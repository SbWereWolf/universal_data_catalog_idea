-- Опции Характерисик
SELECT
  p.code,
  t.code
FROM
  property_tag pt
  JOIN property p
    ON pt.property_id = p.id
  JOIN tag t
    ON pt.tag_id = t.id
ORDER BY
  p.id, t.id;

-- Иерархия Сущностей и статус Сущности в иерархии
SELECT
  r.code,
  CASE
  WHEN
    NOT EXISTS(SELECT NULL
               FROM structure_tree t
               WHERE t.structure_tree_id = e.id)
    AND EXISTS(SELECT NULL
               FROM structure_tree t
               WHERE t.id = e.structure_tree_id)
    THEN 'rubric'
  WHEN
    NOT EXISTS(SELECT NULL
               FROM structure_tree t
               WHERE t.structure_tree_id = e.id)
    AND e.structure_tree_id IS NULL
    THEN 'single'
  WHEN
    EXISTS(SELECT NULL
           FROM structure_tree t
           WHERE t.structure_tree_id = e.id)
    AND e.structure_tree_id IS NULL
    THEN 'root'
  WHEN
    EXISTS(SELECT NULL
           FROM structure_tree t
           WHERE t.structure_tree_id = e.id)
    AND EXISTS(SELECT NULL
               FROM structure_tree t
               WHERE t.id = e.structure_tree_id)
    THEN 'section'
  ELSE
    'unknown'
  END
FROM
  rubric_structure_tree re
  JOIN structure_tree e
    ON re.structure_tree_id = e.id
  JOIN rubric r
    ON re.rubric_id = r.id;

-- Сущности
SELECT
  r.code,
  i.title,
  i.code
FROM
  rubric_item ri
  JOIN rubric r
    ON ri.rubric_id = r.id
  JOIN item i
    ON ri.item_id = i.id;

-- Характеристики Сущностей
SELECT
  r.code,
  p.code,
  p.title
FROM
  rubric_property rp
  JOIN rubric r
    ON rp.rubric_id = r.id
  JOIN property p
    ON rp.property_id = p.id;

-- Значения Характеристик Сущностей ( собственно данные каталога )
SELECT
  i.code,
  p.code,
  c.raw
FROM
  item_content ic
  JOIN item i
    ON ic.item_id = i.id
  JOIN content c
    ON ic.content_id = c.id
  JOIN property p
    ON c.property_id = p.id
ORDER BY i.code, c.raw;

-- Пользовательские значения
SELECT
  r.code,
  r.title,
  c.raw
FROM
  redactor_content rc
  JOIN redactor r
    ON rc.redactor_id = r.id
  JOIN content c
    ON rc.content_id = c.id;

-- Значения
SELECT
  c.raw,
  CASE
  WHEN
    sm.string IS NOT NULL
    THEN
      sm.string :: TEXT
  WHEN
    dim.digital IS NOT NULL
    THEN
      dim.digital :: TEXT
  WHEN
    dam.date_time IS NOT NULL
    THEN
      dam.date_time :: TEXT
  WHEN
    dum.duration IS NOT NULL
    THEN
      dum.duration :: TEXT
  ELSE
    'nothing'
  END AS data
FROM
  content c
  LEFT JOIN date_matter dam
    ON c.id = dam.content_id
  LEFT JOIN digital_matter dim
    ON c.id = dim.content_id
  LEFT JOIN duration_matter dum
    ON c.id = dum.content_id
  LEFT JOIN string_matter sm
    ON c.id = sm.content_id;

-- показать путь от потомка до родительского корневого элемента 'ekskavatory-karernye'
WITH RECURSIVE road_map ( id, structure_tree_id, code, horizont ) AS
(
  SELECT
    cet.id              AS id,
    cet.structure_tree_id AS structure_tree_id,
    r.code              AS code,
    0                   AS horizont
  FROM
    structure_tree cet
    LEFT JOIN rubric_structure_tree ret
      ON cet.id = ret.structure_tree_id
    LEFT JOIN rubric r
      ON ret.rubric_id = r.id
  WHERE r.code = :CHILD
  UNION
  SELECT
    pet.id,
    pet.structure_tree_id,
    r.code,
    horizont + 1
  FROM
    structure_tree pet
    JOIN road_map c
      ON (c.structure_tree_id = pet.id)
    LEFT JOIN rubric_structure_tree ret
      ON pet.id = ret.structure_tree_id
    LEFT JOIN rubric r
      ON ret.rubric_id = r.id
)
SELECT
  code,
  horizont
FROM
  road_map
ORDER BY
  horizont DESC;

-- показать карту иерархии Сущностей с уровнем иерархии, для корневой рубрики 'GOODS'
WITH RECURSIVE road_map ( id, structure_tree_id, code, horizont ) AS
(
  SELECT
    pet.id              AS id,
    pet.structure_tree_id AS structure_tree_id,
    r.code              AS code,
    0                   AS horizont
  FROM
    structure_tree pet
    LEFT JOIN rubric_structure_tree ret
      ON pet.id = ret.structure_tree_id
    LEFT JOIN rubric r
      ON ret.rubric_id = r.id
  WHERE r.code = :ROOT
  UNION
  SELECT
    cet.id,
    cet.structure_tree_id,
    r.code,
    horizont + 1
  FROM
    structure_tree cet
    JOIN road_map c
      ON (c.id = cet.structure_tree_id)
    LEFT JOIN rubric_structure_tree ret
      ON cet.id = ret.structure_tree_id
    LEFT JOIN rubric r
      ON ret.rubric_id = r.id
)
SELECT
  code,
  horizont
FROM
  road_map
ORDER BY
  horizont ASC;

-- Значения Характеристик одной Сущности 'doneks-eo-4112a-1'
SELECT
  i.title,
  p.title,
  dm.digital::TEXT
FROM
  rubric_item ri
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
  i.code = :CODE
UNION
SELECT
  i.title,
  p.title,
  sm.string::TEXT
FROM
  rubric_item ri
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
  i.code = :CODE;
