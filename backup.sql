-- MySQL dump 10.13  Distrib 8.0.45, for Linux (x86_64)
--
-- Host: localhost    Database: buddy_script
-- ------------------------------------------------------
-- Server version	8.0.45-0ubuntu0.24.04.1

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
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_locks_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_locks`
--

LOCK TABLES `cache_locks` WRITE;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `likes_count` bigint unsigned NOT NULL DEFAULT '0',
  `replies_count` bigint unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `comments_post_id_created_at_index` (`post_id`,`created_at`),
  KEY `comments_user_id_index` (`user_id`),
  CONSTRAINT `comments_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (1,15,1,'Test Comment',0,0,'2026-05-26 06:36:21','2026-05-26 06:36:34','2026-05-26 06:36:34'),(2,16,1,'new comment',1,0,'2026-05-26 06:41:49','2026-05-26 08:34:06','2026-05-26 08:34:06'),(3,16,1,'GG',0,0,'2026-05-26 08:34:16','2026-05-26 09:12:30','2026-05-26 09:12:30'),(4,16,1,'NEW',0,0,'2026-05-26 08:53:16','2026-05-26 09:12:28','2026-05-26 09:12:28'),(5,16,1,'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy',1,0,'2026-05-26 09:11:09','2026-05-26 09:15:08',NULL),(6,16,1,'new c',0,0,'2026-05-26 09:17:33','2026-05-26 09:41:11','2026-05-26 09:41:11'),(7,14,1,'new',0,0,'2026-05-26 09:18:53','2026-05-26 09:41:17','2026-05-26 09:41:17'),(8,17,1,'new c',0,0,'2026-05-26 09:20:14','2026-05-26 09:41:07','2026-05-26 09:41:07'),(9,17,1,'What is Lorem Ipsum?\nLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dumm',0,0,'2026-05-26 09:24:47','2026-05-26 09:24:47',NULL);
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`),
  KEY `failed_jobs_connection_queue_failed_at_index` (`connection`,`queue`,`failed_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` smallint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `likes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `likeable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `likeable_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `likes_user_id_likeable_id_likeable_type_unique` (`user_id`,`likeable_id`,`likeable_type`),
  KEY `likes_likeable_type_likeable_id_index` (`likeable_type`,`likeable_id`),
  KEY `likes_likeable_id_likeable_type_index` (`likeable_id`,`likeable_type`),
  CONSTRAINT `likes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES (4,1,'App\\Models\\Post',15,'2026-05-26 06:36:07','2026-05-26 06:36:07'),(5,1,'App\\Models\\Comment',2,'2026-05-26 08:31:01','2026-05-26 08:31:01'),(7,1,'App\\Models\\Post',16,'2026-05-26 08:50:01','2026-05-26 08:50:01'),(9,1,'App\\Models\\Comment',5,'2026-05-26 09:15:08','2026-05-26 09:15:08'),(10,1,'App\\Models\\Post',14,'2026-05-26 09:18:46','2026-05-26 09:18:46'),(11,1,'App\\Models\\Post',17,'2026-05-26 09:28:10','2026-05-26 09:28:10');
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'0001_01_01_000000_create_users_table',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000002_create_jobs_table',1),(4,'2026_05_25_073151_create_personal_access_tokens_table',1),(5,'2026_05_25_075449_create_posts_table',1),(6,'2026_05_25_075659_create_post_images_table',1),(7,'2026_05_25_075714_create_comments_table',1),(8,'2026_05_25_075726_create_replies_table',1),(9,'2026_05_25_075756_create_likes_table',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  KEY `personal_access_tokens_expires_at_index` (`expires_at`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
INSERT INTO `personal_access_tokens` VALUES (2,'App\\Models\\User',1,'auth_token','7f9a9f34bcebca96b377ea250f4a7d8639bd068df9fb87d21a51e303384fa2ba','[\"*\"]',NULL,NULL,'2026-05-26 00:08:05','2026-05-26 00:08:05'),(3,'App\\Models\\User',1,'auth_token','4251a3a79028941d787f4f9023986dbf35d2c1d93608510635fbabc80cf72839','[\"*\"]',NULL,NULL,'2026-05-26 04:53:27','2026-05-26 04:53:27'),(4,'App\\Models\\User',1,'auth_token','1aa029ef9331945813d2ff323c730421df9f5f31251de11067c4e2c84690be02','[\"*\"]','2026-05-26 09:41:17',NULL,'2026-05-26 09:40:49','2026-05-26 09:41:17');
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_images`
--

