USE VseLists;

ALTER TABLE VSE_EDU_GROUP ENGINE=InnoDB;
ALTER TABLE VSE_LIST ENGINE=InnoDB;
ALTER TABLE VSE_PERSON ENGINE=InnoDB;
ALTER TABLE VSE_STUDENT ENGINE=InnoDB;
ALTER TABLE VSE_TEACHER ENGINE=InnoDB;
ALTER TABLE EO_PK_TABLE ENGINE=InnoDB;

USE RujelStatic;

-- ALTER TABLE BASE_INDEXER ENGINE=InnoDB;
-- ALTER TABLE BASE_INDEX_ROW ENGINE=InnoDB;
ALTER TABLE BASE_BY_COURSE ENGINE=InnoDB;
ALTER TABLE BASE_COURSE ENGINE=InnoDB;
ALTER TABLE BASE_EDU_CYCLE ENGINE=InnoDB;
ALTER TABLE BASE_ENTITYS ENGINE=InnoDB;
ALTER TABLE BASE_SETTINGS ENGINE=InnoDB;
ALTER TABLE CR_BORDER ENGINE=InnoDB;
ALTER TABLE CR_BORDER_SET ENGINE=InnoDB;
ALTER TABLE CR_CRIT_SET ENGINE=InnoDB;
ALTER TABLE CR_CRITERION ENGINE=InnoDB;
-- ALTER TABLE CR_INDEX_ROW ENGINE=InnoDB;
-- ALTER TABLE CR_INDEXER ENGINE=InnoDB;
ALTER TABLE CR_WORK_TYPE ENGINE=InnoDB;
ALTER TABLE ITOG_COMMENT ENGINE=InnoDB;
ALTER TABLE ITOG_CONTAINER ENGINE=InnoDB;
ALTER TABLE ITOG_MARK ENGINE=InnoDB;
ALTER TABLE ITOG_TYPE ENGINE=InnoDB;
ALTER TABLE ITOG_TYPE_LIST ENGINE=InnoDB;
ALTER TABLE PL_CYCLE ENGINE=InnoDB;
ALTER TABLE PL_HOLIDAY_TYPE ENGINE=InnoDB;
ALTER TABLE PL_SUBJ_AREA ENGINE=InnoDB;
ALTER TABLE PL_SUBJECT ENGINE=InnoDB;
ALTER TABLE EO_PK_TABLE ENGINE=InnoDB;

USE RujelYear2009;

ALTER TABLE AI_AUTOITOG ENGINE=InnoDB;
ALTER TABLE AI_BONUS ENGINE=InnoDB;
ALTER TABLE AI_COURSE_TIMEOUT ENGINE=InnoDB;
ALTER TABLE AI_ITOG_RELATED ENGINE=InnoDB;
ALTER TABLE AI_PROGNOSIS ENGINE=InnoDB;
ALTER TABLE AI_STUDENT_TIMEOUT ENGINE=InnoDB;
ALTER TABLE BASE_AUDIENCE ENGINE=InnoDB;
ALTER TABLE BASE_LESSON ENGINE=InnoDB;
ALTER TABLE BASE_NOTE ENGINE=InnoDB;
ALTER TABLE BASE_TAB ENGINE=InnoDB;
ALTER TABLE BASE_TEACHER_CHANGE ENGINE=InnoDB;
ALTER TABLE BASE_TEXT_STORE ENGINE=InnoDB;
ALTER TABLE CR_MARK ENGINE=InnoDB;
ALTER TABLE CR_MASK ENGINE=InnoDB;
ALTER TABLE CR_NOTE ENGINE=InnoDB;
ALTER TABLE CR_WORK ENGINE=InnoDB;
ALTER TABLE CU_REASON ENGINE=InnoDB;
ALTER TABLE CU_REPRIMAND ENGINE=InnoDB;
ALTER TABLE CU_SUBSTITUTE ENGINE=InnoDB;
ALTER TABLE CU_VARIATION ENGINE=InnoDB;
ALTER TABLE MA_MARK_ARCHIVE ENGINE=InnoDB;
ALTER TABLE MA_USED_ENTITY ENGINE=InnoDB;
ALTER TABLE PL_EDU_PERIOD ENGINE=InnoDB;
ALTER TABLE PL_HOLIDAY ENGINE=InnoDB;
ALTER TABLE PL_PERIOD_LIST ENGINE=InnoDB;
ALTER TABLE PL_PLAN_DETAIL ENGINE=InnoDB;
ALTER TABLE ST_DESCRIPTION ENGINE=InnoDB;
ALTER TABLE ST_ENTRY ENGINE=InnoDB;
ALTER TABLE ST_GROUPING ENGINE=InnoDB;
ALTER TABLE EO_PK_TABLE ENGINE=InnoDB;

USE Contacts;

ALTER TABLE CNT_CONTACT ENGINE=InnoDB;
ALTER TABLE CNT_TYPE ENGINE=InnoDB;
ALTER TABLE EO_PK_TABLE ENGINE=InnoDB;