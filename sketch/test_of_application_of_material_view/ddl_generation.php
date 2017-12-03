<?php
/**
 * universal_data_catalog_idea
 * © Volkhin Nikolay M., 2017
 * Date: 02.12.2017 Time: 21:36
 */

require 'array_handler.php';
require 'property.php';

const REQUIRES_VALUE = ':';

const RUBRIC_CODE_OPTION = 'r';
const NUMERIC_PROPERTY_OPTION = 'n';
const STRING_PROPERTY_OPTION = 's';

/**
 * @param array $optionsList
 * @param string $optionKey
 * @param string $defaultValue
 * @return string
 */
function getOptionValue(array $optionsList, string $optionKey, string $defaultValue = ''): string
{
    $isOptionExists = array_key_exists($optionKey, $optionsList);
    $optionValue = $isOptionExists ? $optionsList[$optionKey] : $defaultValue;

    return $optionValue;
}

/**
 * @param $connection
 * @param $rubricCode
 * @param $tagCode
 * @return array
 */
function getPropertiesCodes(\PDO $connection, string $rubricCode, string $tagCode): array
{
    $propertiesResponse = $connection->query("
SELECT
  p.code property
FROM
  rubric r
  JOIN rubric_property rp
    ON r.id = rp.rubric_id
    JOIN property_tag pt 
    ON rp.property_id = pt.property_id
    JOIN tag t 
    ON pt.tag_id = t.id
    JOIN property p 
    ON pt.property_id = p.id
WHERE
  r.code = '$rubricCode'
  AND t.code = '$tagCode'
", PDO::FETCH_NUM)->fetchAll();

    $properties = pickUpNestedArray($propertiesResponse);

    return $properties;
}

$optionsSet = implode(REQUIRES_VALUE, array(RUBRIC_CODE_OPTION, NUMERIC_PROPERTY_OPTION, STRING_PROPERTY_OPTION));
$optionsSet .= REQUIRES_VALUE;
$options = getopt($optionsSet);

$rubricCode = getOptionValue($options, RUBRIC_CODE_OPTION);
$numericTag = getOptionValue($options, NUMERIC_PROPERTY_OPTION, NUMERIC_PROPERTY);
$stringTag = getOptionValue($options, STRING_PROPERTY_OPTION, STRING_PROPERTY);

$connection = require 'get_pdo.php';
/* @var  $connection \PDO */

$numericProperties = getPropertiesCodes($connection, $rubricCode, $numericTag);

$selectNumericColumn = array();
foreach ($numericProperties as $numericProperty) {

    $selectNumericColumn[] = "
(
  SELECT dm.digital
  FROM
    item_content ic
    JOIN content c
      ON ic.content_id = c.id
    JOIN property p
      ON c.property_id = p.id
    JOIN digital_matter dm
      ON dm.content_id = c.id
  WHERE
    ic.item_id = ri.item_id
    AND p.code = '$numericProperty'
) \"$numericProperty\"
    ";

}

$stringProperties = getPropertiesCodes($connection, $rubricCode, $stringTag);

$selectStringColumn = array();
foreach ($stringProperties as $stringProperty) {

    $selectStringColumn[] = "
(
  SELECT sm.string
  FROM
    item_content ic
    JOIN content c
      ON ic.content_id = c.id
    JOIN property p
      ON c.property_id = p.id
    JOIN string_matter sm
      ON sm.content_id = c.id
  WHERE
    ic.item_id = ri.item_id
    AND p.code = '$stringProperty'
) \"$stringProperty\"
    ";

}

$selectColumns = array_merge($selectStringColumn, $selectNumericColumn);
$selectPhase = implode(",", $selectColumns);

$contentRequest = "
SELECT
    ri.item_id item_id,
    $selectPhase
  FROM
    rubric_item ri
  WHERE
    ri.rubric_id = (SELECT id FROM rubric WHERE code = '$rubricCode')    
";

echo "\n -- SELECT STATEMENT :\n$contentRequest;";

$viewName = $rubricCode . '_v';

$createView = "
CREATE VIEW $viewName AS
SELECT
    ri.item_id item_id,
    $selectPhase
  FROM
    rubric_item ri
  WHERE
    ri.rubric_id = ( SELECT id FROM rubric WHERE code = '$rubricCode' )    
";

echo "\n -- CREATE VIEW :\n$createView;";

$materialViewName = $rubricCode . '_mv';

$createMaterialView = "
CREATE MATERIALIZED VIEW $materialViewName AS
SELECT
    ri.item_id item_id,
    $selectPhase
  FROM
    rubric_item ri
  WHERE
    ri.rubric_id = ( SELECT id FROM rubric WHERE code = '$rubricCode' )    
";

echo "\n -- CREATE MATERIALIZED VIEW :\n$createMaterialView;";

$relationColumns = array_merge($stringProperties, $numericProperties);

$createColumnIndex = array();
foreach ($relationColumns as $column) {

    $columnIndexName = $materialViewName . '_' . $column;
    $createColumnIndex[] = "
CREATE INDEX $columnIndexName ON $materialViewName (\"$column\")";


}
$createIndex = implode(';', $createColumnIndex);

echo "\n -- CREATE INDEX FOR MATERIALIZED VIEW :\n$createIndex;";

$numericColumns = array();
foreach ($numericProperties as $numericProperty) {

    $numericColumns[] = "
\"$numericProperty\" DOUBLE PRECISION";

}

$stringColumns = array();
foreach ($stringProperties as $stringProperty) {

    $stringColumns[] = "
\"$stringProperty\" TEXT";

}

$tableColumns = array_merge($stringColumns, $numericColumns);
$columnsPhase = implode(",", $tableColumns);

$tableName = $rubricCode . '_t';
$tablePrimaryKey = $rubricCode . '_pkey';

$createTable = "
CREATE TABLE $tableName
(
  id serial not null constraint $tablePrimaryKey primary key,
  is_hidden integer default 0,
  insert_date timestamp with time zone default now(),
  item_id integer REFERENCES item (id),
  $columnsPhase
)
";

echo "\n -- CREATE TABLE :\n$createTable;";

$createTableIndex = array();
foreach ($relationColumns as $column) {

    $tableIndexName = $tableName . '_' . $column;
    $createTableIndex[] = "
CREATE INDEX $tableIndexName ON $tableName (\"$column\")";
}
$setUpTableIndex = implode(';', $createTableIndex);

echo "\n -- CREATE INDEX FOR TABLE :\n$setUpTableIndex;";

$columns = implode(',', $relationColumns);

$fillTable = "
INSERT INTO $tableName
(item_id,$columns)
$contentRequest
";

echo "\n -- FILL TABLE WITH DATA :\n$fillTable;";
