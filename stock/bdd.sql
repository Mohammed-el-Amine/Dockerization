-- MySQL dump 10.13  Distrib 8.0.33, for Linux (x86_64)
--
-- Host: localhost    Database: stock
-- ------------------------------------------------------
-- Server version	8.0.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `doctrine_migration_versions`
--

DROP TABLE IF EXISTS `doctrine_migration_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctrine_migration_versions`
--

LOCK TABLES `doctrine_migration_versions` WRITE;
/*!40000 ALTER TABLE `doctrine_migration_versions` DISABLE KEYS */;
INSERT INTO `doctrine_migration_versions` VALUES ('DoctrineMigrations\\Version20230613135049','2023-06-13 13:51:43',23),('DoctrineMigrations\\Version20230614093905','2023-06-14 09:40:48',21),('DoctrineMigrations\\Version20230614100404','2023-06-14 10:04:13',74);
/*!40000 ALTER TABLE `doctrine_migration_versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logo`
--

DROP TABLE IF EXISTS `logo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `create_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `update_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logo`
--

LOCK TABLES `logo` WRITE;
/*!40000 ALTER TABLE `logo` DISABLE KEYS */;
INSERT INTO `logo` VALUES (1,'LOGO UNSA 2k19','/img/LOGO_UNSA_2k19.png','2023-06-14 10:18:16','2023-06-14 10:18:16'),(2,'marius','https://www.cidj.com/sites/default/files/styles/full_offre/public/2021-10/Epitech-Technology-logo.gif?itok=1zuGzxJz','2023-06-15 15:28:27','2023-06-15 15:28:27'),(3,'amine','/here/mon/chemin','2023-06-20 13:44:37','2023-06-20 13:44:37'),(4,'test','/here/po','2023-06-20 13:51:14','2023-06-20 13:51:14'),(5,'\"','/tmp/phppqDeHg','2023-06-21 15:21:07','2023-06-21 15:21:07'),(6,'testeur pro','/tmp/phpXm9IMf','2023-06-21 15:21:36','2023-06-21 15:21:36'),(7,'Robin','/tmp/phpOecgaf','2023-06-21 15:22:51','2023-06-21 15:22:51'),(8,'j','/tmp/phpo1Chsi','2023-06-21 15:23:15','2023-06-21 15:23:15');
/*!40000 ALTER TABLE `logo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `signature`
--

DROP TABLE IF EXISTS `signature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `signature` (
  `id` int NOT NULL AUTO_INCREMENT,
  `logo_id` int DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `organization` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `adress` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `zip_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `create_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `update_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_AE880141F98F144A` (`logo_id`),
  CONSTRAINT `FK_AE880141F98F144A` FOREIGN KEY (`logo_id`) REFERENCES `logo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `signature`
--

LOCK TABLES `signature` WRITE;
/*!40000 ALTER TABLE `signature` DISABLE KEYS */;
INSERT INTO `signature` VALUES (1,1,'az','az','az','az','az','zaza','zaezeaza@oo','az','2023-06-16 13:16:49','2023-06-16 13:16:49',1),(2,2,'EVON Théo','Dévellopeur web','EPITECH','24 rue pasteur','94076','Villejuifs','theo.evon@epitech.eu','+336 62 14 39 35','2023-06-16 13:21:26','2023-06-16 13:21:26',1),(3,2,'GERARD NATHAN','Dévellopeur web','EPITECH','24 rue pasteur','94076','Villejuifs','nathan.gerard@epitech.eu','+33 6 95 43 69 83','2023-06-16 13:24:16','2023-06-16 13:24:16',1),(4,2,'MESTRON Marius','Dévellopeur web','EPITECH','24 rue pasteur','94076','Villejuifs','marius.mestron@epitech.eu','+33 7 82 24 16 67','2023-06-16 13:25:36','2023-06-16 13:25:36',1),(5,2,'MESTRON Marius','Dévellopeur web','EPITECH','24 rue pasteur','94076','Villejuifs','marius.mestron@epitech.eu','+33 7 82 24 16 67','2023-06-16 14:32:53','2023-06-16 14:32:53',1),(6,2,'MESTRON Marius','Dévellopeur web','EPITECH','24 rue pasteur','94076','Villejuifs','marius.mestron@epitech.eu','+33 7 82 24 16 67','2023-06-16 14:35:55','2023-06-16 14:35:55',1),(7,2,'MESTRON Marius','Dévellopeur web','EPITECH','24 rue pasteur','94076','Villejuifs','marius.mestron@epitech.eu','+33 7 82 24 16 67','2023-06-16 14:37:14','2023-06-16 14:37:14',1),(8,2,'MESTRON Marius','Dévellopeur web','EPITECH','24 rue pasteur','94076','Villejuifs','marius.mestron@epitech.eu','+33 7 82 24 16 67','2023-06-16 14:41:17','2023-06-16 14:41:17',1),(9,2,'MESTRON Marius','Dévellopeur web','EPITECH','24 rue pasteur','94076','Villejuifs','marius.mestron@epitech.eu','+33 7 82 24 16 67','2023-06-16 14:43:12','2023-06-16 14:43:12',1),(10,2,'MESTRON Marius','Dévellopeur web','EPITECH','24 rue pasteur','94076','Villejuifs','marius.mestron@epitech.eu','+33 7 82 24 16 67','2023-06-16 14:45:33','2023-06-16 14:45:33',1),(11,2,'MESTRON Marius','Dévellopeur web','EPITECH','24 rue pasteur','94076','Villejuifs','marius.mestron@epitech.eu','+33 7 82 24 16 67','2023-06-16 14:52:38','2023-06-16 14:52:38',1),(12,2,'MESTRON Marius','Dévellopeur web','EPITECH','24 rue pasteur','94076','Villejuifs','marius.mestron@epitech.eu','+33 7 82 24 16 67','2023-06-16 14:58:11','2023-06-16 14:58:11',1),(13,2,'MESTRON Marius','Dévellopeur web','EPITECH','24 rue pasteur','94076','Villejuifs','marius.mestron@epitech.eu','+33 7 82 24 16 67','2023-06-16 15:01:23','2023-06-16 15:01:23',1),(14,2,'MESTRON Marius','Dévellopeur web','EPITECH','24 rue pasteur','94076','Villejuifs','marius.mestron@epitech.eu','+33 7 82 24 16 67','2023-06-16 15:05:25','2023-06-16 15:05:25',1),(15,2,'MESTRON Marius','Dévellopeur web','EPITECH','24 rue pasteur','94076','Villejuifs','marius.mestron@epitech.eu','+33 7 82 24 16 67','2023-06-16 15:08:31','2023-06-16 15:08:31',1),(16,2,'MESTRON Marius','Dévellopeur web','EPITECH','24 rue pasteur','94076','Villejuifs','marius.mestron@epitech.eu','+33 7 82 24 16 67','2023-06-16 15:12:07','2023-06-16 15:12:07',1),(17,2,'MESTRON Marius','Dévellopeur web','EPITECH','24 rue pasteur','94076','Villejuifs','marius.mestron@epitech.eu','+33 7 82 24 16 67','2023-06-16 15:16:48','2023-06-16 15:16:48',1),(18,2,'MESTRON Marius','Dévellopeur web','EPITECH','24 rue pasteur','94076','Villejuifs','marius.mestron@epitech.eu','+33 7 82 24 16 67','2023-06-16 15:17:25','2023-06-16 15:17:25',1),(19,2,'MESTRON Marius','Dévellopeur web','EPITECH','24 rue pasteur','94076','Villejuifs','marius.mestron@epitech.eu','+33 7 82 24 16 67','2023-06-16 15:18:12','2023-06-16 15:18:12',1),(20,2,'MESTRON Marius','Dévellopeur web','EPITECH','24 rue pasteur','94076','Villejuifs','marius.mestron@epitech.eu','+33 7 82 24 16 67','2023-06-16 15:18:39','2023-06-16 15:18:39',1),(21,2,'MESTRON Marius','Dévellopeur web','EPITECH','24 rue pasteur','94076','Villejuifs','marius.mestron@epitech.eu','+33 7 82 24 16 67','2023-06-16 15:21:12','2023-06-16 15:21:12',1),(22,2,'MESTRON Marius','Dévellopeur web','EPITECH','24 rue pasteur','94076','Villejuifs','marius.mestron@epitech.eu','+33 7 82 24 16 67','2023-06-16 15:28:19','2023-06-16 15:28:19',1),(23,2,'MESTRON Marius','Dévellopeur web','EPITECH','24 rue pasteur','94076','Villejuifs','marius.mestron@epitech.eu','+33 7 82 24 16 67','2023-06-16 15:30:16','2023-06-16 15:30:16',1),(24,2,'MESTRON Marius','Dévellopeur web','EPITECH','24 rue pasteur','94076','Villejuifs','marius.mestron@epitech.eu','+33 7 82 24 16 67','2023-06-16 15:34:51','2023-06-16 15:34:51',1),(25,2,'MESTRON Marius','Dévellopeur web','EPITECH','24 rue pasteur','94076','Villejuifs','marius.mestron@epitech.eu','+33 7 82 24 16 67','2023-06-16 15:42:48','2023-06-16 15:42:48',1),(26,2,'Marius MESTRON','Dévellopeur web','EPITECH','24 rue pasteur','94076','Villejuifs','marius.mestron@epitech.eu','+33 7 82 24 16 67','2023-06-16 15:49:24','2023-06-16 15:49:24',1),(27,2,'Marius MESTRON','Dévellopeur web','EPITECH','24 rue pasteur','94076','Villejuifs','marius.mestron@epitech.eu','+33 7 82 24 16 67','2023-06-16 15:51:19','2023-06-16 15:51:19',1),(28,2,'Marius MESTRON','Dévellopeur web','EPITECH','24 rue pasteur','94076','Villejuifs','marius.mestron@epitech.eu','+33 7 82 24 16 67','2023-06-16 15:52:00','2023-06-16 15:52:00',1),(29,2,'Marius MESTRON','Dévellopeur web','EPITECH','24 rue pasteur','94076','Villejuifs','marius.mestron@epitech.eu','+33 7 82 24 16 67','2023-06-16 15:52:14','2023-06-16 15:52:14',1),(30,2,'Marius MESTRON','Dévellopeur web','EPITECH','24 rue pasteur','94076','Villejuifs','marius.mestron@epitech.eu','+33 7 82 24 16 67','2023-06-16 15:53:53','2023-06-16 15:53:53',1),(31,1,'mohammed el amine djellal','Dévellopeur web','Unsa','78 rue saint papille','8999','miamland','mohammed@unsa.org','+33 7 51 15 46 98','2023-06-19 09:21:16','2023-06-19 09:21:16',1),(32,2,'test','test','test','test','test','test','test@test','test','2023-06-19 09:54:55','2023-06-19 09:54:55',1),(33,1,'test','test','test','test','test','test','test@test','test','2023-06-19 09:56:02','2023-06-19 09:56:02',1),(34,1,'pdf','pdf','pdf','pdf','pdfp','pdfp','pdf@pdf','pdf','2023-06-19 12:18:16','2023-06-19 12:18:16',1),(35,1,'az az','az','az','az','az','az','az@az.aza','az','2023-06-19 12:53:26','2023-06-19 12:53:26',1),(36,1,'az az','az','az','az','az','aza','az@az.aza','az','2023-06-19 12:53:40','2023-06-19 12:53:40',1),(37,1,'az az','az','az','az','az','aza','az@az.aza','az','2023-06-19 12:54:26','2023-06-19 12:54:26',1),(38,1,'azzz','azaz','azaza','zaaza','zaa','zaa','az@az','az','2023-06-19 12:55:07','2023-06-19 12:55:07',1),(39,1,'az','azaz','zaa','zaaz','zaaz','zaz','az@azzz','azaz','2023-06-19 12:55:42','2023-06-19 12:55:42',1),(40,1,'a','a','a','a','a','a','a@a','a','2023-06-19 13:55:03','2023-06-19 13:55:03',1),(41,1,'az','az','az','az','az','az','az@az','az','2023-06-19 13:59:15','2023-06-19 13:59:15',1),(42,1,'az','az','az','az','az','az','az@az','az','2023-06-19 14:01:28','2023-06-19 14:01:28',1),(43,1,'az','az','az','az','az','az','az@az','az','2023-06-19 14:03:01','2023-06-19 14:03:01',1),(44,1,'a','a','a','a','a','a','a@a','a','2023-06-19 14:07:14','2023-06-19 14:07:14',1),(45,1,'e','e','e','e','e','e','e@e','e','2023-06-19 15:48:19','2023-06-19 15:48:19',1),(46,1,'e','e','e','e','e','e','e@e','e','2023-06-19 15:48:28','2023-06-19 15:48:28',1),(47,1,'az','az','az','az','az','az','az@a','az','2023-06-20 14:28:11','2023-06-20 14:28:11',2),(48,1,'az','z','z','z','z','z','azzz@zz','zz','2023-06-20 14:32:52','2023-06-20 14:32:52',2),(49,1,'aa','aa','aa','aa','aa','aa','aa@aa','aa','2023-06-20 14:54:21','2023-06-20 14:54:21',2),(50,1,'teste teste','testeur','testing','test test test','test','test','test@test','testee','2023-06-21 08:12:01','2023-06-21 08:12:01',14),(51,1,'az az','az','az','az','az','az','az@az','az','2023-06-21 09:11:23','2023-06-21 09:11:23',14),(52,1,'az az','az','az','az','az','az','az@az','az','2023-06-21 09:13:38','2023-06-21 09:13:38',14),(53,1,'az az','az','az','az','az','az','az@az','az','2023-06-21 09:14:02','2023-06-21 09:14:02',14),(54,1,'az az','az','az','az','az','az','az@az','az','2023-06-21 09:17:43','2023-06-21 09:17:43',14),(55,1,'az az','az','az','az','az','az','az@az','az','2023-06-21 09:20:57','2023-06-21 09:20:57',14),(56,1,'az az','az','az','az','az','az','az@az','az','2023-06-21 09:21:00','2023-06-21 09:21:00',14),(57,1,'az az','az','az','az','az','az','az@az','az','2023-06-21 09:21:46','2023-06-21 09:21:46',14),(58,1,'az az','az','az','az','az','az','az@az','az','2023-06-21 09:22:33','2023-06-21 09:22:33',14),(59,1,'az az','az','az','az','az','az','az@az','az','2023-06-21 09:23:03','2023-06-21 09:23:03',14),(60,1,'az az','az','az','az','az','az','az@az','az','2023-06-21 09:23:13','2023-06-21 09:23:13',14),(61,1,'az az','az','az','az','az','az','az@az','az','2023-06-21 09:25:44','2023-06-21 09:25:44',14),(62,1,'az az','az','az','az','az','az','az@az','az','2023-06-21 09:27:45','2023-06-21 09:27:45',14),(63,1,'az az','az','az','az','az','az','az@az','az','2023-06-21 09:28:31','2023-06-21 09:28:31',14),(64,1,'az az','az','az','az','az','az','az@az','az','2023-06-21 09:30:19','2023-06-21 09:30:19',14),(65,1,'az az','az','az','az','az','az','az@az','az','2023-06-21 09:33:59','2023-06-21 09:33:59',14),(66,1,'az az','az','az','az','az','az','az@az','az','2023-06-21 09:46:16','2023-06-21 09:46:16',14),(67,1,'az az','az','az','az','az','az','az@az','az','2023-06-21 09:49:42','2023-06-21 09:49:42',14),(68,1,'az','az','az','az','az','az','az@z','az','2023-06-21 10:58:37','2023-06-21 10:58:37',2),(69,1,'az','az','az','az','az','az','az@z','az','2023-06-21 10:59:59','2023-06-21 10:59:59',2),(70,1,'mohammed djellal','6666655','555544444','77777','889999','657','djellal@unsa.org','066666666','2023-06-21 13:09:46','2023-06-21 13:09:46',14),(71,1,'mohammed djellal','6666655','555544444','77777','889999','657','djellal@unsa.org','066666666','2023-06-21 13:10:36','2023-06-21 13:10:36',14),(72,1,'mohammed djellal','6666655','555544444','77777','889999','657','djellal@unsa.org','066666666','2023-06-21 13:13:18','2023-06-21 13:13:18',14),(73,1,'mohammed djellal','6666655','555544444','77777','889999','657','djellal@unsa.org','066666666','2023-06-21 13:14:37','2023-06-21 13:14:37',14),(74,1,'mohammed djellal','6666655','555544444','77777','889999','657','djellal@unsa.org','066666666','2023-06-21 13:16:28','2023-06-21 13:16:28',14),(75,1,'mohammed djellal','6666655','555544444','77777','889999','657','djellal@unsa.org','066666666','2023-06-21 13:30:02','2023-06-21 13:30:02',14),(76,1,'mohammed djellal','6666655','555544444','77777','889999','657','djellal@unsa.org','066666666','2023-06-21 13:30:43','2023-06-21 13:30:43',14),(77,1,'mohammed djellal','6666655','555544444','77777','889999','657','djellal@unsa.org','066666666','2023-06-21 13:31:26','2023-06-21 13:31:26',14),(78,1,'mohammed djellal','6666655','555544444','77777','889999','657','djellal@unsa.org','066666666','2023-06-21 13:33:27','2023-06-21 13:33:27',14),(79,1,'mohammed djellal','6666655','555544444','77777','889999','657','djellal@unsa.org','066666666','2023-06-21 13:34:58','2023-06-21 13:34:58',14),(80,1,'mohammed djellal','6666655','555544444','77777','889999','657','djellal@unsa.org','066666666','2023-06-21 13:35:32','2023-06-21 13:35:32',14),(81,1,'mohammed djellal','6666655','555544444','77777','889999','657','djellal@unsa.org','066666666','2023-06-21 13:36:09','2023-06-21 13:36:09',14),(82,1,'mohammed djellal','6666655','555544444','77777','889999','657','djellal@unsa.org','066666666','2023-06-21 13:37:23','2023-06-21 13:37:23',14),(83,1,'mohammed djellal','6666655','555544444','77777','889999','657','djellal@unsa.org','066666666','2023-06-21 13:38:00','2023-06-21 13:38:00',14),(84,1,'mohammed djellal','6666655','555544444','77777','889999','657','djellal@unsa.org','066666666','2023-06-21 13:40:39','2023-06-21 13:40:39',14),(85,1,'mohammed djellal','6666655','555544444','77777','889999','657','djellal@unsa.org','066666666','2023-06-21 13:41:05','2023-06-21 13:41:05',14),(86,1,'mohammed djellal','6666655','555544444','77777','889999','657','djellal@unsa.org','066666666','2023-06-21 13:41:30','2023-06-21 13:41:30',14),(87,1,'mohammed djellal','6666655','555544444','77777','889999','657','djellal@unsa.org','066666666','2023-06-21 13:41:48','2023-06-21 13:41:48',14),(88,1,'mohammed djellal','6666655','555544444','77777','889999','657','djellal@unsa.org','066666666','2023-06-21 13:43:13','2023-06-21 13:43:13',14),(89,1,'mohammed djellal','6666655','555544444','77777','889999','657','djellal@unsa.org','066666666','2023-06-21 14:07:19','2023-06-21 14:07:19',14),(90,1,'mohammed djellal','6666655','555544444','77777','889999','657','djellal@unsa.org','066666666','2023-06-21 14:13:43','2023-06-21 14:13:43',14),(91,1,'az az','az','az','ghjk','er','az','az@az','45','2023-06-21 14:33:18','2023-06-21 14:33:18',2),(92,1,'az az','az','az','ghjk','er','az','az@az','45','2023-06-21 14:33:53','2023-06-21 14:33:53',2),(93,1,'Mohammed Djellal','12','12','12','12','85','amine@unsa.org','12','2023-06-21 14:44:12','2023-06-21 14:44:12',2),(94,1,'Mohammed Djellal','12','12','12','12','85','amine@unsa.org','12','2023-06-21 14:44:57','2023-06-21 14:44:57',2),(95,1,'Mohammed Djellal','12','12','12','12','85','amine@unsa.org','12','2023-06-21 14:45:51','2023-06-21 14:45:51',2),(96,1,'Mohammed Djellal','12','12','12','12','85','amine@unsa.org','12','2023-06-21 14:47:12','2023-06-21 14:47:12',2),(97,1,'Mohammed Djellal','12','12','12','12','85','amine@unsa.org','12','2023-06-21 14:48:18','2023-06-21 14:48:18',2),(98,1,'era azeazer','azer','azer','azer','azer','azer','arzer@azer','rzea','2023-06-21 14:53:00','2023-06-21 14:53:00',14),(99,1,'era azeazer','azer','azer','azer','azer','azer','arzer@azer','rzea','2023-06-21 14:53:59','2023-06-21 14:53:59',14),(100,1,'az az','az','az','az','az','az','az@pp.u','az','2023-06-21 14:54:43','2023-06-21 14:54:43',2),(101,1,'az az','az','az','az','az','az','az@pp.u','az','2023-06-21 14:55:29','2023-06-21 14:55:29',2),(102,1,'az az','az','az','az','az','az','az@pp.u','az','2023-06-21 14:58:53','2023-06-21 14:58:53',2),(103,1,'az az','az','az','az','az','az','az@pp.u','az','2023-06-21 14:59:16','2023-06-21 14:59:16',2),(104,1,'az az','az','az','az','az','az','az@pp.u','az','2023-06-21 14:59:36','2023-06-21 14:59:36',2),(105,1,'az az','az','az','az','az','az','az@pp.u','az','2023-06-21 15:00:13','2023-06-21 15:00:13',2),(106,1,'az az','az','az','az','az','az','az@pp.u','az','2023-06-21 15:00:42','2023-06-21 15:00:42',2),(107,1,'az az','az','az','az','az','az','az@pp.u','az','2023-06-21 15:01:02','2023-06-21 15:01:02',2),(108,1,'az az','az','az','az','az','az','az@pp.u','az','2023-06-21 15:02:21','2023-06-21 15:02:21',2),(109,1,'az az','az','az','az','az','az','az@pp.u','az','2023-06-21 15:02:35','2023-06-21 15:02:35',2),(110,1,'djellal amine','45','454','45','45','45','amine@unsa.org','45','2023-06-21 15:03:49','2023-06-21 15:03:49',14),(111,1,'Djellal amine','a','a','a','a','a','a@a','a','2023-06-21 15:16:50','2023-06-21 15:16:50',2);
/*!40000 ALTER TABLE `signature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (2,'admin@unsa.org','f2d81a260dea8a100dd517984e53c56a7523d96942a834b9cdc249bd4e8c7aa9','admin','123'),(14,'amine@unsa.org','f2d81a260dea8a100dd517984e53c56a7523d96942a834b9cdc249bd4e8c7aa9','utilisateur',NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-21 15:34:50
