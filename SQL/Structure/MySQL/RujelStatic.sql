CREATE DATABASE RujelStatic DEFAULT CHARACTER SET utf8;
USE RujelStatic;

CREATE TABLE BASE_EDU_CYCLE (
  C_ID smallint NOT NULL,
  GRADE_NUM tinyint,
  SUBJECT_NAME varchar(28),
  SUB_GROUPS tinyint NOT NULL,
  PRIMARY KEY (C_ID)
) ENGINE=InnoDB;

CREATE TABLE BASE_ENTITYS (
  E_ID smallint NOT NULL,
  ENTITY_NAME varchar(28) NOT NULL,
  SQL_TABLE varchar(255),
  PRIMARY KEY (E_ID)
) ENGINE=InnoDB;

CREATE TABLE BASE_ST_TEXT_STORE (
  T_ID int NOT NULL,
  FROM_ENTITY smallint NOT NULL,
  STORED_TEXT text NOT NULL,
  PRIMARY KEY (T_ID)
) ENGINE=InnoDB;

CREATE TABLE ITOG_COMMENT (
  ITOG_CONTAINER smallint NOT NULL,
  EDU_CYCLE smallint NOT NULL,
  STUDENT_ID int NOT NULL,
  COMMENT_TEXT text NOT NULL,
  PRIMARY KEY (ITOG_CONTAINER,EDU_CYCLE,STUDENT_ID)
) ENGINE=InnoDB;

CREATE TABLE ITOG_CONTAINER (
  I_ID smallint NOT NULL,
  ITOG_TYPE smallint NOT NULL,
  ORDER_NUM tinyint,
  EDU_YEAR smallint NOT NULL,
  PRIMARY KEY (I_ID)
) ENGINE=InnoDB;

CREATE TABLE ITOG_MARK (
  ITOG_CONTAINER smallint NOT NULL,
  EDU_CYCLE smallint NOT NULL,
  STUDENT_ID int NOT NULL,
  MARK_TITLE varchar(5) NOT NULL,
  SUCCESS_VALUE decimal(5,4),
  ITOG_FLAGS tinyint NOT NULL,
  PRIMARY KEY (ITOG_CONTAINER,EDU_CYCLE,STUDENT_ID)
) ENGINE=InnoDB;

CREATE TABLE ITOG_TYPE (
  T_ID smallint NOT NULL,
  SHORT_TITLE varchar(5),
  TYPE_NAME varchar(28),
  IN_YEAR_COUNT tinyint NOT NULL,
  SORT_NUM smallint NOT NULL,
  PRIMARY KEY (T_ID)
) ENGINE=InnoDB;

CREATE TABLE ITOG_TYPE_LIST (
  TL_ID mediumint NOT NULL,
  LIST_NAME varchar(28) NOT NULL,
  ITOG_TYPE smallint NOT NULL,
  PRIMARY KEY (TL_ID)
) ENGINE=InnoDB;

CREATE TABLE PL_CYCLE (
  C_ID smallint NOT NULL,
  GRADE_NUM tinyint NOT NULL,
  SUBJECT_ID smallint NOT NULL,
  SCHOOL_NUM smallint NOT NULL,
  LEVEL_EDU smallint NOT NULL,
  PRIMARY KEY (C_ID)
) ENGINE=InnoDB;

CREATE TABLE PL_HOLIDAY_TYPE (
  HT_ID smallint NOT NULL,
  HOLIDAY_NAME varchar(28) NOT NULL,
  BEGIN_MONTH tinyint NOT NULL,
  BEGIN_DAY tinyint NOT NULL,
  END_MONTH tinyint NOT NULL,
  END_DAY tinyint NOT NULL,
  PRIMARY KEY (HT_ID)
) ENGINE=InnoDB;

CREATE TABLE PL_SUBJECT (
  S_ID smallint NOT NULL,
  AREA_ID smallint NOT NULL,
  SORT_NUM smallint NOT NULL,
  SHORT_NAME varchar(28) NOT NULL,
  FULL_NAME varchar(255),
  SUB_GROUPS tinyint NOT NULL,
  NORMAL_GROUP tinyint NOT NULL,
  PRIMARY KEY (S_ID)
) ENGINE=InnoDB;

CREATE TABLE PL_SUBJ_AREA (
  A_ID smallint NOT NULL,
  AREA_NAME varchar(28) NOT NULL,
  SORT_NUM smallint NOT NULL,
  PRIMARY KEY (A_ID)
) ENGINE=InnoDB;

CREATE TABLE PRT_ACHIEVEMENT (
  A_ID int NOT NULL,
  EVENT_ID mediumint NOT NULL,
  STUDENT_ID int NOT NULL,
  ACHIEVEMENT_STRING varchar(255) NOT NULL,
  ACH_RANK smallint NOT NULL DEFAULT 0,
  WEB_LINK varchar(255),
  PRIMARY KEY (A_ID)
) ENGINE=InnoDB;

CREATE TABLE PRT_EVENT (
  E_ID mediumint NOT NULL,
  ACTUAL_DATE date NOT NULL,
  EVENT_TITLE varchar(255) NOT NULL,
  EVENT_RANK smallint NOT NULL,
  WEB_LINK varchar(255),
  PRIMARY KEY (E_ID)
) ENGINE=InnoDB;

CREATE TABLE TPL_PLAN (
  P_ID smallint NOT NULL,
  FOR_CYCLE	smallint NOT NULL,
  PLAN_DESCRIPTION varchar(255),
  AUTHOR_TEACHER int,
  PRIMARY KEY (P_ID)
) ENGINE=InnoDB;

CREATE TABLE TPL_THEME (
  T_ID mediumint NOT NULL,
  PLAN_ID smallint NOT NULL,
  ORDER_NUM smallint NOT NULL,
  THEME_STRING varchar(255),
  LESSONS_COUNT tinyint NOT NULL,
  PRIMARY KEY (T_ID)
) ENGINE=InnoDB;

CREATE TABLE  EO_PK_TABLE (
  NAME char(40),
  PK int
) ENGINE=InnoDB;