CREATE DATABASE  IF NOT EXISTS `finpro`;
USE `finpro`;

DROP TABLE IF EXISTS `account_type`;
CREATE TABLE `account_type` (
  `ID` int DEFAULT NULL,
  `AccountType` varchar(100) DEFAULT NULL,
  UNIQUE KEY `AccountType_UNIQUE` (`AccountType`)
);

DROP TABLE IF EXISTS `branches`;
CREATE TABLE `branches` (
  `BranchCode` varchar(100) DEFAULT NULL,
  `BranchName` text,
  UNIQUE KEY `BranchCode_UNIQUE` (`BranchCode`)
);

DROP TABLE IF EXISTS `countries`;
CREATE TABLE `countries` (
  `CountryID` int DEFAULT NULL,
  `CountryName` varchar(100) DEFAULT NULL,
  `CountryCode` text,
  `Continent` text,
  UNIQUE KEY `CountryName_UNIQUE` (`CountryName`)
);

DROP TABLE IF EXISTS `customer_data`;
CREATE TABLE `customer_data` (
  `CustomerID` int DEFAULT NULL,
  `CustomerName` text,
  `Email` text,
  `DateOfBirth` text,
  `AccountId` varchar(100) DEFAULT NULL,
  `AccountType` varchar(100) DEFAULT NULL,
  `BranchCode` varchar(100) DEFAULT NULL,
  `Country` varchar(100) DEFAULT NULL,
  `DateJoined` text,
  `Balance` int DEFAULT NULL,
  UNIQUE KEY `AccountId_UNIQUE` (`AccountId`),
  KEY `actype_idx` (`AccountType`),
  KEY `bcode_idx` (`BranchCode`),
  KEY `ctry_idx` (`Country`),
  CONSTRAINT `actype` FOREIGN KEY (`AccountType`) REFERENCES `account_type` (`AccountType`),
  CONSTRAINT `bcode` FOREIGN KEY (`BranchCode`) REFERENCES `branches` (`BranchCode`),
  CONSTRAINT `ctry` FOREIGN KEY (`Country`) REFERENCES `countries` (`CountryName`)
);

DROP TABLE IF EXISTS `us_cities`;
CREATE TABLE `us_cities` (
  `Id` int DEFAULT NULL,
  `CityCode` text,
  `CityName` varchar(100) DEFAULT NULL,
  UNIQUE KEY `CityName_UNIQUE` (`CityName`),
  KEY `idx` (`CityName`)
);

DROP TABLE IF EXISTS `transaction_data`;
CREATE TABLE `transaction_data` (
  `TransactionID` int DEFAULT NULL,
  `AccountId` varchar(100) DEFAULT NULL,
  `TransactionDate` text,
  `TransactionType` text,
  `TransactionAmount` int DEFAULT NULL,
  `TransactionLocation` varchar(100) DEFAULT NULL,
  KEY `LOC_idx` (`TransactionLocation`),
  KEY `acct_idx` (`AccountId`),
  CONSTRAINT `acct` FOREIGN KEY (`AccountId`) REFERENCES `customer_data` (`AccountId`),
  CONSTRAINT `LOC` FOREIGN KEY (`TransactionLocation`) REFERENCES `us_cities` (`CityName`)
);