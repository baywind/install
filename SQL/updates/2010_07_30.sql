-- 2010-07-12

USE RujelStatic;

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

CREATE TABLE RujelYear2010.TPL_LESSON (
  THEME_ID mediumint NOT NULL,
  LESSON_ID int NOT NULL,
  PRIMARY KEY (THEME_ID,LESSON_ID)
) ENGINE=InnoDB;


alter table CR_BORDER_SET
   add column VALUE_TYPE tinyint NOT NULL default 0;

update CR_BORDER_SET set VALUE_TYPE = 1 where BSET_NAME like 'color';

alter table CR_CRIT_SET
   add column CRITER_FLAGS smallint NOT NULL default 0;

alter table CR_CRITERION
   add column CRITER_FLAGS smallint NOT NULL default 0;

update CR_CRIT_SET
  set SET_NAME = COMMENT_TEXT where SET_NAME is null;

alter table BASE_INDEXER
   add column COMMENT_ID int;

alter table PRT_ACHIEVEMENT
   add column WEB_LINK varchar(255);
