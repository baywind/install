-- 2010-09-04 -- MySQL only!

USE RujelYear2008;

CREATE TABLE BASE_COURSE (
  CR_ID smallint,
  PRIMARY KEY (CR_ID)
) ENGINE=InnoDB
SELECT * from RujelStatic.BASE_COURSE;

CREATE TABLE BASE_INDEXER (
  PRIMARY KEY (IND_ID) ) ENGINE=InnoDB
  SELECT * from RujelStatic.BASE_INDEXER;

CREATE TABLE BASE_INDEX_ROW (
  PRIMARY KEY (INDEX_ID,ROW_IDX)
) ENGINE=InnoDB
SELECT * from RujelStatic.BASE_INDEX_ROW;

SET @textmax = (SELECT MAX(T_ID) from BASE_TEXT_STORE);

UPDATE BASE_INDEXER
  SET COMMENT_ID = COMMENT_ID + @textmax
  WHERE COMMENT_ID IS NOT NULL;

UPDATE BASE_INDEX_ROW
  SET COMMENT_ID = COMMENT_ID + @textmax
  WHERE COMMENT_ID IS NOT NULL;

INSERT INTO BASE_TEXT_STORE (T_ID, FROM_ENTITY, STORED_TEXT)
  SELECT T_ID + @textmax, FROM_ENTITY, STORED_TEXT FROM RujelStatic.BASE_ST_TEXT_STORE;

CREATE TABLE BASE_SETTINGS (
  PRIMARY KEY (S_ID)
) ENGINE=InnoDB
SELECT * from RujelStatic.BASE_SETTINGS;

CREATE TABLE BASE_BY_COURSE (
  EDU_CYCLE smallint,
  TEACHER_ID mediumint,
  PRIMARY KEY (SC_ID)
) ENGINE=InnoDB
SELECT * from RujelStatic.BASE_BY_COURSE
WHERE EDU_YEAR IS NULL OR EDU_YEAR = '2008';

CREATE TABLE CR_BORDER (
  PRIMARY KEY (B_ID)
) ENGINE=InnoDB
  SELECT * from RujelStatic.CR_BORDER;

CREATE TABLE CR_BORDER_SET (
  PRIMARY KEY (BS_ID)
) ENGINE=InnoDB
  SELECT * from RujelStatic.CR_BORDER_SET;

CREATE TABLE CR_CRITERION (
  PRIMARY KEY (CRIT_SET,CRITER_NUM)
) ENGINE=InnoDB
  SELECT * from RujelStatic.CR_CRITERION;

CREATE TABLE CR_CRIT_SET (
  PRIMARY KEY (CS_ID)
) ENGINE=InnoDB
  SELECT * from RujelStatic.CR_CRIT_SET;

CREATE TABLE CR_WORK_TYPE (
  PRIMARY KEY(WT_ID)
) ENGINE=InnoDB
  SELECT WT_ID, SORT_NUM, TYPE_NAME, DFLT_FLAGS, DFLT_WEIGHT, COLOR_NOWEIGHT, COLOR_WEIGHT
  from RujelStatic.CR_WORK_TYPE;

CREATE TABLE PL_HOURS (
  PH_ID smallint NOT NULL,
  CYCLE_ID smallint NOT NULL,
  TOTAL_HOURS smallint NOT NULL,
  WEEKLY_HOURS smallint NOT NULL,
  SPEC_CLASS int,
  PRIMARY KEY (PH_ID)
) ENGINE=InnoDB;

INSERT INTO PL_HOURS
SELECT C_ID,C_ID,TOTAL_HOURS,WEEKLY_HOURS,SPEC_CLASS
FROM RujelStatic.PL_CYCLE where EDU_YEAR = 0 OR EDU_YEAR >= 8;