<?php

/**
 * @param $filename
 * @param $connection
 * @param $tableName
 * @param $columnName
 */
function insertFromFile(string $filename, \PDO $connection, string $tableName, string $columnName)
{
    $fileContent = file($filename, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);

    $request = $connection->prepare("INSERT INTO $tableName ($columnName) VALUES (:FILE_STRING)");
    $value = '';
    $request->bindParam(':FILE_STRING', $value, PDO::PARAM_STR);

    foreach ($fileContent as $fileString) {
        $value = $fileString;
        $request->execute();
    }
}

$connection = require 'get_pdo.php';

$filename = 'noun.txt';
$columnName = 'word';
$tableName = 'noun';
insertFromFile($filename, $connection, $tableName, $columnName);

$filename = 'adjective.txt';
$columnName = 'word';
$tableName = 'adjective';
insertFromFile($filename, $connection, $tableName, $columnName);

null;
