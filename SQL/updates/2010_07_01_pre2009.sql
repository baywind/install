-- 2010-07-01

USE RujelYear2008;  

-- исправление привязки прогнозов
UPDATE AI_ITOG_RELATED r, AI_AUTOITOG i
set r.ITOG_CONTAINER = i.ITOG_CONTANER
where r.ITOG_CONTAINER = i.AI_ID;

-- посещаемость

-- поурочно
CREATE TABLE ATT_BYLESSON (
  STUDENT_ID int NOT NULL,
  LESSON_ID int NOT NULL,
  ATTEND_STATE tinyint NOT NULL,  -- присустсвовал/отсутствовал/опоздал/ушел раньше
  REASON_ID mediumint,
  PRIMARY KEY (STUDENT_ID,LESSON_ID)
) ENGINE=InnoDB;

-- по дням
CREATE TABLE ATT_DAY (
  D_ID int NOT NULL,
  STUDENT_ID int NOT NULL,
  ATT_DATE date NOT NULL,
  ATTEND_STATE tinyint NOT NULL,
  SKIPPED_LESSONS smallint NOT NULL,
  VISITED_LESSONS smallint NOT NULL,
  REASON_ID mediumint,
  PRIMARY KEY (D_ID)
) ENGINE=InnoDB;


-- причины, обоснования
CREATE TABLE ATT_REASON (
  R_ID mediumint NOT NULL,
  REASON_TEXT varchar(255) NOT NULL,
  REASON_TYPE smallint NOT NULL,
  VERIFY_TEXT varchar(255),
  EVENT_RANK smallint,
  PRIMARY KEY (R_ID)
) ENGINE=InnoDB;

-- списки к причинам
CREATE TABLE ATT_LIST (
  REASON_ID mediumint NOT NULL,
  STUDENT_ID int NOT NULL,
  PRIMARY KEY (REASON_ID,STUDENT_ID)
) ENGINE=InnoDB;

USE RujelYear2007;  

-- исправление привязки прогнозов
UPDATE AI_ITOG_RELATED r, AI_AUTOITOG i
set r.ITOG_CONTAINER = i.ITOG_CONTANER
where r.ITOG_CONTAINER = i.AI_ID;

-- посещаемость

-- поурочно
CREATE TABLE ATT_BYLESSON (
  STUDENT_ID int NOT NULL,
  LESSON_ID int NOT NULL,
  ATTEND_STATE tinyint NOT NULL,  -- присустсвовал/отсутствовал/опоздал/ушел раньше
  REASON_ID mediumint,
  PRIMARY KEY (STUDENT_ID,LESSON_ID)
) ENGINE=InnoDB;

-- по дням
CREATE TABLE ATT_DAY (
  D_ID int NOT NULL,
  STUDENT_ID int NOT NULL,
  ATT_DATE date NOT NULL,
  ATTEND_STATE tinyint NOT NULL,
  SKIPPED_LESSONS smallint NOT NULL,
  VISITED_LESSONS smallint NOT NULL,
  REASON_ID mediumint,
  PRIMARY KEY (D_ID)
) ENGINE=InnoDB;


-- причины, обоснования
CREATE TABLE ATT_REASON (
  R_ID mediumint NOT NULL,
  REASON_TEXT varchar(255) NOT NULL,
  REASON_TYPE smallint NOT NULL,
  VERIFY_TEXT varchar(255),
  EVENT_RANK smallint,
  PRIMARY KEY (R_ID)
) ENGINE=InnoDB;

-- списки к причинам
CREATE TABLE ATT_LIST (
  REASON_ID mediumint NOT NULL,
  STUDENT_ID int NOT NULL,
  PRIMARY KEY (REASON_ID,STUDENT_ID)
) ENGINE=InnoDB;