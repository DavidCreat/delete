-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: fitfusion_db
-- ------------------------------------------------------
-- Server version	8.0.40

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
-- Table structure for table `actividades_actividad`
--

DROP TABLE IF EXISTS `actividades_actividad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `actividades_actividad` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` longtext,
  `fecha` date NOT NULL,
  `usuario_id` int NOT NULL,
  `duracion` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actividades_actividad`
--

LOCK TABLES `actividades_actividad` WRITE;
/*!40000 ALTER TABLE `actividades_actividad` DISABLE KEYS */;
/*!40000 ALTER TABLE `actividades_actividad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `actividades_grafico`
--

DROP TABLE IF EXISTS `actividades_grafico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `actividades_grafico` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tipo` varchar(50) NOT NULL,
  `fecha` date NOT NULL,
  `valor` double NOT NULL,
  `actividad_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `actividades_grafico_actividad_id_2d955ef0_fk_actividad` (`actividad_id`),
  CONSTRAINT `actividades_grafico_actividad_id_2d955ef0_fk_actividad` FOREIGN KEY (`actividad_id`) REFERENCES `actividades_actividad` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actividades_grafico`
--

LOCK TABLES `actividades_grafico` WRITE;
/*!40000 ALTER TABLE `actividades_grafico` DISABLE KEYS */;
/*!40000 ALTER TABLE `actividades_grafico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `actividades_meta`
--

DROP TABLE IF EXISTS `actividades_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `actividades_meta` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` longtext NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `objetivo` int NOT NULL,
  `usuario_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `actividades_meta_usuario_id_599ce0e9_fk_auth_user_id` (`usuario_id`),
  CONSTRAINT `actividades_meta_usuario_id_599ce0e9_fk_auth_user_id` FOREIGN KEY (`usuario_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actividades_meta`
--

LOCK TABLES `actividades_meta` WRITE;
/*!40000 ALTER TABLE `actividades_meta` DISABLE KEYS */;
/*!40000 ALTER TABLE `actividades_meta` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add usuario',7,'add_usuario'),(26,'Can change usuario',7,'change_usuario'),(27,'Can delete usuario',7,'delete_usuario'),(28,'Can view usuario',7,'view_usuario'),(29,'Can add actividad',8,'add_actividad'),(30,'Can change actividad',8,'change_actividad'),(31,'Can delete actividad',8,'delete_actividad'),(32,'Can view actividad',8,'view_actividad'),(33,'Can add grafico',9,'add_grafico'),(34,'Can change grafico',9,'change_grafico'),(35,'Can delete grafico',9,'delete_grafico'),(36,'Can view grafico',9,'view_grafico'),(37,'Can add meta',10,'add_meta'),(38,'Can change meta',10,'change_meta'),(39,'Can delete meta',10,'delete_meta'),(40,'Can view meta',10,'view_meta'),(41,'Can add Token',11,'add_token'),(42,'Can change Token',11,'change_token'),(43,'Can delete Token',11,'delete_token'),(44,'Can view Token',11,'view_token'),(45,'Can add Token',12,'add_tokenproxy'),(46,'Can change Token',12,'change_tokenproxy'),(47,'Can delete Token',12,'delete_tokenproxy'),(48,'Can view Token',12,'view_tokenproxy'),(49,'Can add actividad',13,'add_actividad'),(50,'Can change actividad',13,'change_actividad'),(51,'Can delete actividad',13,'delete_actividad'),(52,'Can view actividad',13,'view_actividad'),(53,'Can add meta',14,'add_meta'),(54,'Can change meta',14,'change_meta'),(55,'Can delete meta',14,'delete_meta'),(56,'Can view meta',14,'view_meta'),(57,'Can add grafico',15,'add_grafico'),(58,'Can change grafico',15,'change_grafico'),(59,'Can delete grafico',15,'delete_grafico'),(60,'Can view grafico',15,'view_grafico'),(61,'Can add meta',16,'add_meta'),(62,'Can change meta',16,'change_meta'),(63,'Can delete meta',16,'delete_meta'),(64,'Can view meta',16,'view_meta'),(65,'Can add grafico',17,'add_grafico'),(66,'Can change grafico',17,'change_grafico'),(67,'Can delete grafico',17,'delete_grafico'),(68,'Can view grafico',17,'view_grafico');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (26,'pbkdf2_sha256$600000$sYq8Ebkg0WA7YOu9yCNhBT$jgzA728w0RUVoG1I3sPSjLPBjFrp7U46YPZTi2Me6ro=','2024-11-25 19:56:13.614297',1,'diego','','','dlzpu18@gmail.com',1,1,'2024-11-15 14:56:35.884192'),(41,'pbkdf2_sha256$600000$RzHgE5Ntoe71cd49Vuzlif$NLNwnUbxxZL+s2tdTKtOjbqK44hK+VEBCx6Noa/BfAQ=',NULL,0,'prueba','','','prueba@gmail.com',0,1,'2024-11-19 19:56:39.073202'),(54,'pbkdf2_sha256$600000$ZCXKHrh8dedP0S2yeJJhpV$UKLZ0ZoV+aOdkHNWhI2dRn3XPny+r641WD2jkVdFoHo=',NULL,0,'lol','','','lol@gmail.com',0,1,'2024-11-25 19:57:57.653281');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authtoken_token`
--

DROP TABLE IF EXISTS `authtoken_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`key`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `authtoken_token_user_id_35299eff_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authtoken_token`
--

LOCK TABLES `authtoken_token` WRITE;
/*!40000 ALTER TABLE `authtoken_token` DISABLE KEYS */;
INSERT INTO `authtoken_token` VALUES ('bd86fee0317fed13c2253bc65d5c71b042783dd9','2024-11-17 00:02:50.478616',26);
/*!40000 ALTER TABLE `authtoken_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `backend_actividad`
--

DROP TABLE IF EXISTS `backend_actividad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `backend_actividad` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `duracion` double NOT NULL,
  `descripcion` longtext NOT NULL,
  `fecha` date NOT NULL,
  `usuario_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `backend_actividad_usuario_id_c6db3a5d_fk_auth_user_id` (`usuario_id`),
  CONSTRAINT `backend_actividad_usuario_id_c6db3a5d_fk_auth_user_id` FOREIGN KEY (`usuario_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `backend_actividad`
--

LOCK TABLES `backend_actividad` WRITE;
/*!40000 ALTER TABLE `backend_actividad` DISABLE KEYS */;
/*!40000 ALTER TABLE `backend_actividad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `backend_grafico`
--

DROP TABLE IF EXISTS `backend_grafico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `backend_grafico` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `titulo` varchar(100) NOT NULL,
  `datos` json NOT NULL,
  `fecha_creacion` date NOT NULL,
  `usuario_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `backend_grafico_usuario_id_39b9c36f_fk_auth_user_id` (`usuario_id`),
  CONSTRAINT `backend_grafico_usuario_id_39b9c36f_fk_auth_user_id` FOREIGN KEY (`usuario_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `backend_grafico`
--

LOCK TABLES `backend_grafico` WRITE;
/*!40000 ALTER TABLE `backend_grafico` DISABLE KEYS */;
/*!40000 ALTER TABLE `backend_grafico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `backend_meta`
--

DROP TABLE IF EXISTS `backend_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `backend_meta` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` longtext NOT NULL,
  `objetivo` double NOT NULL,
  `fecha_objetivo` date NOT NULL,
  `usuario_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `backend_meta_usuario_id_851d3516_fk_auth_user_id` (`usuario_id`),
  CONSTRAINT `backend_meta_usuario_id_851d3516_fk_auth_user_id` FOREIGN KEY (`usuario_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `backend_meta`
--

LOCK TABLES `backend_meta` WRITE;
/*!40000 ALTER TABLE `backend_meta` DISABLE KEYS */;
/*!40000 ALTER TABLE `backend_meta` ENABLE KEYS */;
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
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (15,'2024-11-15 15:03:30.815598','27','camiloasasaa',1,'[{\"added\": {}}]',4,26),(16,'2024-11-17 19:35:16.646491','30','wqwqqw',1,'[{\"added\": {}}]',4,26),(17,'2024-11-18 20:35:53.466934','29','camilo',2,'[{\"changed\": {\"fields\": [\"password\"]}}]',4,26),(18,'2024-11-19 07:24:54.237361','29','camilo',3,'',4,26),(19,'2024-11-19 07:24:54.244358','27','camiloasasaa',3,'',4,26),(20,'2024-11-19 07:24:54.248357','28','prueba',3,'',4,26),(21,'2024-11-19 07:24:54.252356','30','wqwqqw',3,'',4,26),(22,'2024-11-19 07:25:16.881155','31','prueba',1,'[{\"added\": {}}]',4,26),(23,'2024-11-19 19:49:24.406107','33','bb',3,'',4,26),(24,'2024-11-19 19:49:24.411107','34','jj',3,'',4,26),(25,'2024-11-19 19:49:24.418103','36','nb',3,'',4,26),(26,'2024-11-19 19:49:24.422102','35','nico',3,'',4,26),(27,'2024-11-19 19:49:24.427100','31','prueba',3,'',4,26),(28,'2024-11-19 19:49:24.431099','32','vv',3,'',4,26),(29,'2024-11-19 19:56:27.250840','39','cc',3,'',4,26),(30,'2024-11-19 19:56:27.254838','37','prueba',3,'',4,26),(31,'2024-11-19 19:56:27.258837','40','vb',3,'',4,26),(32,'2024-11-19 19:56:27.262012','38','vv',3,'',4,26),(33,'2024-11-20 02:21:30.998029','47','asdas',3,'',4,26),(34,'2024-11-20 02:21:31.003020','42','cc',3,'',4,26),(35,'2024-11-20 02:21:31.007023','50','dd',3,'',4,26),(36,'2024-11-20 02:21:31.011521','44','ddddd',3,'',4,26),(37,'2024-11-20 02:21:31.017481','43','doriss',3,'',4,26),(38,'2024-11-20 02:21:31.020573','45','fdf',3,'',4,26),(39,'2024-11-20 02:21:31.023903','49','gh',3,'',4,26),(40,'2024-11-20 02:21:31.027530','48','sadwqw',3,'',4,26),(41,'2024-11-20 02:21:31.030944','46','trte',3,'',4,26),(42,'2024-11-20 02:21:31.034243','51','yyy',3,'',4,26),(43,'2024-11-20 02:21:31.037824','52','yyyd',3,'',4,26),(44,'2024-11-25 19:56:50.598541','53','hghg',3,'',4,26);
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (8,'actividades','actividad'),(17,'actividades','grafico'),(16,'actividades','meta'),(1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(11,'authtoken','token'),(12,'authtoken','tokenproxy'),(13,'backend','actividad'),(15,'backend','grafico'),(14,'backend','meta'),(5,'contenttypes','contenttype'),(9,'graficos','grafico'),(10,'metas','meta'),(6,'sessions','session'),(7,'usuarios','usuario');
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
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2024-11-14 17:39:47.874796'),(2,'auth','0001_initial','2024-11-14 17:39:48.933979'),(3,'admin','0001_initial','2024-11-14 17:39:49.179683'),(4,'admin','0002_logentry_remove_auto_add','2024-11-14 17:39:49.191960'),(5,'admin','0003_logentry_add_action_flag_choices','2024-11-14 17:39:49.203313'),(6,'contenttypes','0002_remove_content_type_name','2024-11-14 17:39:49.343079'),(7,'auth','0002_alter_permission_name_max_length','2024-11-14 17:39:49.456545'),(8,'auth','0003_alter_user_email_max_length','2024-11-14 17:39:49.515260'),(9,'auth','0004_alter_user_username_opts','2024-11-14 17:39:49.528466'),(10,'auth','0005_alter_user_last_login_null','2024-11-14 17:39:49.629698'),(11,'auth','0006_require_contenttypes_0002','2024-11-14 17:39:49.633363'),(12,'auth','0007_alter_validators_add_error_messages','2024-11-14 17:39:49.645238'),(13,'auth','0008_alter_user_username_max_length','2024-11-14 17:39:49.753875'),(14,'auth','0009_alter_user_last_name_max_length','2024-11-14 17:39:49.873638'),(15,'auth','0010_alter_group_name_max_length','2024-11-14 17:39:49.906383'),(16,'auth','0011_update_proxy_permissions','2024-11-14 17:39:49.920095'),(17,'auth','0012_alter_user_first_name_max_length','2024-11-14 17:39:50.040792'),(18,'sessions','0001_initial','2024-11-14 17:39:50.106005'),(19,'usuarios','0001_initial','2024-11-14 17:54:02.717516'),(20,'actividades','0001_initial','2024-11-14 17:54:02.841592'),(21,'graficos','0001_initial','2024-11-14 17:54:02.977906'),(22,'metas','0001_initial','2024-11-14 17:54:03.198595'),(23,'authtoken','0001_initial','2024-11-14 21:40:54.331806'),(24,'authtoken','0002_auto_20160226_1747','2024-11-14 21:40:54.375380'),(25,'authtoken','0003_tokenproxy','2024-11-14 21:40:54.381969'),(26,'authtoken','0004_alter_tokenproxy_options','2024-11-14 21:40:54.392264'),(27,'actividades','0002_remove_actividad_duracion_and_more','2024-11-17 01:20:17.337654'),(28,'backend','0001_initial','2024-11-17 19:59:00.062414'),(29,'backend','0002_alter_actividad_tipo','2024-11-17 21:18:54.518583'),(30,'actividades','0003_actividad_duracion','2024-11-18 17:55:08.267542');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('2r9dpyy634bfzy0r5up5l8zhqajqg06p','.eJxVjEEOwiAQRe_C2hAGCiMu3fcMZBhAqoYmpV0Z765NutDtf-_9lwi0rTVsPS9hSuIitBOn3zESP3LbSbpTu82S57YuU5S7Ig_a5Tin_Lwe7t9BpV6_tYmM7AyBZuM0ZswRQbHFkkphIGNzUlrzmcGhG7wGVITWWu8HQwzi_QEN5Deg:1tFfBt:K6hMSPWlhbghHdyNQ_fFlY0zt6x-G-T7y0Nsoe8FCOM','2024-12-09 19:56:13.619295'),('bqswowb4ct8jut5ifubz4jhpddwjtb8u','.eJxVjDsOwjAQBe_iGln2-htKes5geXdtHECxlE-FuDtESgHtm5n3Eilva0vbUuY0sjgL8OL0O2KmR5l2wvc83bqkPq3ziHJX5EEXee1cnpfD_TtoeWnfegCPyNWDskOMFoAsG8c1kKeqjSvomF0gssAKoWRSVRftKgblfDTi_QESBThj:1tCl2g:2ZuuywKbnVCg7T4o5oZEhMU35rVyYDrsRRetwe6Y6jE','2024-12-01 19:34:42.064149'),('grhob85t2gwsem2dqmt6kq8r8rhar8ed','.eJxVjDsOwjAQBe_iGln2-htKes5geXdtHECxlE-FuDtESgHtm5n3Eilva0vbUuY0sjgL8OL0O2KmR5l2wvc83bqkPq3ziHJX5EEXee1cnpfD_TtoeWnfegCPyNWDskOMFoAsG8c1kKeqjSvomF0gssAKoWRSVRftKgblfDTi_QESBThj:1tD8TR:5_V4pyyyRbtHJP0l3BpkG3585jdPvCYNXXwfM1EUnRI','2024-12-02 20:35:53.493926'),('iv37y60jkzvi99mt7nvg0ztce6hzk0oa','.eJxVjDsOwjAQBe_iGln2-htKes5geXdtHECxlE-FuDtESgHtm5n3Eilva0vbUuY0sjgL8OL0O2KmR5l2wvc83bqkPq3ziHJX5EEXee1cnpfD_TtoeWnfegCPyNWDskOMFoAsG8c1kKeqjSvomF0gssAKoWRSVRftKgblfDTi_QESBThj:1tBxkf:LNjo5xEdz_pjFvA4VWWtsbZPXl6QOW6ioxw5M0aYDS0','2024-11-29 14:56:49.414512');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `graficos_grafico`
--

DROP TABLE IF EXISTS `graficos_grafico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `graficos_grafico` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `fecha` datetime(6) NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `valor` double NOT NULL,
  `usuario_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `graficos_grafico_usuario_id_8d3f8a22_fk_usuarios_usuario_id` (`usuario_id`),
  CONSTRAINT `graficos_grafico_usuario_id_8d3f8a22_fk_usuarios_usuario_id` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios_usuario` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `graficos_grafico`
--

LOCK TABLES `graficos_grafico` WRITE;
/*!40000 ALTER TABLE `graficos_grafico` DISABLE KEYS */;
/*!40000 ALTER TABLE `graficos_grafico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metas_meta`
--

DROP TABLE IF EXISTS `metas_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metas_meta` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tipo` varchar(50) NOT NULL,
  `objetivo` double NOT NULL,
  `fecha_inicio` datetime(6) NOT NULL,
  `fecha_fin` datetime(6) NOT NULL,
  `usuario_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `metas_meta_usuario_id_b5b796d9_fk_usuarios_usuario_id` (`usuario_id`),
  CONSTRAINT `metas_meta_usuario_id_b5b796d9_fk_usuarios_usuario_id` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios_usuario` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metas_meta`
--

LOCK TABLES `metas_meta` WRITE;
/*!40000 ALTER TABLE `metas_meta` DISABLE KEYS */;
/*!40000 ALTER TABLE `metas_meta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios_usuario`
--

DROP TABLE IF EXISTS `usuarios_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios_usuario` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(254) NOT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `fecha_registro` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `correo` (`correo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios_usuario`
--

LOCK TABLES `usuarios_usuario` WRITE;
/*!40000 ALTER TABLE `usuarios_usuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuarios_usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-25 22:43:24
