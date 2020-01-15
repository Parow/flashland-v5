-- --------------------------------------------------------
-- Hôte :                        localhost
-- Version du serveur:           5.7.24 - MySQL Community Server (GPL)
-- SE du serveur:                Win64
-- HeidiSQL Version:             10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Listage de la structure de la base pour flashland
CREATE DATABASE IF NOT EXISTS `flashland` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `flashland`;

-- Listage de la structure de la table flashland. banking_account
CREATE TABLE IF NOT EXISTS `banking_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(50) NOT NULL DEFAULT '0',
  `uuid` varchar(255) NOT NULL DEFAULT '0',
  `coowner` longtext,
  `amount` int(11) NOT NULL DEFAULT '0',
  `iban` longtext,
  `todayratio` varchar(255) DEFAULT '{"remove":0,"deposit":0,"maxRemove":5000,"maxDeposit":5000}',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Listage des données de la table flashland.banking_account : ~0 rows (environ)
/*!40000 ALTER TABLE `banking_account` DISABLE KEYS */;
INSERT INTO `banking_account` (`id`, `label`, `uuid`, `coowner`, `amount`, `iban`, `todayratio`) VALUES
	(1, 'Compte entreprise de la ferme', 'cf957a59-e5d2-4f2c-cfb5-834d03175d25x', 'cf957a59-e5d2-4f2c-cfb5-834d03175d25', 10400, '3', '{"remove":0,"deposit":0,"maxRemove":5000,"maxDeposit":5000}');
/*!40000 ALTER TABLE `banking_account` ENABLE KEYS */;

-- Listage de la structure de la table flashland. phone_app_chat
CREATE TABLE IF NOT EXISTS `phone_app_chat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel` varchar(20) NOT NULL,
  `message` varchar(255) NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Listage des données de la table flashland.phone_app_chat : ~0 rows (environ)
/*!40000 ALTER TABLE `phone_app_chat` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_app_chat` ENABLE KEYS */;

-- Listage de la structure de la table flashland. phone_calls
CREATE TABLE IF NOT EXISTS `phone_calls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(10) NOT NULL COMMENT 'Num tel proprio',
  `num` varchar(10) NOT NULL COMMENT 'Num reférence du contact',
  `incoming` int(11) NOT NULL COMMENT 'Défini si on est à l''origine de l''appels',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `accepts` int(11) NOT NULL COMMENT 'Appels accepter ou pas',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Listage des données de la table flashland.phone_calls : ~0 rows (environ)
/*!40000 ALTER TABLE `phone_calls` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_calls` ENABLE KEYS */;

-- Listage de la structure de la table flashland. phone_messages
CREATE TABLE IF NOT EXISTS `phone_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transmitter` varchar(10) NOT NULL,
  `receiver` varchar(10) NOT NULL,
  `message` varchar(255) NOT NULL DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isRead` int(11) NOT NULL DEFAULT '0',
  `owner` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=107 DEFAULT CHARSET=utf8;

-- Listage des données de la table flashland.phone_messages : 1 rows
/*!40000 ALTER TABLE `phone_messages` DISABLE KEYS */;
INSERT INTO `phone_messages` (`id`, `transmitter`, `receiver`, `message`, `time`, `isRead`, `owner`) VALUES
	(106, 'ambulance', '595-8708', 'help', '2019-07-16 22:02:32', 1, 1);
/*!40000 ALTER TABLE `phone_messages` ENABLE KEYS */;

-- Listage de la structure de la table flashland. phone_users_contacts
CREATE TABLE IF NOT EXISTS `phone_users_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) CHARACTER SET utf8mb4 DEFAULT NULL,
  `number` varchar(10) CHARACTER SET utf8mb4 DEFAULT NULL,
  `display` varchar(64) CHARACTER SET utf8mb4 NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- Listage des données de la table flashland.phone_users_contacts : 0 rows
/*!40000 ALTER TABLE `phone_users_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_users_contacts` ENABLE KEYS */;

