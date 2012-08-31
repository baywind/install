CREATE DATABASE 'RujelYear2012' DEFAULT CHARACTER SET utf8;

CREATE TABLE SCHEMA_VERSION (
  MODEL_NAME varchar(255),
  VERSION_NUMBER smallint unsigned NOT NULL,
  VERSION_TITLE varchar(255),
  INSTALL_DATE timestamp
);

INSERT INTO SCHEMA_VERSION (MODEL_NAME,VERSION_NUMBER,VERSION_TITLE)
  VALUES ('BaseYearly',2,'0.9.4'),('Curriculum',2,'0.9.4'),('EduPlanYearly',2,'0.9.4'),
  ('Schedule',2,'0.9.4'),('MarkArchive',2,'0.9.4'),('Stats',1,'0.9.4'),('AutoItog',1,'0.9.4'),
  ('Criterial',1,'0.9.4');

CREATE TABLE AI_AUTOITOG (
  AI_ID smallint NOT NULL,
  LIST_NAME varchar(28) NOT NULL,
  ITOG_CONTANER smallint NOT NULL,
  FIRE_DATE date NOT NULL,
  FIRE_TIME time,
  CALCULATOR_NAME varchar(255),
  BORDER_SET smallint,
  AI_FLAGS smallint NOT NULL,
  PRIMARY KEY (AI_ID)
);

CREATE TABLE AI_BONUS (
  B_ID int NOT NULL,
  ADD_VALUE decimal(4,4) NOT NULL,
  TARGET_MARK varchar(5),
  BONUS_REASON varchar(255),
  PRIMARY KEY (B_ID)
);

CREATE TABLE AI_COURSE_TIMEOUT (
  CT_ID int NOT NULL,
  ITOG_CONTAINER smallint NOT NULL,
  EDU_COURSE smallint,
  EDU_GROUP int,
  EDU_CYCLE smallint,
  TEACHER_ID int,
  FIRE_DATE date NOT NULL,
  REASON_TEXT varchar(255),
  CTO_FLAGS smallint NOT NULL,
  PRIMARY KEY (CT_ID)
);

CREATE TABLE AI_ITOG_RELATED (
  R_ID int NOT NULL,
  EDU_COURSE smallint NOT NULL,
  ITOG_CONTAINER smallint NOT NULL,
  REL_KEY int NOT NULL,
  PRIMARY KEY (R_ID)
);

CREATE TABLE AI_PROGNOSIS (
  ITOG_CONTAINER smallint NOT NULL,
  EDU_COURSE smallint NOT NULL,
  STUDENT_ID int NOT NULL,
  PR_MARK varchar(5),
  SUCCESS_VALUE decimal(5,4) NOT NULL,
  COMPLETE_RATE decimal(5,4) NOT NULL,
  FIRE_DATE date,
  BONUS_ID integer,
  PR_FLAGS smallint NOT NULL,
  PRIMARY KEY (ITOG_CONTAINER,EDU_COURSE,STUDENT_ID)
);

CREATE TABLE AI_STUDENT_TIMEOUT (
  T_ID integer NOT NULL,
  ITOG_CONTAINER smallint NOT NULL,
  STUDENT_ID int NOT NULL,
  EDU_COURSE smallint,
  FIRE_DATE date NOT NULL,
  REASON_TEXT varchar(255),
  STO_FLAGS smallint NOT NULL,
  PRIMARY KEY (T_ID)
);

CREATE TABLE ATT_BYLESSON (
  STUDENT_ID int NOT NULL,
  LESSON_ID int NOT NULL,
  ATTEND_STATE smallint NOT NULL,
  REASON_ID int,
  PRIMARY KEY (STUDENT_ID,LESSON_ID)
);

CREATE TABLE ATT_DAY (
  D_ID int NOT NULL,
  STUDENT_ID int NOT NULL,
  ATT_DATE date NOT NULL,
  ATTEND_STATE smallint NOT NULL,
  SKIPPED_LESSONS smallint NOT NULL,
  VISITED_LESSONS smallint NOT NULL,
  TIME_IN time,
  TIME_OUT time,
  REASON_ID int,
  PRIMARY KEY (D_ID)
);

