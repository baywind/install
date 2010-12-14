SET NAMES utf8;
GRANT ALL PRIVILEGES ON `RujelYear%`.* TO 'rujel'@'localhost' IDENTIFIED BY 'RUJELpassword';

CREATE DATABASE RujelYear2010 DEFAULT CHARACTER SET utf8;
USE RujelYear2010;

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

CREATE TABLE BASE_TEXT_STORE (
  T_ID int NOT NULL,
  FROM_ENTITY smallint NOT NULL,
  STORED_TEXT text NOT NULL,
  PRIMARY KEY (T_ID)
) ENGINE=InnoDB;

CREATE TABLE BASE_COURSE (
  CR_ID smallint NOT NULL,
  EDU_CYCLE smallint NOT NULL,
  EDU_GROUP mediumint NOT NULL,
  TEACHER_ID mediumint,
  EDU_YEAR smallint NOT NULL,
  COMMENT_TEXT varchar(255),
  CR_FLAGS tinyint NOT NULL,
  PRIMARY KEY (CR_ID)
) ENGINE=InnoDB;

CREATE TABLE BASE_INDEXER (
  IND_ID smallint NOT NULL,
  INDEX_NAME varchar(28),
  INDEX_TYPE smallint NOT NULL,
  DEFAULT_VALUE varchar(255),
  FORMAT_STRING varchar(255),
  COMMENT_ID int,
  PRIMARY KEY (IND_ID)
) ENGINE=InnoDB;

CREATE TABLE BASE_INDEX_ROW (
  ROW_IDX smallint NOT NULL,
  INDEX_ID smallint NOT NULL,
  IDX_VALUE varchar(255),
  COMMENT_ID int,
  PRIMARY KEY (INDEX_ID,ROW_IDX)
) ENGINE=InnoDB;

CREATE TABLE BASE_SETTINGS (
  S_ID mediumint NOT NULL,
  SETTING_KEY varchar(28) NOT NULL,
  TEXT_VALUE varchar(255),
  NUM_VALUE int,
  PRIMARY KEY (S_ID)
) ENGINE=InnoDB;

CREATE TABLE BASE_BY_COURSE (
  SC_ID mediumint NOT NULL,
  SETTING_ID mediumint NOT NULL,
  EDU_YEAR smallint,
  EDU_COURSE smallint,
  EDU_CYCLE smallint,
  GRADE_NUM smallint,
  EDU_GROUP mediumint,
  TEACHER_ID mediumint,
  TEXT_VALUE varchar(255),
  NUM_VALUE int,
  PRIMARY KEY (SC_ID)
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

CREATE TABLE CR_BORDER (
  B_ID smallint NOT NULL,
  B_SET smallint NOT NULL,
  LEAST_VALUE decimal(4,2) NOT NULL,
  B_TITLE varchar(28) NOT NULL,
  PRIMARY KEY (B_ID)
) ENGINE=InnoDB;

/* Граничные значения в наборах */
/* B_ID - № п/п; B_SET - № набора; LEAST_VALUE - граничная величина; B_TITLE - возвращаемое значение */
INSERT INTO CR_BORDER (B_ID,B_SET,LEAST_VALUE,B_TITLE) VALUES 
 (1,1,'0.01','-'),
 (2,1,'50.00','~'),
 (3,1,'70.00','+'),
 (4,2,'0.01','2'),
 (5,2,'50.00','3'),
 (6,2,'70.00','4'),
 (7,2,'90.00','5'),
 (8,3,'0.01','#ff6666'),
 (9,3,'50.00','#ffff33'),
 (10,3,'70.00','#99ff66');
 
CREATE TABLE CR_BORDER_SET (
  BS_ID smallint NOT NULL,
  BSET_NAME varchar(28),
  VALUE_TYPE smallint NOT NULL,
  ZERO_VALUE varchar(28),
  EXCLUDE_MIN tinyint NOT NULL,
  FORMAT_STRING varchar(255),
  USE_CLASS varchar(255),
  PRIMARY KEY (BS_ID)
) ENGINE=InnoDB;

/* Наборы граничных значений */
/* USE_CLASS - имя класса Java для использования вместо набора; BS_ID - №п/п */
/* EXCLUDE_MIN - использовать строгое > , а не >=; BSET_NAME - имя набора; */
/* ZERO_VALUE - значение, которое используется при величинах меньше минимального граничного */
/* FORMAT_STRING - строка, в которую включается граничное значение. По принципу java.util.Formatter */
/* VALUE_TYPE - тип значения: 0-текст, 1-цвет, 2-изображение, 3-код HTML */
INSERT INTO CR_BORDER_SET (BS_ID, BSET_NAME, ZERO_VALUE, EXCLUDE_MIN,VALUE_TYPE) VALUES 
 (1,'~','&oslash;',0,0),
 (2,'/5','н/а',0,0),
 (3,'color','#ffffff',0,1);
 
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
) ENGINE=InnoDB;

