-- MySQL dump 10.13  Distrib 9.7.2, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: lichess
-- ------------------------------------------------------
-- Server version	9.7.2

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ 'ee4c2ef8-25c8-11ee-a844-bc5ff470b0f9:1-68070';

--
-- Current Database: `lichess`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `lichess` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `lichess`;

--
-- Table structure for table `games`
--

DROP TABLE IF EXISTS `games`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `games` (
  `id` char(8) NOT NULL,
  `created_at` datetime NOT NULL,
  `last_move_at` datetime NOT NULL,
  `player` varchar(100) NOT NULL,
  `player_color` enum('w','b') NOT NULL,
  `player_rating` int unsigned NOT NULL,
  `player_rating_diff` int NOT NULL,
  `opponent` varchar(100) NOT NULL,
  `opponent_name` varchar(100) NOT NULL,
  `opponent_rating` int unsigned NOT NULL,
  `opponent_rating_diff` int NOT NULL,
  `result` decimal(2,1) NOT NULL,
  `perf` varchar(20) NOT NULL DEFAULT 'rapid',
  `status` varchar(20) NOT NULL,
  `moves` text NOT NULL,
  `number_moves` int unsigned NOT NULL,
  `rated` enum('True','False') NOT NULL DEFAULT 'True',
  `variant` varchar(20) NOT NULL DEFAULT 'standard',
  PRIMARY KEY (`id`),
  KEY `opponent` (`opponent`(10))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `v_games_by_day`
--

DROP TABLE IF EXISTS `v_games_by_day`;
/*!50001 DROP VIEW IF EXISTS `v_games_by_day`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_games_by_day` AS SELECT 
 1 AS `dt`,
 1 AS `win`,
 1 AS `draw`,
 1 AS `loss`,
 1 AS `points`,
 1 AS `games_played`,
 1 AS `percent`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_games_by_month`
--

DROP TABLE IF EXISTS `v_games_by_month`;
/*!50001 DROP VIEW IF EXISTS `v_games_by_month`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_games_by_month` AS SELECT 
 1 AS `month`,
 1 AS `win`,
 1 AS `draw`,
 1 AS `loss`,
 1 AS `points`,
 1 AS `games_played`,
 1 AS `percent`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_multiple_opponents`
--

DROP TABLE IF EXISTS `v_multiple_opponents`;
/*!50001 DROP VIEW IF EXISTS `v_multiple_opponents`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_multiple_opponents` AS SELECT 
 1 AS `opponent`,
 1 AS `cnt`,
 1 AS `first_game`,
 1 AS `last_game`,
 1 AS `points`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_performance`
--

DROP TABLE IF EXISTS `v_performance`;
/*!50001 DROP VIEW IF EXISTS `v_performance`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_performance` AS SELECT 
 1 AS `dt`,
 1 AS `rating`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'lichess'
--

--
-- Current Database: `lichess`
--

USE `lichess`;

--
-- Final view structure for view `v_games_by_day`
--

/*!50001 DROP VIEW IF EXISTS `v_games_by_day`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`mpopp`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_games_by_day` AS select cast(`games`.`created_at` as date) AS `dt`,sum((`games`.`result` = 1.0)) AS `win`,sum((`games`.`result` = 0.5)) AS `draw`,sum((`games`.`result` = 0.0)) AS `loss`,sum(`games`.`result`) AS `points`,count(0) AS `games_played`,round(((100 * sum(`games`.`result`)) / count(0)),1) AS `percent` from `games` group by cast(`games`.`created_at` as date) order by `dt` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_games_by_month`
--

/*!50001 DROP VIEW IF EXISTS `v_games_by_month`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`mpopp`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_games_by_month` AS select left(`games`.`created_at`,7) AS `month`,sum((`games`.`result` = 1.0)) AS `win`,sum((`games`.`result` = 0.5)) AS `draw`,sum((`games`.`result` = 0.0)) AS `loss`,sum(`games`.`result`) AS `points`,count(0) AS `games_played`,round(((100 * sum(`games`.`result`)) / count(0)),1) AS `percent` from `games` group by left(`games`.`created_at`,7) order by `month` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_multiple_opponents`
--

/*!50001 DROP VIEW IF EXISTS `v_multiple_opponents`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`mpopp`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_multiple_opponents` AS select `games`.`opponent` AS `opponent`,count(0) AS `cnt`,min(cast(`games`.`created_at` as date)) AS `first_game`,max(cast(`games`.`created_at` as date)) AS `last_game`,sum(`games`.`result`) AS `points` from `games` group by `games`.`opponent` having (`cnt` > 1) order by `cnt` desc,`points` desc,`first_game` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_performance`
--

/*!50001 DROP VIEW IF EXISTS `v_performance`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`mpopp`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_performance` AS select cast(`a`.`created_at` as date) AS `dt`,(`a`.`player_rating` + `a`.`player_rating_diff`) AS `rating` from `games` `a` where (`a`.`created_at` = (select max(`b`.`created_at`) from `games` `b` where (cast(`b`.`created_at` as date) = cast(`a`.`created_at` as date)))) order by `a`.`created_at` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-31  7:20:01
