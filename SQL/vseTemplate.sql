SET NAMES utf8;

-- for MySQL
/*!40101 USE VseLists */;

-- Таблица VSE_PERSON : список всех персон в школе (и учителей и учеников)
/* P_ID - идентификатор персоны */
/* LAST_NAME - фамилия */
/* FIRST_NAME - имя */
/* SECOND_NAME - отчество */
/* SEX_FLAG - пол (мужской - 1, женский - 0) */
/* BIRTH_DATE - дата рождения */

INSERT INTO VSE_PERSON (P_ID, LAST_NAME, FIRST_NAME, SECOND_NAME, SEX_FLAG, BIRTH_DATE) VALUES 
 (1,'Рыкунова','Мария','Андреевна',0,'1996-02-24'),
 (2,'Комаревский','Александр','Владимирович',1,'1946-08-24');

-- Таблица VSE_TEACHER : список учителей
/* T_ID - индентификатор учителя */
/* PERSON_ID - идентификатор персоны из таблицы VSE_PERSON */
/* LICHN_DELO - номер личного дела */
/* JOB_POSITION - наименование должности */
/* ENTER_DT - дата поступления на работу в школу */
/* LEAVE_DT - дата увольнения из школы */

INSERT INTO VSE_TEACHER (T_ID, PERSON_ID, LICHN_DELO, JOB_POSITION, ENTER_DT, LEAVE_DT) VALUES 
 (1,2,'2000У1','Учитель математики','01-09-2000',NULL);


-- Таблица VSE_STUDENT : список учеников
/* S_ID - индентификатор ученика */
/* PERSON_ID - идентификатор персоны из таблицы VSE_PERSON */
/* LICHN_DELO - номер личного дела */
/* ABS_GRADE - абсолютный номер потока. вычисляется как (учебный_год - цифра класса) */
/* ENTER_DT - дата поступления в школу */
/* LEAVE_DT - дата окончания школы / выбытия из школы */

INSERT INTO VSE_STUDENT (S_ID, PERSON_ID, LICHN_DELO, ABS_GRADE, ENTER_DT, LEAVE_DT) VALUES 
 (1,1,'2007А1',2001,'2007-08-29',NULL);

-- Таблица VSE_EDU_GROUP : список классов
/* GR_ID - индентификатор класса */
/* GROUP_TITLE - название (буква) класса */
/* ABS_GRADE - абсолютный номер потока. вычисляется как (учебный_год - цифра класса) */
/* FIRST_YEAR - учебный год (осеннего семестра) образования класса */
/* LAST_YEAR - учебный год (осеннего семестра) расформирования класса */
/* GR_FLAGS - пока что не используется */

INSERT INTO VSE_EDU_GROUP (GR_ID, GROUP_TITLE, ABS_GRADE, FIRST_YEAR, LAST_YEAR, GR_FLAGS) VALUES 
 (1,'а',2001,2006,2012,0),
 (2,'б',2002,2007,2013,0);

-- Таблица VSE_LIST : списки классов
/* L_ID - номер записи */
/* EDU_GROUP - индентификатор класса из таблицы VSE_EDU_GROUP */
/* STUDENT_ID - индентификатор ученика из таблицы VSE_STUDENT */
/* ENTER_DT - дата вступления в класс (если был в классе сначала, можно оставить NULL) */
/* LEAVE_DT - дата выхода из класса (если до конца существования класса - NULL) */

INSERT INTO VSE_LIST (L_ID, EDU_GROUP, STUDENT_ID, ENTER_DT, LEAVE_DT) VALUES 
 (1,1,1,NULL,'2008-02-01');