CREATE TABLE CR_CRIT_SET (
  CS_ID smallint NOT NULL,
  SET_NAME varchar(28),
  COMMENT_TEXT varchar(255),
  CRITER_FLAGS smallint NOT NULL,
  PRIMARY KEY (CS_ID)
) ENGINE=InnoDB;

CREATE TABLE CR_WORK_TYPE (
  WT_ID smallint NOT NULL,
  SORT_NUM smallint NOT NULL,
  TYPE_NAME varchar(28) NOT NULL,
  DFLT_FLAGS smallint NOT NULL,
  DFLT_WEIGHT decimal(4,2) NOT NULL,
  COLOR_NOWEIGHT char(7),
  COLOR_WEIGHT char(7),
  PRIMARY KEY(WT_ID)
) ENGINE=InnoDB;

 /* типы работ */
INSERT INTO CR_WORK_TYPE 
(WT_ID,SORT_NUM,TYPE_NAME,DFLT_FLAGS,DFLT_WEIGHT,COLOR_NOWEIGHT,COLOR_WEIGHT) VALUES
(0,0,'классная',4,1.0,'#ffcc66','#ff9966'),
(1,1,'домашняя',20,1.0,'#ccffcc','#99ff66'),
(2,2,'проектная',8,1.0,'#ff99ff','#ff99ff'),
(3,3,'дополнительная',2,1.0,'#ccffff','#ccffff');

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

CREATE TABLE PL_EDU_PERIOD (
  P_ID smallint NOT NULL,
  EDU_YEAR smallint NOT NULL,
  DATE_BEGIN date NOT NULL,
  DATE_END date NOT NULL,
  SHORT_TITLE varchar(9) NOT NULL,
  FULL_NAME varchar(28),
  PRIMARY KEY (P_ID)
) ENGINE=InnoDB;

CREATE TABLE PL_HOLIDAY (
  H_ID smallint NOT NULL,
  HD_TYPE smallint NOT NULL,
  DATE_BEGIN date NOT NULL,
  DATE_END date NOT NULL,
  LIST_NAME varchar(28),
  PRIMARY KEY (H_ID)
) ENGINE=InnoDB;

CREATE TABLE PL_HOURS (
  PH_ID smallint NOT NULL,
  CYCLE_ID smallint NOT NULL,
  TOTAL_HOURS smallint NOT NULL,
  WEEKLY_HOURS smallint NOT NULL,
  SPEC_CLASS int,
  PRIMARY KEY (PH_ID)
) ENGINE=InnoDB;

