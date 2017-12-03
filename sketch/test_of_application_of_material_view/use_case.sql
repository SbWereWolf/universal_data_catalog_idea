/* INSTALL */
/*
execute deploy/commit_ddl.sql
execute commit_ddl.sql
*/

/* BEGIN OF SETUP */

TRUNCATE TABLE digital_matter;
TRUNCATE TABLE string_matter;
TRUNCATE TABLE item_content;
DELETE FROM content;
TRUNCATE TABLE rubric_item;
DELETE FROM item;
TRUNCATE TABLE rubric_property;
TRUNCATE TABLE property_tag;
DELETE FROM tag;
DELETE FROM property;
DELETE FROM rubric;

/*
php words_input.php
php data_generation.php
*/

SELECT
  r.code,
  (SELECT COUNT(*)
   FROM rubric_property rp
   WHERE rp.rubric_id = r.id) property_count,
  (SELECT COUNT(*)
   FROM rubric_item ri
   WHERE ri.rubric_id = r.id) item_count,
  (SELECT COUNT(*)
   FROM rubric_property rp
   WHERE rp.rubric_id = r.id) + (
    SELECT COUNT(*)
    FROM rubric_item ri
    WHERE ri.rubric_id = r.id) summary
FROM
  rubric r
GROUP BY
  r.code,
  r.id
ORDER BY
  summary DESC,
  property_count DESC,
  item_count DESC;
/*
tea,22,41,63
*/

/*
php ddl_generation.php -r tea
*/

 -- SELECT STATEMENT :

SELECT
    ri.item_id item_id,

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
    AND p.code = 'snake'
) "snake"
    ,
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
    AND p.code = 'tiger'
) "tiger"
    ,
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
    AND p.code = 'beans'
) "beans"
    ,
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
    AND p.code = 'sweater'
) "sweater"
    ,
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
    AND p.code = 'pudding'
) "pudding"
    ,
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
    AND p.code = 'bumper'
) "bumper"
    ,
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
    AND p.code = 'train'
) "train"
    ,
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
    AND p.code = 'alligator'
) "alligator"
    ,
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
    AND p.code = 'trousers'
) "trousers"
    ,
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
    AND p.code = 'bowl'
) "bowl"
    ,
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
    AND p.code = 'cabbage'
) "cabbage"
    ,
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
    AND p.code = 'ship'
) "ship"
    ,
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
    AND p.code = 'undershirt'
) "undershirt"
    ,
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
    AND p.code = 'simmer'
) "simmer"
    ,
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
    AND p.code = 'squirrel'
) "squirrel"
    ,
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
    AND p.code = 'ceiling'
) "ceiling"
    ,
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
    AND p.code = 'legs'
) "legs"
    ,
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
    AND p.code = 'jacket'
) "jacket"
    ,
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
    AND p.code = 'book'
) "book"
    ,
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
    AND p.code = 'stomach'
) "stomach"
    ,
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
    AND p.code = 'clock'
) "clock"
    ,
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
    AND p.code = 'furniture'
) "furniture"

  FROM
    rubric_item ri
  WHERE
    ri.rubric_id = (SELECT id FROM rubric WHERE code = 'tea')
;
 -- CREATE VIEW :

CREATE VIEW tea_v AS
SELECT
    ri.item_id item_id,

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
    AND p.code = 'snake'
) "snake"
    ,
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
    AND p.code = 'tiger'
) "tiger"
    ,
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
    AND p.code = 'beans'
) "beans"
    ,
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
    AND p.code = 'sweater'
) "sweater"
    ,
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
    AND p.code = 'pudding'
) "pudding"
    ,
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
    AND p.code = 'bumper'
) "bumper"
    ,
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
    AND p.code = 'train'
) "train"
    ,
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
    AND p.code = 'alligator'
) "alligator"
    ,
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
    AND p.code = 'trousers'
) "trousers"
    ,
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
    AND p.code = 'bowl'
) "bowl"
    ,
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
    AND p.code = 'cabbage'
) "cabbage"
    ,
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
    AND p.code = 'ship'
) "ship"
    ,
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
    AND p.code = 'undershirt'
) "undershirt"
    ,
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
    AND p.code = 'simmer'
) "simmer"
    ,
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
    AND p.code = 'squirrel'
) "squirrel"
    ,
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
    AND p.code = 'ceiling'
) "ceiling"
    ,
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
    AND p.code = 'legs'
) "legs"
    ,
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
    AND p.code = 'jacket'
) "jacket"
    ,
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
    AND p.code = 'book'
) "book"
    ,
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
    AND p.code = 'stomach'
) "stomach"
    ,
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
    AND p.code = 'clock'
) "clock"
    ,
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
    AND p.code = 'furniture'
) "furniture"

  FROM
    rubric_item ri
  WHERE
    ri.rubric_id = ( SELECT id FROM rubric WHERE code = 'tea' )