CREATE TABLE ATT_LIST (
  REASON_ID int NOT NULL,
  STUDENT_ID int NOT NULL,
  PRIMARY KEY (REASON_ID,STUDENT_ID)
);

CREATE TABLE ATT_REASON (
  R_ID int NOT NULL,
  REASON_TEXT varchar(255) NOT NULL,
  REASON_TYPE smallint NOT NULL,
  LESSONS_COUNT smallint NOT NULL,
  EVENT_STATUS smallint NOT NULL DEFAULT 0,
  BEGIN_DATE date NOT NULL,
  END_DATE date NOT NULL,
  PRIMARY KEY (R_ID)
);

CREATE TABLE BASE_AUDIENCE (
  EDU_COURSE smallint NOT NULL,
  STUDENT_ID int NOT NULL,
  PRIMARY KEY (EDU_COURSE,STUDENT_ID)
);

CREATE TABLE BASE_LESSON (
  L_ID int NOT NULL,
  EDU_COURSE smallint NOT NULL,
  NUMBER_ORDER smallint,
  DATE_PERFORMED date NOT NULL,
  LESSON_TITLE varchar(5),
  LESSON_THEME varchar(255),
  HOME_TASK int,
  PRIMARY KEY (L_ID)
);

CREATE TABLE BASE_NOTE (
  LESSON_ID int NOT NULL,
  STUDENT_ID int NOT NULL,
  NOTE_TEXT varchar(255),
  PRIMARY KEY (LESSON_ID,STUDENT_ID)
);

CREATE TABLE BASE_TAB (
  TAB_ID integer NOT NULL,
  EDU_COURSE smallint NOT NULL,
  LESSON_ENTITY smallint NOT NULL,
  FIRST_LESSON smallint NOT NULL,
  PRIMARY KEY (TAB_ID)
);

CREATE TABLE BASE_TEACHER_CHANGE (
  TC_ID SMALLINT NOT NULL,
  EDU_COURSE SMALLINT NOT NULL,
  UPTO_DATE DATE NOT NULL,
  TEACHER_ID INTEGER,
  COMMENT_TEXT VARCHAR(255),
  PRIMARY KEY (TC_ID)
);

CREATE TABLE BASE_TEXT_STORE (
  T_ID int NOT NULL,
  FROM_ENTITY smallint NOT NULL,
  STORED_TEXT BLOB SUB_TYPE TEXT NOT NULL,
  PRIMARY KEY (T_ID)
);

CREATE TABLE BASE_COURSE (
  CR_ID smallint NOT NULL,
  EDU_CYCLE smallint NOT NULL,
  EDU_GROUP int,
  TEACHER_ID int,
  EDU_YEAR smallint NOT NULL,
  COMMENT_TEXT varchar(255),
  CR_FLAGS smallint NOT NULL,
  PRIMARY KEY (CR_ID)
);

CREATE TABLE BASE_INDEXER (
  IND_ID smallint NOT NULL,
  INDEX_NAME varchar(28),
  INDEX_TYPE smallint NOT NULL,
  DEFAULT_VALUE varchar(255),
  FORMAT_STRING varchar(255),
  COMMENT_ID int,
  PRIMARY KEY (IND_ID)
);

CREATE TABLE BASE_INDEX_ROW (
  ROW_IDX smallint NOT NULL,
  INDEX_ID smallint NOT NULL,
  IDX_VALUE varchar(255),
  COMMENT_ID int,
  PRIMARY KEY (INDEX_ID,ROW_IDX)
);

CREATE TABLE BASE_SETTINGS (
  S_ID smallint NOT NULL,
  SETTING_KEY varchar(28) NOT NULL,
  TEXT_VALUE varchar(255),
  NUM_VALUE int,
  PRIMARY KEY (S_ID)
);

CREATE TABLE BASE_QUALIFIED_SETTINGS (
  QS_ID int NOT NULL,
  SETTING_ID smallint NOT NULL,
  QUALIFIER_STRING varchar(255),
  ARGUMENTS_STRING varchar(255),
  EDU_YEAR smallint,
  ORDER_KEY smallint NOT NULL,
  TEXT_VALUE varchar(255),
  NUM_VALUE int,
  PRIMARY KEY (QS_ID)
);