/* Часы учебного плана: за основу взят базисный учебный план для общего среднего образования */
INSERT INTO PL_HOURS (PH_ID,CYCLE_ID,WEEKLY_HOURS) VALUES 
 (1,1,7), (3,3,2), (8,8,2), (9,9,3), (7,7,3), (12,12,2), (11,11,4), (10,10,2), (5,5,7), 
 (6,6,2), (17,17,3), (16,16,3), (15,15,3), (14,14,3), (13,13,3), (21,21,2), (22,22,2),
 (20,20,2), (19,19,2), (18,18,2), (25,25,1), (26,26,1), (24,24,1), (23,23,1), (27,27,2),
 (28,28,2), (30,30,2), (29,29,1), (31,31,2), (38,38,2), (36,36,2), (33,33,2), (34,34,1),
 (32,32,2), (35,35,2), (37,37,2), (41,41,5), (39,39,5), (43,43,5), (42,42,5), (40,40,5),
 (45,45,2), (44,44,2), (50,50,2), (48,48,1), (46,46,2), (49,49,1), (47,47,2), (52,52,2),
 (51,51,2), (53,53,2), (54,54,1), (55,55,1), (56,56,2), (57,57,1), (61,61,2), (60,60,2),
 (59,59,2), (58,58,2), (62,62,2), (64,64,1), (74,74,3), (63,63,3), (73,73,3), (69,69,1),
 (68,68,3), (66,66,2), (67,67,4), (71,71,4), (70,70,2), (72,72,2), (65,65,2), (76,76,3),
 (78,78,3), (75,75,2), (77,77,2);

CREATE TABLE PL_PERIOD_LIST (
  PL_ID smallint NOT NULL,
  EDU_PERIOD smallint NOT NULL,
  LIST_NAME varchar(28) NOT NULL,
  PRIMARY KEY (PL_ID)
) ENGINE=InnoDB;

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

CREATE TABLE  EO_PK_TABLE (
  NAME char(40),
  PK int
) ENGINE=InnoDB;


GRANT ALL PRIVILEGES ON `RujelStatic`.* TO 'rujel'@'localhost';

CREATE DATABASE RujelStatic DEFAULT CHARACTER SET utf8;
USE RujelStatic;

CREATE TABLE BASE_EDU_CYCLE (
  C_ID smallint NOT NULL,
  GRADE_NUM tinyint,
  SUBJECT_NAME varchar(28),
  SUB_GROUPS tinyint NOT NULL,
  PRIMARY KEY (C_ID)
) ENGINE=InnoDB;

CREATE TABLE BASE_ENTITYS (
  E_ID smallint NOT NULL,
  ENTITY_NAME varchar(28) NOT NULL,
  SQL_TABLE varchar(255),
  PRIMARY KEY (E_ID)
) ENGINE=InnoDB;

CREATE TABLE BASE_ST_TEXT_STORE (
  T_ID int NOT NULL,
  FROM_ENTITY smallint NOT NULL,
  STORED_TEXT text NOT NULL,
  PRIMARY KEY (T_ID)
) ENGINE=InnoDB;

CREATE TABLE ITOG_COMMENT (
  ITOG_CONTAINER smallint NOT NULL,
  EDU_CYCLE smallint NOT NULL,
  STUDENT_ID int NOT NULL,
  COMMENT_TEXT text NOT NULL,
  PRIMARY KEY (ITOG_CONTAINER,EDU_CYCLE,STUDENT_ID)
) ENGINE=InnoDB;

CREATE TABLE ITOG_CONTAINER (
  I_ID smallint NOT NULL,
  ITOG_TYPE smallint NOT NULL,
  ORDER_NUM tinyint,
  EDU_YEAR smallint NOT NULL,
  PRIMARY KEY (I_ID)
) ENGINE=InnoDB;

CREATE TABLE ITOG_MARK (
  ITOG_CONTAINER smallint NOT NULL,
  EDU_CYCLE smallint NOT NULL,
  STUDENT_ID int NOT NULL,
  MARK_TITLE varchar(5) NOT NULL,
  SUCCESS_VALUE decimal(5,4),
  ITOG_FLAGS tinyint NOT NULL,
  PRIMARY KEY (ITOG_CONTAINER,EDU_CYCLE,STUDENT_ID)
) ENGINE=InnoDB;

CREATE TABLE ITOG_TYPE (
  T_ID smallint NOT NULL,
  SHORT_TITLE varchar(5),
  TYPE_NAME varchar(28),
  IN_YEAR_COUNT tinyint NOT NULL,
  SORT_NUM smallint NOT NULL,
  PRIMARY KEY (T_ID)
) ENGINE=InnoDB;

