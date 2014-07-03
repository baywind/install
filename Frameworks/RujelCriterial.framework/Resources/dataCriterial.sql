-- /* Наборы граничных значений */
-- /* USE_CLASS - имя класса Java для использования вместо набора; BS_ID - №п/п */
-- /* EXCLUDE_MIN - использовать строгое > , а не >=; BSET_NAME - имя набора; */
-- /* ZERO_VALUE - значение, которое используется при величинах меньше минимального граничного */
-- /* FORMAT_STRING - строка, в которую включается граничное значение. По принципу java.util.Formatter */
-- /* VALUE_TYPE - тип значения: 0-текст, 1-цвет, 2-изображение, 3-код HTML */
INSERT INTO CR_BORDER_SET (BS_ID, BSET_NAME, ZERO_VALUE, EXCLUDE_MIN,VALUE_TYPE) VALUES 
 (1,'~','&oslash;',0,0),
 (2,'/5','н/а',0,0),
 (3,'color','#ffffff',0,1);
 
-- /* Граничные значения в наборах */
-- /* B_ID - № п/п; B_SET - № набора; LEAST_VALUE - граничная величина; B_TITLE - возвращаемое значение */
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
 
-- /* типы работ */
INSERT INTO CR_WORK_TYPE 
(WT_ID,SORT_NUM,TYPE_NAME,DFLT_FLAGS,DFLT_WEIGHT,COLOR_NOWEIGHT,COLOR_WEIGHT) VALUES
(0,0,'классная',4,1.0,'#ffcc33','#ff9966'),
(1,1,'работа на уроке',38,0.0,'#ffff66','#ffcc66'),
(2,2,'домашняя',20,1.0,'#ccffcc','#99ff66'),
(3,3,'проектная',8,1.0,'#ff99ff','#ff99ff'),
(4,4,'дополнительная',2,1.0,'#ccffff','#ccffff');

-- /* 5-балльная система оценивания */
INSERT INTO CR_CRIT_SET (CS_ID,SET_NAME,CRITER_FLAGS)
VALUES (1,'5 баллов',1);
INSERT INTO CR_CRITERION (CRIT_SET,CRITER_NUM,DFLT_MAX)
VALUES (1,0,5);
