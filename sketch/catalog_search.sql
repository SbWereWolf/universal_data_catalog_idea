-- Поиск "везде" ( в рубриках и в позициях каталога )
SELECT
  'RUBRIC',
  rr.code,
  rr.title,
  rr.description
FROM rubric rr
WHERE
  (rr.title ILIKE '%' || :SEARCH_PATTERN || '%'
   OR rr.description ILIKE '%' || :SEARCH_PATTERN || '%')
  AND EXISTS
  (
      SELECT NULL
      FROM
        (
          WITH RECURSIVE road_map ( id, element_tree_id, code, horizont ) AS
          (
            SELECT
              cet.id              AS id,
              cet.element_tree_id AS element_tree_id,
              r.code              AS code,
              0                   AS horizont
            FROM
              element_tree cet
              LEFT JOIN rubric_element_tree ret
                ON cet.id = ret.element_tree_id
              LEFT JOIN rubric r
                ON ret.rubric_id = r.id
            WHERE r.code = rr.code
            UNION
            SELECT
              pet.id,
              pet.element_tree_id,
              r.code,
              horizont + 1
            FROM
              element_tree pet
              JOIN road_map c
                ON (c.element_tree_id = pet.id)
              LEFT JOIN rubric_element_tree ret
                ON pet.id = ret.element_tree_id
              LEFT JOIN rubric r
                ON ret.rubric_id = r.id
          )
          SELECT NULL
          FROM
            road_map rm
          WHERE
            rm.code = :CATALOG_ROOT
          ORDER BY
            horizont DESC
          LIMIT 1
        ) R
  )
UNION
SELECT
  'ITEM',
  i.code,
  i.title,
  i.description
FROM
  rubric rr
  JOIN rubric_item ri
    ON rr.id = ri.rubric_id
  JOIN item i
    ON ri.item_id = i.id
WHERE
  (i.title ILIKE '%' || :SEARCH_PATTERN || '%'
   OR i.description ILIKE '%' || :SEARCH_PATTERN || '%')
  AND EXISTS
  (
      SELECT NULL
      FROM
        (
          WITH RECURSIVE road_map ( id, element_tree_id, code, horizont ) AS
          (
            SELECT
              cet.id              AS id,
              cet.element_tree_id AS element_tree_id,
              r.code              AS code,
              0                   AS horizont
            FROM
              element_tree cet
              LEFT JOIN rubric_element_tree ret
                ON cet.id = ret.element_tree_id
              LEFT JOIN rubric r
                ON ret.rubric_id = r.id
            WHERE r.code = rr.code
            UNION
            SELECT
              pet.id,
              pet.element_tree_id,
              r.code,
              horizont + 1
            FROM
              element_tree pet
              JOIN road_map c
                ON (c.element_tree_id = pet.id)
              LEFT JOIN rubric_element_tree ret
                ON pet.id = ret.element_tree_id
              LEFT JOIN rubric r
                ON ret.rubric_id = r.id
          )
          SELECT NULL
          FROM
            road_map rm
          WHERE
            rm.code = :CATALOG_ROOT
          ORDER BY
            horizont DESC
          LIMIT 1
        ) R
  );

-- числовые системные свойства с типом поиска по диапазону
SELECT
  p.code
FROM
  rubric r
  JOIN rubric_property rp
    ON rp.rubric_id = r.id
  JOIN property p
    ON rp.property_id = p.id
WHERE
  r.code = 'ekskavatory-karernye'
  AND EXISTS(
      SELECT NULL
      FROM
        property_tag pt
        JOIN tag t
          ON pt.tag_id = t.id
      WHERE
        pt.property_id = p.id AND t.code = 'DIGITAL_DATA_TYPE'
  )
  AND EXISTS(
      SELECT NULL
      FROM
        property_tag pt
        JOIN tag t
          ON pt.tag_id = t.id
      WHERE
        pt.property_id = p.id AND t.code = 'BETWEEN_SEARCH_TYPE'
  )
  AND EXISTS(
      SELECT NULL
      FROM
        property_tag pt
        JOIN tag t
          ON pt.tag_id = t.id
      WHERE
        pt.property_id = p.id AND t.code = 'SYSTEM_PROPERTY'
  )
;

-- формирование параметров поиска
SELECT
  max(dm.digital) AS maximum,
  min(dm.digital) AS minimum
FROM
  rubric r
  JOIN rubric_item ri
    ON r.id = ri.rubric_id
  JOIN item i
    ON ri.item_id = i.id
  JOIN item_content ic
    ON i.id = ic.item_id
  JOIN content c
    ON ic.content_id = c.id
  JOIN property p
    ON c.property_id = p.id
  JOIN digital_matter dm
    ON c.id = dm.content_id
WHERE
  p.code = 'BUCKET_CAPACITY_M3'
  AND r.code = 'ekskavatory-karernye';
/*
25,0.75
*/

-- строковые системные свойства с поиском по перечислению
SELECT
  p.code
