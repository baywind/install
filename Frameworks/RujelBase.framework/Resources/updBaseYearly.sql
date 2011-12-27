-- Schema updates for BaseYearly model --

-- v1 (0.9) --

ALTER TABLE EO_PK_TABLE
  MODIFY COLUMN PK integer;

ALTER TABLE BASE_SETTINGS
  MODIFY COLUMN S_ID smallint NOT NULL;

CREATE TABLE IF NOT EXISTS BASE_QUALIFIED_SETTINGS (
  QS_ID mediumint NOT NULL,
  SETTING_ID smallint NOT NULL,
  QUALIFIER_STRING varchar(255),
  ARGUMENTS_STRING varchar(255),
  EDU_YEAR smallint,
  ORDER_KEY smallint NOT NULL,
  TEXT_VALUE varchar(255),
  NUM_VALUE int,
  PRIMARY KEY (QS_ID)
) ENGINE=InnoDB;

INSERT INTO BASE_QUALIFIED_SETTINGS
SELECT SC_ID, SETTING_ID, 'IS' AS QUALIFIER_STRING, 
CONCAT('BaseCourse:',EDU_COURSE) AS ARGUMENTS_STRING,
EDU_YEAR, 5, TEXT_VALUE, NUM_VALUE
 FROM BASE_BY_COURSE
where EDU_COURSE IS NOT NULL;

INSERT INTO BASE_QUALIFIED_SETTINGS
SELECT SC_ID, SETTING_ID, 'cycle.grade = %d' AS QUALIFIER_STRING, 
CONCAT('("',GRADE_NUM,'")') AS ARGUMENTS_STRING,
EDU_YEAR, 1, TEXT_VALUE, NUM_VALUE
 FROM BASE_BY_COURSE
where EDU_CYCLE IS NULL AND EDU_GROUP IS NULL AND GRADE_NUM IS NOT NULL;

INSERT INTO BASE_QUALIFIED_SETTINGS
SELECT SC_ID, SETTING_ID, 'eduGroup = %@' AS QUALIFIER_STRING, 
CONCAT('("VseEduGroup:',EDU_GROUP,'")') AS ARGUMENTS_STRING,
EDU_YEAR, 2, TEXT_VALUE, NUM_VALUE
 FROM BASE_BY_COURSE
where EDU_CYCLE IS NULL AND EDU_GROUP IS NOT NULL;

INSERT INTO BASE_QUALIFIED_SETTINGS
SELECT SC_ID, SETTING_ID, 'cycle = %@' AS QUALIFIER_STRING, 
CONCAT('("PlanCycle:',EDU_CYCLE,'")') AS ARGUMENTS_STRING,
EDU_YEAR, 3, TEXT_VALUE, NUM_VALUE
 FROM BASE_BY_COURSE
where EDU_CYCLE IS NOT NULL AND EDU_GROUP IS NULL;

INSERT INTO BASE_QUALIFIED_SETTINGS
SELECT SC_ID, SETTING_ID, 'cycle = %@ AND eduGroup = %@' AS QUALIFIER_STRING, 
CONCAT('("PlanCycle:',EDU_CYCLE,'","VseEduGroup:',EDU_GROUP,'")') AS ARGUMENTS_STRING,
EDU_YEAR, 4, TEXT_VALUE, NUM_VALUE
 FROM BASE_BY_COURSE
where EDU_CYCLE IS NOT NULL AND EDU_GROUP IS NOT NULL;

ALTER TABLE BASE_COURSE
  MODIFY COLUMN EDU_GROUP mediumint;
  
CREATE TABLE IF NOT EXISTS SCHEMA_VERSION (
  MODEL_NAME varchar(255),
  VERSION_NUMBER smallint unsigned NOT NULL,
  VERSION_TITLE varchar(255),
  INSTALL_DATE timestamp
);

INSERT INTO SCHEMA_VERSION (MODEL_NAME,VERSION_NUMBER,VERSION_TITLE)
  VALUES ('BaseYearly',1,'0.9');
