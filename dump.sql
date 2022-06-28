CREATE DATABASE  IF NOT EXISTS `wallpaperfactory` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `wallpaperfactory`;
-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: 91.210.171.149    Database: wallpaperfactory
-- ------------------------------------------------------
-- Server version	8.0.29

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (2,'Accountant'),(1,'Manager');
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
INSERT INTO `auth_group_permissions` VALUES (1,1,25),(2,1,26),(3,1,27),(4,1,28),(5,1,29),(6,1,30),(7,1,31),(8,1,32),(9,1,33),(10,1,34),(11,1,35),(12,1,36),(13,1,37),(14,1,38),(15,1,39),(16,1,40),(17,1,44),(18,1,45),(19,1,46),(20,1,47),(21,1,48),(22,1,49),(23,1,50),(24,1,51),(25,1,52),(26,1,53),(27,1,54),(28,1,55),(29,1,56),(30,1,57),(31,1,58),(32,1,59),(33,1,60),(34,2,24),(35,2,25),(36,2,26),(37,2,27),(38,2,28),(39,2,29),(40,2,30),(41,2,31),(42,2,32),(43,2,33),(44,2,34),(45,2,35),(46,2,36),(47,2,37),(48,2,38),(49,2,39),(50,2,40),(51,2,44),(52,2,48),(53,2,52),(54,2,56);
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add bill',6,'add_bill'),(22,'Can change bill',6,'change_bill'),(23,'Can delete bill',6,'delete_bill'),(24,'Can view bill',6,'view_bill'),(25,'Can add expense',7,'add_expense'),(26,'Can change expense',7,'change_expense'),(27,'Can delete expense',7,'delete_expense'),(28,'Can view expense',7,'view_expense'),(29,'Can add expense type',8,'add_expensetype'),(30,'Can change expense type',8,'change_expensetype'),(31,'Can delete expense type',8,'delete_expensetype'),(32,'Can view expense type',8,'view_expensetype'),(33,'Can add income',9,'add_income'),(34,'Can change income',9,'change_income'),(35,'Can delete income',9,'delete_income'),(36,'Can view income',9,'view_income'),(37,'Can add income type',10,'add_incometype'),(38,'Can change income type',10,'change_incometype'),(39,'Can delete income type',10,'delete_incometype'),(40,'Can view income type',10,'view_incometype'),(41,'Can add orders',11,'add_orders'),(42,'Can change orders',11,'change_orders'),(43,'Can delete orders',11,'delete_orders'),(44,'Can view orders',11,'view_orders'),(45,'Can add tag',12,'add_tag'),(46,'Can change tag',12,'change_tag'),(47,'Can delete tag',12,'delete_tag'),(48,'Can view tag',12,'view_tag'),(49,'Can add wallpaper material',13,'add_wallpapermaterial'),(50,'Can change wallpaper material',13,'change_wallpapermaterial'),(51,'Can delete wallpaper material',13,'delete_wallpapermaterial'),(52,'Can view wallpaper material',13,'view_wallpapermaterial'),(53,'Can add wallpapers entry',14,'add_wallpapersentry'),(54,'Can change wallpapers entry',14,'change_wallpapersentry'),(55,'Can delete wallpapers entry',14,'delete_wallpapersentry'),(56,'Can view wallpapers entry',14,'view_wallpapersentry'),(57,'Can add wallpapers premade entry has tag',15,'add_wallpaperspremadeentryhastag'),(58,'Can change wallpapers premade entry has tag',15,'change_wallpaperspremadeentryhastag'),(59,'Can delete wallpapers premade entry has tag',15,'delete_wallpaperspremadeentryhastag'),(60,'Can view wallpapers premade entry has tag',15,'view_wallpaperspremadeentryhastag'),(61,'Can add site user',16,'add_siteuser'),(62,'Can change site user',16,'change_siteuser'),(63,'Can delete site user',16,'delete_siteuser'),(64,'Can view site user',16,'view_siteuser');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bill`
--