;
/*[2017-12-03 14:26:19] completed in 177ms*/

 -- CREATE MATERIALIZED VIEW :

CREATE MATERIALIZED VIEW tea_mv AS
SELECT
    ri.item_id item_id,

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
    AND p.code = 'snake'
) "snake"
    ,
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
    AND p.code = 'tiger'
) "tiger"
    ,
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
    AND p.code = 'beans'
) "beans"
    ,
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
    AND p.code = 'sweater'
) "sweater"
    ,
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
    AND p.code = 'pudding'
) "pudding"
    ,
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
    AND p.code = 'bumper'
) "bumper"
    ,
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
    AND p.code = 'train'
) "train"
    ,
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
    AND p.code = 'alligator'
) "alligator"
    ,
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
    AND p.code = 'trousers'
) "trousers"
    ,
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
    AND p.code = 'bowl'
) "bowl"
    ,
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
    AND p.code = 'cabbage'
) "cabbage"
    ,
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
    AND p.code = 'ship'
) "ship"
    ,
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
    AND p.code = 'undershirt'
) "undershirt"
    ,
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
    AND p.code = 'simmer'
) "simmer"
    ,
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
    AND p.code = 'squirrel'
) "squirrel"
    ,
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
    AND p.code = 'ceiling'
) "ceiling"
    ,
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
    AND p.code = 'legs'
) "legs"
    ,
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
    AND p.code = 'jacket'
) "jacket"
    ,
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
    AND p.code = 'book'
) "book"
    ,
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
    AND p.code = 'stomach'
) "stomach"
    ,
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
    AND p.code = 'clock'
) "clock"
    ,
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
    AND p.code = 'furniture'
) "furniture"

  FROM
    rubric_item ri
  WHERE
    ri.rubric_id = ( SELECT id FROM rubric WHERE code = 'tea' )
;
/* [2017-12-03 14:27:34] completed in 163ms */
 -- CREATE INDEX FOR MATERIALIZED VIEW :

CREATE INDEX tea_mv_snake ON tea_mv ("snake");
CREATE INDEX tea_mv_tiger ON tea_mv ("tiger");
CREATE INDEX tea_mv_beans ON tea_mv ("beans");
CREATE INDEX tea_mv_sweater ON tea_mv ("sweater");
CREATE INDEX tea_mv_pudding ON tea_mv ("pudding");
CREATE INDEX tea_mv_bumper ON tea_mv ("bumper");
CREATE INDEX tea_mv_train ON tea_mv ("train");
CREATE INDEX tea_mv_alligator ON tea_mv ("alligator");
CREATE INDEX tea_mv_trousers ON tea_mv ("trousers");
CREATE INDEX tea_mv_bowl ON tea_mv ("bowl");
CREATE INDEX tea_mv_cabbage ON tea_mv ("cabbage");
CREATE INDEX tea_mv_ship ON tea_mv ("ship");
CREATE INDEX tea_mv_undershirt ON tea_mv ("undershirt");
CREATE INDEX tea_mv_simmer ON tea_mv ("simmer");
CREATE INDEX tea_mv_squirrel ON tea_mv ("squirrel");
CREATE INDEX tea_mv_ceiling ON tea_mv ("ceiling");
CREATE INDEX tea_mv_legs ON tea_mv ("legs");
CREATE INDEX tea_mv_jacket ON tea_mv ("jacket");
CREATE INDEX tea_mv_book ON tea_mv ("book");
CREATE INDEX tea_mv_stomach ON tea_mv ("stomach");
CREATE INDEX tea_mv_clock ON tea_mv ("clock");
CREATE INDEX tea_mv_furniture ON tea_mv ("furniture");
 -- CREATE TABLE :

