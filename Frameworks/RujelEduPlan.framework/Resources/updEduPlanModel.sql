-- Schema updates for EduPlanModel model --

-- v1 (0.9) --

CREATE TABLE IF NOT EXISTS SCHEMA_VERSION (
  MODEL_NAME varchar(255),
  VERSION_NUMBER smallint unsigned NOT NULL,
  VERSION_TITLE varchar(255),
  INSTALL_DATE timestamp
);

ALTER TABLE PL_CYCLE
  CHANGE COLUMN `LEVEL_EDU` `EDU_SECTION` SMALLINT NOT NULL;

ALTER TABLE PL_SUBJECT
  ADD COLUMN `SPEC_FLAGS` SMALLINT NOT NULL DEFAULT 0;

CREATE TABLE IF NOT EXISTS SCHEMA_VERSION (
  MODEL_NAME varchar(255),
  VERSION_NUMBER smallint unsigned NOT NULL,
  VERSION_TITLE varchar(255),
  INSTALL_DATE timestamp
);

INSERT INTO SCHEMA_VERSION (MODEL_NAME,VERSION_NUMBER,VERSION_TITLE)
  VALUES ('EduPlanModel',1,'0.9');
