CREATE TABLE SCHEMA_VERSION (
  MODEL_NAME varchar(255),
  VERSION_NUMBER smallint NOT NULL,
  VERSION_TITLE varchar(255),
  INSTALL_DATE timestamp
);

CREATE TABLE  EO_PK_TABLE (
  NAME char(40),
  PK int
);