CREATE DATABASE VseLists DEFAULT CHARACTER SET utf8;
USE VseLists;

CREATE TABLE SCHEMA_VERSION (
  MODEL_NAME varchar(255),
  VERSION_NUMBER smallint unsigned NOT NULL,
  VERSION_TITLE varchar(255),
  INSTALL_DATE timestamp
);

INSERT INTO SCHEMA_VERSION (MODEL_NAME,VERSION_NUMBER,VERSION_TITLE)
  VALUES ('VseLists',1,'0.9');

CREATE TABLE VSE_EDU_GROUP (
  GR_ID mediumint NOT NULL,
  GROUP_TITLE varchar(28),
  ABS_GRADE smallint NOT NULL,
  FIRST_YEAR smallint NOT NULL,
  LAST_YEAR smallint NOT NULL,
  GR_FLAGS tinyint NOT NULL,
  SECTION_NUM smallint NOT NULL,
  SCHOOL_NUM smallint NOT NULL DEFAULT 0,
  PRIMARY KEY (GR_ID)
) ENGINE=InnoDB;

CREATE TABLE VSE_LIST (
  L_ID int NOT NULL,
  EDU_GROUP mediumint NOT NULL,
  STUDENT_ID mediumint NOT NULL,
  ENTER_DT date,
  LEAVE_DT date,
  PRIMARY KEY (L_ID)
) ENGINE=InnoDB;

CREATE TABLE VSE_PERSON (
  P_ID int NOT NULL,
  LAST_NAME varchar(28) NOT NULL,
  FIRST_NAME varchar(28),
  SECOND_NAME varchar(28),
  SEX_FLAG bit NOT NULL,
  BIRTH_DATE date,
  PRIMARY KEY (P_ID)
) ENGINE=InnoDB;

CREATE TABLE VSE_STUDENT (
  S_ID mediumint NOT NULL,
  PERSON_ID int,
  ENTER_DT date,
  LEAVE_DT date,
  LICHN_DELO varchar(28),
  ABS_GRADE smallint NOT NULL,
  SCHOOL_NUM smallint NOT NULL DEFAULT 0,
  PRIMARY KEY (S_ID)
) ENGINE=InnoDB;

CREATE TABLE VSE_TEACHER (
  T_ID mediumint NOT NULL,
  PERSON_ID int,
  ENTER_DT date,
  LEAVE_DT date,
  LICHN_DELO varchar(28),
  JOB_POSITION varchar(255),
  SCHOOL_NUM smallint NOT NULL DEFAULT 0,
  PRIMARY KEY (T_ID)
) ENGINE=InnoDB;

CREATE TABLE VSE_TUTOR (
  T_ID mediumint NOT NULL,
  EDU_GROUP mediumint NOT NULL,
  TEACHER_ID mediumint NOT NULL,
  ENTER_DT date,
  LEAVE_DT date,
  STATUS_ID SMALLINT NOT NULL DEFAULT 0,
  PRIMARY KEY (T_ID)
) ENGINE=InnoDB;

CREATE TABLE  EO_PK_TABLE (
  NAME char(40),
  PK int
) ENGINE=InnoDB;