-- Listage de la structure de la table flashland. players_appartement
CREATE TABLE IF NOT EXISTS `players_appartement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `capacity` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `pos` varchar(255) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `indexx` int(11) DEFAULT NULL,
  `owner` varchar(255) DEFAULT NULL,
  `coowner` text,
  `table_index` int(11) DEFAULT NULL,
  `time` bigint(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Listage des données de la table flashland.players_appartement : ~0 rows (environ)
/*!40000 ALTER TABLE `players_appartement` DISABLE KEYS */;
INSERT INTO `players_appartement` (`id`, `capacity`, `name`, `pos`, `price`, `indexx`, `owner`, `coowner`, `table_index`, `time`) VALUES
	(2, '50KG', 'Palomino Avenue 20', '{"x":-702.70544433594,"y":-916.91204833984,"z":18.261242675781}', 500, 1, 'cf957a59-e5d2-4f2c-cfb5-834d03175d25', NULL, NULL, NULL);
/*!40000 ALTER TABLE `players_appartement` ENABLE KEYS */;

-- Listage de la structure de la table flashland. players_appearance
CREATE TABLE IF NOT EXISTS `players_appearance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `model` varchar(255) NOT NULL DEFAULT 'mp_m_freemode_01',
  `face` text,
  `outfit` text,
  `tattoo` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- Listage des données de la table flashland.players_appearance : ~0 rows (environ)
/*!40000 ALTER TABLE `players_appearance` DISABLE KEYS */;
INSERT INTO `players_appearance` (`id`, `uuid`, `model`, `face`, `outfit`, `tattoo`, `created_at`, `updated_at`) VALUES
	(1, '1ea322bf-0c9f-6010-ac9a-9188fe246e01', 'mp_m_freemode_01', '{"skinAspect":{"opacity":0.0,"style":0},"freckles":{"opacity":0.0,"style":0},"complexion":{"opacity":0.0,"style":0},"facial":{"hair":{"eyebrow":{"color":[2,2],"style":20,"opacity":1.0},"beard":{"color":[0,0],"style":2,"opacity":1.0}},"features":{"lips":{"thickness":0.5},"jaw":{"bone":{"width":0.5,"backLength":0.5}},"eye":{"opening":0.5},"neck":{"thickness":0.5},"nose":{"width":0.5,"peak":{"length":0.5,"height":0.5,"lowering":0.5},"bone":{"twist":0.5,"height":0.5}},"cheeks":{"width":0.5,"bone":{"width":0.5,"height":0.5}},"eyebrow":{"height":0.5,"forward":0.5},"chimp":{"bone":{"length":0.5,"lowering":0.5,"width":0.5},"hole":0.5}}},"eye":{"style":1},"face":{"mom":18,"dad":4},"skinMix":0.6,"model":"mp_m_freemode_01","chestHair":{"color":[0,0],"style":0,"opacity":0.0},"ageing":{"opacity":0.0,"style":0},"blemishes":{"opacity":0.0,"style":0},"hair":{"color":[0,0],"style":8},"resemblance":0.8,"makeup":{"color":[22,0],"style":65,"opacity":0.6},"lipstick":{"color":[0,0],"style":1,"opacity":0.98}}', '{"feet":{"id":12,"txt":4},"texture":{"id":0,"txt":0},"mask":{"id":0,"txt":0,"toggle":false},"undershirt":{"id":0,"txt":0},"watches":{"id":-1,"txt":0,"toggle":true},"body_armor":{"id":0,"txt":0},"legs":{"id":15,"txt":10},"bracelets":{"id":-1,"txt":0,"toggle":true},"ears":{"id":-1,"txt":0,"toggle":true},"hat":{"id":-1,"txt":0,"toggle":true},"accessories":{"id":0,"txt":0},"tops":{"id":0,"txt":2},"glasses":{"id":-1,"txt":0,"toggle":true},"backpacks":{"id":0,"txt":0},"torso":{"id":0,"txt":0}}', '{"neck":{"style":0,"dictionary":0},"arm":{"right":{"style":0,"dictionary":0},"left":{"style":0,"dictionary":0}},"head":{"style":0,"dictionary":0},"leg":{"right":{"style":0,"dictionary":0},"left":{"style":0,"dictionary":0}},"torso":{"chest":{"style":0,"dictionary":0},"belly":{"style":0,"dictionary":0},"back":{"style":0,"dictionary":0}}}', '2020-01-08 16:31:29', '2020-01-08 16:31:29');
/*!40000 ALTER TABLE `players_appearance` ENABLE KEYS */;

