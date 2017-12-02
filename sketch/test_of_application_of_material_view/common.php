<?php
/**
 * universal_data_catalog_idea
 * © Volkhin Nikolay M., 2017
 * Date: 02.12.2017 Time: 22:48
 */

const BASE_INDEX = 0;

/**
 * @param $grossArray
 * @return array
 */
function pickUpNestedArray(array $grossArray): array
{
    $reducedArray = array();
    foreach ($grossArray as $nestedArray) {
        $reducedArray[] = $nestedArray[BASE_INDEX];

    }
    return $reducedArray;
}
