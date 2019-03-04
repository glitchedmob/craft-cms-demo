-- MySQL dump 10.13  Distrib 5.7.24, for osx10.14 (x86_64)
--
-- Host: localhost    Database: craftdemo
-- ------------------------------------------------------
-- Server version	5.7.24

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
-- Table structure for table `assetindexdata`
--

DROP TABLE IF EXISTS `assetindexdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assetindexdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(36) NOT NULL DEFAULT '',
  `volumeId` int(11) NOT NULL,
  `uri` text,
  `size` bigint(20) unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `recordId` int(11) DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT '0',
  `completed` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assetindexdata_sessionId_volumeId_idx` (`sessionId`,`volumeId`),
  KEY `assetindexdata_volumeId_idx` (`volumeId`),
  CONSTRAINT `assetindexdata_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assets`
--

DROP TABLE IF EXISTS `assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assets` (
  `id` int(11) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `folderId` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `kind` varchar(50) NOT NULL DEFAULT 'unknown',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `focalPoint` varchar(13) DEFAULT NULL,
  `deletedWithVolume` tinyint(1) DEFAULT NULL,
  `keptFile` tinyint(1) DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assets_filename_folderId_idx` (`filename`,`folderId`),
  KEY `assets_folderId_idx` (`folderId`),
  KEY `assets_volumeId_idx` (`volumeId`),
  CONSTRAINT `assets_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assettransformindex`
--

DROP TABLE IF EXISTS `assettransformindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assettransformindex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assetId` int(11) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `fileExists` tinyint(1) NOT NULL DEFAULT '0',
  `inProgress` tinyint(1) NOT NULL DEFAULT '0',
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assettransformindex_volumeId_assetId_location_idx` (`volumeId`,`assetId`,`location`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assettransforms`
--

DROP TABLE IF EXISTS `assettransforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assettransforms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `mode` enum('stretch','fit','crop') NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') NOT NULL DEFAULT 'center-center',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `quality` int(11) DEFAULT NULL,
  `interlace` enum('none','line','plane','partition') NOT NULL DEFAULT 'none',
  `dimensionChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `assettransforms_name_unq_idx` (`name`),
  UNIQUE KEY `assettransforms_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categories_groupId_idx` (`groupId`),
  KEY `categories_parentId_fk` (`parentId`),
  CONSTRAINT `categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categorygroups`
--

DROP TABLE IF EXISTS `categorygroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorygroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categorygroups_name_idx` (`name`),
  KEY `categorygroups_handle_idx` (`handle`),
  KEY `categorygroups_structureId_idx` (`structureId`),
  KEY `categorygroups_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `categorygroups_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categorygroups_sites`
--

DROP TABLE IF EXISTS `categorygroups_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorygroups_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `categorygroups_sites_groupId_siteId_unq_idx` (`groupId`,`siteId`),
  KEY `categorygroups_sites_siteId_idx` (`siteId`),
  CONSTRAINT `categorygroups_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categorygroups_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `content`
--

DROP TABLE IF EXISTS `content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_simpleRichText` text,
  `field_description` text,
  `field_headline` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `content_siteId_idx` (`siteId`),
  KEY `content_title_idx` (`title`),
  CONSTRAINT `content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craftidtokens`
--

DROP TABLE IF EXISTS `craftidtokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craftidtokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `accessToken` text NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craftidtokens_userId_fk` (`userId`),
  CONSTRAINT `craftidtokens_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `deprecationerrors`
--

DROP TABLE IF EXISTS `deprecationerrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deprecationerrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `fingerprint` varchar(255) NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` smallint(6) unsigned DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `traces` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `deprecationerrors_key_fingerprint_unq_idx` (`key`,`fingerprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `elementindexsettings`
--

DROP TABLE IF EXISTS `elementindexsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elementindexsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `elements`
--

DROP TABLE IF EXISTS `elements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `elements_dateDeleted_idx` (`dateDeleted`),
  KEY `elements_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `elements_type_idx` (`type`),
  KEY `elements_enabled_idx` (`enabled`),
  KEY `elements_archived_dateCreated_idx` (`archived`,`dateCreated`),
  CONSTRAINT `elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `elements_sites`
--

DROP TABLE IF EXISTS `elements_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elements_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elements_sites_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `elements_sites_siteId_idx` (`siteId`),
  KEY `elements_sites_slug_siteId_idx` (`slug`,`siteId`),
  KEY `elements_sites_enabled_idx` (`enabled`),
  KEY `elements_sites_uri_siteId_idx` (`uri`,`siteId`),
  CONSTRAINT `elements_sites_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `elements_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entries`
--

DROP TABLE IF EXISTS `entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entries` (
  `id` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `typeId` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `deletedWithEntryType` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entries_postDate_idx` (`postDate`),
  KEY `entries_expiryDate_idx` (`expiryDate`),
  KEY `entries_authorId_idx` (`authorId`),
  KEY `entries_sectionId_idx` (`sectionId`),
  KEY `entries_typeId_idx` (`typeId`),
  KEY `entries_parentId_fk` (`parentId`),
  CONSTRAINT `entries_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `entries` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entrydrafts`
--

DROP TABLE IF EXISTS `entrydrafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entrydrafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text,
  `data` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entrydrafts_sectionId_idx` (`sectionId`),
  KEY `entrydrafts_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `entrydrafts_siteId_idx` (`siteId`),
  KEY `entrydrafts_creatorId_idx` (`creatorId`),
  CONSTRAINT `entrydrafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entrytypes`
--

DROP TABLE IF EXISTS `entrytypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entrytypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT '1',
  `titleLabel` varchar(255) DEFAULT 'Title',
  `titleFormat` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entrytypes_name_sectionId_idx` (`name`,`sectionId`),
  KEY `entrytypes_handle_sectionId_idx` (`handle`,`sectionId`),
  KEY `entrytypes_sectionId_idx` (`sectionId`),
  KEY `entrytypes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `entrytypes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entryversions`
--

DROP TABLE IF EXISTS `entryversions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entryversions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `siteId` int(11) NOT NULL,
  `num` smallint(6) unsigned NOT NULL,
  `notes` text,
  `data` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entryversions_sectionId_idx` (`sectionId`),
  KEY `entryversions_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `entryversions_siteId_idx` (`siteId`),
  KEY `entryversions_creatorId_idx` (`creatorId`),
  CONSTRAINT `entryversions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entryversions_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entryversions_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entryversions_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldgroups`
--

DROP TABLE IF EXISTS `fieldgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldgroups_name_unq_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldlayoutfields`
--

DROP TABLE IF EXISTS `fieldlayoutfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayoutfields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `tabId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldlayoutfields_layoutId_fieldId_unq_idx` (`layoutId`,`fieldId`),
  KEY `fieldlayoutfields_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayoutfields_tabId_idx` (`tabId`),
  KEY `fieldlayoutfields_fieldId_idx` (`fieldId`),
  CONSTRAINT `fieldlayoutfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_tabId_fk` FOREIGN KEY (`tabId`) REFERENCES `fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldlayouts`
--

DROP TABLE IF EXISTS `fieldlayouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouts_dateDeleted_idx` (`dateDeleted`),
  KEY `fieldlayouts_type_idx` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldlayouttabs`
--

DROP TABLE IF EXISTS `fieldlayouttabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayouttabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouttabs_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayouttabs_layoutId_idx` (`layoutId`),
  CONSTRAINT `fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fields`
--

DROP TABLE IF EXISTS `fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `context` varchar(255) NOT NULL DEFAULT 'global',
  `instructions` text,
  `searchable` tinyint(1) NOT NULL DEFAULT '1',
  `translationMethod` varchar(255) NOT NULL DEFAULT 'none',
  `translationKeyFormat` text,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fields_handle_context_unq_idx` (`handle`,`context`),
  KEY `fields_groupId_idx` (`groupId`),
  KEY `fields_context_idx` (`context`),
  CONSTRAINT `fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `globalsets`
--

DROP TABLE IF EXISTS `globalsets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `globalsets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `globalsets_name_unq_idx` (`name`),
  UNIQUE KEY `globalsets_handle_unq_idx` (`handle`),
  KEY `globalsets_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `info`
--

DROP TABLE IF EXISTS `info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `maintenance` tinyint(1) NOT NULL DEFAULT '0',
  `config` mediumtext,
  `configMap` mediumtext,
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixblocks`
--

DROP TABLE IF EXISTS `matrixblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `ownerSiteId` int(11) DEFAULT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `deletedWithOwner` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `matrixblocks_ownerId_idx` (`ownerId`),
  KEY `matrixblocks_fieldId_idx` (`fieldId`),
  KEY `matrixblocks_typeId_idx` (`typeId`),
  KEY `matrixblocks_sortOrder_idx` (`sortOrder`),
  KEY `matrixblocks_ownerSiteId_idx` (`ownerSiteId`),
  CONSTRAINT `matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerSiteId_fk` FOREIGN KEY (`ownerSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixblocktypes`
--

DROP TABLE IF EXISTS `matrixblocktypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixblocktypes_name_fieldId_unq_idx` (`name`,`fieldId`),
  UNIQUE KEY `matrixblocktypes_handle_fieldId_unq_idx` (`handle`,`fieldId`),
  KEY `matrixblocktypes_fieldId_idx` (`fieldId`),
  KEY `matrixblocktypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `matrixblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixcontent_contentblocks`
--

DROP TABLE IF EXISTS `matrixcontent_contentblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixcontent_contentblocks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_richTextBlock_text` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixcontent_contentblocks_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `matrixcontent_contentblocks_siteId_fk` (`siteId`),
  CONSTRAINT `matrixcontent_contentblocks_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixcontent_contentblocks_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixcontent_imagecalloutset`
--

DROP TABLE IF EXISTS `matrixcontent_imagecalloutset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixcontent_imagecalloutset` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_imageCallout_headline` text,
  `field_imageCallout_text` text,
  `field_imageCallout_button` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixcontent_imagecalloutset_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `matrixcontent_imagecalloutset_siteId_fk` (`siteId`),
  CONSTRAINT `matrixcontent_imagecalloutset_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixcontent_imagecalloutset_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixcontent_linkgroup`
--

DROP TABLE IF EXISTS `matrixcontent_linkgroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixcontent_linkgroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_linkItem_customLink` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixcontent_linkgroup_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `matrixcontent_linkgroup_siteId_fk` (`siteId`),
  CONSTRAINT `matrixcontent_linkgroup_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixcontent_linkgroup_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixcontent_slider`
--

DROP TABLE IF EXISTS `matrixcontent_slider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixcontent_slider` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_slide_headline` text,
  `field_slide_button` text,
  `field_slide_text` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixcontent_slider_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `matrixcontent_slider_siteId_fk` (`siteId`),
  CONSTRAINT `matrixcontent_slider_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixcontent_slider_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixcontent_twocolumncallout`
--

DROP TABLE IF EXISTS `matrixcontent_twocolumncallout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixcontent_twocolumncallout` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_callout_headline` text,
  `field_callout_text` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixcontent_twocolumncallout_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `matrixcontent_twocolumncallout_siteId_fk` (`siteId`),
  CONSTRAINT `matrixcontent_twocolumncallout_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixcontent_twocolumncallout_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pluginId` int(11) DEFAULT NULL,
  `type` enum('app','plugin','content') NOT NULL DEFAULT 'app',
  `name` varchar(255) NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `migrations_pluginId_idx` (`pluginId`),
  KEY `migrations_type_pluginId_idx` (`type`,`pluginId`),
  CONSTRAINT `migrations_pluginId_fk` FOREIGN KEY (`pluginId`) REFERENCES `plugins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=138 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugins`
--

DROP TABLE IF EXISTS `plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `schemaVersion` varchar(255) NOT NULL,
  `licenseKeyStatus` enum('valid','invalid','mismatched','astray','unknown') NOT NULL DEFAULT 'unknown',
  `licensedEdition` varchar(255) DEFAULT NULL,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `plugins_handle_unq_idx` (`handle`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `queue`
--

DROP TABLE IF EXISTS `queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job` longblob NOT NULL,
  `description` text,
  `timePushed` int(11) NOT NULL,
  `ttr` int(11) NOT NULL,
  `delay` int(11) NOT NULL DEFAULT '0',
  `priority` int(11) unsigned NOT NULL DEFAULT '1024',
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int(11) DEFAULT NULL,
  `progress` smallint(6) NOT NULL DEFAULT '0',
  `attempt` int(11) DEFAULT NULL,
  `fail` tinyint(1) DEFAULT '0',
  `dateFailed` datetime DEFAULT NULL,
  `error` text,
  PRIMARY KEY (`id`),
  KEY `queue_fail_timeUpdated_timePushed_idx` (`fail`,`timeUpdated`,`timePushed`),
  KEY `queue_fail_timeUpdated_delay_idx` (`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `relations`
--

DROP TABLE IF EXISTS `relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `sourceId` int(11) NOT NULL,
  `sourceSiteId` int(11) DEFAULT NULL,
  `targetId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `relations_fieldId_sourceId_sourceSiteId_targetId_unq_idx` (`fieldId`,`sourceId`,`sourceSiteId`,`targetId`),
  KEY `relations_sourceId_idx` (`sourceId`),
  KEY `relations_targetId_idx` (`targetId`),
  KEY `relations_sourceSiteId_idx` (`sourceSiteId`),
  CONSTRAINT `relations_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `relations_targetId_fk` FOREIGN KEY (`targetId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resourcepaths`
--

DROP TABLE IF EXISTS `resourcepaths`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resourcepaths` (
  `hash` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `searchindex`
--

DROP TABLE IF EXISTS `searchindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `searchindex` (
  `elementId` int(11) NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `searchindex_keywords_idx` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('single','channel','structure') NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint(1) NOT NULL DEFAULT '0',
  `propagateEntries` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sections_handle_idx` (`handle`),
  KEY `sections_name_idx` (`name`),
  KEY `sections_structureId_idx` (`structureId`),
  KEY `sections_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sections_sites`
--

DROP TABLE IF EXISTS `sections_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sections_sites_sectionId_siteId_unq_idx` (`sectionId`,`siteId`),
  KEY `sections_sites_siteId_idx` (`siteId`),
  CONSTRAINT `sections_sites_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sections_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sequences`
--

DROP TABLE IF EXISTS `sequences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sequences` (
  `name` varchar(255) NOT NULL,
  `next` int(11) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `token` char(100) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sessions_uid_idx` (`uid`),
  KEY `sessions_token_idx` (`token`),
  KEY `sessions_dateUpdated_idx` (`dateUpdated`),
  KEY `sessions_userId_idx` (`userId`),
  CONSTRAINT `sessions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shunnedmessages`
--

DROP TABLE IF EXISTS `shunnedmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shunnedmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `shunnedmessages_userId_message_unq_idx` (`userId`,`message`),
  CONSTRAINT `shunnedmessages_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sitegroups`
--

DROP TABLE IF EXISTS `sitegroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sitegroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sitegroups_name_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sites`
--

DROP TABLE IF EXISTS `sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '0',
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sites_dateDeleted_idx` (`dateDeleted`),
  KEY `sites_handle_idx` (`handle`),
  KEY `sites_sortOrder_idx` (`sortOrder`),
  KEY `sites_groupId_fk` (`groupId`),
  CONSTRAINT `sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `structureelements`
--

DROP TABLE IF EXISTS `structureelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `structureelements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `elementId` int(11) DEFAULT NULL,
  `root` int(11) unsigned DEFAULT NULL,
  `lft` int(11) unsigned NOT NULL,
  `rgt` int(11) unsigned NOT NULL,
  `level` smallint(6) unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `structureelements_structureId_elementId_unq_idx` (`structureId`,`elementId`),
  KEY `structureelements_root_idx` (`root`),
  KEY `structureelements_lft_idx` (`lft`),
  KEY `structureelements_rgt_idx` (`rgt`),
  KEY `structureelements_level_idx` (`level`),
  KEY `structureelements_elementId_idx` (`elementId`),
  CONSTRAINT `structureelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `structureelements_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `structures`
--

DROP TABLE IF EXISTS `structures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `structures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `structures_dateDeleted_idx` (`dateDeleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `systemmessages`
--

DROP TABLE IF EXISTS `systemmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `systemmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `systemmessages_key_language_unq_idx` (`key`,`language`),
  KEY `systemmessages_language_idx` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `taggroups`
--

DROP TABLE IF EXISTS `taggroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taggroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `taggroups_name_idx` (`name`),
  KEY `taggroups_handle_idx` (`handle`),
  KEY `taggroups_dateDeleted_idx` (`dateDeleted`),
  KEY `taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `tags_groupId_idx` (`groupId`),
  CONSTRAINT `tags_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tags_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `templatecacheelements`
--

DROP TABLE IF EXISTS `templatecacheelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templatecacheelements` (
  `cacheId` int(11) NOT NULL,
  `elementId` int(11) NOT NULL,
  KEY `templatecacheelements_cacheId_idx` (`cacheId`),
  KEY `templatecacheelements_elementId_idx` (`elementId`),
  CONSTRAINT `templatecacheelements_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `templatecacheelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `templatecachequeries`
--

DROP TABLE IF EXISTS `templatecachequeries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templatecachequeries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `query` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecachequeries_cacheId_idx` (`cacheId`),
  KEY `templatecachequeries_type_idx` (`type`),
  CONSTRAINT `templatecachequeries_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `templatecaches`
--

DROP TABLE IF EXISTS `templatecaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templatecaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) NOT NULL,
  `cacheKey` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_path_idx` (`cacheKey`,`siteId`,`expiryDate`,`path`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_idx` (`cacheKey`,`siteId`,`expiryDate`),
  KEY `templatecaches_siteId_idx` (`siteId`),
  CONSTRAINT `templatecaches_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` char(32) NOT NULL,
  `route` text,
  `usageLimit` tinyint(3) unsigned DEFAULT NULL,
  `usageCount` tinyint(3) unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tokens_token_unq_idx` (`token`),
  KEY `tokens_expiryDate_idx` (`expiryDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usergroups`
--

DROP TABLE IF EXISTS `usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_handle_unq_idx` (`handle`),
  UNIQUE KEY `usergroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usergroups_users`
--

DROP TABLE IF EXISTS `usergroups_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usergroups_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_users_groupId_userId_unq_idx` (`groupId`,`userId`),
  KEY `usergroups_users_userId_idx` (`userId`),
  CONSTRAINT `usergroups_users_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `usergroups_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpermissions`
--

DROP TABLE IF EXISTS `userpermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpermissions_usergroups`
--

DROP TABLE IF EXISTS `userpermissions_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_usergroups_permissionId_groupId_unq_idx` (`permissionId`,`groupId`),
  KEY `userpermissions_usergroups_groupId_idx` (`groupId`),
  CONSTRAINT `userpermissions_usergroups_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_usergroups_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpermissions_users`
--

DROP TABLE IF EXISTS `userpermissions_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_users_permissionId_userId_unq_idx` (`permissionId`,`userId`),
  KEY `userpermissions_users_userId_idx` (`userId`),
  CONSTRAINT `userpermissions_users_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpreferences`
--

DROP TABLE IF EXISTS `userpreferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpreferences` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `preferences` text,
  PRIMARY KEY (`userId`),
  CONSTRAINT `userpreferences_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `photoId` int(11) DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `suspended` tinyint(1) NOT NULL DEFAULT '0',
  `pending` tinyint(1) NOT NULL DEFAULT '0',
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint(3) unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `hasDashboard` tinyint(1) NOT NULL DEFAULT '0',
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT '0',
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `users_uid_idx` (`uid`),
  KEY `users_verificationCode_idx` (`verificationCode`),
  KEY `users_email_idx` (`email`),
  KEY `users_username_idx` (`username`),
  KEY `users_photoId_fk` (`photoId`),
  CONSTRAINT `users_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `users_photoId_fk` FOREIGN KEY (`photoId`) REFERENCES `assets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `volumefolders`
--

DROP TABLE IF EXISTS `volumefolders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volumefolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `volumefolders_name_parentId_volumeId_unq_idx` (`name`,`parentId`,`volumeId`),
  KEY `volumefolders_parentId_idx` (`parentId`),
  KEY `volumefolders_volumeId_idx` (`volumeId`),
  CONSTRAINT `volumefolders_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `volumefolders_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `volumes`
--

DROP TABLE IF EXISTS `volumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `url` varchar(255) DEFAULT NULL,
  `settings` text,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `volumes_name_idx` (`name`),
  KEY `volumes_handle_idx` (`handle`),
  KEY `volumes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `volumes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `volumes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `widgets`
--

DROP TABLE IF EXISTS `widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `colspan` tinyint(3) DEFAULT NULL,
  `settings` text,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `widgets_userId_idx` (`userId`),
  CONSTRAINT `widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'craftdemo'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-03-03 20:29:59
-- MySQL dump 10.13  Distrib 5.7.24, for osx10.14 (x86_64)
--
-- Host: localhost    Database: craftdemo
-- ------------------------------------------------------
-- Server version	5.7.24

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
-- Dumping data for table `assets`
--

LOCK TABLES `assets` WRITE;
/*!40000 ALTER TABLE `assets` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `assets` VALUES (8,1,1,'placeholder.jpg','image',1920,1280,39150,NULL,NULL,NULL,'2019-03-04 00:28:47','2019-03-04 00:28:47','2019-03-04 00:28:47','8a5b69fc-423d-4c4a-a48b-2700b69a1bae');
/*!40000 ALTER TABLE `assets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `assettransforms`
--

LOCK TABLES `assettransforms` WRITE;
/*!40000 ALTER TABLE `assettransforms` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `assettransforms` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categorygroups`
--

LOCK TABLES `categorygroups` WRITE;
/*!40000 ALTER TABLE `categorygroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `categorygroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categorygroups_sites`
--

LOCK TABLES `categorygroups_sites` WRITE;
/*!40000 ALTER TABLE `categorygroups_sites` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `categorygroups_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `content`
--

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `content` VALUES (1,1,1,NULL,'2019-03-03 19:55:27','2019-03-03 19:55:27','bd8f6335-e6eb-4331-abf5-96cacd6f3377',NULL,NULL,NULL),(2,2,1,'Home Page','2019-03-03 20:13:38','2019-03-04 02:06:14','f869806e-19af-472e-8fe4-ee2b32ba2918',NULL,NULL,NULL),(3,3,1,'Blog Listing','2019-03-03 20:29:18','2019-03-04 02:24:04','387c089f-9f91-4ae7-a712-4e5c8a684ea3',NULL,'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet aspernatur excepturi maiores nam odit porro quas quo sapiente vel voluptatem. Est facilis, ipsum molestiae necessitatibus, neque nihil nisi obcaecati odit optio porro provident sunt tempora?','Blog'),(4,4,1,'Test','2019-03-03 20:44:57','2019-03-04 02:21:20','c5a83c5e-f43c-45ea-a94b-479461592566',NULL,'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet aspernatur excepturi maiores nam odit porro quas quo sapiente vel voluptatem. Est facilis, ipsum molestiae necessitatibus, neque nihil nisi obcaecati odit optio porro provident sunt tempora?',NULL),(5,5,1,NULL,'2019-03-04 00:16:26','2019-03-04 00:20:34','76d54478-3657-415f-b7a7-a8dd6bbdfcda',NULL,NULL,NULL),(6,8,1,'Placeholder','2019-03-04 00:28:46','2019-03-04 00:28:46','3a081ccb-1046-4c9f-820e-b66e1538fbab',NULL,NULL,NULL);
/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craftidtokens`
--

LOCK TABLES `craftidtokens` WRITE;
/*!40000 ALTER TABLE `craftidtokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craftidtokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `deprecationerrors`
--

LOCK TABLES `deprecationerrors` WRITE;
/*!40000 ALTER TABLE `deprecationerrors` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `deprecationerrors` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elementindexsettings`
--

LOCK TABLES `elementindexsettings` WRITE;
/*!40000 ALTER TABLE `elementindexsettings` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `elementindexsettings` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elements`
--

LOCK TABLES `elements` WRITE;
/*!40000 ALTER TABLE `elements` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `elements` VALUES (1,NULL,'craft\\elements\\User',1,0,'2019-03-03 19:55:27','2019-03-03 19:55:27',NULL,'352fd770-8504-4a0a-92d9-a392ad8f91e6'),(2,5,'craft\\elements\\Entry',1,0,'2019-03-03 20:13:38','2019-03-04 02:06:14',NULL,'9a44accb-2633-4a1d-85c6-ee5ee65f13cf'),(3,1,'craft\\elements\\Entry',1,0,'2019-03-03 20:29:18','2019-03-04 02:24:04',NULL,'662691d3-e1e3-4621-9fa7-e01dc6701921'),(4,10,'craft\\elements\\Entry',1,0,'2019-03-03 20:44:56','2019-03-04 02:21:20',NULL,'3ac97ed6-256c-4ab3-9b64-760a89d00b2b'),(5,3,'craft\\elements\\GlobalSet',1,0,'2019-03-04 00:16:26','2019-03-04 00:20:34',NULL,'1745273a-c05c-4b63-b2ec-5f68ed3bb996'),(6,2,'craft\\elements\\MatrixBlock',1,0,'2019-03-04 00:20:34','2019-03-04 00:20:34',NULL,'5d78e80a-9931-4989-92dc-f2661a42031a'),(7,2,'craft\\elements\\MatrixBlock',1,0,'2019-03-04 00:20:34','2019-03-04 00:20:34',NULL,'83a1fec3-d8b1-46c5-858d-25ef48e5a00a'),(8,NULL,'craft\\elements\\Asset',1,0,'2019-03-04 00:28:46','2019-03-04 00:28:46',NULL,'3d4b6b15-393d-4f5d-8b81-cdb54d442dbd'),(9,4,'craft\\elements\\MatrixBlock',1,0,'2019-03-04 00:29:38','2019-03-04 02:06:14',NULL,'5ae40f9b-2e94-4de6-88a1-3caa04e2b97e'),(10,4,'craft\\elements\\MatrixBlock',1,0,'2019-03-04 00:32:19','2019-03-04 02:06:14',NULL,'f1d16c3b-d18c-423b-8236-b8b50cd0f89a'),(11,6,'craft\\elements\\MatrixBlock',1,0,'2019-03-04 02:06:14','2019-03-04 02:06:14',NULL,'b2e2958c-4f25-41b8-9c42-849d5b6cec99'),(12,6,'craft\\elements\\MatrixBlock',1,0,'2019-03-04 02:06:14','2019-03-04 02:06:14',NULL,'e2216a3d-063a-4796-96a9-1b753be0028d'),(13,6,'craft\\elements\\MatrixBlock',1,0,'2019-03-04 02:06:14','2019-03-04 02:06:14',NULL,'eba1e42f-4928-43d4-b389-3b90cfb53be5'),(14,7,'craft\\elements\\MatrixBlock',1,0,'2019-03-04 02:06:14','2019-03-04 02:06:14',NULL,'95c22638-6872-41d5-b4fd-7b77f48da606'),(15,8,'craft\\elements\\MatrixBlock',1,0,'2019-03-04 02:17:18','2019-03-04 02:21:20',NULL,'b6f37e91-fd8c-48e8-a201-6e1aee593c23'),(16,9,'craft\\elements\\MatrixBlock',1,0,'2019-03-04 02:17:18','2019-03-04 02:21:21',NULL,'cb269964-0d90-49c0-a091-ea969c6ad1e2');
/*!40000 ALTER TABLE `elements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elements_sites`
--

LOCK TABLES `elements_sites` WRITE;
/*!40000 ALTER TABLE `elements_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `elements_sites` VALUES (1,1,1,NULL,NULL,1,'2019-03-03 19:55:27','2019-03-03 19:55:27','bb012599-7267-4e3f-acd7-640ae378d87d'),(2,2,1,'home-page','__home__',1,'2019-03-03 20:13:38','2019-03-04 02:06:14','33250c64-b06d-4b54-9ef2-e81323cb0a49'),(3,3,1,'blog-listing','blog',1,'2019-03-03 20:29:18','2019-03-04 02:24:04','e31010c3-4c57-471e-9546-a42b8cd15828'),(4,4,1,'test','blog/test',1,'2019-03-03 20:44:57','2019-03-04 02:21:20','0f139eca-5c3b-45f9-8a5f-01e31193025f'),(5,5,1,NULL,NULL,1,'2019-03-04 00:16:26','2019-03-04 00:20:34','bf425726-bd14-46da-91f7-e35d7e18e714'),(6,6,1,NULL,NULL,1,'2019-03-04 00:20:34','2019-03-04 00:20:34','b99c3911-82fb-4485-925d-21aabe7f1a2b'),(7,7,1,NULL,NULL,1,'2019-03-04 00:20:34','2019-03-04 00:20:34','7a3bd9f7-1402-4cb6-9ec9-2efc3d86a18c'),(8,8,1,NULL,NULL,1,'2019-03-04 00:28:46','2019-03-04 00:28:46','ff55cd25-e3e1-4291-9d2e-073d8029c70b'),(9,9,1,NULL,NULL,1,'2019-03-04 00:29:38','2019-03-04 02:06:14','7d1d1101-c8a4-407c-908b-6b283cbd34cb'),(10,10,1,NULL,NULL,1,'2019-03-04 00:32:19','2019-03-04 02:06:14','220c1fa3-b72b-4230-b295-2b9a21625852'),(11,11,1,NULL,NULL,1,'2019-03-04 02:06:14','2019-03-04 02:06:14','934d570d-3574-41a1-93a3-f2f2ef07fff5'),(12,12,1,NULL,NULL,1,'2019-03-04 02:06:14','2019-03-04 02:06:14','c55dc225-e656-43c3-a031-f091bc6e73cd'),(13,13,1,NULL,NULL,1,'2019-03-04 02:06:14','2019-03-04 02:06:14','912b023f-5f47-4299-bc46-79c6e69cdffd'),(14,14,1,NULL,NULL,1,'2019-03-04 02:06:14','2019-03-04 02:06:14','ac6ba358-dfef-4754-a9c8-6e0034f58e3d'),(15,15,1,NULL,NULL,1,'2019-03-04 02:17:18','2019-03-04 02:21:20','6713967d-43e5-408f-bf6d-726bd0312a4c'),(16,16,1,NULL,NULL,1,'2019-03-04 02:17:18','2019-03-04 02:21:21','892921b9-b198-45b1-94cb-9b341fd5e1d7');
/*!40000 ALTER TABLE `elements_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entries`
--

LOCK TABLES `entries` WRITE;
/*!40000 ALTER TABLE `entries` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `entries` VALUES (2,1,NULL,1,NULL,'2019-03-03 20:13:00',NULL,NULL,'2019-03-03 20:13:38','2019-03-04 02:06:14','93763b0b-1a89-441d-bee3-105bde923ef3'),(3,2,NULL,2,NULL,'2019-03-03 20:29:00',NULL,NULL,'2019-03-03 20:29:18','2019-03-04 02:24:04','a6e80f09-ff1e-4b65-ac31-c5ba749cd28f'),(4,3,NULL,3,1,'2019-03-03 20:44:00',NULL,NULL,'2019-03-03 20:44:57','2019-03-04 02:21:20','951931f5-df61-4c01-b5c9-18fbb69e5a8a');
/*!40000 ALTER TABLE `entries` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entrydrafts`
--

LOCK TABLES `entrydrafts` WRITE;
/*!40000 ALTER TABLE `entrydrafts` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `entrydrafts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entrytypes`
--

LOCK TABLES `entrytypes` WRITE;
/*!40000 ALTER TABLE `entrytypes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `entrytypes` VALUES (1,1,5,'Home Page','homePage',0,'','{section.name|raw}',1,'2019-03-03 20:13:38','2019-03-04 02:03:03',NULL,'cee82091-e714-4340-9fe1-f1b26f579478'),(2,2,1,'Blog Listing','blogListing',1,'Title','',1,'2019-03-03 20:29:01','2019-03-04 02:23:07',NULL,'59d2aaaf-4cad-4a67-81f8-fcefc29b4c9d'),(3,3,10,'Blog Posts','blogPosts',1,'Title','',1,'2019-03-03 20:44:37','2019-03-04 02:15:12',NULL,'7179579e-07b0-4850-93b4-4f7d5c521ec4');
/*!40000 ALTER TABLE `entrytypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entryversions`
--

LOCK TABLES `entryversions` WRITE;
/*!40000 ALTER TABLE `entryversions` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `entryversions` VALUES (1,4,3,1,1,1,'','{\"typeId\":\"3\",\"authorId\":\"1\",\"title\":\"Test\",\"slug\":\"test\",\"postDate\":1551645840,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":[]}','2019-03-03 20:44:57','2019-03-03 20:44:57','b0900910-c913-4aca-b5fc-39954d2fb3d2'),(2,2,1,1,1,1,'Revision from Mar 3, 2019, 4:26:54 PM','{\"typeId\":\"1\",\"authorId\":null,\"title\":\"Home Page\",\"slug\":\"home-page\",\"postDate\":1551643980,\"expiryDate\":null,\"enabled\":\"1\",\"newParentId\":null,\"fields\":{\"4\":[]}}','2019-03-04 00:29:38','2019-03-04 00:29:38','c0d12862-17d4-4765-bb89-ea285f728b86'),(3,2,1,1,1,2,'','{\"typeId\":\"1\",\"authorId\":null,\"title\":\"Home Page\",\"slug\":\"home-page\",\"postDate\":1551643980,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"4\":{\"9\":{\"type\":\"slide\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"image\":[\"8\"],\"headline\":\"Test\",\"text\":\"<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Est nobis placeat quaerat quos? Aliquam distinctio ea enim molestias omnis perspiciatis sunt tenetur! Assumenda beatae deserunt dolorem, maxime mollitia quibusdam tempora!</p>\",\"button\":{\"ariaLabel\":\"\",\"customQuery\":null,\"customText\":\"\",\"target\":\"\",\"title\":\"\",\"type\":\"entry\",\"value\":null}}}}}}','2019-03-04 00:29:38','2019-03-04 00:29:38','086ce1ab-b880-484f-bacc-e8094c4f0215'),(4,2,1,1,1,3,'','{\"typeId\":\"1\",\"authorId\":null,\"title\":\"Home Page\",\"slug\":\"home-page\",\"postDate\":1551643980,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"4\":{\"9\":{\"type\":\"slide\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"image\":[\"8\"],\"headline\":\"Test\",\"text\":\"<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Est nobis placeat quaerat quos? Aliquam distinctio ea enim molestias omnis perspiciatis sunt tenetur! Assumenda beatae deserunt dolorem, maxime mollitia quibusdam tempora!</p>\",\"button\":{\"ariaLabel\":\"\",\"customQuery\":null,\"customText\":\"Blog\",\"target\":\"\",\"title\":\"\",\"type\":\"entry\",\"value\":\"3\"}}}}}}','2019-03-04 00:31:41','2019-03-04 00:31:41','d01b8454-4f6e-416a-8d82-47613c280db1'),(5,2,1,1,1,4,'','{\"typeId\":\"1\",\"authorId\":null,\"title\":\"Home Page\",\"slug\":\"home-page\",\"postDate\":1551643980,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"4\":{\"9\":{\"type\":\"slide\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"image\":[\"8\"],\"headline\":\"Test\",\"text\":\"<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Est nobis placeat quaerat quos? Aliquam distinctio ea enim molestias omnis perspiciatis sunt tenetur! Assumenda beatae deserunt dolorem, maxime mollitia quibusdam tempora!</p>\",\"button\":{\"ariaLabel\":\"\",\"customQuery\":null,\"customText\":\"Blog\",\"target\":\"\",\"title\":\"\",\"type\":\"entry\",\"value\":\"3\"}}},\"10\":{\"type\":\"slide\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"image\":[\"8\"],\"headline\":\"Test 2\",\"text\":\"<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Est nobis placeat quaerat quos? Aliquam distinctio ea enim molestias omnis perspiciatis sunt tenetur! Assumenda beatae deserunt dolorem, maxime mollitia quibusdam tempora!</p>\",\"button\":{\"ariaLabel\":\"\",\"customQuery\":null,\"customText\":\"Home\",\"target\":\"\",\"title\":\"\",\"type\":\"entry\",\"value\":\"2\"}}}}}}','2019-03-04 00:32:19','2019-03-04 00:32:19','e3f48166-36f8-4150-8d0a-5b7299d5b3c8'),(6,2,1,1,1,5,'','{\"typeId\":\"1\",\"authorId\":null,\"title\":\"Home Page\",\"slug\":\"home-page\",\"postDate\":1551643980,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"9\":{\"11\":{\"type\":\"imageCallout\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"image\":[\"8\"],\"headline\":\"Test 1\",\"text\":\"<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Est nobis placeat quaerat quos? Aliquam distinctio ea enim molestias omnis perspiciatis sunt tenetur! Assumenda beatae deserunt dolorem, maxime mollitia quibusdam tempora!</p>\",\"button\":{\"ariaLabel\":\"\",\"customQuery\":null,\"customText\":\"Test\",\"target\":\"\",\"title\":\"\",\"type\":\"entry\",\"value\":\"4\"}}},\"12\":{\"type\":\"imageCallout\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"image\":[\"8\"],\"headline\":\"Test 2\",\"text\":\"<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Est nobis placeat quaerat quos? Aliquam distinctio ea enim molestias omnis perspiciatis sunt tenetur! Assumenda beatae deserunt dolorem, maxime mollitia quibusdam tempora!</p>\",\"button\":{\"ariaLabel\":\"\",\"customQuery\":null,\"customText\":\"Test\",\"target\":\"\",\"title\":\"\",\"type\":\"entry\",\"value\":\"4\"}}},\"13\":{\"type\":\"imageCallout\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"image\":[\"8\"],\"headline\":\"Test 3\",\"text\":\"<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Est nobis placeat quaerat quos? Aliquam distinctio ea enim molestias omnis perspiciatis sunt tenetur! Assumenda beatae deserunt dolorem, maxime mollitia quibusdam tempora!</p>\",\"button\":{\"ariaLabel\":\"\",\"customQuery\":null,\"customText\":\"\",\"target\":\"\",\"title\":\"\",\"type\":\"entry\",\"value\":null}}}},\"4\":{\"9\":{\"type\":\"slide\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"image\":[\"8\"],\"headline\":\"Test\",\"text\":\"<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Est nobis placeat quaerat quos? Aliquam distinctio ea enim molestias omnis perspiciatis sunt tenetur! Assumenda beatae deserunt dolorem, maxime mollitia quibusdam tempora!</p>\",\"button\":{\"ariaLabel\":\"\",\"customQuery\":null,\"customText\":\"Blog\",\"target\":\"\",\"title\":\"\",\"type\":\"entry\",\"value\":\"3\"}}},\"10\":{\"type\":\"slide\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"image\":[\"8\"],\"headline\":\"Test 2\",\"text\":\"<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Est nobis placeat quaerat quos? Aliquam distinctio ea enim molestias omnis perspiciatis sunt tenetur! Assumenda beatae deserunt dolorem, maxime mollitia quibusdam tempora!</p>\",\"button\":{\"ariaLabel\":\"\",\"customQuery\":null,\"customText\":\"Home\",\"target\":\"\",\"title\":\"\",\"type\":\"entry\",\"value\":\"2\"}}}},\"14\":{\"14\":{\"type\":\"callout\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"headline\":\"Test\",\"text\":\"<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Est nobis placeat quaerat quos? Aliquam distinctio ea enim molestias omnis perspiciatis sunt tenetur! Assumenda beatae deserunt dolorem, maxime mollitia quibusdam tempora!</p>\",\"image\":[\"8\"]}}}}}','2019-03-04 02:06:14','2019-03-04 02:06:14','adbd5dc6-ea64-4028-9b57-2303ace7b080'),(7,4,3,1,1,2,'','{\"typeId\":\"3\",\"authorId\":\"1\",\"title\":\"Test\",\"slug\":\"test\",\"postDate\":1551645840,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"20\":{\"15\":{\"type\":\"imageBlock\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"image\":[\"8\"]}},\"16\":{\"type\":\"richTextBlock\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"text\":\"<p>This blog post shows a few different types of content that’s supported and styled with Bootstrap. Basic typography, images, and code are all supported.</p>\\n<p>Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Sed posuere consectetur est at lobortis. Cras mattis consectetur purus sit amet fermentum.</p>\\n<p>Curabitur blandit tempus porttitor. Nullam quis risus eget urna mollis ornare vel eu leo. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>\\n<p>Etiam porta sem malesuada magna mollis euismod. Cras mattis consectetur purus sit amet fermentum. Aenean lacinia bibendum nulla sed consectetur.</p>\\n<h1>Heading</h1>\\n<p>Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.</p>\\n<h3>Sub-heading</h3>\\n<p>Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.</p>\\n<p>Example code block</p>\\n<p>Aenean lacinia bibendum nulla sed consectetur. Etiam porta sem malesuada magna mollis euismod. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa.</p>\\n<h3>Sub-heading</h3>\\n<p>Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aenean lacinia bibendum nulla sed consectetur. Etiam porta sem malesuada magna mollis euismod. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>\\n\\n\\n\\n<ul><li>Praesent commodo cursus magna, vel scelerisque nisl consectetur et.</li><li>Donec id elit non mi porta gravida at eget metus.</li><li>Nulla vitae elit libero, a pharetra augue.</li></ul>\\n<p>Donec ullamcorper nulla non metus auctor fringilla. Nulla vitae elit libero, a pharetra augue.</p>\\n\\n<ol><li>Vestibulum id ligula porta felis euismod semper.</li><li>Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.</li><li>Maecenas sed diam eget risus varius blandit sit amet non magna.</li></ol>\\n<p>Cras mattis consectetur purus sit amet fermentum. Sed posuere consectetur est at lobortis.</p>\"}}},\"19\":[\"8\"]}}','2019-03-04 02:17:18','2019-03-04 02:17:18','e71b6809-063c-4d1d-9b0c-8e5d7b4a4077'),(8,4,3,1,1,3,'','{\"typeId\":\"3\",\"authorId\":\"1\",\"title\":\"Test\",\"slug\":\"test\",\"postDate\":1551645840,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"20\":{\"15\":{\"type\":\"imageBlock\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"image\":[\"8\"]}},\"16\":{\"type\":\"richTextBlock\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"text\":\"<p>This blog post shows a few different types of content that’s supported and styled with Bootstrap. Basic typography, images, and code are all supported.</p>\\n<p>Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Sed posuere consectetur est at lobortis. Cras mattis consectetur purus sit amet fermentum.</p>\\n<p>Curabitur blandit tempus porttitor. Nullam quis risus eget urna mollis ornare vel eu leo. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>\\n<p>Etiam porta sem malesuada magna mollis euismod. Cras mattis consectetur purus sit amet fermentum. Aenean lacinia bibendum nulla sed consectetur.</p>\\n<h1>Heading</h1>\\n<p>Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.</p>\\n<h3>Sub-heading</h3>\\n<p>Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.</p>\\n<p>Example code block</p>\\n<p>Aenean lacinia bibendum nulla sed consectetur. Etiam porta sem malesuada magna mollis euismod. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa.</p>\\n<h3>Sub-heading</h3>\\n<p>Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aenean lacinia bibendum nulla sed consectetur. Etiam porta sem malesuada magna mollis euismod. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>\\n<ul><li>Praesent commodo cursus magna, vel scelerisque nisl consectetur et.</li><li>Donec id elit non mi porta gravida at eget metus.</li><li>Nulla vitae elit libero, a pharetra augue.</li></ul>\\n<p>Donec ullamcorper nulla non metus auctor fringilla. Nulla vitae elit libero, a pharetra augue.</p>\\n<ol><li>Vestibulum id ligula porta felis euismod semper.</li><li>Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.</li><li>Maecenas sed diam eget risus varius blandit sit amet non magna.</li></ol>\\n<p>Cras mattis consectetur purus sit amet fermentum. Sed posuere consectetur est at lobortis.</p>\"}}},\"18\":\"Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet aspernatur excepturi maiores nam odit porro quas quo sapiente vel voluptatem. Est facilis, ipsum molestiae necessitatibus, neque nihil nisi obcaecati odit optio porro provident sunt tempora?\",\"19\":[\"8\"]}}','2019-03-04 02:21:21','2019-03-04 02:21:21','4bd16b26-0e8b-4c7a-84b4-67de65362e09'),(9,3,2,1,1,1,'Revision from Mar 3, 2019, 6:23:07 PM','{\"typeId\":\"2\",\"authorId\":null,\"title\":\"Blog Listing\",\"slug\":\"blog-listing\",\"postDate\":1551644940,\"expiryDate\":null,\"enabled\":\"1\",\"newParentId\":null,\"fields\":[]}','2019-03-04 02:24:04','2019-03-04 02:24:04','d9b55b1a-4750-4d5d-888b-5ef20afc431a'),(10,3,2,1,1,2,'','{\"typeId\":\"2\",\"authorId\":null,\"title\":\"Blog Listing\",\"slug\":\"blog-listing\",\"postDate\":1551644940,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"18\":\"Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet aspernatur excepturi maiores nam odit porro quas quo sapiente vel voluptatem. Est facilis, ipsum molestiae necessitatibus, neque nihil nisi obcaecati odit optio porro provident sunt tempora?\",\"23\":\"Blog\"}}','2019-03-04 02:24:04','2019-03-04 02:24:04','c4b026ee-37ea-49d4-8daf-6289c24a5c34');
/*!40000 ALTER TABLE `entryversions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldgroups`
--

LOCK TABLES `fieldgroups` WRITE;
/*!40000 ALTER TABLE `fieldgroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldgroups` VALUES (1,'Common','2019-03-03 19:55:27','2019-03-03 19:55:27','861b809b-0e21-4836-938c-cd47b81bcff9');
/*!40000 ALTER TABLE `fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayoutfields`
--

LOCK TABLES `fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `fieldlayoutfields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldlayoutfields` VALUES (3,3,3,2,0,1,'2019-03-04 00:18:35','2019-03-04 00:18:35','3687465e-dd52-4a92-aad7-26db58564a4e'),(5,2,5,3,0,1,'2019-03-04 00:20:03','2019-03-04 00:20:03','c42995f9-ada5-4386-a3fe-848838155d75'),(6,4,6,5,1,2,'2019-03-04 00:26:40','2019-03-04 00:26:40','ba54f315-dfa5-46c1-b095-5860b49807fc'),(7,4,6,6,0,4,'2019-03-04 00:26:40','2019-03-04 00:26:40','b5316085-f8a2-4f00-a74f-4da506f6bcf4'),(8,4,6,7,1,3,'2019-03-04 00:26:40','2019-03-04 00:26:40','40986ee7-3777-4f08-83b6-8ca72755ce78'),(9,4,6,8,1,1,'2019-03-04 00:26:40','2019-03-04 00:26:40','48de36e3-22e4-42a1-a8d9-d433c86efa7e'),(15,7,9,15,1,1,'2019-03-04 02:02:19','2019-03-04 02:02:19','7c60ee68-cad7-4bf3-9fac-a66946163443'),(16,7,9,16,1,2,'2019-03-04 02:02:19','2019-03-04 02:02:19','d54bb868-94d5-4c9c-adea-cd9966387114'),(17,7,9,17,1,3,'2019-03-04 02:02:19','2019-03-04 02:02:19','a9e33e55-97a2-4e70-8141-e7910cb72827'),(18,5,10,4,0,1,'2019-03-04 02:03:03','2019-03-04 02:03:03','c800df53-83fb-4f0b-adf9-5f019063068b'),(19,5,10,9,0,2,'2019-03-04 02:03:03','2019-03-04 02:03:03','45d8f188-a263-4d31-96ab-569f55c45722'),(20,5,10,14,0,3,'2019-03-04 02:03:03','2019-03-04 02:03:03','fc842313-7753-4dac-878c-7bceeaa7ba10'),(21,6,11,10,1,2,'2019-03-04 02:03:12','2019-03-04 02:03:12','8b262c62-6f96-4edf-a2da-0d83e90da67d'),(22,6,11,11,1,3,'2019-03-04 02:03:12','2019-03-04 02:03:12','55dcf664-f00d-43aa-9e93-842328cd63ad'),(23,6,11,12,1,1,'2019-03-04 02:03:12','2019-03-04 02:03:12','9df91400-6969-41d8-9a9f-4ff1be450af3'),(24,6,11,13,0,4,'2019-03-04 02:03:12','2019-03-04 02:03:12','9b68df1f-e6e5-455b-9140-e2e02ab832a7'),(25,8,12,21,0,1,'2019-03-04 02:14:23','2019-03-04 02:14:23','8cb843e3-8740-4ceb-bd7c-373c5209c5da'),(26,9,13,22,0,1,'2019-03-04 02:14:23','2019-03-04 02:14:23','98eb14c8-b14d-4f80-8779-affee78c87ef'),(27,10,14,19,0,2,'2019-03-04 02:15:12','2019-03-04 02:15:12','4c0bdf28-2805-4c76-99e7-c69aac6a958e'),(28,10,14,20,0,3,'2019-03-04 02:15:12','2019-03-04 02:15:12','eb2ea267-8607-4ee6-9754-c5800fb2f275'),(29,10,14,18,0,1,'2019-03-04 02:15:12','2019-03-04 02:15:12','4ff2def2-225d-4430-9f5d-60efb100e949'),(31,1,16,18,0,2,'2019-03-04 02:23:07','2019-03-04 02:23:07','24b9f845-9f57-4465-9a5c-9a7776f6f77a'),(32,1,16,23,0,1,'2019-03-04 02:23:07','2019-03-04 02:23:07','83aae7b6-c10d-41f2-89a0-b54e1a755036');
/*!40000 ALTER TABLE `fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayouts`
--

LOCK TABLES `fieldlayouts` WRITE;
/*!40000 ALTER TABLE `fieldlayouts` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldlayouts` VALUES (1,'craft\\elements\\Entry','2019-03-04 00:15:50','2019-03-04 02:23:07',NULL,'b62ed177-92e2-4a89-80f3-3def95db77d3'),(2,'craft\\elements\\MatrixBlock','2019-03-04 00:18:15','2019-03-04 00:20:03',NULL,'ea5147c7-741c-4db4-843e-330c2da34b8f'),(3,'craft\\elements\\GlobalSet','2019-03-04 00:18:35','2019-03-04 00:18:35',NULL,'4baaac6c-f5c2-4706-a699-da1664b3de7f'),(4,'craft\\elements\\MatrixBlock','2019-03-04 00:26:40','2019-03-04 00:26:40',NULL,'cc06bbf4-546e-444a-8200-14e4b4e371f4'),(5,'craft\\elements\\Entry','2019-03-04 00:26:53','2019-03-04 02:03:03',NULL,'3cd4f888-08ec-4474-9802-826cfb3a84e4'),(6,'craft\\elements\\MatrixBlock','2019-03-04 02:00:09','2019-03-04 02:03:12',NULL,'d850203c-7324-48a1-9e5e-999f8a53ff4e'),(7,'craft\\elements\\MatrixBlock','2019-03-04 02:02:19','2019-03-04 02:02:19',NULL,'508ea40b-9821-477d-928d-887285c47aa6'),(8,'craft\\elements\\MatrixBlock','2019-03-04 02:14:23','2019-03-04 02:14:23',NULL,'08cb7a6e-77da-4e78-9a86-de1985084ff3'),(9,'craft\\elements\\MatrixBlock','2019-03-04 02:14:23','2019-03-04 02:14:23',NULL,'b896da6d-1fc2-4538-963f-f9bc59b79d2a'),(10,'craft\\elements\\Entry','2019-03-04 02:15:12','2019-03-04 02:15:12',NULL,'c5adda62-42b5-49a5-b4da-07ee007aea7f');
/*!40000 ALTER TABLE `fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayouttabs`
--

LOCK TABLES `fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `fieldlayouttabs` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldlayouttabs` VALUES (3,3,'Content',1,'2019-03-04 00:18:35','2019-03-04 00:18:35','9be0a359-a7eb-4f79-9f78-7e578e098985'),(5,2,'Content',1,'2019-03-04 00:20:03','2019-03-04 00:20:03','cba16792-ee2f-4cdb-8476-52c6df4de365'),(6,4,'Content',1,'2019-03-04 00:26:40','2019-03-04 00:26:40','28cdf547-505b-4693-97a2-e91a944bea67'),(9,7,'Content',1,'2019-03-04 02:02:19','2019-03-04 02:02:19','0c7d8fcb-4566-4bc3-b38b-ac716ef1c22d'),(10,5,'Content',1,'2019-03-04 02:03:03','2019-03-04 02:03:03','1e120750-28ba-41dd-822c-dfb73875cc5e'),(11,6,'Content',1,'2019-03-04 02:03:12','2019-03-04 02:03:12','1627cd4b-b201-4606-8621-7f99719cf881'),(12,8,'Content',1,'2019-03-04 02:14:23','2019-03-04 02:14:23','62c156f4-68bf-45bb-a31e-130315fbc2a0'),(13,9,'Content',1,'2019-03-04 02:14:23','2019-03-04 02:14:23','80954f7c-fbc4-4aa3-bcf7-8fece626b308'),(14,10,'Content',1,'2019-03-04 02:15:12','2019-03-04 02:15:12','077564f8-1781-4942-ab10-4ad32b715777'),(16,1,'Content',1,'2019-03-04 02:23:07','2019-03-04 02:23:07','58860fa7-bee2-48ce-a681-2281be9bc682');
/*!40000 ALTER TABLE `fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fields`
--

LOCK TABLES `fields` WRITE;
/*!40000 ALTER TABLE `fields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fields` VALUES (1,1,'Simple Rich Text','simpleRichText','global','',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"cleanupHtml\":\"1\",\"columnType\":\"text\",\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"redactorConfig\":\"Simple.json\"}','2019-03-04 00:15:28','2019-03-04 00:15:28','266a8092-cc85-452c-8e8e-2e888bc9e232'),(2,1,'Link Group','linkGroup','global','',1,'site',NULL,'craft\\fields\\Matrix','{\"contentTable\":\"{{%matrixcontent_linkgroup}}\",\"localizeBlocks\":false,\"maxBlocks\":\"4\",\"minBlocks\":\"\"}','2019-03-04 00:18:09','2019-03-04 00:20:03','cbd605f4-abe7-469d-917a-ed78c2d5b7e4'),(3,NULL,'Link','customLink','matrixBlockType:69ada84e-f4c1-44c9-a1a6-4fd2deed76d2','',1,'none',NULL,'typedlinkfield\\fields\\LinkField','{\"allowCustomText\":\"1\",\"allowTarget\":\"1\",\"allowedLinkNames\":{\"3\":\"entry\",\"6\":\"custom\",\"7\":\"email\",\"8\":\"tel\",\"9\":\"url\"},\"autoNoReferrer\":\"1\",\"defaultLinkName\":\"entry\",\"defaultText\":\"\",\"enableAriaLabel\":\"1\",\"enableTitle\":\"1\",\"typeSettings\":{\"asset\":{\"allowCustomQuery\":\"\",\"sources\":\"*\"},\"category\":{\"allowCustomQuery\":\"\",\"sources\":\"*\"},\"custom\":{\"allowAliases\":\"\",\"disableValidation\":\"\"},\"email\":{\"allowAliases\":\"\",\"disableValidation\":\"\"},\"entry\":{\"allowCustomQuery\":\"\",\"sources\":\"*\"},\"site\":{\"sites\":\"*\"},\"tel\":{\"allowAliases\":\"\",\"disableValidation\":\"\"},\"url\":{\"allowAliases\":\"\",\"disableValidation\":\"\"},\"user\":{\"allowCustomQuery\":\"\",\"sources\":\"*\"}}}','2019-03-04 00:18:15','2019-03-04 00:20:03','2505e7f2-1ec4-4db8-90dc-768148e77b4e'),(4,1,'Slider','slider','global','',1,'site',NULL,'craft\\fields\\Matrix','{\"contentTable\":\"{{%matrixcontent_slider}}\",\"localizeBlocks\":false,\"maxBlocks\":\"5\",\"minBlocks\":\"\"}','2019-03-04 00:26:39','2019-03-04 00:26:39','6bbcbdff-cc50-48e1-88e9-2e1b6f70bba8'),(5,NULL,'Headline','headline','matrixBlockType:84cb23ba-6290-4966-b53a-315df8f70777','',1,'none',NULL,'craft\\fields\\PlainText','{\"charLimit\":\"\",\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2019-03-04 00:26:40','2019-03-04 00:26:40','135f5c25-b095-470a-a9d6-c2c871c3611b'),(6,NULL,'Button','button','matrixBlockType:84cb23ba-6290-4966-b53a-315df8f70777','',1,'none',NULL,'typedlinkfield\\fields\\LinkField','{\"allowCustomText\":\"1\",\"allowTarget\":\"1\",\"allowedLinkNames\":{\"2\":\"category\",\"3\":\"entry\",\"6\":\"custom\",\"7\":\"email\",\"8\":\"tel\",\"9\":\"url\"},\"autoNoReferrer\":\"1\",\"defaultLinkName\":\"entry\",\"defaultText\":\"\",\"enableAriaLabel\":\"1\",\"enableTitle\":\"1\",\"typeSettings\":{\"asset\":{\"allowCustomQuery\":\"\",\"sources\":\"*\"},\"category\":{\"allowCustomQuery\":\"\",\"sources\":\"*\"},\"custom\":{\"allowAliases\":\"\",\"disableValidation\":\"\"},\"email\":{\"allowAliases\":\"\",\"disableValidation\":\"\"},\"entry\":{\"allowCustomQuery\":\"\",\"sources\":\"*\"},\"site\":{\"sites\":\"*\"},\"tel\":{\"allowAliases\":\"\",\"disableValidation\":\"\"},\"url\":{\"allowAliases\":\"\",\"disableValidation\":\"\"},\"user\":{\"allowCustomQuery\":\"\",\"sources\":\"*\"}}}','2019-03-04 00:26:40','2019-03-04 00:26:40','596861f3-2684-45d0-a673-8ad45bf9165d'),(7,NULL,'Text','text','matrixBlockType:84cb23ba-6290-4966-b53a-315df8f70777','',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"cleanupHtml\":\"1\",\"columnType\":\"text\",\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"redactorConfig\":\"Simple.json\"}','2019-03-04 00:26:40','2019-03-04 00:26:40','79743360-da2d-4f5b-8599-fcc7d54cf671'),(8,NULL,'Image','image','matrixBlockType:84cb23ba-6290-4966-b53a-315df8f70777','',1,'site',NULL,'craft\\fields\\Assets','{\"allowedKinds\":[\"image\"],\"defaultUploadLocationSource\":\"volume:18580cf9-0fba-4a6f-8934-e1776f0e2149\",\"defaultUploadLocationSubpath\":\"\",\"limit\":\"1\",\"localizeRelations\":false,\"restrictFiles\":\"1\",\"selectionLabel\":\"\",\"singleUploadLocationSource\":\"volume:18580cf9-0fba-4a6f-8934-e1776f0e2149\",\"singleUploadLocationSubpath\":\"\",\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"useSingleFolder\":\"\",\"viewMode\":\"list\"}','2019-03-04 00:26:40','2019-03-04 00:26:40','e33a7ff1-5f5e-4c16-9e5c-e427ddaafa9b'),(9,1,'Image Callout Set','imageCalloutSet','global','',1,'site',NULL,'craft\\fields\\Matrix','{\"contentTable\":\"{{%matrixcontent_imagecalloutset}}\",\"localizeBlocks\":false,\"maxBlocks\":\"3\",\"minBlocks\":\"\"}','2019-03-04 02:00:09','2019-03-04 02:03:12','a8def9a5-bab5-4f06-b1b9-1cba7fded966'),(10,NULL,'Headline','headline','matrixBlockType:0022f946-12f9-4f59-a183-9037a17bff7f','',1,'none',NULL,'craft\\fields\\PlainText','{\"charLimit\":\"\",\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2019-03-04 02:00:09','2019-03-04 02:03:12','31fc5dbe-60e6-40ae-abe2-107dcc2059d1'),(11,NULL,'Text','text','matrixBlockType:0022f946-12f9-4f59-a183-9037a17bff7f','',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"cleanupHtml\":\"1\",\"columnType\":\"text\",\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"redactorConfig\":\"Simple.json\"}','2019-03-04 02:00:09','2019-03-04 02:03:12','4a03b61b-831e-43d3-b854-6febf9ca054e'),(12,NULL,'Image','image','matrixBlockType:0022f946-12f9-4f59-a183-9037a17bff7f','',1,'site',NULL,'craft\\fields\\Assets','{\"allowedKinds\":[\"image\"],\"defaultUploadLocationSource\":\"volume:18580cf9-0fba-4a6f-8934-e1776f0e2149\",\"defaultUploadLocationSubpath\":\"\",\"limit\":\"1\",\"localizeRelations\":false,\"restrictFiles\":\"1\",\"selectionLabel\":\"\",\"singleUploadLocationSource\":\"volume:18580cf9-0fba-4a6f-8934-e1776f0e2149\",\"singleUploadLocationSubpath\":\"\",\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"useSingleFolder\":\"\",\"viewMode\":\"list\"}','2019-03-04 02:00:09','2019-03-04 02:03:12','636651e0-1d88-45c8-8c3f-2da7f9684e73'),(13,NULL,'Button','button','matrixBlockType:0022f946-12f9-4f59-a183-9037a17bff7f','',1,'none',NULL,'typedlinkfield\\fields\\LinkField','{\"allowCustomText\":\"1\",\"allowTarget\":\"1\",\"allowedLinkNames\":{\"3\":\"entry\",\"6\":\"custom\",\"7\":\"email\",\"8\":\"tel\",\"9\":\"url\"},\"autoNoReferrer\":\"1\",\"defaultLinkName\":\"entry\",\"defaultText\":\"\",\"enableAriaLabel\":\"1\",\"enableTitle\":\"1\",\"typeSettings\":{\"asset\":{\"allowCustomQuery\":\"\",\"sources\":\"*\"},\"category\":{\"allowCustomQuery\":\"\",\"sources\":\"*\"},\"custom\":{\"allowAliases\":\"\",\"disableValidation\":\"\"},\"email\":{\"allowAliases\":\"\",\"disableValidation\":\"\"},\"entry\":{\"allowCustomQuery\":\"\",\"sources\":\"*\"},\"site\":{\"sites\":\"*\"},\"tel\":{\"allowAliases\":\"\",\"disableValidation\":\"\"},\"url\":{\"allowAliases\":\"\",\"disableValidation\":\"\"},\"user\":{\"allowCustomQuery\":\"\",\"sources\":\"*\"}}}','2019-03-04 02:00:09','2019-03-04 02:03:12','c2f32189-d7a9-41ec-8282-3c9779a9f825'),(14,1,'Two Column Callout','twoColumnCallout','global','',1,'site',NULL,'craft\\fields\\Matrix','{\"contentTable\":\"{{%matrixcontent_twocolumncallout}}\",\"localizeBlocks\":false,\"maxBlocks\":\"1\",\"minBlocks\":\"\"}','2019-03-04 02:02:19','2019-03-04 02:02:19','c7d0c722-9e8d-41e2-9479-86cf3dee1e5a'),(15,NULL,'Headline','headline','matrixBlockType:159a0002-8036-46f0-b841-fff97712822f','',1,'none',NULL,'craft\\fields\\PlainText','{\"charLimit\":\"\",\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2019-03-04 02:02:19','2019-03-04 02:02:19','19cf6c69-f424-41c7-aeb6-e96b7c861345'),(16,NULL,'Text','text','matrixBlockType:159a0002-8036-46f0-b841-fff97712822f','',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"cleanupHtml\":\"1\",\"columnType\":\"text\",\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"redactorConfig\":\"Simple.json\"}','2019-03-04 02:02:19','2019-03-04 02:02:19','612a527c-7d76-481e-a46e-6cef9469aa81'),(17,NULL,'Image','image','matrixBlockType:159a0002-8036-46f0-b841-fff97712822f','',1,'site',NULL,'craft\\fields\\Assets','{\"allowedKinds\":[\"image\"],\"defaultUploadLocationSource\":\"volume:18580cf9-0fba-4a6f-8934-e1776f0e2149\",\"defaultUploadLocationSubpath\":\"\",\"limit\":\"1\",\"localizeRelations\":false,\"restrictFiles\":\"1\",\"selectionLabel\":\"\",\"singleUploadLocationSource\":\"volume:18580cf9-0fba-4a6f-8934-e1776f0e2149\",\"singleUploadLocationSubpath\":\"\",\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"useSingleFolder\":\"\",\"viewMode\":\"list\"}','2019-03-04 02:02:19','2019-03-04 02:02:19','d689d51a-bdc8-40a6-8a54-68d4125e5990'),(18,1,'Description','description','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"charLimit\":\"\",\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2019-03-04 02:12:54','2019-03-04 02:12:54','33f55018-e2e1-4828-8f35-5759a8024682'),(19,1,'Preview Image','previewImage','global','',1,'site',NULL,'craft\\fields\\Assets','{\"allowedKinds\":[\"image\"],\"defaultUploadLocationSource\":\"volume:18580cf9-0fba-4a6f-8934-e1776f0e2149\",\"defaultUploadLocationSubpath\":\"\",\"limit\":\"1\",\"localizeRelations\":false,\"restrictFiles\":\"1\",\"selectionLabel\":\"\",\"singleUploadLocationSource\":\"volume:18580cf9-0fba-4a6f-8934-e1776f0e2149\",\"singleUploadLocationSubpath\":\"\",\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"useSingleFolder\":\"\",\"viewMode\":\"list\"}','2019-03-04 02:13:25','2019-03-04 02:13:25','05fcdbb5-3a3f-4855-bf1d-3bfb1d0b0d98'),(20,1,'Content Blocks','contentBlocks','global','',1,'site',NULL,'craft\\fields\\Matrix','{\"contentTable\":\"{{%matrixcontent_contentblocks}}\",\"localizeBlocks\":false,\"maxBlocks\":\"\",\"minBlocks\":\"\"}','2019-03-04 02:14:23','2019-03-04 02:14:23','33a8e7bf-3aa8-4eba-8336-2b9d47e27b0e'),(21,NULL,'Image','image','matrixBlockType:4ff91211-3e0d-4acf-8752-56a6f0ddf556','',1,'site',NULL,'craft\\fields\\Assets','{\"allowedKinds\":[\"image\"],\"defaultUploadLocationSource\":\"volume:18580cf9-0fba-4a6f-8934-e1776f0e2149\",\"defaultUploadLocationSubpath\":\"\",\"limit\":\"1\",\"localizeRelations\":false,\"restrictFiles\":\"1\",\"selectionLabel\":\"\",\"singleUploadLocationSource\":\"volume:18580cf9-0fba-4a6f-8934-e1776f0e2149\",\"singleUploadLocationSubpath\":\"\",\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"useSingleFolder\":\"\",\"viewMode\":\"list\"}','2019-03-04 02:14:23','2019-03-04 02:14:23','d385991f-c2a0-4613-ad4a-9f4eaea890e2'),(22,NULL,'Text','text','matrixBlockType:2642b72f-fbc0-4f9b-aa23-80fcf5a1c002','',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"cleanupHtml\":\"1\",\"columnType\":\"text\",\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"redactorConfig\":\"Standard.json\"}','2019-03-04 02:14:23','2019-03-04 02:14:23','8e8a7caf-d04a-483c-94ff-52cbc4ef1f8e'),(23,1,'Headline','headline','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"charLimit\":\"\",\"code\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2019-03-04 02:22:58','2019-03-04 02:22:58','b9cf4261-00f8-4234-96da-a22e85cd8551');
/*!40000 ALTER TABLE `fields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `globalsets`
--

LOCK TABLES `globalsets` WRITE;
/*!40000 ALTER TABLE `globalsets` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `globalsets` VALUES (5,'Navigation','navigation',3,'2019-03-04 00:16:26','2019-03-04 00:18:35','fb2bd663-bc5f-4eda-9b36-6212afcb3356');
/*!40000 ALTER TABLE `globalsets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `info`
--

LOCK TABLES `info` WRITE;
/*!40000 ALTER TABLE `info` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `info` VALUES (1,'3.1.15','3.1.25',0,'a:13:{s:12:\"dateModified\";i:1551666187;s:5:\"email\";a:3:{s:9:\"fromEmail\";s:21:\"levi@mostlyserious.io\";s:8:\"fromName\";s:10:\"Craft Demo\";s:13:\"transportType\";s:37:\"craft\\mail\\transportadapters\\Sendmail\";}s:11:\"fieldGroups\";a:1:{s:36:\"861b809b-0e21-4836-938c-cd47b81bcff9\";a:1:{s:4:\"name\";s:6:\"Common\";}}s:7:\"plugins\";a:2:{s:14:\"typedlinkfield\";a:3:{s:7:\"edition\";s:8:\"standard\";s:7:\"enabled\";b:1;s:13:\"schemaVersion\";s:5:\"1.0.0\";}s:8:\"redactor\";a:3:{s:7:\"edition\";s:8:\"standard\";s:7:\"enabled\";b:1;s:13:\"schemaVersion\";s:5:\"2.2.2\";}}s:8:\"sections\";a:3:{s:36:\"55337af1-2367-47fe-8e26-422065e7bd6c\";a:7:{s:16:\"enableVersioning\";b:1;s:10:\"entryTypes\";a:1:{s:36:\"cee82091-e714-4340-9fe1-f1b26f579478\";a:7:{s:12:\"fieldLayouts\";a:1:{s:36:\"3cd4f888-08ec-4474-9802-826cfb3a84e4\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:6:\"fields\";a:3:{s:36:\"6bbcbdff-cc50-48e1-88e9-2e1b6f70bba8\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:1;}s:36:\"a8def9a5-bab5-4f06-b1b9-1cba7fded966\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:2;}s:36:\"c7d0c722-9e8d-41e2-9479-86cf3dee1e5a\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:3;}}s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";i:1;}}}}s:6:\"handle\";s:8:\"homePage\";s:13:\"hasTitleField\";b:0;s:4:\"name\";s:9:\"Home Page\";s:9:\"sortOrder\";i:1;s:11:\"titleFormat\";s:18:\"{section.name|raw}\";s:10:\"titleLabel\";s:0:\"\";}}s:6:\"handle\";s:8:\"homePage\";s:4:\"name\";s:9:\"Home Page\";s:16:\"propagateEntries\";b:1;s:12:\"siteSettings\";a:1:{s:36:\"97f47ded-c397-4935-a907-f1e28344839c\";a:4:{s:16:\"enabledByDefault\";b:1;s:7:\"hasUrls\";b:1;s:8:\"template\";s:10:\"pages/home\";s:9:\"uriFormat\";s:8:\"__home__\";}}s:4:\"type\";s:6:\"single\";}s:36:\"79e07047-bb12-4550-b070-89b39c20d824\";a:7:{s:16:\"enableVersioning\";b:1;s:10:\"entryTypes\";a:1:{s:36:\"59d2aaaf-4cad-4a67-81f8-fcefc29b4c9d\";a:7:{s:12:\"fieldLayouts\";a:1:{s:36:\"b62ed177-92e2-4a89-80f3-3def95db77d3\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:6:\"fields\";a:2:{s:36:\"33f55018-e2e1-4828-8f35-5759a8024682\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:2;}s:36:\"b9cf4261-00f8-4234-96da-a22e85cd8551\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:1;}}s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";i:1;}}}}s:6:\"handle\";s:11:\"blogListing\";s:13:\"hasTitleField\";b:1;s:4:\"name\";s:12:\"Blog Listing\";s:9:\"sortOrder\";i:1;s:11:\"titleFormat\";s:0:\"\";s:10:\"titleLabel\";s:5:\"Title\";}}s:6:\"handle\";s:11:\"blogListing\";s:4:\"name\";s:12:\"Blog Listing\";s:16:\"propagateEntries\";b:1;s:12:\"siteSettings\";a:1:{s:36:\"97f47ded-c397-4935-a907-f1e28344839c\";a:4:{s:16:\"enabledByDefault\";b:1;s:7:\"hasUrls\";b:1;s:8:\"template\";s:17:\"pages/blogListing\";s:9:\"uriFormat\";s:4:\"blog\";}}s:4:\"type\";s:6:\"single\";}s:36:\"9fe861ca-2dad-41bb-a592-ff24cdadeb26\";a:7:{s:16:\"enableVersioning\";b:1;s:6:\"handle\";s:9:\"blogPosts\";s:4:\"name\";s:10:\"Blog Posts\";s:16:\"propagateEntries\";b:1;s:12:\"siteSettings\";a:1:{s:36:\"97f47ded-c397-4935-a907-f1e28344839c\";a:4:{s:16:\"enabledByDefault\";b:1;s:7:\"hasUrls\";b:1;s:8:\"template\";s:16:\"pages/blogDetail\";s:9:\"uriFormat\";s:11:\"blog/{slug}\";}}s:4:\"type\";s:7:\"channel\";s:10:\"entryTypes\";a:1:{s:36:\"7179579e-07b0-4850-93b4-4f7d5c521ec4\";a:7:{s:12:\"fieldLayouts\";a:1:{s:36:\"c5adda62-42b5-49a5-b4da-07ee007aea7f\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:6:\"fields\";a:3:{s:36:\"05fcdbb5-3a3f-4855-bf1d-3bfb1d0b0d98\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:2;}s:36:\"33a8e7bf-3aa8-4eba-8336-2b9d47e27b0e\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:3;}s:36:\"33f55018-e2e1-4828-8f35-5759a8024682\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:1;}}s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";i:1;}}}}s:6:\"handle\";s:9:\"blogPosts\";s:13:\"hasTitleField\";b:1;s:4:\"name\";s:10:\"Blog Posts\";s:9:\"sortOrder\";i:1;s:11:\"titleFormat\";s:0:\"\";s:10:\"titleLabel\";s:5:\"Title\";}}}}s:10:\"siteGroups\";a:1:{s:36:\"0c2edc31-fb81-4c3c-84b8-7e73a1a778f7\";a:1:{s:4:\"name\";s:10:\"Craft Demo\";}}s:5:\"sites\";a:1:{s:36:\"97f47ded-c397-4935-a907-f1e28344839c\";a:8:{s:7:\"baseUrl\";s:4:\"@web\";s:6:\"handle\";s:7:\"default\";s:7:\"hasUrls\";b:1;s:8:\"language\";s:5:\"en-US\";s:4:\"name\";s:10:\"Craft Demo\";s:7:\"primary\";b:1;s:9:\"siteGroup\";s:36:\"0c2edc31-fb81-4c3c-84b8-7e73a1a778f7\";s:9:\"sortOrder\";i:1;}}s:6:\"system\";a:5:{s:7:\"edition\";s:4:\"solo\";s:4:\"live\";b:1;s:4:\"name\";s:10:\"Craft Demo\";s:13:\"schemaVersion\";s:6:\"3.1.25\";s:8:\"timeZone\";s:19:\"America/Los_Angeles\";}s:5:\"users\";a:5:{s:23:\"allowPublicRegistration\";b:0;s:12:\"defaultGroup\";N;s:12:\"photoSubpath\";s:0:\"\";s:14:\"photoVolumeUid\";N;s:24:\"requireEmailVerification\";b:1;}s:7:\"volumes\";a:1:{s:36:\"18580cf9-0fba-4a6f-8934-e1776f0e2149\";a:7:{s:6:\"handle\";s:6:\"public\";s:7:\"hasUrls\";b:1;s:4:\"name\";s:6:\"Public\";s:8:\"settings\";a:1:{s:4:\"path\";s:16:\"@root/web/assets\";}s:9:\"sortOrder\";s:1:\"1\";s:4:\"type\";s:19:\"craft\\volumes\\Local\";s:3:\"url\";s:11:\"@web/assets\";}}s:6:\"fields\";a:9:{s:36:\"266a8092-cc85-452c-8e8e-2e888bc9e232\";a:10:{s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";s:36:\"861b809b-0e21-4836-938c-cd47b81bcff9\";s:6:\"handle\";s:14:\"simpleRichText\";s:12:\"instructions\";s:0:\"\";s:4:\"name\";s:16:\"Simple Rich Text\";s:10:\"searchable\";b:1;s:8:\"settings\";a:7:{s:19:\"availableTransforms\";s:1:\"*\";s:16:\"availableVolumes\";s:1:\"*\";s:11:\"cleanupHtml\";s:1:\"1\";s:10:\"columnType\";s:4:\"text\";s:14:\"purifierConfig\";s:0:\"\";s:10:\"purifyHtml\";s:1:\"1\";s:14:\"redactorConfig\";s:11:\"Simple.json\";}s:20:\"translationKeyFormat\";N;s:17:\"translationMethod\";s:4:\"none\";s:4:\"type\";s:20:\"craft\\redactor\\Field\";}s:36:\"cbd605f4-abe7-469d-917a-ed78c2d5b7e4\";a:10:{s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";s:36:\"861b809b-0e21-4836-938c-cd47b81bcff9\";s:6:\"handle\";s:9:\"linkGroup\";s:12:\"instructions\";s:0:\"\";s:4:\"name\";s:10:\"Link Group\";s:10:\"searchable\";b:1;s:8:\"settings\";a:4:{s:12:\"contentTable\";s:28:\"{{%matrixcontent_linkgroup}}\";s:14:\"localizeBlocks\";b:0;s:9:\"maxBlocks\";s:1:\"4\";s:9:\"minBlocks\";s:0:\"\";}s:20:\"translationKeyFormat\";N;s:17:\"translationMethod\";s:4:\"site\";s:4:\"type\";s:19:\"craft\\fields\\Matrix\";}s:36:\"6bbcbdff-cc50-48e1-88e9-2e1b6f70bba8\";a:10:{s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";s:36:\"861b809b-0e21-4836-938c-cd47b81bcff9\";s:6:\"handle\";s:6:\"slider\";s:12:\"instructions\";s:0:\"\";s:4:\"name\";s:6:\"Slider\";s:10:\"searchable\";b:1;s:8:\"settings\";a:4:{s:12:\"contentTable\";s:25:\"{{%matrixcontent_slider}}\";s:14:\"localizeBlocks\";b:0;s:9:\"maxBlocks\";s:1:\"5\";s:9:\"minBlocks\";s:0:\"\";}s:20:\"translationKeyFormat\";N;s:17:\"translationMethod\";s:4:\"site\";s:4:\"type\";s:19:\"craft\\fields\\Matrix\";}s:36:\"a8def9a5-bab5-4f06-b1b9-1cba7fded966\";a:10:{s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";s:36:\"861b809b-0e21-4836-938c-cd47b81bcff9\";s:6:\"handle\";s:15:\"imageCalloutSet\";s:12:\"instructions\";s:0:\"\";s:4:\"name\";s:17:\"Image Callout Set\";s:10:\"searchable\";b:1;s:8:\"settings\";a:4:{s:12:\"contentTable\";s:34:\"{{%matrixcontent_imagecalloutset}}\";s:14:\"localizeBlocks\";b:0;s:9:\"maxBlocks\";s:1:\"3\";s:9:\"minBlocks\";s:0:\"\";}s:20:\"translationKeyFormat\";N;s:17:\"translationMethod\";s:4:\"site\";s:4:\"type\";s:19:\"craft\\fields\\Matrix\";}s:36:\"c7d0c722-9e8d-41e2-9479-86cf3dee1e5a\";a:10:{s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";s:36:\"861b809b-0e21-4836-938c-cd47b81bcff9\";s:6:\"handle\";s:16:\"twoColumnCallout\";s:12:\"instructions\";s:0:\"\";s:4:\"name\";s:18:\"Two Column Callout\";s:10:\"searchable\";b:1;s:8:\"settings\";a:4:{s:12:\"contentTable\";s:35:\"{{%matrixcontent_twocolumncallout}}\";s:14:\"localizeBlocks\";b:0;s:9:\"maxBlocks\";s:1:\"1\";s:9:\"minBlocks\";s:0:\"\";}s:20:\"translationKeyFormat\";N;s:17:\"translationMethod\";s:4:\"site\";s:4:\"type\";s:19:\"craft\\fields\\Matrix\";}s:36:\"33f55018-e2e1-4828-8f35-5759a8024682\";a:10:{s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";s:36:\"861b809b-0e21-4836-938c-cd47b81bcff9\";s:6:\"handle\";s:11:\"description\";s:12:\"instructions\";s:0:\"\";s:4:\"name\";s:11:\"Description\";s:10:\"searchable\";b:1;s:8:\"settings\";a:6:{s:9:\"charLimit\";s:0:\"\";s:4:\"code\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";s:11:\"initialRows\";s:1:\"4\";s:9:\"multiline\";s:0:\"\";s:11:\"placeholder\";s:0:\"\";}s:20:\"translationKeyFormat\";N;s:17:\"translationMethod\";s:4:\"none\";s:4:\"type\";s:22:\"craft\\fields\\PlainText\";}s:36:\"05fcdbb5-3a3f-4855-bf1d-3bfb1d0b0d98\";a:10:{s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";s:36:\"861b809b-0e21-4836-938c-cd47b81bcff9\";s:6:\"handle\";s:12:\"previewImage\";s:12:\"instructions\";s:0:\"\";s:4:\"name\";s:13:\"Preview Image\";s:10:\"searchable\";b:1;s:8:\"settings\";a:14:{s:12:\"allowedKinds\";a:1:{i:0;s:5:\"image\";}s:27:\"defaultUploadLocationSource\";s:43:\"volume:18580cf9-0fba-4a6f-8934-e1776f0e2149\";s:28:\"defaultUploadLocationSubpath\";s:0:\"\";s:5:\"limit\";s:1:\"1\";s:17:\"localizeRelations\";b:0;s:13:\"restrictFiles\";s:1:\"1\";s:14:\"selectionLabel\";s:0:\"\";s:26:\"singleUploadLocationSource\";s:43:\"volume:18580cf9-0fba-4a6f-8934-e1776f0e2149\";s:27:\"singleUploadLocationSubpath\";s:0:\"\";s:6:\"source\";N;s:7:\"sources\";s:1:\"*\";s:12:\"targetSiteId\";N;s:15:\"useSingleFolder\";s:0:\"\";s:8:\"viewMode\";s:4:\"list\";}s:20:\"translationKeyFormat\";N;s:17:\"translationMethod\";s:4:\"site\";s:4:\"type\";s:19:\"craft\\fields\\Assets\";}s:36:\"33a8e7bf-3aa8-4eba-8336-2b9d47e27b0e\";a:10:{s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";s:36:\"861b809b-0e21-4836-938c-cd47b81bcff9\";s:6:\"handle\";s:13:\"contentBlocks\";s:12:\"instructions\";s:0:\"\";s:4:\"name\";s:14:\"Content Blocks\";s:10:\"searchable\";b:1;s:8:\"settings\";a:4:{s:12:\"contentTable\";s:32:\"{{%matrixcontent_contentblocks}}\";s:14:\"localizeBlocks\";b:0;s:9:\"maxBlocks\";s:0:\"\";s:9:\"minBlocks\";s:0:\"\";}s:20:\"translationKeyFormat\";N;s:17:\"translationMethod\";s:4:\"site\";s:4:\"type\";s:19:\"craft\\fields\\Matrix\";}s:36:\"b9cf4261-00f8-4234-96da-a22e85cd8551\";a:10:{s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";s:36:\"861b809b-0e21-4836-938c-cd47b81bcff9\";s:6:\"handle\";s:8:\"headline\";s:12:\"instructions\";s:0:\"\";s:4:\"name\";s:8:\"Headline\";s:10:\"searchable\";b:1;s:8:\"settings\";a:6:{s:9:\"charLimit\";s:0:\"\";s:4:\"code\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";s:11:\"initialRows\";s:1:\"4\";s:9:\"multiline\";s:0:\"\";s:11:\"placeholder\";s:0:\"\";}s:20:\"translationKeyFormat\";N;s:17:\"translationMethod\";s:4:\"none\";s:4:\"type\";s:22:\"craft\\fields\\PlainText\";}}s:10:\"globalSets\";a:1:{s:36:\"fb2bd663-bc5f-4eda-9b36-6212afcb3356\";a:3:{s:12:\"fieldLayouts\";a:1:{s:36:\"4baaac6c-f5c2-4706-a699-da1664b3de7f\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:6:\"fields\";a:1:{s:36:\"cbd605f4-abe7-469d-917a-ed78c2d5b7e4\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:1;}}s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";i:1;}}}}s:6:\"handle\";s:10:\"navigation\";s:4:\"name\";s:10:\"Navigation\";}}s:16:\"matrixBlockTypes\";a:6:{s:36:\"69ada84e-f4c1-44c9-a1a6-4fd2deed76d2\";a:6:{s:5:\"field\";s:36:\"cbd605f4-abe7-469d-917a-ed78c2d5b7e4\";s:12:\"fieldLayouts\";a:1:{s:36:\"ea5147c7-741c-4db4-843e-330c2da34b8f\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:6:\"fields\";a:1:{s:36:\"2505e7f2-1ec4-4db8-90dc-768148e77b4e\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:1;}}s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";i:1;}}}}s:6:\"fields\";a:1:{s:36:\"2505e7f2-1ec4-4db8-90dc-768148e77b4e\";a:10:{s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";N;s:6:\"handle\";s:10:\"customLink\";s:12:\"instructions\";s:0:\"\";s:4:\"name\";s:4:\"Link\";s:10:\"searchable\";b:1;s:8:\"settings\";a:9:{s:15:\"allowCustomText\";s:1:\"1\";s:11:\"allowTarget\";s:1:\"1\";s:16:\"allowedLinkNames\";a:5:{i:3;s:5:\"entry\";i:6;s:6:\"custom\";i:7;s:5:\"email\";i:8;s:3:\"tel\";i:9;s:3:\"url\";}s:14:\"autoNoReferrer\";s:1:\"1\";s:15:\"defaultLinkName\";s:5:\"entry\";s:11:\"defaultText\";s:0:\"\";s:15:\"enableAriaLabel\";s:1:\"1\";s:11:\"enableTitle\";s:1:\"1\";s:12:\"typeSettings\";a:9:{s:5:\"asset\";a:2:{s:16:\"allowCustomQuery\";s:0:\"\";s:7:\"sources\";s:1:\"*\";}s:8:\"category\";a:2:{s:16:\"allowCustomQuery\";s:0:\"\";s:7:\"sources\";s:1:\"*\";}s:6:\"custom\";a:2:{s:12:\"allowAliases\";s:0:\"\";s:17:\"disableValidation\";s:0:\"\";}s:5:\"email\";a:2:{s:12:\"allowAliases\";s:0:\"\";s:17:\"disableValidation\";s:0:\"\";}s:5:\"entry\";a:2:{s:16:\"allowCustomQuery\";s:0:\"\";s:7:\"sources\";s:1:\"*\";}s:4:\"site\";a:1:{s:5:\"sites\";s:1:\"*\";}s:3:\"tel\";a:2:{s:12:\"allowAliases\";s:0:\"\";s:17:\"disableValidation\";s:0:\"\";}s:3:\"url\";a:2:{s:12:\"allowAliases\";s:0:\"\";s:17:\"disableValidation\";s:0:\"\";}s:4:\"user\";a:2:{s:16:\"allowCustomQuery\";s:0:\"\";s:7:\"sources\";s:1:\"*\";}}}s:20:\"translationKeyFormat\";N;s:17:\"translationMethod\";s:4:\"none\";s:4:\"type\";s:31:\"typedlinkfield\\fields\\LinkField\";}}s:6:\"handle\";s:8:\"linkItem\";s:4:\"name\";s:9:\"Link Item\";s:9:\"sortOrder\";i:1;}s:36:\"84cb23ba-6290-4966-b53a-315df8f70777\";a:6:{s:5:\"field\";s:36:\"6bbcbdff-cc50-48e1-88e9-2e1b6f70bba8\";s:12:\"fieldLayouts\";a:1:{s:36:\"cc06bbf4-546e-444a-8200-14e4b4e371f4\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:6:\"fields\";a:4:{s:36:\"135f5c25-b095-470a-a9d6-c2c871c3611b\";a:2:{s:8:\"required\";b:1;s:9:\"sortOrder\";i:2;}s:36:\"596861f3-2684-45d0-a673-8ad45bf9165d\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:4;}s:36:\"79743360-da2d-4f5b-8599-fcc7d54cf671\";a:2:{s:8:\"required\";b:1;s:9:\"sortOrder\";i:3;}s:36:\"e33a7ff1-5f5e-4c16-9e5c-e427ddaafa9b\";a:2:{s:8:\"required\";b:1;s:9:\"sortOrder\";i:1;}}s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";i:1;}}}}s:6:\"fields\";a:4:{s:36:\"135f5c25-b095-470a-a9d6-c2c871c3611b\";a:10:{s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";N;s:6:\"handle\";s:8:\"headline\";s:12:\"instructions\";s:0:\"\";s:4:\"name\";s:8:\"Headline\";s:10:\"searchable\";b:1;s:8:\"settings\";a:6:{s:9:\"charLimit\";s:0:\"\";s:4:\"code\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";s:11:\"initialRows\";s:1:\"4\";s:9:\"multiline\";s:0:\"\";s:11:\"placeholder\";s:0:\"\";}s:20:\"translationKeyFormat\";N;s:17:\"translationMethod\";s:4:\"none\";s:4:\"type\";s:22:\"craft\\fields\\PlainText\";}s:36:\"596861f3-2684-45d0-a673-8ad45bf9165d\";a:10:{s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";N;s:6:\"handle\";s:6:\"button\";s:12:\"instructions\";s:0:\"\";s:4:\"name\";s:6:\"Button\";s:10:\"searchable\";b:1;s:8:\"settings\";a:9:{s:15:\"allowCustomText\";s:1:\"1\";s:11:\"allowTarget\";s:1:\"1\";s:16:\"allowedLinkNames\";a:6:{i:2;s:8:\"category\";i:3;s:5:\"entry\";i:6;s:6:\"custom\";i:7;s:5:\"email\";i:8;s:3:\"tel\";i:9;s:3:\"url\";}s:14:\"autoNoReferrer\";s:1:\"1\";s:15:\"defaultLinkName\";s:5:\"entry\";s:11:\"defaultText\";s:0:\"\";s:15:\"enableAriaLabel\";s:1:\"1\";s:11:\"enableTitle\";s:1:\"1\";s:12:\"typeSettings\";a:9:{s:5:\"asset\";a:2:{s:16:\"allowCustomQuery\";s:0:\"\";s:7:\"sources\";s:1:\"*\";}s:8:\"category\";a:2:{s:16:\"allowCustomQuery\";s:0:\"\";s:7:\"sources\";s:1:\"*\";}s:6:\"custom\";a:2:{s:12:\"allowAliases\";s:0:\"\";s:17:\"disableValidation\";s:0:\"\";}s:5:\"email\";a:2:{s:12:\"allowAliases\";s:0:\"\";s:17:\"disableValidation\";s:0:\"\";}s:5:\"entry\";a:2:{s:16:\"allowCustomQuery\";s:0:\"\";s:7:\"sources\";s:1:\"*\";}s:4:\"site\";a:1:{s:5:\"sites\";s:1:\"*\";}s:3:\"tel\";a:2:{s:12:\"allowAliases\";s:0:\"\";s:17:\"disableValidation\";s:0:\"\";}s:3:\"url\";a:2:{s:12:\"allowAliases\";s:0:\"\";s:17:\"disableValidation\";s:0:\"\";}s:4:\"user\";a:2:{s:16:\"allowCustomQuery\";s:0:\"\";s:7:\"sources\";s:1:\"*\";}}}s:20:\"translationKeyFormat\";N;s:17:\"translationMethod\";s:4:\"none\";s:4:\"type\";s:31:\"typedlinkfield\\fields\\LinkField\";}s:36:\"79743360-da2d-4f5b-8599-fcc7d54cf671\";a:10:{s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";N;s:6:\"handle\";s:4:\"text\";s:12:\"instructions\";s:0:\"\";s:4:\"name\";s:4:\"Text\";s:10:\"searchable\";b:1;s:8:\"settings\";a:7:{s:19:\"availableTransforms\";s:1:\"*\";s:16:\"availableVolumes\";s:1:\"*\";s:11:\"cleanupHtml\";s:1:\"1\";s:10:\"columnType\";s:4:\"text\";s:14:\"purifierConfig\";s:0:\"\";s:10:\"purifyHtml\";s:1:\"1\";s:14:\"redactorConfig\";s:11:\"Simple.json\";}s:20:\"translationKeyFormat\";N;s:17:\"translationMethod\";s:4:\"none\";s:4:\"type\";s:20:\"craft\\redactor\\Field\";}s:36:\"e33a7ff1-5f5e-4c16-9e5c-e427ddaafa9b\";a:10:{s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;s:6:\"handle\";s:5:\"image\";s:12:\"instructions\";s:0:\"\";s:4:\"name\";s:5:\"Image\";s:10:\"searchable\";b:1;s:8:\"settings\";a:14:{s:12:\"allowedKinds\";a:1:{i:0;s:5:\"image\";}s:27:\"defaultUploadLocationSource\";s:43:\"volume:18580cf9-0fba-4a6f-8934-e1776f0e2149\";s:28:\"defaultUploadLocationSubpath\";s:0:\"\";s:5:\"limit\";s:1:\"1\";s:17:\"localizeRelations\";b:0;s:13:\"restrictFiles\";s:1:\"1\";s:14:\"selectionLabel\";s:0:\"\";s:26:\"singleUploadLocationSource\";s:43:\"volume:18580cf9-0fba-4a6f-8934-e1776f0e2149\";s:27:\"singleUploadLocationSubpath\";s:0:\"\";s:6:\"source\";N;s:7:\"sources\";s:1:\"*\";s:12:\"targetSiteId\";N;s:15:\"useSingleFolder\";s:0:\"\";s:8:\"viewMode\";s:4:\"list\";}s:20:\"translationKeyFormat\";N;s:17:\"translationMethod\";s:4:\"site\";s:4:\"type\";s:19:\"craft\\fields\\Assets\";}}s:6:\"handle\";s:5:\"slide\";s:4:\"name\";s:5:\"Slide\";s:9:\"sortOrder\";i:1;}s:36:\"0022f946-12f9-4f59-a183-9037a17bff7f\";a:6:{s:5:\"field\";s:36:\"a8def9a5-bab5-4f06-b1b9-1cba7fded966\";s:12:\"fieldLayouts\";a:1:{s:36:\"d850203c-7324-48a1-9e5e-999f8a53ff4e\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:6:\"fields\";a:4:{s:36:\"31fc5dbe-60e6-40ae-abe2-107dcc2059d1\";a:2:{s:8:\"required\";b:1;s:9:\"sortOrder\";i:2;}s:36:\"4a03b61b-831e-43d3-b854-6febf9ca054e\";a:2:{s:8:\"required\";b:1;s:9:\"sortOrder\";i:3;}s:36:\"636651e0-1d88-45c8-8c3f-2da7f9684e73\";a:2:{s:8:\"required\";b:1;s:9:\"sortOrder\";i:1;}s:36:\"c2f32189-d7a9-41ec-8282-3c9779a9f825\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:4;}}s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";i:1;}}}}s:6:\"fields\";a:4:{s:36:\"31fc5dbe-60e6-40ae-abe2-107dcc2059d1\";a:10:{s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";N;s:6:\"handle\";s:8:\"headline\";s:12:\"instructions\";s:0:\"\";s:4:\"name\";s:8:\"Headline\";s:10:\"searchable\";b:1;s:8:\"settings\";a:6:{s:9:\"charLimit\";s:0:\"\";s:4:\"code\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";s:11:\"initialRows\";s:1:\"4\";s:9:\"multiline\";s:0:\"\";s:11:\"placeholder\";s:0:\"\";}s:20:\"translationKeyFormat\";N;s:17:\"translationMethod\";s:4:\"none\";s:4:\"type\";s:22:\"craft\\fields\\PlainText\";}s:36:\"4a03b61b-831e-43d3-b854-6febf9ca054e\";a:10:{s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";N;s:6:\"handle\";s:4:\"text\";s:12:\"instructions\";s:0:\"\";s:4:\"name\";s:4:\"Text\";s:10:\"searchable\";b:1;s:8:\"settings\";a:7:{s:19:\"availableTransforms\";s:1:\"*\";s:16:\"availableVolumes\";s:1:\"*\";s:11:\"cleanupHtml\";s:1:\"1\";s:10:\"columnType\";s:4:\"text\";s:14:\"purifierConfig\";s:0:\"\";s:10:\"purifyHtml\";s:1:\"1\";s:14:\"redactorConfig\";s:11:\"Simple.json\";}s:20:\"translationKeyFormat\";N;s:17:\"translationMethod\";s:4:\"none\";s:4:\"type\";s:20:\"craft\\redactor\\Field\";}s:36:\"636651e0-1d88-45c8-8c3f-2da7f9684e73\";a:10:{s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;s:6:\"handle\";s:5:\"image\";s:12:\"instructions\";s:0:\"\";s:4:\"name\";s:5:\"Image\";s:10:\"searchable\";b:1;s:8:\"settings\";a:14:{s:12:\"allowedKinds\";a:1:{i:0;s:5:\"image\";}s:27:\"defaultUploadLocationSource\";s:43:\"volume:18580cf9-0fba-4a6f-8934-e1776f0e2149\";s:28:\"defaultUploadLocationSubpath\";s:0:\"\";s:5:\"limit\";s:1:\"1\";s:17:\"localizeRelations\";b:0;s:13:\"restrictFiles\";s:1:\"1\";s:14:\"selectionLabel\";s:0:\"\";s:26:\"singleUploadLocationSource\";s:43:\"volume:18580cf9-0fba-4a6f-8934-e1776f0e2149\";s:27:\"singleUploadLocationSubpath\";s:0:\"\";s:6:\"source\";N;s:7:\"sources\";s:1:\"*\";s:12:\"targetSiteId\";N;s:15:\"useSingleFolder\";s:0:\"\";s:8:\"viewMode\";s:4:\"list\";}s:20:\"translationKeyFormat\";N;s:17:\"translationMethod\";s:4:\"site\";s:4:\"type\";s:19:\"craft\\fields\\Assets\";}s:36:\"c2f32189-d7a9-41ec-8282-3c9779a9f825\";a:10:{s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";N;s:6:\"handle\";s:6:\"button\";s:12:\"instructions\";s:0:\"\";s:4:\"name\";s:6:\"Button\";s:10:\"searchable\";b:1;s:8:\"settings\";a:9:{s:15:\"allowCustomText\";s:1:\"1\";s:11:\"allowTarget\";s:1:\"1\";s:16:\"allowedLinkNames\";a:5:{i:3;s:5:\"entry\";i:6;s:6:\"custom\";i:7;s:5:\"email\";i:8;s:3:\"tel\";i:9;s:3:\"url\";}s:14:\"autoNoReferrer\";s:1:\"1\";s:15:\"defaultLinkName\";s:5:\"entry\";s:11:\"defaultText\";s:0:\"\";s:15:\"enableAriaLabel\";s:1:\"1\";s:11:\"enableTitle\";s:1:\"1\";s:12:\"typeSettings\";a:9:{s:5:\"asset\";a:2:{s:16:\"allowCustomQuery\";s:0:\"\";s:7:\"sources\";s:1:\"*\";}s:8:\"category\";a:2:{s:16:\"allowCustomQuery\";s:0:\"\";s:7:\"sources\";s:1:\"*\";}s:6:\"custom\";a:2:{s:12:\"allowAliases\";s:0:\"\";s:17:\"disableValidation\";s:0:\"\";}s:5:\"email\";a:2:{s:12:\"allowAliases\";s:0:\"\";s:17:\"disableValidation\";s:0:\"\";}s:5:\"entry\";a:2:{s:16:\"allowCustomQuery\";s:0:\"\";s:7:\"sources\";s:1:\"*\";}s:4:\"site\";a:1:{s:5:\"sites\";s:1:\"*\";}s:3:\"tel\";a:2:{s:12:\"allowAliases\";s:0:\"\";s:17:\"disableValidation\";s:0:\"\";}s:3:\"url\";a:2:{s:12:\"allowAliases\";s:0:\"\";s:17:\"disableValidation\";s:0:\"\";}s:4:\"user\";a:2:{s:16:\"allowCustomQuery\";s:0:\"\";s:7:\"sources\";s:1:\"*\";}}}s:20:\"translationKeyFormat\";N;s:17:\"translationMethod\";s:4:\"none\";s:4:\"type\";s:31:\"typedlinkfield\\fields\\LinkField\";}}s:6:\"handle\";s:12:\"imageCallout\";s:4:\"name\";s:13:\"Image Callout\";s:9:\"sortOrder\";i:1;}s:36:\"159a0002-8036-46f0-b841-fff97712822f\";a:6:{s:5:\"field\";s:36:\"c7d0c722-9e8d-41e2-9479-86cf3dee1e5a\";s:12:\"fieldLayouts\";a:1:{s:36:\"508ea40b-9821-477d-928d-887285c47aa6\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:6:\"fields\";a:3:{s:36:\"19cf6c69-f424-41c7-aeb6-e96b7c861345\";a:2:{s:8:\"required\";b:1;s:9:\"sortOrder\";i:1;}s:36:\"612a527c-7d76-481e-a46e-6cef9469aa81\";a:2:{s:8:\"required\";b:1;s:9:\"sortOrder\";i:2;}s:36:\"d689d51a-bdc8-40a6-8a54-68d4125e5990\";a:2:{s:8:\"required\";b:1;s:9:\"sortOrder\";i:3;}}s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";i:1;}}}}s:6:\"fields\";a:3:{s:36:\"19cf6c69-f424-41c7-aeb6-e96b7c861345\";a:10:{s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";N;s:6:\"handle\";s:8:\"headline\";s:12:\"instructions\";s:0:\"\";s:4:\"name\";s:8:\"Headline\";s:10:\"searchable\";b:1;s:8:\"settings\";a:6:{s:9:\"charLimit\";s:0:\"\";s:4:\"code\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";s:11:\"initialRows\";s:1:\"4\";s:9:\"multiline\";s:0:\"\";s:11:\"placeholder\";s:0:\"\";}s:20:\"translationKeyFormat\";N;s:17:\"translationMethod\";s:4:\"none\";s:4:\"type\";s:22:\"craft\\fields\\PlainText\";}s:36:\"612a527c-7d76-481e-a46e-6cef9469aa81\";a:10:{s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";N;s:6:\"handle\";s:4:\"text\";s:12:\"instructions\";s:0:\"\";s:4:\"name\";s:4:\"Text\";s:10:\"searchable\";b:1;s:8:\"settings\";a:7:{s:19:\"availableTransforms\";s:1:\"*\";s:16:\"availableVolumes\";s:1:\"*\";s:11:\"cleanupHtml\";s:1:\"1\";s:10:\"columnType\";s:4:\"text\";s:14:\"purifierConfig\";s:0:\"\";s:10:\"purifyHtml\";s:1:\"1\";s:14:\"redactorConfig\";s:11:\"Simple.json\";}s:20:\"translationKeyFormat\";N;s:17:\"translationMethod\";s:4:\"none\";s:4:\"type\";s:20:\"craft\\redactor\\Field\";}s:36:\"d689d51a-bdc8-40a6-8a54-68d4125e5990\";a:10:{s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;s:6:\"handle\";s:5:\"image\";s:12:\"instructions\";s:0:\"\";s:4:\"name\";s:5:\"Image\";s:10:\"searchable\";b:1;s:8:\"settings\";a:14:{s:12:\"allowedKinds\";a:1:{i:0;s:5:\"image\";}s:27:\"defaultUploadLocationSource\";s:43:\"volume:18580cf9-0fba-4a6f-8934-e1776f0e2149\";s:28:\"defaultUploadLocationSubpath\";s:0:\"\";s:5:\"limit\";s:1:\"1\";s:17:\"localizeRelations\";b:0;s:13:\"restrictFiles\";s:1:\"1\";s:14:\"selectionLabel\";s:0:\"\";s:26:\"singleUploadLocationSource\";s:43:\"volume:18580cf9-0fba-4a6f-8934-e1776f0e2149\";s:27:\"singleUploadLocationSubpath\";s:0:\"\";s:6:\"source\";N;s:7:\"sources\";s:1:\"*\";s:12:\"targetSiteId\";N;s:15:\"useSingleFolder\";s:0:\"\";s:8:\"viewMode\";s:4:\"list\";}s:20:\"translationKeyFormat\";N;s:17:\"translationMethod\";s:4:\"site\";s:4:\"type\";s:19:\"craft\\fields\\Assets\";}}s:6:\"handle\";s:7:\"callout\";s:4:\"name\";s:7:\"Callout\";s:9:\"sortOrder\";i:1;}s:36:\"4ff91211-3e0d-4acf-8752-56a6f0ddf556\";a:6:{s:5:\"field\";s:36:\"33a8e7bf-3aa8-4eba-8336-2b9d47e27b0e\";s:12:\"fieldLayouts\";a:1:{s:36:\"08cb7a6e-77da-4e78-9a86-de1985084ff3\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:6:\"fields\";a:1:{s:36:\"d385991f-c2a0-4613-ad4a-9f4eaea890e2\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:1;}}s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";i:1;}}}}s:6:\"fields\";a:1:{s:36:\"d385991f-c2a0-4613-ad4a-9f4eaea890e2\";a:10:{s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;s:6:\"handle\";s:5:\"image\";s:12:\"instructions\";s:0:\"\";s:4:\"name\";s:5:\"Image\";s:10:\"searchable\";b:1;s:8:\"settings\";a:14:{s:12:\"allowedKinds\";a:1:{i:0;s:5:\"image\";}s:27:\"defaultUploadLocationSource\";s:43:\"volume:18580cf9-0fba-4a6f-8934-e1776f0e2149\";s:28:\"defaultUploadLocationSubpath\";s:0:\"\";s:5:\"limit\";s:1:\"1\";s:17:\"localizeRelations\";b:0;s:13:\"restrictFiles\";s:1:\"1\";s:14:\"selectionLabel\";s:0:\"\";s:26:\"singleUploadLocationSource\";s:43:\"volume:18580cf9-0fba-4a6f-8934-e1776f0e2149\";s:27:\"singleUploadLocationSubpath\";s:0:\"\";s:6:\"source\";N;s:7:\"sources\";s:1:\"*\";s:12:\"targetSiteId\";N;s:15:\"useSingleFolder\";s:0:\"\";s:8:\"viewMode\";s:4:\"list\";}s:20:\"translationKeyFormat\";N;s:17:\"translationMethod\";s:4:\"site\";s:4:\"type\";s:19:\"craft\\fields\\Assets\";}}s:6:\"handle\";s:10:\"imageBlock\";s:4:\"name\";s:11:\"Image Block\";s:9:\"sortOrder\";i:1;}s:36:\"2642b72f-fbc0-4f9b-aa23-80fcf5a1c002\";a:6:{s:5:\"field\";s:36:\"33a8e7bf-3aa8-4eba-8336-2b9d47e27b0e\";s:12:\"fieldLayouts\";a:1:{s:36:\"b896da6d-1fc2-4538-963f-f9bc59b79d2a\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:6:\"fields\";a:1:{s:36:\"8e8a7caf-d04a-483c-94ff-52cbc4ef1f8e\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:1;}}s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";i:1;}}}}s:6:\"fields\";a:1:{s:36:\"8e8a7caf-d04a-483c-94ff-52cbc4ef1f8e\";a:10:{s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";N;s:6:\"handle\";s:4:\"text\";s:12:\"instructions\";s:0:\"\";s:4:\"name\";s:4:\"Text\";s:10:\"searchable\";b:1;s:8:\"settings\";a:7:{s:19:\"availableTransforms\";s:1:\"*\";s:16:\"availableVolumes\";s:1:\"*\";s:11:\"cleanupHtml\";s:1:\"1\";s:10:\"columnType\";s:4:\"text\";s:14:\"purifierConfig\";s:0:\"\";s:10:\"purifyHtml\";s:1:\"1\";s:14:\"redactorConfig\";s:13:\"Standard.json\";}s:20:\"translationKeyFormat\";N;s:17:\"translationMethod\";s:4:\"none\";s:4:\"type\";s:20:\"craft\\redactor\\Field\";}}s:6:\"handle\";s:13:\"richTextBlock\";s:4:\"name\";s:15:\"Rich Text Block\";s:9:\"sortOrder\";i:2;}}}','{\"dateModified\":\"@config/project.yaml\",\"email\":\"@config/project.yaml\",\"fieldGroups\":\"@config/project.yaml\",\"sections\":\"@config/project.yaml\",\"siteGroups\":\"@config/project.yaml\",\"sites\":\"@config/project.yaml\",\"system\":\"@config/project.yaml\",\"users\":\"@config/project.yaml\",\"plugins\":\"@config/project.yaml\"}','BndeuBcB2dVd','2019-03-03 19:55:27','2019-03-04 02:23:07','4aae29fd-b462-46f1-a987-df1c00eb9e22');
/*!40000 ALTER TABLE `info` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixblocks`
--

LOCK TABLES `matrixblocks` WRITE;
/*!40000 ALTER TABLE `matrixblocks` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `matrixblocks` VALUES (6,5,NULL,2,1,1,NULL,'2019-03-04 00:20:34','2019-03-04 00:20:34','f8175c4f-16f4-4efb-a70b-c0c516b0e84f'),(7,5,NULL,2,1,2,NULL,'2019-03-04 00:20:34','2019-03-04 00:20:34','db970691-2c82-4be8-88b9-19eab22c6b05'),(9,2,NULL,4,2,1,NULL,'2019-03-04 00:29:38','2019-03-04 02:06:14','87f4a75b-bb5d-4972-a4dd-7e299125c7d2'),(10,2,NULL,4,2,2,NULL,'2019-03-04 00:32:19','2019-03-04 02:06:14','8463c8c7-ebbd-40eb-84d3-b447aec33f7f'),(11,2,NULL,9,3,1,NULL,'2019-03-04 02:06:14','2019-03-04 02:06:14','39137d6b-a6df-456e-8560-1f80cabfe5c3'),(12,2,NULL,9,3,2,NULL,'2019-03-04 02:06:14','2019-03-04 02:06:14','d2c03e32-4a2e-4ded-b7a4-47ffeaca73f7'),(13,2,NULL,9,3,3,NULL,'2019-03-04 02:06:14','2019-03-04 02:06:14','c62080c7-4807-4e77-ac38-05ae25285d3b'),(14,2,NULL,14,4,1,NULL,'2019-03-04 02:06:14','2019-03-04 02:06:14','171d4f45-3820-461e-83ee-d1782d5da789'),(15,4,NULL,20,5,1,NULL,'2019-03-04 02:17:18','2019-03-04 02:21:21','c6c8ef5c-0119-440f-9c73-70b3eb9d9bbf'),(16,4,NULL,20,6,2,NULL,'2019-03-04 02:17:18','2019-03-04 02:21:21','ccab6da1-e9b6-43d7-9ab8-2c28bbee2c5b');
/*!40000 ALTER TABLE `matrixblocks` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixblocktypes`
--

LOCK TABLES `matrixblocktypes` WRITE;
/*!40000 ALTER TABLE `matrixblocktypes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `matrixblocktypes` VALUES (1,2,2,'Link Item','linkItem',1,'2019-03-04 00:18:16','2019-03-04 00:20:03','69ada84e-f4c1-44c9-a1a6-4fd2deed76d2'),(2,4,4,'Slide','slide',1,'2019-03-04 00:26:40','2019-03-04 00:26:40','84cb23ba-6290-4966-b53a-315df8f70777'),(3,9,6,'Image Callout','imageCallout',1,'2019-03-04 02:00:09','2019-03-04 02:03:12','0022f946-12f9-4f59-a183-9037a17bff7f'),(4,14,7,'Callout','callout',1,'2019-03-04 02:02:19','2019-03-04 02:02:19','159a0002-8036-46f0-b841-fff97712822f'),(5,20,8,'Image Block','imageBlock',1,'2019-03-04 02:14:23','2019-03-04 02:14:23','4ff91211-3e0d-4acf-8752-56a6f0ddf556'),(6,20,9,'Rich Text Block','richTextBlock',2,'2019-03-04 02:14:23','2019-03-04 02:14:23','2642b72f-fbc0-4f9b-aa23-80fcf5a1c002');
/*!40000 ALTER TABLE `matrixblocktypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixcontent_contentblocks`
--

LOCK TABLES `matrixcontent_contentblocks` WRITE;
/*!40000 ALTER TABLE `matrixcontent_contentblocks` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `matrixcontent_contentblocks` VALUES (1,15,1,'2019-03-04 02:17:18','2019-03-04 02:21:20','ff8791f4-a9be-46b5-abd6-8155c94f890b',NULL),(2,16,1,'2019-03-04 02:17:18','2019-03-04 02:21:21','17285638-cd7b-4de8-9691-d8b4b25dfb51','<p>This blog post shows a few different types of content that’s supported and styled with Bootstrap. Basic typography, images, and code are all supported.</p>\n<p>Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Sed posuere consectetur est at lobortis. Cras mattis consectetur purus sit amet fermentum.</p>\n<p>Curabitur blandit tempus porttitor. Nullam quis risus eget urna mollis ornare vel eu leo. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>\n<p>Etiam porta sem malesuada magna mollis euismod. Cras mattis consectetur purus sit amet fermentum. Aenean lacinia bibendum nulla sed consectetur.</p>\n<h1>Heading</h1>\n<p>Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.</p>\n<h3>Sub-heading</h3>\n<p>Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.</p>\n<p>Example code block</p>\n<p>Aenean lacinia bibendum nulla sed consectetur. Etiam porta sem malesuada magna mollis euismod. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa.</p>\n<h3>Sub-heading</h3>\n<p>Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aenean lacinia bibendum nulla sed consectetur. Etiam porta sem malesuada magna mollis euismod. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>\n<ul><li>Praesent commodo cursus magna, vel scelerisque nisl consectetur et.</li><li>Donec id elit non mi porta gravida at eget metus.</li><li>Nulla vitae elit libero, a pharetra augue.</li></ul>\n<p>Donec ullamcorper nulla non metus auctor fringilla. Nulla vitae elit libero, a pharetra augue.</p>\n<ol><li>Vestibulum id ligula porta felis euismod semper.</li><li>Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.</li><li>Maecenas sed diam eget risus varius blandit sit amet non magna.</li></ol>\n<p>Cras mattis consectetur purus sit amet fermentum. Sed posuere consectetur est at lobortis.</p>');
/*!40000 ALTER TABLE `matrixcontent_contentblocks` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixcontent_imagecalloutset`
--

LOCK TABLES `matrixcontent_imagecalloutset` WRITE;
/*!40000 ALTER TABLE `matrixcontent_imagecalloutset` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `matrixcontent_imagecalloutset` VALUES (1,11,1,'2019-03-04 02:06:14','2019-03-04 02:06:14','514076c3-d662-4405-b16a-f4fe7a328bb0','Test 1','<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Est nobis placeat quaerat quos? Aliquam distinctio ea enim molestias omnis perspiciatis sunt tenetur! Assumenda beatae deserunt dolorem, maxime mollitia quibusdam tempora!</p>','{\"ariaLabel\":\"\",\"customQuery\":null,\"customText\":\"Test\",\"target\":\"\",\"title\":\"\",\"type\":\"entry\",\"value\":\"4\"}'),(2,12,1,'2019-03-04 02:06:14','2019-03-04 02:06:14','aacd426a-0713-4fb5-b1ca-636a93ed42c7','Test 2','<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Est nobis placeat quaerat quos? Aliquam distinctio ea enim molestias omnis perspiciatis sunt tenetur! Assumenda beatae deserunt dolorem, maxime mollitia quibusdam tempora!</p>','{\"ariaLabel\":\"\",\"customQuery\":null,\"customText\":\"Test\",\"target\":\"\",\"title\":\"\",\"type\":\"entry\",\"value\":\"4\"}'),(3,13,1,'2019-03-04 02:06:14','2019-03-04 02:06:14','9a6257e1-c293-4aa8-bfe7-3c2d7961c0bb','Test 3','<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Est nobis placeat quaerat quos? Aliquam distinctio ea enim molestias omnis perspiciatis sunt tenetur! Assumenda beatae deserunt dolorem, maxime mollitia quibusdam tempora!</p>','{\"ariaLabel\":\"\",\"customQuery\":null,\"customText\":\"\",\"target\":\"\",\"title\":\"\",\"type\":\"entry\",\"value\":null}');
/*!40000 ALTER TABLE `matrixcontent_imagecalloutset` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixcontent_linkgroup`
--

LOCK TABLES `matrixcontent_linkgroup` WRITE;
/*!40000 ALTER TABLE `matrixcontent_linkgroup` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `matrixcontent_linkgroup` VALUES (1,6,1,'2019-03-04 00:20:34','2019-03-04 00:20:34','af4b85ed-634e-465d-86d6-ccb7027d4f8d','{\"ariaLabel\":\"\",\"customQuery\":null,\"customText\":\"Home\",\"target\":\"\",\"title\":\"\",\"type\":\"entry\",\"value\":\"2\"}'),(2,7,1,'2019-03-04 00:20:34','2019-03-04 00:20:34','5b5b47d5-773d-4779-9291-9572236e16aa','{\"ariaLabel\":\"\",\"customQuery\":null,\"customText\":\"Blog\",\"target\":\"\",\"title\":\"\",\"type\":\"entry\",\"value\":\"3\"}');
/*!40000 ALTER TABLE `matrixcontent_linkgroup` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixcontent_slider`
--

LOCK TABLES `matrixcontent_slider` WRITE;
/*!40000 ALTER TABLE `matrixcontent_slider` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `matrixcontent_slider` VALUES (1,9,1,'2019-03-04 00:29:38','2019-03-04 02:06:14','2b7b6f5a-479b-417d-b12c-88e7caea8cdc','Test','{\"ariaLabel\":\"\",\"customQuery\":null,\"customText\":\"Blog\",\"target\":\"\",\"title\":\"\",\"type\":\"entry\",\"value\":\"3\"}','<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Est nobis placeat quaerat quos? Aliquam distinctio ea enim molestias omnis perspiciatis sunt tenetur! Assumenda beatae deserunt dolorem, maxime mollitia quibusdam tempora!</p>'),(2,10,1,'2019-03-04 00:32:19','2019-03-04 02:06:14','893a0f5c-e4c4-4461-929e-676e8c69942e','Test 2','{\"ariaLabel\":\"\",\"customQuery\":null,\"customText\":\"Home\",\"target\":\"\",\"title\":\"\",\"type\":\"entry\",\"value\":\"2\"}','<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Est nobis placeat quaerat quos? Aliquam distinctio ea enim molestias omnis perspiciatis sunt tenetur! Assumenda beatae deserunt dolorem, maxime mollitia quibusdam tempora!</p>');
/*!40000 ALTER TABLE `matrixcontent_slider` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixcontent_twocolumncallout`
--

LOCK TABLES `matrixcontent_twocolumncallout` WRITE;
/*!40000 ALTER TABLE `matrixcontent_twocolumncallout` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `matrixcontent_twocolumncallout` VALUES (1,14,1,'2019-03-04 02:06:14','2019-03-04 02:06:14','a0863f29-c80e-4e2f-976e-ebd76b7e6913','Test','<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Est nobis placeat quaerat quos? Aliquam distinctio ea enim molestias omnis perspiciatis sunt tenetur! Assumenda beatae deserunt dolorem, maxime mollitia quibusdam tempora!</p>');
/*!40000 ALTER TABLE `matrixcontent_twocolumncallout` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `migrations` VALUES (1,NULL,'app','Install','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','4d9a0008-a896-4fcf-bb67-b1b197d3f01e'),(2,NULL,'app','m150403_183908_migrations_table_changes','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','36a316cc-8e59-4966-a9e6-be1a9a7b7b2d'),(3,NULL,'app','m150403_184247_plugins_table_changes','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','6f4d2868-77d7-4483-b9b8-c463ab663a16'),(4,NULL,'app','m150403_184533_field_version','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','5eba6f53-a221-426d-a2ca-b9ae41da5385'),(5,NULL,'app','m150403_184729_type_columns','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','dfecd465-3d6f-43c9-ba88-716492817769'),(6,NULL,'app','m150403_185142_volumes','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','72de58dd-c3ed-4264-8f2a-d14f72105a90'),(7,NULL,'app','m150428_231346_userpreferences','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','5d504f9b-b994-46b9-a092-7b3517902df8'),(8,NULL,'app','m150519_150900_fieldversion_conversion','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','2e9709d5-b454-4d9e-b3cf-296902cd14a1'),(9,NULL,'app','m150617_213829_update_email_settings','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','ae51bc87-a0fd-41bb-9123-010ea30e626d'),(10,NULL,'app','m150721_124739_templatecachequeries','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','e70064f2-8c26-4f20-8108-9c0406578c4f'),(11,NULL,'app','m150724_140822_adjust_quality_settings','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','10f87009-d2b2-413e-af0c-8579236f0164'),(12,NULL,'app','m150815_133521_last_login_attempt_ip','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','c68d2bdf-0194-46f4-9224-da2f4a9e63a0'),(13,NULL,'app','m151002_095935_volume_cache_settings','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','9e5e56f8-d652-4fd5-80e3-947913a99950'),(14,NULL,'app','m151005_142750_volume_s3_storage_settings','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','47239d32-7317-415e-a442-a85a65a415f5'),(15,NULL,'app','m151016_133600_delete_asset_thumbnails','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','d9e2041b-b404-474d-963f-159d86981007'),(16,NULL,'app','m151209_000000_move_logo','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','17ca1b3e-6f08-450d-8a34-594059254d92'),(17,NULL,'app','m151211_000000_rename_fileId_to_assetId','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','00cbd531-091f-420d-ac75-9342801f6be4'),(18,NULL,'app','m151215_000000_rename_asset_permissions','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','bb105591-3bc6-402c-8c73-a21cc4b2aff9'),(19,NULL,'app','m160707_000001_rename_richtext_assetsource_setting','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','e80f17be-f2df-46f5-89f5-ccb7625aabf9'),(20,NULL,'app','m160708_185142_volume_hasUrls_setting','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','9d61e6a7-4dbb-411e-815c-b9b333682b16'),(21,NULL,'app','m160714_000000_increase_max_asset_filesize','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','0937553d-c447-457d-b771-4eaafa23255a'),(22,NULL,'app','m160727_194637_column_cleanup','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','b78bcedf-7cbf-492e-8e71-7a7b87a32b3b'),(23,NULL,'app','m160804_110002_userphotos_to_assets','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','3bbf2c35-d981-4868-9500-ee9754fae3c2'),(24,NULL,'app','m160807_144858_sites','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','6d339519-bca6-4487-8760-8b279616fde4'),(25,NULL,'app','m160829_000000_pending_user_content_cleanup','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','b6bf9a8e-e428-4117-8f86-b1ee47632246'),(26,NULL,'app','m160830_000000_asset_index_uri_increase','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','fee0f4e3-a888-41f8-91cc-0840d40ec10d'),(27,NULL,'app','m160912_230520_require_entry_type_id','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','9f83c67f-8e38-43db-aa0d-8ee489104d13'),(28,NULL,'app','m160913_134730_require_matrix_block_type_id','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','6d698c22-3d02-461c-8989-5d78df9fca37'),(29,NULL,'app','m160920_174553_matrixblocks_owner_site_id_nullable','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','869e00ba-d7ee-412c-8644-7d2c5fd8fe05'),(30,NULL,'app','m160920_231045_usergroup_handle_title_unique','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','05ffa795-362b-4e95-b589-13da703d52c1'),(31,NULL,'app','m160925_113941_route_uri_parts','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','fde5a7e6-29e3-4d93-8a07-0cbe8d330d98'),(32,NULL,'app','m161006_205918_schemaVersion_not_null','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','e76c76df-92a4-43c8-a52f-5b320e0fb9d1'),(33,NULL,'app','m161007_130653_update_email_settings','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','54a4f7cc-e05d-4565-aa6b-b8df4c41a9cb'),(34,NULL,'app','m161013_175052_newParentId','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','d6188bb5-c4bb-4dd4-b37c-2b0efa3d81ff'),(35,NULL,'app','m161021_102916_fix_recent_entries_widgets','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','e4452f9a-424f-48bc-84bb-f15eb3ba83de'),(36,NULL,'app','m161021_182140_rename_get_help_widget','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','08987793-6489-4254-b55b-1efeb41ecb0b'),(37,NULL,'app','m161025_000000_fix_char_columns','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','1bfb6011-b1e0-438b-8b5b-1bd002ac6548'),(38,NULL,'app','m161029_124145_email_message_languages','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','3c2c78a6-9138-4bf4-b2c1-0d0528e9448c'),(39,NULL,'app','m161108_000000_new_version_format','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','2f8c7bd1-bf46-481f-8241-0072bb690426'),(40,NULL,'app','m161109_000000_index_shuffle','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','770e20a7-032d-44a9-a022-9d873f01da89'),(41,NULL,'app','m161122_185500_no_craft_app','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','a62ae4aa-f78a-43c3-b575-e821c8f2d7a2'),(42,NULL,'app','m161125_150752_clear_urlmanager_cache','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','793a45bc-e5cd-4bce-83ea-bc52afa2edc2'),(43,NULL,'app','m161220_000000_volumes_hasurl_notnull','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','87744d3e-98b4-49b1-84d6-b2b4ef096a4a'),(44,NULL,'app','m170114_161144_udates_permission','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','594f65aa-dedd-48af-8b4b-ac04c8ba87fd'),(45,NULL,'app','m170120_000000_schema_cleanup','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','cb774b51-e995-437c-8300-15b6a78b1a46'),(46,NULL,'app','m170126_000000_assets_focal_point','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','590eb15f-26cb-4cce-9764-8be0f43eb9fa'),(47,NULL,'app','m170206_142126_system_name','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','f3a0fae5-7cec-4b76-ac0c-970020a27c0a'),(48,NULL,'app','m170217_044740_category_branch_limits','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','d6eaadc1-dfc4-493e-bd3b-6a12d362d1c8'),(49,NULL,'app','m170217_120224_asset_indexing_columns','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','60e4ef57-07e2-481e-b62c-6558f746875c'),(50,NULL,'app','m170223_224012_plain_text_settings','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','1d46d0af-d6c6-4a8e-88c3-c1a4802f6fed'),(51,NULL,'app','m170227_120814_focal_point_percentage','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','4f5cbc18-452c-4087-b1d0-f5cc91ae7f33'),(52,NULL,'app','m170228_171113_system_messages','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','513f72f5-5b9b-4fc1-909c-58d09ee86d59'),(53,NULL,'app','m170303_140500_asset_field_source_settings','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','7123267d-22fc-47bb-b8c5-4ae3e027f73b'),(54,NULL,'app','m170306_150500_asset_temporary_uploads','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','9a600856-2a39-4af2-9d5b-a10d78226498'),(55,NULL,'app','m170523_190652_element_field_layout_ids','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','a75fd1d9-a88e-4c70-b37b-a9fe977c5362'),(56,NULL,'app','m170612_000000_route_index_shuffle','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','9fb0cb3c-1b25-46a9-a8a1-3d4c5b5c0255'),(57,NULL,'app','m170621_195237_format_plugin_handles','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','dafcabd9-103b-4651-b135-71fd66412f82'),(58,NULL,'app','m170630_161027_deprecation_line_nullable','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','75e192a3-b728-4442-bbb8-682d33cb1a7a'),(59,NULL,'app','m170630_161028_deprecation_changes','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','ed3489c7-29c1-406b-9854-ed2d43f93d40'),(60,NULL,'app','m170703_181539_plugins_table_tweaks','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','1ad019b3-0649-42a2-81ec-02fa5591b42f'),(61,NULL,'app','m170704_134916_sites_tables','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','56288512-cb33-4118-be71-a021b09de3d8'),(62,NULL,'app','m170706_183216_rename_sequences','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','bb3181a2-fd3c-4603-9ff3-bff19b75e80d'),(63,NULL,'app','m170707_094758_delete_compiled_traits','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','48ad8059-0ed2-4cde-a9e5-c3ccac8d80b6'),(64,NULL,'app','m170731_190138_drop_asset_packagist','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','c2365244-35ee-4c77-8fec-97e54dd4e469'),(65,NULL,'app','m170810_201318_create_queue_table','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','33ec2b1e-af6f-4b8f-8202-58b29056c209'),(66,NULL,'app','m170816_133741_delete_compiled_behaviors','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','3ea02ff9-569e-455f-8d31-0f1478d635be'),(67,NULL,'app','m170903_192801_longblob_for_queue_jobs','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','4ea4f7d1-72d2-4a49-8210-ef2f3c5fc0a3'),(68,NULL,'app','m170914_204621_asset_cache_shuffle','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','a2b9cc7f-e738-445e-a6ee-76aa6121be65'),(69,NULL,'app','m171011_214115_site_groups','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','b63b7bd0-3934-4de5-9fd4-976b798e883f'),(70,NULL,'app','m171012_151440_primary_site','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','a8146d80-1255-4762-9f6c-606d5087aebd'),(71,NULL,'app','m171013_142500_transform_interlace','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','20f46204-562f-48a1-bd2a-db79a4131cd9'),(72,NULL,'app','m171016_092553_drop_position_select','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','25bb8312-796e-42ce-ae77-fc1562400a79'),(73,NULL,'app','m171016_221244_less_strict_translation_method','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','89ebe01e-a2f3-4afc-834e-cc2fd2506bae'),(74,NULL,'app','m171107_000000_assign_group_permissions','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','2b72a27d-63d1-4e89-8d10-3f69500f0453'),(75,NULL,'app','m171117_000001_templatecache_index_tune','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','32040726-a2ca-4bc2-b9dd-8557ebc19f4e'),(76,NULL,'app','m171126_105927_disabled_plugins','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','a5e75fb5-936f-40e2-b62e-30ec538d867e'),(77,NULL,'app','m171130_214407_craftidtokens_table','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','ecfc1ef8-4eb5-4421-8cc9-ace4f236ee79'),(78,NULL,'app','m171202_004225_update_email_settings','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','a86dab2d-0594-404b-ba28-5cc606d1a193'),(79,NULL,'app','m171204_000001_templatecache_index_tune_deux','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','f70bb6e9-24fc-414a-8409-ecc950762f0e'),(80,NULL,'app','m171205_130908_remove_craftidtokens_refreshtoken_column','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','6814175c-7389-44bf-9c61-292a8b3e2925'),(81,NULL,'app','m171218_143135_longtext_query_column','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','4e42d1a7-7829-4ee9-9a87-fcab000b577c'),(82,NULL,'app','m171231_055546_environment_variables_to_aliases','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','2adaf4b8-8ff9-45bd-87fc-b08a1fb6fd1c'),(83,NULL,'app','m180113_153740_drop_users_archived_column','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','02b888b3-17b7-407c-b5fc-afae645099a4'),(84,NULL,'app','m180122_213433_propagate_entries_setting','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','5edf0ec8-0a9e-4bc3-923e-e1aaf50ac9c1'),(85,NULL,'app','m180124_230459_fix_propagate_entries_values','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','6e0266df-92aa-4f63-bbf4-f3c59e43d9d1'),(86,NULL,'app','m180128_235202_set_tag_slugs','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','db25aa1b-8c4d-4534-88c6-f52ff88a696d'),(87,NULL,'app','m180202_185551_fix_focal_points','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','d4ea1642-7e3c-4a26-a537-ec093ccd6863'),(88,NULL,'app','m180217_172123_tiny_ints','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','0c2f3b7e-da2e-41ea-9d74-6d3a840819d1'),(89,NULL,'app','m180321_233505_small_ints','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','2cf96480-a9af-4d38-8b25-fb21e27a6e05'),(90,NULL,'app','m180328_115523_new_license_key_statuses','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','96d10d6e-ba5a-4166-a032-d5ccb35a6f9a'),(91,NULL,'app','m180404_182320_edition_changes','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','0adeda7b-1265-4d74-a387-e3986a689961'),(92,NULL,'app','m180411_102218_fix_db_routes','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','042a03d5-664e-47bc-9f5e-544938e734c4'),(93,NULL,'app','m180416_205628_resourcepaths_table','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','9236faaf-f275-4d2d-93d0-a0fb7b22a101'),(94,NULL,'app','m180418_205713_widget_cleanup','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','fb0a3aca-319a-4dec-8df6-f7a01981a57c'),(95,NULL,'app','m180425_203349_searchable_fields','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','a3d4ce59-f436-4e53-83d8-f621d23d7e3b'),(96,NULL,'app','m180516_153000_uids_in_field_settings','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','e0ed520a-714f-4b0f-a457-f8e1be381835'),(97,NULL,'app','m180517_173000_user_photo_volume_to_uid','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','cd8a2b36-195e-4302-96aa-673b4fe0ce6e'),(98,NULL,'app','m180518_173000_permissions_to_uid','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','d43b6032-6bd7-48dd-9a02-8534511726d9'),(99,NULL,'app','m180520_173000_matrix_context_to_uids','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','0e61ef8d-2261-4e69-b67f-4f3743d2f683'),(100,NULL,'app','m180521_173000_initial_yml_and_snapshot','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','b43a6a7b-e6c8-4ef5-9769-5ed36d0f6d72'),(101,NULL,'app','m180731_162030_soft_delete_sites','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','d139d384-7e3a-4956-a358-5a124d969afc'),(102,NULL,'app','m180810_214427_soft_delete_field_layouts','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','576110f6-2fed-4b55-9fce-b908bf21d71b'),(103,NULL,'app','m180810_214439_soft_delete_elements','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','4cf90995-6dff-4e4e-bd9e-f5ffddf4d9e9'),(104,NULL,'app','m180824_193422_case_sensitivity_fixes','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','72b08d82-c037-4e55-9c7d-bb6401ac126f'),(105,NULL,'app','m180901_151639_fix_matrixcontent_tables','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','dcfd4fb7-f3d8-4ccb-b49f-fb1ecf0b6d8f'),(106,NULL,'app','m180904_112109_permission_changes','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','f49719e3-f813-48ef-85d8-220582c2453c'),(107,NULL,'app','m180910_142030_soft_delete_sitegroups','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','ca2ca987-94d6-4ed6-9ef6-54fa00c6c27f'),(108,NULL,'app','m181011_160000_soft_delete_asset_support','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','c8398e95-923b-4cfc-861c-fd45b24d2df9'),(109,NULL,'app','m181016_183648_set_default_user_settings','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','ae6f1d0c-7c15-4a80-ba2e-f9d27f32009a'),(110,NULL,'app','m181017_225222_system_config_settings','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','d0888179-34c1-4e5f-a2f0-54213b586b79'),(111,NULL,'app','m181018_222343_drop_userpermissions_from_config','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','29c69f87-9fae-4647-837a-bfdba034decf'),(112,NULL,'app','m181029_130000_add_transforms_routes_to_config','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','f959b83b-b19b-46f0-996b-7561d5ad2722'),(113,NULL,'app','m181112_203955_sequences_table','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','8ad88414-9f1e-4be7-a574-f17f7bd6f693'),(114,NULL,'app','m181121_001712_cleanup_field_configs','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','6d3e7811-62b3-4977-9190-5f707ac7cb4a'),(115,NULL,'app','m181128_193942_fix_project_config','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','a83cf86e-4c98-4a01-929a-0b751b139240'),(116,NULL,'app','m181130_143040_fix_schema_version','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','1d80bac8-27b0-44c3-96e1-0923306906ed'),(117,NULL,'app','m181211_143040_fix_entry_type_uids','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','7307958b-d683-45cd-8b27-008ddbfbbef0'),(118,NULL,'app','m181213_102500_config_map_aliases','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','fb5ca2b7-cec5-41d5-984b-bcfcdaffc9b1'),(119,NULL,'app','m181217_153000_fix_structure_uids','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','2f189e6a-23e1-4d1f-9cb0-1e451414d3cf'),(120,NULL,'app','m190104_152725_store_licensed_plugin_editions','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','aaf23fa6-c381-4380-923d-8571881dda55'),(121,NULL,'app','m190108_110000_cleanup_project_config','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','25a2e39d-0a95-4c8e-8bda-f76d9bd9f90c'),(122,NULL,'app','m190108_113000_asset_field_setting_change','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','57c9d5aa-2175-492b-bfcd-e5ffbe245887'),(123,NULL,'app','m190109_172845_fix_colspan','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','35d3ca6c-1a9d-46bf-847f-13b12bf7056b'),(124,NULL,'app','m190110_150000_prune_nonexisting_sites','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','92edebbe-88e8-4fb1-97c0-25d9df2e09b8'),(125,NULL,'app','m190110_214819_soft_delete_volumes','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','c82ac4cd-68ad-4dbc-bd10-a8e240ebec58'),(126,NULL,'app','m190112_124737_fix_user_settings','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','49d70fad-c922-4f46-b4e5-2c0cdee75fad'),(127,NULL,'app','m190112_131225_fix_field_layouts','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','789e7d2f-8c00-4405-8cec-ec053dac1f38'),(128,NULL,'app','m190112_201010_more_soft_deletes','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','92239334-6882-424f-8ff1-e72afa3f5f6c'),(129,NULL,'app','m190114_143000_more_asset_field_setting_changes','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','e0144b85-1171-4204-ba1e-c209e43ef8f3'),(130,NULL,'app','m190121_120000_rich_text_config_setting','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','2f0a6556-fbca-4e22-b194-bd312d0bf7b9'),(131,NULL,'app','m190125_191628_fix_email_transport_password','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','27b82e66-a0a4-4ffc-8354-51cf4f8cada4'),(132,NULL,'app','m190128_181422_cleanup_volume_folders','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','afb64a3e-4acc-4b3c-bac0-a033b74b17ef'),(133,NULL,'app','m190205_140000_fix_asset_soft_delete_index','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','26cf385f-7658-41a5-a3c3-50ec6ffaa3b5'),(134,NULL,'app','m190208_140000_reset_project_config_mapping','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','290efbff-692c-4e3b-950d-04356a04f921'),(135,NULL,'app','m190218_143000_element_index_settings_uid','2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-03 19:55:28','01b66967-2095-4f57-bee5-3152d2f25852'),(136,2,'plugin','m180430_204710_remove_old_plugins','2019-03-04 00:11:13','2019-03-04 00:11:13','2019-03-04 00:11:13','631673ce-3a44-4930-9b91-2f219684fc85'),(137,2,'plugin','Install','2019-03-04 00:11:13','2019-03-04 00:11:13','2019-03-04 00:11:13','9de4e83c-6b5b-4e79-a639-a7b019964adc');
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `plugins`
--

LOCK TABLES `plugins` WRITE;
/*!40000 ALTER TABLE `plugins` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `plugins` VALUES (1,'typedlinkfield','1.0.17','1.0.0','unknown',NULL,'2019-03-03 20:33:06','2019-03-03 20:33:06','2019-03-04 00:14:43','21873f32-3c6c-46c3-994d-0c0cdcc9c48d'),(2,'redactor','2.3.2','2.2.2','unknown',NULL,'2019-03-04 00:11:13','2019-03-04 00:11:13','2019-03-04 00:14:43','25e42768-620c-4e99-a22f-b08e735329ef');
/*!40000 ALTER TABLE `plugins` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `queue`
--

LOCK TABLES `queue` WRITE;
/*!40000 ALTER TABLE `queue` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `queue` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `relations`
--

LOCK TABLES `relations` WRITE;
/*!40000 ALTER TABLE `relations` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `relations` VALUES (11,8,9,NULL,8,1,'2019-03-04 02:06:14','2019-03-04 02:06:14','bdae35a1-5330-47cf-bc76-ec8c4dde86f6'),(12,8,10,NULL,8,1,'2019-03-04 02:06:14','2019-03-04 02:06:14','dce263e0-3960-42e6-a1ea-77367d679801'),(13,12,11,NULL,8,1,'2019-03-04 02:06:14','2019-03-04 02:06:14','76ceeede-2584-486c-b2dc-c5020496722a'),(14,12,12,NULL,8,1,'2019-03-04 02:06:14','2019-03-04 02:06:14','61c5a4c5-4970-47db-841e-a9dccc2c577c'),(15,12,13,NULL,8,1,'2019-03-04 02:06:14','2019-03-04 02:06:14','e7c2be5d-f584-4a73-b99a-9cf56a13b943'),(16,17,14,NULL,8,1,'2019-03-04 02:06:14','2019-03-04 02:06:14','6ec35a73-b501-4055-a599-41d88de0bcbb'),(19,19,4,NULL,8,1,'2019-03-04 02:21:20','2019-03-04 02:21:20','ff0706d3-f6fc-43d1-b0fc-5846d7039d8e'),(20,21,15,NULL,8,1,'2019-03-04 02:21:21','2019-03-04 02:21:21','bb2ddf1b-79fc-4cad-b603-7bfe29606d62');
/*!40000 ALTER TABLE `relations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `resourcepaths`
--

LOCK TABLES `resourcepaths` WRITE;
/*!40000 ALTER TABLE `resourcepaths` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `resourcepaths` VALUES ('135659e2','@app/web/assets/dbbackup/dist'),('1fda6f13','@lib/fileupload'),('21058a6','@lib/prismjs'),('2b79f88f','@app/web/assets/fields/dist'),('2c1ed6c1','@app/web/assets/dashboard/dist'),('2f6c8d04','@lib/fabric'),('2fa944e9','@craft/web/assets/fields/dist'),('39a36f5','@app/web/assets/matrix/dist'),('3a2a593a','@lib/garnishjs'),('534c4369','@lib/selectize'),('55636620','@craft/web/assets/cp/dist'),('592007e3','@lib/xregexp'),('5c18565d','@craft/web/assets/pluginstore/dist'),('66df5f96','@lib/timepicker'),('6cbb8f71','@typedlinkfield/resources'),('6ed59bd2','@app/web/assets/plugins/dist'),('7326eed','@lib/picturefill'),('77ce345a','@craft/redactor/assets/field/dist'),('7864bb80','@craft/web/assets/updater/dist'),('7bbf69c','@craft/web/assets/tablesettings/dist'),('8011ee4c','@vendor/craftcms/redactor/lib/redactor-plugins/video'),('8442b443','@app/web/assets/tablesettings/dist'),('86300aff','@lib/jquery.payment'),('8b98526a','@bower/jquery/dist'),('8d68da1c','@app/web/assets/utilities/dist'),('8e419037','@craft/web/assets/editentry/dist'),('9608d333','@app/web/assets/feed/dist'),('96522f','@lib/jquery-touch-events'),('9974ebc','@lib/d3'),('9a17a517','@lib/velocity'),('a408f99f','@lib/element-resize-detector'),('a7c2875c','@app/web/assets/matrixsettings/dist'),('a94a9da','@vendor/craftcms/redactor/lib/redactor'),('b12db15b','@craft/web/assets/matrixsettings/dist'),('b3b29392','@lib'),('b74414aa','@vendor/craftcms/redactor/lib/redactor-plugins/fullscreen'),('c27651af','@app/web/assets/craftsupport/dist'),('ca008f03','@craft/web/assets/plugins/dist'),('cb814c1','@app/web/assets/editentry/dist'),('cce4fd6e','@app/web/assets/updateswidget/dist'),('d4be3eb2','@lib/jquery-ui'),('d840917f','@app/web/assets/generalsettings/dist'),('dae6b900','@app/web/assets/installer/dist'),('dcb1af51','@app/web/assets/updater/dist'),('eb2d8df3','@app/web/assets/login/dist'),('ef13988d','@app/web/assets/cp/dist'),('f25ebf00','@app/web/assets/recententries/dist'),('f42bd5a6','@app/web/assets/pluginstore/dist');
/*!40000 ALTER TABLE `resourcepaths` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `searchindex`
--

LOCK TABLES `searchindex` WRITE;
/*!40000 ALTER TABLE `searchindex` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `searchindex` VALUES (1,'username',0,1,' admin '),(1,'firstname',0,1,''),(1,'lastname',0,1,''),(1,'fullname',0,1,''),(1,'email',0,1,' levi mostlyserious io '),(1,'slug',0,1,''),(2,'slug',0,1,' home page '),(2,'title',0,1,' home page '),(3,'slug',0,1,' blog listing '),(3,'title',0,1,' blog listing '),(4,'slug',0,1,' test '),(4,'title',0,1,' test '),(3,'field',1,1,''),(5,'slug',0,1,''),(5,'field',2,1,' http localhost 8000 http localhost 8000 blog '),(6,'field',3,1,' http localhost 8000 '),(6,'slug',0,1,''),(7,'field',3,1,' http localhost 8000 blog '),(7,'slug',0,1,''),(2,'field',4,1,' http localhost 8000 blog test placeholder lorem ipsum dolor sit amet consectetur adipisicing elit est nobis placeat quaerat quos aliquam distinctio ea enim molestias omnis perspiciatis sunt tenetur assumenda beatae deserunt dolorem maxime mollitia quibusdam tempora http localhost 8000 test 2 placeholder lorem ipsum dolor sit amet consectetur adipisicing elit est nobis placeat quaerat quos aliquam distinctio ea enim molestias omnis perspiciatis sunt tenetur assumenda beatae deserunt dolorem maxime mollitia quibusdam tempora '),(8,'filename',0,1,' placeholder jpg '),(8,'extension',0,1,' jpg '),(8,'kind',0,1,' image '),(8,'slug',0,1,''),(8,'title',0,1,' placeholder '),(9,'field',8,1,' placeholder '),(9,'field',5,1,' test '),(9,'field',7,1,' lorem ipsum dolor sit amet consectetur adipisicing elit est nobis placeat quaerat quos aliquam distinctio ea enim molestias omnis perspiciatis sunt tenetur assumenda beatae deserunt dolorem maxime mollitia quibusdam tempora '),(9,'field',6,1,' http localhost 8000 blog '),(9,'slug',0,1,''),(10,'field',8,1,' placeholder '),(10,'field',5,1,' test 2 '),(10,'field',7,1,' lorem ipsum dolor sit amet consectetur adipisicing elit est nobis placeat quaerat quos aliquam distinctio ea enim molestias omnis perspiciatis sunt tenetur assumenda beatae deserunt dolorem maxime mollitia quibusdam tempora '),(10,'field',6,1,' http localhost 8000 '),(10,'slug',0,1,''),(2,'field',9,1,' http localhost 8000 blog test test 1 placeholder lorem ipsum dolor sit amet consectetur adipisicing elit est nobis placeat quaerat quos aliquam distinctio ea enim molestias omnis perspiciatis sunt tenetur assumenda beatae deserunt dolorem maxime mollitia quibusdam tempora http localhost 8000 blog test test 2 placeholder lorem ipsum dolor sit amet consectetur adipisicing elit est nobis placeat quaerat quos aliquam distinctio ea enim molestias omnis perspiciatis sunt tenetur assumenda beatae deserunt dolorem maxime mollitia quibusdam tempora test 3 placeholder lorem ipsum dolor sit amet consectetur adipisicing elit est nobis placeat quaerat quos aliquam distinctio ea enim molestias omnis perspiciatis sunt tenetur assumenda beatae deserunt dolorem maxime mollitia quibusdam tempora '),(2,'field',14,1,' test placeholder lorem ipsum dolor sit amet consectetur adipisicing elit est nobis placeat quaerat quos aliquam distinctio ea enim molestias omnis perspiciatis sunt tenetur assumenda beatae deserunt dolorem maxime mollitia quibusdam tempora '),(11,'field',12,1,' placeholder '),(11,'field',10,1,' test 1 '),(11,'field',11,1,' lorem ipsum dolor sit amet consectetur adipisicing elit est nobis placeat quaerat quos aliquam distinctio ea enim molestias omnis perspiciatis sunt tenetur assumenda beatae deserunt dolorem maxime mollitia quibusdam tempora '),(11,'field',13,1,' http localhost 8000 blog test '),(11,'slug',0,1,''),(12,'field',12,1,' placeholder '),(12,'field',10,1,' test 2 '),(12,'field',11,1,' lorem ipsum dolor sit amet consectetur adipisicing elit est nobis placeat quaerat quos aliquam distinctio ea enim molestias omnis perspiciatis sunt tenetur assumenda beatae deserunt dolorem maxime mollitia quibusdam tempora '),(12,'field',13,1,' http localhost 8000 blog test '),(12,'slug',0,1,''),(13,'field',12,1,' placeholder '),(13,'field',10,1,' test 3 '),(13,'field',11,1,' lorem ipsum dolor sit amet consectetur adipisicing elit est nobis placeat quaerat quos aliquam distinctio ea enim molestias omnis perspiciatis sunt tenetur assumenda beatae deserunt dolorem maxime mollitia quibusdam tempora '),(13,'field',13,1,''),(13,'slug',0,1,''),(14,'field',15,1,' test '),(14,'field',16,1,' lorem ipsum dolor sit amet consectetur adipisicing elit est nobis placeat quaerat quos aliquam distinctio ea enim molestias omnis perspiciatis sunt tenetur assumenda beatae deserunt dolorem maxime mollitia quibusdam tempora '),(14,'field',17,1,' placeholder '),(14,'slug',0,1,''),(4,'field',18,1,' lorem ipsum dolor sit amet consectetur adipisicing elit amet aspernatur excepturi maiores nam odit porro quas quo sapiente vel voluptatem est facilis ipsum molestiae necessitatibus neque nihil nisi obcaecati odit optio porro provident sunt tempora '),(4,'field',19,1,' placeholder '),(4,'field',20,1,' placeholder this blog post shows a few different types of content that s supported and styled with bootstrap basic typography images and code are all supported cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus aenean eu leo quam pellentesque ornare sem lacinia quam venenatis vestibulum sed posuere consectetur est at lobortis cras mattis consectetur purus sit amet fermentum curabitur blandit tempus porttitor nullam quis risus eget urna mollis ornare vel eu leo nullam id dolor id nibh ultricies vehicula ut id elit etiam porta sem malesuada magna mollis euismod cras mattis consectetur purus sit amet fermentum aenean lacinia bibendum nulla sed consectetur heading vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor duis mollis est non commodo luctus nisi erat porttitor ligula eget lacinia odio sem nec elit morbi leo risus porta ac consectetur ac vestibulum at eros sub heading cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus example code block aenean lacinia bibendum nulla sed consectetur etiam porta sem malesuada magna mollis euismod fusce dapibus tellus ac cursus commodo tortor mauris condimentum nibh ut fermentum massa sub heading cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus aenean lacinia bibendum nulla sed consectetur etiam porta sem malesuada magna mollis euismod fusce dapibus tellus ac cursus commodo tortor mauris condimentum nibh ut fermentum massa justo sit amet risus praesent commodo cursus magna vel scelerisque nisl consectetur et donec id elit non mi porta gravida at eget metus nulla vitae elit libero a pharetra augue donec ullamcorper nulla non metus auctor fringilla nulla vitae elit libero a pharetra augue vestibulum id ligula porta felis euismod semper cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus maecenas sed diam eget risus varius blandit sit amet non magna cras mattis consectetur purus sit amet fermentum sed posuere consectetur est at lobortis '),(15,'field',21,1,' placeholder '),(15,'slug',0,1,''),(16,'field',22,1,' this blog post shows a few different types of content that s supported and styled with bootstrap basic typography images and code are all supported cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus aenean eu leo quam pellentesque ornare sem lacinia quam venenatis vestibulum sed posuere consectetur est at lobortis cras mattis consectetur purus sit amet fermentum curabitur blandit tempus porttitor nullam quis risus eget urna mollis ornare vel eu leo nullam id dolor id nibh ultricies vehicula ut id elit etiam porta sem malesuada magna mollis euismod cras mattis consectetur purus sit amet fermentum aenean lacinia bibendum nulla sed consectetur heading vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor duis mollis est non commodo luctus nisi erat porttitor ligula eget lacinia odio sem nec elit morbi leo risus porta ac consectetur ac vestibulum at eros sub heading cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus example code block aenean lacinia bibendum nulla sed consectetur etiam porta sem malesuada magna mollis euismod fusce dapibus tellus ac cursus commodo tortor mauris condimentum nibh ut fermentum massa sub heading cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus aenean lacinia bibendum nulla sed consectetur etiam porta sem malesuada magna mollis euismod fusce dapibus tellus ac cursus commodo tortor mauris condimentum nibh ut fermentum massa justo sit amet risus praesent commodo cursus magna vel scelerisque nisl consectetur et donec id elit non mi porta gravida at eget metus nulla vitae elit libero a pharetra augue donec ullamcorper nulla non metus auctor fringilla nulla vitae elit libero a pharetra augue vestibulum id ligula porta felis euismod semper cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus maecenas sed diam eget risus varius blandit sit amet non magna cras mattis consectetur purus sit amet fermentum sed posuere consectetur est at lobortis '),(16,'slug',0,1,''),(3,'field',18,1,' lorem ipsum dolor sit amet consectetur adipisicing elit amet aspernatur excepturi maiores nam odit porro quas quo sapiente vel voluptatem est facilis ipsum molestiae necessitatibus neque nihil nisi obcaecati odit optio porro provident sunt tempora '),(3,'field',23,1,' blog ');
/*!40000 ALTER TABLE `searchindex` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sections` VALUES (1,NULL,'Home Page','homePage','single',1,1,'2019-03-03 20:13:38','2019-03-04 02:03:02',NULL,'55337af1-2367-47fe-8e26-422065e7bd6c'),(2,NULL,'Blog Listing','blogListing','single',1,1,'2019-03-03 20:29:01','2019-03-04 02:23:07',NULL,'79e07047-bb12-4550-b070-89b39c20d824'),(3,NULL,'Blog Posts','blogPosts','channel',1,1,'2019-03-03 20:44:37','2019-03-04 02:15:12',NULL,'9fe861ca-2dad-41bb-a592-ff24cdadeb26');
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sections_sites`
--

LOCK TABLES `sections_sites` WRITE;
/*!40000 ALTER TABLE `sections_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sections_sites` VALUES (1,1,1,1,'__home__','pages/home',1,'2019-03-03 20:13:38','2019-03-04 02:03:02','0c7d873f-2241-43c0-ba68-d6b4146bcc7b'),(2,2,1,1,'blog','pages/blogListing',1,'2019-03-03 20:29:01','2019-03-04 02:23:07','520d7c97-06d3-4a33-81f6-3e1aa956b99c'),(3,3,1,1,'blog/{slug}','pages/blogDetail',1,'2019-03-03 20:44:37','2019-03-04 02:15:12','d4d3bbf4-b0e9-4660-984a-f200012abbbd');
/*!40000 ALTER TABLE `sections_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sequences`
--

LOCK TABLES `sequences` WRITE;
/*!40000 ALTER TABLE `sequences` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `sequences` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `shunnedmessages`
--

LOCK TABLES `shunnedmessages` WRITE;
/*!40000 ALTER TABLE `shunnedmessages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `shunnedmessages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sitegroups`
--

LOCK TABLES `sitegroups` WRITE;
/*!40000 ALTER TABLE `sitegroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sitegroups` VALUES (1,'Craft Demo','2019-03-03 19:55:27','2019-03-03 19:55:27',NULL,'0c2edc31-fb81-4c3c-84b8-7e73a1a778f7');
/*!40000 ALTER TABLE `sitegroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sites`
--

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sites` VALUES (1,1,1,'Craft Demo','default','en-US',1,'@web',1,'2019-03-03 19:55:27','2019-03-03 19:55:27',NULL,'97f47ded-c397-4935-a907-f1e28344839c');
/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `structureelements`
--

LOCK TABLES `structureelements` WRITE;
/*!40000 ALTER TABLE `structureelements` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `structureelements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `structures`
--

LOCK TABLES `structures` WRITE;
/*!40000 ALTER TABLE `structures` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `structures` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `systemmessages`
--

LOCK TABLES `systemmessages` WRITE;
/*!40000 ALTER TABLE `systemmessages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `systemmessages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `taggroups`
--

LOCK TABLES `taggroups` WRITE;
/*!40000 ALTER TABLE `taggroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `taggroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `tokens`
--

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `usergroups`
--

LOCK TABLES `usergroups` WRITE;
/*!40000 ALTER TABLE `usergroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `usergroups_users`
--

LOCK TABLES `usergroups_users` WRITE;
/*!40000 ALTER TABLE `usergroups_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `usergroups_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpermissions`
--

LOCK TABLES `userpermissions` WRITE;
/*!40000 ALTER TABLE `userpermissions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `userpermissions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpermissions_usergroups`
--

LOCK TABLES `userpermissions_usergroups` WRITE;
/*!40000 ALTER TABLE `userpermissions_usergroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `userpermissions_usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpermissions_users`
--

LOCK TABLES `userpermissions_users` WRITE;
/*!40000 ALTER TABLE `userpermissions_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `userpermissions_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpreferences`
--

LOCK TABLES `userpreferences` WRITE;
/*!40000 ALTER TABLE `userpreferences` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `userpreferences` VALUES (1,'{\"language\":\"en-US\"}');
/*!40000 ALTER TABLE `userpreferences` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `users` VALUES (1,'admin',NULL,NULL,NULL,'levi@mostlyserious.io','$2y$13$oBLAHL91eSlhz8UP8gEvQ.9bMSOWyJfIaPneuXFmFFV5FJ58RLxQ2',1,0,0,0,'2019-03-04 01:39:35',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,'2019-03-03 19:55:28','2019-03-03 19:55:28','2019-03-04 01:39:35','139efe80-2cf2-41b8-ae77-bb9066921c98');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `volumefolders`
--

LOCK TABLES `volumefolders` WRITE;
/*!40000 ALTER TABLE `volumefolders` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `volumefolders` VALUES (1,NULL,1,'Public','','2019-03-04 00:09:48','2019-03-04 00:35:33','451ea40f-d4a6-4ac7-b0a0-f4abb0e09679'),(2,NULL,NULL,'Temporary source',NULL,'2019-03-04 00:10:01','2019-03-04 00:10:01','ec2567a4-c5b9-4c9a-b08d-7e8e76ace53e'),(3,2,NULL,'user_1','user_1/','2019-03-04 00:10:02','2019-03-04 00:10:02','6b25ad42-1468-4069-878a-64840817ecd7');
/*!40000 ALTER TABLE `volumefolders` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `volumes`
--

LOCK TABLES `volumes` WRITE;
/*!40000 ALTER TABLE `volumes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `volumes` VALUES (1,NULL,'Public','public','craft\\volumes\\Local',1,'@web/assets','{\"path\":\"@root/web/assets\"}',1,'2019-03-04 00:09:48','2019-03-04 00:35:33',NULL,'18580cf9-0fba-4a6f-8934-e1776f0e2149');
/*!40000 ALTER TABLE `volumes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `widgets`
--

LOCK TABLES `widgets` WRITE;
/*!40000 ALTER TABLE `widgets` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `widgets` VALUES (1,1,'craft\\widgets\\RecentEntries',1,NULL,'{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}',1,'2019-03-03 20:07:05','2019-03-03 20:07:05','7f1cfaef-3010-410f-833b-448a9190ae1d'),(2,1,'craft\\widgets\\CraftSupport',2,NULL,'[]',1,'2019-03-03 20:07:05','2019-03-03 20:07:05','ab1b3b07-40d7-45fe-9023-29d3fd4e78fb'),(3,1,'craft\\widgets\\Updates',3,NULL,'[]',1,'2019-03-03 20:07:05','2019-03-03 20:07:05','3c9a0dec-d8d1-404f-a64c-2e122bc6de48'),(4,1,'craft\\widgets\\Feed',4,NULL,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2019-03-03 20:07:05','2019-03-03 20:07:05','122927eb-9577-452e-99ec-6bb5d4975a21');
/*!40000 ALTER TABLE `widgets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping routines for database 'craftdemo'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-03-03 20:29:59
