-- phpMyAdmin SQL Dump
-- version 3.4.10.1deb1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tempo de Geração: 17/03/2017 às 11h09min
-- Versão do Servidor: 5.5.54
-- Versão do PHP: 5.3.10-1ubuntu3.26

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Banco de Dados: `sda`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `accounts`
--

CREATE TABLE IF NOT EXISTS `accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '',
  `password` varchar(255) NOT NULL,
  `salt` varchar(40) NOT NULL DEFAULT '',
  `premdays` int(11) NOT NULL DEFAULT '0',
  `lastpremdays` int(11) NOT NULL DEFAULT '0',
  `lastday` int(10) unsigned NOT NULL DEFAULT '0',
  `email` varchar(255) NOT NULL DEFAULT '',
  `key` varchar(20) NOT NULL DEFAULT '0',
  `blocked` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'internal usage',
  `warnings` int(11) NOT NULL DEFAULT '0',
  `group_id` int(11) NOT NULL DEFAULT '1',
  `vip_time` int(15) NOT NULL,
  `page_lastday` int(11) NOT NULL,
  `email_new` varchar(255) NOT NULL,
  `email_new_time` int(15) NOT NULL,
  `created` int(11) NOT NULL DEFAULT '0',
  `rlname` varchar(255) NOT NULL DEFAULT '',
  `location` varchar(255) NOT NULL DEFAULT '',
  `page_access` int(11) NOT NULL DEFAULT '0',
  `email_code` varchar(255) NOT NULL DEFAULT '0',
  `next_email` int(11) NOT NULL DEFAULT '0',
  `premium_points` int(11) NOT NULL DEFAULT '0',
  `vote` int(11) NOT NULL,
  `last_post` int(11) NOT NULL DEFAULT '0',
  `flag` varchar(255) NOT NULL,
  `loot_time` int(15) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9691165 ;

--
-- Extraindo dados da tabela `accounts`
--

INSERT INTO `accounts` (`id`, `name`, `password`, `salt`, `premdays`, `lastpremdays`, `lastday`, `email`, `key`, `blocked`, `warnings`, `group_id`, `vip_time`, `page_lastday`, `email_new`, `email_new_time`, `created`, `rlname`, `location`, `page_access`, `email_code`, `next_email`, `premium_points`, `vote`, `last_post`, `flag`, `loot_time`) VALUES
(1, '1', '1', '', 65535, 0, 0, '', 'b6589fc6ab0dc82cf120', 0, 0, 1, 1314226342, 1313937843, '', 0, 0, '', '', 6, '0', 0, 5854, 0, 0, '', 0),
(9691164, 'god', 'styller', '', 0, 0, 0, '', '0', 0, 0, 1, 0, 0, '', 0, 0, '', '', 0, '0', 0, 0, 0, 0, '', 0);

--
-- Gatilhos `accounts`
--
DROP TRIGGER IF EXISTS `ondelete_accounts`;
DELIMITER //
CREATE TRIGGER `ondelete_accounts` BEFORE DELETE ON `accounts`
 FOR EACH ROW BEGIN
DELETE FROM `bans` WHERE `type` IN (3, 4) AND `value` = OLD.`id`;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `account_viplist`
--

CREATE TABLE IF NOT EXISTS `account_viplist` (
  `account_id` int(11) NOT NULL,
  `world_id` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `player_id` int(11) NOT NULL,
  UNIQUE KEY `account_id_2` (`account_id`,`player_id`),
  KEY `account_id` (`account_id`),
  KEY `player_id` (`player_id`),
  KEY `world_id` (`world_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `auction_system`
--

CREATE TABLE IF NOT EXISTS `auction_system` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player` int(11) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `item_name` varchar(255) DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  `cost` int(11) DEFAULT NULL,
  `date` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `bans`
--

CREATE TABLE IF NOT EXISTS `bans` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) NOT NULL COMMENT '1 - ip banishment, 2 - namelock, 3 - account banishment, 4 - notation, 5 - deletion',
  `value` int(10) unsigned NOT NULL COMMENT 'ip address (integer), player guid or account number',
  `param` int(10) unsigned NOT NULL DEFAULT '4294967295' COMMENT 'used only for ip banishment mask (integer)',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `expires` int(11) NOT NULL,
  `added` int(10) unsigned NOT NULL,
  `admin_id` int(10) unsigned NOT NULL DEFAULT '0',
  `comment` text NOT NULL,
  `reason` int(10) unsigned NOT NULL DEFAULT '0',
  `action` int(10) unsigned NOT NULL DEFAULT '0',
  `statement` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `type` (`type`,`value`),
  KEY `active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `death_list`
--

CREATE TABLE IF NOT EXISTS `death_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `date` bigint(20) unsigned NOT NULL,
  `level` int(11) NOT NULL,
  `killer_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `environment_killers`
--