DROP TABLE IF EXISTS `post_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_images` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint unsigned NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order` tinyint unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `post_images_post_id_index` (`post_id`),
  CONSTRAINT `post_images_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_images`
--

LOCK TABLES `post_images` WRITE;
/*!40000 ALTER TABLE `post_images` DISABLE KEYS */;
INSERT INTO `post_images` VALUES (1,1,'https://vgvtcncpzukejeyvqvpu.storage.supabase.co/storage/v1/s3/mybucket/posts/1/826e5e6a-3745-4269-841f-344d785b668a.jfif','posts/1/826e5e6a-3745-4269-841f-344d785b668a.jfif',0,'2026-05-26 01:44:54','2026-05-26 01:44:54'),(2,2,'https://vgvtcncpzukejeyvqvpu.storage.supabase.co/storage/v1/s3/mybucket/posts/2/479b51fb-a4d5-4a3f-89ae-ccecd7d15f69.png','posts/2/479b51fb-a4d5-4a3f-89ae-ccecd7d15f69.png',0,'2026-05-26 01:49:30','2026-05-26 01:49:30'),(3,3,'https://vgvtcncpzukejeyvqvpu.storage.supabase.co/storage/v1/s3/mybucket/posts/3/37b908a3-7506-4b66-93c5-fa6e1c6ef8cb.png','posts/3/37b908a3-7506-4b66-93c5-fa6e1c6ef8cb.png',0,'2026-05-26 01:52:26','2026-05-26 01:52:26'),(4,4,'https://vgvtcncpzukejeyvqvpu.storage.supabase.co/storage/v1/s3/mybucket/posts/4/77a29013-50bf-4850-89d6-87c9ee8cecf1.png','posts/4/77a29013-50bf-4850-89d6-87c9ee8cecf1.png',0,'2026-05-26 01:59:41','2026-05-26 01:59:41'),(5,6,'https://vgvtcncpzukejeyvqvpu.storage.supabase.co/storage/v1/s3/mybucket/posts/6/5fe22ebb-14c6-4a93-8b6a-5b4aabbb5c1a.png','posts/6/5fe22ebb-14c6-4a93-8b6a-5b4aabbb5c1a.png',0,'2026-05-26 02:07:17','2026-05-26 02:07:17'),(6,7,'https://vgvtcncpzukejeyvqvpu.storage.supabase.co/storage/v1/s3/mybucket/posts/7/36c3b9ff-1dae-41e2-b8eb-136dfa25d7fb.png','posts/7/36c3b9ff-1dae-41e2-b8eb-136dfa25d7fb.png',0,'2026-05-26 02:20:47','2026-05-26 02:20:47'),(7,8,'https://vgvtcncpzukejeyvqvpu.storage.supabase.co/storage/v1/s3/posts/8/e6ffd927-5ea3-4881-93fc-05219528bc67.png','posts/8/e6ffd927-5ea3-4881-93fc-05219528bc67.png',0,'2026-05-26 02:40:49','2026-05-26 02:40:49'),(8,9,'https://vgvtcncpzukejeyvqvpu.storage.supabase.co/storage/v1/s3/posts/9/1812b39a-0f00-412e-828d-dc15ce2012fe.png','posts/9/1812b39a-0f00-412e-828d-dc15ce2012fe.png',0,'2026-05-26 02:51:44','2026-05-26 02:51:44'),(9,10,'https://vgvtcncpzukejeyvqvpu.supabase.co/storage/v1/object/public/posts/posts/10/435aaa61-5127-41a9-9138-5351c59e306f.png','posts/10/435aaa61-5127-41a9-9138-5351c59e306f.png',0,'2026-05-26 03:00:50','2026-05-26 03:00:50'),(10,11,'https://vgvtcncpzukejeyvqvpu.supabase.co/storage/v1/object/public/posts/posts/11/e3ac04c0-cc3b-4812-85a4-d18f0bcba983.png','posts/11/e3ac04c0-cc3b-4812-85a4-d18f0bcba983.png',0,'2026-05-26 03:29:48','2026-05-26 03:29:48'),(11,12,'https://vgvtcncpzukejeyvqvpu.supabase.co/storage/v1/object/public/posts/posts/12/744bc780-7a5b-4156-a903-9810d2d823fe.png','posts/12/744bc780-7a5b-4156-a903-9810d2d823fe.png',0,'2026-05-26 04:34:35','2026-05-26 04:34:35'),(12,13,'https://vgvtcncpzukejeyvqvpu.supabase.co/storage/v1/object/public/posts/posts/13/fec6166e-558d-4738-9d85-2896e800dcb9.png','posts/13/fec6166e-558d-4738-9d85-2896e800dcb9.png',0,'2026-05-26 05:07:46','2026-05-26 05:07:46'),(13,14,'https://vgvtcncpzukejeyvqvpu.supabase.co/storage/v1/object/public/posts/posts/14/230cc7c5-df0c-45ad-bfdd-dd18b7fc2661.png','posts/14/230cc7c5-df0c-45ad-bfdd-dd18b7fc2661.png',0,'2026-05-26 05:13:30','2026-05-26 05:13:30'),(14,15,'https://vgvtcncpzukejeyvqvpu.supabase.co/storage/v1/object/public/posts/posts/15/52ad95c7-ac04-4973-ba6f-83538409855e.png','posts/15/52ad95c7-ac04-4973-ba6f-83538409855e.png',0,'2026-05-26 05:22:57','2026-05-26 05:22:57'),(15,16,'https://vgvtcncpzukejeyvqvpu.supabase.co/storage/v1/object/public/posts/posts/16/3c491ea8-7b9a-44f4-937c-3569fac66efe.png','posts/16/3c491ea8-7b9a-44f4-937c-3569fac66efe.png',0,'2026-05-26 06:38:56','2026-05-26 06:38:56'),(16,17,'https://vgvtcncpzukejeyvqvpu.supabase.co/storage/v1/object/public/posts/posts/17/06e7f4b8-c7c9-4dfe-982a-2fed918d648c.png','posts/17/06e7f4b8-c7c9-4dfe-982a-2fed918d648c.png',0,'2026-05-26 09:20:02','2026-05-26 09:20:02');
/*!40000 ALTER TABLE `post_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `title` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `visibility` enum('public','private') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'public',
  `likes_count` bigint unsigned NOT NULL DEFAULT '0',
  `comments_count` bigint unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `posts_user_id_created_at_index` (`user_id`,`created_at`),
  KEY `posts_visibility_created_at_index` (`visibility`,`created_at`),
  CONSTRAINT `posts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,1,'Test','public',0,0,'2026-05-26 01:44:49','2026-05-26 01:44:49',NULL),(2,1,'Test Post','public',0,0,'2026-05-26 01:49:27','2026-05-26 01:49:27',NULL),(3,1,'Test Posts','public',0,0,'2026-05-26 01:52:24','2026-05-26 01:52:24',NULL),(4,1,'New Post','public',0,0,'2026-05-26 01:59:27','2026-05-26 01:59:27',NULL),(5,1,'TESTTT','public',0,0,'2026-05-26 02:05:58','2026-05-26 02:05:58',NULL),(6,1,'TEST','public',0,0,'2026-05-26 02:07:16','2026-05-26 02:07:16',NULL),(7,1,'TEST POST','public',0,0,'2026-05-26 02:20:44','2026-05-26 02:20:44',NULL),(8,1,'TESTB','public',0,0,'2026-05-26 02:40:45','2026-05-26 02:40:45',NULL),(9,1,'TEST','public',0,0,'2026-05-26 02:51:41','2026-05-26 02:51:41',NULL),(10,1,'TEST POST WITH IMAGE','public',0,0,'2026-05-26 03:00:48','2026-05-26 03:00:48',NULL),(11,1,'TEST','public',0,0,'2026-05-26 03:29:46','2026-05-26 03:29:46',NULL),(12,1,'TE','public',0,0,'2026-05-26 04:34:33','2026-05-26 04:34:33',NULL),(13,1,'RECENT POST BY Partho','public',0,0,'2026-05-26 05:07:45','2026-05-26 05:07:45',NULL),(14,1,'8080New','public',1,0,'2026-05-26 05:13:29','2026-05-26 09:41:17',NULL),(15,1,'TESTTTT','public',1,0,'2026-05-26 05:22:54','2026-05-26 06:36:34',NULL),(16,1,'NEWS','public',1,1,'2026-05-26 06:38:54','2026-05-26 09:41:11',NULL),(17,1,'hellow','public',1,1,'2026-05-26 09:20:00','2026-05-26 09:41:07',NULL);
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `replies`
--

DROP TABLE IF EXISTS `replies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `replies` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `comment_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `likes_count` bigint unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `replies_comment_id_created_at_index` (`comment_id`,`created_at`),
  KEY `replies_user_id_index` (`user_id`),
  CONSTRAINT `replies_comment_id_foreign` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `replies_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `replies`
--

LOCK TABLES `replies` WRITE;
/*!40000 ALTER TABLE `replies` DISABLE KEYS */;
INSERT INTO `replies` VALUES (1,2,1,'TEST REPLY',0,'2026-05-26 08:30:54','2026-05-26 08:34:02','2026-05-26 08:34:02'),(2,2,1,'ggg',0,'2026-05-26 08:33:49','2026-05-26 08:34:04','2026-05-26 08:34:04');
/*!40000 ALTER TABLE `replies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `google_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'email',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_email_index` (`email`),
  KEY `users_google_id_index` (`google_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Test','Name','test@email.com','$2y$12$e3fFT3z388tBHQxnyjYVFexQkVOFKVYPCHNWqS9AVlGiSOntjJhUy',NULL,NULL,'email',NULL,NULL,'2026-05-26 00:03:18','2026-05-26 00:03:18');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-26 21:58:55
