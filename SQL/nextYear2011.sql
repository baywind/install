SET NAMES utf8;

CREATE DATABASE RujelYear2011;
USE RujelYear2011;

CREATE TABLE SCHEMA_VERSION (
  MODEL_NAME varchar(255),
  VERSION_NUMBER smallint unsigned NOT NULL,
  VERSION_TITLE varchar(255),
  INSTALL_DATE timestamp
);

INSERT INTO SCHEMA_VERSION (MODEL_NAME,VERSION_NUMBER,VERSION_TITLE)
  VALUES ('BaseYearly',1,'0.9'),('Curriculum',1,'0.9'),('EduPlanYearly',1,'0.9');

CREATE TABLE BASE_INDEXER (
  PRIMARY KEY (IND_ID) 
) ENGINE=InnoDB 
  SELECT IND_ID, INDEX_NAME, INDEX_TYPE, DEFAULT_VALUE, FORMAT_STRING, COMMENT_ID
  from RujelYear2010.BASE_INDEXER;

CREATE TABLE BASE_INDEX_ROW (
  PRIMARY KEY (INDEX_ID,ROW_IDX)
) ENGINE=InnoDB
  SELECT ROW_IDX, INDEX_ID, IDX_VALUE, COMMENT_ID
  from RujelYear2010.BASE_INDEX_ROW;

CREATE TABLE BASE_TEXT_STORE (
  PRIMARY KEY (T_ID)
) ENGINE=InnoDB
  SELECT T_ID, FROM_ENTITY, STORED_TEXT
  FROM RujelYear2010.BASE_TEXT_STORE
  where T_ID in (
    select COMMENT_ID from BASE_INDEXER union
    select COMMENT_ID from BASE_INDEX_ROW);

CREATE TABLE BASE_SETTINGS (
  PRIMARY KEY (S_ID)
) ENGINE=InnoDB
  SELECT S_ID, SETTING_KEY, TEXT_VALUE, NUM_VALUE
  from RujelYear2010.BASE_SETTINGS
  WHERE SETTING_KEY != "CompletionActive";

CREATE TABLE BASE_QUALIFIED_SETTINGS (
  PRIMARY KEY (QS_ID)
) ENGINE=InnoDB
  SELECT QS_ID, SETTING_ID, QUALIFIER_STRING, ARGUMENTS_STRING, EDU_YEAR, ORDER_KEY, TEXT_VALUE, NUM_VALUE
  from RujelYear2010.BASE_QUALIFIED_SETTINGS
  WHERE EDU_YEAR IS NULL;

CREATE TABLE CR_BORDER (
  PRIMARY KEY (B_ID)
) ENGINE=InnoDB
  SELECT B_ID, B_SET, LEAST_VALUE, B_TITLE
  from RujelYear2010.CR_BORDER;

CREATE TABLE CR_BORDER_SET (
  PRIMARY KEY (BS_ID)
) ENGINE=InnoDB
  SELECT BS_ID, BSET_NAME, VALUE_TYPE, ZERO_VALUE, EXCLUDE_MIN, FORMAT_STRING, USE_CLASS
  from RujelYear2010.CR_BORDER_SET;

CREATE TABLE CR_CRITERION (
  PRIMARY KEY (CRIT_SET,CRITER_NUM)
) ENGINE=InnoDB
  SELECT CRIT_SET, CRITER_NUM, CR_TITLE, COMMENT_TEXT, DFLT_MAX, DFLT_WEIGHT, INDEX_ID, CRITER_FLAGS
  from RujelYear2010.CR_CRITERION;

CREATE TABLE CR_CRIT_SET (
  PRIMARY KEY (CS_ID)
) ENGINE=InnoDB
  SELECT CS_ID, SET_NAME, COMMENT_TEXT, CRITER_FLAGS
  from RujelYear2010.CR_CRIT_SET;

CREATE TABLE CR_WORK_TYPE (
  PRIMARY KEY(WT_ID)
) ENGINE=InnoDB
  SELECT WT_ID, SORT_NUM, TYPE_NAME, DFLT_FLAGS, DFLT_WEIGHT, COLOR_NOWEIGHT, COLOR_WEIGHT
  from RujelYear2010.CR_WORK_TYPE;

CREATE TABLE PL_HOURS (
  PRIMARY KEY (PH_ID)
) ENGINE=InnoDB
  SELECT PH_ID, CYCLE_ID, TOTAL_HOURS, WEEKLY_HOURS, SPEC_CLASS
  from RujelYear2010.PL_HOURS;

CREATE TABLE PL_EDU_PERIOD (
  P_ID smallint NOT NULL,
  EDU_YEAR smallint NOT NULL,
  DATE_BEGIN date NOT NULL,
  DATE_END date NOT NULL,
  SHORT_TITLE varchar(9) NOT NULL,
  FULL_NAME varchar(28),
  PRIMARY KEY (P_ID)
) ENGINE=InnoDB;

