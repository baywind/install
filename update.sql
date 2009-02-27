-- 2008-11-23

ALTER TABLE `AutoItog`.`PROGNOSIS` 
 ADD COLUMN `BONUS` MEDIUMINT;

CREATE TABLE  `AutoItog`.`BONUS` (
  `B_ID` mediumint(9) NOT NULL,
  `STUDENT` int(11) NOT NULL,
  `CYCLE` mediumint(9) NOT NULL,
  `PERIOD` smallint(6) NOT NULL,
  `MARK` varchar(5) NOT NULL,
  `REASON` text,
  `VALUE` decimal(4,4) NOT NULL,
  PRIMARY KEY (`B_ID`)
) DEFAULT CHARSET=utf8;


-- 2009-01-08

ALTER TABLE `AutoItog`.`PROGNOSIS`
 DROP PRIMARY KEY,
 DROP COLUMN `PR_ID`,
 ADD PRIMARY KEY (`STUDENT`, `PERIOD`, `EDU_COURSE`);


-- 2009-01-28

USE Curriculum;

CREATE TABLE `Curriculum`.`VARIATION` (
  `V_ID` INT NOT NULL,
  `V_DATE` DATE NOT NULL,
  `VALUE` TINYINT NOT NULL,
  `COURSE` MEDIUMINT NOT NULL,
  `REASON` MEDIUMINT NOT NULL,
  PRIMARY KEY (`V_ID`)
);

DELETE FROM R USING Curriculum.REASON R 
  LEFT OUTER JOIN Curriculum.SUBSTITUTE S ON S.REASON = R.R_ID
  WHERE S.LESSON IS NULL;

ALTER TABLE `Curriculum`.`REASON` 
  MODIFY COLUMN `BEGIN` DATE NOT NULL DEFAULT '2000-09-01',
  ADD COLUMN `TEACHER` MEDIUMINT,
  ADD COLUMN `EDU_GROUP` MEDIUMINT,
  ADD COLUMN `VERIFICATION` VARCHAR(255),
  ADD COLUMN `SCHOOL` SMALLINT NOT NULL DEFAULT 0;
  
UPDATE Curriculum.REASON R
  LEFT OUTER JOIN Curriculum.SUBSTITUTE S ON S.REASON = R.R_ID
  SET R.SCHOOL = S.SCHOOL, R.BEGIN = S.LESSON_DATE, R.END = S.LESSON_DATE;
  
ALTER TABLE `Curriculum`.`SUBSTITUTE` 
  DROP PRIMARY KEY,
  MODIFY COLUMN `REASON` MEDIUMINT(9) NOT NULL,
  DROP COLUMN `SCHOOL`,
  ADD COLUMN `FACTOR` DECIMAL(4,2) NOT NULL,
  ADD PRIMARY KEY (`LESSON`, `TEACHER`);
  
UPDATE Curriculum.SUBSTITUTE S
  SET FACTOR = if(FLAGS = 1,0.5,1.0);

ALTER TABLE `Curriculum`.`SUBSTITUTE` 
  DROP COLUMN `FLAGS`;


-- 2009-02-09

ALTER TABLE `Curriculum`.`REASON`
	ADD COLUMN `EXTERNAL` BIT NOT NULL AFTER `EDU_GROUP`;

UPDATE `Curriculum`.`REASON`
	SET EXTERNAL = FALSE;

-- 2009-02-26

ALTER TABLE `Curriculum`.`REASON` ADD COLUMN `FLAGS` TINYINT NOT NULL;

UPDATE `Curriculum`.`REASON`
	SET FLAGS = if(EXTERNAL,1,0) + if(EDU_GROUP IS NULL,0,16) + if(TEACHER IS NULL,0,32);

ALTER TABLE `Curriculum`.`REASON` DROP COLUMN `EXTERNAL`;