-- /* Предметные области */
INSERT INTO PL_SUBJ_AREA (A_ID,AREA_NAME,SORT_NUM) VALUES 
 (1,'Филология',1),
 (2,'Математика',3),
 (3,'Иностранный язык',2),
 (4,'Обществознание',4),
 (5,'Естествознание',5),
 (6,'Искусство',6),
 (7,'Технология',7),
 (8,'Физическая культура',8);

-- /* предметы (по областям) */
INSERT INTO PL_SUBJECT 
 (S_ID,AREA_ID,SORT_NUM,SHORT_NAME,FULL_NAME,SUB_GROUPS,NORMAL_GROUP,SPEC_FLAGS) VALUES 
 (1,1,1,'Русский язык',NULL,1,0,0),
 (2,2,2,'Алгебра','Алгебра и начала анализа',0,0,0),
 (3,2,3,'Геометрия',NULL,0,0,0),
 (4,1,2,'Литература',NULL,1,0,0),
 (5,3,0,'Англ.яз.','Английский язык',2,0,0),
 (6,4,0,'История',NULL,1,0,0),
 (7,4,1,'Общ-знание','Обществознание',1,0,0),
 (8,4,2,'География','География',1,0,0),
 (9,5,2,'Природ.','Природоведение',1,0,0),
 (10,5,5,'Биология','Биология',1,0,0),
 (11,5,3,'Физика',NULL,1,0,0),
 (12,2,1,'Математика',NULL,1,0,0),
 (13,5,4,'Химия',NULL,1,0,0),
 (14,6,0,'Искусство',NULL,1,0,0),
 (15,7,0,'Технология',NULL,2,0,0),
 (16,7,1,'ИКТ','Информатика и ИКТ',2,0,0),
 (17,8,0,'ОБЖ','Основы безопасности жизнедеятельности',1,0,0),
 (18,8,1,'Физкультура','Физическая культура',2,0,0),
 (19,5,1,'Ест-знание','Естествознание',1,0,0);


-- /* Предметы учебного плана: за основу взят базисный учебный план для общего среднего образования */
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
 
-- /* установить свой номер школы. такой же, как в Rujel.plist */
-- update PL_CYCLE set SCHOOL_NUM = $schoolNum$;
