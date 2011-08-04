-- 2009-08-30

alter table `VseLists`.`STUDENT`
  add column `DELO` varchar(28),
  add column `ABS_GRADE` smallint NOT NULL;

update VseLists.STUDENT S, VseLists.VSE_LIST L, VseLists.EDU_GROUP G
set S.ABS_GRADE = G.FIRST_YEAR - G.START_GRADE
where S.S_ID = L.STUDENT AND L.EDU_GROUP = G.GR_ID;

alter table `VseLists`.`TEACHER`
  add column `DELO` varchar(28),
  add column `POSITION` varchar(255);