CREATE TABLE CPT_COMPLETION (
  C_ID integer NOT NULL,
  CPT_ASPECT VARCHAR(28) NOT NULL,
  EDU_COURSE SMALLINT,
  STUDENT_ID INTEGER,
  CLOSE_DATE timestamp,
  WHO_CLOSED VARCHAR(255),
  PRIMARY KEY (C_ID)
);

CREATE TABLE IF NOT EXISTS CPT_PED_DECISION (
  P_ID smallint NOT NULL,
  STUDENT_ID int NOT NULL,
  SPEC_DECISION varchar(255),
  DECISION_FLAGS tinyint NOT NULL,
  PRIMARY KEY (P_ID)
);

CRETE UNIQUE INDEX pedsovetIdx
  ON CPT_PED_DECISION (STUDENT_ID);


CREATE TABLE CR_BORDER (
  B_ID smallint NOT NULL,
  B_SET smallint NOT NULL,
  LEAST_VALUE decimal(4,2) NOT NULL,
  B_TITLE varchar(28) NOT NULL,
  PRIMARY KEY (B_ID)
);

CREATE TABLE CR_BORDER_SET (
  BS_ID smallint NOT NULL,
  BSET_NAME varchar(28),
  VALUE_TYPE smallint NOT NULL,
  ZERO_VALUE varchar(28),
  EXCLUDE_MIN smallint NOT NULL,
  FORMAT_STRING varchar(255),
  USE_CLASS varchar(255),
  PRIMARY KEY (BS_ID)
);

CREATE TABLE CR_CRITERION (
  CRIT_SET smallint NOT NULL,
  CRITER_NUM smallint NOT NULL,
  CR_TITLE varchar(5),
  COMMENT_TEXT varchar(255),
  DFLT_MAX smallint,
  DFLT_WEIGHT smallint,
  INDEX_ID smallint,
  CRITER_FLAGS smallint NOT NULL,
  PRIMARY KEY (CRIT_SET,CRITER_NUM)
);

CREATE TABLE CR_CRIT_SET (
  CS_ID smallint NOT NULL,
  SET_NAME varchar(28),
  COMMENT_TEXT varchar(255),
  CRITER_FLAGS smallint NOT NULL,
  PRIMARY KEY (CS_ID)
);

CREATE TABLE CR_WORK_TYPE (
  WT_ID smallint NOT NULL,
  SORT_NUM smallint NOT NULL,
  TYPE_NAME varchar(28) NOT NULL,
  DFLT_FLAGS smallint NOT NULL,
  DFLT_WEIGHT decimal(4,2) NOT NULL,
  COLOR_NOWEIGHT char(7),
  COLOR_WEIGHT char(7),
  PRIMARY KEY(WT_ID)
);

CREATE TABLE CR_MARK (
  WORK_ID integer NOT NULL,
  CRITER_NUM smallint NOT NULL,
  STUDENT_ID int NOT NULL,
  MARK_VALUE smallint NOT NULL,
  DATE_SET date NOT NULL,
  PRIMARY KEY (WORK_ID,CRITER_NUM,STUDENT_ID)
);

CREATE TABLE CR_MASK (
  WORK_ID integer NOT NULL,
  CRITER_NUM smallint NOT NULL,
  MARK_MAX smallint NOT NULL,
  CRITER_WEIGHT smallint,
  PRIMARY KEY (WORK_ID,CRITER_NUM)
);

CREATE TABLE CR_NOTE (
  WORK_ID int NOT NULL,
  STUDENT_ID int NOT NULL,
  NOTE_TEXT varchar(255),
  PRIMARY KEY (WORK_ID,STUDENT_ID)
);

CREATE TABLE CR_WORK (
  W_ID integer NOT NULL,
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
);

CREATE TABLE CU_REASON (
  R_ID integer NOT NULL,
  TEACHER_ID integer,
  EDU_GROUP integer,
  DATE_BEGIN date NOT NULL,
  DATE_END date,
  REASON_TEXT varchar(255) NOT NULL,
  VERIFY_TEXT varchar(255),
  SCHOOL_NUM smallint NOT NULL,
  REASON_FLAGS smallint NOT NULL,
  PRIMARY KEY (R_ID)
);