INSERT INTO ITOG_TYPE (T_ID, SHORT_TITLE, TYPE_NAME, IN_YEAR_COUNT,  SORT_NUM) VALUES
(1,'год','Учебный Год',1,4),
(2,'сем','Полугодие',2,3),
(3,'трм','Триместр',3,2),
(4,'чтв','Четверть',4,1),
(5,'экз','Экзамен',0,5),
(6,'итог','Итоговая отметка',0,6);

CREATE TABLE ITOG_TYPE_LIST (
  TL_ID mediumint NOT NULL,
  LIST_NAME varchar(28) NOT NULL,
  ITOG_TYPE smallint NOT NULL,
  PRIMARY KEY (TL_ID)
) ENGINE=InnoDB;

CREATE TABLE PL_CYCLE (
  C_ID smallint NOT NULL,
  GRADE_NUM tinyint NOT NULL,
  SUBJECT_ID smallint NOT NULL,
  SCHOOL_NUM smallint NOT NULL,
  LEVEL_EDU smallint NOT NULL,
  PRIMARY KEY (C_ID)
) ENGINE=InnoDB;

INSERT INTO PL_CYCLE (C_ID,GRADE_NUM,SUBJECT_ID) VALUES 
 (1,6,1), (3,6,4), (8,9,1), (9,8,1), (7,9,4), (12,8,4), (11,7,1), (10,7,4), (5,5,1), (6,5,4),
 (17,9,5), (16,6,5), (15,8,5), (14,5,5), (13,7,5), (21,9,6), (22,6,6), (20,8,6), (19,5,6),
 (18,7,6), (25,9,7), (26,8,7), (24,7,7), (23,6,7), (27,9,8), (28,8,8), (30,7,8), (29,6,8),
 (31,5,9), (38,7,10), (36,8,10), (33,9,10), (34,6,10), (32,7,11), (35,9,11), (37,8,11),
 (41,5,12), (39,8,12), (43,6,12), (42,9,12), (40,7,12), (45,8,13), (44,9,13), (50,5,14),
 (48,8,14), (46,6,14), (49,9,14), (47,7,14), (52,5,15), (51,6,15), (53,7,15), (54,8,15),
 (55,8,16), (56,9,16), (57,8,17), (61,5,18), (60,8,18), (59,6,18), (58,9,18), (62,7,18),
 (64,11,1), (74,10,4), (63,11,4), (73,10,5), (69,10,1), (68,11,5), (66,11,7), (67,10,12),
 (71,11,12), (70,10,6), (72,11,6), (65,10,7), (76,10,19), (78,11,19), (75,10,18), (77,11,18);

CREATE TABLE PL_HOLIDAY_TYPE (
  HT_ID smallint NOT NULL,
  HOLIDAY_NAME varchar(28) NOT NULL,
  BEGIN_MONTH tinyint NOT NULL,
  BEGIN_DAY tinyint NOT NULL,
  END_MONTH tinyint NOT NULL,
  END_DAY tinyint NOT NULL,
  PRIMARY KEY (HT_ID)
) ENGINE=InnoDB;

/* Каникулы и праздники */
INSERT INTO PL_HOLIDAY_TYPE (HT_ID, HOLIDAY_NAME, BEGIN_MONTH, BEGIN_DAY, END_MONTH, END_DAY) VALUES
(1,'Осенние каникулы',10,1,10,7),
(2,'Зимние каникулы',11,29,12,10),
(3,'Весенние каникулы',14,22,14,28),
(4,'День народного единства',10,4,10,4),
(5,'День защитника отечества',13,23,13,23),
(6,'Международный женский день',14,8,14,8),
(7,'День весны и труда',16,1,16,1),
(8,'День Победы',16,9,16,9),
(9,'День России',17,12,17,12);
 
CREATE TABLE PL_SUBJECT (
  S_ID smallint NOT NULL,
  AREA_ID smallint NOT NULL,
  SORT_NUM smallint NOT NULL,
  SHORT_NAME varchar(28) NOT NULL,
  FULL_NAME varchar(255),
  SUB_GROUPS tinyint NOT NULL,
  NORMAL_GROUP tinyint NOT NULL,
  PRIMARY KEY (S_ID)
) ENGINE=InnoDB;

