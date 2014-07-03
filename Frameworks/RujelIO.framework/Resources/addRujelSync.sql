-- Creation script for RujelSync model --

CREATE DATABASE `RujelSync` DEFAULT CHARACTER SET utf8;
USE `RujelSync`;

CREATE TABLE IF NOT EXISTS SYNC_EXT_SYSTEM (
  S_ID smallint NOT NULL,
  PRODUCT_NAME varchar(255),
  SYSTEM_DESCRIPTION text,
  PRIMARY KEY (S_ID)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS SYNC_EXT_BASE (
  B_ID smallint NOT NULL,
  SYSTEM_ID smallint NOT NULL,
  BASE_IDENTIFIER varchar(255) NOT NULL,
  BASE_TITLE varchar(255),
  PRIMARY KEY (B_ID)
) ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS SYNC_EXT_DATA (
  D_ID integer NOT NULL,
  SYSTEM_ID smallint NOT NULL,
  BASE_ID smallint,
  DATA_KEY varchar(28) NOT NULL,
  DATA_VALUE text,
  EDU_YEAR smallint,
  FOR_SECTION smallint,
  PRIMARY KEY (D_ID),
  INDEX (SYSTEM_ID, BASE_ID)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS SYNC_MATCH (
  M_ID integer NOT NULL,
  SYSTEM_ID smallint NOT NULL,
  BASE_ID smallint,
  ENTITY_ID smallint NOT NULL,
  OBJECT_ID integer NOT NULL,
  EXTERNAL_ID varchar(255),
  EDU_YEAR smallint,
  PRIMARY KEY (M_ID),
  INDEX (SYSTEM_ID, BASE_ID),
  INDEX (ENTITY_ID, OBJECT_ID)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS SYNC_INDEX (
  I_ID integer NOT NULL,
  SYSTEM_ID smallint NOT NULL,
  BASE_ID smallint,
  INDEX_NAME varchar(28) NOT NULL,
  EDU_YEAR smallint,
  PRIMARY KEY (I_ID),
  INDEX (SYSTEM_ID, BASE_ID)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS SYNC_IDX_MATCH (
  M_ID integer NOT NULL,
  INDEX_ID integer NOT NULL,
  LOCAL_VALUE varchar(255),
  EXT_VALUE varchar(255),
  PRIMARY KEY (M_ID),
  INDEX (INDEX_ID)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS SYNC_EVENT (
  E_ID integer NOT NULL,
  SYSTEM_ID smallint NOT NULL,
  BASE_ID smallint,
  EXEC_TIME DATETIME NOT NULL,
  SYNC_ENTITY varchar(28),
  EVENT_RESULT smallint NOT NULL,
  PRIMARY KEY (E_ID),
  INDEX (SYSTEM_ID, BASE_ID)
) ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS EO_PK_TABLE (
  NAME char(40),
  PK int
);

CREATE TABLE IF NOT EXISTS SCHEMA_VERSION (
  MODEL_NAME varchar(255),
  VERSION_NUMBER smallint unsigned NOT NULL,
  VERSION_TITLE varchar(255),
  INSTALL_DATE timestamp
);

INSERT INTO SCHEMA_VERSION (MODEL_NAME,VERSION_NUMBER,VERSION_TITLE)
  VALUES ('RujelSync',2,'0.9.4');