-- Listage de la structure de la table flashland. players_identity
CREATE TABLE IF NOT EXISTS `players_identity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `face_picutre` text NOT NULL,
  `first_name` text NOT NULL,
  `last_name` text NOT NULL,
  `birth_date` text NOT NULL,
  `origine` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- Listage des données de la table flashland.players_identity : ~0 rows (environ)
/*!40000 ALTER TABLE `players_identity` DISABLE KEYS */;
INSERT INTO `players_identity` (`id`, `uuid`, `face_picutre`, `first_name`, `last_name`, `birth_date`, `origine`, `created_at`, `updated_at`) VALUES
	(1, '1ea322bf-0c9f-6010-ac9a-9188fe246e01', 'N/A', 'x', 'x', 'x', 'x', '2020-01-08 16:31:29', '2020-01-08 16:31:29');
/*!40000 ALTER TABLE `players_identity` ENABLE KEYS */;

-- Listage de la structure de la table flashland. players_inventory
CREATE TABLE IF NOT EXISTS `players_inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `data` varchar(500) COLLATE utf8mb4_bin DEFAULT NULL,
  `label` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6833 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Listage des données de la table flashland.players_inventory : 19 rows
/*!40000 ALTER TABLE `players_inventory` DISABLE KEYS */;
INSERT INTO `players_inventory` (`id`, `uuid`, `name`, `data`, `label`) VALUES
	(5628, 'xxxxxxxxxxxxxx', 'ne pas delete', NULL, NULL),
	(6801, 'cf957a59-e5d2-4f2c-cfb5-834d03175d25', 'access', '{"ind":3,"sex":"male","var":2,"type":1,"equiped":false,"component":0}', 'Bonnet rasta'),
	(6803, 'cf957a59-e5d2-4f2c-cfb5-834d03175d25', 'access', '{"type":1,"sex":"male","var":6,"equiped":false,"ind":0,"component":7}', 'Bracelet large clouté (D.)'),
	(6802, 'cf957a59-e5d2-4f2c-cfb5-834d03175d25', 'access', '{"type":1,"sex":"male","var":8,"equiped":false,"ind":0,"component":1}', 'Lunettes de police marron'),
	(5732, 'cf957a59-e5d2-4f2c-cfb5-834d03175d25', 'kevlar', '{"var":1,"ind":1,"status":100,"serial":852973090}', NULL),
	(5773, 'cf957a59-e5d2-4f2c-cfb5-834d03175d25', 'pistol', '{"access":["COMPONENT_PISTOL_CLIP_02","COMPONENT_AT_PI_FLSH","COMPONENT_AT_PI_SUPP_02","COMPONENT_PISTOL_VARMOD_LUXE"],"serial":620741102,"tint":7}', NULL),
	(6774, 'cf957a59-e5d2-4f2c-cfb5-834d03175d25', 'pistol50', '{"tint":2,"access":["COMPONENT_AT_PI_FLSH","COMPONENT_AT_AR_SUPP_02","COMPONENT_PISTOL50_CLIP_02"],"serial":816134982}', NULL),
	(6810, 'cf957a59-e5d2-4f2c-cfb5-834d03175d25', 'access', '{"ind":0,"sex":"male","var":2,"type":1,"equiped":false,"component":0}', 'Bonnet noir'),
	(6811, 'cf957a59-e5d2-4f2c-cfb5-834d03175d25', 'access', '{"ind":0,"sex":"male","var":0,"type":1,"equiped":true,"component":6}', 'Montre bleue'),
	(6778, 'cf957a59-e5d2-4f2c-cfb5-834d03175d25', 'mask', '{"equiped":false,"component":1,"var":68,"ind":2}', 'Super stream'),
	(6831, '1ea322bf-0c9f-6010-ac9a-9188fe246e01', 'herse', 'null', NULL),
	(6832, '1ea322bf-0c9f-6010-ac9a-9188fe246e01', 'shield', 'null', NULL),
	(6829, '1ea318d8-4861-6170-7d8f-160e3c0f9b96', 'water', 'null', NULL),
	(6828, '1ea318d8-4861-6170-7d8f-160e3c0f9b96', 'water', 'null', NULL),
	(6827, '1ea318d8-4861-6170-7d8f-160e3c0f9b96', 'water', 'null', NULL),
	(6792, 'cf957a59-e5d2-4f2c-cfb5-834d03175d25', 'access', '{"type":1,"sex":"male","var":0,"equiped":false,"component":0,"ind":0}', 'Casque antibruit rouge'),
	(6807, 'cf957a59-e5d2-4f2c-cfb5-834d03175d25', 'clothe', '{"var":3,"sex":"male","component":11,"equiped":true,"ind":5,"type":0}', 'Survêtement rouge'),
	(6825, 'cf957a59-e5d2-4f2c-cfb5-834d03175d25', 'cafe', 'null', NULL),
	(6826, 'cf957a59-e5d2-4f2c-cfb5-834d03175d25', 'cafe', 'null', NULL);