FROM
  rubric r
  JOIN rubric_property rp
    ON rp.rubric_id = r.id
  JOIN property p
    ON rp.property_id = p.id
WHERE
  r.code = 'ekskavatory-karernye'
  AND EXISTS(
      SELECT NULL
      FROM
        property_tag pt
        JOIN tag t
          ON pt.tag_id = t.id
      WHERE
        pt.property_id = p.id AND t.code = 'STRING_DATA_TYPE'
  )
  AND EXISTS(
      SELECT NULL
      FROM
        property_tag pt
        JOIN tag t
          ON pt.tag_id = t.id
      WHERE
        pt.property_id = p.id AND t.code = 'ENUMERATION_SEARCH_TYPE'
  )
  AND EXISTS(
      SELECT NULL
      FROM
        property_tag pt
        JOIN tag t
          ON pt.tag_id = t.id
      WHERE
        pt.property_id = p.id AND t.code = 'SYSTEM_PROPERTY'
  )
;

-- формирование параметров поиска
SELECT
  sm.string
FROM
  rubric r
  JOIN rubric_item ri
    ON r.id = ri.rubric_id
  JOIN item i
    ON ri.item_id = i.id
  JOIN item_content ic
    ON i.id = ic.item_id
  JOIN content c
    ON ic.content_id = c.id
  JOIN property p
    ON c.property_id = p.id
  JOIN string_matter sm
    ON c.id = sm.content_id
WHERE
  p.code = 'TRADE_MARK'
  AND r.code = 'ekskavatory-karernye'
GROUP BY sm.string;
/*
Уралмаш
Донэкс
*/

SELECT
  p.code
FROM
  rubric r
  JOIN rubric_property rp
    ON rp.rubric_id = r.id
  JOIN property p
    ON rp.property_id = p.id
WHERE
  r.code = 'ekskavatory-karernye'
  AND EXISTS(
      SELECT NULL
      FROM
        property_tag pt
        JOIN tag t
          ON pt.tag_id = t.id
      WHERE
        pt.property_id = p.id AND t.code = 'STRING_DATA_TYPE'
  )
  AND EXISTS(
      SELECT NULL
      FROM
        property_tag pt
        JOIN tag t
          ON pt.tag_id = t.id
      WHERE
        pt.property_id = p.id AND t.code = 'LIKE_SEARCH_TYPE'
  )
  AND EXISTS(
      SELECT NULL
      FROM
        property_tag pt
        JOIN tag t
          ON pt.tag_id = t.id
      WHERE
        pt.property_id = p.id AND t.code = 'SYSTEM_PROPERTY'
  )
;
/* MANUFACTURER_MODEL */

-- поиск по рубрике
/*
'ekskavatory-karernye'
'MANUFACTURER_MODEL'
'12'
'TRADE_MARK'
'Уралмаш'
'Донэкс'
'BUCKET_CAPACITY_M3'
0.75
25
 */
SELECT
  i.code
FROM
  rubric_item ri
  join rubric r
  on ri.rubric_id = r.id
  JOIN item i
    ON ri.item_id = i.id
  JOIN item_content ic
    ON i.id = ic.item_id
  JOIN content c
    ON ic.content_id = c.id
  JOIN string_matter sm
    ON c.id = sm.content_id
  JOIN rubric_property rp
    ON ri.rubric_id = rp.rubric_id
  JOIN property p
    ON c.property_id = p.id
       AND p.id = rp.property_id
WHERE
  r.code = :CODE
  AND p.code = :MODEL_PROPERTY
  AND sm.string LIKE '%'||:MODEL_LIKE||'%'
INTERSECT
SELECT
  i.code
FROM
  rubric_item ri
  join rubric r
  on ri.rubric_id = r.id
  JOIN item i
    ON ri.item_id = i.id
  JOIN item_content ic
    ON i.id = ic.item_id
  JOIN content c
    ON ic.content_id = c.id
  JOIN string_matter sm
    ON c.id = sm.content_id
  JOIN rubric_property rp
    ON ri.rubric_id = rp.rubric_id
  JOIN property p
    ON c.property_id = p.id
       AND p.id = rp.property_id
WHERE
    r.code = :CODE
  AND p.code = :MARK_PROPERTY
  AND sm.string IN ( :MARK1 , :MARK2)
INTERSECT
SELECT
  i.code
FROM
  rubric_item ri
  join rubric r
  on ri.rubric_id = r.id
  JOIN item i
    ON ri.item_id = i.id
  JOIN item_content ic
    ON i.id = ic.item_id
  JOIN content c
    ON ic.content_id = c.id
  JOIN digital_matter dm
    ON c.id = dm.content_id
  JOIN rubric_property rp
    ON ri.rubric_id = rp.rubric_id
  JOIN property p
    ON c.property_id = p.id
       AND p.id = rp.property_id
WHERE
    r.code = :CODE
  AND p.code = :BUCKET_PROPERTY
  AND dm.digital BETWEEN :MIN_BUCKET AND :MAX_BUCKET
;
