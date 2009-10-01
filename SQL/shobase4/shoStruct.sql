-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.1.23-rc

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

--
-- Create schema DemoSho
--

CREATE DATABASE IF NOT EXISTS DemoSho /*!40100 DEFAULT CHARACTER SET utf8 */;
USE DemoSho;

--
-- Definition of table `DemoSho`.`class`
--

DROP TABLE IF EXISTS `DemoSho`.`class`;
CREATE TABLE  `DemoSho`.`class` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ID_PARALLEL` int(11) NOT NULL DEFAULT '0',
  `CODE` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


--
-- Definition of table `DemoSho`.`parallel`
--

DROP TABLE IF EXISTS `DemoSho`.`parallel`;
CREATE TABLE  `DemoSho`.`parallel` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ID_NAMEPARALLEL` int(11) NOT NULL DEFAULT '0',
  `ID_STUPEN` int(11) NOT NULL DEFAULT '0',
  `YEAR` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


--
-- Definition of table `DemoSho`.`sl_nameparallel`
--

DROP TABLE IF EXISTS `DemoSho`.`sl_nameparallel`;
CREATE TABLE  `DemoSho`.`sl_nameparallel` (
  `ID` int(11) NOT NULL DEFAULT '0',
  `NAME` varchar(50) NOT NULL DEFAULT '',
  `ID_STUPEN` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `DemoSho`.`sl_nameparallel`
--

/*!40000 ALTER TABLE `sl_nameparallel` DISABLE KEYS */;
LOCK TABLES `sl_nameparallel` WRITE;
INSERT INTO `DemoSho`.`sl_nameparallel` VALUES  (1,'0',1),
 (2,'1',2),
 (3,'2',2),
 (4,'3',2),
 (5,'4',2),
 (6,'5',3),
 (7,'6',3),
 (8,'7',3),
 (9,'8',3),
 (10,'9',3),
 (11,'10',4),
 (12,'11',4),
 (13,'12',4);
UNLOCK TABLES;
/*!40000 ALTER TABLE `sl_nameparallel` ENABLE KEYS */;

--
-- Definition of table `DemoSho`.`student`
--

DROP TABLE IF EXISTS `DemoSho`.`student`;
CREATE TABLE  `DemoSho`.`student` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `FIRSTNAME` varchar(50) DEFAULT NULL,
  `LASTNAME` varchar(50) DEFAULT NULL,
  `SECONDNAME` varchar(50) DEFAULT NULL,
  `ID_SEX` int(11) DEFAULT NULL,
  `BORN_DT` date DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


--
-- Definition of table `DemoSho`.`teach`
--

DROP TABLE IF EXISTS `DemoSho`.`teach`;
CREATE TABLE  `DemoSho`.`teach` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ID_CLASS` int(11) NOT NULL DEFAULT '0',
  `ID_STUDENT` int(11) NOT NULL DEFAULT '0',
  `IS_ARHIVE` int(11) DEFAULT '0',
  PRIMARY KEY (`ID`,`ID_CLASS`,`ID_STUDENT`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


--
-- Definition of table `DemoSho`.`teacher`
--

DROP TABLE IF EXISTS `DemoSho`.`teacher`;
CREATE TABLE  `DemoSho`.`teacher` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `FIRSTNAME` varchar(20) DEFAULT NULL,
  `LASTNAME` varchar(20) DEFAULT NULL,
  `SECONDNAME` varchar(20) DEFAULT NULL,
  `SEX` char(1) DEFAULT NULL,
  `DT_ROGD` date DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
