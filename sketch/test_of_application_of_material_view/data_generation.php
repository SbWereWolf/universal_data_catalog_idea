<?php

const NUMERIC_PROPERTY = 'NUMERIC_PROPERTY';
const STRING_PROPERTY = 'STRING_PROPERTY';

require 'common.php';

/**
 * @param PDO $connection
 * @param string $tableName
 * @return array
 */
function getWords(\PDO $connection, string $tableName): array
{

    $dataSet = $connection
        ->query("SELECT DISTINCT word AS word FROM $tableName", PDO::FETCH_NUM)
        ->fetchAll();

    $words = pickUpNestedArray($dataSet);

    return $words;
}

/**
 * @param $connection
 * @param $tableName
 * @param $itemCollection
 */
function insertCode(\PDO $connection, string $tableName, array $itemCollection)
{
    $parameterName = ':CODE';

    $request = $connection->prepare("INSERT INTO $tableName (code) VALUES ($parameterName)");
    $value = '';
    $request->bindParam($parameterName, $value, PDO::PARAM_STR);

    foreach ($itemCollection as $item) {
        $value = $item;
        $request->execute();
    }
}

/**
 * @param $connection
 * @param $codes
 */
function linkPropertyToRubric(\PDO $connection, array $codes)
{
    $tableName = 'rubric_property';
    $leftTable = 'rubric';
    $leftColumn = 'rubric_id';
    $leftParameter = ':RUBRIC_CODE';
    $leftValue = '';
    $rightTable = 'property';
    $rightColumn = 'property_id';
    $rightParameter = ':PROPERTY_CODE';
    $rightValue = '';

    $request = $connection->prepare("
INSERT INTO 
$tableName 
($leftColumn,$rightColumn) 
VALUES 
(
(SELECT id FROM $leftTable where code = $leftParameter)
,(SELECT id FROM $rightTable where code = $rightParameter)
)
");

    $request->bindParam($leftParameter, $leftValue, PDO::PARAM_STR);
    $request->bindParam($rightParameter, $rightValue, PDO::PARAM_STR);

    foreach ($codes as $rubric) {

        $leftValue = $rubric;

        foreach ($codes as $property) {

            $choice = random_int(1, 3);
            $let = $choice > 2;
            if ($let) {

                $rightValue = $property;
                $request->execute();
            }

        }
    }
}

/**
 * @param PDO $connection
 * @param string $tableName
 * @return array
 */
function getCodes(\PDO $connection, string $tableName): array
{

    $dataSet = $connection
        ->query("SELECT code AS code FROM $tableName", PDO::FETCH_NUM)
        ->fetchAll();

    $codes = array();
    foreach ($dataSet as $responseRow) {
        $codes[] = $responseRow[BASE_INDEX];

    }

    return $codes;
}

/**
 * @param PDO $connection
 * @param array $rubricCollection
 * @param $adjectives
 */
function addItemToRubric(\PDO $connection, array $rubricCollection, array $adjectives)
{
    $itemTable = 'item';
    $parameter = ':VALUE';
    $itemInsertion = $connection->prepare("
INSERT INTO 
$itemTable 
(code) 
VALUES 
($parameter)
");

    $itemCode = '';
    $itemInsertion->bindParam($parameter, $itemCode, PDO::PARAM_STR);

    $tableName = 'rubric_item';
    $leftTable = 'rubric';
    $leftColumn = 'rubric_id';
    $leftParameter = ':RUBRIC_CODE';
    $rightTable = 'item';
    $rightColumn = 'item_id';
    $rightParameter = ':ITEM_CODE';

    $linkItemToRubric = $connection->prepare("
INSERT INTO 
$tableName 
($leftColumn,$rightColumn) 
VALUES 
(
(SELECT id FROM $leftTable where code = $leftParameter)
,(SELECT id FROM $rightTable where code = $rightParameter)
)
");

    $rubricCode = '';
    $linkItemToRubric->bindParam($leftParameter, $rubricCode, PDO::PARAM_STR);
    $linkItemToRubric->bindParam($rightParameter, $itemCode, PDO::PARAM_STR);

    foreach ($rubricCollection as $rubric) {

        $rubricCode = $rubric;

        foreach ($adjectives as $adjective) {

            $choice = random_int(1, 3);
            $let = $choice > 2;
            if ($let) {

                $itemCode = $rubric . '_' . $adjective;
                $itemInsertion->execute();

                $linkItemToRubric->execute();
            }

        }
    }
}

// $connection = new \PDO('pgsql:host=localhost;port=5432;dbname=universal_catalog;user=postgres;password=admin');

$connection = require 'get_pdo.php';

$nounTableName = 'noun';
$nouns = getWords($connection, $nounTableName);

$rubricTableName = 'rubric';
insertCode($connection, $rubricTableName, $nouns);

$propertyTableName = 'property';
insertCode($connection, $propertyTableName, $nouns);

linkPropertyToRubric($connection, $nouns);

$adjectiveTableName = 'adjective';
$adjectives = getWords($connection, $adjectiveTableName);

addItemToRubric($connection, $nouns, $adjectives);

$connection->exec('
INSERT INTO content (property_id)
SELECT
  rp.property_id property_id
FROM
  rubric_property rp
  JOIN rubric_item ri
    ON ri.rubric_id = rp.rubric_id
');

$connection->exec('
INSERT INTO item_content (item_id, content_id)
  SELECT
    rubric_items.item_id,
    property_contents.content_id
  FROM
    (
      SELECT
        ri.item_id     item_id,
        rp.property_id property_id,
        row_number()
        OVER (
          ORDER BY rp.property_id
          ) AS         i
      FROM
        rubric_property rp
        JOIN rubric_item ri
          ON ri.rubric_id = rp.rubric_id
      ORDER BY
        rp.property_id
    ) rubric_items
    JOIN (
           SELECT
             c.id          content_id,
             c.property_id property_id,
             row_number()
             OVER (
               ORDER BY c.property_id
               ) AS        i
           FROM content c
           ORDER BY
             c.property_id
         ) property_contents
      ON property_contents.property_id = rubric_items.property_id
         AND rubric_items.i = property_contents.i;
');

$numericCode = NUMERIC_PROPERTY;

$connection->exec("
INSERT INTO tag (code, title, description)
VALUES
  ('$numericCode', 'Числовое', 'Числовое свойство')
");

$propertyNumber = count($nouns);
$numericPie = random_int(1, $propertyNumber);

$connection->exec("
INSERT INTO property_tag (property_id, tag_id)
SELECT p.id property_id,(SELECT t.id tag_id  FROM tag t WHERE t.code='$numericCode') tag_id FROM property p LIMIT $numericPie
");

$connection->exec("
INSERT INTO digital_matter (content_id, digital)
SELECT
  c.id,
  random()*10000
FROM
  tag t
  JOIN property_tag pt
    ON t.id = pt.tag_id
  JOIN content c
    ON c.property_id = pt.property_id
WHERE
  t.code = '$numericCode'
");

$stringCode = STRING_PROPERTY;

$connection->exec("
INSERT INTO tag (code, title, description)
VALUES  
  ('$stringCode', 'Строковое', 'Строковое свойство')
");

$connection->exec("
INSERT INTO property_tag (property_id, tag_id)
  SELECT
    p.id                           property_id,
    (SELECT t.id tag_id
     FROM tag t
     WHERE t.code = '$stringCode') tag_id
  FROM
    property p
  WHERE
    NOT EXISTS(
        SELECT NULL
        FROM
          property_tag pt
        WHERE
          pt.property_id = p.id
    )
");

$connection->exec("
INSERT INTO string_matter (content_id, string)
SELECT
  c.id id,
  (SELECT word FROM adjective WHERE c.id IS NOT NULL OFFSET round(random()*(SELECT COUNT(*)-1 FROM adjective)) LIMIT 1) word
FROM
  tag t
  JOIN property_tag pt
    ON t.id = pt.tag_id
  JOIN content c
    ON c.property_id = pt.property_id
WHERE
  t.code = '$stringCode'
");