CREATE TABLE tea_t
(
  id serial not null constraint tea_pkey primary key,
  is_hidden integer default 0,
  insert_date timestamp with time zone default now(),
  item_id integer REFERENCES item (id),

"snake" TEXT,
"tiger" TEXT,
"beans" TEXT,
"sweater" TEXT,
"pudding" TEXT,
"bumper" TEXT,
"train" TEXT,
"alligator" TEXT,
"trousers" TEXT,
"bowl" DOUBLE PRECISION,
"cabbage" DOUBLE PRECISION,
"ship" DOUBLE PRECISION,
"undershirt" DOUBLE PRECISION,
"simmer" DOUBLE PRECISION,
"squirrel" DOUBLE PRECISION,
"ceiling" DOUBLE PRECISION,
"legs" DOUBLE PRECISION,
"jacket" DOUBLE PRECISION,
"book" DOUBLE PRECISION,
"stomach" DOUBLE PRECISION,
"clock" DOUBLE PRECISION,
"furniture" DOUBLE PRECISION
)
;
/* [2017-12-03 14:28:24] completed in 82ms */
 -- CREATE INDEX FOR TABLE :

CREATE INDEX tea_t_snake ON tea_t ("snake");
CREATE INDEX tea_t_tiger ON tea_t ("tiger");
CREATE INDEX tea_t_beans ON tea_t ("beans");
CREATE INDEX tea_t_sweater ON tea_t ("sweater");
CREATE INDEX tea_t_pudding ON tea_t ("pudding");
CREATE INDEX tea_t_bumper ON tea_t ("bumper");
CREATE INDEX tea_t_train ON tea_t ("train");
CREATE INDEX tea_t_alligator ON tea_t ("alligator");
CREATE INDEX tea_t_trousers ON tea_t ("trousers");
CREATE INDEX tea_t_bowl ON tea_t ("bowl");
CREATE INDEX tea_t_cabbage ON tea_t ("cabbage");
CREATE INDEX tea_t_ship ON tea_t ("ship");
CREATE INDEX tea_t_undershirt ON tea_t ("undershirt");
CREATE INDEX tea_t_simmer ON tea_t ("simmer");
CREATE INDEX tea_t_squirrel ON tea_t ("squirrel");
CREATE INDEX tea_t_ceiling ON tea_t ("ceiling");
CREATE INDEX tea_t_legs ON tea_t ("legs");
CREATE INDEX tea_t_jacket ON tea_t ("jacket");
CREATE INDEX tea_t_book ON tea_t ("book");
CREATE INDEX tea_t_stomach ON tea_t ("stomach");
CREATE INDEX tea_t_clock ON tea_t ("clock");
CREATE INDEX tea_t_furniture ON tea_t ("furniture");

-- FILL TABLE WITH DATA :

INSERT INTO tea_t
(item_id,snake,tiger,beans,sweater,pudding,bumper,train,alligator,trousers,bowl,cabbage,ship,undershirt,simmer,squirrel,ceiling,legs,jacket,book,stomach,clock,furniture)

SELECT
    ri.item_id item_id,

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
    AND p.code = 'snake'
) "snake"
    ,
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
    AND p.code = 'tiger'
) "tiger"
    ,
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
    AND p.code = 'beans'
) "beans"
    ,
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
    AND p.code = 'sweater'
) "sweater"
    ,
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
    AND p.code = 'pudding'
) "pudding"
    ,
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
    AND p.code = 'bumper'
) "bumper"
    ,
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
    AND p.code = 'train'
) "train"
    ,
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
    AND p.code = 'alligator'
) "alligator"
    ,
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
    AND p.code = 'trousers'
) "trousers"
    ,
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
    AND p.code = 'bowl'
) "bowl"
    ,
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
    AND p.code = 'cabbage'
) "cabbage"
    ,
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
    AND p.code = 'ship'
) "ship"
    ,
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
    AND p.code = 'undershirt'
) "undershirt"
    ,
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
    AND p.code = 'simmer'
) "simmer"
    ,
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
    AND p.code = 'squirrel'
) "squirrel"
    ,
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
    AND p.code = 'ceiling'
) "ceiling"
    ,
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
    AND p.code = 'legs'
) "legs"
    ,
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
    AND p.code = 'jacket'
) "jacket"
    ,
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
    AND p.code = 'book'
) "book"
    ,
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
    AND p.code = 'stomach'
) "stomach"
    ,
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
    AND p.code = 'clock'
) "clock"
    ,
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
    AND p.code = 'furniture'
) "furniture"

  FROM
    rubric_item ri
  WHERE
    ri.rubric_id = (SELECT id FROM rubric WHERE code = 'tea')