INSERT INTO PL_EDU_PERIOD (P_ID, EDU_YEAR, DATE_BEGIN, DATE_END, SHORT_TITLE, FULL_NAME)
  SELECT P_ID, EDU_YEAR, DATE_BEGIN + INTERVAL 1 YEAR AS DATE_BEGIN, DATE_END + INTERVAL 1 YEAR AS DATE_END, SHORT_TITLE, FULL_NAME
  from RujelYear2010.PL_EDU_PERIOD;

CREATE TABLE PL_PERIOD_LIST (
  PRIMARY KEY (PL_ID)
) ENGINE=InnoDB
  SELECT PL_ID, EDU_PERIOD, LIST_NAME
  from RujelYear2010.PL_PERIOD_LIST;

CREATE TABLE AI_AUTOITOG (
  AI_ID smallint NOT NULL,
  LIST_NAME varchar(28) NOT NULL,
  ITOG_CONTANER smallint NOT NULL,
  FIRE_DATE date NOT NULL,
  FIRE_TIME time,
  CALCULATOR_NAME varchar(255),
  BORDER_SET smallint,
  AI_FLAGS tinyint NOT NULL,
  PRIMARY KEY (AI_ID)
) ENGINE=InnoDB;

CREATE TABLE AI_BONUS (
  B_ID mediumint NOT NULL,
  ADD_VALUE decimal(4,4) NOT NULL,
  TARGET_MARK varchar(5),
  BONUS_REASON varchar(255),
  PRIMARY KEY (B_ID)
) ENGINE=InnoDB;

CREATE TABLE AI_COURSE_TIMEOUT (
  CT_ID mediumint NOT NULL,
  ITOG_CONTAINER smallint NOT NULL,
  EDU_COURSE smallint,
  EDU_GROUP int,
  EDU_CYCLE smallint,
  TEACHER_ID mediumint,
  FIRE_DATE date NOT NULL,
  REASON_TEXT varchar(255),
  CTO_FLAGS tinyint NOT NULL,
  PRIMARY KEY (CT_ID)
) ENGINE=InnoDB;

CREATE TABLE AI_ITOG_RELATED (
  R_ID int NOT NULL,
  EDU_COURSE smallint NOT NULL,
  ITOG_CONTAINER smallint NOT NULL,
  REL_KEY int NOT NULL,
  PRIMARY KEY (R_ID)
) ENGINE=InnoDB;

CREATE TABLE AI_PROGNOSIS (
  ITOG_CONTAINER smallint NOT NULL,
  EDU_COURSE smallint NOT NULL,
  STUDENT_ID int NOT NULL,
  PR_MARK varchar(5),
  SUCCESS_VALUE decimal(5,4) NOT NULL,
  COMPLETE_RATE decimal(5,4) NOT NULL,
  FIRE_DATE date,
  BONUS_ID mediumint,
  PR_FLAGS tinyint NOT NULL,
  PRIMARY KEY (ITOG_CONTAINER,EDU_COURSE,STUDENT_ID)
) ENGINE=InnoDB;

CREATE TABLE AI_STUDENT_TIMEOUT (
  T_ID mediumint NOT NULL,
  ITOG_CONTAINER smallint NOT NULL,
  STUDENT_ID int NOT NULL,
  EDU_COURSE smallint,
  FIRE_DATE date NOT NULL,
  REASON_TEXT varchar(255),
  STO_FLAGS tinyint NOT NULL,
  PRIMARY KEY (T_ID)
) ENGINE=InnoDB;

CREATE TABLE ATT_BYLESSON (
  STUDENT_ID int NOT NULL,
  LESSON_ID int NOT NULL,
  ATTEND_STATE tinyint NOT NULL,
  REASON_ID mediumint,
  PRIMARY KEY (STUDENT_ID,LESSON_ID)
) ENGINE=InnoDB;

CREATE TABLE ATT_DAY (
  D_ID int NOT NULL,
  STUDENT_ID int NOT NULL,
  ATT_DATE date NOT NULL,
  ATTEND_STATE tinyint NOT NULL,
  SKIPPED_LESSONS smallint NOT NULL,
  VISITED_LESSONS smallint NOT NULL,
  TIME_IN time,
  TIME_OUT time,
  REASON_ID mediumint,
  PRIMARY KEY (D_ID)
) ENGINE=InnoDB;

CREATE TABLE ATT_LIST (
  REASON_ID mediumint NOT NULL,
  STUDENT_ID int NOT NULL,
  PRIMARY KEY (REASON_ID,STUDENT_ID)
) ENGINE=InnoDB;

