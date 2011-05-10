CREATE DATABASE RujelUsers DEFAULT CHARACTER SET utf8;
USE RujelUsers;

CREATE TABLE SCHEMA_VERSION (
  MODEL_NAME varchar(255),
  VERSION_NUMBER smallint unsigned NOT NULL,
  VERSION_TITLE varchar(255),
  INSTALL_DATE timestamp
);

INSERT INTO SCHEMA_VERSION (MODEL_NAME,VERSION_NUMBER,VERSION_TITLE)
  VALUES ('RujelUsers',1,'0.9');

CREATE TABLE AUT_USER (
  U_ID mediumint NOT NULL,
  USER_NAME varchar(28) NOT NULL,
  CREDENTIAL_STRING varchar(255),
  PERSON_ID int,
  PERS_ENTITY smallint,
  PRIMARY KEY (U_ID)
) ENGINE=InnoDB;

CREATE TABLE AUT_GROUP (
  G_ID smallint NOT NULL,
  GROUP_TITLE varchar(28) NOT NULL,
  SECTION_NUM smallint,
  EXTERNAL_EQUIVALENT varchar(255),
  PRIMARY KEY (G_ID)
) ENGINE=InnoDB;

CREATE TABLE AUT_MEMBER (
  USER_ID mediumint NOT NULL,
  GROUP_ID smallint NOT NULL,
  PRIMARY KEY (USER_ID,GROUP_ID)
) ENGINE=InnoDB;

CREATE TABLE AUT_USER_PROPERTIES (
  P_ID mediumint NOT NULL,
  USER_ID mediumint NOT NULL,
  PROP_KEY varchar(28) NOT NULL,
  PROP_VALUE varchar(255) NOT NULL,
  PRIMARY KEY (P_ID)
) ENGINE=InnoDB;

CREATE TABLE  EO_PK_TABLE (
  NAME char(40),
  PK int
) ENGINE=InnoDB;