;
/*[2017-12-03 14:30:08] 41 rows affected in 105ms*/

/* END OF SETUP */

/* PREPARE FOR MEASURE */

SELECT
  *
FROM
  tea_mv t
WHERE
  t.tiger IN ('poor','white','orange','red')
;
/*[2017-12-03 14:45:28] 14 rows retrieved starting from 1 in 29ms (execution: 11ms, fetching: 18ms)*/

SELECT
  *
FROM
  tea_mv t
WHERE
  t.tiger IN ('poor','white','orange','red')
  AND bowl BETWEEN 1000 AND 4000
;
/*[2017-12-03 14:47:14] 7 rows retrieved starting from 1 in 112ms (execution: 39ms, fetching: 73ms)*/

SELECT
  *
FROM
  tea_mv t
WHERE
  t.tiger IN ('poor','white','orange','red')
  AND bowl BETWEEN 1000 AND 4000
AND clock > 3000
;
/*[2017-12-03 14:49:21] 4 rows retrieved starting from 1 in 16ms (execution: 3ms, fetching: 13ms)*/


SELECT
  *
FROM
  tea_mv t
WHERE
  t.tiger IN ('poor','white','orange','red')
  AND bowl BETWEEN 1000 AND 4000
AND clock > 3000
AND legs < 2000
;
/*[2017-12-03 14:50:20] 2 rows retrieved starting from 1 in 14ms (execution: 4ms, fetching: 10ms)*/

SELECT
  *
FROM
  tea_mv t
WHERE
  t.tiger IN ('poor','white','orange','red')
  AND bowl BETWEEN 1000 AND 4000
AND clock > 3000
AND legs < 2000
AND snake = 'crazy'
;
/*[2017-12-03 14:51:54] 1 row retrieved starting from 1 in 19ms (execution: 8ms, fetching: 11ms)*/

/* MEASURE OF SELECTING */

/* RESULT SINGLE ROW */

/*
[2017-12-03 15:08:00] 1 row retrieved starting from 1 in 43ms (execution: 3ms, fetching: 40ms)

[2017-12-03 15:03:11] 1 row retrieved starting from 1 in 20ms (execution: 4ms, fetching: 16ms)
[2017-12-03 15:10:15] 1 row retrieved starting from 1 in 15ms (execution: 4ms, fetching: 11ms)
[2017-12-03 15:11:15] 1 row retrieved starting from 1 in 14ms (execution: 3ms, fetching: 11ms)

[2017-12-03 15:13:46] 1 row retrieved starting from 1 in 12ms (execution: 3ms, fetching: 9ms)
*/
SELECT
  *
FROM
  tea_mv mv
WHERE
  mv.tiger IN ('poor', 'white', 'orange', 'red')
  AND mv.bowl BETWEEN 1000 AND 4000
AND mv.clock > 3000
AND mv.legs < 2000
AND mv.snake = 'crazy'
;

/*
[2017-12-03 15:10:05] 1 row retrieved starting from 1 in 62ms (execution: 48ms, fetching: 14ms)

[2017-12-03 15:11:03] 1 row retrieved starting from 1 in 53ms (execution: 39ms, fetching: 14ms)
[2017-12-03 15:02:49] 1 row retrieved starting from 1 in 50ms (execution: 40ms, fetching: 10ms)
[2017-12-03 15:07:47] 1 row retrieved starting from 1 in 48ms (execution: 40ms, fetching: 8ms)

[2017-12-03 15:09:25] 1 row retrieved starting from 1 in 49ms (execution: 39ms, fetching: 10ms)
*/
SELECT
  *
FROM
  tea_v v
WHERE
  v.tiger IN ('poor', 'white', 'orange', 'red')
  AND v.bowl BETWEEN 1000 AND 4000
AND v.clock > 3000
AND v.legs < 2000
AND v.snake = 'crazy'
;

/*
[2017-12-03 15:09:56] 1 row retrieved starting from 1 in 43ms (execution: 25ms, fetching: 18ms)

[2017-12-03 15:07:35] 1 row retrieved starting from 1 in 22ms (execution: 5ms, fetching: 17ms)
[2017-12-03 15:02:36] 1 row retrieved starting from 1 in 20ms (execution: 3ms, fetching: 17ms)
[2017-12-03 15:09:14] 1 row retrieved starting from 1 in 20ms (execution: 5ms, fetching: 15ms)

[2017-12-03 15:10:53] 1 row retrieved starting from 1 in 18ms (execution: 4ms, fetching: 14ms)
*/
SELECT
  *