/* предметы (по областям) */
INSERT INTO PL_SUBJECT (S_ID,AREA_ID,SORT_NUM,SHORT_NAME,FULL_NAME,SUB_GROUPS,NORMAL_GROUP) VALUES 
 (1,1,1,'Русский язык',NULL,1,0),
 (2,2,2,'Алгебра','Алгебра и начала анализа',0,0),
 (3,2,3,'Геометрия',NULL,0,0),
 (4,1,2,'Литература',NULL,1,0),
 (5,3,0,'Англ.яз.','Английский язык',2,0),
 (6,4,0,'История',NULL,1,0),
 (7,4,1,'Общ-знание','Обществознание',1,0),
 (8,4,2,'География','География',1,0),
 (9,5,2,'Природ.','Природоведение',1,0),
 (10,5,5,'Биология','Биология',1,0),
 (11,5,3,'Физика',NULL,1,0),
 (12,2,1,'Математика',NULL,1,0),
 (13,5,4,'Химия',NULL,1,0),
 (14,6,0,'Искусство',NULL,1,0),
 (15,7,0,'Технология',NULL,2,0),
 (16,7,1,'ИКТ','Информатика и ИКТ',2,0),
 (17,8,0,'ОБЖ','Основы безопасности жизнедеятельности',1,0),
 (18,8,1,'Физкультура','Физическая культура',2,0),
 (19,5,1,'Ест-знание','Естествознание',1,0);

CREATE TABLE PL_SUBJ_AREA (
  A_ID smallint NOT NULL,
  AREA_NAME varchar(28) NOT NULL,
  SORT_NUM smallint NOT NULL,
  PRIMARY KEY (A_ID)
) ENGINE=InnoDB;

/* Предметные области */
INSERT INTO PL_SUBJ_AREA (A_ID,AREA_NAME,SORT_NUM) VALUES 
 (1,'Филология',1),
 (2,'Математика',3),
 (3,'Иностранный язык',2),
 (4,'Обществознание',4),
 (5,'Естествознание',5),
 (6,'Искусство',6),
 (7,'Технология',7),
 (8,'Физическая культура',8);

CREATE TABLE PRT_ACHIEVEMENT (
  A_ID int NOT NULL,
  EVENT_ID mediumint NOT NULL,
  STUDENT_ID int NOT NULL,
  ACHIEVEMENT_STRING varchar(255) NOT NULL,
  ACH_RANK smallint NOT NULL DEFAULT 0,
  WEB_LINK varchar(255),
  PRIMARY KEY (A_ID)
) ENGINE=InnoDB;

CREATE TABLE PRT_EVENT (
  E_ID mediumint NOT NULL,
  ACTUAL_DATE date NOT NULL,
  EVENT_TITLE varchar(255) NOT NULL,
  EVENT_RANK smallint NOT NULL,
  WEB_LINK varchar(255),
  PRIMARY KEY (E_ID)
) ENGINE=InnoDB;

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

CREATE TABLE  EO_PK_TABLE (
  NAME char(40),
  PK int
) ENGINE=InnoDB;


GRANT ALL PRIVILEGES ON `VseLists`.* TO 'rujel'@'localhost';

CREATE DATABASE VseLists DEFAULT CHARACTER SET utf8;
USE VseLists;

CREATE TABLE VSE_EDU_GROUP (
  GR_ID mediumint NOT NULL,
  GROUP_TITLE varchar(28),
  ABS_GRADE smallint NOT NULL,
  FIRST_YEAR smallint NOT NULL,
  LAST_YEAR smallint NOT NULL,
  GR_FLAGS tinyint NOT NULL,
  PRIMARY KEY (GR_ID)
) ENGINE=InnoDB;