/*!40000 ALTER TABLE `players_inventory` ENABLE KEYS */;

-- Listage de la structure de la table flashland. players_jobs
CREATE TABLE IF NOT EXISTS `players_jobs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `name` text NOT NULL,
  `rank` int(11) NOT NULL,
  `orga` text,
  `orga_rank` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- Listage des données de la table flashland.players_jobs : ~0 rows (environ)
/*!40000 ALTER TABLE `players_jobs` DISABLE KEYS */;
INSERT INTO `players_jobs` (`id`, `uuid`, `name`, `rank`, `orga`, `orga_rank`, `created_at`, `updated_at`) VALUES
	(1, '1ea322bf-0c9f-6010-ac9a-9188fe246e01', 'police', 6, NULL, NULL, '2020-01-08 16:31:29', '2020-01-08 16:31:29');
/*!40000 ALTER TABLE `players_jobs` ENABLE KEYS */;

-- Listage de la structure de la table flashland. players_needs
CREATE TABLE IF NOT EXISTS `players_needs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `food` int(11) NOT NULL,
  `drink` int(11) NOT NULL,
  `sickness` float DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Listage des données de la table flashland.players_needs : ~0 rows (environ)
/*!40000 ALTER TABLE `players_needs` DISABLE KEYS */;
/*!40000 ALTER TABLE `players_needs` ENABLE KEYS */;

-- Listage de la structure de la table flashland. players_parking
CREATE TABLE IF NOT EXISTS `players_parking` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `garage` varchar(50) NOT NULL DEFAULT '0',
  `vehicles` longtext NOT NULL,
  `uuid` varchar(255) NOT NULL DEFAULT '0',
  `label` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Listage des données de la table flashland.players_parking : ~0 rows (environ)
/*!40000 ALTER TABLE `players_parking` DISABLE KEYS */;
INSERT INTO `players_parking` (`id`, `garage`, `vehicles`, `uuid`, `label`) VALUES
	(5, 'Garage vigneron', '{"modSuspension":-1,"modShifterLeavers":-1,"health":1000,"modAirFilter":-1,"modArchCover":-1,"label":"Blade","modArmor":-1,"modSmokeEnabled":1,"modXenon":false,"plate":"47XQQ207","modSeats":-1,"modHydrolic":-1,"modXenonColor":255,"modDial":-1,"modExhaust":-1,"plateIndex":0,"modGrille":-1,"neonColor":[255,0,255],"modSpoilers":-1,"neonEnabled":[false,false,false,false],"modBackWheels":-1,"tyreSmokeColor":[255,255,255],"modAPlate":-1,"color1":93,"modRightFender":-1,"modSideSkirt":-1,"dirtLevel":3.0016775131226,"modHood":-1,"modPlateHolder":-1,"modEngineBlock":-1,"modFrontBumper":-1,"modAerials":-1,"modSpeakers":-1,"modTransmission":-1,"modLivery":-1,"modTrimB":-1,"modTrimA":-1,"modRearBumper":-1,"wheelColor":156,"modFender":-1,"modTank":-1,"modRoof":-1,"modTrunk":-1,"windowTint":-1,"modFrontWheels":-1,"modOrnaments":-1,"modVanityPlate":-1,"modStruts":-1,"modTurbo":false,"modBrakes":-1,"pearlescentColor":0,"modDoorSpeaker":-1,"model":-1205801634,"modDashboard":-1,"modSteeringWheel":-1,"modEngine":-1,"modFrame":-1,"modWindows":-1,"color2":95,"modHorns":-1,"wheels":1}', '0', 'Blade');
/*!40000 ALTER TABLE `players_parking` ENABLE KEYS */;