CREATE TABLE ATT_REASON (
  R_ID mediumint NOT NULL,
  REASON_TEXT varchar(255) NOT NULL,
  REASON_TYPE smallint NOT NULL,
  LESSONS_COUNT tinyint NOT NULL,
  EVENT_STATUS tinyint NOT NULL DEFAULT 0,
  BEGIN_DATE date NOT NULL,
  END_DATE date NOT NULL,
  PRIMARY KEY (R_ID)
) ENGINE=InnoDB;

CREATE TABLE BASE_AUDIENCE (
  EDU_COURSE smallint NOT NULL,
  STUDENT_ID int NOT NULL,
  PRIMARY KEY (EDU_COURSE,STUDENT_ID)
) ENGINE=InnoDB;

CREATE TABLE BASE_LESSON (
  L_ID int NOT NULL,
  EDU_COURSE smallint NOT NULL,
  NUMBER_ORDER smallint,
  DATE_PERFORMED date NOT NULL,
  LESSON_TITLE varchar(5),
  LESSON_THEME varchar(255),
  HOME_TASK int,
  PRIMARY KEY (L_ID)
) ENGINE=InnoDB;

CREATE TABLE BASE_NOTE (
  LESSON_ID int NOT NULL,
  STUDENT_ID int NOT NULL,
  NOTE_TEXT varchar(255),
  PRIMARY KEY (LESSON_ID,STUDENT_ID)
) ENGINE=InnoDB;

CREATE TABLE BASE_TAB (
  TAB_ID mediumint NOT NULL,
  EDU_COURSE smallint NOT NULL,
  LESSON_ENTITY smallint NOT NULL,
  FIRST_LESSON smallint NOT NULL,
  PRIMARY KEY (TAB_ID)
) ENGINE=InnoDB;

CREATE TABLE BASE_TEACHER_CHANGE (
  TC_ID SMALLINT NOT NULL,
  EDU_COURSE SMALLINT NOT NULL,
  UPTO_DATE DATE NOT NULL,
  TEACHER_ID MEDIUMINT,
  COMMENT_TEXT VARCHAR(255),
  PRIMARY KEY (TC_ID)
) ENGINE=InnoDB;

CREATE TABLE BASE_COURSE (
  CR_ID smallint NOT NULL,
  EDU_CYCLE smallint NOT NULL,
  EDU_GROUP mediumint,
  TEACHER_ID mediumint,
  EDU_YEAR smallint NOT NULL,
  COMMENT_TEXT varchar(255),
  CR_FLAGS tinyint NOT NULL,
  PRIMARY KEY (CR_ID)
) ENGINE=InnoDB;

CREATE TABLE CPT_COMPLETION (
  C_ID MEDIUMINT NOT NULL,
  CPT_ASPECT VARCHAR(28) NOT NULL,
  EDU_COURSE SMALLINT,
  STUDENT_ID INTEGER,
  CLOSE_DATE DATETIME,
  WHO_CLOSED VARCHAR(255),
  PRIMARY KEY (C_ID)
) ENGINE=InnoDB;

CREATE TABLE CR_MARK (
  WORK_ID mediumint NOT NULL,
  CRITER_NUM smallint NOT NULL,
  STUDENT_ID int NOT NULL,
  MARK_VALUE smallint NOT NULL,
  DATE_SET date NOT NULL,
  PRIMARY KEY (WORK_ID,CRITER_NUM,STUDENT_ID)
) ENGINE=InnoDB;

CREATE TABLE CR_MASK (
  WORK_ID mediumint NOT NULL,
  CRITER_NUM smallint NOT NULL,
  MARK_MAX smallint NOT NULL,
  CRITER_WEIGHT smallint,
  PRIMARY KEY (WORK_ID,CRITER_NUM)
) ENGINE=InnoDB;

CREATE TABLE CR_NOTE (
  WORK_ID int NOT NULL,
  STUDENT_ID int NOT NULL,
  NOTE_TEXT varchar(255),
  PRIMARY KEY (WORK_ID,STUDENT_ID)
) ENGINE=InnoDB;

CREATE TABLE CR_WORK (
  W_ID mediumint NOT NULL,
  EDU_COURSE smallint NOT NULL,
  NUMBER_ORDER smallint NOT NULL,
  ANNOUNCE_DATE date NOT NULL,
  DEADLINE_DATE date NOT NULL,
  WORK_WEIGHT decimal(4,2) NOT NULL,
  WORK_TYPE smallint NOT NULL,
  WORK_TITLE varchar(5),
  WORK_THEME varchar(255),
  LOAD_TIME smallint NOT NULL,
  TASK_LINK int,
  WORK_FLAGS smallint NOT NULL,
  PRIMARY KEY (W_ID)
) ENGINE=InnoDB;