CREATE TABLE IF NOT EXISTS `environment_killers` (
  `kill_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  KEY `kill_id` (`kill_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `global_storage`
--

CREATE TABLE IF NOT EXISTS `global_storage` (
  `key` int(10) unsigned NOT NULL,
  `world_id` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `value` varchar(255) NOT NULL DEFAULT '0',
  UNIQUE KEY `key` (`key`,`world_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `global_storage`
--

INSERT INTO `global_storage` (`key`, `world_id`, `value`) VALUES
(5001, 0, '1311040024'),
(7801, 0, '0'),
(7802, 0, '0'),
(24503, 0, '-1'),
(24504, 0, '1073747374'),
(24505, 0, '1073747375'),
(24506, 0, '1073747376'),
(24507, 0, '1073747377'),
(24508, 0, '1073747378'),
(24509, 0, '1073747379'),
(24510, 0, '1073747380');

-- --------------------------------------------------------

--
-- Estrutura da tabela `guilds`
--

CREATE TABLE IF NOT EXISTS `guilds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `world_id` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `ownerid` int(11) NOT NULL,
  `creationdata` int(11) NOT NULL,
  `checkdata` int(11) NOT NULL,
  `motd` varchar(255) NOT NULL,
  `balance` bigint(20) unsigned NOT NULL,
  `description` text NOT NULL,
  `logo_gfx_name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`world_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Gatilhos `guilds`
--
DROP TRIGGER IF EXISTS `oncreate_guilds`;
DELIMITER //
CREATE TRIGGER `oncreate_guilds` AFTER INSERT ON `guilds`
 FOR EACH ROW BEGIN
INSERT INTO `guild_ranks` (`name`, `level`, `guild_id`) VALUES ('Leader', 3, NEW.`id`);
INSERT INTO `guild_ranks` (`name`, `level`, `guild_id`) VALUES ('Vice-Leader', 2, NEW.`id`);
INSERT INTO `guild_ranks` (`name`, `level`, `guild_id`) VALUES ('Member', 1, NEW.`id`);
END
//
DELIMITER ;
DROP TRIGGER IF EXISTS `ondelete_guilds`;
DELIMITER //
CREATE TRIGGER `ondelete_guilds` BEFORE DELETE ON `guilds`
 FOR EACH ROW BEGIN
UPDATE `players` SET `guildnick` = '', `rank_id` = 0 WHERE `rank_id` IN (SELECT `id` FROM `guild_ranks` WHERE `guild_id` = OLD.`id`);
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `guild_invites`
--

CREATE TABLE IF NOT EXISTS `guild_invites` (
  `player_id` int(11) NOT NULL DEFAULT '0',
  `guild_id` int(11) NOT NULL DEFAULT '0',
  UNIQUE KEY `player_id` (`player_id`,`guild_id`),
  KEY `guild_id` (`guild_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `guild_kills`
--

CREATE TABLE IF NOT EXISTS `guild_kills` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `guild_id` int(11) NOT NULL,
  `war_id` int(11) NOT NULL,
  `death_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `guild_kills_ibfk_1` (`war_id`),
  KEY `guild_kills_ibfk_2` (`death_id`),
  KEY `guild_kills_ibfk_3` (`guild_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `guild_ranks`
--

CREATE TABLE IF NOT EXISTS `guild_ranks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `guild_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `level` int(11) NOT NULL COMMENT '1 - leader, 2 - vice leader, 3 - member',
  PRIMARY KEY (`id`),
  KEY `guild_id` (`guild_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `guild_wars`
--

CREATE TABLE IF NOT EXISTS `guild_wars` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `guild_id` int(11) NOT NULL,
  `enemy_id` int(11) NOT NULL,
  `begin` bigint(20) NOT NULL DEFAULT '0',
  `end` bigint(20) NOT NULL DEFAULT '0',
  `frags` int(10) unsigned NOT NULL DEFAULT '0',
  `payment` bigint(20) unsigned NOT NULL DEFAULT '0',
  `guild_kills` int(10) unsigned NOT NULL DEFAULT '0',
  `enemy_kills` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `guild_id` (`guild_id`),
  KEY `enemy_id` (`enemy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `houses`
--

CREATE TABLE IF NOT EXISTS `houses` (
  `id` int(10) unsigned NOT NULL,
  `world_id` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `owner` int(11) NOT NULL,
  `paid` int(10) unsigned NOT NULL DEFAULT '0',
  `warnings` int(11) NOT NULL DEFAULT '0',
  `lastwarning` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `town` int(10) unsigned NOT NULL DEFAULT '0',
  `size` int(10) unsigned NOT NULL DEFAULT '0',
  `price` int(10) unsigned NOT NULL DEFAULT '0',
  `rent` int(10) unsigned NOT NULL DEFAULT '0',
  `doors` int(10) unsigned NOT NULL DEFAULT '0',
  `beds` int(10) unsigned NOT NULL DEFAULT '0',
  `tiles` int(10) unsigned NOT NULL DEFAULT '0',
  `guild` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `clear` tinyint(1) unsigned NOT NULL DEFAULT '0',
  UNIQUE KEY `id` (`id`,`world_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `houses`
--

INSERT INTO `houses` (`id`, `world_id`, `owner`, `paid`, `warnings`, `lastwarning`, `name`, `town`, `size`, `price`, `rent`, `doors`, `beds`, `tiles`, `guild`, `clear`) VALUES
(1, 0, 0, 0, 0, 0, 'Tower 1', 1, 99, 194000, 0, 1, 0, 194, 0, 0),
(1, 1, 0, 0, 0, 0, 'Tower 1', 1, 99, 194000, 0, 1, 0, 194, 0, 0),
(6, 0, 0, 0, 0, 0, 'GuildHouse Street', 1, 44, 80000, 0, 5, 0, 80, 0, 0),
(6, 1, 0, 0, 0, 0, 'GuildHouse Street', 1, 44, 80000, 0, 5, 0, 80, 0, 0),
(8, 0, 0, 0, 0, 0, 'Pirate Street', 0, 1, 1000, 0, 0, 0, 1, 0, 0),
(8, 1, 0, 0, 0, 0, 'Pirate Street', 0, 1, 1000, 0, 0, 0, 1, 0, 0),
(42, 0, 0, 0, 0, 0, 'Heavy Depot House', 1, 35, 61000, 0, 7, 0, 61, 0, 0),
(42, 1, 0, 0, 0, 0, 'Heavy Depot House', 1, 35, 63000, 0, 4, 0, 63, 0, 0),
(43, 0, 0, 0, 0, 0, 'Heavy Depot House II', 1, 57, 96000, 0, 2, 0, 96, 0, 0),
(43, 1, 0, 0, 0, 0, 'Heavy Depot House II', 1, 57, 96000, 0, 2, 0, 96, 0, 0),
(56, 0, 0, 0, 0, 0, 'Port house I', 1, 145, 252000, 0, 8, 0, 252, 0, 0),
(56, 1, 0, 0, 0, 0, 'Port house I', 1, 145, 258000, 0, 8, 0, 258, 0, 0),
(91, 0, 0, 0, 0, 0, 'Depot House III', 1, 32, 60000, 6578, 2, 0, 60, 0, 0),
(91, 1, 0, 0, 0, 0, 'Depot House III', 1, 32, 60000, 6578, 2, 0, 60, 0, 0),
(92, 0, 0, 0, 0, 0, 'Temple House V', 1, 15, 24000, 0, 1, 0, 24, 0, 0),
(92, 1, 0, 0, 0, 0, 'Temple House V', 1, 15, 24000, 0, 1, 0, 24, 0, 0),
(93, 0, 0, 0, 0, 0, 'Temple House VI', 1, 23, 28000, 0, 2, 0, 28, 0, 0),
(93, 1, 0, 0, 0, 0, 'Temple House VI', 1, 23, 31000, 0, 2, 0, 31, 0, 0),
(94, 0, 0, 0, 0, 0, 'Temple House VII', 1, 31, 38000, 0, 1, 0, 38, 0, 0),
(94, 1, 0, 0, 0, 0, 'Temple House VII', 1, 31, 38000, 0, 1, 0, 38, 0, 0),
(95, 0, 0, 0, 0, 0, 'Temple House VIII', 1, 28, 50000, 0, 1, 0, 50, 0, 0),
(95, 1, 0, 0, 0, 0, 'Temple House VIII', 1, 23, 28000, 0, 1, 0, 28, 0, 0),
(96, 0, 0, 0, 0, 0, 'Sub I', 1, 12, 40000, 0, 0, 2, 40, 0, 0),
(96, 1, 0, 0, 0, 0, 'Sub I', 1, 12, 40000, 0, 0, 2, 40, 0, 0),
(97, 0, 0, 0, 0, 0, 'Sub II', 1, 30, 47000, 0, 0, 2, 47, 0, 0),
(97, 1, 0, 0, 0, 0, 'Sub II', 1, 30, 47000, 0, 0, 2, 47, 0, 0),
(98, 0, 0, 0, 0, 0, 'Sub III', 1, 30, 44000, 0, 0, 2, 44, 0, 0),
(98, 1, 0, 0, 0, 0, 'Sub III', 1, 30, 44000, 0, 0, 2, 44, 0, 0),
(99, 0, 0, 0, 0, 0, 'Sub IV', 1, 28, 44000, 0, 0, 2, 44, 0, 0),
(99, 1, 0, 0, 0, 0, 'Sub IV', 1, 28, 44000, 0, 0, 2, 44, 0, 0),
(100, 0, 0, 0, 0, 0, 'Sub V', 1, 16, 28000, 0, 0, 2, 28, 0, 0),
(100, 1, 0, 0, 0, 0, 'Sub V', 1, 16, 28000, 0, 0, 2, 28, 0, 0),
(101, 0, 0, 0, 0, 0, 'Sub VI', 1, 22, 36000, 0, 1, 2, 36, 0, 0),
(101, 1, 0, 0, 0, 0, 'Sub VI', 1, 22, 36000, 0, 1, 2, 36, 0, 0),
(102, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 0, 0, 7, 0, 0),
(102, 1, 0, 0, 0, 0, '', 0, 6, 7000, 0, 0, 0, 7, 0, 0),
(119, 0, 0, 0, 0, 0, 'Pirate House', 1, 25, 63000, 5451, 1, 0, 63, 0, 0),
(119, 1, 0, 0, 0, 0, 'Pirate House', 1, 25, 63000, 5451, 1, 0, 63, 0, 0),
(120, 0, 0, 0, 0, 0, 'Blue House I', 4, 18, 29000, 0, 1, 0, 29, 0, 0),
(120, 1, 0, 0, 0, 0, 'Blue House I', 4, 18, 29000, 0, 1, 0, 29, 0, 0),
(121, 0, 0, 0, 0, 0, 'Blue House II', 4, 18, 33000, 0, 1, 0, 33, 0, 0),
(121, 1, 0, 0, 0, 0, 'Blue House II', 4, 18, 33000, 0, 1, 0, 33, 0, 0),
(122, 0, 0, 0, 0, 0, 'Blue House III', 4, 56, 59000, 0, 1, 0, 59, 0, 0),
(122, 1, 0, 0, 0, 0, 'Blue House III', 4, 56, 59000, 0, 1, 0, 59, 0, 0),
(123, 0, 0, 0, 0, 0, 'Blue House IV', 4, 27, 28000, 0, 1, 0, 28, 0, 0),
(123, 1, 0, 0, 0, 0, 'Blue House IV', 4, 27, 28000, 0, 1, 0, 28, 0, 0),
(124, 0, 0, 0, 0, 0, 'Blue House V', 4, 40, 41000, 0, 1, 0, 41, 0, 0),
(124, 1, 0, 0, 0, 0, 'Blue House V', 4, 40, 41000, 0, 1, 0, 41, 0, 0),
(125, 0, 0, 0, 0, 0, 'Blue House VI', 4, 24, 31000, 0, 1, 0, 31, 0, 0),
(125, 1, 0, 0, 0, 0, 'Blue House VI', 4, 24, 31000, 0, 1, 0, 31, 0, 0),
(126, 0, 0, 0, 0, 0, 'Blue House VII', 4, 18, 19000, 0, 1, 0, 19, 0, 0),
(126, 1, 0, 0, 0, 0, 'Blue House VII', 4, 18, 19000, 0, 1, 0, 19, 0, 0),
(128, 0, 0, 0, 0, 0, 'Blue House XX', 4, 31, 32000, 0, 1, 0, 32, 0, 0),
(128, 1, 0, 0, 0, 0, 'Blue House XX', 4, 31, 32000, 0, 1, 0, 32, 0, 0),
(129, 0, 0, 0, 0, 0, 'Blood House I', 1, 44, 80000, 0, 3, 0, 80, 0, 0),
(129, 1, 0, 0, 0, 0, 'Blood House I', 1, 44, 80000, 0, 3, 0, 80, 0, 0),
(133, 0, 0, 0, 0, 0, 'Blood House V', 1, 30, 48000, 0, 1, 0, 48, 0, 0),
(133, 1, 0, 0, 0, 0, 'Blood House V', 1, 30, 48000, 0, 1, 0, 48, 0, 0),
(137, 0, 0, 0, 0, 0, 'Blood House XX', 1, 25, 33000, 0, 3, 0, 33, 0, 0),
(137, 1, 0, 0, 0, 0, 'Blood House XX', 1, 25, 33000, 0, 3, 0, 33, 0, 0),
(139, 0, 0, 0, 0, 0, 'Blood House XXI', 1, 30, 43000, 0, 4, 0, 43, 0, 0),
(139, 1, 0, 0, 0, 0, 'Blood House XXI', 1, 30, 43000, 0, 4, 0, 43, 0, 0),
(140, 0, 0, 0, 0, 0, 'Blood House XXII', 1, 30, 42000, 0, 4, 0, 42, 0, 0),
(140, 1, 0, 0, 0, 0, 'Blood House XXII', 1, 30, 42000, 0, 4, 0, 42, 0, 0),
(141, 0, 0, 0, 0, 0, 'Blood House XXIII', 1, 25, 34000, 0, 3, 0, 34, 0, 0),
(141, 1, 0, 0, 0, 0, 'Blood House XXIII', 1, 25, 34000, 0, 3, 0, 34, 0, 0),
(209, 0, 0, 0, 0, 0, '15181', 0, 25, 47000, 0, 1, 0, 47, 0, 0),
(209, 1, 0, 0, 0, 0, '', 0, 25, 47000, 0, 1, 0, 47, 0, 0),
(210, 0, 0, 0, 0, 0, '111', 0, 20, 41000, 0, 1, 0, 41, 0, 0),
(210, 1, 0, 0, 0, 0, '', 0, 20, 41000, 0, 1, 0, 41, 0, 0),
(211, 0, 0, 0, 0, 0, '99898', 0, 25, 49000, 0, 1, 0, 49, 0, 0),
(211, 1, 0, 0, 0, 0, '', 0, 25, 49000, 0, 1, 0, 49, 0, 0),
(212, 0, 0, 0, 0, 0, '4874181', 0, 24, 48000, 0, 1, 0, 48, 0, 0),
(212, 1, 0, 0, 0, 0, '', 0, 24, 48000, 0, 1, 0, 48, 0, 0),
(213, 0, 0, 0, 0, 0, '12334', 0, 24, 40000, 0, 1, 0, 40, 0, 0),
(213, 1, 0, 0, 0, 0, '', 0, 24, 40000, 0, 1, 0, 40, 0, 0),
(214, 0, 0, 0, 0, 0, '1581481', 0, 24, 39000, 0, 1, 0, 39, 0, 0),
(214, 1, 0, 0, 0, 0, '', 0, 24, 39000, 0, 1, 0, 39, 0, 0),
(215, 0, 0, 0, 0, 0, '1818180', 0, 24, 28000, 0, 1, 0, 28, 0, 0),
(215, 1, 0, 0, 0, 0, '', 0, 24, 28000, 0, 1, 0, 28, 0, 0),
(216, 0, 0, 0, 0, 0, 'adcaca', 0, 72, 128000, 0, 6, 0, 128, 0, 0),
(216, 1, 0, 0, 0, 0, '', 0, 72, 128000, 0, 6, 0, 128, 0, 0),
(217, 0, 0, 0, 0, 0, '158191', 0, 35, 41000, 0, 1, 0, 41, 0, 0),
(217, 1, 0, 0, 0, 0, '', 0, 35, 41000, 0, 1, 0, 41, 0, 0),
(218, 0, 0, 0, 0, 0, '2343', 0, 20, 40000, 0, 1, 0, 40, 0, 0),
(218, 1, 0, 0, 0, 0, '', 0, 20, 40000, 0, 1, 0, 40, 0, 0),
(219, 0, 0, 0, 0, 0, '34232', 0, 20, 35000, 0, 1, 0, 35, 0, 0),
(219, 1, 0, 0, 0, 0, '', 0, 20, 35000, 0, 1, 0, 35, 0, 0),
(220, 0, 0, 0, 0, 0, '32424', 0, 20, 42000, 0, 1, 0, 42, 0, 0),
(220, 1, 0, 0, 0, 0, '', 0, 20, 42000, 0, 1, 0, 42, 0, 0),
(221, 0, 0, 0, 0, 0, '234234', 0, 85, 113000, 0, 1, 0, 113, 0, 0),
(221, 1, 0, 0, 0, 0, '', 0, 85, 113000, 0, 1, 0, 113, 0, 0),
(222, 0, 0, 0, 0, 0, '3244242', 0, 59, 85000, 0, 2, 0, 85, 0, 0),
(222, 1, 0, 0, 0, 0, '', 0, 59, 85000, 0, 2, 0, 85, 0, 0),
(223, 0, 0, 0, 0, 0, '2342422', 0, 42, 45000, 0, 1, 0, 45, 0, 0),
(223, 1, 0, 0, 0, 0, '', 0, 42, 45000, 0, 1, 0, 45, 0, 0),
(224, 0, 0, 0, 0, 0, '2342342', 0, 85, 106000, 0, 1, 0, 106, 0, 0),
(224, 1, 0, 0, 0, 0, '', 0, 85, 106000, 0, 1, 0, 106, 0, 0),
(225, 0, 0, 0, 0, 0, '23424221', 0, 98, 115000, 0, 1, 0, 115, 0, 0),
(225, 1, 0, 0, 0, 0, '', 0, 98, 115000, 0, 1, 0, 115, 0, 0),
(569, 0, 0, 0, 0, 0, 'Svargrond I', 5, 65, 107000, 0, 7, 8, 107, 0, 0),
(569, 1, 0, 0, 0, 0, 'Svargrond I', 5, 65, 107000, 0, 7, 8, 107, 0, 0),
(570, 0, 0, 0, 0, 0, 'Svargrond Guild House II', 5, 27, 63000, 0, 6, 8, 63, 0, 0),
(570, 1, 0, 0, 0, 0, 'Svargrond Guild House II', 5, 27, 63000, 0, 6, 8, 63, 0, 0),
(571, 0, 0, 0, 0, 0, 'Svargrond III', 5, 77, 125000, 0, 9, 6, 125, 0, 0),
(571, 1, 0, 0, 0, 0, 'Svargrond III', 5, 77, 125000, 0, 9, 6, 125, 0, 0),
(572, 0, 0, 0, 0, 0, 'Svargrond IV', 5, 48, 98000, 0, 10, 4, 98, 0, 0),
(572, 1, 0, 0, 0, 0, 'Svargrond IV', 5, 48, 98000, 0, 10, 4, 98, 0, 0),
(573, 0, 0, 0, 0, 0, 'Svargrond V', 5, 55, 92000, 0, 7, 4, 92, 0, 0),
(573, 1, 0, 0, 0, 0, 'Svargrond V', 5, 55, 92000, 0, 7, 4, 92, 0, 0),
(574, 0, 0, 0, 0, 0, 'Svargrond Guild House VI', 5, 91, 206000, 0, 12, 40, 206, 0, 0),
(574, 1, 0, 0, 0, 0, 'Svargrond Guild House VI', 5, 91, 206000, 0, 12, 40, 206, 0, 0),
(575, 0, 0, 0, 0, 0, 'Svargrond VII', 5, 32, 55000, 0, 2, 4, 55, 0, 0),
(575, 1, 0, 0, 0, 0, 'Svargrond VII', 5, 32, 55000, 0, 2, 4, 55, 0, 0),
(576, 0, 0, 0, 0, 0, 'Svargrond VIII', 5, 46, 69000, 0, 5, 0, 69, 0, 0),
(576, 1, 0, 0, 0, 0, 'Svargrond VIII', 5, 46, 69000, 0, 5, 0, 69, 0, 0),
(577, 0, 0, 0, 0, 0, 'Svargrond IX', 5, 61, 96000, 0, 7, 4, 96, 0, 0),
(577, 1, 0, 0, 0, 0, 'Svargrond IX', 5, 61, 96000, 0, 7, 4, 96, 0, 0),
(578, 0, 0, 0, 0, 0, 'Svargrond X', 5, 22, 40000, 0, 4, 2, 40, 0, 0),
(578, 1, 0, 0, 0, 0, 'Svargrond X', 5, 22, 40000, 0, 4, 2, 40, 0, 0),
(579, 0, 0, 0, 0, 0, 'Svargrond XI', 5, 51, 94000, 0, 8, 6, 94, 0, 0),
(579, 1, 0, 0, 0, 0, 'Svargrond XI', 5, 51, 94000, 0, 8, 6, 94, 0, 0),
(580, 0, 0, 0, 0, 0, 'Svargrond XII', 5, 23, 42000, 0, 3, 2, 42, 0, 0),
(580, 1, 0, 0, 0, 0, 'Svargrond XII', 5, 23, 42000, 0, 3, 2, 42, 0, 0),
(581, 0, 0, 0, 0, 0, 'Svargrond XIII', 5, 18, 39000, 0, 3, 2, 39, 0, 0),
(581, 1, 0, 0, 0, 0, 'Svargrond XIII', 5, 18, 39000, 0, 3, 2, 39, 0, 0),
(584, 0, 0, 0, 0, 0, 'Svargrond XXI', 5, 61, 105000, 0, 5, 6, 105, 0, 0),
(584, 1, 0, 0, 0, 0, 'Svargrond XXI', 5, 61, 105000, 0, 5, 6, 105, 0, 0),
(585, 0, 0, 0, 0, 0, 'Svargrond XXII', 5, 23, 44000, 0, 5, 4, 44, 0, 0),
(585, 1, 0, 0, 0, 0, 'Svargrond XXII', 5, 23, 44000, 0, 5, 4, 44, 0, 0),
(586, 0, 0, 0, 0, 0, 'Svargrond XXIII', 5, 74, 123000, 0, 7, 6, 123, 0, 0),
(586, 1, 0, 0, 0, 0, 'Svargrond XXIII', 5, 74, 123000, 0, 7, 6, 123, 0, 0),
(587, 0, 0, 0, 0, 0, 'Svargrond XXIV', 5, 30, 57000, 0, 4, 4, 57, 0, 0),
(587, 1, 0, 0, 0, 0, 'Svargrond XXIV', 5, 30, 57000, 0, 4, 4, 57, 0, 0),
(588, 0, 0, 0, 0, 0, 'Svargrond Guild House XXV', 5, 54, 120000, 0, 12, 10, 120, 0, 0),
(588, 1, 0, 0, 0, 0, 'Svargrond Guild House XXV', 5, 54, 120000, 0, 12, 10, 120, 0, 0),
(589, 0, 0, 0, 0, 0, 'Svargrond XXVI', 5, 33, 61000, 0, 6, 6, 61, 0, 0),
(589, 1, 0, 0, 0, 0, 'Svargrond XXVI', 5, 33, 61000, 0, 6, 6, 61, 0, 0),
(590, 0, 0, 0, 0, 0, 'Svargrond XXVII', 5, 88, 167000, 0, 12, 8, 167, 0, 0),
(590, 1, 0, 0, 0, 0, 'Svargrond XXVII', 5, 88, 167000, 0, 12, 8, 167, 0, 0),
(591, 0, 0, 0, 0, 0, 'Svargrond XXVIII', 5, 37, 57000, 0, 5, 2, 57, 0, 0),
(591, 1, 0, 0, 0, 0, 'Svargrond XXVIII', 5, 37, 57000, 0, 5, 2, 57, 0, 0),
(592, 0, 0, 0, 0, 0, 'Svargrond XXIX', 5, 40, 64000, 0, 5, 2, 64, 0, 0),
(592, 1, 0, 0, 0, 0, 'Svargrond XXIX', 5, 40, 64000, 0, 5, 2, 64, 0, 0),
(593, 0, 0, 0, 0, 0, 'Svargrond XXX', 5, 32, 64000, 0, 6, 6, 64, 0, 0),
(593, 1, 0, 0, 0, 0, 'Svargrond XXX', 5, 32, 64000, 0, 6, 6, 64, 0, 0),
(594, 0, 0, 0, 0, 0, 'Svargrond XXXI', 5, 8, 23000, 0, 2, 4, 23, 0, 0),
(594, 1, 0, 0, 0, 0, 'Svargrond XXXI', 5, 8, 23000, 0, 2, 4, 23, 0, 0),
(595, 0, 0, 0, 0, 0, 'Svargrond XXXII', 5, 10, 23000, 0, 2, 2, 23, 0, 0),
(595, 1, 0, 0, 0, 0, 'Svargrond XXXII', 5, 10, 23000, 0, 2, 2, 23, 0, 0),
(596, 0, 0, 0, 0, 0, 'Svargrond XXXIII', 5, 10, 24000, 0, 2, 2, 24, 0, 0),
(596, 1, 0, 0, 0, 0, 'Svargrond XXXIII', 5, 10, 24000, 0, 2, 2, 24, 0, 0),
(597, 0, 0, 0, 0, 0, 'Svargrond XXXIV', 5, 8, 24000, 0, 2, 4, 24, 0, 0),
(597, 1, 0, 0, 0, 0, 'Svargrond XXXIV', 5, 8, 24000, 0, 2, 4, 24, 0, 0),
(598, 0, 0, 0, 0, 0, 'Svargrond XXXV', 5, 8, 23000, 0, 2, 4, 23, 0, 0),
(598, 1, 0, 0, 0, 0, 'Svargrond XXXV', 5, 8, 23000, 0, 2, 4, 23, 0, 0),
(599, 0, 0, 0, 0, 0, 'Svargrond XXXVI', 5, 7, 19000, 0, 2, 2, 19, 0, 0),
(599, 1, 0, 0, 0, 0, 'Svargrond XXXVI', 5, 7, 19000, 0, 2, 2, 19, 0, 0),
(600, 0, 0, 0, 0, 0, 'Svargrond XXXVII', 5, 7, 20000, 0, 2, 2, 20, 0, 0),
(600, 1, 0, 0, 0, 0, 'Svargrond XXXVII', 5, 7, 20000, 0, 2, 2, 20, 0, 0),
(601, 0, 0, 0, 0, 0, 'Svargrond XXXVIII', 5, 5, 19000, 0, 2, 4, 19, 0, 0),
(601, 1, 0, 0, 0, 0, 'Svargrond XXXVIII', 5, 5, 19000, 0, 2, 4, 19, 0, 0),
(602, 0, 0, 0, 0, 0, 'Svargrond XXXIX', 5, 7, 19000, 0, 2, 2, 19, 0, 0),
(602, 1, 0, 0, 0, 0, 'Svargrond XXXIX', 5, 7, 19000, 0, 2, 2, 19, 0, 0),
(603, 0, 0, 0, 0, 0, 'Svargrond L', 5, 7, 19000, 0, 2, 2, 19, 0, 0),
(603, 1, 0, 0, 0, 0, 'Svargrond L', 5, 7, 19000, 0, 2, 2, 19, 0, 0),
(604, 0, 0, 0, 0, 0, 'Svargrond House I', 5, 43, 88000, 0, 9, 4, 88, 0, 0),
(604, 1, 0, 0, 0, 0, 'Svargrond House I', 5, 43, 88000, 0, 9, 4, 88, 0, 0),
(605, 0, 0, 0, 0, 0, 'Svargrond House II', 5, 26, 52000, 0, 5, 4, 52, 0, 0),
(605, 1, 0, 0, 0, 0, 'Svargrond House II', 5, 26, 52000, 0, 5, 4, 52, 0, 0),
(606, 0, 0, 0, 0, 0, 'Svargrond House III', 5, 67, 119000, 0, 8, 4, 119, 0, 0),
(606, 1, 0, 0, 0, 0, 'Svargrond House III', 5, 67, 119000, 0, 8, 4, 119, 0, 0),
(607, 0, 0, 0, 0, 0, 'Svargrond House IV', 5, 16, 32000, 0, 2, 2, 32, 0, 0),
(607, 1, 0, 0, 0, 0, 'Svargrond House IV', 5, 16, 32000, 0, 2, 2, 32, 0, 0),
(608, 0, 0, 0, 0, 0, 'Svargrond House V', 5, 22, 43000, 0, 4, 2, 43, 0, 0),
(608, 1, 0, 0, 0, 0, 'Svargrond House V', 5, 22, 43000, 0, 4, 2, 43, 0, 0),
(609, 0, 0, 0, 0, 0, 'Svargrond House VI', 5, 12, 33000, 0, 5, 4, 33, 0, 0),
(609, 1, 0, 0, 0, 0, 'Svargrond House VI', 5, 12, 33000, 0, 5, 4, 33, 0, 0),
(610, 0, 0, 0, 0, 0, 'Svargrond House VII', 5, 25, 54000, 0, 5, 4, 54, 0, 0),
(610, 1, 0, 0, 0, 0, 'Svargrond House VII', 5, 25, 54000, 0, 5, 4, 54, 0, 0),
(611, 0, 0, 0, 0, 0, 'Svargrond Super Guild House I', 5, 184, 363000, 0, 23, 26, 363, 0, 0),
(611, 1, 0, 0, 0, 0, 'Svargrond Super Guild House I', 5, 184, 363000, 0, 23, 26, 363, 0, 0),
(612, 0, 0, 0, 0, 0, 'Svargrond House IX', 5, 14, 35000, 0, 4, 4, 35, 0, 0),
(612, 1, 0, 0, 0, 0, 'Svargrond House IX', 5, 14, 35000, 0, 4, 4, 35, 0, 0),
(613, 0, 0, 0, 0, 0, 'Svargrond House X', 5, 16, 35000, 0, 2, 4, 35, 0, 0),
(613, 1, 0, 0, 0, 0, 'Svargrond House X', 5, 16, 35000, 0, 2, 4, 35, 0, 0),
(614, 0, 0, 0, 0, 0, 'Svargrond House XI', 5, 11, 33000, 0, 3, 4, 33, 0, 0),
(614, 1, 0, 0, 0, 0, 'Svargrond House XI', 5, 11, 33000, 0, 3, 4, 33, 0, 0),
(615, 0, 0, 0, 0, 0, 'Svargrond House XII', 5, 6, 16000, 0, 2, 2, 16, 0, 0),
(615, 1, 0, 0, 0, 0, 'Svargrond House XII', 5, 6, 16000, 0, 2, 2, 16, 0, 0),
(616, 0, 0, 0, 0, 0, 'Svargrond House XIII', 5, 10, 20000, 0, 3, 2, 20, 0, 0),
(616, 1, 0, 0, 0, 0, 'Svargrond House XIII', 5, 10, 20000, 0, 3, 2, 20, 0, 0),
(617, 0, 0, 0, 0, 0, 'Svargrond House XIV', 5, 11, 28000, 0, 3, 4, 28, 0, 0),
(617, 1, 0, 0, 0, 0, 'Svargrond House XIV', 5, 11, 28000, 0, 3, 4, 28, 0, 0),
(619, 0, 0, 0, 0, 0, 'Demona House I', 1, 22, 36000, 0, 2, 0, 36, 0, 0),
(619, 1, 0, 0, 0, 0, 'Demona House I', 1, 22, 36000, 0, 2, 0, 36, 0, 0),
(623, 0, 0, 0, 0, 0, 'Jukita I', 1, 17, 45000, 0, 1, 0, 45, 0, 0),
(623, 1, 0, 0, 0, 0, 'Jukita I', 1, 17, 45000, 0, 1, 0, 45, 0, 0),
(626, 0, 0, 0, 0, 0, 'Depot House XIX', 1, 165, 248000, 0, 10, 0, 248, 0, 0),
(626, 1, 0, 0, 0, 0, 'Depot House XIX', 1, 165, 248000, 0, 10, 0, 248, 0, 0),
(1363, 0, 0, 0, 0, 0, 'Unnamed House #1363', 1, 2, 3000, 0, 0, 0, 3, 0, 0),
(1363, 1, 0, 0, 0, 0, 'Unnamed House #1363', 1, 2, 3000, 0, 0, 0, 3, 0, 0),
(1372, 0, 0, 0, 0, 0, 'Titanic House I', 1, 0, 8000, 0, 0, 0, 8, 0, 0),
(1372, 1, 0, 0, 0, 0, 'Titanic House I', 1, 0, 8000, 0, 0, 0, 8, 0, 0),
(1373, 0, 0, 0, 0, 0, 'Unnamed House #1373', 6, 10, 34000, 0, 0, 0, 34, 0, 0),
(1373, 1, 0, 0, 0, 0, 'Unnamed House #1373', 6, 10, 34000, 0, 0, 0, 34, 0, 0),
(1374, 0, 0, 0, 0, 0, 'Unnamed House #1374', 6, 24, 72000, 0, 0, 0, 72, 0, 0),
(1374, 1, 0, 0, 0, 0, 'Unnamed House #1374', 6, 24, 72000, 0, 0, 0, 72, 0, 0),
(1376, 0, 0, 0, 0, 0, 'Unnamed House #1376', 6, 13, 37000, 0, 1, 0, 37, 0, 0),
(1376, 1, 0, 0, 0, 0, 'Unnamed House #1376', 6, 13, 37000, 0, 1, 0, 37, 0, 0),
(1377, 0, 0, 0, 0, 0, 'Unnamed House #1377', 6, 16, 44000, 0, 1, 0, 44, 0, 0),
(1377, 1, 0, 0, 0, 0, 'Unnamed House #1377', 6, 16, 44000, 0, 1, 0, 44, 0, 0),
(1378, 0, 0, 0, 0, 0, 'Unnamed House #1378', 6, 47, 106000, 0, 1, 0, 106, 0, 0),
(1378, 1, 0, 0, 0, 0, 'Unnamed House #1378', 6, 47, 106000, 0, 1, 0, 106, 0, 0),
(1379, 0, 0, 0, 0, 0, 'Unnamed House #1379', 6, 22, 63000, 0, 1, 0, 63, 0, 0),
(1379, 1, 0, 0, 0, 0, 'Unnamed House #1379', 6, 22, 63000, 0, 1, 0, 63, 0, 0),
(1380, 0, 0, 0, 0, 0, 'Unnamed House #1380', 6, 30, 78000, 0, 0, 0, 78, 0, 0),
(1380, 1, 0, 0, 0, 0, 'Unnamed House #1380', 6, 30, 78000, 0, 0, 0, 78, 0, 0),
(1381, 0, 0, 0, 0, 0, 'Unnamed House #1381', 6, 18, 38000, 0, 1, 0, 38, 0, 0),
(1381, 1, 0, 0, 0, 0, 'Unnamed House #1381', 6, 18, 38000, 0, 1, 0, 38, 0, 0),
(1382, 0, 0, 0, 0, 0, 'Unnamed House #1382', 6, 9, 29000, 0, 1, 0, 29, 0, 0),
(1382, 1, 0, 0, 0, 0, 'Unnamed House #1382', 6, 9, 29000, 0, 1, 0, 29, 0, 0),
(1383, 0, 0, 0, 0, 0, 'Unnamed House #1383', 6, 13, 31000, 0, 1, 0, 31, 0, 0),
(1383, 1, 0, 0, 0, 0, 'Unnamed House #1383', 6, 13, 31000, 0, 1, 0, 31, 0, 0),
(1384, 0, 0, 0, 0, 0, 'Unnamed House #1384', 6, 12, 34000, 0, 2, 0, 34, 0, 0),
(1384, 1, 0, 0, 0, 0, 'Unnamed House #1384', 6, 12, 34000, 0, 2, 0, 34, 0, 0),
(1385, 0, 0, 0, 0, 0, 'Unnamed House #1385', 6, 22, 54000, 0, 2, 0, 54, 0, 0),
(1385, 1, 0, 0, 0, 0, 'Unnamed House #1385', 6, 22, 54000, 0, 2, 0, 54, 0, 0),
(1386, 0, 0, 0, 0, 0, 'Unnamed House #1386', 6, 20, 45000, 0, 1, 0, 45, 0, 0),
(1386, 1, 0, 0, 0, 0, 'Unnamed House #1386', 6, 20, 45000, 0, 1, 0, 45, 0, 0),
(1387, 0, 0, 0, 0, 0, 'Unnamed House #1387', 6, 10, 23000, 0, 2, 0, 23, 0, 0),
(1387, 1, 0, 0, 0, 0, 'Unnamed House #1387', 6, 10, 23000, 0, 2, 0, 23, 0, 0),
(1388, 0, 0, 0, 0, 0, 'Unnamed House #1388', 6, 18, 37000, 0, 1, 0, 37, 0, 0),
(1388, 1, 0, 0, 0, 0, 'Unnamed House #1388', 6, 18, 37000, 0, 1, 0, 37, 0, 0),
(1389, 0, 0, 0, 0, 0, 'Unnamed House #1389', 6, 50, 79000, 0, 2, 0, 79, 0, 0),
(1389, 1, 0, 0, 0, 0, 'Unnamed House #1389', 6, 50, 79000, 0, 2, 0, 79, 0, 0),
(1391, 0, 0, 0, 0, 0, 'Unnamed House #1391', 5, 55, 105000, 0, 8, 8, 105, 0, 0),
(1391, 1, 0, 0, 0, 0, 'Unnamed House #1391', 5, 55, 105000, 0, 8, 8, 105, 0, 0),
(1392, 0, 0, 0, 0, 0, 'Tiquanda I', 3, 30, 48000, 0, 1, 0, 48, 0, 0),
(1392, 1, 0, 0, 0, 0, 'Tiquanda I', 3, 30, 48000, 0, 1, 0, 48, 0, 0),
(1393, 0, 0, 0, 0, 0, 'Tiquanda II', 3, 30, 56000, 0, 1, 0, 56, 0, 0),
(1393, 1, 0, 0, 0, 0, 'Tiquanda II', 3, 30, 56000, 0, 1, 0, 56, 0, 0),
(1394, 0, 0, 0, 0, 0, 'Tiquanda III', 3, 30, 56000, 0, 1, 0, 56, 0, 0),
(1394, 1, 0, 0, 0, 0, 'Tiquanda III', 3, 30, 56000, 0, 1, 0, 56, 0, 0),
(1395, 0, 0, 0, 0, 0, 'Tiquanda IV', 3, 30, 48000, 0, 1, 0, 48, 0, 0),
(1395, 1, 0, 0, 0, 0, 'Tiquanda IV', 3, 30, 48000, 0, 1, 0, 48, 0, 0),
(1396, 0, 0, 0, 0, 0, 'Tiquanda V', 3, 30, 56000, 0, 1, 0, 56, 0, 0),
(1396, 1, 0, 0, 0, 0, 'Tiquanda V', 3, 30, 56000, 0, 1, 0, 56, 0, 0),
(1397, 0, 0, 0, 0, 0, 'Tiquanda VI', 3, 42, 64000, 0, 1, 0, 64, 0, 0),
(1397, 1, 0, 0, 0, 0, 'Tiquanda VI', 3, 42, 64000, 0, 1, 0, 64, 0, 0),
(1398, 0, 0, 0, 0, 0, 'Tiquanda VII', 3, 42, 72000, 0, 1, 0, 72, 0, 0),
(1398, 1, 0, 0, 0, 0, 'Tiquanda VII', 3, 42, 72000, 0, 1, 0, 72, 0, 0),
(1399, 0, 0, 0, 0, 0, 'Tiquanda VIII', 3, 30, 48000, 0, 1, 0, 48, 0, 0),
(1399, 1, 0, 0, 0, 0, 'Tiquanda VIII', 3, 30, 48000, 0, 1, 0, 48, 0, 0),
(1400, 0, 0, 0, 0, 0, 'Tiquanda IX', 3, 30, 56000, 0, 1, 0, 56, 0, 0),
(1400, 1, 0, 0, 0, 0, 'Tiquanda IX', 3, 30, 56000, 0, 1, 0, 56, 0, 0),
(1401, 0, 0, 0, 0, 0, 'Tiquanda X', 3, 15, 30000, 0, 1, 0, 30, 0, 0),
(1401, 1, 0, 0, 0, 0, 'Tiquanda X', 3, 15, 30000, 0, 1, 0, 30, 0, 0),
(1402, 0, 0, 0, 0, 0, 'Tiquanda XI', 3, 15, 35000, 0, 1, 0, 35, 0, 0),
(1402, 1, 0, 0, 0, 0, 'Tiquanda XI', 3, 15, 35000, 0, 1, 0, 35, 0, 0),
(1403, 0, 0, 0, 0, 0, 'Tiquanda XII', 3, 27, 59000, 0, 2, 0, 59, 0, 0),
(1403, 1, 0, 0, 0, 0, 'Tiquanda XII', 3, 27, 59000, 0, 2, 0, 59, 0, 0),
(1404, 0, 0, 0, 0, 0, 'Blood House XXXXX', 1, 20, 56000, 0, 1, 0, 56, 0, 0),
(1404, 1, 0, 0, 0, 0, 'Blood House XXXXX', 1, 20, 56000, 0, 1, 0, 56, 0, 0),
(1405, 0, 0, 0, 0, 0, 'Blood House XV8', 1, 30, 44000, 0, 1, 0, 44, 0, 0),
(1405, 1, 0, 0, 0, 0, 'Blood House XV8', 1, 30, 44000, 0, 1, 0, 44, 0, 0),
(1406, 0, 0, 0, 0, 0, 'Blood House Pl', 1, 20, 42000, 0, 1, 0, 42, 0, 0),
(1406, 1, 0, 0, 0, 0, 'Blood House Pl', 1, 20, 42000, 0, 1, 0, 42, 0, 0),
(1407, 0, 0, 0, 0, 0, 'Blood House Xv4', 1, 45, 77000, 0, 3, 0, 77, 0, 0),
(1407, 1, 0, 0, 0, 0, 'Blood House Xv4', 1, 45, 77000, 0, 3, 0, 77, 0, 0),
(1408, 0, 0, 0, 0, 0, 'Blood House Legas.', 1, 45, 66000, 0, 3, 0, 66, 0, 0),
(1408, 1, 0, 0, 0, 0, 'Blood House Legas.', 1, 45, 66000, 0, 3, 0, 66, 0, 0),
(1606, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 11, 0, 187, 0, 0),
(1606, 1, 0, 0, 0, 0, '', 0, 107, 187000, 0, 11, 0, 187, 0, 0),
(1607, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 2, 0, 33, 0, 0),
(1607, 1, 0, 0, 0, 0, '', 0, 18, 33000, 0, 2, 0, 33, 0, 0),
(1608, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 7, 0, 135, 0, 0),
(1608, 1, 0, 0, 0, 0, '', 0, 72, 135000, 0, 7, 0, 135, 0, 0),
(1609, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 1, 0, 83, 0, 0),
(1609, 1, 0, 0, 0, 0, '', 0, 56, 83000, 0, 1, 0, 83, 0, 0),
(1610, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 1, 0, 78, 0, 0),
(1610, 1, 0, 0, 0, 0, '', 0, 52, 78000, 0, 1, 0, 78, 0, 0),
(1611, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 2, 0, 103, 0, 0),
(1611, 1, 0, 0, 0, 0, '', 0, 72, 103000, 0, 2, 0, 103, 0, 0),
(1613, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 5, 0, 148, 0, 0),
(1613, 1, 0, 0, 0, 0, '', 0, 98, 148000, 0, 5, 0, 148, 0, 0),
(1615, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 1, 0, 87, 0, 0),
(1615, 1, 0, 0, 0, 0, '', 0, 60, 87000, 0, 1, 0, 87, 0, 0),
(1616, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 1, 0, 39, 0, 0),
(1616, 1, 0, 0, 0, 0, '', 0, 24, 39000, 0, 1, 0, 39, 0, 0),
(1617, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 1, 0, 38, 0, 0),
(1617, 1, 0, 0, 0, 0, '', 0, 24, 38000, 0, 1, 0, 38, 0, 0),
(1618, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 3, 0, 88, 0, 0),
(1618, 1, 0, 0, 0, 0, '', 0, 58, 88000, 0, 3, 0, 88, 0, 0),
(1619, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 1, 0, 35, 0, 0),
(1619, 1, 0, 0, 0, 0, '', 0, 24, 35000, 0, 1, 0, 35, 0, 0),
(1620, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 1, 0, 35, 0, 0),
(1620, 1, 0, 0, 0, 0, '', 0, 24, 35000, 0, 1, 0, 35, 0, 0),
(1621, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 1, 0, 38, 0, 0),
(1621, 1, 0, 0, 0, 0, '', 0, 24, 38000, 0, 1, 0, 38, 0, 0),
(1622, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 0, 0, 35, 0, 0),
(1622, 1, 0, 0, 0, 0, '', 0, 24, 35000, 0, 0, 0, 35, 0, 0),
(1623, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 2, 0, 63, 0, 0),
(1623, 1, 0, 0, 0, 0, '', 0, 41, 63000, 0, 2, 0, 63, 0, 0),
(1624, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 1, 0, 39, 0, 0),
(1624, 1, 0, 0, 0, 0, '', 0, 24, 39000, 0, 1, 0, 39, 0, 0),
(1625, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 2, 0, 60, 0, 0),
(1625, 1, 0, 0, 0, 0, '', 0, 41, 60000, 0, 2, 0, 60, 0, 0),
(1626, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 0, 0, 35, 0, 0),
(1626, 1, 0, 0, 0, 0, '', 0, 24, 35000, 0, 0, 0, 35, 0, 0),
(1627, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 0, 0, 38, 0, 0),
(1627, 1, 0, 0, 0, 0, '', 0, 24, 38000, 0, 0, 0, 38, 0, 0),
(1628, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 1, 0, 58, 0, 0),
(1628, 1, 0, 0, 0, 0, '', 0, 37, 58000, 0, 1, 0, 58, 0, 0),
(1629, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 1, 0, 35, 0, 0),
(1629, 1, 0, 0, 0, 0, '', 0, 24, 35000, 0, 1, 0, 35, 0, 0),
(1630, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 2, 0, 55, 0, 0),
(1630, 1, 0, 0, 0, 0, '', 0, 37, 55000, 0, 2, 0, 55, 0, 0),
(1631, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 2, 0, 109, 0, 0),
(1631, 1, 0, 0, 0, 0, '', 0, 73, 109000, 0, 2, 0, 109, 0, 0),
(1632, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 3, 0, 102, 0, 0),
(1632, 1, 0, 0, 0, 0, '', 0, 65, 102000, 0, 3, 0, 102, 0, 0),
(1633, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 15, 0, 393, 0, 0),
(1633, 1, 0, 0, 0, 0, '', 0, 239, 393000, 0, 15, 0, 393, 0, 0),
(1634, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 15, 0, 318, 0, 0),
(1634, 1, 0, 0, 0, 0, '', 0, 196, 318000, 0, 15, 0, 318, 0, 0),
(1635, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 1, 0, 35, 0, 0),
(1635, 1, 0, 0, 0, 0, '', 0, 24, 35000, 0, 1, 0, 35, 0, 0),
(1636, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 1, 0, 38, 0, 0),
(1636, 1, 0, 0, 0, 0, '', 0, 24, 38000, 0, 1, 0, 38, 0, 0),
(1637, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 2, 0, 61, 0, 0),
(1637, 1, 0, 0, 0, 0, '', 0, 37, 61000, 0, 2, 0, 61, 0, 0),
(1638, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 1, 0, 38, 0, 0),
(1638, 1, 0, 0, 0, 0, '', 0, 24, 38000, 0, 1, 0, 38, 0, 0),
(1639, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 2, 0, 59, 0, 0),
(1639, 1, 0, 0, 0, 0, '', 0, 37, 59000, 0, 2, 0, 59, 0, 0),
(1640, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 1, 0, 38, 0, 0),
(1640, 1, 0, 0, 0, 0, '', 0, 24, 38000, 0, 1, 0, 38, 0, 0),
(1641, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 1, 0, 35, 0, 0),
(1641, 1, 0, 0, 0, 0, '', 0, 24, 35000, 0, 1, 0, 35, 0, 0),
(1642, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 1, 0, 35, 0, 0),
(1642, 1, 0, 0, 0, 0, '', 0, 24, 35000, 0, 1, 0, 35, 0, 0),
(1643, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 1, 0, 23, 0, 0),
(1643, 1, 0, 0, 0, 0, '', 0, 12, 23000, 0, 1, 0, 23, 0, 0),
(1644, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 1, 0, 43, 0, 0),
(1644, 1, 0, 0, 0, 0, '', 0, 28, 43000, 0, 1, 0, 43, 0, 0),
(1645, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 1, 0, 20, 0, 0),
(1645, 1, 0, 0, 0, 0, '', 0, 12, 20000, 0, 1, 0, 20, 0, 0),
(1646, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 1, 0, 40, 0, 0),
(1646, 1, 0, 0, 0, 0, '', 0, 28, 40000, 0, 1, 0, 40, 0, 0),
(1647, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 1, 0, 38, 0, 0),
(1647, 1, 0, 0, 0, 0, '', 0, 24, 38000, 0, 1, 0, 38, 0, 0),
(1648, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 1, 0, 35, 0, 0),
(1648, 1, 0, 0, 0, 0, '', 0, 24, 35000, 0, 1, 0, 35, 0, 0),
(1649, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 1, 0, 38, 0, 0),
(1649, 1, 0, 0, 0, 0, '', 0, 24, 38000, 0, 1, 0, 38, 0, 0),
(1650, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 2, 0, 85, 0, 0),
(1650, 1, 0, 0, 0, 0, '', 0, 60, 85000, 0, 2, 0, 85, 0, 0),
(1651, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 1, 0, 35, 0, 0),
(1651, 1, 0, 0, 0, 0, '', 0, 24, 35000, 0, 1, 0, 35, 0, 0),
(1652, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 2, 0, 61, 0, 0),
(1652, 1, 0, 0, 0, 0, '', 0, 41, 61000, 0, 2, 0, 61, 0, 0),
(1653, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 3, 0, 88, 0, 0),
(1653, 1, 0, 0, 0, 0, '', 0, 57, 88000, 0, 3, 0, 88, 0, 0),
(1654, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 2, 0, 60, 0, 0),
(1654, 1, 0, 0, 0, 0, '', 0, 41, 60000, 0, 2, 0, 60, 0, 0),
(1655, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 1, 0, 35, 0, 0),
(1655, 1, 0, 0, 0, 0, '', 0, 24, 35000, 0, 1, 0, 35, 0, 0),
(1656, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 1, 0, 40, 0, 0),
(1656, 1, 0, 0, 0, 0, '', 0, 28, 40000, 0, 1, 0, 40, 0, 0),
(1657, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 1, 0, 20, 0, 0),
(1657, 1, 0, 0, 0, 0, '', 0, 12, 20000, 0, 1, 0, 20, 0, 0),
(1658, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 1, 0, 40, 0, 0),
(1658, 1, 0, 0, 0, 0, '', 0, 29, 40000, 0, 1, 0, 40, 0, 0),
(1659, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 1, 0, 28, 0, 0),
(1659, 1, 0, 0, 0, 0, '', 0, 16, 28000, 0, 1, 0, 28, 0, 0),
(1660, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 1, 0, 36, 0, 0),
(1660, 1, 0, 0, 0, 0, '', 0, 24, 36000, 0, 1, 0, 36, 0, 0),
(1661, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 1, 0, 27, 0, 0),
(1661, 1, 0, 0, 0, 0, '', 0, 16, 27000, 0, 1, 0, 27, 0, 0),
(1662, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 1, 0, 36, 0, 0),
(1662, 1, 0, 0, 0, 0, '', 0, 24, 36000, 0, 1, 0, 36, 0, 0),
(1663, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 1, 0, 20, 0, 0),
(1663, 1, 0, 0, 0, 0, '', 0, 12, 20000, 0, 1, 0, 20, 0, 0),
(1664, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 3, 0, 80, 0, 0),
(1664, 1, 0, 0, 0, 0, '', 0, 52, 80000, 0, 3, 0, 80, 0, 0),
(1665, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 1, 0, 35, 0, 0),
(1665, 1, 0, 0, 0, 0, '', 0, 24, 35000, 0, 1, 0, 35, 0, 0),
(1666, 0, 0, 0, 0, 0, '12', 0, 53, 82000, 0, 3, 0, 82, 0, 0),
(1666, 1, 0, 0, 0, 0, '', 0, 53, 82000, 0, 3, 0, 82, 0, 0),
(1667, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 1, 0, 37, 0, 0),
(1667, 1, 0, 0, 0, 0, '', 0, 24, 37000, 0, 1, 0, 37, 0, 0),
(1668, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 2, 0, 60, 0, 0),
(1668, 1, 0, 0, 0, 0, '', 0, 40, 60000, 0, 2, 0, 60, 0, 0),
(1669, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 2, 0, 55, 0, 0),
(1669, 1, 0, 0, 0, 0, '', 0, 36, 55000, 0, 2, 0, 55, 0, 0),
(1670, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 2, 0, 61, 0, 0),
(1670, 1, 0, 0, 0, 0, '', 0, 41, 61000, 0, 2, 0, 61, 0, 0),
(1671, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 2, 0, 58, 0, 0),
(1671, 1, 0, 0, 0, 0, '', 0, 37, 58000, 0, 2, 0, 58, 0, 0),
(1673, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 3, 0, 82, 0, 0),
(1673, 1, 0, 0, 0, 0, '', 0, 56, 82000, 0, 3, 0, 82, 0, 0),
(1674, 0, 0, 0, 0, 0, '091', 0, 24, 35000, 0, 1, 0, 35, 0, 0),
(1674, 1, 0, 0, 0, 0, '', 0, 24, 35000, 0, 1, 0, 35, 0, 0),
(1675, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 2, 0, 62, 0, 0),
(1675, 1, 0, 0, 0, 0, '', 0, 41, 62000, 0, 2, 0, 62, 0, 0),
(1676, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 2, 0, 65, 0, 0),
(1676, 1, 0, 0, 0, 0, '', 0, 41, 65000, 0, 2, 0, 65, 0, 0),
(1677, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 3, 0, 85, 0, 0),
(1677, 1, 0, 0, 0, 0, '', 0, 58, 85000, 0, 3, 0, 85, 0, 0),
(1678, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 1, 0, 36, 0, 0),
(1678, 1, 0, 0, 0, 0, '', 0, 24, 36000, 0, 1, 0, 36, 0, 0),
(1679, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 3, 0, 92, 0, 0),
(1679, 1, 0, 0, 0, 0, '', 0, 58, 92000, 0, 3, 0, 92, 0, 0),
(1680, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 1, 0, 30, 0, 0),
(1680, 1, 0, 0, 0, 0, '', 0, 24, 30000, 0, 1, 0, 30, 0, 0),
(1681, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 2, 0, 61, 0, 0),
(1681, 1, 0, 0, 0, 0, '', 0, 41, 61000, 0, 2, 0, 61, 0, 0),
(1683, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 2, 0, 55, 0, 0),
(1683, 1, 0, 0, 0, 0, '', 0, 36, 55000, 0, 2, 0, 55, 0, 0),
(1684, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 1, 0, 58, 0, 0),
(1684, 1, 0, 0, 0, 0, '', 0, 37, 58000, 0, 1, 0, 58, 0, 0),
(1685, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 1, 0, 60, 0, 0),
(1685, 1, 0, 0, 0, 0, '', 0, 41, 60000, 0, 1, 0, 60, 0, 0),
(1686, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 303778175, 0, 0, 24, 0, 950, 0, 0),
(1686, 1, 0, 0, 0, 0, '', 0, 610, 950000, 0, 24, 0, 950, 0, 0),
(1688, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 6, 0, 115, 0, 0),
(1688, 1, 0, 0, 0, 0, '', 0, 70, 116000, 0, 6, 0, 116, 0, 0),
(1689, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 3, 0, 49, 0, 0),
(1689, 1, 0, 0, 0, 0, '', 0, 25, 49000, 0, 3, 0, 49, 0, 0),
(1694, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 2, 0, 100, 0, 0),
(1694, 1, 0, 0, 0, 0, '', 0, 56, 100000, 0, 2, 0, 100, 0, 0),
(1698, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 0, 0, 11, 0, 0),
(1698, 1, 0, 0, 0, 0, '', 0, 0, 11000, 0, 0, 0, 11, 0, 0),
(1699, 0, 0, 0, 0, 0, '19198', 0, 69, 95000, 0, 4, 0, 95, 0, 0),
(1699, 1, 0, 0, 0, 0, '', 0, 69, 95000, 0, 4, 0, 95, 0, 0),
(1700, 0, 0, 0, 0, 0, '185194', 0, 80, 131000, 0, 4, 0, 131, 0, 0),
(1700, 1, 0, 0, 0, 0, '', 0, 80, 131000, 0, 4, 0, 131, 0, 0),
(1701, 0, 0, 0, 0, 0, '1561851', 0, 64, 107000, 0, 5, 0, 107, 0, 0),
(1701, 1, 0, 0, 0, 0, '', 0, 64, 107000, 0, 5, 0, 107, 0, 0),
(1709, 0, 0, 0, 0, 0, 'Forgotten headquarter (Flat 1, Area 42)', 0, 0, 0, 0, 2, 0, 82, 0, 0),
(1709, 1, 0, 0, 0, 0, '', 0, 48, 82000, 0, 2, 0, 82, 0, 0),
(1711, 0, 0, 0, 0, 0, 'Blood House XX9', 0, 32, 50000, 0, 4, 0, 50, 0, 0),
(1711, 1, 0, 0, 0, 0, 'Blood House XX9', 0, 32, 50000, 0, 4, 0, 50, 0, 0),
(1712, 0, 0, 0, 0, 0, 'Blood House Pits', 0, 30, 56000, 0, 4, 0, 56, 0, 0),
(1712, 1, 0, 0, 0, 0, 'Blood House Pits', 0, 30, 56000, 0, 5, 0, 56, 0, 0),
(1713, 0, 0, 0, 0, 0, 'Blood City XX2', 0, 32, 50000, 0, 4, 0, 50, 0, 0),
(1713, 1, 0, 0, 0, 0, 'Blood City XX2', 0, 32, 50000, 0, 4, 0, 50, 0, 0),
(1714, 0, 0, 0, 0, 0, 'Blood House XX99', 0, 30, 56000, 0, 5, 0, 56, 0, 0),
(1714, 1, 0, 0, 0, 0, 'Blood House XX99', 0, 30, 56000, 0, 4, 0, 56, 0, 0),
(1715, 0, 0, 0, 0, 0, 'Blood House 106', 1, 57, 105000, 0, 10, 0, 105, 0, 0),
(1715, 1, 0, 0, 0, 0, 'Blood House 106', 1, 89, 123000, 0, 7, 0, 123, 0, 0),
(1716, 0, 0, 0, 0, 0, 'Blood 156', 1, 84, 147000, 0, 7, 0, 147, 0, 0),
(1716, 1, 0, 0, 0, 0, 'Blood 156', 1, 84, 147000, 0, 7, 0, 147, 0, 0),
(1717, 0, 0, 0, 0, 0, 'Blood 262', 1, 64, 72000, 0, 4, 0, 72, 0, 0),
(1717, 1, 0, 0, 0, 0, 'Blood 262', 1, 118, 172000, 0, 6, 0, 172, 0, 0),
(1718, 0, 0, 0, 0, 0, 'Blood 451', 1, 59, 103000, 0, 6, 0, 103, 0, 0),
(1718, 1, 0, 0, 0, 0, 'Blood 451', 1, 79, 142000, 0, 6, 0, 142, 0, 0),
(1719, 0, 0, 0, 0, 0, 'Blood 51', 1, 35, 63000, 0, 2, 0, 63, 0, 0),
(1719, 1, 0, 0, 0, 0, 'Blood 51', 1, 35, 63000, 0, 2, 0, 63, 0, 0),
(1720, 0, 0, 0, 0, 0, 'Blood 571', 1, 35, 48000, 0, 2, 0, 48, 0, 0),
(1720, 1, 0, 0, 0, 0, 'Blood 571', 1, 35, 48000, 0, 2, 0, 48, 0, 0),
(1721, 0, 0, 0, 0, 0, 'Blood 47', 1, 34, 53000, 0, 1, 0, 53, 0, 0),
(1721, 1, 0, 0, 0, 0, 'Blood 47', 1, 34, 53000, 0, 1, 0, 53, 0, 0),
(1722, 0, 0, 0, 0, 0, 'Blood 781', 1, 75, 132000, 0, 2, 0, 132, 0, 0),
(1722, 1, 0, 0, 0, 0, 'Blood 781', 1, 75, 132000, 0, 2, 0, 132, 0, 0),
(1723, 0, 0, 0, 0, 0, 'Blood 74', 1, 30, 56000, 0, 1, 0, 56, 0, 0),
(1723, 1, 0, 0, 0, 0, 'Blood 74', 1, 30, 56000, 0, 1, 0, 56, 0, 0),
(1724, 0, 0, 0, 0, 0, 'Blood 71', 1, 24, 40000, 0, 5, 0, 40, 0, 0),
(1724, 1, 0, 0, 0, 0, 'Blood 71', 1, 24, 39000, 0, 5, 0, 39, 0, 0),
(1725, 0, 0, 0, 0, 0, 'Blood Nossa', 1, 84, 144000, 0, 3, 0, 144, 0, 0),
(1725, 1, 0, 0, 0, 0, 'Blood Nossa', 1, 84, 144000, 0, 3, 0, 144, 0, 0),
(1726, 0, 0, 0, 0, 0, 'Blood Kits', 1, 20, 52000, 0, 2, 0, 52, 0, 0),
(1726, 1, 0, 0, 0, 0, 'Blood Kits', 1, 40, 70000, 0, 1, 0, 70, 0, 0),
(1727, 0, 0, 0, 0, 0, 'Blood House XX7', 1, 40, 60000, 0, 2, 0, 60, 0, 0),
(1727, 1, 0, 0, 0, 0, 'Blood House XX7', 1, 40, 60000, 0, 2, 0, 60, 0, 0),
(1728, 0, 0, 0, 0, 0, 'Blood XD', 1, 40, 63000, 0, 2, 0, 63, 0, 0),
(1728, 1, 0, 0, 0, 0, 'Blood XD', 1, 40, 60000, 0, 1, 0, 60, 0, 0),
(1729, 0, 0, 0, 0, 0, 'Blood X89', 1, 66, 114000, 0, 6, 0, 114, 0, 0),
(1729, 1, 0, 0, 0, 0, 'Blood X89', 1, 66, 114000, 0, 4, 0, 114, 0, 0),
(1730, 0, 0, 0, 0, 0, 'I', 7, 15, 36000, 0, 1, 0, 36, 0, 0),
(1731, 0, 0, 0, 0, 0, 'II', 7, 19, 42000, 0, 1, 0, 42, 0, 0),
(1732, 0, 0, 0, 0, 0, 'III', 7, 184, 360000, 0, 13, 0, 360, 0, 0),
(1733, 0, 0, 0, 0, 0, 'IV', 7, 82, 152000, 0, 8, 0, 152, 0, 0),
(1734, 0, 0, 0, 0, 0, 'V', 7, 55, 90000, 0, 2, 0, 90, 0, 0),
(1735, 0, 0, 0, 0, 0, 'VI', 7, 39, 78000, 0, 5, 0, 78, 0, 0),
(1736, 0, 0, 0, 0, 0, 'VII', 7, 105, 195000, 0, 6, 0, 195, 0, 0),
(1737, 0, 0, 0, 0, 0, 'VIII', 7, 71, 135000, 0, 9, 0, 135, 0, 0),
(1738, 0, 0, 0, 0, 0, 'IX', 7, 35, 64000, 0, 7, 0, 64, 0, 0),
(1739, 0, 0, 0, 0, 0, 'X', 7, 23, 49000, 0, 1, 0, 49, 0, 0),
(1740, 0, 0, 0, 0, 0, 'Depot House TOP', 1, 66, 102000, 0, 3, 0, 102, 0, 0),
(1741, 0, 0, 0, 0, 0, 'Maconha I', 3, 47, 80000, 0, 1, 0, 80, 0, 0),
(1742, 0, 0, 0, 0, 0, 'Aeww', 1, 48, 91000, 0, 5, 0, 91, 0, 0),
(1743, 0, 0, 0, 0, 0, 'Unnamed House #1743', 1, 56, 100000, 0, 2, 0, 100, 0, 0),
(1744, 0, 0, 0, 0, 0, 'Unnamed House #1744', 1, 25, 49000, 0, 3, 0, 49, 0, 0),
(1745, 0, 0, 0, 0, 0, 'Unnamed House #1745', 1, 54, 100000, 0, 2, 0, 100, 0, 0),
(1746, 0, 0, 0, 0, 0, 'Unnamed House #1746', 1, 20, 42000, 0, 1, 0, 42, 0, 0),
(1747, 0, 0, 0, 0, 0, 'Village Mall', 1, 70, 110000, 0, 6, 0, 110, 0, 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `house_auctions`
--

CREATE TABLE IF NOT EXISTS `house_auctions` (
  `house_id` int(10) unsigned NOT NULL,
  `world_id` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `player_id` int(11) NOT NULL,
  `bid` int(10) unsigned NOT NULL DEFAULT '0',
  `limit` int(10) unsigned NOT NULL DEFAULT '0',
  `endtime` bigint(20) unsigned NOT NULL DEFAULT '0',
  UNIQUE KEY `house_id` (`house_id`,`world_id`),
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `house_data`
--

CREATE TABLE IF NOT EXISTS `house_data` (
  `house_id` int(10) unsigned NOT NULL,
  `world_id` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `data` longblob NOT NULL,
  UNIQUE KEY `house_id` (`house_id`,`world_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `house_data`
--

INSERT INTO `house_data` (`house_id`, `world_id`, `data`) VALUES
(1, 0, 0x9c006a00070100000071188002000b006465736372697074696f6e015200000049742062656c6f6e677320746f20686f7573652027546f7765722031272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031393430303020676f6c6420636f696e732e0600646f6f726964020200000000),
(6, 0, 0xba0027000701000000d3238002000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f75736520274775696c64486f75736520537472656574272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320383030303020676f6c6420636f696e732e0600646f6f726964020400000000bf0027000701000000b81400b90028000701000000d5238002000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f75736520274775696c64486f75736520537472656574272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320383030303020676f6c6420636f696e732e0600646f6f726964020100000000be0029000701000000e4048002000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f75736520274775696c64486f75736520537472656574272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320383030303020676f6c6420636f696e732e0600646f6f726964020200000000b9002d000701000000d5238002000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f75736520274775696c64486f75736520537472656574272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320383030303020676f6c6420636f696e732e0600646f6f726964020100000000ba0031000701000000e4048002000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f75736520274775696c64486f75736520537472656574272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320383030303020676f6c6420636f696e732e0600646f6f726964020500000000),
(42, 0, 0x80003e000701000000f8288002000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f75736520274865617679204465706f7420486f757365272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363130303020676f6c6420636f696e732e0600646f6f72696402010000000082003e00070100000071188002000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f75736520274865617679204465706f7420486f757365272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363130303020676f6c6420636f696e732e0600646f6f72696402020000000084003e000701000000f8288002000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f75736520274865617679204465706f7420486f757365272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363130303020676f6c6420636f696e732e0600646f6f7269640201000000007e0040000701000000f9288002000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f75736520274865617679204465706f7420486f757365272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363130303020676f6c6420636f696e732e0600646f6f7269640201000000007e0042000701000000f9288002000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f75736520274865617679204465706f7420486f757365272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363130303020676f6c6420636f696e732e0600646f6f726964020100000000800044000701000000fa288002000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f75736520274865617679204465706f7420486f757365272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363130303020676f6c6420636f696e732e0600646f6f726964020100000000840044000701000000fa288002000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f75736520274865617679204465706f7420486f757365272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363130303020676f6c6420636f696e732e0600646f6f726964020300000000),
(43, 0, 0x81003c0005010000001a28008200420005010000001a288002000b006465736372697074696f6e015e00000049742062656c6f6e677320746f20686f75736520274865617679204465706f7420486f757365204949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393630303020676f6c6420636f696e732e0600646f6f726964020300000000810042000601000000182800820042000601000000c5048002000b006465736372697074696f6e015e00000049742062656c6f6e677320746f20686f75736520274865617679204465706f7420486f757365204949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393630303020676f6c6420636f696e732e0600646f6f726964020200000000840041000601000000192800),
(56, 0, 0x7b003f000401000000f928007b0043000501000000f9288002000b006465736372697074696f6e015700000049742062656c6f6e677320746f20686f7573652027506f727420686f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732032353230303020676f6c6420636f696e732e0600646f6f7269640203000000007b0043000601000000f9288002000b006465736372697074696f6e015700000049742062656c6f6e677320746f20686f7573652027506f727420686f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732032353230303020676f6c6420636f696e732e0600646f6f7269640202000000007b00430007010000006f188002000b006465736372697074696f6e015700000049742062656c6f6e677320746f20686f7573652027506f727420686f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732032353230303020676f6c6420636f696e732e0600646f6f726964020600000000750045000501000000f92800750044000701000000f9288002000b006465736372697074696f6e015700000049742062656c6f6e677320746f20686f7573652027506f727420686f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732032353230303020676f6c6420636f696e732e0600646f6f7269640201000000007b0045000401000000f928007b0047000501000000f9288002000b006465736372697074696f6e015700000049742062656c6f6e677320746f20686f7573652027506f727420686f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732032353230303020676f6c6420636f696e732e0600646f6f7269640203000000007900460006010000006d188002000b006465736372697074696f6e015700000049742062656c6f6e677320746f20686f7573652027506f727420686f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732032353230303020676f6c6420636f696e732e0600646f6f7269640202000000007900460007010000006d188002000b006465736372697074696f6e015700000049742062656c6f6e677320746f20686f7573652027506f727420686f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732032353230303020676f6c6420636f696e732e0600646f6f7269640201000000007500480008010000006f188002000b006465736372697074696f6e015700000049742062656c6f6e677320746f20686f7573652027506f727420686f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732032353230303020676f6c6420636f696e732e0600646f6f726964020400000000),
(91, 0, 0x80002f000502000000b71400b714008600320005010000006f188002000b006465736372697074696f6e015900000049742062656c6f6e677320746f20686f75736520274465706f7420486f75736520494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363030303020676f6c6420636f696e732e0600646f6f72696402010000000080003400050100000071188002000b006465736372697074696f6e015900000049742062656c6f6e677320746f20686f75736520274465706f7420486f75736520494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363030303020676f6c6420636f696e732e0600646f6f726964020100000000),
(93, 0, 0xa8003300080100000071188002000b006465736372697074696f6e015900000049742062656c6f6e677320746f20686f757365202754656d706c6520486f757365205649272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323830303020676f6c6420636f696e732e0600646f6f726964020400000000bf005000080100000036198002000b006465736372697074696f6e015900000049742062656c6f6e677320746f20686f757365202754656d706c6520486f757365205649272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323830303020676f6c6420636f696e732e0600646f6f726964020300000000),
(95, 0, 0xa5002e00080100000071188002000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f757365202754656d706c6520486f7573652056494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353030303020676f6c6420636f696e732e0600646f6f726964020200000000),
(120, 0, 0xfd013e000c01000000e1048002000b006465736372697074696f6e015600000049742062656c6f6e677320746f20686f7573652027426c756520486f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323930303020676f6c6420636f696e732e0600646f6f726964020100000000),
(121, 0, 0xfd013e000b01000000e1048002000b006465736372697074696f6e015700000049742062656c6f6e677320746f20686f7573652027426c756520486f757365204949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333330303020676f6c6420636f696e732e0600646f6f726964020100000000),
(122, 0, 0x02024b000c01000000e1048002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f7573652027426c756520486f75736520494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353930303020676f6c6420636f696e732e0600646f6f726964020100000000),
(123, 0, 0x030259000c010000008d158002000b006465736372697074696f6e015700000049742062656c6f6e677320746f20686f7573652027426c756520486f757365204956272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323830303020676f6c6420636f696e732e0600646f6f726964020100000000),
(124, 0, ''),
(125, 0, 0xfb014a000b01000000e5048002000b006465736372697074696f6e015700000049742062656c6f6e677320746f20686f7573652027426c756520486f757365205649272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333130303020676f6c6420636f696e732e0600646f6f726964020200000000),
(126, 0, 0x030266000c010000008d158002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f7573652027426c756520486f75736520564949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313930303020676f6c6420636f696e732e0600646f6f726964020100000000),
(128, 0, ''),
(129, 0, 0xbd0021000701000000e4048002000b006465736372697074696f6e015700000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320383030303020676f6c6420636f696e732e0600646f6f726964020100000000c0001f0007010000008b158002000b006465736372697074696f6e015700000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320383030303020676f6c6420636f696e732e0600646f6f726964020400000000c20021000701000000e4048002000b006465736372697074696f6e015700000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320383030303020676f6c6420636f696e732e0600646f6f726964020200000000),
(133, 0, 0xc20033000701000000e4048002000b006465736372697074696f6e015700000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f7573652056272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343830303020676f6c6420636f696e732e0600646f6f726964020200000000),
(137, 0, 0xc800260007010000002c198002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f757365205858272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333330303020676f6c6420636f696e732e0600646f6f726964020400000000ca002600070100000071188002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f757365205858272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333330303020676f6c6420636f696e732e0600646f6f726964020300000000cb00260007010000002c198002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f757365205858272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333330303020676f6c6420636f696e732e0600646f6f726964020200000000),
(139, 0, 0xc700230006010000002d198002000b006465736372697074696f6e015900000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f75736520585849272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343330303020676f6c6420636f696e732e0600646f6f726964020100000000d1002600070100000071188002000b006465736372697074696f6e015900000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f75736520585849272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343330303020676f6c6420636f696e732e0600646f6f726964020400000000d200260007010000002c198002000b006465736372697074696f6e015900000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f75736520585849272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343330303020676f6c6420636f696e732e0600646f6f726964020200000000d400240007010000002d198002000b006465736372697074696f6e015900000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f75736520585849272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343330303020676f6c6420636f696e732e0600646f6f726964020300000000),
(140, 0, 0xcf00260006010000002c198002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f7573652058584949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343230303020676f6c6420636f696e732e0600646f6f726964020100000000d400220006010000002d198002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f7573652058584949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343230303020676f6c6420636f696e732e0600646f6f726964020100000000d2002600060100000071188002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f7573652058584949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343230303020676f6c6420636f696e732e0600646f6f726964020100000000d400240006010000002d198002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f7573652058584949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343230303020676f6c6420636f696e732e0600646f6f726964020100000000),
(141, 0, 0xc800260006010000002c198002000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f757365205858494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333430303020676f6c6420636f696e732e0600646f6f726964020100000000c9002600060100000071188002000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f757365205858494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333430303020676f6c6420636f696e732e0600646f6f726964020300000000cc00260006010000002c198002000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f757365205858494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333430303020676f6c6420636f696e732e0600646f6f726964020400000000),
(209, 0, 0x6600dc020701000000a1148002000b006465736372697074696f6e014f00000049742062656c6f6e677320746f20686f75736520273135313831272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343730303020676f6c6420636f696e732e0600646f6f726964020100000000),
(210, 0, 0x6700d40207010000009e148002000b006465736372697074696f6e014d00000049742062656c6f6e677320746f20686f7573652027313131272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343130303020676f6c6420636f696e732e0600646f6f726964020100000000),
(211, 0, 0x6800e30207010000009e148002000b006465736372697074696f6e014f00000049742062656c6f6e677320746f20686f75736520273939383938272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343930303020676f6c6420636f696e732e0600646f6f726964020100000000),
(212, 0, 0x7600e0020701000000fc138002000b006465736372697074696f6e015100000049742062656c6f6e677320746f20686f757365202734383734313831272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343830303020676f6c6420636f696e732e0600646f6f726964020100000000),
(213, 0, 0x7600d6020701000000fc138002000b006465736372697074696f6e014f00000049742062656c6f6e677320746f20686f75736520273132333334272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343030303020676f6c6420636f696e732e0600646f6f726964020100000000),
(214, 0, 0x7900dd02060100000005148002000b006465736372697074696f6e015100000049742062656c6f6e677320746f20686f757365202731353831343831272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333930303020676f6c6420636f696e732e0600646f6f726964020100000000),
(215, 0, 0x7900da02060100000005148002000b006465736372697074696f6e015100000049742062656c6f6e677320746f20686f757365202731383138313830272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323830303020676f6c6420636f696e732e0600646f6f726964020100000000),
(216, 0, 0x7500cc02060100000005148002000b006465736372697074696f6e015100000049742062656c6f6e677320746f20686f7573652027616463616361272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031323830303020676f6c6420636f696e732e0600646f6f7269640205000000007700ce020601000000fc138002000b006465736372697074696f6e015100000049742062656c6f6e677320746f20686f7573652027616463616361272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031323830303020676f6c6420636f696e732e0600646f6f7269640206000000007800cf020701000000fc138002000b006465736372697074696f6e015100000049742062656c6f6e677320746f20686f7573652027616463616361272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031323830303020676f6c6420636f696e732e0600646f6f7269640203000000007a00ce02070100000005148002000b006465736372697074696f6e015100000049742062656c6f6e677320746f20686f7573652027616463616361272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031323830303020676f6c6420636f696e732e0600646f6f7269640204000000007500d102070100000005148002000b006465736372697074696f6e015100000049742062656c6f6e677320746f20686f7573652027616463616361272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031323830303020676f6c6420636f696e732e0600646f6f7269640202000000007700d2020701000000fc138002000b006465736372697074696f6e015100000049742062656c6f6e677320746f20686f7573652027616463616361272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031323830303020676f6c6420636f696e732e0600646f6f726964020100000000),
(217, 0, 0x8a00cd02060100000005148002000b006465736372697074696f6e015000000049742062656c6f6e677320746f20686f7573652027313538313931272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343130303020676f6c6420636f696e732e0600646f6f726964020100000000),
(218, 0, 0x8500d0020701000000fc138002000b006465736372697074696f6e014e00000049742062656c6f6e677320746f20686f757365202732333433272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343030303020676f6c6420636f696e732e0600646f6f726964020100000000),
(219, 0, 0x8a00d0020701000000fc138002000b006465736372697074696f6e014f00000049742062656c6f6e677320746f20686f75736520273334323332272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333530303020676f6c6420636f696e732e0600646f6f726964020100000000),
(220, 0, 0x8000d902070100000005148002000b006465736372697074696f6e014f00000049742062656c6f6e677320746f20686f75736520273332343234272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343230303020676f6c6420636f696e732e0600646f6f726964020100000000),
(221, 0, 0x7700e6020701000000fc138002000b006465736372697074696f6e015100000049742062656c6f6e677320746f20686f7573652027323334323334272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031313330303020676f6c6420636f696e732e0600646f6f726964020100000000),
(222, 0, 0x7300f2020701000000fc138002000b006465736372697074696f6e015100000049742062656c6f6e677320746f20686f757365202733323434323432272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320383530303020676f6c6420636f696e732e0600646f6f7269640201000000007500f9020701000000fc138002000b006465736372697074696f6e015100000049742062656c6f6e677320746f20686f757365202733323434323432272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320383530303020676f6c6420636f696e732e0600646f6f726964020200000000),
(223, 0, 0x7700f502060100000005148002000b006465736372697074696f6e015100000049742062656c6f6e677320746f20686f757365202732333432343232272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343530303020676f6c6420636f696e732e0600646f6f726964020100000000),
(224, 0, 0x9300eb02070100000005148002000b006465736372697074696f6e015200000049742062656c6f6e677320746f20686f757365202732333432333432272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303630303020676f6c6420636f696e732e0600646f6f726964020100000000),
(225, 0, 0x9500d502070100000005148002000b006465736372697074696f6e015300000049742062656c6f6e677320746f20686f75736520273233343234323231272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031313530303020676f6c6420636f696e732e0600646f6f726964020100000000),
(569, 0, 0x7d026b020701000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e007e026b020701000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e0078026d020601000000741b8002000b006465736372697074696f6e015600000049742062656c6f6e677320746f20686f75736520275376617267726f6e642049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303730303020676f6c6420636f696e732e0600646f6f7269640207000000007b026f020601000000731b8002000b006465736372697074696f6e015600000049742062656c6f6e677320746f20686f75736520275376617267726f6e642049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303730303020676f6c6420636f696e732e0600646f6f7269640204000000007a026f020701000000ee1a8002000b006465736372697074696f6e015600000049742062656c6f6e677320746f20686f75736520275376617267726f6e642049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303730303020676f6c6420636f696e732e0600646f6f7269640201000000007e026f020601000000731b8002000b006465736372697074696f6e015600000049742062656c6f6e677320746f20686f75736520275376617267726f6e642049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303730303020676f6c6420636f696e732e0600646f6f7269640205000000007f026d020601000000f71a8002000b006465736372697074696f6e015600000049742062656c6f6e677320746f20686f75736520275376617267726f6e642049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303730303020676f6c6420636f696e732e0600646f6f7269640206000000007c026d020701000000f71a8002000b006465736372697074696f6e015600000049742062656c6f6e677320746f20686f75736520275376617267726f6e642049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303730303020676f6c6420636f696e732e0600646f6f7269640203000000007d026e020701000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e007e026e020701000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e0081026b020701000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e0080026e020701000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e0080026f020701000000731b8002000b006465736372697074696f6e015600000049742062656c6f6e677320746f20686f75736520275376617267726f6e642049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303730303020676f6c6420636f696e732e0600646f6f72696402020000000081026c020701000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e0081026e020701000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(570, 0, 0x7c0275020701000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e007d0275020701000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e007e0277020701000000ee1a8002000b006465736372697074696f6e016200000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204775696c6420486f757365204949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363330303020676f6c6420636f696e732e0600646f6f7269640202000000007f0275020701000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e007b0279020701000000f71a8002000b006465736372697074696f6e016200000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204775696c6420486f757365204949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363330303020676f6c6420636f696e732e0600646f6f7269640201000000007e027b020701000000ee1a8002000b006465736372697074696f6e016200000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204775696c6420486f757365204949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363330303020676f6c6420636f696e732e0600646f6f7269640203000000007e027e020701000000731b8002000b006465736372697074696f6e016200000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204775696c6420486f757365204949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363330303020676f6c6420636f696e732e0600646f6f7269640201000000007f027c020701000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e007f027d020701000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00800275020701000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00810276020701000000741b8002000b006465736372697074696f6e016200000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204775696c6420486f757365204949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363330303020676f6c6420636f696e732e0600646f6f726964020600000000810279020701000000741b8002000b006465736372697074696f6e016200000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204775696c6420486f757365204949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363330303020676f6c6420636f696e732e0600646f6f72696402040000000080027c020701000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e0080027d020701000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(571, 0, 0x890273020601000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e008a0273020601000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00870274020601000000ee1a8002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031323530303020676f6c6420636f696e732e0600646f6f726964020700000000860274020701000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00860275020701000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00870274020701000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00870275020701000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e008b0277020601000000741b8002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031323530303020676f6c6420636f696e732e0600646f6f726964020a000000008a0276020701000000ee1a8002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031323530303020676f6c6420636f696e732e0600646f6f7269640206000000008b0274020701000000741b8002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031323530303020676f6c6420636f696e732e0600646f6f726964020100000000880279020601000000ee1a8002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031323530303020676f6c6420636f696e732e0600646f6f7269640208000000008b0279020701000000741b8002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031323530303020676f6c6420636f696e732e0600646f6f7269640205000000008b027b020701000000f71a8002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031323530303020676f6c6420636f696e732e0600646f6f72696402040000000087027c020701000000731b8002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031323530303020676f6c6420636f696e732e0600646f6f7269640202000000008a027c020701000000731b8002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031323530303020676f6c6420636f696e732e0600646f6f726964020300000000),
(572, 0, 0x8f0277020601000000741b8002000b006465736372697074696f6e015600000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204956272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393830303020676f6c6420636f696e732e0600646f6f7269640207000000008f0278020701000000f71a8002000b006465736372697074696f6e015600000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204956272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393830303020676f6c6420636f696e732e0600646f6f726964020b00000000930274020601000000741b8002000b006465736372697074696f6e015600000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204956272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393830303020676f6c6420636f696e732e0600646f6f726964020a00000000930277020601000000741b8002000b006465736372697074696f6e015600000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204956272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393830303020676f6c6420636f696e732e0600646f6f726964020900000000900274020701000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00900275020701000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00910276020701000000ee1a8002000b006465736372697074696f6e015600000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204956272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393830303020676f6c6420636f696e732e0600646f6f726964020600000000920274020701000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00920275020701000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00930274020701000000741b8002000b006465736372697074696f6e015600000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204956272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393830303020676f6c6420636f696e732e0600646f6f726964020200000000920279020601000000ee1a8002000b006465736372697074696f6e015600000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204956272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393830303020676f6c6420636f696e732e0600646f6f72696402080000000090027902070100000068068002000b006465736372697074696f6e015600000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204956272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393830303020676f6c6420636f696e732e0600646f6f726964020b00000000930279020701000000741b8002000b006465736372697074696f6e015600000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204956272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393830303020676f6c6420636f696e732e0600646f6f72696402050000000091027c020701000000ee1a8002000b006465736372697074696f6e015600000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204956272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393830303020676f6c6420636f696e732e0600646f6f726964020100000000),
(573, 0, 0x980276020701000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00990276020701000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e0098027a020701000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e0099027a020701000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e009a0278020701000000f71a8002000b006465736372697074696f6e015500000049742062656c6f6e677320746f20686f75736520275376617267726f6e642056272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393230303020676f6c6420636f696e732e0600646f6f7269640202000000009c027b020701000000ee1a8002000b006465736372697074696f6e015500000049742062656c6f6e677320746f20686f75736520275376617267726f6e642056272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393230303020676f6c6420636f696e732e0600646f6f72696402070000000098027f020701000000f71a8002000b006465736372697074696f6e015500000049742062656c6f6e677320746f20686f75736520275376617267726f6e642056272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393230303020676f6c6420636f696e732e0600646f6f7269640201000000009f027e020701000000741b8002000b006465736372697074696f6e015500000049742062656c6f6e677320746f20686f75736520275376617267726f6e642056272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393230303020676f6c6420636f696e732e0600646f6f726964020600000000a00277020701000000741b8002000b006465736372697074696f6e015500000049742062656c6f6e677320746f20686f75736520275376617267726f6e642056272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393230303020676f6c6420636f696e732e0600646f6f726964020100000000a00279020701000000741b8002000b006465736372697074696f6e015500000049742062656c6f6e677320746f20686f75736520275376617267726f6e642056272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393230303020676f6c6420636f696e732e0600646f6f7269640204000000009c0280020701000000731b8002000b006465736372697074696f6e015500000049742062656c6f6e677320746f20686f75736520275376617267726f6e642056272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393230303020676f6c6420636f696e732e0600646f6f726964020500000000),
(574, 0, 0x6f0274020601000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006f0276020601000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006f0277020601000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006b027b020601000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006c027b020601000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006e0278020701000000f71a8002000b006465736372697074696f6e016300000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204775696c6420486f757365205649272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732032303630303020676f6c6420636f696e732e0600646f6f7269640208000000006a027e020701000000741b8002000b006465736372697074696f6e016300000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204775696c6420486f757365205649272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732032303630303020676f6c6420636f696e732e0600646f6f7269640204000000006e027c020601000000f71a8002000b006465736372697074696f6e016300000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204775696c6420486f757365205649272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732032303630303020676f6c6420636f696e732e0600646f6f726964020b000000006c027f020701000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006d027f020701000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006e027c020701000000f71a8002000b006465736372697074696f6e016300000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204775696c6420486f757365205649272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732032303630303020676f6c6420636f696e732e0600646f6f726964020100000000700274020601000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00700276020601000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00700277020601000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00730274020601000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00730275020601000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00730277020601000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00700276020701000000ee1a8002000b006465736372697074696f6e016300000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204775696c6420486f757365205649272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732032303630303020676f6c6420636f696e732e0600646f6f726964020700000000730274020701000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00730275020701000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00730277020701000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00740274020601000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00740275020601000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00740277020601000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00750276020601000000741b8002000b006465736372697074696f6e016300000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204775696c6420486f757365205649272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732032303630303020676f6c6420636f696e732e0600646f6f726964020a00000000740274020701000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00740275020701000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00740277020701000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e0071027b020601000000f71a8002000b006465736372697074696f6e016300000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204775696c6420486f757365205649272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732032303630303020676f6c6420636f696e732e0600646f6f726964020200000000730278020601000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00730278020701000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00740278020601000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e0075027b020601000000741b8002000b006465736372697074696f6e016300000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204775696c6420486f757365205649272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732032303630303020676f6c6420636f696e732e0600646f6f726964020b00000000740278020701000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e0070027e020601000000731b8002000b006465736372697074696f6e016300000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204775696c6420486f757365205649272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732032303630303020676f6c6420636f696e732e0600646f6f72696402090000000072027c020601000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e0072027d020601000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e0073027c020601000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e0073027d020601000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e0070027e020701000000731b8002000b006465736372697074696f6e016300000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204775696c6420486f757365205649272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732032303630303020676f6c6420636f696e732e0600646f6f72696402050000000071027c020701000000f71a8002000b006465736372697074696f6e016300000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204775696c6420486f757365205649272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732032303630303020676f6c6420636f696e732e0600646f6f72696402060000000073027c020701000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e0073027d020701000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e0073027e020701000000731b8002000b006465736372697074696f6e016300000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204775696c6420486f757365205649272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732032303630303020676f6c6420636f696e732e0600646f6f72696402030000000074027c020601000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e0074027d020601000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e0074027c020701000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e0074027d020701000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006b0280020601000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006c0280020601000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006c0280020701000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006d0280020701000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(575, 0, 0x740286020701000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00740287020701000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00750286020701000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00750287020701000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00780286020701000000f71a8002000b006465736372697074696f6e015700000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420564949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353530303020676f6c6420636f696e732e0600646f6f7269640203000000007e0286020701000000f71a8002000b006465736372697074696f6e015700000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420564949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353530303020676f6c6420636f696e732e0600646f6f726964020100000000),
(576, 0, 0x690287020701000000f71a8002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f75736520275376617267726f6e642056494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363930303020676f6c6420636f696e732e0600646f6f7269640201000000006e0289020601000000ee1a8002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f75736520275376617267726f6e642056494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363930303020676f6c6420636f696e732e0600646f6f7269640206000000006d0288020701000000ee1a8002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f75736520275376617267726f6e642056494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363930303020676f6c6420636f696e732e0600646f6f7269640202000000006e028b020701000000731b8002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f75736520275376617267726f6e642056494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363930303020676f6c6420636f696e732e0600646f6f726964020400000000700287020601000000741b8002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f75736520275376617267726f6e642056494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363930303020676f6c6420636f696e732e0600646f6f726964020500000000),
(577, 0, 0x5a0276020701000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e005b0276020701000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e005b0279020701000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e005b027a020701000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e005c027b020601000000731b8002000b006465736372697074696f6e015600000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204958272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393630303020676f6c6420636f696e732e0600646f6f7269640201000000005f027b020601000000731b8002000b006465736372697074696f6e015600000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204958272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393630303020676f6c6420636f696e732e0600646f6f7269640207000000005c0278020701000000f71a8002000b006465736372697074696f6e015600000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204958272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393630303020676f6c6420636f696e732e0600646f6f7269640204000000005f027b020701000000731b8002000b006465736372697074696f6e015600000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204958272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393630303020676f6c6420636f696e732e0600646f6f726964020200000000610277020601000000741b8002000b006465736372697074696f6e015600000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204958272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393630303020676f6c6420636f696e732e0600646f6f726964020500000000610279020601000000741b8002000b006465736372697074696f6e015600000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204958272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393630303020676f6c6420636f696e732e0600646f6f726964020600000000610278020701000000f71a8002000b006465736372697074696f6e015600000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204958272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393630303020676f6c6420636f696e732e0600646f6f726964020300000000),
(578, 0, 0x60027f020701000000f71a8002000b006465736372697074696f6e015500000049742062656c6f6e677320746f20686f75736520275376617267726f6e642058272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343030303020676f6c6420636f696e732e0600646f6f7269640204000000005f0280020701000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e005f0281020701000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e005f0282020701000000731b8002000b006465736372697074696f6e015500000049742062656c6f6e677320746f20686f75736520275376617267726f6e642058272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343030303020676f6c6420636f696e732e0600646f6f726964020300000000630282020701000000731b8002000b006465736372697074696f6e015500000049742062656c6f6e677320746f20686f75736520275376617267726f6e642058272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343030303020676f6c6420636f696e732e0600646f6f726964020500000000650280020701000000f71a8002000b006465736372697074696f6e015500000049742062656c6f6e677320746f20686f75736520275376617267726f6e642058272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343030303020676f6c6420636f696e732e0600646f6f726964020200000000);
INSERT INTO `house_data` (`house_id`, `world_id`, `data`) VALUES
(579, 0, 0x5e0285020601000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e005f0285020601000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e005e0289020601000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e005e028a020601000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e005f0289020601000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e005f028a020601000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00600286020601000000f71a8002000b006465736372697074696f6e015600000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205849272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393430303020676f6c6420636f696e732e0600646f6f726964020800000000620287020601000000ee1a8002000b006465736372697074696f6e015600000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205849272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393430303020676f6c6420636f696e732e0600646f6f72696402010000000060028b020601000000731b8002000b006465736372697074696f6e015600000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205849272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393430303020676f6c6420636f696e732e0600646f6f72696402070000000062028b020601000000731b8002000b006465736372697074696f6e015600000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205849272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393430303020676f6c6420636f696e732e0600646f6f72696402060000000060028b020701000000731b8002000b006465736372697074696f6e015600000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205849272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393430303020676f6c6420636f696e732e0600646f6f726964020300000000620288020701000000f71a8002000b006465736372697074696f6e015600000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205849272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393430303020676f6c6420636f696e732e0600646f6f726964020500000000640288020701000000f71a8002000b006465736372697074696f6e015600000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205849272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393430303020676f6c6420636f696e732e0600646f6f72696402050000000064028a020701000000741b8002000b006465736372697074696f6e015600000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205849272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393430303020676f6c6420636f696e732e0600646f6f726964020200000000),
(580, 0, 0x58028b020701000000f71a8002000b006465736372697074696f6e015700000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420584949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343230303020676f6c6420636f696e732e0600646f6f72696402040000000056028f020701000000ee1a8002000b006465736372697074696f6e015700000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420584949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343230303020676f6c6420636f696e732e0600646f6f72696402030000000059028d020701000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e0059028e020701000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e005b028c020701000000741b8002000b006465736372697074696f6e015700000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420584949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343230303020676f6c6420636f696e732e0600646f6f726964020100000000),
(581, 0, 0x540283020701000000f71a8002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f75736520275376617267726f6e642058494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333930303020676f6c6420636f696e732e0600646f6f726964020100000000570285020701000000f71a8002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f75736520275376617267726f6e642058494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333930303020676f6c6420636f696e732e0600646f6f726964020100000000580284020701000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00590284020701000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e005a0285020701000000741b8002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f75736520275376617267726f6e642058494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333930303020676f6c6420636f696e732e0600646f6f726964020300000000),
(584, 0, 0x480278020601000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00480279020601000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e0048027b020601000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00490278020601000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00490279020601000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e0049027b020601000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e004d0278020601000000f71a8002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420585849272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303530303020676f6c6420636f696e732e0600646f6f7269640202000000004a027d020601000000731b8002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420585849272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303530303020676f6c6420636f696e732e0600646f6f7269640206000000004d027c020601000000f71a8002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420585849272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303530303020676f6c6420636f696e732e0600646f6f7269640204000000004f027d020601000000ee1a8002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420585849272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303530303020676f6c6420636f696e732e0600646f6f72696402010000000052027a020601000000f71a8002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420585849272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303530303020676f6c6420636f696e732e0600646f6f726964020500000000),
(585, 0, 0x3c027b020701000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e003e027b020701000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e003c027c020701000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e003d027d020701000000ee1a8002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f75736520275376617267726f6e642058584949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343430303020676f6c6420636f696e732e0600646f6f7269640202000000003e027c020701000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e003f027f020701000000f71a8002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f75736520275376617267726f6e642058584949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343430303020676f6c6420636f696e732e0600646f6f7269640204000000003d0281020701000000731b8002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f75736520275376617267726f6e642058584949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343430303020676f6c6420636f696e732e0600646f6f726964020300000000420281020701000000731b8002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f75736520275376617267726f6e642058584949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343430303020676f6c6420636f696e732e0600646f6f726964020100000000440280020701000000f71a8002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f75736520275376617267726f6e642058584949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343430303020676f6c6420636f696e732e0600646f6f726964020600000000),
(586, 0, 0x370286020601000000741b8002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205858494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031323330303020676f6c6420636f696e732e0600646f6f726964020100000000380287020601000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00390287020601000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e003c0284020601000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e003d0284020601000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e003e0286020601000000741b8002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205858494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031323330303020676f6c6420636f696e732e0600646f6f7269640207000000003e0287020601000000f71a8002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205858494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031323330303020676f6c6420636f696e732e0600646f6f7269640206000000003e0287020701000000f71a8002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205858494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031323330303020676f6c6420636f696e732e0600646f6f726964020300000000380288020601000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00390288020601000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e003b0289020601000000731b8002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205858494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031323330303020676f6c6420636f696e732e0600646f6f7269640205000000003a0289020701000000731b8002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205858494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031323330303020676f6c6420636f696e732e0600646f6f726964020200000000410286020701000000f71a8002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205858494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031323330303020676f6c6420636f696e732e0600646f6f726964020400000000),
(587, 0, 0x3c028d020701000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e003c028e020701000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e003e028e020701000000f71a8002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f75736520275376617267726f6e642058584956272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353730303020676f6c6420636f696e732e0600646f6f72696402020000000044028e020701000000f71a8002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f75736520275376617267726f6e642058584956272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353730303020676f6c6420636f696e732e0600646f6f726964020300000000410291020701000000ee1a8002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f75736520275376617267726f6e642058584956272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353730303020676f6c6420636f696e732e0600646f6f726964020500000000430292020701000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00430293020701000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00410294020701000000731b8002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f75736520275376617267726f6e642058584956272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353730303020676f6c6420636f696e732e0600646f6f726964020100000000),
(588, 0, 0x5c029a020701000000ee1a8002000b006465736372697074696f6e016400000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204775696c6420486f75736520585856272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031323030303020676f6c6420636f696e732e0600646f6f7269640208000000005d0298020701000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e005d0299020701000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e005e0298020701000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e005e0299020701000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e005f029e020701000000f71a8002000b006465736372697074696f6e016400000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204775696c6420486f75736520585856272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031323030303020676f6c6420636f696e732e0600646f6f72696402010000000061029b020701000000ee1a8002000b006465736372697074696f6e016400000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204775696c6420486f75736520585856272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031323030303020676f6c6420636f696e732e0600646f6f72696402010000000063029a020701000000ee1a8002000b006465736372697074696f6e016400000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204775696c6420486f75736520585856272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031323030303020676f6c6420636f696e732e0600646f6f72696402040000000064029b020701000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e0065029b020701000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00660299020701000000741b8002000b006465736372697074696f6e016400000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204775696c6420486f75736520585856272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031323030303020676f6c6420636f696e732e0600646f6f726964020a0000000064029c020701000000731b8002000b006465736372697074696f6e016400000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204775696c6420486f75736520585856272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031323030303020676f6c6420636f696e732e0600646f6f7269640204000000005c02a1020701000000ee1a8002000b006465736372697074696f6e016400000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204775696c6420486f75736520585856272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031323030303020676f6c6420636f696e732e0600646f6f7269640206000000005e02a2020701000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e005e02a3020701000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e005d02a4020701000000731b8002000b006465736372697074696f6e016400000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204775696c6420486f75736520585856272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031323030303020676f6c6420636f696e732e0600646f6f7269640207000000006102a0020701000000ee1a8002000b006465736372697074696f6e016400000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204775696c6420486f75736520585856272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031323030303020676f6c6420636f696e732e0600646f6f7269640201000000006302a1020701000000ee1a8002000b006465736372697074696f6e016400000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204775696c6420486f75736520585856272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031323030303020676f6c6420636f696e732e0600646f6f7269640203000000006402a0020701000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006502a0020701000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006602a2020701000000741b8002000b006465736372697074696f6e016400000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204775696c6420486f75736520585856272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031323030303020676f6c6420636f696e732e0600646f6f7269640202000000006402a4020701000000731b8002000b006465736372697074696f6e016400000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204775696c6420486f75736520585856272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031323030303020676f6c6420636f696e732e0600646f6f726964020500000000),
(589, 0, 0x6e0295020701000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006e0296020701000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006f0295020701000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006f0296020701000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006e029a020701000000ee1a8002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f75736520275376617267726f6e642058585649272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363130303020676f6c6420636f696e732e0600646f6f7269640202000000006f029e020701000000ee1a8002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f75736520275376617267726f6e642058585649272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363130303020676f6c6420636f696e732e0600646f6f726964020700000000710297020701000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00720297020701000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e0072029a020701000000ee1a8002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f75736520275376617267726f6e642058585649272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363130303020676f6c6420636f696e732e0600646f6f726964020400000000730299020701000000741b8002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f75736520275376617267726f6e642058585649272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363130303020676f6c6420636f696e732e0600646f6f72696402010000000072029e020701000000731b8002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f75736520275376617267726f6e642058585649272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363130303020676f6c6420636f696e732e0600646f6f72696402050000000073029d020701000000741b8002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f75736520275376617267726f6e642058585649272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363130303020676f6c6420636f696e732e0600646f6f726964020600000000),
(590, 0, 0x780297020701000000731b8002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205858564949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031363730303020676f6c6420636f696e732e0600646f6f726964020200000000760298020601000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00760299020601000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00760298020701000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00760299020701000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e0078029a020601000000ee1a8002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205858564949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031363730303020676f6c6420636f696e732e0600646f6f726964020d00000000790298020601000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00790299020601000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e0078029a020701000000ee1a8002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205858564949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031363730303020676f6c6420636f696e732e0600646f6f726964020500000000790298020701000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00790299020701000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e0075029d020601000000741b8002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205858564949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031363730303020676f6c6420636f696e732e0600646f6f726964020a0000000077029f020701000000ee1a8002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205858564949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031363730303020676f6c6420636f696e732e0600646f6f72696402080000000078029f020601000000731b8002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205858564949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031363730303020676f6c6420636f696e732e0600646f6f72696402030000000079029f020701000000731b8002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205858564949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031363730303020676f6c6420636f696e732e0600646f6f7269640204000000007b029d020701000000f71a8002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205858564949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031363730303020676f6c6420636f696e732e0600646f6f7269640206000000007c029f020601000000731b8002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205858564949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031363730303020676f6c6420636f696e732e0600646f6f726964020b000000007d029d020601000000f71a8002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205858564949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031363730303020676f6c6420636f696e732e0600646f6f726964020c000000007f029f020701000000731b8002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205858564949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031363730303020676f6c6420636f696e732e0600646f6f72696402010000000081029d020701000000741b8002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205858564949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031363730303020676f6c6420636f696e732e0600646f6f726964020700000000),
(591, 0, 0x3c028d020601000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e003c028e020601000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e003e028e020601000000f71a8002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420585856494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353730303020676f6c6420636f696e732e0600646f6f72696402020000000044028f020601000000741b8002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420585856494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353730303020676f6c6420636f696e732e0600646f6f726964020100000000440292020601000000741b8002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420585856494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353730303020676f6c6420636f696e732e0600646f6f726964020500000000410294020601000000731b8002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420585856494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353730303020676f6c6420636f696e732e0600646f6f726964020600000000430294020601000000ee1a8002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420585856494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353730303020676f6c6420636f696e732e0600646f6f726964020500000000),
(592, 0, 0x390292020601000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e003a0292020601000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e003b0293020601000000741b8002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f75736520275376617267726f6e642058584958272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363430303020676f6c6420636f696e732e0600646f6f7269640205000000003a0296020601000000ee1a8002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f75736520275376617267726f6e642058584958272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363430303020676f6c6420636f696e732e0600646f6f7269640206000000003b0295020601000000741b8002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f75736520275376617267726f6e642058584958272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363430303020676f6c6420636f696e732e0600646f6f726964020200000000370299020601000000731b8002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f75736520275376617267726f6e642058584958272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363430303020676f6c6420636f696e732e0600646f6f7269640201000000003b0298020601000000f71a8002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f75736520275376617267726f6e642058584958272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363430303020676f6c6420636f696e732e0600646f6f726964020600000000),
(593, 0, 0x840297020701000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00860297020701000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00840298020701000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e0085029b020701000000ee1a8002000b006465736372697074696f6e015700000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420585858272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363430303020676f6c6420636f696e732e0600646f6f726964020200000000860298020701000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00860299020701000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e0086029a020701000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e0089029b020701000000ee1a8002000b006465736372697074696f6e015700000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420585858272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363430303020676f6c6420636f696e732e0600646f6f7269640206000000008b029a020701000000741b8002000b006465736372697074696f6e015700000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420585858272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363430303020676f6c6420636f696e732e0600646f6f72696402040000000085029e020701000000731b8002000b006465736372697074696f6e015700000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420585858272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363430303020676f6c6420636f696e732e0600646f6f72696402030000000087029e020701000000ee1a8002000b006465736372697074696f6e015700000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420585858272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363430303020676f6c6420636f696e732e0600646f6f7269640207000000008a029e020701000000731b8002000b006465736372697074696f6e015700000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420585858272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363430303020676f6c6420636f696e732e0600646f6f726964020500000000),
(594, 0, 0x900296020701000000f71a8002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f75736520275376617267726f6e642058585849272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323330303020676f6c6420636f696e732e0600646f6f726964020100000000930295020701000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00930297020701000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00940295020701000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00940297020701000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00950297020701000000741b8002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f75736520275376617267726f6e642058585849272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323330303020676f6c6420636f696e732e0600646f6f726964020200000000),
(595, 0, 0x90029a020701000000f71a8002000b006465736372697074696f6e015900000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205858584949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323330303020676f6c6420636f696e732e0600646f6f726964020100000000930299020701000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00940299020701000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e0095029b020701000000741b8002000b006465736372697074696f6e015900000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205858584949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323330303020676f6c6420636f696e732e0600646f6f726964020300000000),
(596, 0, 0x90029e020701000000f71a8002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420585858494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323430303020676f6c6420636f696e732e0600646f6f72696402020000000093029f020701000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e0094029f020701000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e0095029f020701000000741b8002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420585858494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323430303020676f6c6420636f696e732e0600646f6f726964020300000000),
(597, 0, 0x9002a2020701000000f71a8002000b006465736372697074696f6e015900000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205858584956272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323430303020676f6c6420636f696e732e0600646f6f7269640201000000009102a1020701000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e009202a1020701000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e009302a1020701000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e009402a1020701000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e009502a3020701000000741b8002000b006465736372697074696f6e015900000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205858584956272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323430303020676f6c6420636f696e732e0600646f6f726964020300000000),
(598, 0, 0x9002a6020701000000f71a8002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f75736520275376617267726f6e642058585856272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323330303020676f6c6420636f696e732e0600646f6f7269640201000000009302a5020701000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e009302a7020701000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e009402a5020701000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e009402a7020701000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e009502a7020701000000741b8002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f75736520275376617267726f6e642058585856272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323330303020676f6c6420636f696e732e0600646f6f726964020200000000),
(599, 0, 0x910296020601000000f71a8002000b006465736372697074696f6e015900000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205858585649272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313930303020676f6c6420636f696e732e0600646f6f726964020100000000920295020601000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00930295020601000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00950297020601000000741b8002000b006465736372697074696f6e015900000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205858585649272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313930303020676f6c6420636f696e732e0600646f6f726964020200000000),
(600, 0, 0x91029a020601000000f71a8002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420585858564949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323030303020676f6c6420636f696e732e0600646f6f726964020200000000930299020601000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00940299020601000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e0095029b020601000000741b8002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420585858564949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323030303020676f6c6420636f696e732e0600646f6f726964020300000000),
(601, 0, 0x91029e020601000000f71a8002000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f75736520275376617267726f6e642058585856494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313930303020676f6c6420636f696e732e0600646f6f72696402010000000093029d020601000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e0093029f020601000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e0094029d020601000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e0094029f020601000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e0095029f020601000000741b8002000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f75736520275376617267726f6e642058585856494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313930303020676f6c6420636f696e732e0600646f6f726964020200000000),
(602, 0, 0x9102a2020601000000f71a8002000b006465736372697074696f6e015900000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205858584958272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313930303020676f6c6420636f696e732e0600646f6f7269640201000000009302a1020601000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e009402a1020601000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e009502a3020601000000741b8002000b006465736372697074696f6e015900000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205858584958272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313930303020676f6c6420636f696e732e0600646f6f726964020200000000),
(603, 0, 0x9102a6020601000000f71a8002000b006465736372697074696f6e015500000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204c272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313930303020676f6c6420636f696e732e0600646f6f7269640201000000009302a7020601000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e009402a7020601000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e009502a7020601000000741b8002000b006465736372697074696f6e015500000049742062656c6f6e677320746f20686f75736520275376617267726f6e64204c272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313930303020676f6c6420636f696e732e0600646f6f726964020200000000),
(604, 0, 0x7302a6020601000000f71a8002000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320383830303020676f6c6420636f696e732e0600646f6f7269640204000000007302a5020701000000f71a8002000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320383830303020676f6c6420636f696e732e0600646f6f7269640202000000007702a6020601000000741b8002000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320383830303020676f6c6420636f696e732e0600646f6f726964020a000000007502a7020701000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e007602a7020701000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e007702a5020701000000741b8002000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320383830303020676f6c6420636f696e732e0600646f6f7269640206000000007202a9020601000000731b8002000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320383830303020676f6c6420636f696e732e0600646f6f7269640208000000007002a8020701000000f71a8002000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320383830303020676f6c6420636f696e732e0600646f6f7269640203000000007302a8020701000000f71a8002000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320383830303020676f6c6420636f696e732e0600646f6f7269640201000000007602a9020601000000731b8002000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320383830303020676f6c6420636f696e732e0600646f6f7269640209000000007502a8020701000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e007502a9020701000000731b8002000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320383830303020676f6c6420636f696e732e0600646f6f7269640205000000007602a8020701000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(605, 0, 0x7b02a4020701000000ee1a8002000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f757365204949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353230303020676f6c6420636f696e732e0600646f6f7269640201000000007b02ab020701000000731b8002000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f757365204949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353230303020676f6c6420636f696e732e0600646f6f7269640201000000007c02a9020701000000f71a8002000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f757365204949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353230303020676f6c6420636f696e732e0600646f6f7269640205000000007e02a9020701000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e007e02aa020701000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e007e02ab020701000000731b8002000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f757365204949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353230303020676f6c6420636f696e732e0600646f6f7269640204000000007f02a9020701000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e007f02aa020701000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e008002a6020701000000741b8002000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f757365204949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353230303020676f6c6420636f696e732e0600646f6f726964020300000000),
(606, 0, 0x8a02aa020701000000ee1a8002000b006465736372697074696f6e015e00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f75736520494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031313930303020676f6c6420636f696e732e0600646f6f7269640201000000008502af020601000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e008602af020601000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e008602ae020701000000ee1a8002000b006465736372697074696f6e015e00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f75736520494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031313930303020676f6c6420636f696e732e0600646f6f7269640203000000008902ac020601000000741b8002000b006465736372697074696f6e015e00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f75736520494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031313930303020676f6c6420636f696e732e0600646f6f7269640202000000008902ae020601000000f71a8002000b006465736372697074696f6e015e00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f75736520494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031313930303020676f6c6420636f696e732e0600646f6f7269640208000000008c02ac020701000000741b8002000b006465736372697074696f6e015e00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f75736520494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031313930303020676f6c6420636f696e732e0600646f6f7269640201000000008502b0020601000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e008602b0020601000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e008402b0020701000000f71a8002000b006465736372697074696f6e015e00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f75736520494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031313930303020676f6c6420636f696e732e0600646f6f7269640205000000008902b0020601000000741b8002000b006465736372697074696f6e015e00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f75736520494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031313930303020676f6c6420636f696e732e0600646f6f7269640206000000008c02b0020701000000741b8002000b006465736372697074696f6e015e00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f75736520494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031313930303020676f6c6420636f696e732e0600646f6f726964020400000000),
(607, 0, 0x7d02ae020701000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e007e02ae020701000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e007c02b0020701000000f71a8002000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f757365204956272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333230303020676f6c6420636f696e732e0600646f6f7269640201000000007f02b0020701000000741b8002000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f757365204956272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333230303020676f6c6420636f696e732e0600646f6f726964020300000000),
(608, 0, 0x7702b3020701000000f71a8002000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f7573652056272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343330303020676f6c6420636f696e732e0600646f6f7269640201000000007d02b2020701000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e007e02b2020701000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e007a02b6020701000000731b8002000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f7573652056272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343330303020676f6c6420636f696e732e0600646f6f7269640205000000007c02b5020701000000f71a8002000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f7573652056272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343330303020676f6c6420636f696e732e0600646f6f7269640202000000007e02b6020701000000731b8002000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f7573652056272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343330303020676f6c6420636f696e732e0600646f6f726964020300000000),
(609, 0, 0x7a02bb020701000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e007d02bb020701000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e007902bf020701000000f71a8002000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f757365205649272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333330303020676f6c6420636f696e732e0600646f6f7269640201000000007a02bc020701000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e007c02bd020701000000ee1a8002000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f757365205649272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333330303020676f6c6420636f696e732e0600646f6f7269640205000000007d02bc020701000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e007e02bf020701000000741b8002000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f757365205649272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333330303020676f6c6420636f696e732e0600646f6f7269640204000000007c02c0020701000000731b8002000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f757365205649272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333330303020676f6c6420636f696e732e0600646f6f7269640203000000007d02c0020701000000731b8002000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f757365205649272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333330303020676f6c6420636f696e732e0600646f6f726964020300000000);
INSERT INTO `house_data` (`house_id`, `world_id`, `data`) VALUES
(610, 0, 0x6802bb020701000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006902bb020701000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006802be020701000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006802bf020701000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006e02bc020701000000f71a8002000b006465736372697074696f6e015d00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f75736520564949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353430303020676f6c6420636f696e732e0600646f6f7269640201000000006e02bf020701000000f71a8002000b006465736372697074696f6e015d00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f75736520564949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353430303020676f6c6420636f696e732e0600646f6f7269640205000000007002bd020701000000f71a8002000b006465736372697074696f6e015d00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f75736520564949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353430303020676f6c6420636f696e732e0600646f6f7269640201000000007002bf020701000000741b8002000b006465736372697074696f6e015d00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f75736520564949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353430303020676f6c6420636f696e732e0600646f6f7269640202000000006a02c0020701000000731b8002000b006465736372697074696f6e015d00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f75736520564949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353430303020676f6c6420636f696e732e0600646f6f726964020400000000),
(611, 0, 0x6302a7020701000000731b8002000b006465736372697074696f6e016800000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205375706572204775696c6420486f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732033363330303020676f6c6420636f696e732e0600646f6f7269640209000000006202ab020701000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006302ab020701000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006502a9020701000000f71a8002000b006465736372697074696f6e016800000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205375706572204775696c6420486f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732033363330303020676f6c6420636f696e732e0600646f6f726964020a000000006902a802060100000062068002000b006465736372697074696f6e016800000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205375706572204775696c6420486f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732033363330303020676f6c6420636f696e732e0600646f6f7269640214000000006802aa020701000000ee1a8002000b006465736372697074696f6e016800000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205375706572204775696c6420486f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732033363330303020676f6c6420636f696e732e0600646f6f726964020d000000006902ab020701000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006d02ab020601000000741b8002000b006465736372697074696f6e016800000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205375706572204775696c6420486f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732033363330303020676f6c6420636f696e732e0600646f6f7269640210000000006d02aa020701000000741b8002000b006465736372697074696f6e016800000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205375706572204775696c6420486f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732033363330303020676f6c6420636f696e732e0600646f6f7269640207000000006302ad020701000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006402ad020701000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006602ac020701000000f71a8002000b006465736372697074696f6e016800000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205375706572204775696c6420486f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732033363330303020676f6c6420636f696e732e0600646f6f726964020c000000006802ad020701000000731b8002000b006465736372697074696f6e016800000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205375706572204775696c6420486f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732033363330303020676f6c6420636f696e732e0600646f6f726964020b000000006902ac020701000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006902af020701000000f71a8002000b006465736372697074696f6e016800000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205375706572204775696c6420486f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732033363330303020676f6c6420636f696e732e0600646f6f726964020e000000006d02af020701000000741b8002000b006465736372697074696f6e016800000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205375706572204775696c6420486f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732033363330303020676f6c6420636f696e732e0600646f6f7269640206000000006302b3020601000000ee1a8002000b006465736372697074696f6e016800000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205375706572204775696c6420486f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732033363330303020676f6c6420636f696e732e0600646f6f7269640215000000006702b3020601000000ee1a8002000b006465736372697074696f6e016800000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205375706572204775696c6420486f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732033363330303020676f6c6420636f696e732e0600646f6f7269640215000000006b02b3020601000000ee1a8002000b006465736372697074696f6e016800000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205375706572204775696c6420486f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732033363330303020676f6c6420636f696e732e0600646f6f7269640212000000006d02b1020601000000741b8002000b006465736372697074696f6e016800000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205375706572204775696c6420486f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732033363330303020676f6c6420636f696e732e0600646f6f7269640211000000006302b5020601000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006302b6020601000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006302b7020601000000731b8002000b006465736372697074696f6e016800000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205375706572204775696c6420486f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732033363330303020676f6c6420636f696e732e0600646f6f7269640213000000006302b4020701000000ee1a8002000b006465736372697074696f6e016800000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205375706572204775696c6420486f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732033363330303020676f6c6420636f696e732e0600646f6f7269640205000000006302b7020701000000731b8002000b006465736372697074696f6e016800000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205375706572204775696c6420486f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732033363330303020676f6c6420636f696e732e0600646f6f7269640203000000006402b5020601000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006402b6020601000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006702b5020601000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006702b6020601000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006702b7020601000000731b8002000b006465736372697074696f6e016800000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205375706572204775696c6420486f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732033363330303020676f6c6420636f696e732e0600646f6f7269640213000000006402b5020701000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006402b6020701000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006602b5020701000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006602b6020701000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006702b4020701000000ee1a8002000b006465736372697074696f6e016800000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205375706572204775696c6420486f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732033363330303020676f6c6420636f696e732e0600646f6f726964020f000000006702b7020701000000731b8002000b006465736372697074696f6e016800000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205375706572204775696c6420486f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732033363330303020676f6c6420636f696e732e0600646f6f7269640202000000006802b5020601000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006802b6020601000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006b02b5020601000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006b02b6020601000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006b02b7020601000000731b8002000b006465736372697074696f6e016800000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205375706572204775696c6420486f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732033363330303020676f6c6420636f696e732e0600646f6f7269640212000000006802b5020701000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006802b6020701000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006a02b5020701000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006a02b6020701000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006c02b5020601000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006c02b6020601000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e006c02b4020701000000ee1a8002000b006465736372697074696f6e016800000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205375706572204775696c6420486f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732033363330303020676f6c6420636f696e732e0600646f6f7269640208000000006d02b5020701000000741b8002000b006465736372697074696f6e016800000049742062656c6f6e677320746f20686f75736520275376617267726f6e64205375706572204775696c6420486f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732033363330303020676f6c6420636f696e732e0600646f6f726964020400000000),
(612, 0, 0xa4027e020701000000a4148002000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f757365204958272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333530303020676f6c6420636f696e732e0600646f6f726964020300000000a5027c0207010000007c158001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00a6027c0207010000007d158001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00a6027f02070100000046198002000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f757365204958272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333530303020676f6c6420636f696e732e0600646f6f726964020300000000a9027f02070100000046198002000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f757365204958272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333530303020676f6c6420636f696e732e0600646f6f726964020400000000aa027c0207010000007e158001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00aa027d0207010000007f158001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00ab027e02070100000047198002000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f757365204958272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333530303020676f6c6420636f696e732e0600646f6f726964020200000000),
(613, 0, 0xa50277020701000000a4148002000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f7573652058272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333530303020676f6c6420636f696e732e0600646f6f726964020100000000a902750207010000007c158001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00a902760207010000007c158001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00aa02750207010000007d158001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00aa02760207010000007d158001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00ab027702070100000047198002000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f7573652058272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333530303020676f6c6420636f696e732e0600646f6f726964020200000000),
(614, 0, 0xad026f0207010000007c158001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00ae026f0207010000007d158001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00ac0271020701000000a4148002000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f757365205849272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333330303020676f6c6420636f696e732e0600646f6f726964020200000000ad02730207010000007c158001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00ae02730207010000007d158001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00af027402070100000046198002000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f757365205849272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333330303020676f6c6420636f696e732e0600646f6f726964020300000000b0027002070100000047198002000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f757365205849272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333330303020676f6c6420636f696e732e0600646f6f726964020100000000),
(615, 0, 0xab026b020701000000a4148002000b006465736372697074696f6e015d00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f75736520584949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313630303020676f6c6420636f696e732e0600646f6f726964020100000000af026a0207010000007e158001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00af026b0207010000007f158001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00ad026c02070100000046198002000b006465736372697074696f6e015d00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f75736520584949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313630303020676f6c6420636f696e732e0600646f6f726964020200000000),
(616, 0, 0xb4026a0207010000007e158001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00b4026b0207010000007f158001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00b8026b02070100000047198002000b006465736372697074696f6e015e00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f7573652058494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323030303020676f6c6420636f696e732e0600646f6f726964020100000000b6026d02070100000046198002000b006465736372697074696f6e015e00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f7573652058494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323030303020676f6c6420636f696e732e0600646f6f726964020300000000b7026d020701000000a6148002000b006465736372697074696f6e015e00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f7573652058494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323030303020676f6c6420636f696e732e0600646f6f726964020300000000),
(617, 0, 0xac0265020701000000a4148002000b006465736372697074696f6e015d00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f75736520584956272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323830303020676f6c6420636f696e732e0600646f6f726964020200000000ad02640207010000007c158001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00ae02640207010000007d158001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00ae026702070100000046198002000b006465736372697074696f6e015d00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f75736520584956272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323830303020676f6c6420636f696e732e0600646f6f726964020300000000b102650207010000007e158001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00b102660207010000007f158001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00b1026702070100000046198002000b006465736372697074696f6e015d00000049742062656c6f6e677320746f20686f75736520275376617267726f6e6420486f75736520584956272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323830303020676f6c6420636f696e732e0600646f6f726964020400000000),
(619, 0, 0xc00050000801000000d3048002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f757365202744656d6f6e6120486f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333630303020676f6c6420636f696e732e0600646f6f726964020200000000c4005200080100000037198002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f757365202744656d6f6e6120486f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333630303020676f6c6420636f696e732e0600646f6f726964020100000000),
(623, 0, 0x79008000070100000071188002000b006465736372697074696f6e015200000049742062656c6f6e677320746f20686f75736520274a756b6974612049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343530303020676f6c6420636f696e732e0600646f6f726964020200000000),
(626, 0, 0x9f007c00060100000063218002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f75736520274465706f7420486f75736520584958272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732032343830303020676f6c6420636f696e732e0600646f6f726964020100000000a3007400070100000061218002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f75736520274465706f7420486f75736520584958272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732032343830303020676f6c6420636f696e732e0600646f6f726964020800000000a4007600060100000063218002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f75736520274465706f7420486f75736520584958272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732032343830303020676f6c6420636f696e732e0600646f6f726964020600000000a2007800060100000065218002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f75736520274465706f7420486f75736520584958272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732032343830303020676f6c6420636f696e732e0600646f6f726964020900000000a0007900070100000063218002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f75736520274465706f7420486f75736520584958272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732032343830303020676f6c6420636f696e732e0600646f6f726964020700000000a6007800070100000063218002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f75736520274465706f7420486f75736520584958272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732032343830303020676f6c6420636f696e732e0600646f6f726964020200000000a0007d00070100000063218002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f75736520274465706f7420486f75736520584958272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732032343830303020676f6c6420636f696e732e0600646f6f726964020500000000a3007e00070100000065218002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f75736520274465706f7420486f75736520584958272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732032343830303020676f6c6420636f696e732e0600646f6f726964020300000000a6007c00060100000063218002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f75736520274465706f7420486f75736520584958272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732032343830303020676f6c6420636f696e732e0600646f6f726964020500000000a6007d00070100000063218002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f75736520274465706f7420486f75736520584958272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732032343830303020676f6c6420636f696e732e0600646f6f726964020400000000),
(1363, 0, ''),
(1372, 0, ''),
(1373, 0, 0x1c019d020603000000b606170000000000b606170000000000b6061700000000001c019e020602000000b906170000000000b9061700000000001d019d020601000000b7061700000000001e019c020602000000b906170000000000b906170000000000),
(1374, 0, 0x1f01a70206010000001b28002301a60207010000001b28002101a9020701000000c50400),
(1376, 0, 0x3501a3020701000000c5048002000b006465736372697074696f6e015d00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f757365202331333736272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333730303020676f6c6420636f696e732e0600646f6f726964020100000000),
(1377, 0, 0x3a01a10206010000001b28003c01a40206010000001a28003c01a4020701000000c5048002000b006465736372697074696f6e015d00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f757365202331333737272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343430303020676f6c6420636f696e732e0600646f6f726964020100000000),
(1378, 0, 0x3d019e0207010000005607003f019d020701000000c3048002000b006465736372697074696f6e015e00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f757365202331333738272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303630303020676f6c6420636f696e732e0600646f6f726964020100000000),
(1379, 0, 0x440197020701000000c3048002000b006465736372697074696f6e015d00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f757365202331333739272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363330303020676f6c6420636f696e732e0600646f6f726964020200000000),
(1380, 0, 0x4e01a10205010000001b28004c01a30206010000001a28004a01a40207010000001a2800),
(1381, 0, 0x54019b020701000000c3048002000b006465736372697074696f6e015d00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f757365202331333831272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333830303020676f6c6420636f696e732e0600646f6f726964020200000000),
(1382, 0, 0x4e01aa020701000000c3048002000b006465736372697074696f6e015d00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f757365202331333832272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323930303020676f6c6420636f696e732e0600646f6f7269640201000000004c01ad0207010000001a2800),
(1383, 0, 0x3701ae0207010000006c188002000b006465736372697074696f6e015d00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f757365202331333833272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333130303020676f6c6420636f696e732e0600646f6f726964020200000000),
(1384, 0, 0x2d01b30207010000002d198002000b006465736372697074696f6e015d00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f757365202331333834272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333430303020676f6c6420636f696e732e0600646f6f7269640203000000002a01b6020701000000c5048002000b006465736372697074696f6e015d00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f757365202331333834272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333430303020676f6c6420636f696e732e0600646f6f726964020100000000),
(1385, 0, 0x2901bf020701000000c5048002000b006465736372697074696f6e015d00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f757365202331333835272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353430303020676f6c6420636f696e732e0600646f6f7269640201000000002601c30206010000002f198002000b006465736372697074696f6e015d00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f757365202331333835272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353430303020676f6c6420636f696e732e0600646f6f7269640202000000002b01c10207010000001b2800),
(1386, 0, 0x4301c8020701000000c3048002000b006465736372697074696f6e015d00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f757365202331333836272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343530303020676f6c6420636f696e732e0600646f6f726964020100000000),
(1387, 0, 0x1901bd0205010000006d188002000b006465736372697074696f6e015d00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f757365202331333837272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323330303020676f6c6420636f696e732e0600646f6f7269640203000000001a01c0020601000000c3048002000b006465736372697074696f6e015d00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f757365202331333837272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323330303020676f6c6420636f696e732e0600646f6f726964020200000000),
(1388, 0, 0x1b01ba020501000000ba048002000b006465736372697074696f6e015d00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f757365202331333838272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333730303020676f6c6420636f696e732e0600646f6f726964020100000000),
(1389, 0, 0x570190020401000000c5048002000b006465736372697074696f6e015d00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f757365202331333839272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320373930303020676f6c6420636f696e732e0600646f6f7269640203000000005701920204010000006c188002000b006465736372697074696f6e015d00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f757365202331333839272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320373930303020676f6c6420636f696e732e0600646f6f7269640202000000005501960203010000001a2800),
(1391, 0, 0x4c0277020701000000e0068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e004d0277020701000000e1068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e004f0277020701000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e004b027a020701000000f71a8002000b006465736372697074696f6e015e00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f757365202331333931272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303530303020676f6c6420636f696e732e0600646f6f7269640204000000004d027b020701000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e004f0278020701000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e0049027d020701000000ee1a8002000b006465736372697074696f6e015e00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f757365202331333931272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303530303020676f6c6420636f696e732e0600646f6f7269640203000000004c027d020701000000731b8002000b006465736372697074696f6e015e00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f757365202331333931272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303530303020676f6c6420636f696e732e0600646f6f7269640201000000004d027c020701000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00510277020701000000da068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00510278020701000000db068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00510279020701000000ee1a8002000b006465736372697074696f6e015e00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f757365202331333931272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303530303020676f6c6420636f696e732e0600646f6f726964020400000000540279020701000000ee1a8002000b006465736372697074696f6e015e00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f757365202331333931272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303530303020676f6c6420636f696e732e0600646f6f72696402030000000056027a020701000000741b8002000b006465736372697074696f6e015e00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f757365202331333931272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303530303020676f6c6420636f696e732e0600646f6f72696402010000000052027d020701000000ee1a8002000b006465736372697074696f6e015e00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f757365202331333931272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303530303020676f6c6420636f696e732e0600646f6f72696402020000000054027d020701000000731b8002000b006465736372697074696f6e015e00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f757365202331333931272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303530303020676f6c6420636f696e732e0600646f6f726964020500000000),
(1392, 0, 0x7200b3000701000000db0d8002000b006465736372697074696f6e015400000049742062656c6f6e677320746f20686f757365202754697175616e64612049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343830303020676f6c6420636f696e732e0600646f6f726964020100000000),
(1393, 0, 0x7200b9000701000000db0d8002000b006465736372697074696f6e015500000049742062656c6f6e677320746f20686f757365202754697175616e6461204949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353630303020676f6c6420636f696e732e0600646f6f726964020100000000),
(1394, 0, 0x7e00be000701000000db0d8002000b006465736372697074696f6e015600000049742062656c6f6e677320746f20686f757365202754697175616e646120494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353630303020676f6c6420636f696e732e0600646f6f726964020100000000),
(1395, 0, 0x6b00c0000701000000db0d8002000b006465736372697074696f6e015500000049742062656c6f6e677320746f20686f757365202754697175616e6461204956272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343830303020676f6c6420636f696e732e0600646f6f726964020100000000),
(1396, 0, 0x6b00c6000701000000db0d8002000b006465736372697074696f6e015400000049742062656c6f6e677320746f20686f757365202754697175616e64612056272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353630303020676f6c6420636f696e732e0600646f6f726964020100000000),
(1397, 0, 0x7100ca000701000000d20d8002000b006465736372697074696f6e015500000049742062656c6f6e677320746f20686f757365202754697175616e6461205649272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363430303020676f6c6420636f696e732e0600646f6f726964020100000000),
(1398, 0, 0x7900ca000701000000d20d8002000b006465736372697074696f6e015600000049742062656c6f6e677320746f20686f757365202754697175616e646120564949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320373230303020676f6c6420636f696e732e0600646f6f726964020100000000),
(1399, 0, 0x9600c9000701000000db0d8002000b006465736372697074696f6e015700000049742062656c6f6e677320746f20686f757365202754697175616e64612056494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343830303020676f6c6420636f696e732e0600646f6f726964020100000000),
(1400, 0, 0x9600cf000701000000db0d8002000b006465736372697074696f6e015500000049742062656c6f6e677320746f20686f757365202754697175616e6461204958272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353630303020676f6c6420636f696e732e0600646f6f726964020100000000),
(1403, 0, 0x9800ba000701000000db0d8002000b006465736372697074696f6e015600000049742062656c6f6e677320746f20686f757365202754697175616e646120584949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353930303020676f6c6420636f696e732e0600646f6f7269640201000000009c00ba000701000000db0d8002000b006465736372697074696f6e015600000049742062656c6f6e677320746f20686f757365202754697175616e646120584949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353930303020676f6c6420636f696e732e0600646f6f726964020200000000),
(1404, 0, 0xbe004a000601000000b81400be0049000701000000311900be004a000701000000e2048002000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f757365205858585858272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353630303020676f6c6420636f696e732e0600646f6f726964020200000000be004b000701000000b81400bf004c000601000000301900c00048000601000000301900c2004a000601000000b81400c10048000701000000b71400c20049000701000000311900c2004c000601000000b81400c2004c000701000000311900),
(1405, 0, 0xb100220007010000008b158002000b006465736372697074696f6e015900000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f75736520585638272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343430303020676f6c6420636f696e732e0600646f6f726964020100000000),
(1406, 0, 0xab001f000701000000b71400ad001d0007010000008b158002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f75736520506c272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343230303020676f6c6420636f696e732e0600646f6f726964020100000000),
(1407, 0, 0xa600200007010000002d198002000b006465736372697074696f6e015900000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f75736520587634272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320373730303020676f6c6420636f696e732e0600646f6f726964020100000000a200240007010000002c198002000b006465736372697074696f6e015900000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f75736520587634272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320373730303020676f6c6420636f696e732e0600646f6f726964020100000000a3002400070100000071188002000b006465736372697074696f6e015900000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f75736520587634272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320373730303020676f6c6420636f696e732e0600646f6f726964020100000000),
(1408, 0, 0x9a001e0007010000002d198002000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f757365204c656761732e272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363630303020676f6c6420636f696e732e0600646f6f7269640201000000009d002400070100000071188002000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f757365204c656761732e272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363630303020676f6c6420636f696e732e0600646f6f7269640201000000009e00240007010000002c198002000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f757365204c656761732e272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363630303020676f6c6420636f696e732e0600646f6f726964020100000000),
(1666, 0, 0x6f043b0406010000008b158002000b006465736372697074696f6e014c00000049742062656c6f6e677320746f20686f75736520273132272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320383230303020676f6c6420636f696e732e0600646f6f7269640202000000007204360406010000008e158002000b006465736372697074696f6e014c00000049742062656c6f6e677320746f20686f75736520273132272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320383230303020676f6c6420636f696e732e0600646f6f726964020100000000740434040601000000b81400740439040601000000b8140072043c0406010000008d158002000b006465736372697074696f6e014c00000049742062656c6f6e677320746f20686f75736520273132272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320383230303020676f6c6420636f696e732e0600646f6f72696402030000000074043f040601000000b81400720441040601000000b71400),
(1674, 0, 0x78041f0406010000008d158002000b006465736372697074696f6e014d00000049742062656c6f6e677320746f20686f7573652027303931272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333530303020676f6c6420636f696e732e0600646f6f72696402020000000079041f040601000000b71400),
(1699, 0, 0xac002a00070100000025198002000b006465736372697074696f6e014f00000049742062656c6f6e677320746f20686f75736520273139313938272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393530303020676f6c6420636f696e732e0600646f6f726964020100000000ad002b00070100000042198002000b006465736372697074696f6e014f00000049742062656c6f6e677320746f20686f75736520273139313938272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393530303020676f6c6420636f696e732e0600646f6f726964020100000000b3002700070100000024198002000b006465736372697074696f6e014f00000049742062656c6f6e677320746f20686f75736520273139313938272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393530303020676f6c6420636f696e732e0600646f6f726964020100000000b1002d000701000000c5048002000b006465736372697074696f6e014f00000049742062656c6f6e677320746f20686f75736520273139313938272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393530303020676f6c6420636f696e732e0600646f6f726964020200000000),
(1700, 0, 0xb7002b00060100000025198002000b006465736372697074696f6e015100000049742062656c6f6e677320746f20686f7573652027313835313934272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031333130303020676f6c6420636f696e732e0600646f6f726964020200000000b2002f000701000000c3048002000b006465736372697074696f6e015100000049742062656c6f6e677320746f20686f7573652027313835313934272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031333130303020676f6c6420636f696e732e0600646f6f726964020400000000b7003200060100000025198002000b006465736372697074696f6e015100000049742062656c6f6e677320746f20686f7573652027313835313934272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031333130303020676f6c6420636f696e732e0600646f6f726964020200000000b7003000070100000025198002000b006465736372697074696f6e015100000049742062656c6f6e677320746f20686f7573652027313835313934272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031333130303020676f6c6420636f696e732e0600646f6f726964020100000000),
(1701, 0, 0xad003200070100000042198002000b006465736372697074696f6e015200000049742062656c6f6e677320746f20686f757365202731353631383531272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303730303020676f6c6420636f696e732e0600646f6f726964020100000000ad003600060100000024198002000b006465736372697074696f6e015200000049742062656c6f6e677320746f20686f757365202731353631383531272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303730303020676f6c6420636f696e732e0600646f6f726964020200000000ad003600070100000024198002000b006465736372697074696f6e015200000049742062656c6f6e677320746f20686f757365202731353631383531272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303730303020676f6c6420636f696e732e0600646f6f726964020100000000b10030000701000000c5048002000b006465736372697074696f6e015200000049742062656c6f6e677320746f20686f757365202731353631383531272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303730303020676f6c6420636f696e732e0600646f6f726964020300000000b5003600070100000042198002000b006465736372697074696f6e015200000049742062656c6f6e677320746f20686f757365202731353631383531272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303730303020676f6c6420636f696e732e0600646f6f726964020100000000),
(1711, 0, 0x91003c00070100000042198002000b006465736372697074696f6e015900000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f75736520585839272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353030303020676f6c6420636f696e732e0600646f6f72696402010000000094003c00070100000042198002000b006465736372697074696f6e015900000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f75736520585839272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353030303020676f6c6420636f696e732e0600646f6f72696402010000000097003c00070100000042198002000b006465736372697074696f6e015900000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f75736520585839272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353030303020676f6c6420636f696e732e0600646f6f72696402010000000098003f00070100000008148002000b006465736372697074696f6e015900000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f75736520585839272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353030303020676f6c6420636f696e732e0600646f6f726964020200000000),
(1712, 0, 0x8f004300070100000043198002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f7573652050697473272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353630303020676f6c6420636f696e732e0600646f6f7269640201000000008f004600070100000043198002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f7573652050697473272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353630303020676f6c6420636f696e732e0600646f6f72696402020000000096004400070100000043190096004500070100000008148002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f7573652050697473272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353630303020676f6c6420636f696e732e0600646f6f72696402030000000096004600070100000043198002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f7573652050697473272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353630303020676f6c6420636f696e732e0600646f6f726964020200000000),
(1713, 0, 0x9c003f00070100000008148002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f7573652027426c6f6f64204369747920585832272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353030303020676f6c6420636f696e732e0600646f6f7269640202000000009e003c00070100000042198002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f7573652027426c6f6f64204369747920585832272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353030303020676f6c6420636f696e732e0600646f6f726964020100000000a0003c00070100000042198002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f7573652027426c6f6f64204369747920585832272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353030303020676f6c6420636f696e732e0600646f6f726964020100000000a3003c00070100000042198002000b006465736372697074696f6e015800000049742062656c6f6e677320746f20686f7573652027426c6f6f64204369747920585832272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353030303020676f6c6420636f696e732e0600646f6f726964020100000000),
(1714, 0, 0x9e004500070100000008148002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f7573652058583939272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353630303020676f6c6420636f696e732e0600646f6f7269640204000000009e004600070100000043198002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f7573652058583939272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353630303020676f6c6420636f696e732e0600646f6f726964020200000000a5004200070100000043198002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f7573652058583939272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353630303020676f6c6420636f696e732e0600646f6f726964020100000000a10047000701000000ff138002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f7573652058583939272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353630303020676f6c6420636f696e732e0600646f6f726964020300000000a5004600070100000043198002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f7573652058583939272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353630303020676f6c6420636f696e732e0600646f6f726964020200000000),
(1715, 0, 0x87001a00060200000024198002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f75736520313036272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303530303020676f6c6420636f696e732e0600646f6f72696402010000000024198002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f75736520313036272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303530303020676f6c6420636f696e732e0600646f6f72696402010000000083001e00060200000025198002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f75736520313036272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303530303020676f6c6420636f696e732e0600646f6f72696402010000000025198002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f75736520313036272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303530303020676f6c6420636f696e732e0600646f6f72696402010000000089001f000601000000c3048002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f75736520313036272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303530303020676f6c6420636f696e732e0600646f6f72696402010000000087002000060100000024198002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f75736520313036272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303530303020676f6c6420636f696e732e0600646f6f72696402010000000093003e00060100000008148002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f75736520313036272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303530303020676f6c6420636f696e732e0600646f6f72696402050000000095003c00050200000042198002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f75736520313036272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303530303020676f6c6420636f696e732e0600646f6f72696402030000000042198002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f75736520313036272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303530303020676f6c6420636f696e732e0600646f6f726964020300000000970041000601000000ff138002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f75736520313036272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303530303020676f6c6420636f696e732e0600646f6f726964020200000000);
INSERT INTO `house_data` (`house_id`, `world_id`, `data`) VALUES
(1716, 0, 0x89001b00050100000025198002000b006465736372697074696f6e015400000049742062656c6f6e677320746f20686f7573652027426c6f6f6420313536272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031343730303020676f6c6420636f696e732e0600646f6f72696402010000000083001d00050100000025198002000b006465736372697074696f6e015400000049742062656c6f6e677320746f20686f7573652027426c6f6f6420313536272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031343730303020676f6c6420636f696e732e0600646f6f72696402010000000089001d000501000000c3048002000b006465736372697074696f6e015400000049742062656c6f6e677320746f20686f7573652027426c6f6f6420313536272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031343730303020676f6c6420636f696e732e0600646f6f72696402010000000086002000050100000024198002000b006465736372697074696f6e015400000049742062656c6f6e677320746f20686f7573652027426c6f6f6420313536272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031343730303020676f6c6420636f696e732e0600646f6f72696402010000000096004200060100000008148002000b006465736372697074696f6e015400000049742062656c6f6e677320746f20686f7573652027426c6f6f6420313536272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031343730303020676f6c6420636f696e732e0600646f6f72696402010000000091004700050100000042190092004700050100000042190094004700050100000042190096004400050100000043198002000b006465736372697074696f6e015400000049742062656c6f6e677320746f20686f7573652027426c6f6f6420313536272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031343730303020676f6c6420636f696e732e0600646f6f72696402020000000096004500060100000043198002000b006465736372697074696f6e015400000049742062656c6f6e677320746f20686f7573652027426c6f6f6420313536272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031343730303020676f6c6420636f696e732e0600646f6f726964020100000000),
(1717, 0, 0xa5003f00050100000043198002000b006465736372697074696f6e015300000049742062656c6f6e677320746f20686f7573652027426c6f6f6420323632272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320373230303020676f6c6420636f696e732e0600646f6f726964020200000000a5003d00060100000043198002000b006465736372697074696f6e015300000049742062656c6f6e677320746f20686f7573652027426c6f6f6420323632272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320373230303020676f6c6420636f696e732e0600646f6f726964020100000000a5003e00060100000008148002000b006465736372697074696f6e015300000049742062656c6f6e677320746f20686f7573652027426c6f6f6420323632272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320373230303020676f6c6420636f696e732e0600646f6f726964020100000000a5003f00060100000008148002000b006465736372697074696f6e015300000049742062656c6f6e677320746f20686f7573652027426c6f6f6420323632272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320373230303020676f6c6420636f696e732e0600646f6f726964020100000000),
(1718, 0, 0x9e004500060100000008148002000b006465736372697074696f6e015400000049742062656c6f6e677320746f20686f7573652027426c6f6f6420343531272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303330303020676f6c6420636f696e732e0600646f6f726964020300000000a5004300060100000043198002000b006465736372697074696f6e015400000049742062656c6f6e677320746f20686f7573652027426c6f6f6420343531272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303330303020676f6c6420636f696e732e0600646f6f726964020100000000a1004700050100000042198002000b006465736372697074696f6e015400000049742062656c6f6e677320746f20686f7573652027426c6f6f6420343531272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303330303020676f6c6420636f696e732e0600646f6f726964020200000000a5004400050100000043198002000b006465736372697074696f6e015400000049742062656c6f6e677320746f20686f7573652027426c6f6f6420343531272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303330303020676f6c6420636f696e732e0600646f6f726964020200000000a5004400060100000008148002000b006465736372697074696f6e015400000049742062656c6f6e677320746f20686f7573652027426c6f6f6420343531272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303330303020676f6c6420636f696e732e0600646f6f726964020100000000a5004500060100000008148002000b006465736372697074696f6e015400000049742062656c6f6e677320746f20686f7573652027426c6f6f6420343531272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303330303020676f6c6420636f696e732e0600646f6f726964020100000000),
(1719, 0, 0x9c00220006010000002c198002000b006465736372697074696f6e015200000049742062656c6f6e677320746f20686f7573652027426c6f6f64203531272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363330303020676f6c6420636f696e732e0600646f6f7269640201000000009d002200060100000071188002000b006465736372697074696f6e015200000049742062656c6f6e677320746f20686f7573652027426c6f6f64203531272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363330303020676f6c6420636f696e732e0600646f6f726964020100000000),
(1720, 0, 0xa200220006010000002c198002000b006465736372697074696f6e015300000049742062656c6f6e677320746f20686f7573652027426c6f6f6420353731272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343830303020676f6c6420636f696e732e0600646f6f726964020100000000a4002200060100000071188002000b006465736372697074696f6e015300000049742062656c6f6e677320746f20686f7573652027426c6f6f6420353731272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343830303020676f6c6420636f696e732e0600646f6f726964020100000000),
(1721, 0, 0xb1001c0006010000008b158002000b006465736372697074696f6e015200000049742062656c6f6e677320746f20686f7573652027426c6f6f64203437272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353330303020676f6c6420636f696e732e0600646f6f726964020100000000),
(1722, 0, 0xb1001d0005010000008b158002000b006465736372697074696f6e015400000049742062656c6f6e677320746f20686f7573652027426c6f6f6420373831272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031333230303020676f6c6420636f696e732e0600646f6f726964020200000000b4001d000601000000d3238002000b006465736372697074696f6e015400000049742062656c6f6e677320746f20686f7573652027426c6f6f6420373831272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031333230303020676f6c6420636f696e732e0600646f6f726964020300000000),
(1723, 0, 0xb3001f0006010000008d158002000b006465736372697074696f6e015200000049742062656c6f6e677320746f20686f7573652027426c6f6f64203734272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353630303020676f6c6420636f696e732e0600646f6f726964020100000000),
(1724, 0, 0xae003b0006010000002c198002000b006465736372697074696f6e015200000049742062656c6f6e677320746f20686f7573652027426c6f6f64203731272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343030303020676f6c6420636f696e732e0600646f6f726964020400000000ac003d0006010000002d198002000b006465736372697074696f6e015200000049742062656c6f6e677320746f20686f7573652027426c6f6f64203731272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343030303020676f6c6420636f696e732e0600646f6f726964020100000000b0003c0006010000006f188002000b006465736372697074696f6e015200000049742062656c6f6e677320746f20686f7573652027426c6f6f64203731272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343030303020676f6c6420636f696e732e0600646f6f726964020200000000b0003d0006010000006f188002000b006465736372697074696f6e015200000049742062656c6f6e677320746f20686f7573652027426c6f6f64203731272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343030303020676f6c6420636f696e732e0600646f6f726964020200000000ac00420006010000002d198002000b006465736372697074696f6e015200000049742062656c6f6e677320746f20686f7573652027426c6f6f64203731272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343030303020676f6c6420636f696e732e0600646f6f726964020100000000),
(1725, 0, 0xaf003600050100000024198002000b006465736372697074696f6e015600000049742062656c6f6e677320746f20686f7573652027426c6f6f64204e6f737361272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031343430303020676f6c6420636f696e732e0600646f6f726964020100000000b10036000501000000c5048002000b006465736372697074696f6e015600000049742062656c6f6e677320746f20686f7573652027426c6f6f64204e6f737361272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031343430303020676f6c6420636f696e732e0600646f6f726964020300000000b4003600050100000024198002000b006465736372697074696f6e015600000049742062656c6f6e677320746f20686f7573652027426c6f6f64204e6f737361272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031343430303020676f6c6420636f696e732e0600646f6f726964020100000000),
(1726, 0, 0x93002e000601000000ff138002000b006465736372697074696f6e015400000049742062656c6f6e677320746f20686f7573652027426c6f6f64204b697473272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353230303020676f6c6420636f696e732e0600646f6f726964020300000000920033000601000000ff138002000b006465736372697074696f6e015400000049742062656c6f6e677320746f20686f7573652027426c6f6f64204b697473272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353230303020676f6c6420636f696e732e0600646f6f726964020100000000),
(1727, 0, 0x79002f000601000000f8288002000b006465736372697074696f6e015900000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f75736520585837272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363030303020676f6c6420636f696e732e0600646f6f7269640201000000007e00340006010000006f188002000b006465736372697074696f6e015900000049742062656c6f6e677320746f20686f7573652027426c6f6f6420486f75736520585837272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363030303020676f6c6420636f696e732e0600646f6f726964020100000000),
(1728, 0, 0x7e00370006010000006f188002000b006465736372697074696f6e015200000049742062656c6f6e677320746f20686f7573652027426c6f6f64205844272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363330303020676f6c6420636f696e732e0600646f6f7269640201000000007c003b00060100000071188002000b006465736372697074696f6e015200000049742062656c6f6e677320746f20686f7573652027426c6f6f64205844272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363330303020676f6c6420636f696e732e0600646f6f726964020200000000),
(1729, 0, 0x750033000402000000f9288002000b006465736372697074696f6e015400000049742062656c6f6e677320746f20686f7573652027426c6f6f6420583839272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031313430303020676f6c6420636f696e732e0600646f6f726964020100000000f9288002000b006465736372697074696f6e015400000049742062656c6f6e677320746f20686f7573652027426c6f6f6420583839272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031313430303020676f6c6420636f696e732e0600646f6f7269640201000000007e00350003010000006f188002000b006465736372697074696f6e015400000049742062656c6f6e677320746f20686f7573652027426c6f6f6420583839272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031313430303020676f6c6420636f696e732e0600646f6f7269640203000000007c00350004010000006f188002000b006465736372697074696f6e015400000049742062656c6f6e677320746f20686f7573652027426c6f6f6420583839272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031313430303020676f6c6420636f696e732e0600646f6f726964020200000000750038000402000000f9288002000b006465736372697074696f6e015400000049742062656c6f6e677320746f20686f7573652027426c6f6f6420583839272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031313430303020676f6c6420636f696e732e0600646f6f726964020100000000f9288002000b006465736372697074696f6e015400000049742062656c6f6e677320746f20686f7573652027426c6f6f6420583839272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031313430303020676f6c6420636f696e732e0600646f6f726964020100000000),
(1730, 0, 0xee0213040601000000c3048002000b006465736372697074696f6e014b00000049742062656c6f6e677320746f20686f757365202749272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333630303020676f6c6420636f696e732e0600646f6f726964020200000000),
(1731, 0, 0xeb020b040601000000c3048002000b006465736372697074696f6e014c00000049742062656c6f6e677320746f20686f75736520274949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343230303020676f6c6420636f696e732e0600646f6f726964020200000000),
(1732, 0, 0xcb021e040601000000c5048002000b006465736372697074696f6e014e00000049742062656c6f6e677320746f20686f7573652027494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732033363030303020676f6c6420636f696e732e0600646f6f726964020100000000cb021e040701000000c5048002000b006465736372697074696f6e014e00000049742062656c6f6e677320746f20686f7573652027494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732033363030303020676f6c6420636f696e732e0600646f6f726964020300000000cf021e040601000000c5048002000b006465736372697074696f6e014e00000049742062656c6f6e677320746f20686f7573652027494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732033363030303020676f6c6420636f696e732e0600646f6f726964020100000000cf021e040701000000c5048002000b006465736372697074696f6e014e00000049742062656c6f6e677320746f20686f7573652027494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732033363030303020676f6c6420636f696e732e0600646f6f726964020300000000d1021a040701000000bd048002000b006465736372697074696f6e014e00000049742062656c6f6e677320746f20686f7573652027494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732033363030303020676f6c6420636f696e732e0600646f6f726964020300000000d2021e040601000000c6048002000b006465736372697074696f6e014e00000049742062656c6f6e677320746f20686f7573652027494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732033363030303020676f6c6420636f696e732e0600646f6f726964020100000000d4021e040701000000c5048002000b006465736372697074696f6e014e00000049742062656c6f6e677320746f20686f7573652027494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732033363030303020676f6c6420636f696e732e0600646f6f726964020300000000cb0221040601000000c5048002000b006465736372697074696f6e014e00000049742062656c6f6e677320746f20686f7573652027494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732033363030303020676f6c6420636f696e732e0600646f6f726964020100000000cb0221040701000000c5048002000b006465736372697074696f6e014e00000049742062656c6f6e677320746f20686f7573652027494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732033363030303020676f6c6420636f696e732e0600646f6f726964020300000000cf0221040601000000c5048002000b006465736372697074696f6e014e00000049742062656c6f6e677320746f20686f7573652027494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732033363030303020676f6c6420636f696e732e0600646f6f726964020100000000cf0221040701000000c6048002000b006465736372697074696f6e014e00000049742062656c6f6e677320746f20686f7573652027494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732033363030303020676f6c6420636f696e732e0600646f6f726964020300000000d20221040601000000c6048002000b006465736372697074696f6e014e00000049742062656c6f6e677320746f20686f7573652027494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732033363030303020676f6c6420636f696e732e0600646f6f726964020100000000d40221040701000000c6048002000b006465736372697074696f6e014e00000049742062656c6f6e677320746f20686f7573652027494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732033363030303020676f6c6420636f696e732e0600646f6f726964020300000000),
(1733, 0, 0xc8022f0407010000006c188002000b006465736372697074696f6e014d00000049742062656c6f6e677320746f20686f75736520274956272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031353230303020676f6c6420636f696e732e0600646f6f726964020100000000cd022e0406010000006c188002000b006465736372697074696f6e014d00000049742062656c6f6e677320746f20686f75736520274956272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031353230303020676f6c6420636f696e732e0600646f6f726964020200000000cf022e0407010000002d198002000b006465736372697074696f6e014d00000049742062656c6f6e677320746f20686f75736520274956272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031353230303020676f6c6420636f696e732e0600646f6f726964020100000000c902320407010000002c198002000b006465736372697074696f6e014d00000049742062656c6f6e677320746f20686f75736520274956272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031353230303020676f6c6420636f696e732e0600646f6f726964020100000000cb023204070100000071188002000b006465736372697074696f6e014d00000049742062656c6f6e677320746f20686f75736520274956272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031353230303020676f6c6420636f696e732e0600646f6f726964020100000000cf02300406010000002d198002000b006465736372697074696f6e014d00000049742062656c6f6e677320746f20686f75736520274956272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031353230303020676f6c6420636f696e732e0600646f6f726964020200000000cd02320407010000002c198002000b006465736372697074696f6e014d00000049742062656c6f6e677320746f20686f75736520274956272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031353230303020676f6c6420636f696e732e0600646f6f726964020100000000cf02300407010000002d198002000b006465736372697074696f6e014d00000049742062656c6f6e677320746f20686f75736520274956272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031353230303020676f6c6420636f696e732e0600646f6f726964020100000000),
(1734, 0, 0xc3022e0406010000006c188002000b006465736372697074696f6e014b00000049742062656c6f6e677320746f20686f757365202756272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393030303020676f6c6420636f696e732e0600646f6f726964020200000000c3023204070100000071188002000b006465736372697074696f6e014b00000049742062656c6f6e677320746f20686f757365202756272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393030303020676f6c6420636f696e732e0600646f6f726964020100000000),
(1735, 0, 0xc3023704060100000069188002000b006465736372697074696f6e014c00000049742062656c6f6e677320746f20686f75736520275649272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320373830303020676f6c6420636f696e732e0600646f6f726964020200000000c3023504070100000071188002000b006465736372697074696f6e014c00000049742062656c6f6e677320746f20686f75736520275649272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320373830303020676f6c6420636f696e732e0600646f6f726964020100000000c302390407010000002c198002000b006465736372697074696f6e014c00000049742062656c6f6e677320746f20686f75736520275649272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320373830303020676f6c6420636f696e732e0600646f6f726964020100000000c402390406010000002c198002000b006465736372697074696f6e014c00000049742062656c6f6e677320746f20686f75736520275649272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320373830303020676f6c6420636f696e732e0600646f6f726964020200000000c402390407010000002c198002000b006465736372697074696f6e014c00000049742062656c6f6e677320746f20686f75736520275649272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320373830303020676f6c6420636f696e732e0600646f6f726964020100000000),
(1736, 0, 0xcb023504070100000071188002000b006465736372697074696f6e014e00000049742062656c6f6e677320746f20686f7573652027564949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031393530303020676f6c6420636f696e732e0600646f6f726964020400000000c902380406010000006c188002000b006465736372697074696f6e014e00000049742062656c6f6e677320746f20686f7573652027564949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031393530303020676f6c6420636f696e732e0600646f6f726964020300000000ca02390407010000006c188002000b006465736372697074696f6e014e00000049742062656c6f6e677320746f20686f7573652027564949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031393530303020676f6c6420636f696e732e0600646f6f726964020100000000c9023d0406010000002c198002000b006465736372697074696f6e014e00000049742062656c6f6e677320746f20686f7573652027564949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031393530303020676f6c6420636f696e732e0600646f6f726964020300000000c9023d0407010000002c198002000b006465736372697074696f6e014e00000049742062656c6f6e677320746f20686f7573652027564949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031393530303020676f6c6420636f696e732e0600646f6f726964020100000000d0023a0407010000002d198002000b006465736372697074696f6e014e00000049742062656c6f6e677320746f20686f7573652027564949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031393530303020676f6c6420636f696e732e0600646f6f726964020200000000),
(1737, 0, 0xdf02420407010000006f188002000b006465736372697074696f6e014f00000049742062656c6f6e677320746f20686f757365202756494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031333530303020676f6c6420636f696e732e0600646f6f726964020100000000d702450407010000006c188002000b006465736372697074696f6e014f00000049742062656c6f6e677320746f20686f757365202756494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031333530303020676f6c6420636f696e732e0600646f6f726964020100000000df02460406010000002d198002000b006465736372697074696f6e014f00000049742062656c6f6e677320746f20686f757365202756494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031333530303020676f6c6420636f696e732e0600646f6f726964020300000000dc02440407010000006c188002000b006465736372697074696f6e014f00000049742062656c6f6e677320746f20686f757365202756494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031333530303020676f6c6420636f696e732e0600646f6f726964020100000000df02460407010000002d198002000b006465736372697074696f6e014f00000049742062656c6f6e677320746f20686f757365202756494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031333530303020676f6c6420636f696e732e0600646f6f726964020100000000dc02480406010000002c198002000b006465736372697074696f6e014f00000049742062656c6f6e677320746f20686f757365202756494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031333530303020676f6c6420636f696e732e0600646f6f726964020300000000dd02480406010000002c198002000b006465736372697074696f6e014f00000049742062656c6f6e677320746f20686f757365202756494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031333530303020676f6c6420636f696e732e0600646f6f726964020300000000dc02480407010000002c198002000b006465736372697074696f6e014f00000049742062656c6f6e677320746f20686f757365202756494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031333530303020676f6c6420636f696e732e0600646f6f726964020100000000dd02480407010000002c198002000b006465736372697074696f6e014f00000049742062656c6f6e677320746f20686f757365202756494949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031333530303020676f6c6420636f696e732e0600646f6f726964020100000000),
(1738, 0, 0xf8024304070100000027198002000b006465736372697074696f6e014c00000049742062656c6f6e677320746f20686f75736520274958272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363430303020676f6c6420636f696e732e0600646f6f726964020100000000f1024404070100000027198002000b006465736372697074696f6e014c00000049742062656c6f6e677320746f20686f75736520274958272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363430303020676f6c6420636f696e732e0600646f6f726964020100000000f1024504070100000027198002000b006465736372697074696f6e014c00000049742062656c6f6e677320746f20686f75736520274958272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363430303020676f6c6420636f696e732e0600646f6f726964020100000000f80245040701000000ba048002000b006465736372697074696f6e014c00000049742062656c6f6e677320746f20686f75736520274958272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363430303020676f6c6420636f696e732e0600646f6f726964020100000000f8024704070100000027198002000b006465736372697074696f6e014c00000049742062656c6f6e677320746f20686f75736520274958272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363430303020676f6c6420636f696e732e0600646f6f726964020100000000f4024804070100000026198002000b006465736372697074696f6e014c00000049742062656c6f6e677320746f20686f75736520274958272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363430303020676f6c6420636f696e732e0600646f6f726964020100000000f6024804070100000026198002000b006465736372697074696f6e014c00000049742062656c6f6e677320746f20686f75736520274958272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363430303020676f6c6420636f696e732e0600646f6f726964020100000000),
(1739, 0, 0x03032e040701000000ba048002000b006465736372697074696f6e014b00000049742062656c6f6e677320746f20686f757365202758272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343930303020676f6c6420636f696e732e0600646f6f726964020100000000),
(1740, 0, 0x70002f000601000000fa280074002f000601000000fa288002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f75736520274465706f7420486f75736520544f50272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303230303020676f6c6420636f696e732e0600646f6f7269640201000000006d0032000601000000fb28006d0038000601000000fb280073003500060100000071188002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f75736520274465706f7420486f75736520544f50272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303230303020676f6c6420636f696e732e0600646f6f72696402010000000072003a00060100000071188002000b006465736372697074696f6e015a00000049742062656c6f6e677320746f20686f75736520274465706f7420486f75736520544f50272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303230303020676f6c6420636f696e732e0600646f6f726964020200000000),
(1741, 0, 0x6f00b9000601000000d20d8002000b006465736372697074696f6e015300000049742062656c6f6e677320746f20686f75736520274d61636f6e68612049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320383030303020676f6c6420636f696e732e0600646f6f726964020200000000),
(1742, 0, 0xb4003f0006010000002c198002000b006465736372697074696f6e014e00000049742062656c6f6e677320746f20686f757365202741657777272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393130303020676f6c6420636f696e732e0600646f6f726964020200000000af00460006010000002d198002000b006465736372697074696f6e014e00000049742062656c6f6e677320746f20686f757365202741657777272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393130303020676f6c6420636f696e732e0600646f6f726964020300000000af0046000701000000f9288002000b006465736372697074696f6e014e00000049742062656c6f6e677320746f20686f757365202741657777272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393130303020676f6c6420636f696e732e0600646f6f726964020100000000b3004700060100000071188002000b006465736372697074696f6e014e00000049742062656c6f6e677320746f20686f757365202741657777272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393130303020676f6c6420636f696e732e0600646f6f726964020400000000b0004400070100000071188002000b006465736372697074696f6e014e00000049742062656c6f6e677320746f20686f757365202741657777272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393130303020676f6c6420636f696e732e0600646f6f726964020100000000b200450007010000004c0700),
(1743, 0, 0x910020000701000000d5238002000b006465736372697074696f6e015e00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f757365202331373433272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303030303020676f6c6420636f696e732e0600646f6f726964020200000000910024000701000000d5238002000b006465736372697074696f6e015e00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f757365202331373433272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303030303020676f6c6420636f696e732e0600646f6f726964020100000000),
(1744, 0, 0x89001b00070100000043198002000b006465736372697074696f6e015d00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f757365202331373434272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343930303020676f6c6420636f696e732e0600646f6f72696402010000000085002000070100000042198002000b006465736372697074696f6e015d00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f757365202331373434272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343930303020676f6c6420636f696e732e0600646f6f726964020100000000860020000701000000ff138002000b006465736372697074696f6e015d00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f757365202331373434272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343930303020676f6c6420636f696e732e0600646f6f726964020100000000),
(1745, 0, 0x95001e000601000000d3238002000b006465736372697074696f6e015e00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f757365202331373435272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303030303020676f6c6420636f696e732e0600646f6f726964020100000000910020000601000000d5238002000b006465736372697074696f6e015e00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f757365202331373435272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303030303020676f6c6420636f696e732e0600646f6f726964020100000000),
(1746, 0, 0x92001e000501000000d3238002000b006465736372697074696f6e015d00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f757365202331373436272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343230303020676f6c6420636f696e732e0600646f6f726964020100000000),
(1747, 0, 0x75003f000501000000f9288002000b006465736372697074696f6e015700000049742062656c6f6e677320746f20686f757365202756696c6c616765204d616c6c272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031313030303020676f6c6420636f696e732e0600646f6f7269640203000000007b003d000501000000f9288002000b006465736372697074696f6e015700000049742062656c6f6e677320746f20686f757365202756696c6c616765204d616c6c272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031313030303020676f6c6420636f696e732e0600646f6f7269640203000000007b003e0006010000006f188002000b006465736372697074696f6e015700000049742062656c6f6e677320746f20686f757365202756696c6c616765204d616c6c272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031313030303020676f6c6420636f696e732e0600646f6f72696402050000000078003e0007010000002c198002000b006465736372697074696f6e015700000049742062656c6f6e677320746f20686f757365202756696c6c616765204d616c6c272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031313030303020676f6c6420636f696e732e0600646f6f726964020100000000750040000601000000f9288002000b006465736372697074696f6e015700000049742062656c6f6e677320746f20686f757365202756696c6c616765204d616c6c272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031313030303020676f6c6420636f696e732e0600646f6f7269640202000000007b0040000501000000fb288002000b006465736372697074696f6e015700000049742062656c6f6e677320746f20686f757365202756696c6c616765204d616c6c272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031313030303020676f6c6420636f696e732e0600646f6f726964020400000000);

-- --------------------------------------------------------

--
-- Estrutura da tabela `house_lists`
--

CREATE TABLE IF NOT EXISTS `house_lists` (
  `house_id` int(10) unsigned NOT NULL,
  `world_id` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `listid` int(11) NOT NULL,
  `list` text NOT NULL,
  UNIQUE KEY `house_id` (`house_id`,`world_id`,`listid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `killers`
--

CREATE TABLE IF NOT EXISTS `killers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `death_id` int(11) NOT NULL,
  `final_hit` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `unjustified` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `war` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `death_id` (`death_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `marriage_system`
--

CREATE TABLE IF NOT EXISTS `marriage_system` (
  `id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `partner` varchar(255) NOT NULL,
  `marriage_date` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `players`
--

CREATE TABLE IF NOT EXISTS `players` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `world_id` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `group_id` int(11) NOT NULL DEFAULT '1',
  `account_id` int(11) NOT NULL DEFAULT '0',
  `level` int(11) NOT NULL DEFAULT '1',
  `vocation` int(11) NOT NULL DEFAULT '0',
  `health` int(11) NOT NULL DEFAULT '150',
  `healthmax` int(11) NOT NULL DEFAULT '150',
  `experience` bigint(20) NOT NULL DEFAULT '0',
  `lookbody` int(11) NOT NULL DEFAULT '0',
  `lookfeet` int(11) NOT NULL DEFAULT '0',
  `lookhead` int(11) NOT NULL DEFAULT '0',
  `looklegs` int(11) NOT NULL DEFAULT '0',
  `looktype` int(11) NOT NULL DEFAULT '136',
  `lookaddons` int(11) NOT NULL DEFAULT '0',
  `maglevel` int(11) NOT NULL DEFAULT '0',
  `mana` int(11) NOT NULL DEFAULT '0',
  `manamax` int(11) NOT NULL DEFAULT '0',
  `manaspent` int(11) NOT NULL DEFAULT '0',
  `soul` int(10) unsigned NOT NULL DEFAULT '0',
  `town_id` int(11) NOT NULL DEFAULT '0',
  `posx` int(11) NOT NULL DEFAULT '0',
  `posy` int(11) NOT NULL DEFAULT '0',
  `posz` int(11) NOT NULL DEFAULT '0',
  `conditions` blob NOT NULL,
  `cap` int(11) NOT NULL DEFAULT '0',
  `sex` int(11) NOT NULL DEFAULT '0',
  `lastlogin` bigint(20) unsigned NOT NULL DEFAULT '0',
  `lastip` int(10) unsigned NOT NULL DEFAULT '0',
  `save` tinyint(1) NOT NULL DEFAULT '1',
  `skull` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `skulltime` int(11) NOT NULL DEFAULT '0',
  `rank_id` int(11) NOT NULL DEFAULT '0',
  `guildnick` varchar(255) NOT NULL DEFAULT '',
  `join_date` bigint(20) NOT NULL,
  `lastlogout` bigint(20) unsigned NOT NULL DEFAULT '0',
  `blessings` tinyint(2) NOT NULL DEFAULT '0',
  `balance` bigint(20) NOT NULL DEFAULT '0',
  `stamina` bigint(20) NOT NULL DEFAULT '151200000' COMMENT 'stored in miliseconds',
  `direction` int(11) NOT NULL DEFAULT '2',
  `loss_experience` int(11) NOT NULL DEFAULT '100',
  `loss_mana` int(11) NOT NULL DEFAULT '100',
  `loss_skills` int(11) NOT NULL DEFAULT '100',
  `loss_containers` int(11) NOT NULL DEFAULT '100',
  `loss_items` int(11) NOT NULL DEFAULT '100',
  `premend` int(11) NOT NULL DEFAULT '0' COMMENT 'NOT IN USE BY THE SERVER',
  `online` tinyint(1) NOT NULL DEFAULT '0',
  `marriage` int(10) unsigned NOT NULL DEFAULT '0',
  `marrystatus` int(10) unsigned NOT NULL DEFAULT '0',
  `promotion` int(11) NOT NULL DEFAULT '0',
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `description` varchar(255) NOT NULL DEFAULT '',
  `created` int(11) NOT NULL DEFAULT '0',
  `nick_verify` int(11) NOT NULL DEFAULT '0',
  `old_name` varchar(255) NOT NULL DEFAULT '',
  `hide_char` int(11) NOT NULL DEFAULT '0',
  `worldtransfer` int(11) NOT NULL DEFAULT '0',
  `comment` text NOT NULL,
  `show_outfit` tinyint(4) NOT NULL DEFAULT '1',
  `show_eq` tinyint(4) NOT NULL DEFAULT '1',
  `show_bars` tinyint(4) NOT NULL DEFAULT '1',
  `show_skills` tinyint(4) NOT NULL DEFAULT '1',
  `show_quests` tinyint(4) NOT NULL DEFAULT '1',
  `rep` int(11) NOT NULL DEFAULT '0' COMMENT 'Cyber''s REPSystem © OTLand.net',
  `cast` tinyint(4) NOT NULL DEFAULT '0',
  `castViewers` int(11) NOT NULL DEFAULT '0',
  `castDescription` varchar(255) NOT NULL,
  `frags` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`deleted`),
  KEY `account_id` (`account_id`),
  KEY `group_id` (`group_id`),
  KEY `online` (`online`),
  KEY `deleted` (`deleted`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=25 ;

--
-- Extraindo dados da tabela `players`
--

INSERT INTO `players` (`id`, `name`, `world_id`, `group_id`, `account_id`, `level`, `vocation`, `health`, `healthmax`, `experience`, `lookbody`, `lookfeet`, `lookhead`, `looklegs`, `looktype`, `lookaddons`, `maglevel`, `mana`, `manamax`, `manaspent`, `soul`, `town_id`, `posx`, `posy`, `posz`, `conditions`, `cap`, `sex`, `lastlogin`, `lastip`, `save`, `skull`, `skulltime`, `rank_id`, `guildnick`, `join_date`, `lastlogout`, `blessings`, `balance`, `stamina`, `direction`, `loss_experience`, `loss_mana`, `loss_skills`, `loss_containers`, `loss_items`, `premend`, `online`, `marriage`, `marrystatus`, `promotion`, `deleted`, `description`, `created`, `nick_verify`, `old_name`, `hide_char`, `worldtransfer`, `comment`, `show_outfit`, `show_eq`, `show_bars`, `show_skills`, `show_quests`, `rep`, `cast`, `castViewers`, `castDescription`, `frags`) VALUES
(1, 'Account Manager', 0, 1, 1, 1, 0, 150, 150, 0, 30, 50, 20, 40, 54, 0, 0, 0, 0, 0, 0, 0, 160, 51, 7, '', 400, 0, 1488528314, 2498786954, 0, 0, 0, 0, '', 0, 0, 0, 0, 201660000, 0, 100, 100, 100, 100, 100, 0, 0, 0, 0, 0, 0, '', 0, 0, '', 0, 0, '', 1, 1, 1, 1, 1, 0, 0, 0, '', 0),
(24, 'GOD Raymond', 0, 6, 9691164, 8, 2, 185, 185, 4200, 68, 76, 78, 39, 302, 0, 1, 35, 35, 0, 99, 1, 160, 51, 7, '', 435, 1, 1488528323, 2498786954, 1, 0, 0, 0, '', 0, 1488528327, 0, 0, 151200000, 2, 100, 100, 100, 100, 100, 0, 0, 0, 0, 0, 0, '', 0, 0, '', 0, 0, '', 1, 1, 1, 1, 1, 0, 0, 0, '', 0);

--
-- Gatilhos `players`
--
DROP TRIGGER IF EXISTS `oncreate_players`;
DELIMITER //
CREATE TRIGGER `oncreate_players` AFTER INSERT ON `players`
 FOR EACH ROW BEGIN
INSERT INTO `player_skills` (`player_id`, `skillid`, `value`) VALUES (NEW.`id`, 0, 10);
INSERT INTO `player_skills` (`player_id`, `skillid`, `value`) VALUES (NEW.`id`, 1, 10);
INSERT INTO `player_skills` (`player_id`, `skillid`, `value`) VALUES (NEW.`id`, 2, 10);
INSERT INTO `player_skills` (`player_id`, `skillid`, `value`) VALUES (NEW.`id`, 3, 10);
INSERT INTO `player_skills` (`player_id`, `skillid`, `value`) VALUES (NEW.`id`, 4, 10);
INSERT INTO `player_skills` (`player_id`, `skillid`, `value`) VALUES (NEW.`id`, 5, 10);
INSERT INTO `player_skills` (`player_id`, `skillid`, `value`) VALUES (NEW.`id`, 6, 10);
END
//
DELIMITER ;
DROP TRIGGER IF EXISTS `ondelete_players`;
DELIMITER //
CREATE TRIGGER `ondelete_players` BEFORE DELETE ON `players`
 FOR EACH ROW BEGIN
DELETE FROM `bans` WHERE `type` IN (2, 5) AND `value` = OLD.`id`;
UPDATE `houses` SET `owner` = 0 WHERE `owner` = OLD.`id`;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `player_deaths`
--

CREATE TABLE IF NOT EXISTS `player_deaths` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `date` bigint(20) unsigned NOT NULL,
  `level` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `date` (`date`),
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `player_depotitems`
--

CREATE TABLE IF NOT EXISTS `player_depotitems` (
  `player_id` int(11) NOT NULL,
  `sid` int(11) NOT NULL COMMENT 'any given range, eg. 0-100 is reserved for depot lockers and all above 100 will be normal items inside depots',
  `pid` int(11) NOT NULL DEFAULT '0',
  `itemtype` int(11) NOT NULL,
  `count` int(11) NOT NULL DEFAULT '0',
  `attributes` blob NOT NULL,
  UNIQUE KEY `player_id_2` (`player_id`,`sid`),
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `player_items`
--

CREATE TABLE IF NOT EXISTS `player_items` (
  `player_id` int(11) NOT NULL DEFAULT '0',
  `pid` int(11) NOT NULL DEFAULT '0',
  `sid` int(11) NOT NULL DEFAULT '0',
  `itemtype` int(11) NOT NULL DEFAULT '0',
  `count` int(11) NOT NULL DEFAULT '0',
  `attributes` blob NOT NULL,
  UNIQUE KEY `player_id_2` (`player_id`,`sid`),
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `player_items`
--

INSERT INTO `player_items` (`player_id`, `pid`, `sid`, `itemtype`, `count`, `attributes`) VALUES
(24, 1, 101, 2457, 1, ''),
(24, 2, 102, 2173, 1, ''),
(24, 3, 103, 11235, 1, ''),
(24, 4, 104, 2463, 1, ''),
(24, 5, 105, 2525, 1, ''),
(24, 6, 106, 2182, 1, ''),
(24, 7, 107, 2647, 1, ''),
(24, 8, 108, 2643, 1, ''),
(24, 9, 109, 2124, 1, ''),
(24, 103, 110, 8602, 1, ''),
(24, 103, 111, 2120, 1, ''),
(24, 103, 112, 2554, 1, ''),
(24, 103, 113, 2160, 5, 0x0f05);

-- --------------------------------------------------------

--
-- Estrutura da tabela `player_killers`
--

CREATE TABLE IF NOT EXISTS `player_killers` (
  `kill_id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  KEY `kill_id` (`kill_id`),
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `player_namelocks`
--

CREATE TABLE IF NOT EXISTS `player_namelocks` (
  `player_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `new_name` varchar(255) NOT NULL,
  `date` bigint(20) NOT NULL DEFAULT '0',
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `player_skills`
--

CREATE TABLE IF NOT EXISTS `player_skills` (
  `player_id` int(11) NOT NULL DEFAULT '0',
  `skillid` tinyint(2) NOT NULL DEFAULT '0',
  `value` int(10) unsigned NOT NULL DEFAULT '0',
  `count` int(10) unsigned NOT NULL DEFAULT '0',
  UNIQUE KEY `player_id_2` (`player_id`,`skillid`),
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `player_skills`
--

INSERT INTO `player_skills` (`player_id`, `skillid`, `value`, `count`) VALUES
(24, 0, 10, 0),
(24, 1, 10, 0),
(24, 2, 10, 0),
(24, 3, 10, 0),
(24, 4, 10, 0),
(24, 5, 10, 0),
(24, 6, 10, 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `player_spells`
--

CREATE TABLE IF NOT EXISTS `player_spells` (
  `player_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  UNIQUE KEY `player_id_2` (`player_id`,`name`),
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `player_storage`
--

CREATE TABLE IF NOT EXISTS `player_storage` (
  `player_id` int(11) NOT NULL DEFAULT '0',
  `key` int(10) unsigned NOT NULL DEFAULT '0',
  `value` varchar(255) NOT NULL DEFAULT '0',
  UNIQUE KEY `player_id_2` (`player_id`,`key`),
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `player_storage`
--

INSERT INTO `player_storage` (`player_id`, `key`, `value`) VALUES
(24, 19387, '0'),
(24, 30001, '1'),
(24, 42300, '0'),
(24, 42301, '0'),
(24, 42302, '0'),
(24, 42303, '0'),
(24, 42304, '0'),
(24, 42305, '0'),
(24, 42306, '0'),
(24, 42307, '0'),
(24, 42308, '0'),
(24, 42309, '0'),
(24, 42310, '0'),
(24, 42311, '0'),
(24, 42312, '0'),
(24, 42313, '0'),
(24, 42314, '0'),
(24, 42315, '0'),
(24, 42316, '0'),
(24, 42317, '0'),
(24, 42318, '0'),
(24, 42319, '0'),
(24, 42320, '0'),
(24, 42321, '0'),
(24, 42322, '0'),
(24, 42323, '0'),
(24, 42324, '0'),
(24, 42325, '0'),
(24, 42326, '0'),
(24, 42327, '0'),
(24, 42328, '0'),
(24, 42329, '0'),
(24, 42350, '0'),
(24, 42352, '0'),
(24, 42355, '0'),
(24, 62666, '720'),
(24, 62668, '1488528327'),
(24, 725201, '0');

-- --------------------------------------------------------

--
-- Estrutura da tabela `player_viplist`
--

CREATE TABLE IF NOT EXISTS `player_viplist` (
  `player_id` int(11) NOT NULL,
  `vip_id` int(11) NOT NULL,
  UNIQUE KEY `player_id_2` (`player_id`,`vip_id`),
  KEY `player_id` (`player_id`),
  KEY `vip_id` (`vip_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `server_config`
--

CREATE TABLE IF NOT EXISTS `server_config` (
  `config` varchar(35) NOT NULL DEFAULT '',
  `value` varchar(255) NOT NULL DEFAULT '',
  UNIQUE KEY `config` (`config`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `server_config`
--

INSERT INTO `server_config` (`config`, `value`) VALUES
('db_version', '26'),
('encryption', '2'),
('vahash_key', '924J-9YIT-HO29-3N7W');

-- --------------------------------------------------------

--
-- Estrutura da tabela `server_motd`
--

CREATE TABLE IF NOT EXISTS `server_motd` (
  `id` int(10) unsigned NOT NULL,
  `world_id` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `text` text NOT NULL,
  UNIQUE KEY `id` (`id`,`world_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `server_motd`
--

INSERT INTO `server_motd` (`id`, `world_id`, `text`) VALUES
(399, 0, 'Bem vindo ao Styller Yourots!'),
(400, 0, 'Styller Serio! War System: !infowar');

-- --------------------------------------------------------

--
-- Estrutura da tabela `server_record`
--

CREATE TABLE IF NOT EXISTS `server_record` (
  `record` int(11) NOT NULL,
  `world_id` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `timestamp` bigint(20) NOT NULL,
  UNIQUE KEY `record` (`record`,`world_id`,`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `server_record`
--

INSERT INTO `server_record` (`record`, `world_id`, `timestamp`) VALUES
(1, 0, 1324519055);

-- --------------------------------------------------------

--
-- Estrutura da tabela `server_reports`
--

CREATE TABLE IF NOT EXISTS `server_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `world_id` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `player_id` int(11) NOT NULL DEFAULT '1',
  `posx` int(11) NOT NULL DEFAULT '0',
  `posy` int(11) NOT NULL DEFAULT '0',
  `posz` int(11) NOT NULL DEFAULT '0',
  `timestamp` bigint(20) NOT NULL DEFAULT '0',
  `report` text NOT NULL,
  `reads` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `world_id` (`world_id`),
  KEY `reads` (`reads`),
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `shop_npc`
--

CREATE TABLE IF NOT EXISTS `shop_npc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `count` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `price` int(11) NOT NULL DEFAULT '0',
  `date` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tiles`
--

CREATE TABLE IF NOT EXISTS `tiles` (
  `id` int(10) unsigned NOT NULL,
  `world_id` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `house_id` int(10) unsigned NOT NULL,
  `x` int(5) unsigned NOT NULL,
  `y` int(5) unsigned NOT NULL,
  `z` tinyint(2) unsigned NOT NULL,
  UNIQUE KEY `id` (`id`,`world_id`),
  KEY `x` (`x`,`y`,`z`),
  KEY `house_id` (`house_id`,`world_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `tiles`
--

INSERT INTO `tiles` (`id`, `world_id`, `house_id`, `x`, `y`, `z`) VALUES
(0, 0, 1, 156, 106, 7),
(1, 0, 6, 186, 39, 7),
(2, 0, 6, 191, 39, 7),
(3, 0, 6, 185, 40, 7),
(4, 0, 6, 190, 41, 7),
(5, 0, 6, 185, 45, 7),
(6, 0, 6, 186, 49, 7),
(7, 0, 42, 128, 62, 7),
(8, 0, 42, 130, 62, 7),
(9, 0, 42, 132, 62, 7),
(10, 0, 42, 126, 64, 7),
(11, 0, 42, 126, 66, 7),
(12, 0, 42, 128, 68, 7),
(13, 0, 42, 132, 68, 7),
(14, 0, 43, 129, 60, 5),
(15, 0, 43, 130, 66, 5),
(16, 0, 43, 129, 66, 6),
(17, 0, 43, 130, 66, 6),
(18, 0, 43, 132, 65, 6),
(19, 0, 56, 123, 63, 4),
(20, 0, 56, 123, 67, 5),
(21, 0, 56, 123, 67, 6),
(22, 0, 56, 123, 67, 7),
(23, 0, 56, 117, 69, 5),
(24, 0, 56, 117, 68, 7),
(25, 0, 56, 123, 69, 4),
(26, 0, 56, 123, 71, 5),
(27, 0, 56, 121, 70, 6),
(28, 0, 56, 121, 70, 7),
(29, 0, 56, 117, 72, 8),
(30, 0, 91, 128, 47, 5),
(31, 0, 91, 134, 50, 5),
(32, 0, 91, 128, 52, 5),
(33, 0, 92, 155, 52, 8),
(34, 0, 93, 169, 51, 8),
(35, 0, 93, 191, 80, 8),
(36, 0, 94, 157, 47, 8),
(37, 0, 95, 167, 46, 8),
(38, 0, 96, 181, 35, 8),
(39, 0, 96, 182, 35, 8),
(40, 0, 96, 183, 39, 8),
(41, 0, 97, 192, 35, 8),
(42, 0, 97, 193, 35, 8),
(43, 0, 97, 194, 39, 8),
(44, 0, 98, 202, 35, 8),
(45, 0, 98, 203, 35, 8),
(46, 0, 98, 203, 39, 8),
(47, 0, 99, 189, 45, 8),
(48, 0, 99, 190, 45, 8),
(49, 0, 99, 191, 48, 8),
(50, 0, 100, 203, 45, 8),
(51, 0, 100, 204, 45, 8),
(52, 0, 100, 203, 48, 8),
(53, 0, 101, 187, 54, 8),
(54, 0, 101, 188, 54, 8),
(55, 0, 101, 192, 53, 8),
(56, 0, 119, 141, 95, 6),
(57, 0, 120, 509, 62, 12),
(58, 0, 121, 509, 62, 11),
(59, 0, 122, 514, 75, 12),
(60, 0, 123, 515, 89, 12),
(61, 0, 124, 512, 88, 11),
(62, 0, 125, 507, 74, 11),
(63, 0, 126, 515, 102, 12),
(64, 0, 128, 512, 102, 11),
(65, 0, 129, 189, 33, 7),
(66, 0, 129, 192, 31, 7),
(67, 0, 129, 194, 33, 7),
(68, 0, 133, 194, 51, 7),
(69, 0, 137, 200, 38, 7),
(70, 0, 137, 202, 38, 7),
(71, 0, 137, 203, 38, 7),
(72, 0, 139, 199, 35, 6),
(73, 0, 139, 209, 38, 7),
(74, 0, 139, 210, 38, 7),
(75, 0, 139, 212, 36, 7),
(76, 0, 140, 207, 38, 6),
(77, 0, 140, 212, 34, 6),
(78, 0, 140, 210, 38, 6),
(79, 0, 140, 212, 36, 6),
(80, 0, 141, 200, 38, 6),
(81, 0, 141, 201, 38, 6),
(82, 0, 141, 204, 38, 6),
(83, 0, 209, 102, 732, 7),
(84, 0, 210, 103, 724, 7),
(85, 0, 211, 104, 739, 7),
(86, 0, 212, 118, 736, 7),
(87, 0, 213, 118, 726, 7),
(88, 0, 214, 121, 733, 6),
(89, 0, 215, 121, 730, 6),
(90, 0, 216, 117, 716, 6),
(91, 0, 216, 119, 718, 6),
(92, 0, 216, 120, 719, 7),
(93, 0, 216, 122, 718, 7),
(94, 0, 216, 117, 721, 7),
(95, 0, 216, 119, 722, 7),
(96, 0, 217, 138, 717, 6),
(97, 0, 218, 133, 720, 7),
(98, 0, 219, 138, 720, 7),
(99, 0, 220, 128, 729, 7),
(100, 0, 221, 119, 742, 7),
(101, 0, 222, 115, 754, 7),
(102, 0, 222, 117, 761, 7),
(103, 0, 223, 119, 757, 6),
(104, 0, 224, 147, 747, 7),
(105, 0, 225, 149, 725, 7),
(106, 0, 569, 637, 619, 7),
(107, 0, 569, 638, 619, 7),
(108, 0, 569, 632, 621, 6),
(109, 0, 569, 635, 623, 6),
(110, 0, 569, 634, 623, 7),
(111, 0, 569, 638, 623, 6),
(112, 0, 569, 639, 621, 6),
(113, 0, 569, 636, 621, 7),
(114, 0, 569, 637, 622, 7),
(115, 0, 569, 638, 622, 7),
(116, 0, 569, 641, 619, 7),
(117, 0, 569, 640, 622, 7),
(118, 0, 569, 640, 623, 7),
(119, 0, 569, 641, 620, 7),
(120, 0, 569, 641, 622, 7),
(121, 0, 570, 636, 629, 7),
(122, 0, 570, 637, 629, 7),
(123, 0, 570, 638, 631, 7),
(124, 0, 570, 639, 629, 7),
(125, 0, 570, 635, 633, 7),
(126, 0, 570, 638, 635, 7),
(127, 0, 570, 638, 638, 7),
(128, 0, 570, 639, 636, 7),
(129, 0, 570, 639, 637, 7),
(130, 0, 570, 640, 629, 7),
(131, 0, 570, 641, 630, 7),
(132, 0, 570, 641, 633, 7),
(133, 0, 570, 640, 636, 7),
(134, 0, 570, 640, 637, 7),
(135, 0, 571, 649, 627, 6),
(136, 0, 571, 650, 627, 6),
(137, 0, 571, 647, 628, 6),
(138, 0, 571, 646, 628, 7),
(139, 0, 571, 646, 629, 7),
(140, 0, 571, 647, 628, 7),
(141, 0, 571, 647, 629, 7),
(142, 0, 571, 651, 631, 6),
(143, 0, 571, 650, 630, 7),
(144, 0, 571, 651, 628, 7),
(145, 0, 571, 648, 633, 6),
(146, 0, 571, 651, 633, 7),
(147, 0, 571, 651, 635, 7),
(148, 0, 571, 647, 636, 7),
(149, 0, 571, 650, 636, 7),
(150, 0, 572, 655, 631, 6),
(151, 0, 572, 655, 632, 7),
(152, 0, 572, 659, 628, 6),
(153, 0, 572, 659, 631, 6),
(154, 0, 572, 656, 628, 7),
(155, 0, 572, 656, 629, 7),
(156, 0, 572, 657, 630, 7),
(157, 0, 572, 658, 628, 7),
(158, 0, 572, 658, 629, 7),
(159, 0, 572, 659, 628, 7),
(160, 0, 572, 658, 633, 6),
(161, 0, 572, 656, 633, 7),
(162, 0, 572, 659, 633, 7),
(163, 0, 572, 657, 636, 7),
(164, 0, 573, 664, 630, 7),
(165, 0, 573, 665, 630, 7),
(166, 0, 573, 664, 634, 7),
(167, 0, 573, 665, 634, 7),
(168, 0, 573, 666, 632, 7),
(169, 0, 573, 668, 635, 7),
(170, 0, 573, 664, 639, 7),
(171, 0, 573, 671, 638, 7),
(172, 0, 573, 672, 631, 7),
(173, 0, 573, 672, 633, 7),
(174, 0, 573, 668, 640, 7),
(175, 0, 574, 623, 628, 6),
(176, 0, 574, 623, 630, 6),
(177, 0, 574, 623, 631, 6),
(178, 0, 574, 619, 635, 6),
(179, 0, 574, 620, 635, 6),
(180, 0, 574, 622, 632, 7),
(181, 0, 574, 618, 638, 7),
(182, 0, 574, 622, 636, 6),
(183, 0, 574, 620, 639, 7),
(184, 0, 574, 621, 639, 7),
(185, 0, 574, 622, 636, 7),
(186, 0, 574, 624, 628, 6),
(187, 0, 574, 624, 630, 6),
(188, 0, 574, 624, 631, 6),
(189, 0, 574, 627, 628, 6),
(190, 0, 574, 627, 629, 6),
(191, 0, 574, 627, 631, 6),
(192, 0, 574, 624, 630, 7),
(193, 0, 574, 627, 628, 7),
(194, 0, 574, 627, 629, 7),
(195, 0, 574, 627, 631, 7),
(196, 0, 574, 628, 628, 6),
(197, 0, 574, 628, 629, 6),
(198, 0, 574, 628, 631, 6),
(199, 0, 574, 629, 630, 6),
(200, 0, 574, 628, 628, 7),
(201, 0, 574, 628, 629, 7),
(202, 0, 574, 628, 631, 7),
(203, 0, 574, 625, 635, 6),
(204, 0, 574, 627, 632, 6),
(205, 0, 574, 627, 632, 7),
(206, 0, 574, 628, 632, 6),
(207, 0, 574, 629, 635, 6),
(208, 0, 574, 628, 632, 7),
(209, 0, 574, 624, 638, 6),
(210, 0, 574, 626, 636, 6),
(211, 0, 574, 626, 637, 6),
(212, 0, 574, 627, 636, 6),
(213, 0, 574, 627, 637, 6),
(214, 0, 574, 624, 638, 7),
(215, 0, 574, 625, 636, 7),
(216, 0, 574, 627, 636, 7),
(217, 0, 574, 627, 637, 7),
(218, 0, 574, 627, 638, 7),
(219, 0, 574, 628, 636, 6),
(220, 0, 574, 628, 637, 6),
(221, 0, 574, 628, 636, 7),
(222, 0, 574, 628, 637, 7),
(223, 0, 574, 619, 640, 6),
(224, 0, 574, 620, 640, 6),
(225, 0, 574, 620, 640, 7),
(226, 0, 574, 621, 640, 7),
(227, 0, 575, 628, 646, 7),
(228, 0, 575, 628, 647, 7),
(229, 0, 575, 629, 646, 7),
(230, 0, 575, 629, 647, 7),
(231, 0, 575, 632, 646, 7),
(232, 0, 575, 638, 646, 7),
(233, 0, 576, 617, 647, 7),
(234, 0, 576, 622, 649, 6),
(235, 0, 576, 621, 648, 7),
(236, 0, 576, 622, 651, 7),
(237, 0, 576, 624, 647, 6),
(238, 0, 577, 602, 630, 7),
(239, 0, 577, 603, 630, 7),
(240, 0, 577, 603, 633, 7),
(241, 0, 577, 603, 634, 7),
(242, 0, 577, 604, 635, 6),
(243, 0, 577, 607, 635, 6),
(244, 0, 577, 604, 632, 7),
(245, 0, 577, 607, 635, 7),
(246, 0, 577, 609, 631, 6),
(247, 0, 577, 609, 633, 6),
(248, 0, 577, 609, 632, 7),
(249, 0, 578, 608, 639, 7),
(250, 0, 578, 607, 640, 7),
(251, 0, 578, 607, 641, 7),
(252, 0, 578, 607, 642, 7),
(253, 0, 578, 611, 642, 7),
(254, 0, 578, 613, 640, 7),
(255, 0, 579, 606, 645, 6),
(256, 0, 579, 607, 645, 6),
(257, 0, 579, 606, 649, 6),
(258, 0, 579, 606, 650, 6),
(259, 0, 579, 607, 649, 6),
(260, 0, 579, 607, 650, 6),
(261, 0, 579, 608, 646, 6),
(262, 0, 579, 610, 647, 6),
(263, 0, 579, 608, 651, 6),
(264, 0, 579, 610, 651, 6),
(265, 0, 579, 608, 651, 7),
(266, 0, 579, 610, 648, 7),
(267, 0, 579, 612, 648, 7),
(268, 0, 579, 612, 650, 7),
(269, 0, 580, 600, 651, 7),
(270, 0, 580, 598, 655, 7),
(271, 0, 580, 601, 653, 7),
(272, 0, 580, 601, 654, 7),
(273, 0, 580, 603, 652, 7),
(274, 0, 581, 596, 643, 7),
(275, 0, 581, 599, 645, 7),
(276, 0, 581, 600, 644, 7),
(277, 0, 581, 601, 644, 7),
(278, 0, 581, 602, 645, 7),
(279, 0, 584, 584, 632, 6),
(280, 0, 584, 584, 633, 6),
(281, 0, 584, 584, 635, 6),
(282, 0, 584, 585, 632, 6),
(283, 0, 584, 585, 633, 6),
(284, 0, 584, 585, 635, 6),
(285, 0, 584, 589, 632, 6),
(286, 0, 584, 586, 637, 6),
(287, 0, 584, 589, 636, 6),
(288, 0, 584, 591, 637, 6),
(289, 0, 584, 594, 634, 6),
(290, 0, 585, 572, 635, 7),
(291, 0, 585, 574, 635, 7),
(292, 0, 585, 572, 636, 7),
(293, 0, 585, 573, 637, 7),
(294, 0, 585, 574, 636, 7),
(295, 0, 585, 575, 639, 7),
(296, 0, 585, 573, 641, 7),
(297, 0, 585, 578, 641, 7),
(298, 0, 585, 580, 640, 7),
(299, 0, 586, 567, 646, 6),
(300, 0, 586, 568, 647, 6),
(301, 0, 586, 569, 647, 6),
(302, 0, 586, 572, 644, 6),
(303, 0, 586, 573, 644, 6),
(304, 0, 586, 574, 646, 6),
(305, 0, 586, 574, 647, 6),
(306, 0, 586, 574, 647, 7),
(307, 0, 586, 568, 648, 6),
(308, 0, 586, 569, 648, 6),
(309, 0, 586, 571, 649, 6),
(310, 0, 586, 570, 649, 7),
(311, 0, 586, 577, 646, 7),
(312, 0, 587, 572, 653, 7),
(313, 0, 587, 572, 654, 7),
(314, 0, 587, 574, 654, 7),
(315, 0, 587, 580, 654, 7),
(316, 0, 587, 577, 657, 7),
(317, 0, 587, 579, 658, 7),
(318, 0, 587, 579, 659, 7),
(319, 0, 587, 577, 660, 7),
(320, 0, 588, 604, 666, 7),
(321, 0, 588, 605, 664, 7),
(322, 0, 588, 605, 665, 7),
(323, 0, 588, 606, 664, 7),
(324, 0, 588, 606, 665, 7),
(325, 0, 588, 607, 670, 7),
(326, 0, 588, 609, 667, 7),
(327, 0, 588, 611, 666, 7),
(328, 0, 588, 612, 667, 7),
(329, 0, 588, 613, 667, 7),
(330, 0, 588, 614, 665, 7),
(331, 0, 588, 612, 668, 7),
(332, 0, 588, 604, 673, 7),
(333, 0, 588, 606, 674, 7),
(334, 0, 588, 606, 675, 7),
(335, 0, 588, 605, 676, 7),
(336, 0, 588, 609, 672, 7),
(337, 0, 588, 611, 673, 7),
(338, 0, 588, 612, 672, 7),
(339, 0, 588, 613, 672, 7),
(340, 0, 588, 614, 674, 7),
(341, 0, 588, 612, 676, 7),
(342, 0, 589, 622, 661, 7),
(343, 0, 589, 622, 662, 7),
(344, 0, 589, 623, 661, 7),
(345, 0, 589, 623, 662, 7),
(346, 0, 589, 622, 666, 7),
(347, 0, 589, 623, 670, 7),
(348, 0, 589, 625, 663, 7),
(349, 0, 589, 626, 663, 7),
(350, 0, 589, 626, 666, 7),
(351, 0, 589, 627, 665, 7),
(352, 0, 589, 626, 670, 7),
(353, 0, 589, 627, 669, 7),
(354, 0, 590, 632, 663, 7),
(355, 0, 590, 630, 664, 6),
(356, 0, 590, 630, 665, 6),
(357, 0, 590, 630, 664, 7),
(358, 0, 590, 630, 665, 7),
(359, 0, 590, 632, 666, 6),
(360, 0, 590, 633, 664, 6),
(361, 0, 590, 633, 665, 6),
(362, 0, 590, 632, 666, 7),
(363, 0, 590, 633, 664, 7),
(364, 0, 590, 633, 665, 7),
(365, 0, 590, 629, 669, 6),
(366, 0, 590, 631, 671, 7),
(367, 0, 590, 632, 671, 6),
(368, 0, 590, 633, 671, 7),
(369, 0, 590, 635, 669, 7),
(370, 0, 590, 636, 671, 6),
(371, 0, 590, 637, 669, 6),
(372, 0, 590, 639, 671, 7),
(373, 0, 590, 641, 669, 7),
(374, 0, 591, 572, 653, 6),
(375, 0, 591, 572, 654, 6),
(376, 0, 591, 574, 654, 6),
(377, 0, 591, 580, 655, 6),
(378, 0, 591, 580, 658, 6),
(379, 0, 591, 577, 660, 6),
(380, 0, 591, 579, 660, 6),
(381, 0, 592, 569, 658, 6),
(382, 0, 592, 570, 658, 6),
(383, 0, 592, 571, 659, 6),
(384, 0, 592, 570, 662, 6),
(385, 0, 592, 571, 661, 6),
(386, 0, 592, 567, 665, 6),
(387, 0, 592, 571, 664, 6),
(388, 0, 593, 644, 663, 7),
(389, 0, 593, 646, 663, 7),
(390, 0, 593, 644, 664, 7),
(391, 0, 593, 645, 667, 7),
(392, 0, 593, 646, 664, 7),
(393, 0, 593, 646, 665, 7),
(394, 0, 593, 646, 666, 7),
(395, 0, 593, 649, 667, 7),
(396, 0, 593, 651, 666, 7),
(397, 0, 593, 645, 670, 7),
(398, 0, 593, 647, 670, 7),
(399, 0, 593, 650, 670, 7),
(400, 0, 594, 656, 662, 7),
(401, 0, 594, 659, 661, 7),
(402, 0, 594, 659, 663, 7),
(403, 0, 594, 660, 661, 7),
(404, 0, 594, 660, 663, 7),
(405, 0, 594, 661, 663, 7),
(406, 0, 595, 656, 666, 7),
(407, 0, 595, 659, 665, 7),
(408, 0, 595, 660, 665, 7),
(409, 0, 595, 661, 667, 7),
(410, 0, 596, 656, 670, 7),
(411, 0, 596, 659, 671, 7),
(412, 0, 596, 660, 671, 7),
(413, 0, 596, 661, 671, 7),
(414, 0, 597, 656, 674, 7),
(415, 0, 597, 657, 673, 7),
(416, 0, 597, 658, 673, 7),
(417, 0, 597, 659, 673, 7),
(418, 0, 597, 660, 673, 7),
(419, 0, 597, 661, 675, 7),
(420, 0, 598, 656, 678, 7),
(421, 0, 598, 659, 677, 7),
(422, 0, 598, 659, 679, 7),
(423, 0, 598, 660, 677, 7),
(424, 0, 598, 660, 679, 7),
(425, 0, 598, 661, 679, 7),
(426, 0, 599, 657, 662, 6),
(427, 0, 599, 658, 661, 6),
(428, 0, 599, 659, 661, 6),
(429, 0, 599, 661, 663, 6),
(430, 0, 600, 657, 666, 6),
(431, 0, 600, 659, 665, 6),
(432, 0, 600, 660, 665, 6),
(433, 0, 600, 661, 667, 6),
(434, 0, 601, 657, 670, 6),
(435, 0, 601, 659, 669, 6),
(436, 0, 601, 659, 671, 6),
(437, 0, 601, 660, 669, 6),
(438, 0, 601, 660, 671, 6),
(439, 0, 601, 661, 671, 6),
(440, 0, 602, 657, 674, 6),
(441, 0, 602, 659, 673, 6),
(442, 0, 602, 660, 673, 6),
(443, 0, 602, 661, 675, 6),
(444, 0, 603, 657, 678, 6),
(445, 0, 603, 659, 679, 6),
(446, 0, 603, 660, 679, 6),
(447, 0, 603, 661, 679, 6),
(448, 0, 604, 627, 678, 6),
(449, 0, 604, 627, 677, 7),
(450, 0, 604, 631, 678, 6),
(451, 0, 604, 629, 679, 7),
(452, 0, 604, 630, 679, 7),
(453, 0, 604, 631, 677, 7),
(454, 0, 604, 626, 681, 6),
(455, 0, 604, 624, 680, 7),
(456, 0, 604, 627, 680, 7),
(457, 0, 604, 630, 681, 6),
(458, 0, 604, 629, 680, 7),
(459, 0, 604, 629, 681, 7),
(460, 0, 604, 630, 680, 7),
(461, 0, 605, 635, 676, 7),
(462, 0, 605, 635, 683, 7),
(463, 0, 605, 636, 681, 7),
(464, 0, 605, 638, 681, 7),
(465, 0, 605, 638, 682, 7),
(466, 0, 605, 638, 683, 7),
(467, 0, 605, 639, 681, 7),
(468, 0, 605, 639, 682, 7),
(469, 0, 605, 640, 678, 7),
(470, 0, 606, 650, 682, 7),
(471, 0, 606, 645, 687, 6),
(472, 0, 606, 646, 687, 6),
(473, 0, 606, 646, 686, 7),
(474, 0, 606, 649, 684, 6),
(475, 0, 606, 649, 686, 6),
(476, 0, 606, 652, 684, 7),
(477, 0, 606, 645, 688, 6),
(478, 0, 606, 646, 688, 6),
(479, 0, 606, 644, 688, 7),
(480, 0, 606, 649, 688, 6),
(481, 0, 606, 652, 688, 7),
(482, 0, 607, 637, 686, 7),
(483, 0, 607, 638, 686, 7),
(484, 0, 607, 636, 688, 7),
(485, 0, 607, 639, 688, 7),
(486, 0, 608, 631, 691, 7),
(487, 0, 608, 637, 690, 7),
(488, 0, 608, 638, 690, 7),
(489, 0, 608, 634, 694, 7),
(490, 0, 608, 636, 693, 7),
(491, 0, 608, 638, 694, 7),
(492, 0, 609, 634, 699, 7),
(493, 0, 609, 637, 699, 7),
(494, 0, 609, 633, 703, 7),
(495, 0, 609, 634, 700, 7),
(496, 0, 609, 636, 701, 7),
(497, 0, 609, 637, 700, 7),
(498, 0, 609, 638, 703, 7),
(499, 0, 609, 636, 704, 7),
(500, 0, 609, 637, 704, 7),
(501, 0, 610, 616, 699, 7),
(502, 0, 610, 617, 699, 7),
(503, 0, 610, 616, 702, 7),
(504, 0, 610, 616, 703, 7),
(505, 0, 610, 622, 700, 7),
(506, 0, 610, 622, 703, 7),
(507, 0, 610, 624, 701, 7),
(508, 0, 610, 624, 703, 7),
(509, 0, 610, 618, 704, 7),
(510, 0, 611, 611, 679, 7),
(511, 0, 611, 610, 683, 7),
(512, 0, 611, 611, 683, 7),
(513, 0, 611, 613, 681, 7),
(514, 0, 611, 617, 680, 6),
(515, 0, 611, 616, 682, 7),
(516, 0, 611, 617, 683, 7),
(517, 0, 611, 621, 683, 6),
(518, 0, 611, 621, 682, 7),
(519, 0, 611, 611, 685, 7),
(520, 0, 611, 612, 685, 7),
(521, 0, 611, 614, 684, 7),
(522, 0, 611, 616, 685, 7),
(523, 0, 611, 617, 684, 7),
(524, 0, 611, 617, 687, 7),
(525, 0, 611, 621, 687, 7),
(526, 0, 611, 611, 691, 6),
(527, 0, 611, 615, 691, 6),
(528, 0, 611, 619, 691, 6),
(529, 0, 611, 621, 689, 6),
(530, 0, 611, 611, 693, 6),
(531, 0, 611, 611, 694, 6),
(532, 0, 611, 611, 695, 6),
(533, 0, 611, 611, 692, 7),
(534, 0, 611, 611, 695, 7),
(535, 0, 611, 612, 693, 6),
(536, 0, 611, 612, 694, 6),
(537, 0, 611, 615, 693, 6),
(538, 0, 611, 615, 694, 6),
(539, 0, 611, 615, 695, 6),
(540, 0, 611, 612, 693, 7),
(541, 0, 611, 612, 694, 7),
(542, 0, 611, 614, 693, 7),
(543, 0, 611, 614, 694, 7),
(544, 0, 611, 615, 692, 7),
(545, 0, 611, 615, 695, 7),
(546, 0, 611, 616, 693, 6),
(547, 0, 611, 616, 694, 6),
(548, 0, 611, 619, 693, 6),
(549, 0, 611, 619, 694, 6),
(550, 0, 611, 619, 695, 6),
(551, 0, 611, 616, 693, 7),
(552, 0, 611, 616, 694, 7),
(553, 0, 611, 618, 693, 7),
(554, 0, 611, 618, 694, 7),
(555, 0, 611, 620, 693, 6),
(556, 0, 611, 620, 694, 6),
(557, 0, 611, 620, 692, 7),
(558, 0, 611, 621, 693, 7),
(559, 0, 612, 676, 638, 7),
(560, 0, 612, 677, 636, 7),
(561, 0, 612, 678, 636, 7),
(562, 0, 612, 678, 639, 7),
(563, 0, 612, 681, 639, 7),
(564, 0, 612, 682, 636, 7),
(565, 0, 612, 682, 637, 7),
(566, 0, 612, 683, 638, 7),
(567, 0, 613, 677, 631, 7),
(568, 0, 613, 681, 629, 7),
(569, 0, 613, 681, 630, 7),
(570, 0, 613, 682, 629, 7),
(571, 0, 613, 682, 630, 7),
(572, 0, 613, 683, 631, 7),
(573, 0, 614, 685, 623, 7),
(574, 0, 614, 686, 623, 7),
(575, 0, 614, 684, 625, 7),
(576, 0, 614, 685, 627, 7),
(577, 0, 614, 686, 627, 7),
(578, 0, 614, 687, 628, 7),
(579, 0, 614, 688, 624, 7),
(580, 0, 615, 683, 619, 7),
(581, 0, 615, 687, 618, 7),
(582, 0, 615, 687, 619, 7),
(583, 0, 615, 685, 620, 7),
(584, 0, 616, 692, 618, 7),
(585, 0, 616, 692, 619, 7),
(586, 0, 616, 696, 619, 7),
(587, 0, 616, 694, 621, 7),
(588, 0, 616, 695, 621, 7),
(589, 0, 617, 684, 613, 7),
(590, 0, 617, 685, 612, 7),
(591, 0, 617, 686, 612, 7),
(592, 0, 617, 686, 615, 7),
(593, 0, 617, 689, 613, 7),
(594, 0, 617, 689, 614, 7),
(595, 0, 617, 689, 615, 7),
(596, 0, 619, 192, 80, 8),
(597, 0, 619, 196, 82, 8),
(598, 0, 623, 121, 128, 7),
(599, 0, 626, 159, 124, 6),
(600, 0, 626, 163, 116, 7),
(601, 0, 626, 164, 118, 6),
(602, 0, 626, 162, 120, 6),
(603, 0, 626, 160, 121, 7),
(604, 0, 626, 166, 120, 7),
(605, 0, 626, 160, 125, 7),
(606, 0, 626, 163, 126, 7),
(607, 0, 626, 166, 124, 6),
(608, 0, 626, 166, 125, 7),
(609, 0, 1373, 284, 669, 6),
(610, 0, 1373, 284, 670, 6),
(611, 0, 1373, 285, 669, 6),
(612, 0, 1373, 286, 668, 6),
(613, 0, 1374, 287, 679, 6),
(614, 0, 1374, 291, 678, 7),
(615, 0, 1374, 289, 681, 7),
(616, 0, 1376, 309, 675, 7),
(617, 0, 1377, 314, 673, 6),
(618, 0, 1377, 316, 676, 6),
(619, 0, 1377, 316, 676, 7),
(620, 0, 1378, 317, 670, 7),
(621, 0, 1378, 319, 669, 7),
(622, 0, 1379, 324, 663, 7),
(623, 0, 1380, 334, 673, 5),
(624, 0, 1380, 332, 675, 6),
(625, 0, 1380, 330, 676, 7),
(626, 0, 1381, 340, 667, 7),
(627, 0, 1382, 334, 682, 7),
(628, 0, 1382, 332, 685, 7),
(629, 0, 1383, 311, 686, 7),
(630, 0, 1384, 301, 691, 7),
(631, 0, 1384, 298, 694, 7),
(632, 0, 1385, 297, 703, 7),
(633, 0, 1385, 294, 707, 6),
(634, 0, 1385, 299, 705, 7),
(635, 0, 1386, 323, 712, 7),
(636, 0, 1387, 281, 701, 5),
(637, 0, 1387, 282, 704, 6),
(638, 0, 1388, 283, 698, 5),
(639, 0, 1389, 343, 656, 4),
(640, 0, 1389, 343, 658, 4),
(641, 0, 1389, 341, 662, 3),
(642, 0, 1391, 588, 631, 7),
(643, 0, 1391, 589, 631, 7),
(644, 0, 1391, 591, 631, 7),
(645, 0, 1391, 587, 634, 7),
(646, 0, 1391, 589, 635, 7),
(647, 0, 1391, 591, 632, 7),
(648, 0, 1391, 585, 637, 7),
(649, 0, 1391, 588, 637, 7),
(650, 0, 1391, 589, 636, 7),
(651, 0, 1391, 593, 631, 7),
(652, 0, 1391, 593, 632, 7),
(653, 0, 1391, 593, 633, 7),
(654, 0, 1391, 596, 633, 7),
(655, 0, 1391, 598, 634, 7),
(656, 0, 1391, 594, 637, 7),
(657, 0, 1391, 596, 637, 7),
(658, 0, 1392, 114, 179, 7),
(659, 0, 1393, 114, 185, 7),
(660, 0, 1394, 126, 190, 7),
(661, 0, 1395, 107, 192, 7),
(662, 0, 1396, 107, 198, 7),
(663, 0, 1397, 113, 202, 7),
(664, 0, 1398, 121, 202, 7),
(665, 0, 1399, 150, 201, 7),
(666, 0, 1400, 150, 207, 7),
(667, 0, 1401, 136, 187, 7),
(668, 0, 1402, 141, 187, 7),
(669, 0, 1403, 152, 186, 7),
(670, 0, 1403, 156, 186, 7),
(671, 0, 1404, 190, 74, 6),
(672, 0, 1404, 190, 73, 7),
(673, 0, 1404, 190, 74, 7),
(674, 0, 1404, 190, 75, 7),
(675, 0, 1404, 191, 76, 6),
(676, 0, 1404, 192, 72, 6),
(677, 0, 1404, 194, 74, 6),
(678, 0, 1404, 193, 72, 7),
(679, 0, 1404, 194, 73, 7),
(680, 0, 1404, 194, 76, 6),
(681, 0, 1404, 194, 76, 7),
(682, 0, 1405, 177, 34, 7),
(683, 0, 1406, 171, 31, 7),
(684, 0, 1406, 173, 29, 7),
(685, 0, 1407, 166, 32, 7),
(686, 0, 1407, 162, 36, 7),
(687, 0, 1407, 163, 36, 7),
(688, 0, 1408, 154, 30, 7),
(689, 0, 1408, 157, 36, 7),
(690, 0, 1408, 158, 36, 7),
(691, 0, 1606, 1169, 1087, 7),
(692, 0, 1606, 1171, 1086, 7),
(693, 0, 1606, 1172, 1087, 6),
(694, 0, 1606, 1172, 1087, 7),
(695, 0, 1606, 1174, 1085, 7),
(696, 0, 1606, 1179, 1086, 6),
(697, 0, 1606, 1176, 1084, 7),
(698, 0, 1606, 1176, 1087, 7),
(699, 0, 1606, 1179, 1086, 7),
(700, 0, 1606, 1171, 1088, 6),
(701, 0, 1606, 1171, 1088, 7),
(702, 0, 1606, 1172, 1090, 6),
(703, 0, 1606, 1172, 1091, 7),
(704, 0, 1606, 1174, 1089, 7),
(705, 0, 1606, 1178, 1088, 6),
(706, 0, 1606, 1179, 1091, 6),
(707, 0, 1606, 1176, 1091, 7),
(708, 0, 1606, 1179, 1088, 7),
(709, 0, 1606, 1171, 1092, 6),
(710, 0, 1606, 1171, 1092, 7),
(711, 0, 1606, 1175, 1092, 6),
(712, 0, 1606, 1175, 1092, 7),
(713, 0, 1606, 1177, 1092, 6),
(714, 0, 1607, 1157, 1101, 7),
(715, 0, 1607, 1158, 1100, 7),
(716, 0, 1608, 1162, 1097, 6),
(717, 0, 1608, 1157, 1100, 6),
(718, 0, 1608, 1160, 1102, 7),
(719, 0, 1608, 1162, 1100, 7),
(720, 0, 1608, 1164, 1101, 7),
(721, 0, 1608, 1158, 1104, 6),
(722, 0, 1608, 1162, 1104, 6),
(723, 0, 1609, 1155, 1076, 7),
(724, 0, 1609, 1162, 1076, 7),
(725, 0, 1610, 1145, 1076, 7),
(726, 0, 1610, 1152, 1076, 7),
(727, 0, 1611, 1150, 1081, 7),
(728, 0, 1611, 1148, 1084, 7),
(729, 0, 1611, 1148, 1089, 7),
(730, 0, 1613, 1153, 1084, 7),
(731, 0, 1613, 1154, 1084, 7),
(732, 0, 1613, 1155, 1086, 8),
(733, 0, 1613, 1157, 1087, 7),
(734, 0, 1613, 1156, 1087, 8),
(735, 0, 1613, 1157, 1086, 8),
(736, 0, 1613, 1162, 1087, 7),
(737, 0, 1613, 1153, 1089, 7),
(738, 0, 1613, 1155, 1089, 7),
(739, 0, 1613, 1160, 1089, 7),
(740, 0, 1615, 1157, 1081, 7),
(741, 0, 1615, 1162, 1081, 7),
(742, 0, 1615, 1162, 1082, 7),
(743, 0, 1616, 1161, 1060, 7),
(744, 0, 1616, 1161, 1067, 7),
(745, 0, 1617, 1167, 1062, 7),
(746, 0, 1617, 1167, 1067, 7),
(747, 0, 1618, 1173, 1055, 7),
(748, 0, 1618, 1170, 1059, 7),
(749, 0, 1618, 1175, 1059, 7),
(750, 0, 1618, 1173, 1062, 7),
(751, 0, 1618, 1173, 1067, 7),
(752, 0, 1618, 1175, 1065, 7),
(753, 0, 1619, 1165, 1055, 7),
(754, 0, 1619, 1167, 1055, 7),
(755, 0, 1620, 1161, 1057, 7),
(756, 0, 1621, 1152, 1060, 7),
(757, 0, 1621, 1154, 1063, 7),
(758, 0, 1621, 1152, 1067, 7),
(759, 0, 1621, 1154, 1065, 7),
(760, 0, 1622, 1154, 1053, 7),
(761, 0, 1622, 1154, 1055, 7),
(762, 0, 1622, 1152, 1057, 7),
(763, 0, 1623, 1146, 1062, 7),
(764, 0, 1623, 1140, 1067, 7),
(765, 0, 1623, 1142, 1065, 7),
(766, 0, 1623, 1145, 1067, 7),
(767, 0, 1623, 1147, 1067, 7),
(768, 0, 1624, 1137, 1059, 7),
(769, 0, 1624, 1142, 1059, 7),
(770, 0, 1624, 1142, 1060, 7),
(771, 0, 1625, 1142, 1053, 7),
(772, 0, 1625, 1145, 1055, 7),
(773, 0, 1625, 1146, 1055, 7),
(774, 0, 1625, 1147, 1055, 7),
(775, 0, 1626, 1157, 1043, 7),
(776, 0, 1626, 1154, 1045, 7),
(777, 0, 1627, 1160, 1043, 7),
(778, 0, 1627, 1167, 1043, 7),
(779, 0, 1627, 1164, 1045, 7),
(780, 0, 1628, 1164, 1034, 7),
(781, 0, 1628, 1167, 1032, 7),
(782, 0, 1628, 1162, 1037, 7),
(783, 0, 1628, 1167, 1038, 7),
(784, 0, 1629, 1158, 1034, 7),
(785, 0, 1629, 1160, 1034, 7),
(786, 0, 1630, 1153, 1034, 7),
(787, 0, 1630, 1155, 1037, 7),
(788, 0, 1630, 1155, 1038, 7),
(789, 0, 1631, 1175, 1041, 7),
(790, 0, 1631, 1177, 1042, 6),
(791, 0, 1631, 1183, 1043, 6),
(792, 0, 1631, 1183, 1043, 7),
(793, 0, 1631, 1176, 1045, 6),
(794, 0, 1631, 1177, 1045, 7),
(795, 0, 1631, 1179, 1045, 7),
(796, 0, 1631, 1180, 1045, 6),
(797, 0, 1632, 1175, 1038, 7),
(798, 0, 1632, 1177, 1037, 6),
(799, 0, 1632, 1179, 1039, 7),
(800, 0, 1632, 1183, 1038, 6),
(801, 0, 1632, 1183, 1038, 7),
(802, 0, 1633, 1139, 1099, 6),
(803, 0, 1633, 1139, 1099, 7),
(804, 0, 1633, 1137, 1102, 6),
(805, 0, 1633, 1137, 1102, 7),
(806, 0, 1633, 1141, 1101, 6),
(807, 0, 1633, 1146, 1101, 6),
(808, 0, 1633, 1146, 1103, 7),
(809, 0, 1633, 1148, 1100, 6),
(810, 0, 1633, 1148, 1101, 7),
(811, 0, 1633, 1135, 1104, 7),
(812, 0, 1633, 1137, 1105, 6),
(813, 0, 1633, 1139, 1104, 6),
(814, 0, 1633, 1137, 1105, 7),
(815, 0, 1633, 1139, 1104, 7),
(816, 0, 1633, 1137, 1105, 8),
(817, 0, 1633, 1138, 1104, 8),
(818, 0, 1633, 1142, 1106, 6),
(819, 0, 1633, 1143, 1106, 6),
(820, 0, 1633, 1146, 1106, 6),
(821, 0, 1633, 1144, 1104, 7),
(822, 0, 1633, 1144, 1105, 7),
(823, 0, 1633, 1148, 1104, 6),
(824, 0, 1633, 1148, 1106, 7),
(825, 0, 1633, 1139, 1110, 6),
(826, 0, 1633, 1138, 1110, 7),
(827, 0, 1633, 1143, 1110, 7),
(828, 0, 1633, 1144, 1110, 6),
(829, 0, 1633, 1144, 1108, 7),
(830, 0, 1633, 1146, 1110, 7),
(831, 0, 1633, 1148, 1108, 6),
(832, 0, 1633, 1148, 1108, 7),
(833, 0, 1634, 1118, 1103, 7),
(834, 0, 1634, 1120, 1099, 6),
(835, 0, 1634, 1125, 1099, 6),
(836, 0, 1634, 1120, 1102, 7),
(837, 0, 1634, 1123, 1101, 7),
(838, 0, 1634, 1127, 1102, 6),
(839, 0, 1634, 1127, 1102, 7),
(840, 0, 1634, 1129, 1100, 6),
(841, 0, 1634, 1129, 1100, 7),
(842, 0, 1634, 1118, 1106, 6),
(843, 0, 1634, 1118, 1110, 6),
(844, 0, 1634, 1119, 1110, 7),
(845, 0, 1634, 1120, 1104, 6),
(846, 0, 1634, 1123, 1106, 6),
(847, 0, 1634, 1123, 1106, 7),
(848, 0, 1634, 1127, 1106, 6),
(849, 0, 1634, 1125, 1104, 7),
(850, 0, 1634, 1127, 1105, 7),
(851, 0, 1634, 1129, 1104, 6),
(852, 0, 1634, 1129, 1104, 7),
(853, 0, 1634, 1120, 1108, 6),
(854, 0, 1634, 1123, 1110, 6),
(855, 0, 1634, 1120, 1108, 7),
(856, 0, 1634, 1122, 1110, 7),
(857, 0, 1634, 1126, 1110, 6),
(858, 0, 1634, 1125, 1108, 7),
(859, 0, 1634, 1127, 1110, 7),
(860, 0, 1634, 1129, 1108, 6),
(861, 0, 1634, 1129, 1108, 7),
(862, 0, 1635, 1130, 1076, 7),
(863, 0, 1636, 1133, 1076, 7),
(864, 0, 1636, 1140, 1076, 7),
(865, 0, 1637, 1128, 1081, 7),
(866, 0, 1637, 1123, 1087, 7),
(867, 0, 1637, 1126, 1084, 7),
(868, 0, 1637, 1126, 1089, 7),
(869, 0, 1638, 1131, 1084, 7),
(870, 0, 1638, 1132, 1084, 7),
(871, 0, 1638, 1131, 1089, 7),
(872, 0, 1638, 1133, 1089, 7),
(873, 0, 1639, 1135, 1081, 7),
(874, 0, 1639, 1140, 1081, 7),
(875, 0, 1639, 1140, 1082, 7),
(876, 0, 1639, 1138, 1084, 7),
(877, 0, 1639, 1140, 1087, 7),
(878, 0, 1639, 1138, 1089, 7),
(879, 0, 1640, 1114, 1072, 7),
(880, 0, 1640, 1115, 1079, 7),
(881, 0, 1640, 1117, 1076, 7),
(882, 0, 1641, 1117, 1066, 7),
(883, 0, 1641, 1114, 1069, 7),
(884, 0, 1642, 1108, 1067, 7),
(885, 0, 1642, 1109, 1067, 7),
(886, 0, 1643, 1110, 1074, 7),
(887, 0, 1643, 1110, 1079, 7),
(888, 0, 1644, 1103, 1079, 7),
(889, 0, 1644, 1107, 1074, 7),
(890, 0, 1644, 1105, 1079, 7),
(891, 0, 1645, 1105, 1072, 7),
(892, 0, 1646, 1105, 1069, 7),
(893, 0, 1647, 1112, 1049, 7),
(894, 0, 1647, 1114, 1053, 7),
(895, 0, 1647, 1112, 1056, 7),
(896, 0, 1648, 1114, 1043, 7),
(897, 0, 1648, 1112, 1046, 7),
(898, 0, 1649, 1104, 1051, 7),
(899, 0, 1649, 1105, 1056, 7),
(900, 0, 1649, 1107, 1056, 7),
(901, 0, 1650, 1100, 1044, 7),
(902, 0, 1650, 1102, 1047, 7),
(903, 0, 1650, 1102, 1048, 7),
(904, 0, 1650, 1100, 1056, 7),
(905, 0, 1651, 1104, 1044, 7),
(906, 0, 1651, 1106, 1044, 7),
(907, 0, 1652, 1102, 1054, 6),
(908, 0, 1652, 1108, 1051, 6),
(909, 0, 1652, 1100, 1056, 6),
(910, 0, 1652, 1106, 1056, 6),
(911, 0, 1653, 1114, 1042, 6),
(912, 0, 1653, 1112, 1044, 6),
(913, 0, 1653, 1109, 1050, 6),
(914, 0, 1653, 1112, 1051, 6),
(915, 0, 1653, 1114, 1048, 6),
(916, 0, 1653, 1114, 1054, 6),
(917, 0, 1653, 1112, 1056, 6),
(918, 0, 1654, 1100, 1044, 6),
(919, 0, 1654, 1102, 1046, 6),
(920, 0, 1654, 1102, 1048, 6),
(921, 0, 1655, 1104, 1044, 6),
(922, 0, 1655, 1105, 1044, 6),
(923, 0, 1656, 1107, 1067, 6),
(924, 0, 1657, 1105, 1069, 6),
(925, 0, 1658, 1103, 1079, 6),
(926, 0, 1658, 1105, 1073, 6),
(927, 0, 1659, 1107, 1074, 6),
(928, 0, 1659, 1108, 1079, 6),
(929, 0, 1660, 1111, 1074, 6),
(930, 0, 1660, 1114, 1079, 6),
(931, 0, 1660, 1117, 1077, 6),
(932, 0, 1661, 1112, 1073, 6),
(933, 0, 1661, 1117, 1072, 6),
(934, 0, 1662, 1117, 1067, 6),
(935, 0, 1662, 1112, 1068, 6),
(936, 0, 1663, 1110, 1067, 6),
(937, 0, 1664, 1126, 1078, 6),
(938, 0, 1664, 1128, 1080, 6),
(939, 0, 1664, 1128, 1082, 6),
(940, 0, 1664, 1126, 1084, 6),
(941, 0, 1664, 1126, 1089, 6),
(942, 0, 1665, 1130, 1078, 6),
(943, 0, 1665, 1132, 1078, 6),
(944, 0, 1666, 1135, 1083, 6),
(945, 0, 1666, 1138, 1078, 6),
(946, 0, 1666, 1140, 1076, 6),
(947, 0, 1666, 1140, 1081, 6),
(948, 0, 1666, 1138, 1084, 6),
(949, 0, 1666, 1140, 1087, 6),
(950, 0, 1666, 1138, 1089, 6),
(951, 0, 1667, 1134, 1084, 6),
(952, 0, 1667, 1132, 1089, 6),
(953, 0, 1668, 1150, 1076, 6),
(954, 0, 1668, 1152, 1078, 6),
(955, 0, 1668, 1154, 1078, 6),
(956, 0, 1669, 1150, 1080, 6),
(957, 0, 1669, 1150, 1082, 6),
(958, 0, 1669, 1148, 1084, 6),
(959, 0, 1669, 1148, 1089, 6),
(960, 0, 1670, 1156, 1084, 6),
(961, 0, 1670, 1157, 1087, 6),
(962, 0, 1670, 1162, 1087, 6),
(963, 0, 1670, 1154, 1089, 6),
(964, 0, 1670, 1160, 1089, 6),
(965, 0, 1671, 1160, 1078, 6),
(966, 0, 1671, 1162, 1076, 6),
(967, 0, 1671, 1157, 1083, 6),
(968, 0, 1671, 1162, 1081, 6),
(969, 0, 1673, 1140, 1055, 6),
(970, 0, 1673, 1142, 1057, 6),
(971, 0, 1673, 1142, 1059, 6),
(972, 0, 1673, 1140, 1062, 6),
(973, 0, 1673, 1140, 1067, 6),
(974, 0, 1674, 1144, 1055, 6),
(975, 0, 1674, 1145, 1055, 6),
(976, 0, 1675, 1149, 1061, 6),
(977, 0, 1675, 1152, 1055, 6),
(978, 0, 1675, 1154, 1054, 6),
(979, 0, 1675, 1154, 1059, 6),
(980, 0, 1676, 1148, 1062, 6),
(981, 0, 1676, 1146, 1067, 6),
(982, 0, 1676, 1149, 1065, 6),
(983, 0, 1676, 1152, 1067, 6),
(984, 0, 1676, 1154, 1065, 6),
(985, 0, 1677, 1161, 1055, 6),
(986, 0, 1677, 1163, 1057, 6),
(987, 0, 1677, 1163, 1059, 6),
(988, 0, 1677, 1161, 1062, 6),
(989, 0, 1677, 1161, 1067, 6),
(990, 0, 1678, 1167, 1067, 6),
(991, 0, 1678, 1169, 1062, 6),
(992, 0, 1679, 1173, 1055, 6),
(993, 0, 1679, 1175, 1059, 6),
(994, 0, 1679, 1170, 1061, 6),
(995, 0, 1679, 1173, 1062, 6),
(996, 0, 1679, 1173, 1067, 6),
(997, 0, 1679, 1175, 1065, 6),
(998, 0, 1680, 1165, 1055, 6),
(999, 0, 1680, 1166, 1055, 6),
(1000, 0, 1681, 1161, 1040, 6),
(1001, 0, 1681, 1162, 1043, 6),
(1002, 0, 1681, 1167, 1043, 6),
(1003, 0, 1681, 1159, 1045, 6),
(1004, 0, 1681, 1165, 1045, 6),
(1005, 0, 1683, 1155, 1036, 6),
(1006, 0, 1683, 1155, 1038, 6),
(1007, 0, 1683, 1153, 1040, 6),
(1008, 0, 1683, 1153, 1045, 6),
(1009, 0, 1684, 1165, 1034, 6),
(1010, 0, 1684, 1167, 1032, 6),
(1011, 0, 1684, 1162, 1039, 6),
(1012, 0, 1684, 1167, 1037, 6),
(1013, 0, 1685, 1155, 1032, 6),
(1014, 0, 1685, 1157, 1034, 6),
(1015, 0, 1685, 1159, 1034, 6),
(1016, 0, 1686, 91, 29, 6),
(1017, 0, 1686, 101, 27, 7),
(1018, 0, 1686, 105, 27, 7),
(1019, 0, 1686, 96, 29, 6),
(1020, 0, 1686, 107, 30, 4),
(1021, 0, 1686, 111, 29, 6),
(1022, 0, 1686, 116, 29, 5),
(1023, 0, 1686, 94, 34, 5),
(1024, 0, 1686, 94, 34, 6),
(1025, 0, 1686, 99, 34, 6),
(1026, 0, 1686, 103, 34, 5),
(1027, 0, 1686, 101, 32, 7),
(1028, 0, 1686, 104, 32, 3),
(1029, 0, 1686, 104, 34, 5),
(1030, 0, 1686, 105, 32, 7),
(1031, 0, 1686, 109, 34, 6),
(1032, 0, 1686, 98, 39, 7),
(1033, 0, 1686, 101, 37, 7),
(1034, 0, 1686, 103, 39, 7),
(1035, 0, 1686, 104, 39, 7),
(1036, 0, 1686, 105, 37, 7),
(1037, 0, 1686, 109, 39, 7),
(1038, 0, 1686, 114, 34, 5),
(1039, 0, 1686, 114, 34, 6),
(1040, 0, 1688, 123, 61, 5),
(1041, 0, 1688, 123, 62, 6),
(1042, 0, 1688, 120, 62, 7),
(1043, 0, 1688, 117, 64, 6),
(1044, 0, 1688, 123, 64, 5),
(1045, 0, 1688, 123, 64, 7),
(1046, 0, 1689, 137, 27, 7),
(1047, 0, 1689, 133, 32, 7),
(1048, 0, 1689, 134, 32, 7),
(1049, 0, 1694, 145, 32, 7),
(1050, 0, 1694, 145, 36, 7),
(1051, 0, 1698, 177, 36, 7),
(1052, 0, 1699, 172, 42, 7),
(1053, 0, 1699, 173, 43, 7),
(1054, 0, 1699, 179, 39, 7),
(1055, 0, 1699, 177, 45, 7),
(1056, 0, 1700, 183, 43, 6),
(1057, 0, 1700, 178, 47, 7),
(1058, 0, 1700, 183, 50, 6),
(1059, 0, 1700, 183, 48, 7),
(1060, 0, 1701, 173, 50, 7),
(1061, 0, 1701, 173, 54, 6),
(1062, 0, 1701, 173, 54, 7),
(1063, 0, 1701, 177, 48, 7),
(1064, 0, 1701, 181, 54, 7),
(1065, 0, 1709, 175, 70, 7),
(1066, 0, 1709, 176, 68, 7),
(1067, 0, 1709, 178, 69, 7),
(1068, 0, 1711, 145, 60, 7),
(1069, 0, 1711, 148, 60, 7),
(1070, 0, 1711, 151, 60, 7),
(1071, 0, 1711, 152, 63, 7),
(1072, 0, 1712, 143, 67, 7),
(1073, 0, 1712, 143, 70, 7),
(1074, 0, 1712, 145, 71, 7),
(1075, 0, 1712, 150, 69, 7),
(1076, 0, 1712, 150, 70, 7),
(1077, 0, 1713, 156, 63, 7),
(1078, 0, 1713, 158, 60, 7),
(1079, 0, 1713, 160, 60, 7),
(1080, 0, 1713, 163, 60, 7),
(1081, 0, 1714, 158, 69, 7),
(1082, 0, 1714, 158, 70, 7),
(1083, 0, 1714, 165, 66, 7),
(1084, 0, 1714, 165, 70, 7),
(1085, 0, 1715, 135, 26, 6),
(1086, 0, 1715, 131, 30, 6),
(1087, 0, 1715, 137, 31, 6),
(1088, 0, 1715, 135, 32, 6),
(1089, 0, 1715, 151, 65, 6),
(1090, 0, 1716, 137, 27, 5),
(1091, 0, 1716, 131, 29, 5),
(1092, 0, 1716, 137, 29, 5),
(1093, 0, 1716, 134, 32, 5),
(1094, 0, 1716, 150, 66, 6),
(1095, 0, 1716, 145, 71, 5),
(1096, 0, 1716, 146, 71, 5),
(1097, 0, 1716, 148, 71, 5),
(1098, 0, 1716, 150, 68, 5),
(1099, 0, 1716, 150, 69, 6),
(1100, 0, 1717, 149, 30, 6),
(1101, 0, 1717, 145, 32, 6),
(1102, 0, 1717, 165, 63, 5),
(1103, 0, 1717, 165, 61, 6),
(1104, 0, 1717, 165, 62, 6),
(1105, 0, 1717, 165, 63, 6),
(1106, 0, 1718, 146, 30, 5),
(1107, 0, 1718, 165, 67, 6),
(1108, 0, 1718, 161, 71, 5),
(1109, 0, 1718, 165, 68, 5),
(1110, 0, 1718, 165, 68, 6),
(1111, 0, 1718, 165, 69, 6),
(1112, 0, 1719, 156, 34, 6),
(1113, 0, 1719, 157, 34, 6),
(1114, 0, 1720, 162, 34, 6),
(1115, 0, 1720, 164, 34, 6),
(1116, 0, 1721, 177, 28, 6),
(1117, 0, 1722, 177, 29, 5),
(1118, 0, 1722, 180, 29, 6),
(1119, 0, 1723, 179, 31, 6),
(1120, 0, 1724, 174, 59, 6),
(1121, 0, 1724, 172, 61, 6),
(1122, 0, 1724, 176, 60, 6),
(1123, 0, 1724, 176, 61, 6),
(1124, 0, 1724, 172, 66, 6),
(1125, 0, 1725, 175, 54, 5),
(1126, 0, 1725, 177, 54, 5),
(1127, 0, 1725, 180, 54, 5),
(1128, 0, 1726, 146, 51, 6),
(1129, 0, 1727, 121, 47, 6),
(1130, 0, 1727, 126, 52, 6),
(1131, 0, 1728, 126, 55, 6),
(1132, 0, 1728, 124, 59, 6),
(1133, 0, 1729, 117, 51, 4),
(1134, 0, 1729, 126, 53, 3),
(1135, 0, 1729, 124, 53, 4),
(1136, 0, 1729, 117, 56, 4),
(1137, 0, 1730, 750, 1043, 6),
(1138, 0, 1731, 747, 1035, 6),
(1139, 0, 1732, 715, 1054, 6),
(1140, 0, 1732, 715, 1054, 7),
(1141, 0, 1732, 719, 1054, 6),
(1142, 0, 1732, 719, 1054, 7),
(1143, 0, 1732, 721, 1050, 7),
(1144, 0, 1732, 722, 1054, 6),
(1145, 0, 1732, 724, 1054, 7),
(1146, 0, 1732, 715, 1057, 6),
(1147, 0, 1732, 715, 1057, 7),
(1148, 0, 1732, 719, 1057, 6),
(1149, 0, 1732, 719, 1057, 7),
(1150, 0, 1732, 722, 1057, 6),
(1151, 0, 1732, 724, 1057, 7),
(1152, 0, 1733, 712, 1071, 7),
(1153, 0, 1733, 717, 1070, 6),
(1154, 0, 1733, 719, 1070, 7),
(1155, 0, 1733, 713, 1074, 7),
(1156, 0, 1733, 715, 1074, 7),
(1157, 0, 1733, 719, 1072, 6),
(1158, 0, 1733, 717, 1074, 7),
(1159, 0, 1733, 719, 1072, 7),
(1160, 0, 1734, 707, 1070, 6),
(1161, 0, 1734, 707, 1074, 7),
(1162, 0, 1735, 707, 1079, 6),
(1163, 0, 1735, 707, 1077, 7),
(1164, 0, 1735, 707, 1081, 7),
(1165, 0, 1735, 708, 1081, 6),
(1166, 0, 1735, 708, 1081, 7),
(1167, 0, 1736, 715, 1077, 7),
(1168, 0, 1736, 713, 1080, 6),
(1169, 0, 1736, 714, 1081, 7),
(1170, 0, 1736, 713, 1085, 6),
(1171, 0, 1736, 713, 1085, 7),
(1172, 0, 1736, 720, 1082, 7),
(1173, 0, 1737, 735, 1090, 7),
(1174, 0, 1737, 727, 1093, 7),
(1175, 0, 1737, 735, 1094, 6),
(1176, 0, 1737, 732, 1092, 7),
(1177, 0, 1737, 735, 1094, 7),
(1178, 0, 1737, 732, 1096, 6),
(1179, 0, 1737, 733, 1096, 6),
(1180, 0, 1737, 732, 1096, 7),
(1181, 0, 1737, 733, 1096, 7),
(1182, 0, 1738, 760, 1091, 7),
(1183, 0, 1738, 753, 1092, 7),
(1184, 0, 1738, 753, 1093, 7),
(1185, 0, 1738, 760, 1093, 7),
(1186, 0, 1738, 760, 1095, 7),
(1187, 0, 1738, 756, 1096, 7),
(1188, 0, 1738, 758, 1096, 7),
(1189, 0, 1739, 771, 1070, 7);

-- --------------------------------------------------------

--
-- Estrutura da tabela `tile_items`
--

CREATE TABLE IF NOT EXISTS `tile_items` (
  `tile_id` int(10) unsigned NOT NULL,
  `world_id` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `sid` int(11) NOT NULL,
  `pid` int(11) NOT NULL DEFAULT '0',
  `itemtype` int(11) NOT NULL,
  `count` int(11) NOT NULL DEFAULT '0',
  `attributes` blob NOT NULL,
  UNIQUE KEY `tile_id` (`tile_id`,`world_id`,`sid`),
  KEY `sid` (`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `tile_items`
--

INSERT INTO `tile_items` (`tile_id`, `world_id`, `sid`, `pid`, `itemtype`, `count`, `attributes`) VALUES
(0, 0, 1, 0, 6257, 1, 0x8002000b006465736372697074696f6e015200000049742062656c6f6e677320746f20686f7573652027546f7765722031272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031393430303020676f6c6420636f696e732e0600646f6f7269640202000000),
(1, 0, 1, 0, 9171, 1, 0x8002000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f75736520274775696c64486f75736520537472656574272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320383030303020676f6c6420636f696e732e0600646f6f7269640204000000),
(2, 0, 1, 0, 5304, 1, ''),
(3, 0, 1, 0, 9173, 1, 0x8002000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f75736520274775696c64486f75736520537472656574272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320383030303020676f6c6420636f696e732e0600646f6f7269640201000000),
(4, 0, 1, 0, 1252, 1, 0x8002000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f75736520274775696c64486f75736520537472656574272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320383030303020676f6c6420636f696e732e0600646f6f7269640202000000),
(5, 0, 1, 0, 9173, 1, 0x8002000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f75736520274775696c64486f75736520537472656574272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320383030303020676f6c6420636f696e732e0600646f6f7269640201000000),
(6, 0, 1, 0, 1252, 1, 0x8002000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f75736520274775696c64486f75736520537472656574272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320383030303020676f6c6420636f696e732e0600646f6f7269640205000000),
(7, 0, 1, 0, 10488, 1, 0x8002000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f75736520274865617679204465706f7420486f757365272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363330303020676f6c6420636f696e732e0600646f6f7269640203000000),
(8, 0, 1, 0, 6257, 1, 0x8002000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f75736520274865617679204465706f7420486f757365272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363330303020676f6c6420636f696e732e0600646f6f7269640203000000),
(9, 0, 1, 0, 10488, 1, 0x8002000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f75736520274865617679204465706f7420486f757365272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363330303020676f6c6420636f696e732e0600646f6f7269640203000000),
(10, 0, 1, 0, 10489, 1, ''),
(11, 0, 1, 0, 10489, 1, ''),
(12, 0, 1, 0, 10490, 1, ''),
(13, 0, 1, 0, 10490, 1, 0x8002000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f75736520274865617679204465706f7420486f757365272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363330303020676f6c6420636f696e732e0600646f6f7269640203000000),
(14, 0, 1, 0, 10266, 1, ''),
(15, 0, 1, 0, 10266, 1, 0x8002000b006465736372697074696f6e015e00000049742062656c6f6e677320746f20686f75736520274865617679204465706f7420486f757365204949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393630303020676f6c6420636f696e732e0600646f6f7269640203000000),
(16, 0, 1, 0, 10264, 1, ''),
(17, 0, 1, 0, 1221, 1, 0x8002000b006465736372697074696f6e015e00000049742062656c6f6e677320746f20686f75736520274865617679204465706f7420486f757365204949272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393630303020676f6c6420636f696e732e0600646f6f7269640202000000),
(18, 0, 1, 0, 10265, 1, ''),
(19, 0, 1, 0, 10489, 1, ''),
(20, 0, 1, 0, 10489, 1, 0x8002000b006465736372697074696f6e015700000049742062656c6f6e677320746f20686f7573652027506f727420686f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732032353830303020676f6c6420636f696e732e0600646f6f7269640203000000),
(21, 0, 1, 0, 10489, 1, 0x8002000b006465736372697074696f6e015700000049742062656c6f6e677320746f20686f7573652027506f727420686f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732032353830303020676f6c6420636f696e732e0600646f6f7269640202000000),
(22, 0, 1, 0, 6255, 1, 0x8002000b006465736372697074696f6e015700000049742062656c6f6e677320746f20686f7573652027506f727420686f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732032353830303020676f6c6420636f696e732e0600646f6f7269640206000000),
(23, 0, 1, 0, 10489, 1, ''),
(24, 0, 1, 0, 10489, 1, 0x8002000b006465736372697074696f6e015700000049742062656c6f6e677320746f20686f7573652027506f727420686f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732032353830303020676f6c6420636f696e732e0600646f6f7269640201000000),
(25, 0, 1, 0, 10489, 1, ''),
(26, 0, 1, 0, 10489, 1, 0x8002000b006465736372697074696f6e015700000049742062656c6f6e677320746f20686f7573652027506f727420686f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732032353830303020676f6c6420636f696e732e0600646f6f7269640203000000),
(27, 0, 1, 0, 6253, 1, 0x8002000b006465736372697074696f6e015700000049742062656c6f6e677320746f20686f7573652027506f727420686f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732032353830303020676f6c6420636f696e732e0600646f6f7269640202000000),
(28, 0, 1, 0, 6253, 1, 0x8002000b006465736372697074696f6e015700000049742062656c6f6e677320746f20686f7573652027506f727420686f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732032353830303020676f6c6420636f696e732e0600646f6f7269640201000000),
(29, 0, 1, 0, 6255, 1, 0x8002000b006465736372697074696f6e015700000049742062656c6f6e677320746f20686f7573652027506f727420686f7573652049272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732032353830303020676f6c6420636f696e732e0600646f6f7269640204000000);

-- --------------------------------------------------------

--
-- Estrutura da tabela `tile_store`
--

CREATE TABLE IF NOT EXISTS `tile_store` (
  `house_id` int(10) unsigned NOT NULL,
  `world_id` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `data` longblob NOT NULL,
  KEY `house_id` (`house_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `woe`
--

CREATE TABLE IF NOT EXISTS `woe` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `started` int(11) NOT NULL,
  `guild` int(11) NOT NULL,
  `breaker` int(11) NOT NULL,
  `time` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Restrições para as tabelas dumpadas
--

--
-- Restrições para a tabela `account_viplist`
--
ALTER TABLE `account_viplist`
  ADD CONSTRAINT `account_viplist_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `account_viplist_ibfk_2` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `death_list`
--
ALTER TABLE `death_list`
  ADD CONSTRAINT `death_list_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `environment_killers`
--
ALTER TABLE `environment_killers`
  ADD CONSTRAINT `environment_killers_ibfk_1` FOREIGN KEY (`kill_id`) REFERENCES `killers` (`id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `guild_invites`
--
ALTER TABLE `guild_invites`
  ADD CONSTRAINT `guild_invites_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `guild_invites_ibfk_2` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `guild_kills`
--
ALTER TABLE `guild_kills`
  ADD CONSTRAINT `guild_kills_ibfk_1` FOREIGN KEY (`war_id`) REFERENCES `guild_wars` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `guild_kills_ibfk_2` FOREIGN KEY (`death_id`) REFERENCES `player_deaths` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `guild_kills_ibfk_3` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `guild_ranks`
--
ALTER TABLE `guild_ranks`
  ADD CONSTRAINT `guild_ranks_ibfk_1` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `guild_wars`
--
ALTER TABLE `guild_wars`
  ADD CONSTRAINT `guild_wars_ibfk_1` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `guild_wars_ibfk_2` FOREIGN KEY (`enemy_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `house_auctions`
--
ALTER TABLE `house_auctions`
  ADD CONSTRAINT `house_auctions_ibfk_1` FOREIGN KEY (`house_id`, `world_id`) REFERENCES `houses` (`id`, `world_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `house_auctions_ibfk_2` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `house_data`
--
ALTER TABLE `house_data`
  ADD CONSTRAINT `house_data_ibfk_1` FOREIGN KEY (`house_id`, `world_id`) REFERENCES `houses` (`id`, `world_id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `house_lists`
--
ALTER TABLE `house_lists`
  ADD CONSTRAINT `house_lists_ibfk_1` FOREIGN KEY (`house_id`, `world_id`) REFERENCES `houses` (`id`, `world_id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `killers`
--
ALTER TABLE `killers`
  ADD CONSTRAINT `killers_ibfk_1` FOREIGN KEY (`death_id`) REFERENCES `player_deaths` (`id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `players`
--
ALTER TABLE `players`
  ADD CONSTRAINT `players_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `player_deaths`
--
ALTER TABLE `player_deaths`
  ADD CONSTRAINT `player_deaths_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `player_depotitems`
--
ALTER TABLE `player_depotitems`
  ADD CONSTRAINT `player_depotitems_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `player_items`
--
ALTER TABLE `player_items`
  ADD CONSTRAINT `player_items_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `player_killers`
--
ALTER TABLE `player_killers`
  ADD CONSTRAINT `player_killers_ibfk_1` FOREIGN KEY (`kill_id`) REFERENCES `killers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `player_killers_ibfk_2` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `player_namelocks`
--
ALTER TABLE `player_namelocks`
  ADD CONSTRAINT `player_namelocks_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `player_skills`
--
ALTER TABLE `player_skills`
  ADD CONSTRAINT `player_skills_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `player_spells`
--
ALTER TABLE `player_spells`
  ADD CONSTRAINT `player_spells_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `player_storage`
--
ALTER TABLE `player_storage`
  ADD CONSTRAINT `player_storage_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `player_viplist`
--
ALTER TABLE `player_viplist`
  ADD CONSTRAINT `player_viplist_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `player_viplist_ibfk_2` FOREIGN KEY (`vip_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `server_reports`
--
ALTER TABLE `server_reports`
  ADD CONSTRAINT `server_reports_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `tiles`
--
ALTER TABLE `tiles`
  ADD CONSTRAINT `tiles_ibfk_1` FOREIGN KEY (`house_id`, `world_id`) REFERENCES `houses` (`id`, `world_id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `tile_items`
--
ALTER TABLE `tile_items`
  ADD CONSTRAINT `tile_items_ibfk_1` FOREIGN KEY (`tile_id`) REFERENCES `tiles` (`id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `tile_store`
--
ALTER TABLE `tile_store`
  ADD CONSTRAINT `tile_store_ibfk_1` FOREIGN KEY (`house_id`) REFERENCES `houses` (`id`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
