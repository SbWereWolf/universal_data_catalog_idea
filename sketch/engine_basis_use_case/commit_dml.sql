-- задаём теги для свойств
INSERT INTO tag (code, title, description)
VALUES
  ('DIGITAL_DATA_TYPE', 'числовой тип', 'числовой тип'),
  ('STRING_DATA_TYPE', 'символьный тип', 'символьный тип'),
  ('LIKE_SEARCH_TYPE', 'поиск подобия', 'поиск подобия'),
  ('BETWEEN_SEARCH_TYPE', 'поиск в диапазоне', 'поиск в диапазоне'),
  ('ENUMERATION_SEARCH_TYPE', 'поиск перечисления', 'поиск перечисления'),
  ('USER_PROPERTY', 'пользовательское свойство', 'пользовательское свойство'),
  ('SYSTEM_PROPERTY', 'системное свойство', 'системное свойство');

-- добавляем свойство
INSERT INTO property (code, title, description)
VALUES ('GOODS_ITEM_PRICE_RUB', 'цена товара в рублях', 'цена позиции каталога товаров в рублях');

-- для свойства проставляем теги
INSERT INTO property_tag
(property_id, tag_id)
VALUES
  (( SELECT id FROM property WHERE code = 'GOODS_ITEM_PRICE_RUB' ), ( SELECT id FROM tag WHERE code = 'DIGITAL_DATA_TYPE' )),
  (( SELECT id FROM property WHERE code = 'GOODS_ITEM_PRICE_RUB' ), ( SELECT id FROM tag WHERE code = 'BETWEEN_SEARCH_TYPE' )),
  (( SELECT id FROM property WHERE code = 'GOODS_ITEM_PRICE_RUB' ), ( SELECT id FROM tag WHERE code = 'USER_PROPERTY' ));


INSERT INTO property (code, title, description)
VALUES ('SERVICE_POSITION_PRICE_RUB', 'цена услуги в рублях', 'цена позиции каталога услуг в рублях');

INSERT INTO property_tag
(property_id, tag_id)
VALUES
  (( SELECT id FROM property WHERE code = 'SERVICE_POSITION_PRICE_RUB' ), ( SELECT id FROM tag WHERE code = 'DIGITAL_DATA_TYPE' )),
  (( SELECT id FROM property WHERE code = 'SERVICE_POSITION_PRICE_RUB' ), ( SELECT id FROM tag WHERE code = 'BETWEEN_SEARCH_TYPE' )),
  (( SELECT id FROM property WHERE code = 'SERVICE_POSITION_PRICE_RUB' ), ( SELECT id FROM tag WHERE code = 'USER_PROPERTY' ));

INSERT INTO property (code, title, description)
VALUES ('GOODS_ITEM_UNITS_OF_MEASURE', 'единицы измерения для товарной позиции',
        'единицы измерения для единицы товарной позиции');

INSERT INTO property_tag
(property_id, tag_id)
VALUES
  (( SELECT id FROM property WHERE code = 'GOODS_ITEM_UNITS_OF_MEASURE' ), ( SELECT id FROM tag WHERE code = 'STRING_DATA_TYPE' )),
  (( SELECT id FROM property WHERE code = 'GOODS_ITEM_UNITS_OF_MEASURE' ), ( SELECT id FROM tag WHERE code = 'ENUMERATION_SEARCH_TYPE' )),
  (( SELECT id FROM property WHERE code = 'GOODS_ITEM_UNITS_OF_MEASURE' ), ( SELECT id FROM tag WHERE code = 'USER_PROPERTY' ));

INSERT INTO property (code, title, description)
VALUES ('MANUFACTURER_MODEL', 'Модель', 'Модель изделия');

INSERT INTO property_tag
(property_id, tag_id)
VALUES
  (( SELECT id FROM property WHERE code = 'MANUFACTURER_MODEL' ), ( SELECT id FROM tag WHERE code = 'STRING_DATA_TYPE' )),
  (( SELECT id FROM property WHERE code = 'MANUFACTURER_MODEL' ), ( SELECT id FROM tag WHERE code = 'LIKE_SEARCH_TYPE' )),
  (( SELECT id FROM property WHERE code = 'MANUFACTURER_MODEL' ), ( SELECT id FROM tag WHERE code = 'SYSTEM_PROPERTY' ));

INSERT INTO property (code, title, description)
VALUES ('TRADE_MARK', 'Торговая марка', 'Торговая марка');

INSERT INTO property_tag
(property_id, tag_id)
VALUES
  (( SELECT id FROM property WHERE code = 'TRADE_MARK' ), ( SELECT id FROM tag WHERE code = 'STRING_DATA_TYPE' )),
  (( SELECT id FROM property WHERE code = 'TRADE_MARK' ), ( SELECT id FROM tag WHERE code = 'ENUMERATION_SEARCH_TYPE' )),
  (( SELECT id FROM property WHERE code = 'TRADE_MARK' ), ( SELECT id FROM tag WHERE code = 'SYSTEM_PROPERTY' ));


INSERT INTO property (code, title, description)
VALUES ('BUCKET_CAPACITY_M3', 'Ёмкость ковша', 'Ёмкость ковша, метров кубических');

INSERT INTO property_tag
(property_id, tag_id)
VALUES
  (( SELECT id FROM property WHERE code = 'BUCKET_CAPACITY_M3' ), ( SELECT id FROM tag WHERE code = 'DIGITAL_DATA_TYPE' )),
  (( SELECT id FROM property WHERE code = 'BUCKET_CAPACITY_M3' ), ( SELECT id FROM tag WHERE code = 'BETWEEN_SEARCH_TYPE' )),
  (( SELECT id FROM property WHERE code = 'BUCKET_CAPACITY_M3' ), ( SELECT id FROM tag WHERE code = 'SYSTEM_PROPERTY' ));

-- добавляем рубрики
INSERT INTO rubric (code, title, description)
VALUES
  ('GOODS', 'Товары', 'Каталог товаров'),
  ('SPECIAL_MACHINE', 'Специальная техника', 'Техника специальзированного назначения'),
  ('CONSTRUCTION_MACHINE', 'Строительная техника', 'Техника для строительных работ'),
  ('EXCAVATOR', 'Экскаваторы', 'Экскаваторы, все виды'),
  ('ekskavatory-karernye', 'Экскаваторы карьерные', 'Экскаваторы карьерные')
;

-- добавляем элементы дерева для стыковки с рубриками
INSERT INTO element_tree (element_tree_id) VALUES(NULL);
INSERT INTO element_tree (element_tree_id) VALUES(NULL);
INSERT INTO element_tree (element_tree_id) VALUES(NULL);
INSERT INTO element_tree (element_tree_id) VALUES(NULL);
INSERT INTO element_tree (element_tree_id) VALUES(NULL);

-- стыкуем дерево и рубрики
INSERT INTO rubric_element_tree
(element_tree_id, rubric_id)
VALUES
  (
    (SELECT id from element_tree et WHERE et.element_tree_id IS NULL AND NOT EXISTS ( select NULL from rubric_element_tree ret where ret.id = et.id )LIMIT 1),
    (SELECT id from rubric WHERE code = 'GOODS')
  );
INSERT INTO rubric_element_tree
(element_tree_id, rubric_id)
VALUES
  (
    (SELECT id from element_tree et WHERE et.element_tree_id IS NULL AND NOT EXISTS ( select NULL from rubric_element_tree ret where ret.id = et.id )LIMIT 1),
    (SELECT id from rubric WHERE code = 'SPECIAL_MACHINE')
  );
INSERT INTO rubric_element_tree
(element_tree_id, rubric_id)
VALUES
(
  (SELECT id from element_tree et WHERE et.element_tree_id IS NULL AND NOT EXISTS ( select NULL from rubric_element_tree ret where ret.id = et.id )LIMIT 1),
    (SELECT id from rubric WHERE code = 'CONSTRUCTION_MACHINE')
);
INSERT INTO rubric_element_tree
(element_tree_id, rubric_id)
VALUES
(
  (SELECT id from element_tree et WHERE et.element_tree_id IS NULL AND NOT EXISTS ( select NULL from rubric_element_tree ret where ret.id = et.id )LIMIT 1),
    (SELECT id from rubric WHERE code = 'EXCAVATOR')
);
INSERT INTO rubric_element_tree
(element_tree_id, rubric_id)
VALUES
(
  (SELECT id from element_tree et WHERE et.element_tree_id IS NULL AND NOT EXISTS ( select NULL from rubric_element_tree ret where ret.id = et.id )LIMIT 1),
    (SELECT id from rubric WHERE code = 'ekskavatory-karernye')
)
;

UPDATE element_tree
SET element_tree_id = (select id from element_tree et where id = (select element_tree_id from rubric_element_tree where rubric_id in (select id from rubric where code = 'GOODS')))
WHERE id = (select id from element_tree et where id = (select element_tree_id from rubric_element_tree where rubric_id in (select id from rubric where code = 'SPECIAL_MACHINE')));
UPDATE element_tree
SET element_tree_id = (select id from element_tree et where id = (select element_tree_id from rubric_element_tree where rubric_id in (select id from rubric where code = 'SPECIAL_MACHINE')))
WHERE id = (select id from element_tree et where id = (select element_tree_id from rubric_element_tree where rubric_id in (select id from rubric where code = 'CONSTRUCTION_MACHINE')));
UPDATE element_tree
SET element_tree_id = (select id from element_tree et where id = (select element_tree_id from rubric_element_tree where rubric_id in (select id from rubric where code = 'CONSTRUCTION_MACHINE')))
WHERE id = (select id from element_tree et where id = (select element_tree_id from rubric_element_tree where rubric_id in (select id from rubric where code = 'EXCAVATOR')));
UPDATE element_tree
SET element_tree_id = (select id from element_tree et where id = (select element_tree_id from rubric_element_tree where rubric_id in (select id from rubric where code = 'EXCAVATOR')))
WHERE id = (select id from element_tree et where id = (select element_tree_id from rubric_element_tree where rubric_id in (select id from rubric where code = 'ekskavatory-karernye')));