CREATE TABLE CU_REPRIMAND (
  R_ID integer NOT NULL,
  EDU_COURSE smallint NOT NULL,
  DATE_RAISED timestamp NOT NULL,
  DATE_RELIEF timestamp,
  CONTENT_TEXT varchar(255) NOT NULL,
  AUTHOR_NAME varchar(255) NOT NULL,
  STATUS_FLAG smallint NOT NULL,
  PRIMARY KEY (R_ID)
);

CREATE TABLE CU_SUBSTITUTE (
  LESSON_ID int NOT NULL,
  TEACHER_ID integer NOT NULL,
  LESSON_DATE date NOT NULL,
  SUBS_FACTOR decimal(4,2) NOT NULL,
  REASON_ID integer NOT NULL,
  FROM_LESSON int,
  PRIMARY KEY (LESSON_ID,TEACHER_ID)
);

CREATE TABLE CU_VARIATION (
  V_ID int NOT NULL,
  EDU_COURSE smallint,
  VAR_DATE date NOT NULL,
  VAR_VALUE smallint NOT NULL,
  REASON_ID integer NOT NULL,
  LESSON_ID integer,
  PRIMARY KEY (V_ID)
);

CREATE TABLE MA_MARK_ARCHIVE (
  A_ID int NOT NULL,
  OBJ_ENTITY smallint NOT NULL,
  KEY1_VALUE int NOT NULL,
  KEY2_VALUE int NOT NULL,
  KEY3_VALUE int NOT NULL,
  CHANGE_TIME timestamp NOT NULL,
  ACTION_TYPE smallint NOT NULL,
  ARCH_DATA BLOB SUB_TYPE TEXT NOT NULL,
  BY_USER varchar(255) NOT NULL,
  WOSID_CODE varchar(28) NOT NULL,
  PRIMARY KEY (A_ID)
);

CREATE TABLE MA_USED_ENTITY (
  ENT_ID smallint NOT NULL,
  KEY1_NAME varchar(28),
  KEY2_NAME varchar(28),
  KEY3_NAME varchar(28),
  TO_ARCHIVE varchar(28),
  ENTITY_NAME varchar(28) NOT NULL,
  PRIMARY KEY (ENT_ID)
);

CREATE TABLE PL_EDU_PERIOD (
  P_ID smallint NOT NULL,
  EDU_YEAR smallint NOT NULL,
  DATE_BEGIN date NOT NULL,
  DATE_END date NOT NULL,
  SHORT_TITLE varchar(9) NOT NULL,
  FULL_NAME varchar(28),
  ITOG_ID smallint,
  PRIMARY KEY (P_ID)
);

CREATE TABLE PL_HOLIDAY (
  H_ID smallint NOT NULL,
  HOLIDAY_NAME varchar(28) NOT NULL,
  DATE_BEGIN date NOT NULL,
  DATE_END date NOT NULL,
  LIST_NAME varchar(28),
  PRIMARY KEY (H_ID)
);

CREATE TABLE PL_HOURS (
  PH_ID smallint NOT NULL,
  CYCLE_ID smallint NOT NULL,
  TOTAL_HOURS smallint NOT NULL,
  WEEKLY_HOURS smallint NOT NULL,
  SPEC_CLASS int,
  PRIMARY KEY (PH_ID)
);

CREATE TABLE PL_PERIOD_LIST (
  PL_ID smallint NOT NULL,
  EDU_PERIOD smallint NOT NULL,
  LIST_NAME varchar(28) NOT NULL,
  PRIMARY KEY (PL_ID)
);

CREATE TABLE PL_PLAN_DETAIL (
  EDU_COURSE smallint NOT NULL,
  EDU_PERIOD smallint NOT NULL,
  TOTAL_HOURS smallint NOT NULL,
  WEEKLY_HOURS smallint NOT NULL,
  PRIMARY KEY (EDU_COURSE,EDU_PERIOD)
);