FROM
  tea_t t
WHERE
  t.tiger IN ('poor','white','orange','red')
  AND t.bowl BETWEEN 1000 AND 4000
AND t.clock > 3000
AND t.legs < 2000
AND t.snake = 'crazy'
;

/*
[2017-12-03 15:01:22] 1 row retrieved starting from 1 in 122ms (execution: 91ms, fetching: 31ms)

[2017-12-03 15:08:27] 1 row retrieved starting from 1 in 61ms (execution: 44ms, fetching: 17ms)
[2017-12-03 15:07:11] 1 row retrieved starting from 1 in 49ms (execution: 40ms, fetching: 9ms)
[2017-12-03 15:10:40] 1 row retrieved starting from 1 in 50ms (execution: 40ms, fetching: 10ms)

[2017-12-03 15:09:43] 1 row retrieved starting from 1 in 48ms (execution: 39ms, fetching: 9ms)
*/
SELECT
    ri.item_id item_id,

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
    AND p.code = 'snake'
) "snake"
    ,
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
    AND p.code = 'tiger'
) "tiger"
    ,
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
    AND p.code = 'beans'
) "beans"
    ,
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
    AND p.code = 'sweater'
) "sweater"
    ,
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
    AND p.code = 'pudding'
) "pudding"
    ,
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
    AND p.code = 'bumper'
) "bumper"
    ,
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
    AND p.code = 'train'
) "train"
    ,
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
    AND p.code = 'alligator'
) "alligator"
    ,
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
    AND p.code = 'trousers'
) "trousers"
    ,
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
    AND p.code = 'bowl'
) "bowl"
    ,
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
    AND p.code = 'cabbage'
) "cabbage"
    ,
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
    AND p.code = 'ship'
) "ship"
    ,
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
    AND p.code = 'undershirt'
) "undershirt"
    ,
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
    AND p.code = 'simmer'
) "simmer"
    ,
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
    AND p.code = 'squirrel'
) "squirrel"
    ,
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
    AND p.code = 'ceiling'
) "ceiling"
    ,
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
    AND p.code = 'legs'
) "legs"
    ,
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
    AND p.code = 'jacket'
) "jacket"
    ,
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
    AND p.code = 'book'
) "book"
    ,
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
    AND p.code = 'stomach'
) "stomach"
    ,
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
    AND p.code = 'clock'
) "clock"
    ,
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
    AND p.code = 'furniture'
) "furniture"

  FROM
    rubric_item ri
  WHERE
    ri.rubric_id = (SELECT id FROM rubric WHERE code = 'tea')

  AND (
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
    AND p.code = 'tiger'
) IN ('poor','white','orange','red')
  AND (
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
    AND p.code = 'bowl'
)  BETWEEN 1000 AND 4000
AND (
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
    AND p.code = 'clock'
) > 3000
AND (
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
    AND p.code = 'legs'
) < 2000
AND (
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
    AND p.code = 'snake'
) = 'crazy'
;

/* RESULT MULTI ROW */

/*
[2017-12-03 15:23:36] 7 rows retrieved starting from 1 in 27ms (execution: 15ms, fetching: 12ms)

[2017-12-03 15:24:31] 7 rows retrieved starting from 1 in 19ms (execution: 7ms, fetching: 12ms)
[2017-12-03 15:25:29] 7 rows retrieved starting from 1 in 14ms (execution: 3ms, fetching: 11ms)
[2017-12-03 15:26:22] 7 rows retrieved starting from 1 in 18ms (execution: 2ms, fetching: 16ms)

[2017-12-03 15:27:09] 7 rows retrieved starting from 1 in 14ms (execution: 3ms, fetching: 11ms)
*/
SELECT
  *
FROM
  tea_mv mv
WHERE
  mv.tiger IN ('poor', 'white', 'orange', 'red')
  AND mv.bowl BETWEEN 1000 AND 4000
;

