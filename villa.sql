CREATE DATABASE  IF NOT EXISTS `villa` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `villa`;
-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: localhost    Database: villa
-- ------------------------------------------------------
-- Server version	8.0.30

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
-- Table structure for table `acquista`
--

DROP TABLE IF EXISTS `acquista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `acquista` (
  `cod_prodotto` int NOT NULL,
  `cod_utente` int NOT NULL,
  `mail_utente` varchar(45) NOT NULL,
  PRIMARY KEY (`cod_prodotto`,`cod_utente`,`mail_utente`),
  KEY `cod_utente_idx` (`cod_utente`),
  KEY `mail_utente_idx` (`mail_utente`),
  CONSTRAINT `cod_prodotto` FOREIGN KEY (`cod_prodotto`) REFERENCES `prodotto` (`idprodotto`),
  CONSTRAINT `cod_utente` FOREIGN KEY (`cod_utente`) REFERENCES `utente` (`idutente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acquista`
--

LOCK TABLES `acquista` WRITE;
/*!40000 ALTER TABLE `acquista` DISABLE KEYS */;
/*!40000 ALTER TABLE `acquista` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `connessione`
--

DROP TABLE IF EXISTS `connessione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `connessione` (
  `cod_macchinetta` int NOT NULL,
  `email_utente` varchar(45) NOT NULL,
  PRIMARY KEY (`cod_macchinetta`,`email_utente`),
  UNIQUE KEY `email` (`email_utente`) /*!80000 INVISIBLE */,
  KEY `email_idx` (`email_utente`),
  CONSTRAINT `email` FOREIGN KEY (`email_utente`) REFERENCES `utente` (`email`),
  CONSTRAINT `idmacchinetta` FOREIGN KEY (`cod_macchinetta`) REFERENCES `macchinetta` (`idmacchinetta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `connessione`
--

LOCK TABLES `connessione` WRITE;
/*!40000 ALTER TABLE `connessione` DISABLE KEYS */;
/*!40000 ALTER TABLE `connessione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `macchinetta`
--

DROP TABLE IF EXISTS `macchinetta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `macchinetta` (
  `idmacchinetta` int NOT NULL AUTO_INCREMENT,
  `modello` varchar(45) DEFAULT NULL,
  `stato` int NOT NULL,
  PRIMARY KEY (`idmacchinetta`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `macchinetta`
--

LOCK TABLES `macchinetta` WRITE;
/*!40000 ALTER TABLE `macchinetta` DISABLE KEYS */;
INSERT INTO `macchinetta` VALUES (1,'Samsung A2',0),(2,'Samsung A2',0),(3,'Kimbo 3',0),(4,'ART 4872',0),(5,'J328',0);
/*!40000 ALTER TABLE `macchinetta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `possiede`
--

DROP TABLE IF EXISTS `possiede`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `possiede` (
  `cod_macchinetta` int NOT NULL,
  `cod_prodotto` int NOT NULL,
  `quantita` int DEFAULT NULL,
  PRIMARY KEY (`cod_macchinetta`,`cod_prodotto`),
  KEY `cod_prodotto_idx` (`cod_prodotto`),
  CONSTRAINT `cod_macchinetta` FOREIGN KEY (`cod_macchinetta`) REFERENCES `macchinetta` (`idmacchinetta`),
  CONSTRAINT `ref_prodotto` FOREIGN KEY (`cod_prodotto`) REFERENCES `prodotto` (`idprodotto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `possiede`
--

LOCK TABLES `possiede` WRITE;
/*!40000 ALTER TABLE `possiede` DISABLE KEYS */;
INSERT INTO `possiede` VALUES (1,1,14),(1,2,8),(1,3,10),(1,4,5),(1,5,21),(1,6,19),(1,7,12),(1,8,10),(1,9,13),(2,1,20),(2,2,18),(2,3,2),(2,4,8),(2,5,20),(2,6,21),(2,7,25),(2,8,15),(2,9,22),(3,1,20),(3,2,18),(3,3,10),(3,4,9),(3,5,20),(3,6,21),(3,7,25),(3,8,15),(3,9,22),(4,1,20),(4,2,18),(4,3,9),(4,4,9),(4,5,20),(4,6,21),(4,7,25),(4,8,15),(4,9,22),(5,1,20),(5,2,15),(5,3,10),(5,4,8),(5,5,20),(5,6,21),(5,7,25),(5,8,15),(5,9,22);
/*!40000 ALTER TABLE `possiede` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prodotto`
--

DROP TABLE IF EXISTS `prodotto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prodotto` (
  `idprodotto` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  `tipo` varchar(45) DEFAULT NULL,
  `costo` int DEFAULT NULL,
  PRIMARY KEY (`idprodotto`,`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prodotto`
--

LOCK TABLES `prodotto` WRITE;
/*!40000 ALTER TABLE `prodotto` DISABLE KEYS */;
INSERT INTO `prodotto` VALUES (1,'caffe','bevanda calda',1),(2,'the verde','bevanda calda',3),(3,'the al limone','bevanda fredda',3),(4,'cappuccino','bevanda calda',2),(5,'cioccolata calda','bevanda calda',4),(6,'latte di mandorla','bevanda fredda',1),(7,'espresso','bevanda calda',2),(8,'caffe con ginseng','bevanda calda',2),(9,'orzo','bevanda calda',1);
/*!40000 ALTER TABLE `prodotto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utente`
--

DROP TABLE IF EXISTS `utente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utente` (
  `idutente` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) DEFAULT NULL,
  `cognome` varchar(45) DEFAULT NULL,
  `email` varchar(80) NOT NULL,
  `password` varchar(1000) NOT NULL,
  `credito` int DEFAULT NULL,
  PRIMARY KEY (`idutente`,`email`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utente`
--

LOCK TABLES `utente` WRITE;
/*!40000 ALTER TABLE `utente` DISABLE KEYS */;
INSERT INTO `utente` VALUES (15,'Marco','Moscardelli','mosca43@gmail.com','8890a74e12a37bdec8e39e00fec6c1cef2032c6e98fca2e326509c0b70878cdff44e69e2c0c5a24e90693de54f0ce02efead7bdc5ad2f3c02b6996ceecb28053',0),(16,'Giovanni','Settimo','Settimo34@libero.it','8eed7d56838fa036228fe7ad84ac1936b07766074f3276bd3d5a06877aec21eab1472d8301a5f6da3a83f3318e61f90c0919b1ee1d9a5a9e63a93ac35847dbf1',10),(17,'Mario ','Rossi','mariorossi@libero.it','2d8630a13f8c0e3545f8579312c2b078f09701420d910f85ed492b1b9c87f88354b43d188218309ef06eb08debb7a2e6c26a7baba292f428ac694d9378f3d67',30),(18,'Mario','Rossi','mariorossi@hotmail.com','e9d71bad5c9a719fbb122539b4697005fb804c68081247bd45973b17d97ee96bbb7a49f51fc67a062b5b9e1aa6f5705ec1041bbd2ee6233beee897c768524bbc',40),(19,'Gabriele','Musso','gabrielemusso@live.it','6c36fc0c5404266a0e214e95d02cac4fc8a3e9bf33952a31bd137c265c6c906016d8cfec778fffeaf2a607669f0d983b1f47535591b54c17861e78fb50d294d2',0),(20,'Riccardo','Verdi','RiccardoVerdi@gmail.com','6c36fc0c5404266a0e214e95d02cac4fc8a3e9bf33952a31bd137c265c6c906016d8cfec778fffeaf2a607669f0d983b1f47535591b54c17861e78fb50d294d2',0),(21,'Riccardo','Leone','riccardoleone@libero.it','e53f5f49d482918dc7dba54245908591a872a86573d429dd51a680937ba2ba12a2644f2351cb85fce0bcc0401f10755a79f0180eee98c6cbf0eba13d84ab9591',37),(23,'gino','cugino','ginogino@gino.com','3b84447ec61b3973d6a2f027e2bb98641c6becfd7bef932f1320d11fd0169461bc6a22a70232275cd3287e3f648a9cfd2a4e2931351eff100256139635508f00',2),(24,'kan','kan','kan@kan.it','52f1f129b213f48b49bf505d2e5350d9ad9aaf9fad55ff36112b52d2015ce26762b89ac34bafe3d77840e3b78a90e73db5421189e25c4f4c9ed67430dde0113c',220),(25,'Patrizia','Rossi','patriziarossi@libero.com','b2c7ef393b29809578c37857a5251e4c099ca039d2b700600eac4ebdad7ade10b22116a11bcc18de7a63913d3791c58d5b204ab589fc376fbc831e3dd896f15b',67),(27,'Riccardo','Licari','rlc@pm.it','9eb48b96088e86d57007910b65d250525e97b50eaeb87a26279ba85d1db647d3db55e9f0e44a494ebbb17357464b7074676f7f1c13165d714c427695336aad0c',4995);
/*!40000 ALTER TABLE `utente` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-11-07 20:42:28
