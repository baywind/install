USE RujelStatic;

ALTER TABLE `BASE_COURSE`
 CHANGE COLUMN `CYCLE` `EDU_CYCLE` SMALLINT(6) NOT NULL,
 CHANGE COLUMN `TEACHER` `TEACHER_ID` MEDIUMINT(9),
 CHANGE COLUMN `COMMENT` `COMMENT_TEXT` VARCHAR(255),
 CHANGE COLUMN `FLAGS` `CR_FLAGS` TINYINT(4) NOT NULL;

ALTER TABLE `ENT_INDEX` RENAME TO `BASE_ENTITYS`,
 CHANGE COLUMN `ENT_NAME` `ENTITY_NAME` VARCHAR(28) NOT NULL;

ALTER TABLE `PRIMITIVE_EDU_CYCLE` RENAME TO `BASE_EDU_CYCLE`,
 CHANGE COLUMN `GRADE` `GRADE_NUM` TINYINT(4),
 CHANGE COLUMN `SUBGROUPS` `SUB_GROUPS` TINYINT(4) NOT NULL,
 CHANGE COLUMN `SUBJECT` `SUBJECT_NAME` VARCHAR(28);

ALTER TABLE `INDEXER` RENAME TO `BASE_INDEXER`,
 CHANGE COLUMN `TITLE` `INDEX_NAME` VARCHAR(28),
 CHANGE COLUMN `TYPE` `INDEX_TYPE` SMALLINT(4) NOT NULL;

ALTER TABLE `INDEX_ROW` RENAME TO `BASE_INDEX_ROW`,
 CHANGE COLUMN `IDX` `ROW_IDX` SMALLINT(6) NOT NULL,
 CHANGE COLUMN `IND` `INDEX_ID` SMALLINT(6) NOT NULL,
 CHANGE COLUMN `VALUE` `IDX_VALUE` VARCHAR(255);

ALTER TABLE `SETTINGS_BASE` RENAME TO `BASE_SETTINGS`;

ALTER TABLE `SETTING_BY_COURSE` RENAME TO `BASE_BY_COURSE`,
 CHANGE COLUMN `SETTINGS` `SETTING_ID` MEDIUMINT(9) NOT NULL,
 CHANGE COLUMN `COURSE` `EDU_COURSE` SMALLINT(6),
 CHANGE COLUMN `CYCLE` `EDU_CYCLE` MEDIUMINT(9),
 CHANGE COLUMN `GRADE` `GRADE_NUM` SMALLINT(6),
 CHANGE COLUMN `TEACHER` `TEACHER_ID` MEDIUMINT(9); 
 
ALTER TABLE `BORDER` RENAME TO `CR_BORDER`,
 CHANGE COLUMN `LEAST` `LEAST_VALUE` DECIMAL(4,2) NOT NULL,
 CHANGE COLUMN `TITLE` `B_TITLE` VARCHAR(28) NOT NULL;

ALTER TABLE `BORDER_SET` RENAME TO `CR_BORDER_SET`,
 CHANGE COLUMN `EXCLUDE` `EXCLUDE_MIN` TINYINT(1) NOT NULL,
 CHANGE COLUMN `TITLE` `BSET_NAME` VARCHAR(28);

ALTER TABLE `CRIT_SET` RENAME TO `CR_CRIT_SET`,
 CHANGE COLUMN `COMMENT` `COMMENT_TEXT` VARCHAR(255),
 ADD COLUMN `SET_NAME` VARCHAR(28);

ALTER TABLE `CRITERION` RENAME TO `CR_CRITERION`,
 CHANGE COLUMN `COMMENT` `COMMENT_TEXT` VARCHAR(255),
 CHANGE COLUMN `CRITERION` `CRITER_NUM` SMALLINT(6) NOT NULL,
 CHANGE COLUMN `TITLE` `CR_TITLE` VARCHAR(5);

CREATE TABLE CR_WORK_TYPE (
  WT_ID SMALLINT NOT NULL,
  SORT_NUM SMALLINT NOT NULL,
  TYPE_NAME VARCHAR(28) NOT NULL,
  DFLT_FLAGS SMALLINT NOT NULL,
  DFLT_WEIGHT DECIMAL(4,2) NOT NULL,
  COLOR_NOWEIGHT CHAR(7),
  COLOR_WEIGHT CHAR(7),
  USE_COUNT INTEGER NOT NULL,
  PRIMARY KEY(WT_ID)
);