-- Listage de la structure de la table flashland. players_settings
CREATE TABLE IF NOT EXISTS `players_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `bind` text NOT NULL,
  `colors` text NOT NULL,
  `outfit` text NOT NULL,
  `farm_limit` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Listage des données de la table flashland.players_settings : ~0 rows (environ)
/*!40000 ALTER TABLE `players_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `players_settings` ENABLE KEYS */;

-- Listage de la structure de la table flashland. players_vehicles
CREATE TABLE IF NOT EXISTS `players_vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) DEFAULT NULL,
  `settings` longtext,
  `data` longtext NOT NULL,
  `pound` tinyint(1) DEFAULT '0',
  `label` varchar(50) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Listage des données de la table flashland.players_vehicles : ~0 rows (environ)
/*!40000 ALTER TABLE `players_vehicles` DISABLE KEYS */;
INSERT INTO `players_vehicles` (`id`, `uuid`, `settings`, `data`, `pound`, `label`, `created_at`, `updated_at`) VALUES
	(1, 'x', '{}', '{}', 0, NULL, '2020-01-10 21:32:22', '2020-01-10 21:32:24');
/*!40000 ALTER TABLE `players_vehicles` ENABLE KEYS */;

-- Listage de la structure de la table flashland. players_weapon
CREATE TABLE IF NOT EXISTS `players_weapon` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `serial` int(11) NOT NULL DEFAULT '0',
  `weapon_name` int(11) NOT NULL DEFAULT '0',
  `user` varchar(255) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Listage des données de la table flashland.players_weapon : ~0 rows (environ)
/*!40000 ALTER TABLE `players_weapon` DISABLE KEYS */;
/*!40000 ALTER TABLE `players_weapon` ENABLE KEYS */;

-- Listage de la structure de la table flashland. server_logs
CREATE TABLE IF NOT EXISTS `server_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Listage des données de la table flashland.server_logs : ~0 rows (environ)
/*!40000 ALTER TABLE `server_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `server_logs` ENABLE KEYS */;

-- Listage de la structure de la table flashland. storages_inventory_accounts
CREATE TABLE IF NOT EXISTS `storages_inventory_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `money` int(11) NOT NULL DEFAULT '0',
  `dark_money` int(11) NOT NULL DEFAULT '0',
  `type` int(11) NOT NULL DEFAULT '0',
  `name` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Listage des données de la table flashland.storages_inventory_accounts : 12 rows
/*!40000 ALTER TABLE `storages_inventory_accounts` DISABLE KEYS */;
INSERT INTO `storages_inventory_accounts` (`id`, `money`, `dark_money`, `type`, `name`, `created_at`, `updated_at`) VALUES
	(5, 999941, 0, 1, '84mef027', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
	(7, 34400000, 34925, 1, '66rfh064', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
	(8, 370, 5500, 1, 'coffre1', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
	(9, 500, 0, 1, 'lspdarme', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
	(10, 500, 0, 1, '143334', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
	(11, 5000, 0, 1, 'property_24', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
	(12, 0, 0, 0, '1039032026|62TND776', '2019-12-21 23:42:56', '2019-12-21 23:42:56'),
	(13, 701, 0, 0, '970598228|69FHP771', '2019-12-22 00:18:52', '2019-12-22 00:18:52'),
	(14, 0, 0, 0, 'ltd_storage', '2020-01-02 17:51:48', '2020-01-02 17:51:48'),
	(15, 0, 0, 0, 'coffre_storage', '2020-01-02 18:03:13', '2020-01-02 18:03:13'),
	(16, 0, 0, 0, '_storage', '2020-01-02 18:07:48', '2020-01-02 18:07:48'),
	(17, 0, 0, 0, 'Palomino Avenue 20_storage', '2020-01-06 00:19:44', '2020-01-06 00:19:44');
/*!40000 ALTER TABLE `storages_inventory_accounts` ENABLE KEYS */;

-- Listage de la structure de la table flashland. storages_inventory_items
CREATE TABLE IF NOT EXISTS `storages_inventory_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `itemName` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `metadata` varchar(255) COLLATE utf8mb4_bin DEFAULT '{}',
  `label` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=703 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Listage des données de la table flashland.storages_inventory_items : 50 rows
