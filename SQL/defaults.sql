SET NAMES utf8;

-- for MySQL
/*!40101 USE RujelStatic */;


/* Наборы граничных значений */
/* USE_CLASS - имя класса Java для использования вместо набора; BS_ID - №п/п */
/* EXCLUDE_MIN - использовать строгое > , а не >=; BSET_NAME - имя набора; */
/* ZERO_VALUE - значение, которое используется при величинах меньше минимального граничного */
/* FORMAT_STRING - строка, в которую включается граничное значение. По принципу java.util.Formatter */
INSERT INTO CR_BORDER_SET (BS_ID, BSET_NAME, ZERO_VALUE, EXCLUDE_MIN) VALUES 
 (1,'~','&oslash;',0),
 (2,'/5','н/а',0),
 (3,'color','#ffffff',0);
 
/* Граничные значения для наборов */
/* B_ID - №п/п; B_SET - №набора; LEAST_VALUE - граничная величина; B_TITLE - возвращаемое значение */
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

/* Наборы критериев для оценивания */
/* название; №п/п */
INSERT INTO CR_CRIT_SET (CS_ID,COMMENT_TEXT) VALUES 
 (1,'Бакалавриат');

/* Установка набора критериев по умолчанию для всех */
insert into BASE_SETTINGS (S_ID,SETTING_KEY,NUM_VALUE) values (1,'CriteriaSet',1);

/* Критерии оценивания */
/* CRITER_NUM - №п/п, CRIT_SET - №набора; INDEX_ID - №индекса (не используется) */
/* CR_TITLE - заголовок(имя) критерия; COMMENT_TEXT - описание критерия */
/* DFLT_MAX - максимум по умолчанию; DFLT_WEIGHT - вес критерия по умолчанию */
INSERT INTO CR_CRITERION (CRITER_NUM,CRIT_SET,CR_TITLE) VALUES 
 (1,1,'A'),
 (2,1,'B'),
 (3,1,'C'),
 (4,1,'D'),
 (5,1,'E'),
 (6,1,'F');
 
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

/* за основу взят базисный учебный план для общего среднего образования */
INSERT INTO PL_CYCLE (C_ID,GRADE_NUM,SPEC_CLASS,SUBJECT_ID,TOTAL_HOURS,LEVEL_EDU,SCHOOL_NUM,EDU_YEAR) VALUES 
 (2,6,NULL,2,103,0,0,8),
 (1,6,NULL,1,210,0,0,0),
 (4,6,NULL,3,80,0,0,8),
 (3,6,NULL,4,70,0,0,0),
 (8,9,NULL,1,70,0,0,0),
 (9,8,NULL,1,105,0,0,0),
 (7,9,NULL,4,105,0,0,0),
 (12,8,NULL,4,70,0,0,0),
 (11,7,NULL,1,140,0,0,0),
 (10,7,NULL,4,70,0,0,0),
 (5,5,NULL,1,210,0,0,0),
 (6,5,NULL,4,70,0,0,0),
 (17,9,NULL,5,105,0,0,0),
 (16,6,NULL,5,105,0,0,0),
 (15,8,NULL,5,105,0,0,0),
 (14,5,NULL,5,105,0,0,0),
 (13,7,NULL,5,105,0,0,0),
 (21,9,NULL,6,70,0,0,0),
 (22,6,NULL,6,70,0,0,0),
 (20,8,NULL,6,70,0,0,0),
 (19,5,NULL,6,70,0,0,0),
 (18,7,NULL,6,70,0,0,0),
 (25,9,NULL,7,35,0,0,0),
 (26,8,NULL,7,35,0,0,0),
 (24,7,NULL,7,35,0,0,0),
 (23,6,NULL,7,35,0,0,0),
 (27,9,NULL,8,70,0,0,0),
 (28,8,NULL,8,70,0,0,0),
 (30,7,NULL,8,70,0,0,0),
 (29,6,NULL,8,35,0,0,0),
 (31,5,NULL,9,70,0,0,0),
 (38,7,NULL,10,70,0,0,0),
 (36,8,NULL,10,70,0,0,0),
 (33,9,NULL,10,70,0,0,0),
 (34,6,NULL,10,35,0,0,0),
 (32,7,NULL,11,70,0,0,0),
 (35,9,NULL,11,70,0,0,0),
 (37,8,NULL,11,70,0,0,0),
 (41,5,NULL,12,175,0,0,0),
 (39,8,NULL,12,175,0,0,0),
 (43,6,NULL,12,175,0,0,0),
 (42,9,NULL,12,175,0,0,0),
 (40,7,NULL,12,175,0,0,0),
 (45,8,NULL,13,70,0,0,0),
 (44,9,NULL,13,70,0,0,0),
 (50,5,NULL,14,70,0,0,0),
 (48,8,NULL,14,35,0,0,0),
 (46,6,NULL,14,70,0,0,0),
 (49,9,NULL,14,35,0,0,0),
 (47,7,NULL,14,70,0,0,0),
 (52,5,NULL,15,70,0,0,0),
 (51,6,NULL,15,70,0,0,0),
 (53,7,NULL,15,70,0,0,0),
 (54,8,NULL,15,35,0,0,0),
 (55,8,NULL,16,35,0,0,0),
 (56,9,NULL,16,70,0,0,0),
 (57,8,NULL,17,35,0,0,0),
 (61,5,NULL,18,70,0,0,0),
 (60,8,NULL,18,70,0,0,0),
 (59,6,NULL,18,70,0,0,0),
 (58,9,NULL,18,70,0,0,0),
 (62,7,NULL,18,70,0,0,0),
 (64,11,NULL,1,35,0,0,0),
 (74,10,NULL,4,105,0,0,0),
 (63,11,NULL,4,105,0,0,0),
 (73,10,NULL,5,105,0,0,0),
 (69,10,NULL,1,35,0,0,0),
 (68,11,NULL,5,105,0,0,0),
 (66,11,NULL,7,70,0,0,0),
 (67,10,NULL,12,140,0,0,0),
 (71,11,NULL,12,140,0,0,0),
 (70,10,NULL,6,70,0,0,0),
 (72,11,NULL,6,70,0,0,0),
 (65,10,NULL,7,70,0,0,0),
 (76,10,NULL,19,105,0,0,0),
 (78,11,NULL,19,105,0,0,0),
 (75,10,NULL,18,70,0,0,0),
 (77,11,NULL,18,70,0,0,0);
 
 /* установить свой номер школы. такой же, как в Rujel.plist */
 update PL_CYCLE set SCHOOL_NUM = 0;