DROP TABLE IF EXISTS `bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bill` (
  `id` bigint NOT NULL,
  `data` text CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL,
  `status` int NOT NULL,
  `date` datetime NOT NULL,
  `user_id` bigint NOT NULL,
  `order_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_bill_user_id` (`user_id`),
  KEY `fk_order_idx` (`order_id`),
  CONSTRAINT `fk_bill_user_id` FOREIGN KEY (`user_id`) REFERENCES `website_siteuser` (`id`),
  CONSTRAINT `fk_order` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bill`
--

LOCK TABLES `bill` WRITE;
/*!40000 ALTER TABLE `bill` DISABLE KEYS */;
/*!40000 ALTER TABLE `bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat`
--

DROP TABLE IF EXISTS `chat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat` (
  `id` bigint NOT NULL,
  `client_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_chat_website_siteuser1_idx` (`client_id`),
  CONSTRAINT `fk_chat_website_siteuser1` FOREIGN KEY (`client_id`) REFERENCES `website_siteuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat`
--

LOCK TABLES `chat` WRITE;
/*!40000 ALTER TABLE `chat` DISABLE KEYS */;
/*!40000 ALTER TABLE `chat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conversation`
--

DROP TABLE IF EXISTS `conversation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `conversation` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conversation`
--

LOCK TABLES `conversation` WRITE;
/*!40000 ALTER TABLE `conversation` DISABLE KEYS */;
/*!40000 ALTER TABLE `conversation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_website_siteuser_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_website_siteuser_id` FOREIGN KEY (`user_id`) REFERENCES `website_siteuser` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2022-05-09 17:42:41.802545','24','<Тэг \'Природа\'>',1,'[{\"added\": {}}]',12,1),(2,'2022-05-09 17:42:46.071984','25','<Тэг \'Море\'>',1,'[{\"added\": {}}]',12,1),(3,'2022-05-09 17:42:51.332031','26','<Тэг \'art\'>',1,'[{\"added\": {}}]',12,1),(4,'2022-05-09 17:43:02.940975','27','<Тэг \'Абстракция\'>',1,'[{\"added\": {}}]',12,1),(5,'2022-05-09 17:43:12.029689','28','<Тэг \'Узор\'>',1,'[{\"added\": {}}]',12,1),(6,'2022-05-09 17:43:20.896057','29','<Тэг \'city\'>',1,'[{\"added\": {}}]',12,1),(7,'2022-05-09 17:43:26.488468','30','<Тэг \'animal\'>',1,'[{\"added\": {}}]',12,1),(8,'2022-05-09 17:43:48.924799','30','<Тэг \'Животные\'>',2,'[{\"changed\": {\"fields\": [\"\\u0422\\u044d\\u0433\", \"\\u041e\\u0442\\u043e\\u0431\\u0440\\u0430\\u0436\\u0430\\u0435\\u043c\\u043e\\u0435 \\u043d\\u0430\\u0437\\u0432\\u0430\\u043d\\u0438\\u0435\"]}}]',12,1),(9,'2022-05-09 17:43:57.118931','29','<Тэг \'Город\'>',2,'[{\"changed\": {\"fields\": [\"\\u0422\\u044d\\u0433\", \"\\u041e\\u0442\\u043e\\u0431\\u0440\\u0430\\u0436\\u0430\\u0435\\u043c\\u043e\\u0435 \\u043d\\u0430\\u0437\\u0432\\u0430\\u043d\\u0438\\u0435\"]}}]',12,1),(10,'2022-05-09 17:44:03.586674','26','<Тэг \'Искусство\'>',2,'[{\"changed\": {\"fields\": [\"\\u0422\\u044d\\u0433\", \"\\u041e\\u0442\\u043e\\u0431\\u0440\\u0430\\u0436\\u0430\\u0435\\u043c\\u043e\\u0435 \\u043d\\u0430\\u0437\\u0432\\u0430\\u043d\\u0438\\u0435\"]}}]',12,1),(11,'2022-05-09 17:44:44.213839','31','<Тэг \'Детские\'>',1,'[{\"added\": {}}]',12,1),(12,'2022-05-09 17:45:01.955174','32','<Тэг \'Растения\'>',1,'[{\"added\": {}}]',12,1),(13,'2022-05-09 17:47:34.962949','33','<Тэг \'Тёмные\'>',1,'[{\"added\": {}}]',12,1),(14,'2022-05-09 17:47:52.837471','18','<Обои AROMATICO>',1,'[{\"added\": {}}, {\"added\": {\"name\": \"wallpapers premade entry has tag\", \"object\": \"WallpapersPremadeEntryHasTag object (31)\"}}, {\"added\": {\"name\": \"wallpapers premade entry has tag\", \"object\": \"WallpapersPremadeEntryHasTag object (32)\"}}]',14,1),(15,'2022-05-09 17:48:20.062444','34','<Тэг \'Светлые\'>',1,'[{\"added\": {}}]',12,1),(16,'2022-05-09 17:48:32.205375','35','<Тэг \'Лес\'>',1,'[{\"added\": {}}]',12,1),(17,'2022-05-09 17:48:44.817655','36','<Тэг \'Деревья\'>',1,'[{\"added\": {}}]',12,1),(18,'2022-05-09 17:50:24.414819','19','<Обои FAIRY TALE>',1,'[{\"added\": {}}, {\"added\": {\"name\": \"wallpapers premade entry has tag\", \"object\": \"WallpapersPremadeEntryHasTag object (33)\"}}, {\"added\": {\"name\": \"wallpapers premade entry has tag\", \"object\": \"WallpapersPremadeEntryHasTag object (34)\"}}, {\"added\": {\"name\": \"wallpapers premade entry has tag\", \"object\": \"WallpapersPremadeEntryHasTag object (35)\"}}, {\"added\": {\"name\": \"wallpapers premade entry has tag\", \"object\": \"WallpapersPremadeEntryHasTag object (36)\"}}]',14,1),(19,'2022-05-09 17:51:09.888915','20','<Обои INT FICHI FRACTURA>',1,'[{\"added\": {}}, {\"added\": {\"name\": \"wallpapers premade entry has tag\", \"object\": \"WallpapersPremadeEntryHasTag object (37)\"}}, {\"added\": {\"name\": \"wallpapers premade entry has tag\", \"object\": \"WallpapersPremadeEntryHasTag object (38)\"}}]',14,1),(20,'2022-05-09 17:51:46.118425','21','<Обои FOXY>',1,'[{\"added\": {}}, {\"added\": {\"name\": \"wallpapers premade entry has tag\", \"object\": \"WallpapersPremadeEntryHasTag object (39)\"}}, {\"added\": {\"name\": \"wallpapers premade entry has tag\", \"object\": \"WallpapersPremadeEntryHasTag object (40)\"}}]',14,1),(21,'2022-05-09 17:52:16.892769','37','<Тэг \'Цветы\'>',1,'[{\"added\": {}}]',12,1),(22,'2022-05-09 17:52:28.213513','22','<Обои FRAGILITY FRACTURA>',1,'[{\"added\": {}}, {\"added\": {\"name\": \"wallpapers premade entry has tag\", \"object\": \"WallpapersPremadeEntryHasTag object (41)\"}}, {\"added\": {\"name\": \"wallpapers premade entry has tag\", \"object\": \"WallpapersPremadeEntryHasTag object (42)\"}}, {\"added\": {\"name\": \"wallpapers premade entry has tag\", \"object\": \"WallpapersPremadeEntryHasTag object (43)\"}}]',14,1),(23,'2022-05-09 17:53:02.107958','23','<Обои LIGHTHOUSE>',1,'[{\"added\": {}}, {\"added\": {\"name\": \"wallpapers premade entry has tag\", \"object\": \"WallpapersPremadeEntryHasTag object (44)\"}}, {\"added\": {\"name\": \"wallpapers premade entry has tag\", \"object\": \"WallpapersPremadeEntryHasTag object (45)\"}}]',14,1),(24,'2022-05-09 17:53:39.405856','24','<Обои SCANDITOWN>',1,'[{\"added\": {}}, {\"added\": {\"name\": \"wallpapers premade entry has tag\", \"object\": \"WallpapersPremadeEntryHasTag object (46)\"}}, {\"added\": {\"name\": \"wallpapers premade entry has tag\", \"object\": \"WallpapersPremadeEntryHasTag object (47)\"}}, {\"added\": {\"name\": \"wallpapers premade entry has tag\", \"object\": \"WallpapersPremadeEntryHasTag object (48)\"}}]',14,1),(25,'2022-05-09 17:54:03.237339','25','<Обои SELENION>',1,'[{\"added\": {}}, {\"added\": {\"name\": \"wallpapers premade entry has tag\", \"object\": \"WallpapersPremadeEntryHasTag object (49)\"}}, {\"added\": {\"name\": \"wallpapers premade entry has tag\", \"object\": \"WallpapersPremadeEntryHasTag object (50)\"}}]',14,1),(26,'2022-05-09 17:55:29.645111','26','<Обои SIBERIA>',1,'[{\"added\": {}}, {\"added\": {\"name\": \"wallpapers premade entry has tag\", \"object\": \"WallpapersPremadeEntryHasTag object (51)\"}}, {\"added\": {\"name\": \"wallpapers premade entry has tag\", \"object\": \"WallpapersPremadeEntryHasTag object (52)\"}}, {\"added\": {\"name\": \"wallpapers premade entry has tag\", \"object\": \"WallpapersPremadeEntryHasTag object (53)\"}}, {\"added\": {\"name\": \"wallpapers premade entry has tag\", \"object\": \"WallpapersPremadeEntryHasTag object (54)\"}}, {\"added\": {\"name\": \"wallpapers premade entry has tag\", \"object\": \"WallpapersPremadeEntryHasTag object (55)\"}}]',14,1),(27,'2022-05-09 17:56:47.362762','27','<Обои VISION>',1,'[{\"added\": {}}, {\"added\": {\"name\": \"wallpapers premade entry has tag\", \"object\": \"WallpapersPremadeEntryHasTag object (56)\"}}, {\"added\": {\"name\": \"wallpapers premade entry has tag\", \"object\": \"WallpapersPremadeEntryHasTag object (57)\"}}]',14,1),(28,'2022-05-09 17:57:28.200153','28','<Обои WONDERLAND>',1,'[{\"added\": {}}, {\"added\": {\"name\": \"wallpapers premade entry has tag\", \"object\": \"WallpapersPremadeEntryHasTag object (58)\"}}, {\"added\": {\"name\": \"wallpapers premade entry has tag\", \"object\": \"WallpapersPremadeEntryHasTag object (59)\"}}]',14,1),(29,'2022-05-11 05:50:17.626128','22','<Обои FRAGILITY>',2,'[{\"changed\": {\"fields\": [\"\\u041d\\u0430\\u0437\\u0432\\u0430\\u043d\\u0438\\u0435\"]}}]',14,1),(30,'2022-05-12 17:46:46.052870','1','MaterialParameter object (1)',1,'[{\"added\": {}}]',17,1),(31,'2022-05-12 17:57:35.206582','2','<Свойство материала \'Для детской\'>',1,'[{\"added\": {}}]',17,1),(32,'2022-05-12 17:58:05.061779','3','<Свойство материала \'Самоклеющиеся\'>',1,'[{\"added\": {}}]',17,1),(33,'2022-05-12 17:58:22.418612','4','<Свойство материала \'Гладкие\'>',1,'[{\"added\": {}}]',17,1),(34,'2022-05-12 17:58:35.246222','5','<Свойство материала \'Фактурные\'>',1,'[{\"added\": {}}]',17,1),(35,'2022-05-12 17:59:03.661197','6','<Свойство материала \'Моющиеся\'>',1,'[{\"added\": {}}]',17,1),(36,'2022-05-14 18:10:25.038607','2','<Свойство материала \'Для детской\'>',3,'',17,1),(37,'2022-05-14 18:27:36.650684','6','<Материал Гладкий флизелин>',1,'[{\"added\": {}}, {\"added\": {\"name\": \"material has parameter\", \"object\": \"MaterialHasParameter object (1)\"}}, {\"added\": {\"name\": \"material has parameter\", \"object\": \"MaterialHasParameter object (2)\"}}]',13,1),(38,'2022-05-14 18:36:08.648333','7','<Материал Флизелин + штукатурка>',1,'[{\"added\": {}}, {\"added\": {\"name\": \"material has parameter\", \"object\": \"MaterialHasParameter object (3)\"}}, {\"added\": {\"name\": \"material has parameter\", \"object\": \"MaterialHasParameter object (4)\"}}]',13,1),(39,'2022-05-14 18:37:55.630299','8','<Материал Матовые самоклеющиеся>',1,'[{\"added\": {}}, {\"added\": {\"name\": \"material has parameter\", \"object\": \"MaterialHasParameter object (5)\"}}, {\"added\": {\"name\": \"material has parameter\", \"object\": \"MaterialHasParameter object (6)\"}}]',13,1),(40,'2022-05-14 18:40:01.594518','9','<Материал Пожаростойкие>',1,'[{\"added\": {}}, {\"added\": {\"name\": \"material has parameter\", \"object\": \"MaterialHasParameter object (7)\"}}, {\"added\": {\"name\": \"material has parameter\", \"object\": \"MaterialHasParameter object (8)\"}}]',13,1),(41,'2022-05-14 18:42:43.396481','7','<Свойство материала \'Подходят для рисования\'>',1,'[{\"added\": {}}]',17,1),(42,'2022-05-14 18:43:02.275784','10','<Материал Для рисования>',1,'[{\"added\": {}}, {\"added\": {\"name\": \"material has parameter\", \"object\": \"MaterialHasParameter object (9)\"}}, {\"added\": {\"name\": \"material has parameter\", \"object\": \"MaterialHasParameter object (10)\"}}]',13,1),(43,'2022-05-14 18:47:48.038908','8','<Свойство материала \'Суперстойкие\'>',1,'[{\"added\": {}}]',17,1),(44,'2022-05-14 18:47:55.551420','11','<Материал Флизелин + штукатурка с фактурой ткани>',1,'[{\"added\": {}}, {\"added\": {\"name\": \"material has parameter\", \"object\": \"MaterialHasParameter object (11)\"}}, {\"added\": {\"name\": \"material has parameter\", \"object\": \"MaterialHasParameter object (12)\"}}]',13,1),(45,'2022-05-14 18:48:06.160708','7','<Материал Флизелин + штукатурка>',2,'[{\"added\": {\"name\": \"material has parameter\", \"object\": \"MaterialHasParameter object (13)\"}}]',13,1),(46,'2022-05-14 18:48:25.312174','10','<Материал Холст для рисования>',2,'[{\"changed\": {\"fields\": [\"\\u041e\\u0442\\u043e\\u0431\\u0440\\u0430\\u0436\\u0430\\u0435\\u043c\\u043e\\u0435 \\u043d\\u0430\\u0437\\u0432\\u0430\\u043d\\u0438\\u0435\"]}}]',13,1),(47,'2022-05-14 18:49:50.022329','12','<Материал Флизелин + крошка штукатурки>',1,'[{\"added\": {}}, {\"added\": {\"name\": \"material has parameter\", \"object\": \"MaterialHasParameter object (14)\"}}, {\"added\": {\"name\": \"material has parameter\", \"object\": \"MaterialHasParameter object (15)\"}}]',13,1),(48,'2022-05-14 18:51:34.724782','10','<Материал Холст для рисования>',2,'[]',13,1),(49,'2022-05-14 18:52:01.210343','13','<Материал Холст для рисования самоклеющийся>',1,'[{\"added\": {}}, {\"added\": {\"name\": \"material has parameter\", \"object\": \"MaterialHasParameter object (16)\"}}, {\"added\": {\"name\": \"material has parameter\", \"object\": \"MaterialHasParameter object (17)\"}}, {\"added\": {\"name\": \"material has parameter\", \"object\": \"MaterialHasParameter object (18)\"}}]',13,1),(50,'2022-06-06 18:31:42.709905','1','Order object (1)',1,'[{\"added\": {}}]',18,1),(51,'2022-06-06 18:33:16.109118','2','<Заказ \'2\'>',1,'[{\"added\": {}}]',18,1),(52,'2022-06-06 18:34:35.309921','2','<Заказ \'2\'>',3,'',18,1),(53,'2022-06-06 18:35:27.478938','3','<Заказ \'3\'>',1,'[{\"added\": {}}]',18,1),(54,'2022-06-06 18:36:13.133720','4','<Заказ \'4\'>',1,'[{\"added\": {}}]',18,1),(55,'2022-06-06 18:56:36.626897','1','<Заказ \'1\'>',2,'[{\"changed\": {\"fields\": [\"\\u0414\\u0430\\u0442\\u0430 \\u0438 \\u0432\\u0440\\u0435\\u043c\\u044f\"]}}]',18,1),(56,'2022-06-06 18:56:45.270280','3','<Заказ \'3\'>',2,'[{\"changed\": {\"fields\": [\"\\u0414\\u0430\\u0442\\u0430 \\u0438 \\u0432\\u0440\\u0435\\u043c\\u044f\"]}}]',18,1),(57,'2022-06-06 20:08:51.827864','4','<Заказ \'4\'>',2,'[{\"changed\": {\"fields\": [\"Material\"]}}]',18,1),(58,'2022-06-06 20:08:56.860652','3','<Заказ \'3\'>',2,'[{\"changed\": {\"fields\": [\"Material\"]}}]',18,1),(59,'2022-06-06 20:09:03.497205','1','<Заказ \'1\'>',2,'[{\"changed\": {\"fields\": [\"Material\"]}}]',18,1),(60,'2022-06-17 22:58:54.641075','5','<Заказ \'5\'>',2,'[{\"changed\": {\"fields\": [\"\\u0414\\u0430\\u043d\\u043d\\u044b\\u0435\", \"\\u0410\\u0434\\u0440\\u0435\\u0441\"]}}]',18,1),(61,'2022-06-18 14:50:13.234307','1','<Пункт выдачи \'ул. Пугачевская, 6\'>',1,'[{\"added\": {}}]',19,1),(62,'2022-06-18 14:50:30.185549','2','<Пункт выдачи \'ул. Циолковского, 7\'>',1,'[{\"added\": {}}]',19,1),(63,'2022-06-18 14:51:00.579293','3','<Пункт выдачи \'ул. Рабоче-Крестьянская, 12\'>',1,'[{\"added\": {}}]',19,1),(64,'2022-06-18 14:51:25.783212','4','<Пункт выдачи \'ул. Социалистическая, 20\'>',1,'[{\"added\": {}}]',19,1),(65,'2022-06-18 20:11:40.079258','10','<Материал Холст для рисования>',2,'[{\"changed\": {\"fields\": [\"\\u041a\\u043e\\u0434\\u043e\\u0432\\u043e\\u0435 \\u043d\\u0430\\u0437\\u0432\\u0430\\u043d\\u0438\\u0435\"]}}]',13,1),(66,'2022-06-18 21:50:42.613103','1','ExpenseType object (1)',1,'[{\"added\": {}}]',8,1),(67,'2022-06-18 21:51:06.043262','1','ExpenseType object (1)',2,'[]',8,1),(68,'2022-06-18 21:51:52.057248','2','ExpenseType object (2)',1,'[{\"added\": {}}]',8,1),(69,'2022-06-18 21:52:05.213194','2','ExpenseType object (2)',2,'[{\"changed\": {\"fields\": [\"Type\"]}}]',8,1),(70,'2022-06-18 21:52:12.005236','2','ExpenseType object (2)',2,'[{\"changed\": {\"fields\": [\"Type\"]}}]',8,1),(71,'2022-06-18 23:53:37.193111','2','felucca25@gmail.com',1,'[{\"added\": {}}]',16,1),(72,'2022-06-18 23:55:07.690048','2','felucca25@gmail.com',2,'[{\"changed\": {\"fields\": [\"Password\"]}}]',16,1),(73,'2022-06-18 23:59:17.234250','1','Менеджер',1,'[{\"added\": {}}]',3,1),(74,'2022-06-19 00:00:33.591254','2','felucca25@gmail.com',2,'[{\"changed\": {\"fields\": [\"Groups\"]}}]',16,1),(75,'2022-06-19 15:11:29.262104','2','Accountant',1,'[{\"added\": {}}]',3,1),(76,'2022-06-19 15:11:51.538513','1','felucca24@gmail.com',2,'[{\"changed\": {\"fields\": [\"Groups\"]}}]',16,1),(77,'2022-06-19 15:12:22.044564','1','Manager',2,'[{\"changed\": {\"fields\": [\"Name\"]}}]',3,1),(78,'2022-06-19 18:41:15.199561','3','Покупка рекламы на уличном баннере',1,'[{\"added\": {}}]',8,1),(79,'2022-06-19 18:41:39.673562','4','Покупка вывески',1,'[{\"added\": {}}]',8,1),(80,'2022-06-19 18:42:02.803107','5','Закупка оборудования',1,'[{\"added\": {}}]',8,1),(81,'2022-06-19 18:48:48.591322','1','Продажа готовых обоев',1,'[{\"added\": {}}]',10,1),(82,'2022-06-19 18:49:33.293928','2','Продажа обоев с индивидуальным дизайном',1,'[{\"added\": {}}]',10,1),(83,'2022-06-19 18:50:23.227719','7','<Заказ \'7\'>',3,'',18,1),(84,'2022-06-19 18:50:23.270561','6','<Заказ \'6\'>',3,'',18,1),(85,'2022-06-19 18:50:23.311845','5','<Заказ \'5\'>',3,'',18,1),(86,'2022-06-19 18:50:23.351585','4','<Заказ \'4\'>',3,'',18,1),(87,'2022-06-19 18:50:23.404552','3','<Заказ \'3\'>',3,'',18,1),(88,'2022-06-19 18:50:23.447598','1','<Заказ \'1\'>',3,'',18,1),(89,'2022-06-19 19:27:49.560559','10','<Заказ \'10\'>',3,'',18,1),(90,'2022-06-19 19:27:49.603563','9','<Заказ \'9\'>',3,'',18,1),(91,'2022-06-19 19:27:49.647555','8','<Заказ \'8\'>',3,'',18,1),(92,'2022-06-19 19:30:38.910523','1','Расход 25000.0₽ - Покупка вывески',1,'[{\"added\": {}}]',7,1),(93,'2022-06-19 19:30:53.126556','2','Расход 20000.0₽ - Покупка рекламы в интернете',1,'[{\"added\": {}}]',7,1),(94,'2022-06-19 19:31:07.933694','3','Расход 100000.0₽ - Закупка материалов',1,'[{\"added\": {}}]',7,1),(95,'2022-06-19 19:31:19.441580','4','Расход 112000.0₽ - Закупка оборудования',1,'[{\"added\": {}}]',7,1),(96,'2022-06-19 19:37:15.437564','3','Инвестиция',1,'[{\"added\": {}}]',10,1),(97,'2022-06-19 19:37:55.519561','4','Доход 50000.0₽ - Инвестиция',1,'[{\"added\": {}}]',9,1),(98,'2022-06-21 13:36:09.732634','20','<Обои FICHI FRACTURA>',2,'[{\"changed\": {\"fields\": [\"\\u041d\\u0430\\u0437\\u0432\\u0430\\u043d\\u0438\\u0435\"]}}]',14,1),(99,'2022-06-24 03:01:48.665070','10','test_accounting@gmail.com',2,'[{\"changed\": {\"fields\": [\"Groups\"]}}]',16,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(5,'sessions','session'),(6,'website','bill'),(7,'website','expense'),(8,'website','expensetype'),(9,'website','income'),(10,'website','incometype'),(17,'website','materialparameter'),(18,'website','order'),(19,'website','orderplace'),(11,'website','orders'),(16,'website','siteuser'),(12,'website','tag'),(13,'website','wallpapermaterial'),(14,'website','wallpapersentry'),(15,'website','wallpaperspremadeentryhastag');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2022-05-09 15:37:05.167714'),(2,'contenttypes','0002_remove_content_type_name','2022-05-09 15:37:06.863735'),(3,'auth','0001_initial','2022-05-09 15:37:10.126529'),(4,'auth','0002_alter_permission_name_max_length','2022-05-09 15:37:10.797382'),(5,'auth','0003_alter_user_email_max_length','2022-05-09 15:37:10.813456'),(6,'auth','0004_alter_user_username_opts','2022-05-09 15:37:10.842175'),(7,'auth','0005_alter_user_last_login_null','2022-05-09 15:37:10.863822'),(8,'auth','0006_require_contenttypes_0002','2022-05-09 15:37:10.889095'),(9,'auth','0007_alter_validators_add_error_messages','2022-05-09 15:37:10.923928'),(10,'auth','0008_alter_user_username_max_length','2022-05-09 15:37:10.946761'),(11,'auth','0009_alter_user_last_name_max_length','2022-05-09 15:37:10.975040'),(12,'auth','0010_alter_group_name_max_length','2022-05-09 15:37:11.622561'),(13,'auth','0011_update_proxy_permissions','2022-05-09 15:37:11.640834'),(14,'auth','0012_alter_user_first_name_max_length','2022-05-09 15:37:11.666446'),(15,'website','0001_initial','2022-05-09 15:37:15.680823'),(16,'admin','0001_initial','2022-05-09 15:37:17.832598'),(17,'admin','0002_logentry_remove_auto_add','2022-05-09 15:37:17.861591'),(18,'admin','0003_logentry_add_action_flag_choices','2022-05-09 15:37:17.886162'),(19,'sessions','0001_initial','2022-05-09 15:37:18.407270');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('93un3oy10jijhxda9ineyhr5vedccg2j','.eJxVjDsOwjAQRO_iGln-xJ9Q0ucM1np3TQLIkeKkQtydREoB3Wjem3mLBNs6pq3xkiYSV6HF5bfLgE-uB6AH1Pssca7rMmV5KPKkTQ4z8et2un8HI7RxX2OxUHS07IxlDDmS4ei481YX6D3RHnsoXiM62wcFQXXGqJwxFCAi8fkC_W04wg:1o1sL3:XN4oP3pNQIYT_AktEiBbEqxIu2G1GcB0qDQwSLagQ9A','2022-06-30 16:27:21.091070'),('isy596f78ig90500ozjurquuiqe6owbn','.eJxVjEEOwiAQRe_C2hAYKGVcuvcMhIFBqoYmpV0Z765NutDtf-_9lwhxW2vYOi9hyuIstDj9bhTTg9sO8j222yzT3NZlIrkr8qBdXufMz8vh_h3U2Ou3JrCFkEBhTsYUtGCNQoSBnOMCsYyUDPoBoShv2TrWWmXtUwYYHYJ4fwDVEjcf:1no8aS:j91juZ-YxWeAWAuBxHSCLPXFVlswEgJF0CpotDfkfpk','2022-05-23 18:58:28.578538'),('nj9g26txktqeefdleeikos2sz27wzlxd','.eJxVjDsOwjAQRO_iGln-xJ9Q0ucM1np3TQLIkeKkQtydREoB3Wjem3mLBNs6pq3xkiYSV6HF5bfLgE-uB6AH1Pssca7rMmV5KPKkTQ4z8et2un8HI7RxX2OxUHS07IxlDDmS4ei481YX6D3RHnsoXiM62wcFQXXGqJwxFCAi8fkC_W04wg:1o2wX8:CYaSvbwG-oVa-HGIcSw5pbGSM5tchJfKnjhA2zTofGY','2022-07-03 15:08:14.894225'),('o8qeojj4uism1ggoqxagxbhbcovbu0q7','.eJxVjDsOwjAQRO_iGln-xJ9Q0ucM1np3TQLIkeKkQtydREoB3Wjem3mLBNs6pq3xkiYSV6HF5bfLgE-uB6AH1Pssca7rMmV5KPKkTQ4z8et2un8HI7RxX2OxUHS07IxlDDmS4ei481YX6D3RHnsoXiM62wcFQXXGqJwxFCAi8fkC_W04wg:1o4bJ6:mZDZF33xpIaRmAiiiN-T04JQf99gAj197-7IwzYK2As','2022-07-08 04:52:36.015648'),('qunc92xv8zjbnwe9h8qtd4vwdzkt93k7','.eJxVjDsOwjAQRO_iGln-xJ9Q0ucM1np3TQLIkeKkQtydREoB3Wjem3mLBNs6pq3xkiYSV6HF5bfLgE-uB6AH1Pssca7rMmV5KPKkTQ4z8et2un8HI7RxX2OxUHS07IxlDDmS4ei481YX6D3RHnsoXiM62wcFQXXGqJwxFCAi8fkC_W04wg:1nyq1p:PYAaFlw5y0OtxxsrFF1NRqykxbKczro1pidMppe97zM','2022-06-22 07:22:57.269181'),('rgmutqfqcxzsihxat6ccvn6hyawe0p9s','.eJxVjDsOwjAQRO_iGln-xJ9Q0ucM1np3TQLIkeKkQtydREoB3Wjem3mLBNs6pq3xkiYSV6HF5bfLgE-uB6AH1Pssca7rMmV5KPKkTQ4z8et2un8HI7RxX2OxUHS07IxlDDmS4ei481YX6D3RHnsoXiM62wcFQXXGqJwxFCAi8fkC_W04wg:1nythw:jdaC5YL42_0GY2uki82sp1TgQsa7M-3VD807xfb4LAk','2022-06-22 11:18:40.322558'),('swrex872ympy2ytocrwcn3bjn2om6jto','.eJxVjLkOwjAQRP_FNbJ8xBclfb7BWu-ucQAlUo4K8e8kUgroRvPezFtk2NaWt4XnPJC4CiMuv10BfPJ4AHrAeJ8kTuM6D0UeijzpIvuJ-HU73b-DBkvb11gtVB0tO2MZQ4lkODruvNUVkifaY4LqNaKzKSgIqjNGlYKhAhGJzxf-BjjD:1o2iIA:E9CZ6hFAc3Lh0RztEMHvp3qMtJ_RxD62eGldC8jCFs8','2022-07-02 23:55:50.552440'),('t1eeq5dlplr5eizyachair15worfry3p','.eJxVjDsOwjAQRO_iGln-xJ9Q0ucM1np3TQLIkeKkQtydREoB3Wjem3mLBNs6pq3xkiYSV6HF5bfLgE-uB6AH1Pssca7rMmV5KPKkTQ4z8et2un8HI7RxX2OxUHS07IxlDDmS4ei481YX6D3RHnsoXiM62wcFQXXGqJwxFCAi8fkC_W04wg:1o2wX8:CYaSvbwG-oVa-HGIcSw5pbGSM5tchJfKnjhA2zTofGY','2022-07-03 15:08:14.884669'),('uyza50m3r06blyxgu98o0t5uccld36gc','.eJxVjDsOwjAQRO_iGln-xJ9Q0ucM1np3TQLIkeKkQtydREoB3Wjem3mLBNs6pq3xkiYSV6HF5bfLgE-uB6AH1Pssca7rMmV5KPKkTQ4z8et2un8HI7RxX2OxUHS07IxlDDmS4ei481YX6D3RHnsoXiM62wcFQXXGqJwxFCAi8fkC_W04wg:1o4HwR:zJ9f3RQx9W_7tQAF57PL4oudzr7Q_-SfYrzQatK6R6c','2022-07-07 08:11:55.601705'),('vf1nknwcl0eg9bff3sg78g52fn7zoh5n','.eJxVjDsOwjAQRO_iGln-xJ9Q0ucM1np3TQLIkeKkQtydREoB3Wjem3mLBNs6pq3xkiYSV6HF5bfLgE-uB6AH1Pssca7rMmV5KPKkTQ4z8et2un8HI7RxX2OxUHS07IxlDDmS4ei481YX6D3RHnsoXiM62wcFQXXGqJwxFCAi8fkC_W04wg:1nyge0:dWUUrd01aV5B16PWplsVk8nzMpXwOD7nod202xFEYY4','2022-06-21 21:21:44.704767'),('y09skdnrei53rm9ch5xrp3enk2jvj1mz','.eJxVjDsOwjAQRO_iGln-xJ9Q0ucM1np3TQLIkeKkQtydREoB3Wjem3mLBNs6pq3xkiYSV6HF5bfLgE-uB6AH1Pssca7rMmV5KPKkTQ4z8et2un8HI7RxX2OxUHS07IxlDDmS4ei481YX6D3RHnsoXiM62wcFQXXGqJwxFCAi8fkC_W04wg:1o2wX8:CYaSvbwG-oVa-HGIcSw5pbGSM5tchJfKnjhA2zTofGY','2022-07-03 15:08:14.883669'),('yq92uqfiw9uddygm2wxbd6sk6lggzc8g','.eJxVjDsOwjAQRO_iGln-xJ9Q0ucM1np3TQLIkeKkQtydREoB3Wjem3mLBNs6pq3xkiYSV6HF5bfLgE-uB6AH1Pssca7rMmV5KPKkTQ4z8et2un8HI7RxX2OxUHS07IxlDDmS4ei481YX6D3RHnsoXiM62wcFQXXGqJwxFCAi8fkC_W04wg:1o2wX8:CYaSvbwG-oVa-HGIcSw5pbGSM5tchJfKnjhA2zTofGY','2022-07-03 15:08:14.883669'),('yww8h6u5wbvks82n4b8413cwnv6bj9vi','.eJxVjDsOwjAQRO_iGln-xJ9Q0ucM1np3TQLIkeKkQtydREoB3Wjem3mLBNs6pq3xkiYSV6HF5bfLgE-uB6AH1Pssca7rMmV5KPKkTQ4z8et2un8HI7RxX2OxUHS07IxlDDmS4ei481YX6D3RHnsoXiM62wcFQXXGqJwxFCAi8fkC_W04wg:1o1EQu:3wQR3FWrTV_Q6t594pPyOIVQ6igNN7jv25-8hHbQlF4','2022-06-28 21:50:44.847785'),('zhsc9bsh7pcm3k0lecnubvj2o4hr5bip','.eJxVjDEOgzAQBP9ydWRhGzBQps8brPPdGUgiW8KgFFH-HpBo6FY7s_sFxhX9XPxnyWmEQd_A47ZOfiuy-JlhAA2XLiC9JB2An5jGrCindZmDOhR10qIemeV9P93LwYRl2tcULUbdWWmMFXKhYyNdI3VrdcS-Zd5jj7HVRI3tXYWuqo2pQiAXkZnh9wdpAz7-:1nxWdC:rFT6T2LKFHcgR84lL141ItRM_wxd5ZG5Az3vZ7l6Cso','2022-06-18 16:28:06.409348');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expense`
--

DROP TABLE IF EXISTS `expense`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `expense` (
  `id` int NOT NULL AUTO_INCREMENT,
  `amount` float NOT NULL,
  `date` datetime NOT NULL,
  `expense_type_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_expense_expense_type1_idx` (`expense_type_id`),
  CONSTRAINT `fk_expense_expense_type1` FOREIGN KEY (`expense_type_id`) REFERENCES `expense_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expense`
--

LOCK TABLES `expense` WRITE;
/*!40000 ALTER TABLE `expense` DISABLE KEYS */;
INSERT INTO `expense` VALUES (1,25000,'2022-06-19 19:30:28',4),(2,20000,'2022-06-19 19:30:43',2),(3,100000,'2022-06-19 19:31:05',1),(4,112000,'2022-06-19 19:31:17',5);
/*!40000 ALTER TABLE `expense` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expense_type`
--

DROP TABLE IF EXISTS `expense_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `expense_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(128) NOT NULL,
  `name` varchar(256) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expense_type`
--

LOCK TABLES `expense_type` WRITE;
/*!40000 ALTER TABLE `expense_type` DISABLE KEYS */;
INSERT INTO `expense_type` VALUES (1,'materials_buying','Закупка материалов',''),(2,'ads_web','Покупка рекламы в интернете',''),(3,'ads_street','Покупка рекламы на уличном баннере',''),(4,'signboard','Покупка вывески',''),(5,'equipment','Закупка оборудования','');
/*!40000 ALTER TABLE `expense_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `income`
--

DROP TABLE IF EXISTS `income`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `income` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `income_type_id` int NOT NULL,
  `amount` float NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_income_income_type1_idx` (`income_type_id`),
  KEY `fr_order_idx` (`order_id`),
  CONSTRAINT `fk_income_income_type1` FOREIGN KEY (`income_type_id`) REFERENCES `income_type` (`id`),
  CONSTRAINT `fr_order` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `income`
--

LOCK TABLES `income` WRITE;
/*!40000 ALTER TABLE `income` DISABLE KEYS */;
INSERT INTO `income` VALUES (1,11,1,7800,'2022-06-19 19:28:20'),(2,12,1,6440,'2022-06-19 19:29:08'),(3,13,1,7350,'2022-06-19 19:29:46'),(4,NULL,3,50000,'2022-02-15 15:00:00'),(5,14,1,4200,'2022-06-21 02:44:04');
/*!40000 ALTER TABLE `income` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `income_type`
--

DROP TABLE IF EXISTS `income_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `income_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(128) NOT NULL,
  `name` varchar(256) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `income_type`
--

LOCK TABLES `income_type` WRITE;
/*!40000 ALTER TABLE `income_type` DISABLE KEYS */;
INSERT INTO `income_type` VALUES (1,'sell_premade','Продажа готовых обоев',''),(2,'sell_custom','Продажа обоев с индивидуальным дизайном',''),(3,'investment','Инвестиция','');
/*!40000 ALTER TABLE `income_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `material_has_parameter`
--

DROP TABLE IF EXISTS `material_has_parameter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `material_has_parameter` (
  `id` int NOT NULL AUTO_INCREMENT,
  `wallpaper_material_id` int NOT NULL,
  `material_parameter_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_table1_material_parameter1_idx` (`material_parameter_id`),
  KEY `fk_table1_wallpaper_material1` (`wallpaper_material_id`),
  CONSTRAINT `fk_table1_material_parameter1` FOREIGN KEY (`material_parameter_id`) REFERENCES `material_parameter` (`id`),
  CONSTRAINT `fk_table1_wallpaper_material1` FOREIGN KEY (`wallpaper_material_id`) REFERENCES `wallpaper_material` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `material_has_parameter`
--

LOCK TABLES `material_has_parameter` WRITE;
/*!40000 ALTER TABLE `material_has_parameter` DISABLE KEYS */;
INSERT INTO `material_has_parameter` VALUES (1,6,4),(2,6,6),(3,7,5),(4,7,6),(5,8,4),(6,8,3),(7,9,1),(8,9,5),(9,10,7),(10,10,4),(11,11,5),(12,11,8),(13,7,8),(14,12,8),(15,12,5),(16,13,3),(17,13,4),(18,13,7);
/*!40000 ALTER TABLE `material_has_parameter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `material_parameter`
--

DROP TABLE IF EXISTS `material_parameter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `material_parameter` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `displayname` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `material_parameter`
--

LOCK TABLES `material_parameter` WRITE;
/*!40000 ALTER TABLE `material_parameter` DISABLE KEYS */;
INSERT INTO `material_parameter` VALUES (1,'fireproof','Пожаростойкие'),(3,'selfadhesive','Самоклеющиеся'),(4,'smooth','Гладкие'),(5,'textured','Фактурные'),(6,'washable','Моющиеся'),(7,'drawable','Подходят для рисования'),(8,'animalproof','Суперстойкие');
/*!40000 ALTER TABLE `material_parameter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message` (
  `id` bigint NOT NULL,
  `chat_id` bigint NOT NULL,
  `sender_id` bigint NOT NULL,
  `text` text NOT NULL,
  `datetime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_message_chat1_idx` (`chat_id`),
  KEY `fk_message_website_siteuser1_idx` (`sender_id`),
  CONSTRAINT `fk_message_chat1` FOREIGN KEY (`chat_id`) REFERENCES `chat` (`id`),
  CONSTRAINT `fk_message_website_siteuser1` FOREIGN KEY (`sender_id`) REFERENCES `website_siteuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `id` int NOT NULL AUTO_INCREMENT,
  `entry_id` int DEFAULT NULL,
  `date` datetime NOT NULL,
  `user_id` bigint NOT NULL,
  `data` text NOT NULL,
  `status` int NOT NULL,
  `price` float NOT NULL,
  `paid` float NOT NULL,
  `material_id` int DEFAULT NULL,
  `address` text NOT NULL,
  `paymenttype` int NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Orders_wallpapers_premade_entry_idx` (`entry_id`),
  KEY `fk_order_user_id` (`user_id`),
  KEY `fk_material_id_idx` (`material_id`),
  CONSTRAINT `fk_material_id` FOREIGN KEY (`material_id`) REFERENCES `wallpaper_material` (`id`),
  CONSTRAINT `fk_order_user_id` FOREIGN KEY (`user_id`) REFERENCES `website_siteuser` (`id`),
  CONSTRAINT `fk_Orders_wallpapers_premade_entry` FOREIGN KEY (`entry_id`) REFERENCES `wallpapers_premade_entry` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (11,19,'2022-06-19 22:28:20',1,'{\"m_sq_count\": 15.0}',0,7800,7800,8,'ул. Социалистическая, 20',0,'Pavel','Feelin','felucca24@gmail.com'),(12,23,'2022-06-19 22:29:08',1,'{\"m_sq_count\": 12.0}',0,6440,6440,11,'ул. Рабоче-Крестьянская, 12',0,'Pavel','Feelin','felucca24@gmail.com'),(13,21,'2022-06-19 22:29:45',1,'{\"m_sq_count\": 15.0}',0,7350,7350,12,'ул. Рабоче-Крестьянская, 12',0,'Pavel','Feelin','felucca24@gmail.com'),(14,19,'2022-06-21 05:44:04',1,'{\"m_sq_count\": 6.0}',0,4200,4200,8,'ул. Циолковского, 7',0,'Pavel','Feelin','felucca24@gmail.com');
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_place`
--

DROP TABLE IF EXISTS `order_place`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_place` (
  `id` int NOT NULL AUTO_INCREMENT,
  `address` text NOT NULL,
  `name` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_place`
--

LOCK TABLES `order_place` WRITE;
/*!40000 ALTER TABLE `order_place` DISABLE KEYS */;
INSERT INTO `order_place` VALUES (1,'ул. Пугачевская, 6','ул. Пугачевская, 6'),(2,'ул. Циолковского, 7','ул. Циолковского, 7'),(3,'ул. Рабоче-Крестьянская, 12','ул. Рабоче-Крестьянская, 12'),(4,'ул. Социалистическая, 20','ул. Социалистическая, 20');
/*!40000 ALTER TABLE `order_place` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tag` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tag` varchar(45) NOT NULL,
  `displaytag` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tag_UNIQUE` (`tag`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag`
--

LOCK TABLES `tag` WRITE;
/*!40000 ALTER TABLE `tag` DISABLE KEYS */;
INSERT INTO `tag` VALUES (24,'nature','Природа'),(25,'sea','Море'),(26,'art','Искусство'),(27,'abstraction','Абстракция'),(28,'pattern','Узор'),(29,'city','Город'),(30,'animal','Животные'),(31,'chilrens','Детские'),(32,'plants','Растения'),(33,'dark','Тёмные'),(34,'light','Светлые'),(35,'forest','Лес'),(36,'trees','Деревья'),(37,'flowers','Цветы');
/*!40000 ALTER TABLE `tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wallpaper_material`
--

DROP TABLE IF EXISTS `wallpaper_material`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wallpaper_material` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `displayname` varchar(64) NOT NULL,
  `price` float NOT NULL,
  `image_url` varchar(512) NOT NULL,
  `in_stock` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wallpaper_material`
--

LOCK TABLES `wallpaper_material` WRITE;
/*!40000 ALTER TABLE `wallpaper_material` DISABLE KEYS */;
INSERT INTO `wallpaper_material` VALUES (6,'interlining_smooth','Гладкий флизелин',360,'sinteko_1b',0),(7,'nicca','Флизелин + штукатурка',370,'nicca_1b',0),(8,'stick','Матовые самоклеющиеся',400,'samoklejuschiesja_1b',0),(9,'protect','Пожаростойкие',380,'protekt1b-150x150',0),(10,'manifiko_1a','Холст для рисования',390,'manifiko_1b',0),(11,'korsika_1b','Флизелин + штукатурка с фактурой ткани',395,'korsika_1b',0),(12,'sicilija_1b','Флизелин + крошка штукатурки',370,'sicilija_1b',0),(13,'manifiko_1b','Холст для рисования самоклеющийся',410,'manifiko_1b',0);
/*!40000 ALTER TABLE `wallpaper_material` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wallpapers_premade_entry`
--

DROP TABLE IF EXISTS `wallpapers_premade_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wallpapers_premade_entry` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(256) NOT NULL,
  `description` text NOT NULL,
  `price` float NOT NULL,
  `image` varchar(512) NOT NULL,
  `full_picture` tinyint NOT NULL DEFAULT '0',
  `custom` tinyint NOT NULL DEFAULT '0',
  `img_size` float DEFAULT '0',
  `img_x` float DEFAULT '0',
  `img_y` float DEFAULT '0',
  `img_rot` float DEFAULT '0',
  `preview` varchar(512) NOT NULL,
  `custom_hash` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wallpapers_premade_entry`
--

LOCK TABLES `wallpapers_premade_entry` WRITE;
/*!40000 ALTER TABLE `wallpapers_premade_entry` DISABLE KEYS */;
INSERT INTO `wallpapers_premade_entry` VALUES (18,'AROMATICO','',1500,'int-aromatico-06-2_600x600_361.jpg',1,0,0,0,0,0,'int-aromatico-06-2_600x600_361.jpg',NULL),(19,'FAIRY TALE','',1800,'int-fairy-tale-03-(2)_600x600_361.jpg',1,0,0,0,0,0,'int-fairy-tale-03-(2)_600x600_361.jpg',NULL),(20,'FICHI FRACTURA','',1400,'int-fichi-factura-123456-01_600x600_361.jpg',0,0,0,0,0,0,'int-fichi-factura-123456-01_600x600_361.jpg',NULL),(21,'FOXY','',1800,'int-foxy-01-3_600x600_361.jpg',0,0,0,0,0,0,'int-foxy-01-3_600x600_361.jpg',NULL),(22,'FRAGILITY','',1699,'int-fragility-factura-12345-3_600x600_361.jpg',0,0,0,0,0,0,'int-fragility-factura-12345-3_600x600_361.jpg',NULL),(23,'LIGHTHOUSE','',1700,'int-lighthouse-factura-12345-01_600x600_361.jpg',1,0,0,0,0,0,'int-lighthouse-factura-12345-01_600x600_361.jpg',NULL),(24,'SCANDITOWN','',1800,'int-scanditown-01-2_600x600_361.jpg',1,0,0,0,0,0,'int-scanditown-01-2_600x600_361.jpg',NULL),(25,'SELENION','',1599,'int-selenion-05-3_600x600_361.jpg',1,0,0,0,0,0,'int-selenion-05-3_600x600_361.jpg',NULL),(26,'SIBERIA','',1550,'int-siberia-01-2_600x600_361.jpg',1,0,0,0,0,0,'int-siberia-01-2_600x600_361.jpg',NULL),(27,'VISION','',1799,'int-vision-factura-123456-06_600x600_361.jpg',0,0,0,0,0,0,'int-vision-factura-123456-06_600x600_361.jpg',NULL),(28,'WONDERLAND','',1899,'int-wonderland-01-2_600x600_361.jpg',1,0,0,0,0,0,'int-wonderland-01-2_600x600_361.jpg',NULL);
/*!40000 ALTER TABLE `wallpapers_premade_entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wallpapers_premade_entry_has_tag`
--

DROP TABLE IF EXISTS `wallpapers_premade_entry_has_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wallpapers_premade_entry_has_tag` (
  `id` int NOT NULL AUTO_INCREMENT,
  `wallpapers_premade_entry_id` int NOT NULL,
  `tag_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_wallpapers_premade_entry_has_tag_tag1_idx` (`tag_id`),
  KEY `fk_wallpapers_premade_entry_has_tag_wallpapers_premade_entr_idx` (`wallpapers_premade_entry_id`),
  CONSTRAINT `fk_wallpapers_premade_entry_has_tag_tag1` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`),
  CONSTRAINT `fk_wallpapers_premade_entry_has_tag_wallpapers_premade_entry1` FOREIGN KEY (`wallpapers_premade_entry_id`) REFERENCES `wallpapers_premade_entry` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wallpapers_premade_entry_has_tag`
--

LOCK TABLES `wallpapers_premade_entry_has_tag` WRITE;
/*!40000 ALTER TABLE `wallpapers_premade_entry_has_tag` DISABLE KEYS */;
INSERT INTO `wallpapers_premade_entry_has_tag` VALUES (31,18,32),(32,18,33),(33,19,34),(34,19,35),(35,19,30),(36,19,36),(37,20,34),(38,20,28),(39,21,30),(40,21,34),(41,22,37),(42,22,34),(43,22,32),(44,23,25),(45,23,34),(46,24,29),(47,24,25),(48,24,34),(49,25,37),(50,25,34),(51,26,33),(52,26,35),(53,26,37),(54,26,32),(55,26,30),(56,27,28),(57,27,27),(58,28,32),(59,28,30);
/*!40000 ALTER TABLE `wallpapers_premade_entry_has_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `website_siteuser`
--

DROP TABLE IF EXISTS `website_siteuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `website_siteuser` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `username` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL,
  `first_name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL,
  `second_name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8_general_ci DEFAULT NULL,
  `last_name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `website_siteuser`
--

LOCK TABLES `website_siteuser` WRITE;
/*!40000 ALTER TABLE `website_siteuser` DISABLE KEYS */;
INSERT INTO `website_siteuser` VALUES (1,'pbkdf2_sha256$320000$WYMSYjoFrx298hkUgm2VhN$S1uNRjLjXZmJ/Q87xuwsLR0zA25GEnXg/KKQEo82MSM=','2022-06-24 04:52:35.931647','Feelin','felucca24@gmail.com','Pavel',NULL,'Feelin',1,1),(2,'pbkdf2_sha256$320000$WYMSYjoFrx298hkUgm2VhN$S1uNRjLjXZmJ/Q87xuwsLR0zA25GEnXg/KKQEo82MSM=','2022-06-19 00:00:42.002213','Test','felucca25@gmail.com','Test',NULL,'Test',1,0),(3,'pbkdf2_sha256$320000$m3U2s5NzyGKOCDXfTx2AnA$GzkUHMHsbeMukXrap1mTSZXzMEoK7yuFVZe/xBM0GiM=',NULL,'TestUser','felucca26@gmail.com','Павел','Сергеевич','Филин',0,0),(8,'pbkdf2_sha256$320000$423wthP1MaJB7PQWlYFmRk$oULoYuuv8clKogo+RIMblIqhgDe93RA9To+XXHeObQc=','2022-06-21 14:31:07.566869','TestUser2','felucca27@gmail.com','Павел','Сергеевич','Филин',0,0),(9,'pbkdf2_sha256$320000$53lk6Mm2aerBduP8rODlOB$2e7NEfwYRSsEWs5DQ8VgDuRggnoubPOe2s6xURF/+rw=','2022-06-24 02:38:50.260316','TestUser123','felucca28@gmail.com','Иванов','Иванович','Иван',0,0),(10,'pbkdf2_sha256$320000$mkdZRzlGOuCIaBsStvbbz3$3qnfcDB2HH0PfdKQvdkv1e92R5BxoUFhFxbI282xlXo=','2022-06-24 03:02:00.932657','TestAccounting','test_accounting@gmail.com','Test','Test','Test',0,0);
/*!40000 ALTER TABLE `website_siteuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `website_siteuser_groups`
--

DROP TABLE IF EXISTS `website_siteuser_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `website_siteuser_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `siteuser_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `website_siteuser_groups_siteuser_id_group_id_55c9f36b_uniq` (`siteuser_id`,`group_id`),
  KEY `website_siteuser_groups_group_id_90c73e2b_fk_auth_group_id` (`group_id`),
  CONSTRAINT `website_siteuser_gro_siteuser_id_67ac1295_fk_website_s` FOREIGN KEY (`siteuser_id`) REFERENCES `website_siteuser` (`id`),
  CONSTRAINT `website_siteuser_groups_group_id_90c73e2b_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `website_siteuser_groups`
--

LOCK TABLES `website_siteuser_groups` WRITE;
/*!40000 ALTER TABLE `website_siteuser_groups` DISABLE KEYS */;
INSERT INTO `website_siteuser_groups` VALUES (2,1,1),(3,1,2),(1,2,1),(4,10,2);
/*!40000 ALTER TABLE `website_siteuser_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `website_siteuser_user_permissions`
--

DROP TABLE IF EXISTS `website_siteuser_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `website_siteuser_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `siteuser_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `website_siteuser_user_pe_siteuser_id_permission_i_471679e2_uniq` (`siteuser_id`,`permission_id`),
  KEY `website_siteuser_use_permission_id_76df74d7_fk_auth_perm` (`permission_id`),
  CONSTRAINT `website_siteuser_use_permission_id_76df74d7_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `website_siteuser_use_siteuser_id_1fa231d4_fk_website_s` FOREIGN KEY (`siteuser_id`) REFERENCES `website_siteuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `website_siteuser_user_permissions`
--

LOCK TABLES `website_siteuser_user_permissions` WRITE;
/*!40000 ALTER TABLE `website_siteuser_user_permissions` DISABLE KEYS */;
INSERT INTO `website_siteuser_user_permissions` VALUES (1,2,4);
/*!40000 ALTER TABLE `website_siteuser_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'wallpaperfactory'
--

--
-- Dumping routines for database 'wallpaperfactory'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-06-25  8:56:50