/*!40000 ALTER TABLE `storages_inventory_items` DISABLE KEYS */;
INSERT INTO `storages_inventory_items` (`id`, `name`, `itemName`, `metadata`, `label`, `type`) VALUES
	(467, 'lspdarme', 'pistolcombat', '{"num":1696197,"type":"weapon"}', NULL, 1),
	(460, '86zgn968', 'kevlar', '{"skin":[2,1],"type":"kevlar","protect":50}', NULL, 1),
	(459, '86zgn968', 'kevlar', '{"skin":[2,1],"type":"kevlar","protect":50}', NULL, 1),
	(458, '86zgn968', 'flaregun', '{"access":[],"tint":3,"type":"weapon","num":1425140}', NULL, 1),
	(456, '66rfh064', 'water', '{}', NULL, 1),
	(457, '86zgn968', 'pistolmk2', '{"type":"weapon","num":1225097}', NULL, 1),
	(454, '45muz061', 'cola', '{}', NULL, 1),
	(453, '22ugf383', 'cola', '{}', NULL, 1),
	(464, 'lspdarme', 'cola', '{}', NULL, 1),
	(465, 'lspdarme', 'cola', '{}', NULL, 1),
	(468, 'lspdarme', 'pistolcombat', '{"num":1696197,"type":"weapon"}', NULL, 1),
	(498, '89qnk449', 'objets', NULL, NULL, 1),
	(544, '816921657', 'bread', NULL, NULL, 1),
	(540, 'vlife', 'objets', NULL, NULL, 1),
	(539, 'vlife', 'objets', NULL, NULL, 1),
	(543, 'vlife', 'objets', NULL, 'thrhrhrh', 1),
	(532, 'vlife', 'objets', NULL, 'dldqkd', 1),
	(476, '133551', 'objets', NULL, NULL, 1),
	(477, '133551', 'objets', NULL, NULL, 1),
	(497, '89qnk449', 'objets', NULL, NULL, 1),
	(496, '89qnk449', 'objets', NULL, NULL, 1),
	(495, '89qnk449', 'objets', NULL, NULL, 1),
	(488, '133551', 'sac', '"{\\"id\\":133551}"', NULL, 1),
	(487, '143334', 'objets', NULL, NULL, 1),
	(545, 'vespucciboulevard10', 'clothe', '{"type":"top","skin":[190,7,15,0,6,0]}', 'Pull ras du cou logo Squash', 1),
	(531, '48ynj806', 'biere1', NULL, NULL, 1),
	(530, '48ynj806', 'pizza', NULL, NULL, 1),
	(529, '48ynj806', 'pizza', NULL, NULL, 1),
	(528, '48ynj806', 'pizza', NULL, NULL, 1),
	(527, '48ynj806', 'pizza', NULL, NULL, 1),
	(546, 'property_5', 'clothe', '{"skin":[7,0],"type":"pant"}', 'Pantalon de travail noir', 1),
	(547, 'property_24', 'pizza', NULL, NULL, 1),
	(548, '42jff294', 'clothe', '{"skin":[7,0],"type":"pant"}', 'Pantalon de travail noir', 1),
	(549, '42jff294', 'clothe', '{"type":"top","skin":[190,7,15,0,6,0]}', 'Pull ras du cou logo Squash', 1),
	(550, '42jff294', 'clothe', '{"skin":[1,0],"type":"shoes"}', 'Skate noires', 1),
	(551, '42jff294', 'clothe', '{"type":"top","skin":[190,7,15,0,6,0]}', 'Pull ras du cou logo Squash', 1),
	(552, '42jff294', 'clothe', '{"skin":[1,0],"type":"shoes"}', 'Skate noires', 1),
	(553, '42jff294', 'clothe', '{"skin":[7,0],"type":"pant"}', 'Pantalon de travail noir', 1),
	(554, '42jff294', 'clothe', '{"skin":[9,2],"type":"shoes"}', 'Baskets noires', 1),
	(555, '42jff294', 'clothe', '{"skin":[13,0],"type":"pant"}', 'Baggy noir', 1),
	(556, '42jff294', 'tenue', '{"chaus":25,"topcolor":0,"chausscolor":0,"pant":38,"accesscolor":-1,"unders":15,"tops":65,"pantcolor":0,"underscolor":0,"access":-1,"torso":17}', 'Tenue de services', 1),
	(557, '42jff294', 'tenue', '{"chausscolor":0,"pantcolor":0,"pant":38,"torso":17,"unders":15,"accesscolor":-1,"tops":65,"underscolor":0,"chaus":25,"topcolor":0,"access":-1}', 'Tenue LSPD', 1),
	(558, '42jff294', 'tenue', '{"chausscolor":0,"pantcolor":0,"pant":38,"torso":17,"unders":15,"accesscolor":-1,"tops":65,"underscolor":0,"chaus":25,"topcolor":0,"access":-1}', 'Tenue LSPD', 1),
	(559, '42jff294', 'tenue', '{"torso":19,"unders":58,"tops":55,"access":-1,"pant":35,"accesscolor":-1,"chausscolor":0,"pantcolor":0,"chaus":51,"underscolor":0,"topcolor":0}', NULL, 1),
	(560, '42jff294', 'tenue', '{"access":-1,"pant":35,"underscolor":0,"accesscolor":-1,"unders":58,"tops":55,"torso":19,"chausscolor":0,"pantcolor":0,"topcolor":0,"chaus":51}', NULL, 1),
	(561, '42jff294', 'clothe', '{"skin":[220,24,15,0,4,0],"type":"top"}', 'Haut de combat rouge', 1),
	(565, '1039032026|62TND776', 'cana', 'null', NULL, NULL),
	(566, '1039032026|62TND776', 'cana', 'null', NULL, NULL),
	(567, '1039032026|62TND776', 'cana', 'null', NULL, NULL),
	(568, '1039032026|62TND776', 'cana', 'null', NULL, NULL);