SET NAMES utf8;
INSERT INTO CR_WORK_TYPE VALUES (0,0,'классная',12,0.0,'#ffcc66','#ff9966',4880);
INSERT INTO CR_WORK_TYPE VALUES (1,1,'домашняя',28,0.0,'#ccffcc','#99ff66',5874);
INSERT INTO CR_WORK_TYPE VALUES (2,2,'проектная',8,1.0,'#ff99ff','#ff99ff',185);
INSERT INTO CR_WORK_TYPE VALUES (3,3,'дополнительная',2,1.0,'#ccffff','#ccffff',54);

ALTER TABLE `HOLIDAY_TYPE` RENAME TO `PL_HOLIDAY_TYPE`,
 CHANGE COLUMN `NAME` `HOLIDAY_NAME` VARCHAR(28) NOT NULL;

ALTER TABLE `PLAN_CYCLE` RENAME TO `PL_CYCLE`,
 CHANGE COLUMN `GRADE` `GRADE_NUM` TINYINT(4) NOT NULL,
 CHANGE COLUMN `HOURS` `TOTAL_HOURS` SMALLINT(6) NOT NULL,
 ADD COLUMN `WEEKLY_HOURS` SMALLINT NOT NULL,
 CHANGE COLUMN `LEVEL` `LEVEL_EDU` SMALLINT(6) NOT NULL,
 CHANGE COLUMN `SCHOOL` `SCHOOL_NUM` SMALLINT(6) NOT NULL,
 CHANGE COLUMN `SUBJECT` `SUBJECT_ID` SMALLINT(6) NOT NULL,
 CHANGE COLUMN `YEAR` `EDU_YEAR` TINYINT(4) NOT NULL;

ALTER TABLE `SUBJECT` RENAME TO `PL_SUBJECT`,
 CHANGE COLUMN `AREA` `AREA_ID` SMALLINT(6) NOT NULL,
 CHANGE COLUMN `NUM` `SORT_NUM` SMALLINT(6) NOT NULL,
 CHANGE COLUMN `SUBJECT` `SHORT_NAME` VARCHAR(28) NOT NULL,
 CHANGE COLUMN `SUBGROUPS` `SUB_GROUPS` TINYINT(4) NOT NULL;

ALTER TABLE `SUBJ_AREA` RENAME TO `PL_SUBJ_AREA`,
 CHANGE COLUMN `NAME` `AREA_NAME` VARCHAR(28) NOT NULL,
 CHANGE COLUMN `NUM` `SORT_NUM` SMALLINT(6) NOT NULL;


ALTER TABLE `ITOG_COMMENT`
 CHANGE COLUMN `CONTAINER` `ITOG_CONTAINER` SMALLINT(6) NOT NULL,
 CHANGE COLUMN `CYCLE` `EDU_CYCLE` MEDIUMINT(9) NOT NULL,
 CHANGE COLUMN `STUDENT` `STUDENT_ID` INTEGER NOT NULL,
 CHANGE COLUMN `COMMENT` `COMMENT_TEXT` TEXT NOT NULL;

ALTER TABLE `ITOG` RENAME TO `ITOG_CONTAINER`,
 CHANGE COLUMN `TYPE` `ITOG_TYPE` SMALLINT(6) NOT NULL,
 CHANGE COLUMN `NUM` `ORDER_NUM` TINYINT(4);

ALTER TABLE `ITOG_MARK`
 CHANGE COLUMN `CONTAINER` `ITOG_CONTAINER` SMALLINT(6) NOT NULL,
 CHANGE COLUMN `CYCLE` `EDU_CYCLE` MEDIUMINT(9) NOT NULL,
 CHANGE COLUMN `STUDENT` `STUDENT_ID` INTEGER NOT NULL,
 CHANGE COLUMN `MARK` `MARK_TITLE` VARCHAR(5) NOT NULL,
 CHANGE COLUMN `VALUE` `SUCCESS_VALUE` DECIMAL(5,4),
 CHANGE COLUMN `FLAGS` `ITOG_FLAGS` TINYINT(4) NOT NULL,
 DROP COLUMN `COMMENT`;

ALTER TABLE `ITOG_TYPE`
 CHANGE COLUMN `TITLE` `SHORT_TITLE` VARCHAR(5),
 CHANGE COLUMN `NAME` `TYPE_NAME` VARCHAR(28),
 CHANGE COLUMN `SORT` `SORT_NUM` SMALLINT(6) NOT NULL;
