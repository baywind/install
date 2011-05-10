SET NAMES utf8;

/* В многолетнюю базу */
USE RujelStatic;

/* Типы итоговых */
INSERT INTO ITOG_TYPE (T_ID, SHORT_TITLE, TYPE_NAME, IN_YEAR_COUNT,  SORT_NUM) VALUES
(1,'год','Учебный Год',1,4),
(2,'сем','Полугодие',2,3),
(3,'трм','Триместр',3,2),
(4,'чтв','Четверть',4,1),
(5,'экз','Экзамен',0,5),
(6,'итог','Итоговая отметка',0,6);

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


/* Предметы учебного плана: за основу взят базисный учебный план для общего среднего образования */
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
 
/* установить свой номер школы. такой же, как в Rujel.plist */
update PL_CYCLE set SCHOOL_NUM = 0;

-- ! ! ! ! !   НАСТРОЙТЕ ! ! ! ! !   НАСТРОЙТЕ ! ! ! ! !   НАСТРОЙТЕ ! ! ! ! !   НАСТРОЙТЕ ! ! ! ! 
-- ! ! ! ! !   НАСТРОЙТЕ ! ! ! ! !   НАСТРОЙТЕ ! ! ! ! !   НАСТРОЙТЕ ! ! ! ! !   НАСТРОЙТЕ ! ! ! ! 
-- ! ! ! ! !   НАСТРОЙТЕ ! ! ! ! !   НАСТРОЙТЕ ! ! ! ! !   НАСТРОЙТЕ ! ! ! ! !   НАСТРОЙТЕ ! ! ! ! 
-- ! ! ! ! !   НАСТРОЙТЕ ! ! ! ! !   НАСТРОЙТЕ ! ! ! ! !   НАСТРОЙТЕ ! ! ! ! !   НАСТРОЙТЕ ! ! ! ! 

/* В годовую базу */
USE RujelYear2010;

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
 
 /* типы работ */
INSERT INTO CR_WORK_TYPE 
(WT_ID,SORT_NUM,TYPE_NAME,DFLT_FLAGS,DFLT_WEIGHT,COLOR_NOWEIGHT,COLOR_WEIGHT) VALUES
(0,0,'классная',4,1.0,'#ffcc66','#ff9966'),
(1,1,'домашняя',20,1.0,'#ccffcc','#99ff66'),
(2,2,'проектная',8,1.0,'#ff99ff','#ff99ff'),
(3,3,'дополнительная',2,1.0,'#ccffff','#ccffff');

/* Каникулы и праздники */
INSERT INTO PL_HOLIDAY (H_ID, HOLIDAY_NAME, DATE_BEGIN, DATE_END) VALUES
(1,'Осенние каникулы','2010-11-01','2010-11-07'),
(2,'День народного единства','2010-11-04','2010-11-04'),
(3,'Зимние каникулы','2010-12-29','2011-01-10'),
(4,'День защитника отечества','2011-02-23','2011-02-23'),
(5,'Международный женский день','2011-03-08','2011-03-08'),
(6,'Весенние каникулы','2011-03-22','2011-03-28'),
(7,'День весны и труда','2011-05-01','2011-05-01'),
(8,'День Победы','2011-05-09','2011-05-09'),
(9,'День России','2011-06-12','2011-06-12');
