-- MySQL dump 10.11
--
-- Host: localhost    Database: tmdmodeldb
-- ------------------------------------------------------
-- Server version	5.0.95-community-nt

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `administrator`
--

DROP TABLE IF EXISTS `administrator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `administrator` (
  `username` char(15) NOT NULL,
  `password` char(100) NOT NULL,
  `password_key` char(100) NOT NULL,
  `email_id` char(100) NOT NULL,
  `first_name` char(25) NOT NULL,
  `last_name` char(25) NOT NULL,
  `mobile_number` char(15) NOT NULL,
  PRIMARY KEY  (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `administrator`
--

LOCK TABLES `administrator` WRITE;
/*!40000 ALTER TABLE `administrator` DISABLE KEYS */;
/*!40000 ALTER TABLE `administrator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `database_architecture`
--

DROP TABLE IF EXISTS `database_architecture`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `database_architecture` (
  `code` int(11) NOT NULL auto_increment,
  `name` char(100) NOT NULL,
  `max_width_of_column_name` int(11) default NULL,
  `max_width_of_table_name` int(11) default NULL,
  `max_width_of_relationship_name` int(11) default NULL,
  PRIMARY KEY  (`code`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `database_architecture`
--

LOCK TABLES `database_architecture` WRITE;
/*!40000 ALTER TABLE `database_architecture` DISABLE KEYS */;
INSERT INTO `database_architecture` VALUES (1,'mysql',10,10,10),(2,'javadb',20,30,20),(3,'db2',40,50,40),(4,'sqlite',40,320,20);
/*!40000 ALTER TABLE `database_architecture` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `database_architecture_data_type`
--

DROP TABLE IF EXISTS `database_architecture_data_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `database_architecture_data_type` (
  `code` int(11) NOT NULL auto_increment,
  `database_architecture_code` int(11) NOT NULL,
  `data_type` char(25) NOT NULL,
  `max_width` int(11) NOT NULL,
  `default_size` int(11) default NULL,
  `max_width_of_precision` int(11) NOT NULL,
  `allow_auto_increment` tinyint(1) NOT NULL,
  PRIMARY KEY  (`code`),
  KEY `database_architecture_code` (`database_architecture_code`),
  CONSTRAINT `database_architecture_data_type_ibfk_1` FOREIGN KEY (`database_architecture_code`) REFERENCES `database_architecture` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `database_architecture_data_type`
--

LOCK TABLES `database_architecture_data_type` WRITE;
/*!40000 ALTER TABLE `database_architecture_data_type` DISABLE KEYS */;
INSERT INTO `database_architecture_data_type` VALUES (1,1,'BIT',1,0,1,0),(2,1,'BOOL',1,0,1,0),(3,1,'TINYINT',3,0,3,1),(4,1,'TINYINT UNSIGNED',3,0,3,1),(5,1,'BIGINT',19,19,19,1),(6,1,'BIGINT UNSIGNED',20,20,20,1),(7,1,'LONG VARBINARY',16777215,0,16777215,0),(8,1,'MEDIUMBLOB',16777215,0,16777215,0),(9,1,'LONGBLOB',2147483647,0,2147483647,0),(10,1,'BLOB',65535,0,65535,0),(11,1,'TINYBLOB',255,0,255,0),(12,1,'VARBINARY(x)',255,20,255,0),(13,1,'BINARY(x)',255,20,255,0),(14,1,'LONG VARCHAR',16777215,0,16777215,0),(15,1,'MEDIUMTEXT',16777215,0,16777215,0),(16,1,'LONGTEXT',2147483647,0,2147483647,0),(17,1,'TEXT',65535,0,65535,0),(18,1,'TINYTEXT',255,0,255,0),(19,1,'CHAR(x)',255,20,255,0),(20,1,'NUMERIC',65,0,65,1),(21,1,'DECIMAL(x,y)',65,10,10,1),(22,1,'INTEGER(x)',10,10,10,1),(23,1,'INTEGER UNSIGNED(x)',10,10,10,1),(24,1,'INT',10,0,10,1),(25,1,'INT UNSIGNED',10,0,10,1),(26,1,'MEDIUMINT',7,0,7,1),(27,1,'MEDIUMINT UNSIGNED',8,0,8,1),(28,1,'SMALLINT',5,0,5,1),(29,1,'SMALLINT UNSIGNED',5,0,5,1),(30,1,'FLOAT(x,y)',10,0,10,1),(31,1,'DOUBLE(x,y)',17,0,17,1),(32,1,'DOUBLE PRECISION',17,0,17,1),(33,1,'REAL',17,0,17,1),(34,1,'VARCHAR(x)',255,20,255,0),(35,1,'ENUM(list)',65535,0,65535,0),(36,1,'SET(list)',64,0,64,0),(37,1,'DATE',0,0,0,0),(38,1,'TIME',0,0,0,0),(39,1,'DATETIME',0,0,0,0),(40,1,'TIMESTAMP',0,0,0,0);
/*!40000 ALTER TABLE `database_architecture_data_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `database_engine`
--

DROP TABLE IF EXISTS `database_engine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `database_engine` (
  `code` int(11) NOT NULL auto_increment,
  `database_architecture_code` int(11) NOT NULL,
  `name` char(25) NOT NULL,
  PRIMARY KEY  (`code`),
  KEY `database_architecture_code` (`database_architecture_code`),
  CONSTRAINT `database_engine_ibfk_1` FOREIGN KEY (`database_architecture_code`) REFERENCES `database_architecture` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `database_engine`
--

LOCK TABLES `database_engine` WRITE;
/*!40000 ALTER TABLE `database_engine` DISABLE KEYS */;
INSERT INTO `database_engine` VALUES (10,1,'InnoDB'),(11,1,'MEMORY'),(12,1,'MyISAM'),(13,1,'BerkeleyDB'),(14,1,'BLACKHOLE'),(15,1,'EXAMPLE'),(16,1,'ARCHIVE'),(17,1,'CSV'),(18,1,'ndbcluster'),(19,1,'FEDERATED'),(20,1,'MRG_MYISAM'),(21,1,'ISAM'),(22,2,'sandbox'),(23,3,'sandbox'),(24,4,'sandbox'),(25,3,'merge'),(26,4,'merge');
/*!40000 ALTER TABLE `database_engine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `database_table`
--

DROP TABLE IF EXISTS `database_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `database_table` (
  `code` int(11) NOT NULL auto_increment,
  `project_code` int(11) NOT NULL,
  `name` varchar(300) NOT NULL,
  `database_engine_code` int(11) default NULL,
  `note` varchar(300) default NULL,
  `number_of_fields` int(11) default NULL,
  `x_location` int(11) default NULL,
  `y_location` int(11) default NULL,
  PRIMARY KEY  (`code`),
  KEY `project_code` (`project_code`),
  KEY `database_engine_code` (`database_engine_code`),
  CONSTRAINT `database_table_ibfk_1` FOREIGN KEY (`project_code`) REFERENCES `project` (`code`),
  CONSTRAINT `database_table_ibfk_2` FOREIGN KEY (`database_engine_code`) REFERENCES `database_engine` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `database_table`
--

LOCK TABLES `database_table` WRITE;
/*!40000 ALTER TABLE `database_table` DISABLE KEYS */;
INSERT INTO `database_table` VALUES (1,1,'Table 1',10,'',0,93,33);
/*!40000 ALTER TABLE `database_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `database_table_field`
--

DROP TABLE IF EXISTS `database_table_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `database_table_field` (
  `code` int(11) NOT NULL auto_increment,
  `table_code` int(11) NOT NULL,
  `name` varchar(300) NOT NULL,
  `database_architecture_data_type_code` int(11) NOT NULL,
  `width` int(11) NOT NULL,
  `number_of_decimal_places` int(11) NOT NULL,
  `is_primary_key` tinyint(1) NOT NULL,
  `is_auto_increment` tinyint(1) NOT NULL,
  `is_unique` tinyint(1) NOT NULL,
  `is_not_null` tinyint(1) NOT NULL,
  `default_value` varchar(800) NOT NULL,
  `check_constraint` varchar(100) NOT NULL,
  `note` varchar(300) NOT NULL,
  PRIMARY KEY  (`code`),
  KEY `table_code` (`table_code`),
  KEY `database_architecture_data_type_code` (`database_architecture_data_type_code`),
  CONSTRAINT `database_table_field_ibfk_1` FOREIGN KEY (`table_code`) REFERENCES `database_table` (`code`),
  CONSTRAINT `database_table_field_ibfk_2` FOREIGN KEY (`database_architecture_data_type_code`) REFERENCES `database_architecture_data_type` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `database_table_field`
--

LOCK TABLES `database_table_field` WRITE;
/*!40000 ALTER TABLE `database_table_field` DISABLE KEYS */;
/*!40000 ALTER TABLE `database_table_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `database_table_relationship`
--

DROP TABLE IF EXISTS `database_table_relationship`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `database_table_relationship` (
  `code` int(11) NOT NULL auto_increment,
  `name` varchar(300) NOT NULL,
  `parent_database_table_code` int(11) NOT NULL,
  `child_database_table_code` int(11) NOT NULL,
  PRIMARY KEY  (`code`),
  KEY `parent_database_table_code` (`parent_database_table_code`),
  KEY `child_database_table_code` (`child_database_table_code`),
  CONSTRAINT `database_table_relationship_ibfk_1` FOREIGN KEY (`parent_database_table_code`) REFERENCES `database_table` (`code`),
  CONSTRAINT `database_table_relationship_ibfk_2` FOREIGN KEY (`child_database_table_code`) REFERENCES `database_table` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `database_table_relationship`
--

LOCK TABLES `database_table_relationship` WRITE;
/*!40000 ALTER TABLE `database_table_relationship` DISABLE KEYS */;
/*!40000 ALTER TABLE `database_table_relationship` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `database_table_relationship_key`
--

DROP TABLE IF EXISTS `database_table_relationship_key`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `database_table_relationship_key` (
  `code` int(11) NOT NULL auto_increment,
  `database_table_relationship_code` int(11) NOT NULL,
  `parent_database_table_field_code` int(11) NOT NULL,
  `child_database_table_field_code` int(11) NOT NULL,
  PRIMARY KEY  (`code`),
  KEY `parent_database_table_field_code` (`parent_database_table_field_code`),
  KEY `child_database_table_field_code` (`child_database_table_field_code`),
  KEY `database_table_relationship_code` (`database_table_relationship_code`),
  CONSTRAINT `database_table_relationship_key_ibfk_1` FOREIGN KEY (`parent_database_table_field_code`) REFERENCES `database_table_field` (`code`),
  CONSTRAINT `database_table_relationship_key_ibfk_2` FOREIGN KEY (`child_database_table_field_code`) REFERENCES `database_table_field` (`code`),
  CONSTRAINT `database_table_relationship_key_ibfk_3` FOREIGN KEY (`database_table_relationship_code`) REFERENCES `database_table_relationship` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `database_table_relationship_key`
--

LOCK TABLES `database_table_relationship_key` WRITE;
/*!40000 ALTER TABLE `database_table_relationship_key` DISABLE KEYS */;
/*!40000 ALTER TABLE `database_table_relationship_key` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `member` (
  `code` int(11) NOT NULL auto_increment,
  `email_id` char(100) NOT NULL,
  `password` char(100) NOT NULL,
  `password_key` char(100) NOT NULL,
  `first_name` char(25) NOT NULL,
  `last_name` char(25) NOT NULL,
  `mobile_number` char(15) NOT NULL,
  `status` char(1) NOT NULL,
  `number_of_projects` int(11) NOT NULL,
  PRIMARY KEY  (`code`),
  UNIQUE KEY `email_id` (`email_id`),
  UNIQUE KEY `mobile_number` (`mobile_number`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES (1,'vinayjain703@gmail.com','OqhL3eD8itKNsLmp5fvuTw==','a1f1962c-a192-4505-8252-ba2fdbc824cf','vinay','jain','7999512904','A',0);
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member_address`
--

DROP TABLE IF EXISTS `member_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `member_address` (
  `code` int(11) NOT NULL auto_increment,
  `member_code` int(11) NOT NULL,
  `address` varchar(800) NOT NULL,
  `effective_from` date NOT NULL,
  PRIMARY KEY  (`code`),
  KEY `member_code` (`member_code`),
  CONSTRAINT `member_address_ibfk_1` FOREIGN KEY (`member_code`) REFERENCES `member` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member_address`
--

LOCK TABLES `member_address` WRITE;
/*!40000 ALTER TABLE `member_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `member_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member_subscription`
--

DROP TABLE IF EXISTS `member_subscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `member_subscription` (
  `invoice_number` int(11) NOT NULL auto_increment,
  `invoice_date` date NOT NULL,
  `member_code` int(11) NOT NULL,
  `subscription_plan_code` int(11) NOT NULL,
  `plan_type` char(1) NOT NULL,
  `quantity` int(11) NOT NULL,
  `rate` int(11) NOT NULL,
  `effective_from` date NOT NULL,
  `effective_upto` date NOT NULL,
  PRIMARY KEY  (`invoice_number`),
  KEY `member_code` (`member_code`),
  KEY `subscription_plan_code` (`subscription_plan_code`),
  CONSTRAINT `member_subscription_ibfk_1` FOREIGN KEY (`member_code`) REFERENCES `member` (`code`),
  CONSTRAINT `member_subscription_ibfk_2` FOREIGN KEY (`subscription_plan_code`) REFERENCES `subscription_plan` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member_subscription`
--

LOCK TABLES `member_subscription` WRITE;
/*!40000 ALTER TABLE `member_subscription` DISABLE KEYS */;
/*!40000 ALTER TABLE `member_subscription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member_vertification_token`
--

DROP TABLE IF EXISTS `member_vertification_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `member_vertification_token` (
  `member_code` int(11) NOT NULL,
  `token` char(100) NOT NULL,
  PRIMARY KEY  (`member_code`),
  CONSTRAINT `member_vertification_token_ibfk_1` FOREIGN KEY (`member_code`) REFERENCES `member` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member_vertification_token`
--

LOCK TABLES `member_vertification_token` WRITE;
/*!40000 ALTER TABLE `member_vertification_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `member_vertification_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project` (
  `code` int(11) NOT NULL auto_increment,
  `title` char(100) NOT NULL,
  `member_code` int(11) NOT NULL,
  `database_architecture_code` int(11) NOT NULL,
  `date_of_creation` date NOT NULL,
  `time_of_creation` time NOT NULL,
  `number_of_table` int(11) NOT NULL,
  `canvas_width` int(11) default NULL,
  `canvas_height` int(11) default NULL,
  PRIMARY KEY  (`code`),
  KEY `member_code` (`member_code`),
  KEY `database_architecture_code` (`database_architecture_code`),
  CONSTRAINT `project_ibfk_1` FOREIGN KEY (`member_code`) REFERENCES `member` (`code`),
  CONSTRAINT `project_ibfk_2` FOREIGN KEY (`database_architecture_code`) REFERENCES `database_architecture` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project`
--

LOCK TABLES `project` WRITE;
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
INSERT INTO `project` VALUES (1,'Inventory Management',1,1,'2019-03-04','18:02:56',1,580,280),(2,'inventory',1,1,'2019-03-19','14:50:45',2,580,280);
/*!40000 ALTER TABLE `project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscription_plan`
--

DROP TABLE IF EXISTS `subscription_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscription_plan` (
  `code` int(11) NOT NULL auto_increment,
  `effective_from` date NOT NULL,
  `monthly_rate` int(11) NOT NULL,
  `yearly_rate` int(11) NOT NULL,
  `free_projects` int(11) NOT NULL,
  `free_tables` int(11) NOT NULL,
  PRIMARY KEY  (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscription_plan`
--

LOCK TABLES `subscription_plan` WRITE;
/*!40000 ALTER TABLE `subscription_plan` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscription_plan` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-04-02 17:54:35