/*
[2017-12-03 15:24:19] 7 rows retrieved starting from 1 in 80ms (execution: 63ms, fetching: 17ms)

[2017-12-03 15:23:22] 7 rows retrieved starting from 1 in 70ms (execution: 63ms, fetching: 7ms)
[2017-12-03 15:25:17] 7 rows retrieved starting from 1 in 56ms (execution: 45ms, fetching: 11ms)
[2017-12-03 15:27:00] 7 rows retrieved starting from 1 in 54ms (execution: 45ms, fetching: 9ms)

[2017-12-03 15:26:12] 7 rows retrieved starting from 1 in 54ms (execution: 46ms, fetching: 8ms)
*/
SELECT
  *
FROM
  tea_v v
WHERE
  v.tiger IN ('poor', 'white', 'orange', 'red')
  AND v.bowl BETWEEN 1000 AND 4000
;

/*
[2017-12-03 15:25:01] 7 rows retrieved starting from 1 in 62ms (execution: 6ms, fetching: 56ms)

[2017-12-03 15:23:07] 7 rows retrieved starting from 1 in 31ms (execution: 7ms, fetching: 24ms)
[2017-12-03 15:24:07] 7 rows retrieved starting from 1 in 19ms (execution: 4ms, fetching: 15ms)
[2017-12-03 15:26:02] 7 rows retrieved starting from 1 in 22ms (execution: 7ms, fetching: 15ms)

[2017-12-03 15:26:51] 7 rows retrieved starting from 1 in 18ms (execution: 6ms, fetching: 12ms)
*/
SELECT
  *
FROM
  tea_t t
WHERE
  t.tiger IN ('poor','white','orange','red')
  AND t.bowl BETWEEN 1000 AND 4000
;

/*
[2017-12-03 15:24:50] 7 rows retrieved starting from 1 in 94ms (execution: 67ms, fetching: 27ms)

[2017-12-03 15:22:54] 7 rows retrieved starting from 1 in 92ms (execution: 74ms, fetching: 18ms)
[2017-12-03 15:23:50] 7 rows retrieved starting from 1 in 63ms (execution: 54ms, fetching: 9ms)
[2017-12-03 15:26:38] 7 rows retrieved starting from 1 in 54ms (execution: 47ms, fetching: 7ms)

[2017-12-03 15:25:48] 7 rows retrieved starting from 1 in 51ms (execution: 44ms, fetching: 7ms)
*/
SELECT
    ri.item_id item_id,

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
    AND p.code = 'snake'
) "snake"
    ,
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
    AND p.code = 'tiger'
) "tiger"
    ,
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
    AND p.code = 'beans'
) "beans"
    ,
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
    AND p.code = 'sweater'
) "sweater"
    ,
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
    AND p.code = 'pudding'
) "pudding"
    ,
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
    AND p.code = 'bumper'
) "bumper"
    ,
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
    AND p.code = 'train'
) "train"
    ,
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
    AND p.code = 'alligator'
) "alligator"
    ,
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
    AND p.code = 'trousers'
) "trousers"
    ,
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
    AND p.code = 'bowl'
) "bowl"
    ,
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
    AND p.code = 'cabbage'
) "cabbage"
    ,
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
    AND p.code = 'ship'
) "ship"
    ,
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
    AND p.code = 'undershirt'
) "undershirt"
    ,
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
    AND p.code = 'simmer'
) "simmer"
    ,
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
    AND p.code = 'squirrel'
) "squirrel"
    ,
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
    AND p.code = 'ceiling'
) "ceiling"
    ,
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
    AND p.code = 'legs'
) "legs"
    ,
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
    AND p.code = 'jacket'
) "jacket"
    ,
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
    AND p.code = 'book'
) "book"
    ,
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
    AND p.code = 'stomach'
) "stomach"
    ,
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
    AND p.code = 'clock'
) "clock"
    ,
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
    AND p.code = 'furniture'
) "furniture"

  FROM
    rubric_item ri
  WHERE
    ri.rubric_id = (SELECT id FROM rubric WHERE code = 'tea')

  AND (
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
    AND p.code = 'tiger'
) IN ('poor','white','orange','red')
  AND (
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
    AND p.code = 'bowl'
)  BETWEEN 1000 AND 4000
;

/* END OF WORK */

DROP VIEW tea_v RESTRICT;
DROP MATERIALIZED VIEW tea_mv;
DROP TABLE tea_t;

/* UNINSTALL */

/*
execute rollback_ddl.sql
execute sketch/engine_basis_use_case/rollback_dml.sql
*/
