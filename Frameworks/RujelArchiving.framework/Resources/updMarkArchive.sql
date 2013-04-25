-- Schema updates for MarkArchive model --

-- v1 (0.9.1) --

ALTER TABLE MA_MARK_ARCHIVE
  ADD COLUMN ACTION_TYPE tinyint NOT NULL DEFAULT 0;

CREATE TABLE IF NOT EXISTS SCHEMA_VERSION (
  MODEL_NAME varchar(255),
  VERSION_NUMBER smallint unsigned NOT NULL,
  VERSION_TITLE varchar(255),
  INSTALL_DATE timestamp
);

INSERT INTO SCHEMA_VERSION (MODEL_NAME,VERSION_NUMBER,VERSION_TITLE)
  VALUES ('MarkArchive',1,'0.9.1');

-- v2 (0.9.4) --

CREATE INDEX ind1 ON MA_MARK_ARCHIVE(KEY2_VALUE, KEY1_VALUE);
ALTER TABLE MA_MARK_ARCHIVE ADD INDEX (OBJ_ENTITY);

INSERT INTO SCHEMA_VERSION (MODEL_NAME,VERSION_NUMBER,VERSION_TITLE)
  VALUES ('MarkArchive',2,'0.9.4');

-- v3 (0.9.7) --

ALTER TABLE MA_MARK_ARCHIVE ADD INDEX (CHANGE_TIME);
ALTER TABLE MA_MARK_ARCHIVE ADD INDEX (ACTION_TYPE);

INSERT INTO SCHEMA_VERSION (MODEL_NAME,VERSION_NUMBER,VERSION_TITLE)
  VALUES ('MarkArchive',3,'0.9.7');
