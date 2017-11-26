<?php

const BASE_INDEX = 0;

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

    $words = array();
    foreach ($dataSet as $responseRow) {
        $words[] = $responseRow[BASE_INDEX];

    }

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

$connection = new \PDO('pgsql:host=localhost;port=5432;dbname=universal_catalog;user=postgres;password=admin');

$nounTableName = 'noun';
$nouns = getWords($connection, $nounTableName);

$rubricTableName = 'rubric';
//insertCode($connection, $rubricTableName, $nouns);

$propertyTableName = 'property';
//insertCode($connection, $propertyTableName, $nouns);

linkPropertyToRubric($connection, $nouns);

$adjectiveTableName = 'adjective';
$adjectives = getWords($connection, $adjectiveTableName);

//addItemToRubric($connection, $nouns, $adjectives);

$connection->exec('
INSERT INTO content (property_id)
SELECT
  rp.property_id property_id
FROM
  rubric_property rp
  JOIN rubric_item ri
    ON ri.rubric_id = rp.rubric_id
');

null;