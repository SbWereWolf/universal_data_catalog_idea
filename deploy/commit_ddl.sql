--CREATE DATABASE information_catalog;

CREATE TABLE structure_tree
(
  id              SERIAL PRIMARY KEY NOT NULL,
  structure_tree_id INTEGER,
  is_hidden       INTEGER                  DEFAULT 0,
  insert_date     TIMESTAMP WITH TIME ZONE DEFAULT now(),
  CONSTRAINT fk_structure_tree FOREIGN KEY (structure_tree_id) REFERENCES structure_tree (id)
);
CREATE INDEX ix_structure_tree_structure_tree_id_id
  ON structure_tree (structure_tree_id, id);

CREATE TABLE rubric
(
  id          SERIAL PRIMARY KEY NOT NULL,
  code        TEXT,
  title       TEXT,
  description TEXT,
  is_hidden   INTEGER                  DEFAULT 0,
  insert_date TIMESTAMP WITH TIME ZONE DEFAULT now()
);
CREATE UNIQUE INDEX ux_rubric_code
  ON rubric (code);

CREATE TABLE item
(
  id          SERIAL PRIMARY KEY NOT NULL,
  code        TEXT,
  title       TEXT,
  description TEXT,
  is_hidden   INTEGER                  DEFAULT 0,
  insert_date TIMESTAMP WITH TIME ZONE DEFAULT now()
);
CREATE UNIQUE INDEX ux_item_code
  ON item (code);

CREATE TABLE property
(
  id          SERIAL PRIMARY KEY NOT NULL,
  code        TEXT,
  title       TEXT,
  description TEXT,
  is_hidden   INTEGER                  DEFAULT 0,
  insert_date TIMESTAMP WITH TIME ZONE DEFAULT now()
);
CREATE UNIQUE INDEX ux_property_code
  ON property (code);

CREATE TABLE rubric_structure_tree
(
  id              SERIAL PRIMARY KEY NOT NULL,
  rubric_id       INTEGER            NOT NULL,
  structure_tree_id INTEGER            NOT NULL,
  insert_date     TIMESTAMP WITH TIME ZONE DEFAULT now(),
  CONSTRAINT fk_rubric_structure_tree_rubric_id FOREIGN KEY (rubric_id) REFERENCES rubric (id),
  CONSTRAINT fk_rubric_structure_tree_structure_tree_id FOREIGN KEY (structure_tree_id) REFERENCES structure_tree (id)
);
CREATE UNIQUE INDEX ux_rubric_structure_tree_rubric_id
  ON rubric_structure_tree (rubric_id);
CREATE UNIQUE INDEX ux_rubric_structure_tree_structure_tree_id
  ON rubric_structure_tree (structure_tree_id);

CREATE TABLE rubric_property
(
  id          SERIAL PRIMARY KEY NOT NULL,
  rubric_id   INTEGER            NOT NULL,
  property_id INTEGER            NOT NULL,
  insert_date TIMESTAMP WITH TIME ZONE DEFAULT now(),
  CONSTRAINT fk_rubric_property_rubric_id FOREIGN KEY (rubric_id) REFERENCES rubric (id),
  CONSTRAINT fk_rubric_property_property_id FOREIGN KEY (property_id) REFERENCES property (id)
);
CREATE UNIQUE INDEX ux_rubric_property_rubric_id
  ON rubric_property (rubric_id, property_id);
CREATE INDEX ix_rubric_property_property_id
  ON rubric_property (property_id);

CREATE TABLE rubric_item
(
  id          SERIAL PRIMARY KEY NOT NULL,
  rubric_id   INTEGER            NOT NULL,
  item_id     INTEGER            NOT NULL,
  insert_date TIMESTAMP WITH TIME ZONE DEFAULT now(),
  CONSTRAINT fk_rubric_item_rubric_id FOREIGN KEY (rubric_id) REFERENCES rubric (id),
  CONSTRAINT fk_rubric_item_item_id FOREIGN KEY (item_id) REFERENCES item (id)
);
CREATE UNIQUE INDEX ux_rubric_item_rubric_id_item_id
  ON rubric_item (rubric_id, item_id);
CREATE UNIQUE INDEX ux_rubric_item_item_id
  ON rubric_item (item_id);

CREATE TABLE content
(
  id          SERIAL PRIMARY KEY NOT NULL,
  raw         TEXT,
  property_id INTEGER            NOT NULL,
  insert_date TIMESTAMP WITH TIME ZONE DEFAULT now(),

  CONSTRAINT fk_content_property_id FOREIGN KEY (property_id) REFERENCES property (id)
);
CREATE INDEX ix_content_property_id
  ON content (property_id);

