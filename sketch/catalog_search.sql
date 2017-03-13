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

-- Для поиска по рубрике необходимо сформировать параметры поиска - диапазоны допустимых значений для системных свойств
SELECT
  btrim(p.code) AS "property",
  btrim(tu.code) AS "author_type",
  btrim(ts.code) AS "search_type",
  btrim(tt.code) AS "data_type"
FROM
  rubric r
  JOIN rubric_property rp
    ON rp.rubric_id = r.id
  JOIN property p
    ON rp.property_id = p.id
  JOIN property_tag ptu
    on p.id = ptu.property_id
  JOIN tag tu
    on ptu.tag_id = tu.id

  JOIN property_tag pts
    on p.id = pts.property_id
  JOIN tag ts
    on pts.tag_id = ts.id

  JOIN property_tag ptt
    on p.id = ptt.property_id
  JOIN tag tt
    on ptt.tag_id = tt.id
WHERE
  r.code = 'ekskavatory-karernye'
  AND tu.code = 'SYSTEM_PROPERTY'
  AND ts.code IN ('LIKE_SEARCH_TYPE','BETWEEN_SEARCH_TYPE','ENUMERATION_SEARCH_TYPE')
  AND tt.code IN ('DIGITAL_DATA_TYPE','STRING_DATA_TYPE')
;
/*
MANUFACTURER_MODEL,SYSTEM_PROPERTY,LIKE_SEARCH_TYPE,STRING_DATA_TYPE
TRADE_MARK,SYSTEM_PROPERTY,ENUMERATION_SEARCH_TYPE,STRING_DATA_TYPE
BUCKET_CAPACITY_M3,SYSTEM_PROPERTY,BETWEEN_SEARCH_TYPE,DIGITAL_DATA_TYPE
*/

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


SELECT
  btrim(p.code) AS "property",
  btrim(tu.code) AS "author_type",
  btrim(ts.code) AS "search_type",
  btrim(tt.code) AS "data_type"
FROM
  rubric r
  JOIN rubric_property rp
    ON rp.rubric_id = r.id
  JOIN property p
    ON rp.property_id = p.id
  JOIN property_tag ptu
    on p.id = ptu.property_id
  JOIN tag tu
    on ptu.tag_id = tu.id

  JOIN property_tag pts
    on p.id = pts.property_id
  JOIN tag ts
    on pts.tag_id = ts.id

  JOIN property_tag ptt
    on p.id = ptt.property_id
  JOIN tag tt
    on ptt.tag_id = tt.id
WHERE
  r.code = 'ekskavatory-pogruzchiki'
  AND tu.code = 'USER_PROPERTY'
  AND ts.code IN ('LIKE_SEARCH_TYPE','BETWEEN_SEARCH_TYPE','ENUMERATION_SEARCH_TYPE')
  AND tt.code IN ('DIGITAL_DATA_TYPE','STRING_DATA_TYPE')
;
/*
GOODS_ITEM_PRICE_RUB,USER_PROPERTY,BETWEEN_SEARCH_TYPE,DIGITAL_DATA_TYPE
GOODS_ITEM_UNITS_OF_MEASURE,USER_PROPERTY,ENUMERATION_SEARCH_TYPE,STRING_DATA_TYPE
*/

-- формирование параметров поиска по Сущности 'jcb-4cx'
SELECT
  min(dm.digital) AS minimum,
  max(dm.digital) AS maximum
FROM

  item i
  JOIN item_content ic
    ON i.id = ic.item_id
  JOIN content c
    ON ic.content_id = c.id
  JOIN property p
    ON c.property_id = p.id
  JOIN digital_matter dm
    ON c.id = dm.content_id
WHERE
  p.code = 'GOODS_ITEM_PRICE_RUB'
  AND i.code = 'jcb-4cx';
/*
3400000
4700000
*/

SELECT
  sm.string
FROM
  item i
  JOIN item_content ic
    ON i.id = ic.item_id
  JOIN content c
    ON ic.content_id = c.id
  JOIN property p
    ON c.property_id = p.id
  JOIN string_matter sm
    ON c.id = sm.content_id
WHERE
  p.code = 'GOODS_ITEM_UNITS_OF_MEASURE'
  AND i.code = 'jcb-4cx'
GROUP BY sm.string;
/*
р/шт
шт
шт.
*/


/*
:ITEM_CODE => 'jcb-4cx'
:PRICE_PROPERTY => 'GOODS_ITEM_PRICE_RUB'
:MIN_PRICE => 3400000
:MAX_PRICE => 4000000
*/
SELECT
  r.id,
  r.title,
  r.description,
  c.raw
FROM
  item i
  JOIN item_content ic
    ON i.id = ic.item_id
  JOIN content c
    ON ic.content_id = c.id
  JOIN redactor_content rc
    ON c.id = rc.content_id
  JOIN redactor r
    ON rc.redactor_id = r.id
  JOIN digital_matter dm
    ON c.id = dm.content_id
  JOIN rubric_item ri
    ON i.id = ri.item_id
  JOIN rubric_property rp
    ON ri.rubric_id = rp.rubric_id
  JOIN property p
    ON c.property_id = p.id
       AND p.id = rp.property_id
WHERE
  i.code = :ITEM_CODE
  AND p.code = :PRICE_PROPERTY
  AND dm.digital BETWEEN :MIN_PRICE AND :MAX_PRICE
;
/*
Василий Алибабаевич Уримчи,бригадир СМУ-3,3 800 000
Олег,Мы всегда можем договориться о взаимовыгодном сотрудничестве,3 400 000
*/
