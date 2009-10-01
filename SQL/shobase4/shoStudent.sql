﻿-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.1.23-rc

/*!40101 SET NAMES utf8 */;


/* Здесь описана структура БД и приведены примеры, как в нее можно помещать данные */
/* На всякий случай уточним: значения нумерации (ID) должны быть уникальными */
/* то есть, если в 5а последний ученик под номером 27, то в 5б первый будет 28, а не 1 */

/* имя базы данных - его можно изменить при необходимости */
USE DemoSho;

/* Параллель 5х классов */
/* № п/п , номер потока + 1, ступень обучения:{1:дошкольная; 2:начальная; 3:средняя; 4:старшая}, учебный год */

INSERT INTO parallel (ID,ID_NAMEPARALLEL,ID_STUPEN,YEAR) VALUES 
 (1,6,3,2005);

/* 5а класс */
/* № п/п , № параллели (см. выше) , полное наименование класса */

INSERT INTO class (ID,ID_PARALLEL,CODE) VALUES 
 (1,1,'5 а');
 
/* список учашихся */
/* № п/п , фамилия, имя , отчество , пол:{1:М; 2:Ж} , дата рождения ГГГГ-ММ-ДД */

INSERT INTO student (ID,FIRSTNAME,LASTNAME,SECONDNAME,ID_SEX,BORN_DT) VALUES 
 (1,'Паскачева','Ксения','Викторовна',2,'1992-04-16'),
 (2,'Бычкова','Екатерина','Денисовна',2,'1991-07-05');
 
/* список класса */
/* № п/п , № класса (см. выше), № ученика(см. выше) , статус:{0:есть; 1:выбыл; 2:прошлогодняя запись} */

INSERT INTO teach (ID,ID_CLASS,ID_STUDENT,IS_ARHIVE) VALUES 
 (1,1,1,0),
 (2,1,2,0);
 
/* Да, структура странная, но не мы ее придумывали: эта структура совместима с БД Всеобуч */
