CREATE TABLE noun
(
  id          SERIAL PRIMARY KEY NOT NULL,
  word        TEXT,
  is_hidden   INTEGER                  DEFAULT 0,
  insert_date TIMESTAMP WITH TIME ZONE DEFAULT now()
);

CREATE TABLE adjective
(
  id          SERIAL PRIMARY KEY NOT NULL,
  word        TEXT,
  is_hidden   INTEGER                  DEFAULT 0,
  insert_date TIMESTAMP WITH TIME ZONE DEFAULT now()
);