CREATE TABLE redactor
(
  id          SERIAL PRIMARY KEY NOT NULL,
  code        TEXT,
  title       TEXT,
  description TEXT,
  is_hidden   INTEGER                  DEFAULT 0,
  insert_date TIMESTAMP WITH TIME ZONE DEFAULT now()
);
CREATE UNIQUE INDEX ux_redactor_code
  ON redactor (code);

CREATE TABLE string_matter
(
  content_id  INTEGER            NOT NULL,
  id          SERIAL PRIMARY KEY NOT NULL,
  string      TEXT,
  insert_date TIMESTAMP WITH TIME ZONE DEFAULT now(),
  CONSTRAINT fk_string_matter_content_id FOREIGN KEY (content_id) REFERENCES content (id)
);
CREATE UNIQUE INDEX ux_string_matter_content_id
  ON string_matter (content_id);

CREATE TABLE digital_matter
(
  content_id  INTEGER            NOT NULL,
  id          SERIAL PRIMARY KEY NOT NULL,
  digital     DOUBLE PRECISION,
  insert_date TIMESTAMP WITH TIME ZONE DEFAULT now(),
  CONSTRAINT fk_digital_matter_content_id FOREIGN KEY (content_id) REFERENCES content (id)
);
CREATE UNIQUE INDEX ux_digital_matter_content_id
  ON digital_matter (content_id);

CREATE TABLE date_matter
(
  content_id  INTEGER            NOT NULL,
  id          SERIAL PRIMARY KEY NOT NULL,
  date_time   TIMESTAMP WITH TIME ZONE,
  insert_date TIMESTAMP WITH TIME ZONE DEFAULT now(),
  CONSTRAINT fk_date_matter_content_id FOREIGN KEY (content_id) REFERENCES content (id)
);
CREATE UNIQUE INDEX ux_date_matter_content_id
  ON date_matter (content_id);

CREATE TABLE duration_matter
(
  content_id  INTEGER            NOT NULL,
  id          SERIAL PRIMARY KEY NOT NULL,
  duration    INTERVAL,
  insert_date TIMESTAMP WITH TIME ZONE DEFAULT now(),
  CONSTRAINT fk_duration_matter_content_id FOREIGN KEY (content_id) REFERENCES content (id)
);
CREATE UNIQUE INDEX ux_duration_matter_content_id
  ON duration_matter (content_id);

CREATE TABLE tag
(
  id          SERIAL PRIMARY KEY NOT NULL,
  code        TEXT,
  title       TEXT,
  description TEXT,
  is_hidden   INTEGER                  DEFAULT 0,
  insert_date TIMESTAMP WITH TIME ZONE DEFAULT now()
);
CREATE UNIQUE INDEX ux_tag_code
  ON tag (code);

CREATE TABLE property_tag
(
  id          SERIAL PRIMARY KEY NOT NULL,
  property_id INTEGER            NOT NULL,
  tag_id   INTEGER            NOT NULL,
  insert_date TIMESTAMP WITH TIME ZONE DEFAULT now(),
  CONSTRAINT fk_property_tag_property_id FOREIGN KEY (property_id) REFERENCES property (id),
  CONSTRAINT fk_property_tag_tag_id FOREIGN KEY (tag_id) REFERENCES tag (id)
);
CREATE UNIQUE INDEX ux_property_tag_property_id_tag_id
  ON property_tag (property_id, tag_id);
CREATE INDEX ix_property_tag_tag_id
  ON property_tag (tag_id);

CREATE TABLE item_content
(
  id          SERIAL PRIMARY KEY NOT NULL,
  item_id     INTEGER            NOT NULL,
  content_id  INTEGER            NOT NULL,
  insert_date TIMESTAMP WITH TIME ZONE DEFAULT now(),
  CONSTRAINT fk_item_content_item_id FOREIGN KEY (item_id) REFERENCES item (id),
  CONSTRAINT fk_item_content_content_id FOREIGN KEY (content_id) REFERENCES content (id)
);
CREATE UNIQUE INDEX ux_item_content_item_id_content_id
  ON item_content (item_id, content_id);
CREATE UNIQUE INDEX ux_item_content_content_id
  ON item_content (content_id);

CREATE TABLE redactor_content
(
  id          SERIAL PRIMARY KEY NOT NULL,
  redactor_id INTEGER            NOT NULL,
  content_id  INTEGER            NOT NULL,
  insert_date TIMESTAMP DEFAULT now(),
  CONSTRAINT fk_redactor_content_redactor_id FOREIGN KEY (redactor_id) REFERENCES redactor (id),
  CONSTRAINT fk_redactor_content_content_id FOREIGN KEY (content_id) REFERENCES content (id)
);
CREATE UNIQUE INDEX ux_redactor_content_content_id
  ON redactor_content (content_id);
CREATE INDEX ix_redactor_content_redactor_id_content_id
  ON redactor_content (redactor_id, content_id);
