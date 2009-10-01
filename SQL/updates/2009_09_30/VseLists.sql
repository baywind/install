USE VseLists;

ALTER TABLE `EDU_GROUP` RENAME TO `VSE_EDU_GROUP`,
 CHANGE COLUMN `TITLE` `GROUP_TITLE` VARCHAR(28),
 CHANGE COLUMN `FLAGS` `GR_FLAGS` TINYINT(4) NOT NULL;

ALTER TABLE `PERSON` RENAME TO `VSE_PERSON`,
 CHANGE COLUMN `SEX` `SEX_FLAG` BIT(1) NOT NULL;

ALTER TABLE `STUDENT` RENAME TO `VSE_STUDENT`,
 CHANGE COLUMN `PERSON` `PERSON_ID` INTEGER NOT NULL,
 CHANGE COLUMN `DELO` `LICHN_DELO` VARCHAR(28);

ALTER TABLE `TEACHER` RENAME TO `VSE_TEACHER`,
 CHANGE COLUMN `PERSON` `PERSON_ID` INTEGER NOT NULL,
 CHANGE COLUMN `DELO` `LICHN_DELO` VARCHAR(28),
 CHANGE COLUMN `POSITION` `JOB_POSITION` VARCHAR(255);

ALTER TABLE `VSE_LIST`
 CHANGE COLUMN `STUDENT` `STUDENT_ID` MEDIUMINT(9) NOT NULL;