CREATE TABLE CU_REASON (
  R_ID mediumint NOT NULL,
  TEACHER_ID mediumint,
  EDU_GROUP mediumint,
  DATE_BEGIN date NOT NULL,
  DATE_END date,
  REASON_TEXT varchar(255) NOT NULL,
  VERIFY_TEXT varchar(255),
  SCHOOL_NUM smallint NOT NULL,
  REASON_FLAGS tinyint NOT NULL,
  PRIMARY KEY (R_ID)
) ENGINE=InnoDB;

CREATE TABLE CU_REPRIMAND (
  R_ID mediumint NOT NULL,
  EDU_COURSE smallint NOT NULL,
  DATE_RAISED datetime NOT NULL,
  DATE_RELIEF datetime,
  CONTENT_TEXT varchar(255) NOT NULL,
  AUTHOR_NAME varchar(255) NOT NULL,
  STATUS_FLAG tinyint NOT NULL,
  PRIMARY KEY (R_ID)
) ENGINE=InnoDB;

CREATE TABLE CU_SUBSTITUTE (
  LESSON_ID int NOT NULL,
  TEACHER_ID mediumint NOT NULL,
  LESSON_DATE date NOT NULL,
  SUBS_FACTOR decimal(4,2) NOT NULL,
  REASON_ID mediumint NOT NULL,
  FROM_LESSON int,
  PRIMARY KEY (LESSON_ID,TEACHER_ID)
) ENGINE=InnoDB;

CREATE TABLE CU_VARIATION (
  V_ID int NOT NULL,
  EDU_COURSE smallint,
  VAR_DATE date NOT NULL,
  VAR_VALUE tinyint NOT NULL,
  REASON_ID mediumint NOT NULL,
  LESSON_ID int,
  PRIMARY KEY (V_ID)
) ENGINE=InnoDB;

CREATE TABLE MA_MARK_ARCHIVE (
  A_ID int NOT NULL,
  OBJ_ENTITY smallint NOT NULL,
  KEY1_VALUE int NOT NULL,
  KEY2_VALUE int NOT NULL,
  KEY3_VALUE int NOT NULL,
  CHANGE_TIME timestamp NOT NULL,
  ARCH_DATA text NOT NULL,
  BY_USER varchar(255) NOT NULL,
  WOSID_CODE varchar(28) NOT NULL,
  PRIMARY KEY (A_ID)
) ENGINE=InnoDB;

CREATE TABLE MA_USED_ENTITY (
  ENT_ID smallint NOT NULL,
  KEY1_NAME varchar(28),
  KEY2_NAME varchar(28),
  KEY3_NAME varchar(28),
  TO_ARCHIVE varchar(28),
  ENTITY_NAME varchar(28) NOT NULL,
  PRIMARY KEY (ENT_ID)
) ENGINE=InnoDB;

CREATE TABLE PL_HOLIDAY (
  PRIMARY KEY (H_ID)
) ENGINE=InnoDB
select H_ID, HD_TYPE, DATE_BEGIN + INTERVAL 1 YEAR, DATE_END + INTERVAL 1 YEAR, LIST_NAME
from RujelYear2010.PL_HOLIDAY;

CREATE TABLE PL_PLAN_DETAIL (
  EDU_COURSE smallint NOT NULL,
  EDU_PERIOD smallint NOT NULL,
  TOTAL_HOURS smallint NOT NULL,
  WEEKLY_HOURS smallint NOT NULL,
  PRIMARY KEY (EDU_COURSE,EDU_PERIOD)
) ENGINE=InnoDB;

CREATE TABLE ST_DESCRIPTION (
  D_ID smallint NOT NULL,
  ENT_NAME varchar(28) NOT NULL,
  ST_DESCRIPTION varchar(28),
  STAT_FIELD varchar(28) NOT NULL,
  GR_FIELD1 varchar(28),
  GR_FIELD2 varchar(28),
  BORDER_SET smallint,
  PRIMARY KEY (D_ID)
) ENGINE=InnoDB;

CREATE TABLE ST_ENTRY (
  E_ID int NOT NULL,
  GROUPING_ID int NOT NULL,
  STAT_KEY varchar(28) NOT NULL,
  KEY_COUNT mediumint NOT NULL,
  PRIMARY KEY (E_ID)
) ENGINE=InnoDB;

CREATE TABLE ST_GROUPING (
  G_ID int NOT NULL,
  DESCRIPTION_ID smallint NOT NULL,
  GR_ID1 int,
  GR_ID2 int,
  GR_TOTAL mediumint NOT NULL,
  PRIMARY KEY (G_ID)
) ENGINE=InnoDB;

CREATE TABLE TPL_LESSON (
  THEME_ID mediumint NOT NULL,
  LESSON_ID int NOT NULL,
  PRIMARY KEY (THEME_ID,LESSON_ID)
) ENGINE=InnoDB;