/*!40000 ALTER TABLE `storages_inventory_items` ENABLE KEYS */;

-- Listage de la structure de la table flashland. users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `position` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `food` int(11) DEFAULT '100',
  `thirst` int(11) DEFAULT '100',
  `is_active` int(11) NOT NULL DEFAULT '1',
  `money` int(11) DEFAULT '1500',
  `black_money` int(11) DEFAULT '0',
  `permission_level` int(11) DEFAULT '0',
  `xp` int(11) DEFAULT '0',
  `group` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Listage des données de la table flashland.users : ~1 rows (environ)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `identifier`, `uuid`, `position`, `food`, `thirst`, `is_active`, `money`, `black_money`, `permission_level`, `xp`, `group`, `created_at`, `updated_at`) VALUES
	(1, 'steam:11000010ca951f2', '1ea322bf-0c9f-6010-ac9a-9188fe246e01', '{"x":134.97924804688,"y":-1709.0495605469,"z":29.291618347168,"heading":355.88940429688}', 100, 100, 0, 5099270, 0, 0, NULL, NULL, '2020-01-08 16:31:29', '2020-01-11 18:52:59');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Listage de la structure de la table flashland. whitelist
CREATE TABLE IF NOT EXISTS `whitelist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` text NOT NULL,
  `character_count` int(11) NOT NULL DEFAULT '0',
  `character_limit` int(1) NOT NULL DEFAULT '1',
  `permanent_ban` tinyint(1) DEFAULT '0',
  `ban_expire_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;

-- Listage des données de la table flashland.whitelist : ~9 rows (environ)
/*!40000 ALTER TABLE `whitelist` DISABLE KEYS */;
INSERT INTO `whitelist` (`id`, `identifier`, `character_count`, `character_limit`, `permanent_ban`, `ban_expire_at`) VALUES
	(2, 'steam:11000010ca951f2 ', 1, 1, 0, NULL),
	(3, 'steam:11000013690cc62', 0, 1, 0, NULL),
	(4, 'steam:11000010c519b4e', 0, 1, 0, NULL),
	(5, 'steam:11000011cfab7f2', 0, 1, 0, NULL),
	(6, 'steam:1100001188ca584', 0, 1, 0, NULL),
	(7, 'steam:1100001187ca5a0', 0, 1, 0, NULL),
	(8, 'steam:11000010feb29a8', 0, 1, 0, NULL),
	(9, 'steam:11000010968d772', 0, 1, 0, NULL),
	(10, 'steam:110000107b72515', 0, 1, 0, NULL),
	(11, 'steam:1100001344209f9', 0, 1, 0, NULL);
/*!40000 ALTER TABLE `whitelist` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