CREATE TABLE SDL_RING (
  R_ID smallint NOT NULL,
  SEQ_NUM smallint NOT NULL,
  TIME_SCHEME smallint NOT NULL DEFAULT 0,
  START_TIME time,
  END_TIME time,
  PRIMARY KEY (R_ID)
);

CREATE TABLE SDL_SCHEDULE (
  S_ID int NOT NULL,
  WEEKDAY_NUM smallint NOT NULL,
  SEQ_NUM smallint NOT NULL,
  EDU_COURSE smallint NOT NULL,
  PLACE_ID smallint NOT NULL DEFAULT 0,
  SDL_FLAGS smallint NOT NULL,
  OTHER_TEACHER int,
  REASON_ID int,
  VALID_SINCE date,
  VALID_TO date,
  PRIMARY KEY (S_ID)
);

CREATE TABLE SDL_PLACE (
  P_ID smallint NOT NULL,
  SHORT_TITLE varchar(10) NOT NULL,
  FULL_NAME varchar(255),
  PRIMARY KEY (P_ID)
);

CREATE TABLE ST_DESCRIPTION (
  D_ID smallint NOT NULL,
  ENT_NAME varchar(28) NOT NULL,
  ST_DESCRIPTION varchar(28),
  STAT_FIELD varchar(28) NOT NULL,
  GR_FIELD1 varchar(28),
  GR_FIELD2 varchar(28),
  BORDER_SET smallint,
  PRIMARY KEY (D_ID)
);

CREATE TABLE ST_ENTRY (
  E_ID int NOT NULL,
  GROUPING_ID int NOT NULL,
  STAT_KEY varchar(28) NOT NULL,
  KEY_COUNT integer NOT NULL,
  PRIMARY KEY (E_ID)
);

CREATE TABLE ST_GROUPING (
  G_ID int NOT NULL,
  DESCRIPTION_ID smallint NOT NULL,
  GR_ID1 int,
  GR_ID2 int,
  GR_TOTAL integer NOT NULL,
  PRIMARY KEY (G_ID)
);

CREATE TABLE TPL_LESSON (
  THEME_ID int NOT NULL,
  LESSON_ID int NOT NULL,
  PRIMARY KEY (THEME_ID,LESSON_ID)
);

CREATE TABLE  EO_PK_TABLE (
  NAME char(40),
  PK int
);

CREATE INDEX courseIdx
  ON BASE_COURSE (EDU_GROUP);

CREATE INDEX lessonIdx
  ON BASE_LESSON (EDU_COURSE);

CREATE INDEX tabIdx
  ON BASE_TAB (EDU_COURSE);

CREATE INDEX workIdx
  ON CR_WORK (EDU_COURSE);

CREATE INDEX markIdx
  ON CR_MARK (STUDENT_ID);

CREATE INDEX schedIdx
  ON SDL_SCHEDULE (EDU_COURSE);

CREATE INDEX itogIdx
  ON AI_ITOG_RELATED (EDU_COURSE);

CREATE INDEX timeoutCrsIdx
  ON AI_STUDENT_TIMEOUT (EDU_COURSE);

CREATE INDEX timeoutItogIdx
  ON AI_STUDENT_TIMEOUT (ITOG_CONTAINER);

CREATE INDEX reprimandIdx
  ON CU_REPRIMAND (EDU_COURSE);

CREATE INDEX varLessonIdx
  ON CU_VARIATION (LESSON_ID);

CREATE INDEX varCrsIdx
  ON CU_VARIATION (EDU_COURSE);

CREATE INDEX archiveEntIdx
  ON MA_MARK_ARCHIVE (OBJ_ENTITY);

CREATE INDEX archiveKeyIdx
  ON MA_MARK_ARCHIVE(KEY2_VALUE, KEY1_VALUE);

CREATE INDEX plhrsIdx
  ON PL_HOURS (CYCLE_ID);

CREATE INDEX statIdx
  ON ST_ENTRY (GROUPING_ID);

CREATE INDEX stgrIdx
  ON ST_GROUPING (GR_ID1);

CREATE INDEX cptCrsIdx
  ON CPT_COMPLETION (EDU_COURSE);

CREATE INDEX cptStuIdx
  ON CPT_COMPLETION (STUDENT_ID);