-- назначаем рубрикам свойства
INSERT INTO rubric_property
(rubric_id, property_id)
VALUES
  ((SELECT id FROM rubric WHERE code = 'ekskavatory-karernye'), (SELECT id FROM property WHERE code = 'GOODS_ITEM_PRICE_RUB')),
  ((SELECT id FROM rubric WHERE code = 'ekskavatory-karernye'), (SELECT id FROM property WHERE code = 'GOODS_ITEM_UNITS_OF_MEASURE')),
  ((SELECT id FROM rubric WHERE code = 'ekskavatory-karernye'), (SELECT id FROM property WHERE code = 'MANUFACTURER_MODEL')),
  ((SELECT id FROM rubric WHERE code = 'ekskavatory-karernye'), (SELECT id FROM property WHERE code = 'TRADE_MARK')),
  ((SELECT id FROM rubric WHERE code = 'ekskavatory-karernye'), (SELECT id FROM property WHERE code = 'BUCKET_CAPACITY_M3'));

-- добавляем Воплощения ( позиции каталога )
INSERT INTO item
(code, title, description)
VALUES
  ('doneks-eo-4112a-1', 'Донэкс ЭО-4112А-1', 'Донэкс ЭО-4112А-1 обратная лопата'),
  ('uralmash-ekg-5a', 'Уралмаш ЭКГ-5А', 'Уралмаш ЭКГ-5А прямая лопата'),
  ('uralmash-ekg-9us', 'Уралмаш ЭКГ-9УС', 'Уралмаш ЭКГ-9УС прямая лопата'),
  ('uralmash-ekg-12', 'Уралмаш ЭКГ-12', 'Уралмаш ЭКГ-12 прямая лопата'),
  ('uralmash-ekg-20a', 'Уралмаш ЭКГ-20А', 'Уралмаш ЭКГ-20А прямая лопата');

INSERT INTO rubric_item
(rubric_id, item_id)
VALUES
  ((SELECT id FROM rubric WHERE code = 'ekskavatory-karernye'), (SELECT id FROM item WHERE code = 'doneks-eo-4112a-1')),
  ((SELECT id FROM rubric WHERE code = 'ekskavatory-karernye'), (SELECT id FROM item WHERE code = 'uralmash-ekg-5a')),
  ((SELECT id FROM rubric WHERE code = 'ekskavatory-karernye'), (SELECT id FROM item WHERE code = 'uralmash-ekg-9us')),
  ((SELECT id FROM rubric WHERE code = 'ekskavatory-karernye'), (SELECT id FROM item WHERE code = 'uralmash-ekg-12')),
  ((SELECT id FROM rubric WHERE code = 'ekskavatory-karernye'), (SELECT id FROM item WHERE code = 'uralmash-ekg-20a'));

INSERT INTO content
(raw, property_id)
VALUES
('ЭКГ-20А',(SELECT id from property where code = 'MANUFACTURER_MODEL')),
('ЭКГ-12',(SELECT id from property where code = 'MANUFACTURER_MODEL')),
('ЭКГ-9УС',(SELECT id from property where code = 'MANUFACTURER_MODEL')),
('ЭКГ-5А',(SELECT id from property where code = 'MANUFACTURER_MODEL')),
('ЭО-4112А-1',(SELECT id from property where code = 'MANUFACTURER_MODEL')),

('Донэкс',(SELECT id from property where code = 'TRADE_MARK')),
('Уралмаш',(SELECT id from property where code = 'TRADE_MARK')),
('Уралмаш',(SELECT id from property where code = 'TRADE_MARK')),
('Уралмаш',(SELECT id from property where code = 'TRADE_MARK')),
('Уралмаш',(SELECT id from property where code = 'TRADE_MARK')),

('0.75',(SELECT id from property where code = 'BUCKET_CAPACITY_M3')),
('5.2',(SELECT id from property where code = 'BUCKET_CAPACITY_M3')),
('9',(SELECT id from property where code = 'BUCKET_CAPACITY_M3')),
('12',(SELECT id from property where code = 'BUCKET_CAPACITY_M3')),
('25',(SELECT id from property where code = 'BUCKET_CAPACITY_M3'))
;

INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'doneks-eo-4112a-1'),
   (SELECT c.id
    FROM content c
    WHERE raw = 'ЭО-4112А-1' AND property_id =
                                 (SELECT id
                                  FROM property
                                  WHERE code = 'MANUFACTURER_MODEL')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'uralmash-ekg-5a'),
   (SELECT c.id
    FROM content c
    WHERE raw = 'ЭКГ-5А' AND property_id =
                             (SELECT id
                              FROM property
                              WHERE code = 'MANUFACTURER_MODEL')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'uralmash-ekg-9us'),
   (SELECT c.id
    FROM content c
    WHERE raw = 'ЭКГ-9УС' AND property_id =
                              (SELECT id
                               FROM property
                               WHERE code = 'MANUFACTURER_MODEL')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'uralmash-ekg-12'),
   (SELECT c.id
    FROM content c
    WHERE raw = 'ЭКГ-12' AND property_id =
                             (SELECT id
                              FROM property
                              WHERE code = 'MANUFACTURER_MODEL')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'uralmash-ekg-20a'),
   (SELECT c.id
    FROM content c
    WHERE raw = 'ЭКГ-20А' AND property_id =
                              (SELECT id
                               FROM property
                               WHERE code = 'MANUFACTURER_MODEL')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES

  ((SELECT id
    FROM item
    WHERE code = 'doneks-eo-4112a-1'),
   (SELECT c.id
    FROM content c
    WHERE raw = 'Донэкс' AND property_id =
                             (SELECT id
                              FROM property
                              WHERE code = 'TRADE_MARK')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'uralmash-ekg-5a'),
   (SELECT c.id
    FROM content c
    WHERE raw = 'Уралмаш' AND property_id =
                              (SELECT id
                               FROM property
                               WHERE code = 'TRADE_MARK')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'uralmash-ekg-9us'),
   (SELECT c.id
    FROM content c
    WHERE raw = 'Уралмаш' AND property_id =
                              (SELECT id
                               FROM property
                               WHERE code = 'TRADE_MARK')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'uralmash-ekg-12'),
   (SELECT c.id
    FROM content c
    WHERE raw = 'Уралмаш' AND property_id =
                              (SELECT id
                               FROM property
                               WHERE code = 'TRADE_MARK')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'uralmash-ekg-20a'),

   (SELECT c.id
    FROM content c
    WHERE raw = 'Уралмаш' AND property_id =
                              (SELECT id
                               FROM property
                               WHERE code = 'TRADE_MARK')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES

  ((SELECT id
    FROM item
    WHERE code = 'doneks-eo-4112a-1'),
   (SELECT c.id
    FROM content c
    WHERE raw = '0.75' AND property_id =
                           (SELECT id
                            FROM property
                            WHERE code = 'BUCKET_CAPACITY_M3')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'uralmash-ekg-5a'),
   (SELECT c.id
    FROM content c
    WHERE raw = '5.2' AND property_id =
                          (SELECT id
                           FROM property
                           WHERE code = 'BUCKET_CAPACITY_M3')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'uralmash-ekg-9us'),
   (SELECT c.id
    FROM content c
    WHERE raw = '9' AND property_id =
                        (SELECT id
                         FROM property
                         WHERE code = 'BUCKET_CAPACITY_M3')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'uralmash-ekg-12'),
   (SELECT c.id FROM content c WHERE raw = '12'
          AND property_id = (SELECT id FROM property WHERE code = 'BUCKET_CAPACITY_M3')
          AND NOT EXISTS(SELECT NULL FROM item_content WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'uralmash-ekg-20a'),
   (SELECT c.id
    FROM content c
    WHERE raw = '25' AND property_id =
                         (SELECT id
                          FROM property
                          WHERE code = 'BUCKET_CAPACITY_M3')
          AND NOT EXISTS(SELECT NULL FROM item_content WHERE content_id = c.id) LIMIT 1));

INSERT INTO string_matter (string, content_id) VALUES
('ЭО-4112А-1',(SELECT c.id FROM content c WHERE raw = 'ЭО-4112А-1' AND property_id = (SELECT id from property where code = 'MANUFACTURER_MODEL')AND NOT EXISTS(SELECT NULL FROM string_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO string_matter (string, content_id) VALUES
('ЭКГ-5А',(SELECT c.id FROM content c WHERE raw = 'ЭКГ-5А' AND property_id = (SELECT id from property where code = 'MANUFACTURER_MODEL')AND NOT EXISTS(SELECT NULL FROM string_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO string_matter (string, content_id) VALUES
('ЭКГ-9УС',(SELECT c.id FROM content c WHERE raw = 'ЭКГ-9УС' AND property_id = (SELECT id from property where code = 'MANUFACTURER_MODEL')AND NOT EXISTS(SELECT NULL FROM string_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO string_matter (string, content_id) VALUES
('ЭКГ-12',(SELECT c.id FROM content c WHERE raw = 'ЭКГ-12' AND property_id = (SELECT id from property where code = 'MANUFACTURER_MODEL')AND NOT EXISTS(SELECT NULL FROM string_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO string_matter (string, content_id) VALUES
('ЭКГ-20А',(SELECT c.id FROM content c WHERE raw = 'ЭКГ-20А' AND property_id = (SELECT id from property where code = 'MANUFACTURER_MODEL')AND NOT EXISTS(SELECT NULL FROM string_matter WHERE content_id = c.id)LIMIT 1));

INSERT INTO string_matter (string, content_id) VALUES
('Донэкс',(SELECT c.id FROM content c WHERE raw = 'Донэкс' AND property_id = (SELECT id from property where code = 'TRADE_MARK')AND NOT EXISTS(SELECT NULL FROM string_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO string_matter (string, content_id) VALUES
('Уралмаш',(SELECT c.id FROM content c WHERE raw = 'Уралмаш' AND property_id = (SELECT id from property where code = 'TRADE_MARK')AND NOT EXISTS(SELECT NULL FROM string_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO string_matter (string, content_id) VALUES
('Уралмаш',(SELECT c.id FROM content c WHERE raw = 'Уралмаш' AND property_id = (SELECT id from property where code = 'TRADE_MARK')AND NOT EXISTS(SELECT NULL FROM string_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO string_matter (string, content_id) VALUES
('Уралмаш',(SELECT c.id FROM content c WHERE raw = 'Уралмаш' AND property_id = (SELECT id from property where code = 'TRADE_MARK')AND NOT EXISTS(SELECT NULL FROM string_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO string_matter (string, content_id) VALUES
('Уралмаш',(SELECT c.id FROM content c WHERE raw = 'Уралмаш' AND property_id = (SELECT id from property where code = 'TRADE_MARK')AND NOT EXISTS(SELECT NULL FROM string_matter WHERE content_id = c.id)LIMIT 1));

-- по науке надо сделать вставку в колонку digital через конвертацию строки из content через ::numeric или ::double precision
INSERT INTO digital_matter (digital, content_id) VALUES
(0.75,(SELECT c.id from content c WHERE raw = '0.75' AND property_id = (SELECT id from property where code = 'BUCKET_CAPACITY_M3') AND NOT EXISTS (SELECT NULL from digital_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO digital_matter (digital, content_id) VALUES
(5.2,(SELECT c.id from content c WHERE raw = '5.2' AND property_id = (SELECT id from property where code = 'BUCKET_CAPACITY_M3') AND NOT EXISTS (SELECT NULL from digital_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO digital_matter (digital, content_id) VALUES
(9,(SELECT c.id from content c WHERE raw = '9' AND property_id = (SELECT id from property where code = 'BUCKET_CAPACITY_M3') AND NOT EXISTS (SELECT NULL from digital_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO digital_matter (digital, content_id) VALUES
(12,(SELECT c.id from content c WHERE raw = '12' AND property_id = (SELECT id from property where code = 'BUCKET_CAPACITY_M3') AND NOT EXISTS (SELECT NULL from digital_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO digital_matter (digital, content_id) VALUES
(25,(SELECT c.id from content c WHERE raw = '25' AND property_id = (SELECT id from property where code = 'BUCKET_CAPACITY_M3') AND NOT EXISTS (SELECT NULL from digital_matter WHERE content_id = c.id)LIMIT 1));
;

-- добавим ещё одну рубрику

-- добавляем свойство
INSERT INTO property (code, title, description)
VALUES ('SHOVEL_CAPACITY_M3', 'Ёмкость лопаты', 'Ёмкость лопаты эксковатора, метров кубических');

-- для свойства проставляем теги
INSERT INTO property_tag
(property_id, tag_id)
VALUES
  (( SELECT id FROM property WHERE code = 'SHOVEL_CAPACITY_M3' ), ( SELECT id FROM tag WHERE code = 'DIGITAL_DATA_TYPE' )),
  (( SELECT id FROM property WHERE code = 'SHOVEL_CAPACITY_M3' ), ( SELECT id FROM tag WHERE code = 'BETWEEN_SEARCH_TYPE' )),
  (( SELECT id FROM property WHERE code = 'SHOVEL_CAPACITY_M3' ), ( SELECT id FROM tag WHERE code = 'SYSTEM_PROPERTY' ));

-- добавляем рубрики
INSERT INTO rubric (code, title, description)
VALUES
  ('ekskavatory-pogruzchiki', 'Экскаваторы погрузчики', 'Экскаваторы погрузчики')
;

-- добавляем элементы дерева для стыковки с рубриками
INSERT INTO element_tree (element_tree_id) VALUES(NULL);

-- стыкуем дерево и рубрики
INSERT INTO rubric_element_tree
(element_tree_id, rubric_id)
VALUES
(
  (SELECT id from element_tree et WHERE et.element_tree_id IS NULL AND NOT EXISTS ( select NULL from rubric_element_tree ret where ret.id = et.id )LIMIT 1),
    (SELECT id from rubric WHERE code = 'ekskavatory-pogruzchiki')
)
;

UPDATE element_tree
SET element_tree_id = (select id from element_tree et where id = (select element_tree_id from rubric_element_tree where rubric_id in (select id from rubric where code = 'EXCAVATOR')))
WHERE id = (select id from element_tree et where id = (select element_tree_id from rubric_element_tree where rubric_id in (select id from rubric where code = 'ekskavatory-pogruzchiki')));

-- назначаем рубрикам свойства
INSERT INTO rubric_property
(rubric_id, property_id)
VALUES
  ((SELECT id FROM rubric WHERE code = 'ekskavatory-pogruzchiki'), (SELECT id FROM property WHERE code = 'GOODS_ITEM_PRICE_RUB')),
  ((SELECT id FROM rubric WHERE code = 'ekskavatory-pogruzchiki'), (SELECT id FROM property WHERE code = 'GOODS_ITEM_UNITS_OF_MEASURE')),
  ((SELECT id FROM rubric WHERE code = 'ekskavatory-pogruzchiki'), (SELECT id FROM property WHERE code = 'MANUFACTURER_MODEL')),
  ((SELECT id FROM rubric WHERE code = 'ekskavatory-pogruzchiki'), (SELECT id FROM property WHERE code = 'TRADE_MARK')),
  ((SELECT id FROM rubric WHERE code = 'ekskavatory-pogruzchiki'), (SELECT id FROM property WHERE code = 'BUCKET_CAPACITY_M3')),
  ((SELECT id FROM rubric WHERE code = 'ekskavatory-pogruzchiki'), (SELECT id FROM property WHERE code = 'SHOVEL_CAPACITY_M3'));

-- добавляем Воплощения ( позиции каталога )
INSERT INTO item
(code, title, description)
VALUES
  ('volvo-bl71-plus', 'VOLVO BL71 Plus', 'VOLVO BL71 Plus'),
  ('bzgt-epm-100', 'БЗГТ ЭПМ-100', 'БЗГТ ЭПМ-100'),
  ('caterpillar-432e', 'Caterpillar 432E', 'Caterpillar 432E'),
  ('jcb-4cx', 'JCB 4CX', 'JCB 4CX'),
  ('jcb-3cx-super', 'JCB 3CX Super', 'JCB 3CX Super');

INSERT INTO rubric_item
(rubric_id, item_id)
VALUES
  ((SELECT id FROM rubric WHERE code = 'ekskavatory-pogruzchiki'), (SELECT id FROM item WHERE code = 'volvo-bl71-plus')),
  ((SELECT id FROM rubric WHERE code = 'ekskavatory-pogruzchiki'), (SELECT id FROM item WHERE code = 'bzgt-epm-100')),
  ((SELECT id FROM rubric WHERE code = 'ekskavatory-pogruzchiki'), (SELECT id FROM item WHERE code = 'caterpillar-432e')),
  ((SELECT id FROM rubric WHERE code = 'ekskavatory-pogruzchiki'), (SELECT id FROM item WHERE code = 'jcb-4cx')),
  ((SELECT id FROM rubric WHERE code = 'ekskavatory-pogruzchiki'), (SELECT id FROM item WHERE code = 'jcb-3cx-super'));

INSERT INTO content
(raw, property_id)
VALUES
('BL71 Plus',(SELECT id from property where code = 'MANUFACTURER_MODEL')),
('ЭПМ-100',(SELECT id from property where code = 'MANUFACTURER_MODEL')),
('432E',(SELECT id from property where code = 'MANUFACTURER_MODEL')),
('4CX',(SELECT id from property where code = 'MANUFACTURER_MODEL')),
('3CX Super',(SELECT id from property where code = 'MANUFACTURER_MODEL')),

('VOLVO',(SELECT id from property where code = 'TRADE_MARK')),
('БЗГТ',(SELECT id from property where code = 'TRADE_MARK')),
('Caterpillar',(SELECT id from property where code = 'TRADE_MARK')),
('JCB',(SELECT id from property where code = 'TRADE_MARK')),
('JCB',(SELECT id from property where code = 'TRADE_MARK')),

('1',(SELECT id from property where code = 'BUCKET_CAPACITY_M3')),
('0.8',(SELECT id from property where code = 'BUCKET_CAPACITY_M3')),
('1.03',(SELECT id from property where code = 'BUCKET_CAPACITY_M3')),
('1.1',(SELECT id from property where code = 'BUCKET_CAPACITY_M3')),
('1',(SELECT id from property where code = 'BUCKET_CAPACITY_M3')),

('0.21',(SELECT id from property where code = 'SHOVEL_CAPACITY_M3')),
('0.16',(SELECT id from property where code = 'SHOVEL_CAPACITY_M3')),
('0.38',(SELECT id from property where code = 'SHOVEL_CAPACITY_M3')),
('0.48',(SELECT id from property where code = 'SHOVEL_CAPACITY_M3')),
('0.48',(SELECT id from property where code = 'SHOVEL_CAPACITY_M3'));

INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'volvo-bl71-plus'),
   (SELECT c.id
    FROM content c
    WHERE raw = 'BL71 Plus' AND property_id =
                                 (SELECT id
                                  FROM property
                                  WHERE code = 'MANUFACTURER_MODEL')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'bzgt-epm-100'),
   (SELECT c.id
    FROM content c
    WHERE raw = 'ЭПМ-100' AND property_id =
                             (SELECT id
                              FROM property
                              WHERE code = 'MANUFACTURER_MODEL')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'caterpillar-432e'),
   (SELECT c.id
    FROM content c
    WHERE raw = '432E' AND property_id =
                              (SELECT id
                               FROM property
                               WHERE code = 'MANUFACTURER_MODEL')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'jcb-4cx'),
   (SELECT c.id
    FROM content c
    WHERE raw = '4CX' AND property_id =
                             (SELECT id
                              FROM property
                              WHERE code = 'MANUFACTURER_MODEL')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'jcb-3cx-super'),
   (SELECT c.id
    FROM content c
    WHERE raw = '3CX Super' AND property_id =
                              (SELECT id
                               FROM property
                               WHERE code = 'MANUFACTURER_MODEL')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES

  ((SELECT id
    FROM item
    WHERE code = 'volvo-bl71-plus'),
   (SELECT c.id
    FROM content c
    WHERE raw = 'VOLVO' AND property_id =
                             (SELECT id
                              FROM property
                              WHERE code = 'TRADE_MARK')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'bzgt-epm-100'),
   (SELECT c.id
    FROM content c
    WHERE raw = 'БЗГТ' AND property_id =
                              (SELECT id
                               FROM property
                               WHERE code = 'TRADE_MARK')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'caterpillar-432e'),
   (SELECT c.id
    FROM content c
    WHERE raw = 'Caterpillar' AND property_id =
                              (SELECT id
                               FROM property
                               WHERE code = 'TRADE_MARK')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'jcb-4cx'),
   (SELECT c.id
    FROM content c
    WHERE raw = 'JCB' AND property_id =
                              (SELECT id
                               FROM property
                               WHERE code = 'TRADE_MARK')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'jcb-3cx-super'),

   (SELECT c.id
    FROM content c
    WHERE raw = 'JCB' AND property_id =
                              (SELECT id
                               FROM property
                               WHERE code = 'TRADE_MARK')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES

  ((SELECT id
    FROM item
    WHERE code = 'volvo-bl71-plus'),
   (SELECT c.id
    FROM content c
    WHERE raw = '1' AND property_id =
                           (SELECT id
                            FROM property
                            WHERE code = 'BUCKET_CAPACITY_M3')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'bzgt-epm-100'),
   (SELECT c.id
    FROM content c
    WHERE raw = '0.8' AND property_id =
                          (SELECT id
                           FROM property
                           WHERE code = 'BUCKET_CAPACITY_M3')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'caterpillar-432e'),
   (SELECT c.id
    FROM content c
    WHERE raw = '1.03' AND property_id =
                        (SELECT id
                         FROM property
                         WHERE code = 'BUCKET_CAPACITY_M3')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'jcb-4cx'),
   (SELECT c.id FROM content c WHERE raw = '1.1'
          AND property_id = (SELECT id FROM property WHERE code = 'BUCKET_CAPACITY_M3')
          AND NOT EXISTS(SELECT NULL FROM item_content WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'jcb-3cx-super'),
   (SELECT c.id
    FROM content c
    WHERE raw = '1' AND property_id =
                         (SELECT id
                          FROM property
                          WHERE code = 'BUCKET_CAPACITY_M3')
          AND NOT EXISTS(SELECT NULL FROM item_content WHERE content_id = c.id) LIMIT 1));

INSERT INTO item_content
(item_id, content_id)
VALUES

  ((SELECT id
    FROM item
    WHERE code = 'volvo-bl71-plus'),
   (SELECT c.id
    FROM content c
    WHERE raw = '0.21' AND property_id =
                           (SELECT id
                            FROM property
                            WHERE code = 'SHOVEL_CAPACITY_M3')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'bzgt-epm-100'),
   (SELECT c.id
    FROM content c
    WHERE raw = '0.16' AND property_id =
                          (SELECT id
                           FROM property
                           WHERE code = 'SHOVEL_CAPACITY_M3')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'caterpillar-432e'),
   (SELECT c.id
    FROM content c
    WHERE raw = '0.38' AND property_id =
                        (SELECT id
                         FROM property
                         WHERE code = 'SHOVEL_CAPACITY_M3')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'jcb-4cx'),
   (SELECT c.id FROM content c WHERE raw = '0.48'
          AND property_id = (SELECT id FROM property WHERE code = 'SHOVEL_CAPACITY_M3')
          AND NOT EXISTS(SELECT NULL FROM item_content WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'jcb-3cx-super'),
   (SELECT c.id
    FROM content c
    WHERE raw = '0.48' AND property_id =
                         (SELECT id
                          FROM property
                          WHERE code = 'SHOVEL_CAPACITY_M3')
          AND NOT EXISTS(SELECT NULL FROM item_content WHERE content_id = c.id) LIMIT 1));

INSERT INTO string_matter (string, content_id) VALUES
('BL71 Plus',(SELECT c.id FROM content c WHERE raw = 'BL71 Plus' AND property_id = (SELECT id from property where code = 'MANUFACTURER_MODEL')AND NOT EXISTS(SELECT NULL FROM string_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO string_matter (string, content_id) VALUES
('ЭПМ-100',(SELECT c.id FROM content c WHERE raw = 'ЭПМ-100' AND property_id = (SELECT id from property where code = 'MANUFACTURER_MODEL')AND NOT EXISTS(SELECT NULL FROM string_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO string_matter (string, content_id) VALUES
('432E',(SELECT c.id FROM content c WHERE raw = '432E' AND property_id = (SELECT id from property where code = 'MANUFACTURER_MODEL')AND NOT EXISTS(SELECT NULL FROM string_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO string_matter (string, content_id) VALUES
('4CX',(SELECT c.id FROM content c WHERE raw = '4CX' AND property_id = (SELECT id from property where code = 'MANUFACTURER_MODEL')AND NOT EXISTS(SELECT NULL FROM string_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO string_matter (string, content_id) VALUES
('3CX Super',(SELECT c.id FROM content c WHERE raw = '3CX Super' AND property_id = (SELECT id from property where code = 'MANUFACTURER_MODEL')AND NOT EXISTS(SELECT NULL FROM string_matter WHERE content_id = c.id)LIMIT 1));

INSERT INTO string_matter (string, content_id) VALUES
('VOLVO',(SELECT c.id FROM content c WHERE raw = 'VOLVO' AND property_id = (SELECT id from property where code = 'TRADE_MARK')AND NOT EXISTS(SELECT NULL FROM string_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO string_matter (string, content_id) VALUES
('БЗГТ',(SELECT c.id FROM content c WHERE raw = 'БЗГТ' AND property_id = (SELECT id from property where code = 'TRADE_MARK')AND NOT EXISTS(SELECT NULL FROM string_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO string_matter (string, content_id) VALUES
('Caterpillar',(SELECT c.id FROM content c WHERE raw = 'Caterpillar' AND property_id = (SELECT id from property where code = 'TRADE_MARK')AND NOT EXISTS(SELECT NULL FROM string_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO string_matter (string, content_id) VALUES
('JCB',(SELECT c.id FROM content c WHERE raw = 'JCB' AND property_id = (SELECT id from property where code = 'TRADE_MARK')AND NOT EXISTS(SELECT NULL FROM string_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO string_matter (string, content_id) VALUES
('JCB',(SELECT c.id FROM content c WHERE raw = 'JCB' AND property_id = (SELECT id from property where code = 'TRADE_MARK')AND NOT EXISTS(SELECT NULL FROM string_matter WHERE content_id = c.id)LIMIT 1));

-- по науке надо сделать вставку в колонку digital через конвертацию строки из content через ::numeric или ::double precision
INSERT INTO digital_matter (digital, content_id) VALUES
(1,(SELECT c.id from content c WHERE raw = '1' AND property_id = (SELECT id from property where code = 'BUCKET_CAPACITY_M3') AND NOT EXISTS (SELECT NULL from digital_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO digital_matter (digital, content_id) VALUES
(0.8,(SELECT c.id from content c WHERE raw = '0.8' AND property_id = (SELECT id from property where code = 'BUCKET_CAPACITY_M3') AND NOT EXISTS (SELECT NULL from digital_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO digital_matter (digital, content_id) VALUES
(1.03,(SELECT c.id from content c WHERE raw = '1.03' AND property_id = (SELECT id from property where code = 'BUCKET_CAPACITY_M3') AND NOT EXISTS (SELECT NULL from digital_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO digital_matter (digital, content_id) VALUES
(1.1,(SELECT c.id from content c WHERE raw = '1.1' AND property_id = (SELECT id from property where code = 'BUCKET_CAPACITY_M3') AND NOT EXISTS (SELECT NULL from digital_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO digital_matter (digital, content_id) VALUES
(1,(SELECT c.id from content c WHERE raw = '1' AND property_id = (SELECT id from property where code = 'BUCKET_CAPACITY_M3') AND NOT EXISTS (SELECT NULL from digital_matter WHERE content_id = c.id)LIMIT 1));

INSERT INTO digital_matter (digital, content_id) VALUES
(0.21,(SELECT c.id from content c WHERE raw = '0.21' AND property_id = (SELECT id from property where code = 'SHOVEL_CAPACITY_M3') AND NOT EXISTS (SELECT NULL from digital_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO digital_matter (digital, content_id) VALUES
(0.16,(SELECT c.id from content c WHERE raw = '0.16' AND property_id = (SELECT id from property where code = 'SHOVEL_CAPACITY_M3') AND NOT EXISTS (SELECT NULL from digital_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO digital_matter (digital, content_id) VALUES
(0.38,(SELECT c.id from content c WHERE raw = '0.38' AND property_id = (SELECT id from property where code = 'SHOVEL_CAPACITY_M3') AND NOT EXISTS (SELECT NULL from digital_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO digital_matter (digital, content_id) VALUES
(0.48,(SELECT c.id from content c WHERE raw = '0.48' AND property_id = (SELECT id from property where code = 'SHOVEL_CAPACITY_M3') AND NOT EXISTS (SELECT NULL from digital_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO digital_matter (digital, content_id) VALUES
(0.48,(SELECT c.id from content c WHERE raw = '0.48' AND property_id = (SELECT id from property where code = 'SHOVEL_CAPACITY_M3') AND NOT EXISTS (SELECT NULL from digital_matter WHERE content_id = c.id)LIMIT 1));

INSERT INTO redactor
(code, title, description)
VALUES
  ('SYSTEM','Система','Системный редактор информационного каталога'),
  ('petya@gmail.com','Пётр Николаевич','менеджер отдела снабжения ООО Рога и Копыта'),
  ('vasya@mail.ru','Василий Алибабаевич Уримчи','бригадир СМУ-3'),
  ('oleg@yandex.ru','Олег','Мы всегда можем договориться о взаимовыгодном сотрудничестве')
;

INSERT INTO redactor_content ( redactor_id, content_id) VALUES
((SELECT id FROM redactor WHERE code = 'SYSTEM'),(SELECT c.id FROM content c WHERE raw = 'ЭО-4112А-1' AND property_id = (SELECT id from property where code = 'MANUFACTURER_MODEL')AND NOT EXISTS(SELECT NULL FROM redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content ( redactor_id, content_id) VALUES
((SELECT id FROM redactor WHERE code = 'SYSTEM'),(SELECT c.id FROM content c WHERE raw = 'ЭКГ-5А' AND property_id = (SELECT id from property where code = 'MANUFACTURER_MODEL')AND NOT EXISTS(SELECT NULL FROM redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content ( redactor_id, content_id) VALUES
((SELECT id FROM redactor WHERE code = 'SYSTEM'),(SELECT c.id FROM content c WHERE raw = 'ЭКГ-9УС' AND property_id = (SELECT id from property where code = 'MANUFACTURER_MODEL')AND NOT EXISTS(SELECT NULL FROM redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content ( redactor_id, content_id) VALUES
((SELECT id FROM redactor WHERE code = 'SYSTEM'),(SELECT c.id FROM content c WHERE raw = 'ЭКГ-12' AND property_id = (SELECT id from property where code = 'MANUFACTURER_MODEL')AND NOT EXISTS(SELECT NULL FROM redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content ( redactor_id, content_id) VALUES
((SELECT id FROM redactor WHERE code = 'SYSTEM'),(SELECT c.id FROM content c WHERE raw = 'ЭКГ-20А' AND property_id = (SELECT id from property where code = 'MANUFACTURER_MODEL')AND NOT EXISTS(SELECT NULL FROM redactor_content WHERE content_id = c.id)LIMIT 1));

INSERT INTO redactor_content ( redactor_id, content_id) VALUES
((SELECT id FROM redactor WHERE code = 'SYSTEM'),(SELECT c.id FROM content c WHERE raw = 'Донэкс' AND property_id = (SELECT id from property where code = 'TRADE_MARK')AND NOT EXISTS(SELECT NULL FROM redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content ( redactor_id, content_id) VALUES
((SELECT id FROM redactor WHERE code = 'SYSTEM'),(SELECT c.id FROM content c WHERE raw = 'Уралмаш' AND property_id = (SELECT id from property where code = 'TRADE_MARK')AND NOT EXISTS(SELECT NULL FROM redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content ( redactor_id, content_id) VALUES
((SELECT id FROM redactor WHERE code = 'SYSTEM'),(SELECT c.id FROM content c WHERE raw = 'Уралмаш' AND property_id = (SELECT id from property where code = 'TRADE_MARK')AND NOT EXISTS(SELECT NULL FROM redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content ( redactor_id, content_id) VALUES
((SELECT id FROM redactor WHERE code = 'SYSTEM'),(SELECT c.id FROM content c WHERE raw = 'Уралмаш' AND property_id = (SELECT id from property where code = 'TRADE_MARK')AND NOT EXISTS(SELECT NULL FROM redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content ( redactor_id, content_id) VALUES
((SELECT id FROM redactor WHERE code = 'SYSTEM'),(SELECT c.id FROM content c WHERE raw = 'Уралмаш' AND property_id = (SELECT id from property where code = 'TRADE_MARK')AND NOT EXISTS(SELECT NULL FROM redactor_content WHERE content_id = c.id)LIMIT 1));

INSERT INTO redactor_content ( redactor_id, content_id) VALUES
((SELECT id FROM redactor WHERE code = 'SYSTEM'),(SELECT c.id from content c WHERE raw = '0.75' AND property_id = (SELECT id from property where code = 'BUCKET_CAPACITY_M3') AND NOT EXISTS (SELECT NULL from redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content ( redactor_id, content_id) VALUES
((SELECT id FROM redactor WHERE code = 'SYSTEM'),(SELECT c.id from content c WHERE raw = '5.2' AND property_id = (SELECT id from property where code = 'BUCKET_CAPACITY_M3') AND NOT EXISTS (SELECT NULL from redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content ( redactor_id, content_id) VALUES
((SELECT id FROM redactor WHERE code = 'SYSTEM'),(SELECT c.id from content c WHERE raw = '9' AND property_id = (SELECT id from property where code = 'BUCKET_CAPACITY_M3') AND NOT EXISTS (SELECT NULL from redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content ( redactor_id, content_id) VALUES
((SELECT id FROM redactor WHERE code = 'SYSTEM'),(SELECT c.id from content c WHERE raw = '12' AND property_id = (SELECT id from property where code = 'BUCKET_CAPACITY_M3') AND NOT EXISTS (SELECT NULL from redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content ( redactor_id, content_id) VALUES
((SELECT id FROM redactor WHERE code = 'SYSTEM'),(SELECT c.id from content c WHERE raw = '25' AND property_id = (SELECT id from property where code = 'BUCKET_CAPACITY_M3') AND NOT EXISTS (SELECT NULL from redactor_content WHERE content_id = c.id)LIMIT 1));

INSERT INTO redactor_content ( redactor_id, content_id) VALUES
((SELECT id FROM redactor WHERE code = 'SYSTEM'),(SELECT c.id FROM content c WHERE raw = 'BL71 Plus' AND property_id = (SELECT id from property where code = 'MANUFACTURER_MODEL')AND NOT EXISTS(SELECT NULL FROM redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content ( redactor_id, content_id) VALUES
((SELECT id FROM redactor WHERE code = 'SYSTEM'),(SELECT c.id FROM content c WHERE raw = 'ЭПМ-100' AND property_id = (SELECT id from property where code = 'MANUFACTURER_MODEL')AND NOT EXISTS(SELECT NULL FROM redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content ( redactor_id, content_id) VALUES
((SELECT id FROM redactor WHERE code = 'SYSTEM'),(SELECT c.id FROM content c WHERE raw = '432E' AND property_id = (SELECT id from property where code = 'MANUFACTURER_MODEL')AND NOT EXISTS(SELECT NULL FROM redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content ( redactor_id, content_id) VALUES
((SELECT id FROM redactor WHERE code = 'SYSTEM'),(SELECT c.id FROM content c WHERE raw = '4CX' AND property_id = (SELECT id from property where code = 'MANUFACTURER_MODEL')AND NOT EXISTS(SELECT NULL FROM redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content ( redactor_id, content_id) VALUES
((SELECT id FROM redactor WHERE code = 'SYSTEM'),(SELECT c.id FROM content c WHERE raw = '3CX Super' AND property_id = (SELECT id from property where code = 'MANUFACTURER_MODEL')AND NOT EXISTS(SELECT NULL FROM redactor_content WHERE content_id = c.id)LIMIT 1));

INSERT INTO redactor_content ( redactor_id, content_id) VALUES
((SELECT id FROM redactor WHERE code = 'SYSTEM'),(SELECT c.id FROM content c WHERE raw = 'VOLVO' AND property_id = (SELECT id from property where code = 'TRADE_MARK')AND NOT EXISTS(SELECT NULL FROM redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content ( redactor_id, content_id) VALUES
((SELECT id FROM redactor WHERE code = 'SYSTEM'),(SELECT c.id FROM content c WHERE raw = 'БЗГТ' AND property_id = (SELECT id from property where code = 'TRADE_MARK')AND NOT EXISTS(SELECT NULL FROM redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content ( redactor_id, content_id) VALUES
((SELECT id FROM redactor WHERE code = 'SYSTEM'),(SELECT c.id FROM content c WHERE raw = 'Caterpillar' AND property_id = (SELECT id from property where code = 'TRADE_MARK')AND NOT EXISTS(SELECT NULL FROM redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content ( redactor_id, content_id) VALUES
((SELECT id FROM redactor WHERE code = 'SYSTEM'),(SELECT c.id FROM content c WHERE raw = 'JCB' AND property_id = (SELECT id from property where code = 'TRADE_MARK')AND NOT EXISTS(SELECT NULL FROM redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content ( redactor_id, content_id) VALUES
((SELECT id FROM redactor WHERE code = 'SYSTEM'),(SELECT c.id FROM content c WHERE raw = 'JCB' AND property_id = (SELECT id from property where code = 'TRADE_MARK')AND NOT EXISTS(SELECT NULL FROM redactor_content WHERE content_id = c.id)LIMIT 1));


INSERT INTO redactor_content ( redactor_id, content_id) VALUES
((SELECT id FROM redactor WHERE code = 'SYSTEM'),(SELECT c.id from content c WHERE raw = '1' AND property_id = (SELECT id from property where code = 'BUCKET_CAPACITY_M3') AND NOT EXISTS (SELECT NULL from redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content ( redactor_id, content_id) VALUES
((SELECT id FROM redactor WHERE code = 'SYSTEM'),(SELECT c.id from content c WHERE raw = '0.8' AND property_id = (SELECT id from property where code = 'BUCKET_CAPACITY_M3') AND NOT EXISTS (SELECT NULL from redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content ( redactor_id, content_id) VALUES
((SELECT id FROM redactor WHERE code = 'SYSTEM'),(SELECT c.id from content c WHERE raw = '1.03' AND property_id = (SELECT id from property where code = 'BUCKET_CAPACITY_M3') AND NOT EXISTS (SELECT NULL from redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content ( redactor_id, content_id) VALUES
((SELECT id FROM redactor WHERE code = 'SYSTEM'),(SELECT c.id from content c WHERE raw = '1.1' AND property_id = (SELECT id from property where code = 'BUCKET_CAPACITY_M3') AND NOT EXISTS (SELECT NULL from redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content ( redactor_id, content_id) VALUES
((SELECT id FROM redactor WHERE code = 'SYSTEM'),(SELECT c.id from content c WHERE raw = '1' AND property_id = (SELECT id from property where code = 'BUCKET_CAPACITY_M3') AND NOT EXISTS (SELECT NULL from redactor_content WHERE content_id = c.id)LIMIT 1));

INSERT INTO redactor_content ( redactor_id, content_id) VALUES
((SELECT id FROM redactor WHERE code = 'SYSTEM'),(SELECT c.id from content c WHERE raw = '0.21' AND property_id = (SELECT id from property where code = 'SHOVEL_CAPACITY_M3') AND NOT EXISTS (SELECT NULL from redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content ( redactor_id, content_id) VALUES
((SELECT id FROM redactor WHERE code = 'SYSTEM'),(SELECT c.id from content c WHERE raw = '0.16' AND property_id = (SELECT id from property where code = 'SHOVEL_CAPACITY_M3') AND NOT EXISTS (SELECT NULL from redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content ( redactor_id, content_id) VALUES
((SELECT id FROM redactor WHERE code = 'SYSTEM'),(SELECT c.id from content c WHERE raw = '0.38' AND property_id = (SELECT id from property where code = 'SHOVEL_CAPACITY_M3') AND NOT EXISTS (SELECT NULL from redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content ( redactor_id, content_id) VALUES
((SELECT id FROM redactor WHERE code = 'SYSTEM'),(SELECT c.id from content c WHERE raw = '0.48' AND property_id = (SELECT id from property where code = 'SHOVEL_CAPACITY_M3') AND NOT EXISTS (SELECT NULL from redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content ( redactor_id, content_id) VALUES
((SELECT id FROM redactor WHERE code = 'SYSTEM'),(SELECT c.id from content c WHERE raw = '0.48' AND property_id = (SELECT id from property where code = 'SHOVEL_CAPACITY_M3') AND NOT EXISTS (SELECT NULL from redactor_content WHERE content_id = c.id)LIMIT 1));
;


INSERT INTO content
(raw, property_id)
VALUES
('3 600 000',(SELECT id from property where code = 'GOODS_ITEM_PRICE_RUB')),
('1 500 000',(SELECT id from property where code = 'GOODS_ITEM_PRICE_RUB')),
('1 702 499',(SELECT id from property where code = 'GOODS_ITEM_PRICE_RUB')),
('4 700 000',(SELECT id from property where code = 'GOODS_ITEM_PRICE_RUB')),
('3 500 000',(SELECT id from property where code = 'GOODS_ITEM_PRICE_RUB')),

('3 240 050',(SELECT id from property where code = 'GOODS_ITEM_PRICE_RUB')),
('1750000',(SELECT id from property where code = 'GOODS_ITEM_PRICE_RUB')),
('3 300 000',(SELECT id from property where code = 'GOODS_ITEM_PRICE_RUB')),
('3 800 000',(SELECT id from property where code = 'GOODS_ITEM_PRICE_RUB')),
('3 700 000',(SELECT id from property where code = 'GOODS_ITEM_PRICE_RUB')),

('2 270 000',(SELECT id from property where code = 'GOODS_ITEM_PRICE_RUB')),
('1 950 000',(SELECT id from property where code = 'GOODS_ITEM_PRICE_RUB')),
('2 200 000',(SELECT id from property where code = 'GOODS_ITEM_PRICE_RUB')),
('5 100 000',(SELECT id from property where code = 'GOODS_ITEM_PRICE_RUB')),
('3 400 000',(SELECT id from property where code = 'GOODS_ITEM_PRICE_RUB')),

('шт',(SELECT id from property where code = 'GOODS_ITEM_UNITS_OF_MEASURE')),
('шт',(SELECT id from property where code = 'GOODS_ITEM_UNITS_OF_MEASURE')),
('шт',(SELECT id from property where code = 'GOODS_ITEM_UNITS_OF_MEASURE')),
('шт',(SELECT id from property where code = 'GOODS_ITEM_UNITS_OF_MEASURE')),
('шт',(SELECT id from property where code = 'GOODS_ITEM_UNITS_OF_MEASURE')),

('шт.',(SELECT id from property where code = 'GOODS_ITEM_UNITS_OF_MEASURE')),
('шт.',(SELECT id from property where code = 'GOODS_ITEM_UNITS_OF_MEASURE')),
('шт.',(SELECT id from property where code = 'GOODS_ITEM_UNITS_OF_MEASURE')),
('шт.',(SELECT id from property where code = 'GOODS_ITEM_UNITS_OF_MEASURE')),
('шт.',(SELECT id from property where code = 'GOODS_ITEM_UNITS_OF_MEASURE')),

('р/шт',(SELECT id from property where code = 'GOODS_ITEM_UNITS_OF_MEASURE')),
('р/шт',(SELECT id from property where code = 'GOODS_ITEM_UNITS_OF_MEASURE')),
('р/шт',(SELECT id from property where code = 'GOODS_ITEM_UNITS_OF_MEASURE')),
('р/шт',(SELECT id from property where code = 'GOODS_ITEM_UNITS_OF_MEASURE')),
('р/шт',(SELECT id from property where code = 'GOODS_ITEM_UNITS_OF_MEASURE'));

--/**/--

INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'volvo-bl71-plus'),
   (SELECT c.id
    FROM content c
    WHERE raw = '3 600 000' AND property_id =
                                 (SELECT id
                                  FROM property
                                  WHERE code = 'GOODS_ITEM_PRICE_RUB')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'bzgt-epm-100'),
   (SELECT c.id
    FROM content c
    WHERE raw = '1 500 000' AND property_id =
                             (SELECT id
                              FROM property
                              WHERE code = 'GOODS_ITEM_PRICE_RUB')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'caterpillar-432e'),
   (SELECT c.id
    FROM content c
    WHERE raw = '1 702 499' AND property_id =
                              (SELECT id
                               FROM property
                               WHERE code = 'GOODS_ITEM_PRICE_RUB')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'jcb-4cx'),
   (SELECT c.id
    FROM content c
    WHERE raw = '4 700 000' AND property_id =
                             (SELECT id
                              FROM property
                              WHERE code = 'GOODS_ITEM_PRICE_RUB')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'jcb-3cx-super'),
   (SELECT c.id
    FROM content c
    WHERE raw = '3 500 000' AND property_id =
                              (SELECT id
                               FROM property
                               WHERE code = 'GOODS_ITEM_PRICE_RUB')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'volvo-bl71-plus'),
   (SELECT c.id
    FROM content c
    WHERE raw = '3 240 050' AND property_id =
                             (SELECT id
                              FROM property
                              WHERE code = 'GOODS_ITEM_PRICE_RUB')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'bzgt-epm-100'),
   (SELECT c.id
    FROM content c
    WHERE raw = '1750000' AND property_id =
                              (SELECT id
                               FROM property
                               WHERE code = 'GOODS_ITEM_PRICE_RUB')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'caterpillar-432e'),
   (SELECT c.id
    FROM content c
    WHERE raw = '3 300 000' AND property_id =
                              (SELECT id
                               FROM property
                               WHERE code = 'GOODS_ITEM_PRICE_RUB')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'jcb-4cx'),
   (SELECT c.id
    FROM content c
    WHERE raw = '3 800 000' AND property_id =
                              (SELECT id
                               FROM property
                               WHERE code = 'GOODS_ITEM_PRICE_RUB')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'jcb-3cx-super'),

   (SELECT c.id
    FROM content c
    WHERE raw = '3 700 000' AND property_id =
                              (SELECT id
                               FROM property
                               WHERE code = 'GOODS_ITEM_PRICE_RUB')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES

  ((SELECT id
    FROM item
    WHERE code = 'volvo-bl71-plus'),
   (SELECT c.id
    FROM content c
    WHERE raw = '2 270 000' AND property_id =
                           (SELECT id
                            FROM property
                            WHERE code = 'GOODS_ITEM_PRICE_RUB')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'bzgt-epm-100'),
   (SELECT c.id
    FROM content c
    WHERE raw = '1 950 000' AND property_id =
                          (SELECT id
                           FROM property
                           WHERE code = 'GOODS_ITEM_PRICE_RUB')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'caterpillar-432e'),
   (SELECT c.id
    FROM content c
    WHERE raw = '2 200 000' AND property_id =
                        (SELECT id
                         FROM property
                         WHERE code = 'GOODS_ITEM_PRICE_RUB')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'jcb-4cx'),
   (SELECT c.id FROM content c WHERE raw = '3 400 000'
          AND property_id = (SELECT id FROM property WHERE code = 'GOODS_ITEM_PRICE_RUB')
          AND NOT EXISTS(SELECT NULL FROM item_content WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'jcb-3cx-super'),
   (SELECT c.id
    FROM content c
    WHERE raw = '5 100 000' AND property_id =
                         (SELECT id
                          FROM property
                          WHERE code = 'GOODS_ITEM_PRICE_RUB')
          AND NOT EXISTS(SELECT NULL FROM item_content WHERE content_id = c.id) LIMIT 1));

INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'volvo-bl71-plus'),
   (SELECT c.id
    FROM content c
    WHERE raw = 'шт' AND property_id =
                           (SELECT id
                            FROM property
                            WHERE code = 'GOODS_ITEM_UNITS_OF_MEASURE')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'bzgt-epm-100'),
   (SELECT c.id
    FROM content c
    WHERE raw = 'шт' AND property_id =
                          (SELECT id
                           FROM property
                           WHERE code = 'GOODS_ITEM_UNITS_OF_MEASURE')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'caterpillar-432e'),
   (SELECT c.id
    FROM content c
    WHERE raw = 'шт' AND property_id =
                        (SELECT id
                         FROM property
                         WHERE code = 'GOODS_ITEM_UNITS_OF_MEASURE')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'jcb-4cx'),
   (SELECT c.id FROM content c WHERE raw = 'шт'
          AND property_id = (SELECT id FROM property WHERE code = 'GOODS_ITEM_UNITS_OF_MEASURE')
          AND NOT EXISTS(SELECT NULL FROM item_content WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'jcb-3cx-super'),
   (SELECT c.id
    FROM content c
    WHERE raw = 'шт' AND property_id =
                         (SELECT id
                          FROM property
                          WHERE code = 'GOODS_ITEM_UNITS_OF_MEASURE')
          AND NOT EXISTS(SELECT NULL FROM item_content WHERE content_id = c.id) LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES

  ((SELECT id
    FROM item
    WHERE code = 'volvo-bl71-plus'),
   (SELECT c.id
    FROM content c
    WHERE raw = 'шт.' AND property_id =
                           (SELECT id
                            FROM property
                            WHERE code = 'GOODS_ITEM_UNITS_OF_MEASURE')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'bzgt-epm-100'),
   (SELECT c.id
    FROM content c
    WHERE raw = 'шт.' AND property_id =
                          (SELECT id
                           FROM property
                           WHERE code = 'GOODS_ITEM_UNITS_OF_MEASURE')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'caterpillar-432e'),
   (SELECT c.id
    FROM content c
    WHERE raw = 'шт.' AND property_id =
                        (SELECT id
                         FROM property
                         WHERE code = 'GOODS_ITEM_UNITS_OF_MEASURE')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'jcb-4cx'),
   (SELECT c.id FROM content c WHERE raw = 'шт.'
          AND property_id = (SELECT id FROM property WHERE code = 'GOODS_ITEM_UNITS_OF_MEASURE')
          AND NOT EXISTS(SELECT NULL FROM item_content WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'jcb-3cx-super'),
   (SELECT c.id
    FROM content c
    WHERE raw = 'шт.' AND property_id =
                         (SELECT id
                          FROM property
                          WHERE code = 'GOODS_ITEM_UNITS_OF_MEASURE')
          AND NOT EXISTS(SELECT NULL FROM item_content WHERE content_id = c.id) LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES

  ((SELECT id
    FROM item
    WHERE code = 'volvo-bl71-plus'),
   (SELECT c.id
    FROM content c
    WHERE raw = 'р/шт' AND property_id =
                           (SELECT id
                            FROM property
                            WHERE code = 'GOODS_ITEM_UNITS_OF_MEASURE')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'bzgt-epm-100'),
   (SELECT c.id
    FROM content c
    WHERE raw = 'р/шт' AND property_id =
                          (SELECT id
                           FROM property
                           WHERE code = 'GOODS_ITEM_UNITS_OF_MEASURE')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'caterpillar-432e'),
   (SELECT c.id
    FROM content c
    WHERE raw = 'р/шт' AND property_id =
                        (SELECT id
                         FROM property
                         WHERE code = 'GOODS_ITEM_UNITS_OF_MEASURE')
          AND NOT EXISTS(SELECT NULL
                         FROM item_content
                         WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'jcb-4cx'),
   (SELECT c.id FROM content c WHERE raw = 'р/шт'
          AND property_id = (SELECT id FROM property WHERE code = 'GOODS_ITEM_UNITS_OF_MEASURE')
          AND NOT EXISTS(SELECT NULL FROM item_content WHERE content_id = c.id)
    LIMIT 1));
INSERT INTO item_content
(item_id, content_id)
VALUES
  ((SELECT id
    FROM item
    WHERE code = 'jcb-3cx-super'),
   (SELECT c.id
    FROM content c
    WHERE raw = 'р/шт' AND property_id =
                         (SELECT id
                          FROM property
                          WHERE code = 'GOODS_ITEM_UNITS_OF_MEASURE')
          AND NOT EXISTS(SELECT NULL FROM item_content WHERE content_id = c.id) LIMIT 1));

INSERT INTO digital_matter (digital, content_id) VALUES
(3600000,(SELECT c.id from content c WHERE raw = '3 600 000' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_PRICE_RUB') AND NOT EXISTS (SELECT NULL from digital_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO digital_matter (digital, content_id) VALUES
(1500000,(SELECT c.id from content c WHERE raw = '1 500 000' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_PRICE_RUB') AND NOT EXISTS (SELECT NULL from digital_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO digital_matter (digital, content_id) VALUES
(1702499,(SELECT c.id from content c WHERE raw = '1 702 499' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_PRICE_RUB') AND NOT EXISTS (SELECT NULL from digital_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO digital_matter (digital, content_id) VALUES
(4700000,(SELECT c.id from content c WHERE raw = '4 700 000' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_PRICE_RUB') AND NOT EXISTS (SELECT NULL from digital_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO digital_matter (digital, content_id) VALUES
(3500000,(SELECT c.id from content c WHERE raw = '3 500 000' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_PRICE_RUB') AND NOT EXISTS (SELECT NULL from digital_matter WHERE content_id = c.id)LIMIT 1));

INSERT INTO digital_matter (digital, content_id) VALUES
(3240050,(SELECT c.id from content c WHERE raw = '3 240 050' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_PRICE_RUB') AND NOT EXISTS (SELECT NULL from digital_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO digital_matter (digital, content_id) VALUES
(1750000,(SELECT c.id from content c WHERE raw = '1750000' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_PRICE_RUB') AND NOT EXISTS (SELECT NULL from digital_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO digital_matter (digital, content_id) VALUES
(3300000,(SELECT c.id from content c WHERE raw = '3 300 000' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_PRICE_RUB') AND NOT EXISTS (SELECT NULL from digital_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO digital_matter (digital, content_id) VALUES
(3800000,(SELECT c.id from content c WHERE raw = '3 800 000' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_PRICE_RUB') AND NOT EXISTS (SELECT NULL from digital_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO digital_matter (digital, content_id) VALUES
(3700000,(SELECT c.id from content c WHERE raw = '3 700 000' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_PRICE_RUB') AND NOT EXISTS (SELECT NULL from digital_matter WHERE content_id = c.id)LIMIT 1));

INSERT INTO digital_matter (digital, content_id) VALUES
(2270000,(SELECT c.id from content c WHERE raw = '2 270 000' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_PRICE_RUB') AND NOT EXISTS (SELECT NULL from digital_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO digital_matter (digital, content_id) VALUES
(1950000,(SELECT c.id from content c WHERE raw = '1 950 000' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_PRICE_RUB') AND NOT EXISTS (SELECT NULL from digital_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO digital_matter (digital, content_id) VALUES
(2200000,(SELECT c.id from content c WHERE raw = '2 200 000' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_PRICE_RUB') AND NOT EXISTS (SELECT NULL from digital_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO digital_matter (digital, content_id) VALUES
(5100000,(SELECT c.id from content c WHERE raw = '5 100 000' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_PRICE_RUB') AND NOT EXISTS (SELECT NULL from digital_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO digital_matter (digital, content_id) VALUES
(3400000,(SELECT c.id from content c WHERE raw = '3 400 000' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_PRICE_RUB') AND NOT EXISTS (SELECT NULL from digital_matter WHERE content_id = c.id)LIMIT 1));

INSERT INTO string_matter (string, content_id) VALUES
('шт',(SELECT c.id from content c WHERE raw = 'шт' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_UNITS_OF_MEASURE') AND NOT EXISTS (SELECT NULL from string_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO string_matter (string, content_id) VALUES
('шт',(SELECT c.id from content c WHERE raw = 'шт' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_UNITS_OF_MEASURE') AND NOT EXISTS (SELECT NULL from string_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO string_matter (string, content_id) VALUES
('шт',(SELECT c.id from content c WHERE raw = 'шт' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_UNITS_OF_MEASURE') AND NOT EXISTS (SELECT NULL from string_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO string_matter (string, content_id) VALUES
('шт',(SELECT c.id from content c WHERE raw = 'шт' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_UNITS_OF_MEASURE') AND NOT EXISTS (SELECT NULL from string_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO string_matter (string, content_id) VALUES
('шт',(SELECT c.id from content c WHERE raw = 'шт' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_UNITS_OF_MEASURE') AND NOT EXISTS (SELECT NULL from string_matter WHERE content_id = c.id)LIMIT 1));

INSERT INTO string_matter (string, content_id) VALUES
('шт.',(SELECT c.id from content c WHERE raw = 'шт.' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_UNITS_OF_MEASURE') AND NOT EXISTS (SELECT NULL from string_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO string_matter (string, content_id) VALUES
('шт.',(SELECT c.id from content c WHERE raw = 'шт.' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_UNITS_OF_MEASURE') AND NOT EXISTS (SELECT NULL from string_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO string_matter (string, content_id) VALUES
('шт.',(SELECT c.id from content c WHERE raw = 'шт.' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_UNITS_OF_MEASURE') AND NOT EXISTS (SELECT NULL from string_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO string_matter (string, content_id) VALUES
('шт.',(SELECT c.id from content c WHERE raw = 'шт.' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_UNITS_OF_MEASURE') AND NOT EXISTS (SELECT NULL from string_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO string_matter (string, content_id) VALUES
('шт.',(SELECT c.id from content c WHERE raw = 'шт.' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_UNITS_OF_MEASURE') AND NOT EXISTS (SELECT NULL from string_matter WHERE content_id = c.id)LIMIT 1));

INSERT INTO string_matter (string, content_id) VALUES
('р/шт',(SELECT c.id from content c WHERE raw = 'р/шт' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_UNITS_OF_MEASURE') AND NOT EXISTS (SELECT NULL from string_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO string_matter (string, content_id) VALUES
('р/шт',(SELECT c.id from content c WHERE raw = 'р/шт' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_UNITS_OF_MEASURE') AND NOT EXISTS (SELECT NULL from string_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO string_matter (string, content_id) VALUES
('р/шт',(SELECT c.id from content c WHERE raw = 'р/шт' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_UNITS_OF_MEASURE') AND NOT EXISTS (SELECT NULL from string_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO string_matter (string, content_id) VALUES
('р/шт',(SELECT c.id from content c WHERE raw = 'р/шт' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_UNITS_OF_MEASURE') AND NOT EXISTS (SELECT NULL from string_matter WHERE content_id = c.id)LIMIT 1));
INSERT INTO string_matter (string, content_id) VALUES
('р/шт',(SELECT c.id from content c WHERE raw = 'р/шт' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_UNITS_OF_MEASURE') AND NOT EXISTS (SELECT NULL from string_matter WHERE content_id = c.id)LIMIT 1));


INSERT INTO redactor_content (redactor_id, content_id) VALUES
((SELECT id from redactor where code = 'petya@gmail.com'),
 (SELECT c.id from content c WHERE raw = '3 600 000' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_PRICE_RUB') AND NOT EXISTS (SELECT NULL from redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content (redactor_id, content_id) VALUES
((SELECT id from redactor where code = 'petya@gmail.com'),
 (SELECT c.id from content c WHERE raw = '1 500 000' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_PRICE_RUB') AND NOT EXISTS (SELECT NULL from redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content (redactor_id, content_id) VALUES
((SELECT id from redactor where code = 'petya@gmail.com'),
 (SELECT c.id from content c WHERE raw = '1 702 499' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_PRICE_RUB') AND NOT EXISTS (SELECT NULL from redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content (redactor_id, content_id) VALUES
((SELECT id from redactor where code = 'petya@gmail.com'),
 (SELECT c.id from content c WHERE raw = '4 700 000' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_PRICE_RUB') AND NOT EXISTS (SELECT NULL from redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content (redactor_id, content_id) VALUES
((SELECT id from redactor where code = 'petya@gmail.com'),
 (SELECT c.id from content c WHERE raw = '3 500 000' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_PRICE_RUB') AND NOT EXISTS (SELECT NULL from redactor_content WHERE content_id = c.id)LIMIT 1));

INSERT INTO redactor_content (redactor_id, content_id) VALUES
((SELECT id from redactor where code = 'vasya@mail.ru'),
 (SELECT c.id from content c WHERE raw = '3 240 050' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_PRICE_RUB') AND NOT EXISTS (SELECT NULL from redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content (redactor_id, content_id) VALUES
((SELECT id from redactor where code = 'vasya@mail.ru'),
 (SELECT c.id from content c WHERE raw = '1750000' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_PRICE_RUB') AND NOT EXISTS (SELECT NULL from redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content (redactor_id, content_id) VALUES
((SELECT id from redactor where code = 'vasya@mail.ru'),
 (SELECT c.id from content c WHERE raw = '3 300 000' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_PRICE_RUB') AND NOT EXISTS (SELECT NULL from redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content (redactor_id, content_id) VALUES
((SELECT id from redactor where code = 'vasya@mail.ru'),
 (SELECT c.id from content c WHERE raw = '3 800 000' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_PRICE_RUB') AND NOT EXISTS (SELECT NULL from redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content (redactor_id, content_id) VALUES
((SELECT id from redactor where code = 'vasya@mail.ru'),
 (SELECT c.id from content c WHERE raw = '3 700 000' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_PRICE_RUB') AND NOT EXISTS (SELECT NULL from redactor_content WHERE content_id = c.id)LIMIT 1));

INSERT INTO redactor_content (redactor_id, content_id) VALUES
((SELECT id from redactor where code = 'oleg@yandex.ru'),
 (SELECT c.id from content c WHERE raw = '2 270 000' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_PRICE_RUB') AND NOT EXISTS (SELECT NULL from redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content (redactor_id, content_id) VALUES
((SELECT id from redactor where code = 'oleg@yandex.ru'),
 (SELECT c.id from content c WHERE raw = '1 950 000' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_PRICE_RUB') AND NOT EXISTS (SELECT NULL from redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content (redactor_id, content_id) VALUES
((SELECT id from redactor where code = 'oleg@yandex.ru'),
 (SELECT c.id from content c WHERE raw = '2 200 000' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_PRICE_RUB') AND NOT EXISTS (SELECT NULL from redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content (redactor_id, content_id) VALUES
((SELECT id from redactor where code = 'oleg@yandex.ru'),
 (SELECT c.id from content c WHERE raw = '5 100 000' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_PRICE_RUB') AND NOT EXISTS (SELECT NULL from redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content (redactor_id, content_id) VALUES
((SELECT id from redactor where code = 'oleg@yandex.ru'),
 (SELECT c.id from content c WHERE raw = '3 400 000' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_PRICE_RUB') AND NOT EXISTS (SELECT NULL from redactor_content WHERE content_id = c.id)LIMIT 1));

INSERT INTO redactor_content (redactor_id, content_id) VALUES
((SELECT id from redactor where code = 'petya@gmail.com')
  ,(SELECT c.id from content c WHERE raw = 'шт' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_UNITS_OF_MEASURE') AND NOT EXISTS (SELECT NULL from redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content (redactor_id, content_id) VALUES
((SELECT id from redactor where code = 'petya@gmail.com'),
 (SELECT c.id from content c WHERE raw = 'шт' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_UNITS_OF_MEASURE') AND NOT EXISTS (SELECT NULL from redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content (redactor_id, content_id) VALUES
((SELECT id from redactor where code = 'petya@gmail.com'),
 (SELECT c.id from content c WHERE raw = 'шт' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_UNITS_OF_MEASURE') AND NOT EXISTS (SELECT NULL from redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content (redactor_id, content_id) VALUES
((SELECT id from redactor where code = 'petya@gmail.com'),
 (SELECT c.id from content c WHERE raw = 'шт' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_UNITS_OF_MEASURE') AND NOT EXISTS (SELECT NULL from redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content (redactor_id, content_id) VALUES
((SELECT id from redactor where code = 'petya@gmail.com'),
 (SELECT c.id from content c WHERE raw = 'шт' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_UNITS_OF_MEASURE') AND NOT EXISTS (SELECT NULL from redactor_content WHERE content_id = c.id)LIMIT 1));

INSERT INTO redactor_content (redactor_id, content_id) VALUES
((SELECT id from redactor where code = 'vasya@mail.ru'),
 (SELECT c.id from content c WHERE raw = 'шт.' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_UNITS_OF_MEASURE') AND NOT EXISTS (SELECT NULL from redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content (redactor_id, content_id) VALUES
((SELECT id from redactor where code = 'vasya@mail.ru'),
 (SELECT c.id from content c WHERE raw = 'шт.' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_UNITS_OF_MEASURE') AND NOT EXISTS (SELECT NULL from redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content (redactor_id, content_id) VALUES
((SELECT id from redactor where code = 'vasya@mail.ru'),
 (SELECT c.id from content c WHERE raw = 'шт.' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_UNITS_OF_MEASURE') AND NOT EXISTS (SELECT NULL from redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content (redactor_id, content_id) VALUES
((SELECT id from redactor where code = 'vasya@mail.ru'),
 (SELECT c.id from content c WHERE raw = 'шт.' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_UNITS_OF_MEASURE') AND NOT EXISTS (SELECT NULL from redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content (redactor_id, content_id) VALUES
((SELECT id from redactor where code = 'vasya@mail.ru'),
 (SELECT c.id from content c WHERE raw = 'шт.' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_UNITS_OF_MEASURE') AND NOT EXISTS (SELECT NULL from redactor_content WHERE content_id = c.id)LIMIT 1));

INSERT INTO redactor_content (redactor_id, content_id) VALUES
((SELECT id from redactor where code = 'oleg@yandex.ru'),
 (SELECT c.id from content c WHERE raw = 'р/шт' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_UNITS_OF_MEASURE') AND NOT EXISTS (SELECT NULL from redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content (redactor_id, content_id) VALUES
((SELECT id from redactor where code = 'oleg@yandex.ru'),
 (SELECT c.id from content c WHERE raw = 'р/шт' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_UNITS_OF_MEASURE') AND NOT EXISTS (SELECT NULL from redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content (redactor_id, content_id) VALUES
((SELECT id from redactor where code = 'oleg@yandex.ru'),
 (SELECT c.id from content c WHERE raw = 'р/шт' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_UNITS_OF_MEASURE') AND NOT EXISTS (SELECT NULL from redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content (redactor_id, content_id) VALUES
((SELECT id from redactor where code = 'oleg@yandex.ru'),
 (SELECT c.id from content c WHERE raw = 'р/шт' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_UNITS_OF_MEASURE') AND NOT EXISTS (SELECT NULL from redactor_content WHERE content_id = c.id)LIMIT 1));
INSERT INTO redactor_content (redactor_id, content_id) VALUES
((SELECT id from redactor where code = 'oleg@yandex.ru'),
 (SELECT c.id from content c WHERE raw = 'р/шт' AND property_id = (SELECT id from property where code = 'GOODS_ITEM_UNITS_OF_MEASURE') AND NOT EXISTS (SELECT NULL from redactor_content WHERE content_id = c.id)LIMIT 1));