CREATE TABLE VSE_LIST (
  L_ID int NOT NULL,
  EDU_GROUP mediumint NOT NULL,
  STUDENT_ID mediumint NOT NULL,
  ENTER_DT date,
  LEAVE_DT date,
  PRIMARY KEY (L_ID)
) ENGINE=InnoDB;

CREATE TABLE VSE_PERSON (
  P_ID int NOT NULL,
  LAST_NAME varchar(28) NOT NULL,
  FIRST_NAME varchar(28),
  SECOND_NAME varchar(28),
  SEX_FLAG bit NOT NULL,
  BIRTH_DATE date,
  PRIMARY KEY (P_ID)
) ENGINE=InnoDB;

CREATE TABLE VSE_STUDENT (
  S_ID mediumint NOT NULL,
  PERSON_ID int,
  ENTER_DT date,
  LEAVE_DT date,
  LICHN_DELO varchar(28),
  ABS_GRADE smallint NOT NULL,
  PRIMARY KEY (S_ID)
) ENGINE=InnoDB;

CREATE TABLE VSE_TEACHER (
  T_ID mediumint NOT NULL,
  PERSON_ID int,
  ENTER_DT date,
  LEAVE_DT date,
  LICHN_DELO varchar(28),
  JOB_POSITION varchar(255),
  PRIMARY KEY (T_ID)
) ENGINE=InnoDB;

CREATE TABLE  EO_PK_TABLE (
  NAME char(40),
  PK int
) ENGINE=InnoDB;


GRANT ALL PRIVILEGES ON `Contacts`.* TO 'rujel'@'localhost';

CREATE DATABASE Contacts DEFAULT CHARACTER SET utf8;
USE Contacts;

CREATE TABLE CNT_CONTACT (
  CON_ID int NOT NULL,
  CONTACT_STRING varchar(255),
  CNT_FLAGS smallint NOT NULL,
  KIND_DESRIPT varchar(28),
  PERS_ENTITY smallint NOT NULL,
  PERSON_ID int NOT NULL,
  CNT_TYPE smallint NOT NULL,
  PRIMARY KEY (CON_ID)
) ENGINE=InnoDB;

CREATE TABLE CNT_TYPE (
  CT_ID smallint NOT NULL,
  TYPE_NAME varchar(28),
  UTILISER_CLASS varchar(255),
  PRIMARY KEY (CT_ID)
) ENGINE=InnoDB;

INSERT INTO CNT_TYPE VALUES (1,'e-mail','net.rujel.contacts.EMailUtiliser');

CREATE TABLE  EO_PK_TABLE (
  NAME char(40),
  PK int
) ENGINE=InnoDB;


GRANT ALL PRIVILEGES ON `RujelUsers`.* TO 'rujel'@'localhost';

CREATE DATABASE RujelUsers DEFAULT CHARACTER SET utf8;
USE RujelUsers;

CREATE TABLE AUT_USER (
  U_ID mediumint NOT NULL,
  USER_NAME varchar(28) NOT NULL,
  CREDENTIAL_STRING varchar(255),
  PERSON_ID int,
  PERS_ENTITY smallint,
  PRIMARY KEY (U_ID)
) ENGINE=InnoDB;

CREATE TABLE AUT_GROUP (
  G_ID smallint NOT NULL,
  GROUP_TITLE varchar(28) NOT NULL,
  EXTERNAL_EQUIVALENT varchar(255),
  PRIMARY KEY (G_ID)
) ENGINE=InnoDB;

CREATE TABLE AUT_MEMBER (
  USER_ID mediumint NOT NULL,
  GROUP_ID smallint NOT NULL,
  PRIMARY KEY (USER_ID,GROUP_ID)
) ENGINE=InnoDB;

CREATE TABLE AUT_USER_PROPERTIES (
  P_ID mediumint NOT NULL,
  USER_ID mediumint NOT NULL,
  PROP_KEY varchar(28) NOT NULL,
  PROP_VALUE varchar(255) NOT NULL,
  PRIMARY KEY (P_ID)
) ENGINE=InnoDB;

CREATE TABLE  EO_PK_TABLE (
  NAME char(40),
  PK int
) ENGINE=InnoDB;