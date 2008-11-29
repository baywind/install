-- 2008-11-23

ALTER TABLE `AutoItog`.`PROGNOSIS` 
 ADD COLUMN `BONUS` MEDIUMINT;

CREATE TABLE  `AutoItog`.`BONUS` (
  `B_ID` mediumint(9) NOT NULL,
  `STUDENT` int(11) NOT NULL,
  `CYCLE` mediumint(9) NOT NULL,
  `PERIOD` smallint(6) NOT NULL,
  `MARK` varchar(5) NOT NULL,
  `REASON` text,
  `VALUE` decimal(4,4) NOT NULL,
  PRIMARY KEY (`B_ID`)
) DEFAULT CHARSET=utf8;