CREATE DATABASE RujelStatic DEFAULT CHARACTER SET utf8;
USE RujelStatic;

CREATE TABLE BASE_BY_COURSE (
  SC_ID mediumint NOT NULL,
  SETTING_ID mediumint NOT NULL,
  EDU_YEAR smallint,
  EDU_COURSE smallint,
  EDU_CYCLE mediumint,
  GRADE_NUM smallint,
  EDU_GROUP mediumint,
  TEACHER_ID mediumint,
  TEXT_VALUE varchar(255),
  NUM_VALUE int,
  PRIMARY KEY (SC_ID)
) ENGINE=InnoDB;

CREATE TABLE BASE_COURSE (
  CR_ID smallint NOT NULL,
  EDU_CYCLE smallint NOT NULL,
  EDU_GROUP mediumint NOT NULL,
  TEACHER_ID mediumint,
  EDU_YEAR smallint NOT NULL,
  COMMENT_TEXT varchar(255),
  CR_FLAGS tinyint NOT NULL,
  PRIMARY KEY (CR_ID)
) ENGINE=InnoDB;

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

CREATE TABLE BASE_INDEXER (
  IND_ID smallint NOT NULL,
  INDEX_NAME varchar(28),
  INDEX_TYPE smallint NOT NULL,
  DEFAULT_VALUE varchar(255),
  FORMAT_STRING varchar(255),
  PRIMARY KEY (IND_ID)
) ENGINE=InnoDB;

CREATE TABLE BASE_INDEX_ROW (
  ROW_IDX smallint NOT NULL,
  INDEX_ID smallint NOT NULL,
  IDX_VALUE varchar(255),
  COMMENT_ID int,
  PRIMARY KEY (INDEX_ID,ROW_IDX)
) ENGINE=InnoDB;

CREATE TABLE BASE_SETTINGS (
  S_ID mediumint NOT NULL,
  SETTING_KEY varchar(28) NOT NULL,
  TEXT_VALUE varchar(255),
  NUM_VALUE int,
  PRIMARY KEY (S_ID)
) ENGINE=InnoDB;

CREATE TABLE BASE_ST_TEXT_STORE (
  T_ID int NOT NULL,
  FROM_ENTITY smallint NOT NULL,
  STORED_TEXT text NOT NULL,
  PRIMARY KEY (T_ID)
) ENGINE=InnoDB;

CREATE TABLE CR_BORDER (
  B_ID smallint NOT NULL,
  B_SET smallint NOT NULL,
  LEAST_VALUE decimal(4,2) NOT NULL,
  B_TITLE varchar(28) NOT NULL,
  PRIMARY KEY (B_ID)
) ENGINE=InnoDB;

CREATE TABLE CR_BORDER_SET (
  BS_ID smallint NOT NULL,
  BSET_NAME varchar(28),
  ZERO_VALUE varchar(28),
  EXCLUDE_MIN tinyint NOT NULL,
  FORMAT_STRING varchar(255),
  USE_CLASS varchar(255),
  PRIMARY KEY (BS_ID)
) ENGINE=InnoDB;

CREATE TABLE CR_CRITERION (
  CRIT_SET smallint NOT NULL,
  CRITER_NUM smallint NOT NULL,
  CR_TITLE varchar(5),
  COMMENT_TEXT varchar(255),
  DFLT_MAX smallint,
  DFLT_WEIGHT smallint,
  INDEX_ID smallint,
  PRIMARY KEY (CRIT_SET,CRITER_NUM)
) ENGINE=InnoDB;

CREATE TABLE CR_CRIT_SET (
  CS_ID smallint NOT NULL,
  COMMENT_TEXT varchar(255),
  SET_NAME varchar(28),
  PRIMARY KEY (CS_ID)
) ENGINE=InnoDB;

CREATE TABLE CR_WORK_TYPE (
  WT_ID smallint NOT NULL,
  SORT_NUM smallint NOT NULL,
  TYPE_NAME varchar(28) NOT NULL,
  DFLT_FLAGS smallint NOT NULL,
  DFLT_WEIGHT decimal(4,2) NOT NULL,
  COLOR_NOWEIGHT char(7),
  COLOR_WEIGHT char(7),
  USE_COUNT int NOT NULL,
  PRIMARY KEY(WT_ID)
) ENGINE=InnoDB;

CREATE TABLE ITOG_COMMENT (
  ITOG_CONTAINER smallint NOT NULL,
  EDU_CYCLE mediumint NOT NULL,
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
  EDU_CYCLE mediumint NOT NULL,
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
  SPEC_CLASS int,
  SUBJECT_ID smallint NOT NULL,
  TOTAL_HOURS smallint NOT NULL,
  WEEKLY_HOURS smallint NOT NULL,
  LEVEL_EDU smallint NOT NULL,
  SCHOOL_NUM smallint NOT NULL,
  EDU_YEAR tinyint NOT NULL,
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
  STUDENT_ID int NOT NULL,
  ACHIEVEMENT_STRING varchar(255) NOT NULL,
  ACH_RANK smallint NOT NULL DEFAULT 0,
  EVENT_ID mediumint NOT NULL,
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
