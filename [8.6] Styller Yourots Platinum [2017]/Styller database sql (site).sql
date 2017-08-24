-- phpMyAdmin SQL Dump
-- version 3.2.4
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tempo de Geração: Mar 18, 2017 as 08:46 
-- Versão do Servidor: 5.1.41
-- Versão do PHP: 5.3.1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Banco de Dados: `styller`
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
  `lastday` int(10) unsigned NOT NULL DEFAULT '0',
  `email` varchar(255) NOT NULL DEFAULT '',
  `key` varchar(32) NOT NULL DEFAULT '0',
  `blocked` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'internal usage',
  `warnings` int(11) NOT NULL DEFAULT '0',
  `group_id` int(11) NOT NULL DEFAULT '1',
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
  `vip_time` int(11) NOT NULL DEFAULT '0',
  `guild_points` int(11) NOT NULL DEFAULT '0',
  `guild_points_stats` int(11) NOT NULL DEFAULT '0',
  `loot_time` int(15) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8459650 ;

--
-- Extraindo dados da tabela `accounts`
--

INSERT INTO `accounts` (`id`, `name`, `password`, `salt`, `premdays`, `lastday`, `email`, `key`, `blocked`, `warnings`, `group_id`, `page_lastday`, `email_new`, `email_new_time`, `created`, `rlname`, `location`, `page_access`, `email_code`, `next_email`, `premium_points`, `vote`, `last_post`, `flag`, `vip_time`, `guild_points`, `guild_points_stats`, `loot_time`) VALUES
(1, '1', '356a192b7913b04c54574d18c28d46e6395428ab', '', 65535, 0, '', '0', 0, 0, 1, 1489877020, '', 0, 1374647117, '', '', 999999, '0', 0, 0, 0, 0, '', 0, 0, 0, 0),
(4032593, 'sample', '3548b58feac10de88b4283aab95ae62dd090202c', '', 2, 0, 'sksis@hotmail.com', '0', 0, 0, 1, 0, '', 0, 1489880646, '', '', 0, '0', 0, 0, 0, 0, '', 0, 0, 0, 0),
(4465942, 'god', 'b512de9e8b792e4094c8b6c08c8320d64dde59bb', '', 2, 0, 'hard@hotmail.com', '0', 0, 0, 1, 1489879064, '', 0, 1489877287, '', '', 9999, '0', 0, 0, 0, 0, '', 0, 0, 0, 0);

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
-- Estrutura da tabela `account_storage`
--

CREATE TABLE IF NOT EXISTS `account_storage` (
  `account_id` int(11) NOT NULL DEFAULT '0',
  `key` int(10) unsigned NOT NULL DEFAULT '0',
  `value` varchar(255) NOT NULL DEFAULT '0',
  UNIQUE KEY `account_id_2` (`account_id`,`key`),
  KEY `account_id` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `account_storage`
--

INSERT INTO `account_storage` (`account_id`, `key`, `value`) VALUES
(8459649, 93871, '1');

-- --------------------------------------------------------

--
-- Estrutura da tabela `account_viplist`
--

CREATE TABLE IF NOT EXISTS `account_viplist` (
  `account_id` int(11) NOT NULL,
  `world_id` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `player_id` int(11) NOT NULL,
  `description` varchar(128) NOT NULL,
  `icon` int(11) unsigned NOT NULL,
  `notify` tinyint(1) NOT NULL,
  UNIQUE KEY `account_id_2` (`account_id`,`player_id`),
  KEY `account_id` (`account_id`),
  KEY `player_id` (`player_id`),
  KEY `world_id` (`world_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `account_viplist`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `announcements`
--

CREATE TABLE IF NOT EXISTS `announcements` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `text` varchar(255) NOT NULL,
  `date` varchar(20) NOT NULL,
  `author` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `announcements`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `bans`
--

CREATE TABLE IF NOT EXISTS `bans` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) NOT NULL COMMENT '1 - ip, 2 - player, 3 - account, 4 - notation',
  `value` int(10) unsigned NOT NULL COMMENT 'ip - ip address, player - player_id, account - account_id, notation - account_id',
  `param` int(10) unsigned NOT NULL COMMENT 'ip - mask, player - type (1 - report, 2 - lock, 3 - ban), account - player, notation - player',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `expires` int(11) NOT NULL DEFAULT '-1',
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

--
-- Extraindo dados da tabela `bans`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `ban_table`
--

CREATE TABLE IF NOT EXISTS `ban_table` (
  `id` int(11) NOT NULL,
  `account` int(11) NOT NULL,
  `added` int(11) NOT NULL,
  `expires` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL DEFAULT '0',
  `comment` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `ban_table`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `death_list`
--

CREATE TABLE IF NOT EXISTS `death_list` (
  `id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `date` int(11) NOT NULL,
  `level` int(11) NOT NULL,
  `killer_name` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `death_list`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `environment_killers`
--

CREATE TABLE IF NOT EXISTS `environment_killers` (
  `kill_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  KEY `kill_id` (`kill_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `environment_killers`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `global_storage`
--

CREATE TABLE IF NOT EXISTS `global_storage` (
  `key` varchar(32) NOT NULL,
  `world_id` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `value` text NOT NULL,
  UNIQUE KEY `key` (`key`,`world_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `global_storage`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `guilds`
--

CREATE TABLE IF NOT EXISTS `guilds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `world_id` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `ownerid` int(11) NOT NULL,
  `creationdata` int(11) NOT NULL,
  `checkdata` int(11) NOT NULL,
  `motd` varchar(255) NOT NULL,
  `balance` bigint(20) unsigned NOT NULL,
  `description` text NOT NULL,
  `logo_gfx_name` varchar(255) NOT NULL DEFAULT '',
  `last_execute_points` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`world_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `guilds`
--


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

--
-- Extraindo dados da tabela `guild_invites`
--


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
  KEY `guild_id` (`guild_id`),
  KEY `war_id` (`war_id`),
  KEY `death_id` (`death_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `guild_kills`
--


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

--
-- Extraindo dados da tabela `guild_ranks`
--


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

--
-- Extraindo dados da tabela `guild_wars`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `houses`
--

CREATE TABLE IF NOT EXISTS `houses` (
  `id` int(10) unsigned NOT NULL,
  `world_id` tinyint(4) unsigned NOT NULL DEFAULT '0',
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
(2, 0, 0, 0, 0, 0, 'Market Street 4 (Shop)', 1, 96, 99000, 5105, 21, 3, 208, 0, 0),
(4, 0, 0, 0, 0, 0, 'Market Street 3', 1, 70, 72000, 3475, 20, 2, 150, 0, 0),
(5, 0, 0, 0, 0, 0, 'Market Street 2', 1, 96, 99000, 4925, 22, 3, 207, 0, 0),
(6, 0, 0, 0, 0, 0, 'Market Street 1', 1, 133, 136000, 6680, 23, 3, 258, 0, 0),
(7, 0, 0, 0, 0, 0, 'Old Lighthouse', 1, 73, 75000, 3610, 15, 2, 177, 0, 0),
(8, 0, 0, 0, 0, 0, 'Seagull Walk 1', 1, 106, 108000, 5095, 19, 2, 210, 0, 0),
(9, 0, 0, 0, 0, 0, 'Seagull Walk 2', 1, 50, 53000, 2765, 17, 3, 132, 0, 0),
(10, 0, 0, 0, 0, 0, 'Dream Street 4', 1, 68, 72000, 3765, 18, 4, 168, 0, 0),
(11, 0, 0, 0, 0, 0, 'Elm Street 2', 1, 51, 53000, 2665, 11, 2, 112, 0, 0),
(12, 0, 0, 0, 0, 0, 'Elm Street 1', 1, 53, 55000, 2710, 12, 2, 120, 0, 0),
(13, 0, 0, 0, 0, 0, 'Elm Street 3', 1, 52, 55000, 2855, 11, 3, 126, 0, 0),
(14, 0, 0, 0, 0, 0, 'Elm Street 4', 1, 51, 53000, 3765, 11, 2, 120, 0, 0),
(15, 0, 0, 0, 0, 0, 'Dream Street 3', 1, 53, 55000, 2710, 10, 2, 117, 0, 0),
(16, 0, 0, 0, 0, 0, 'Dream Street 2', 1, 67, 69000, 3340, 19, 2, 147, 0, 0),
(18, 0, 0, 0, 0, 0, 'Paupers Palace, Flat 13', 1, 7, 8000, 450, 2, 1, 20, 0, 0),
(19, 0, 0, 0, 0, 0, 'Paupers Palace, Flat 12', 1, 8, 10000, 685, 2, 2, 25, 0, 0),
(23, 0, 0, 0, 0, 0, 'Paupers Palace, Flat 14', 1, 10, 11000, 585, 2, 1, 24, 0, 0),
(24, 0, 0, 0, 0, 0, 'Paupers Palace, Flat 15', 1, 7, 8000, 450, 2, 1, 20, 0, 0),
(25, 0, 0, 0, 0, 0, 'Paupers Palace, Flat 16', 1, 10, 11000, 585, 2, 1, 29, 0, 0),
(26, 0, 0, 0, 0, 0, 'Paupers Palace, Flat 17', 1, 7, 8000, 450, 2, 1, 20, 0, 0),
(27, 0, 0, 0, 0, 0, 'Paupers Palace, Flat 18', 1, 4, 5000, 315, 2, 1, 20, 0, 0),
(28, 0, 0, 0, 0, 0, 'Paupers Palace, Flat 01', 1, 6, 7000, 405, 3, 1, 24, 0, 0),
(29, 0, 0, 0, 0, 0, 'Paupers Palace, Flat 02', 1, 7, 8000, 450, 1, 1, 25, 0, 0),
(30, 0, 0, 0, 0, 0, 'Paupers Palace, Flat 03', 1, 6, 7000, 405, 1, 1, 20, 0, 0),
(31, 0, 0, 0, 0, 0, 'Paupers Palace, Flat 04', 1, 8, 9000, 450, 3, 1, 25, 0, 0),
(32, 0, 0, 0, 0, 0, 'Paupers Palace, Flat 05', 1, 4, 5000, 315, 2, 1, 15, 0, 0),
(33, 0, 0, 0, 0, 0, 'Paupers Palace, Flat 06', 1, 7, 8000, 450, 3, 1, 20, 0, 0),
(34, 0, 0, 0, 0, 0, 'Paupers Palace, Flat 07', 1, 8, 10000, 685, 1, 2, 23, 0, 0),
(35, 0, 0, 0, 0, 0, 'Paupers Palace, Flat 21', 1, 5, 6000, 315, 3, 1, 20, 0, 0),
(36, 0, 0, 0, 0, 0, 'Paupers Palace, Flat 22', 1, 7, 8000, 450, 2, 1, 20, 0, 0),
(37, 0, 0, 0, 0, 0, 'Paupers Palace, Flat 23', 1, 10, 11000, 585, 2, 1, 30, 0, 0),
(38, 0, 0, 0, 0, 0, 'Paupers Palace, Flat 24', 1, 7, 8000, 450, 2, 1, 20, 0, 0),
(39, 0, 0, 0, 0, 0, 'Paupers Palace, Flat 26', 1, 7, 8000, 450, 2, 1, 20, 0, 0),
(40, 0, 0, 0, 0, 0, 'Paupers Palace, Flat 28', 1, 4, 5000, 315, 2, 1, 15, 0, 0),
(41, 0, 0, 0, 0, 0, 'Paupers Palace, Flat 27', 1, 8, 10000, 685, 3, 2, 25, 0, 0),
(42, 0, 0, 0, 0, 0, 'Paupers Palace, Flat 25', 1, 10, 11000, 585, 1, 1, 20, 0, 0),
(43, 0, 0, 0, 0, 0, 'Paupers Palace, Flat 31', 1, 16, 17000, 855, 3, 1, 40, 0, 0),
(44, 0, 0, 0, 0, 0, 'Paupers Palace, Flat 32', 1, 18, 20000, 1135, 4, 2, 50, 0, 0),
(45, 0, 0, 0, 0, 0, 'Paupers Palace, Flat 33', 1, 14, 15000, 765, 4, 1, 32, 0, 0),
(46, 0, 0, 0, 0, 0, 'Paupers Palace, Flat 34', 1, 30, 32000, 1675, 6, 2, 60, 0, 0),
(47, 0, 0, 0, 0, 0, 'Salvation Street 1 (Shop)', 1, 119, 123000, 6240, 25, 4, 249, 0, 0),
(49, 0, 0, 0, 0, 0, 'Dream Street 1 (Shop)', 1, 81, 83000, 4330, 22, 2, 192, 0, 0),
(50, 0, 0, 0, 0, 0, 'Blessed Shield Guildhall', 1, 126, 135000, 8090, 14, 9, 259, 0, 0),
(51, 0, 0, 0, 0, 0, 'Dagger Alley 1', 1, 52, 54000, 2665, 13, 2, 116, 0, 0),
(52, 0, 0, 0, 0, 0, 'Steel Home', 1, 219, 232000, 13845, 35, 13, 462, 0, 0),
(53, 0, 0, 0, 0, 0, 'Iron Alley 1', 1, 61, 65000, 3450, 11, 4, 120, 0, 0),
(54, 0, 0, 0, 0, 0, 'Iron Alley 2', 1, 64, 66000, 3450, 9, 2, 144, 0, 0),
(55, 0, 0, 0, 0, 0, 'Swamp Watch', 1, 179, 191000, 11090, 45, 12, 420, 0, 0),
(57, 0, 0, 0, 0, 0, 'Salvation Street 2', 1, 76, 78000, 3790, 13, 2, 135, 0, 0),
(60, 0, 0, 0, 0, 0, 'Salvation Street 3', 1, 76, 78000, 3790, 14, 2, 162, 0, 0),
(61, 0, 0, 0, 0, 0, 'Silver Street 3', 1, 41, 42000, 1980, 11, 1, 84, 0, 0),
(62, 0, 0, 0, 0, 0, 'Golden Axe Guildhall', 1, 175, 185000, 10485, 36, 10, 390, 0, 0),
(63, 0, 0, 0, 0, 0, 'Silver Street 1', 1, 54, 55000, 2565, 14, 1, 129, 0, 0),
(64, 0, 0, 0, 0, 0, 'Silver Street 2', 1, 41, 42000, 1980, 10, 1, 105, 0, 0),
(66, 0, 0, 0, 0, 0, 'Silver Street 4', 1, 66, 68000, 3295, 17, 2, 153, 0, 0),
(67, 0, 0, 0, 0, 0, 'Mystic Lane 2', 1, 58, 60000, 2980, 12, 2, 137, 0, 0),
(69, 0, 0, 0, 0, 0, 'Mystic Lane 1', 1, 51, 54000, 2945, 13, 3, 112, 0, 0),
(70, 0, 0, 0, 0, 0, 'Loot Lane 1 (Shop)', 1, 88, 91000, 4565, 24, 3, 198, 0, 0),
(71, 0, 0, 0, 0, 0, 'Market Street 6', 1, 102, 107000, 5485, 24, 5, 217, 0, 0),
(72, 0, 0, 0, 0, 0, 'Market Street 7', 1, 44, 46000, 2305, 17, 2, 114, 0, 0),
(73, 0, 0, 0, 0, 0, 'Market Street 5 (Shop)', 1, 119, 122000, 6375, 19, 3, 243, 0, 0),
(194, 0, 0, 0, 0, 0, 'Lucky Lane 1 (Shop)', 1, 132, 136000, 6960, 24, 4, 270, 0, 0),
(208, 0, 0, 0, 0, 0, 'Underwood 1', 5, 26, 28000, 1495, 5, 2, 54, 0, 0),
(209, 0, 0, 0, 0, 0, 'Underwood 2', 5, 27, 29000, 1495, 6, 2, 55, 0, 0),
(210, 0, 0, 0, 0, 0, 'Underwood 5', 5, 19, 22000, 1370, 4, 3, 48, 0, 0),
(211, 0, 0, 0, 0, 0, 'Underwood 3', 5, 26, 29000, 1685, 4, 3, 57, 0, 0),
(212, 0, 0, 0, 0, 0, 'Underwood 4', 5, 35, 39000, 2235, 4, 4, 70, 0, 0),
(213, 0, 0, 0, 0, 0, 'Underwood 10', 5, 10, 11000, 585, 2, 1, 23, 0, 0),
(214, 0, 0, 0, 0, 0, 'Underwood 6', 5, 24, 27000, 1595, 5, 3, 55, 0, 0),
(215, 0, 0, 0, 0, 0, 'Great Willow 1a', 5, 7, 8000, 500, 1, 1, 25, 0, 0),
(216, 0, 0, 0, 0, 0, 'Great Willow 1b', 5, 10, 11000, 650, 2, 1, 30, 0, 0),
(217, 0, 0, 0, 0, 0, 'Great Willow 1c', 5, 10, 11000, 650, 1, 1, 20, 0, 0),
(218, 0, 0, 0, 0, 0, 'Great Willow 2d', 5, 6, 7000, 450, 2, 1, 18, 0, 0),
(219, 0, 0, 0, 0, 0, 'Great Willow 2c', 5, 10, 11000, 650, 2, 1, 24, 0, 0),
(220, 0, 0, 0, 0, 0, 'Great Willow 2b', 5, 6, 7000, 450, 3, 1, 24, 0, 0),
(221, 0, 0, 0, 0, 0, 'Great Willow 2a', 5, 11, 12000, 650, 4, 1, 30, 0, 0),
(222, 0, 0, 0, 0, 0, 'Great Willow 3d', 5, 6, 7000, 450, 2, 1, 18, 0, 0),
(223, 0, 0, 0, 0, 0, 'Great Willow 3c', 5, 10, 11000, 650, 2, 1, 24, 0, 0),
(224, 0, 0, 0, 0, 0, 'Great Willow 3b', 5, 6, 7000, 450, 3, 1, 24, 0, 0),
(225, 0, 0, 0, 0, 0, 'Great Willow 3a', 5, 10, 11000, 650, 3, 1, 30, 0, 0),
(226, 0, 0, 0, 0, 0, 'Great Willow 4b', 5, 12, 14000, 950, 3, 2, 27, 0, 0),
(227, 0, 0, 0, 0, 0, 'Great Willow 4c', 5, 12, 14000, 950, 3, 2, 31, 0, 0),
(228, 0, 0, 0, 0, 0, 'Great Willow 4d', 5, 12, 13000, 750, 5, 1, 36, 0, 0),
(229, 0, 0, 0, 0, 0, 'Great Willow 4a', 5, 12, 14000, 950, 4, 2, 36, 0, 0),
(230, 0, 0, 0, 0, 0, 'Underwood 7', 5, 21, 24000, 1460, 5, 3, 49, 0, 0),
(231, 0, 0, 0, 0, 0, 'Shadow Caves 3', 5, 7, 8000, 300, 1, 1, 20, 0, 0),
(232, 0, 0, 0, 0, 0, 'Shadow Caves 4', 5, 7, 8000, 300, 1, 1, 20, 0, 0),
(233, 0, 0, 0, 0, 0, 'Shadow Caves 2', 5, 7, 8000, 300, 1, 1, 16, 0, 0),
(234, 0, 0, 0, 0, 0, 'Shadow Caves 1', 5, 7, 8000, 300, 1, 1, 19, 0, 0),
(235, 0, 0, 0, 0, 0, 'Shadow Caves 17', 5, 7, 8000, 300, 1, 1, 25, 0, 0),
(236, 0, 0, 0, 0, 0, 'Shadow Caves 18', 5, 7, 8000, 300, 1, 1, 25, 0, 0),
(237, 0, 0, 0, 0, 0, 'Shadow Caves 15', 5, 7, 8000, 300, 1, 1, 20, 0, 0),
(238, 0, 0, 0, 0, 0, 'Shadow Caves 16', 5, 7, 8000, 300, 1, 1, 19, 0, 0),
(239, 0, 0, 0, 0, 0, 'Shadow Caves 13', 5, 7, 8000, 300, 1, 1, 19, 0, 0),
(240, 0, 0, 0, 0, 0, 'Shadow Caves 14', 5, 7, 8000, 300, 1, 1, 20, 0, 0),
(241, 0, 0, 0, 0, 0, 'Shadow Caves 11', 5, 7, 8000, 300, 1, 1, 19, 0, 0),
(242, 0, 0, 0, 0, 0, 'Shadow Caves 12', 5, 7, 8000, 300, 1, 1, 20, 0, 0),
(243, 0, 0, 0, 0, 0, 'Shadow Caves 27', 5, 7, 8000, 300, 1, 1, 20, 0, 0),
(244, 0, 0, 0, 0, 0, 'Shadow Caves 28', 5, 7, 8000, 300, 1, 1, 20, 0, 0),
(245, 0, 0, 0, 0, 0, 'Shadow Caves 25', 5, 7, 8000, 300, 1, 1, 20, 0, 0),
(246, 0, 0, 0, 0, 0, 'Shadow Caves 26', 5, 7, 8000, 300, 1, 1, 16, 0, 0),
(247, 0, 0, 0, 0, 0, 'Shadow Caves 23', 5, 7, 8000, 300, 1, 1, 20, 0, 0),
(248, 0, 0, 0, 0, 0, 'Shadow Caves 24', 5, 7, 8000, 300, 1, 1, 20, 0, 0),
(249, 0, 0, 0, 0, 0, 'Shadow Caves 21', 5, 7, 8000, 300, 1, 1, 19, 0, 0),
(250, 0, 0, 0, 0, 0, 'Shadow Caves 22', 5, 7, 8000, 300, 1, 1, 20, 0, 0),
(251, 0, 0, 0, 0, 0, 'Underwood 9', 5, 10, 11000, 585, 3, 1, 28, 0, 0),
(252, 0, 0, 0, 0, 0, 'Treetop 13', 5, 21, 23000, 1400, 6, 2, 48, 0, 0),
(254, 0, 0, 0, 0, 0, 'Underwood 8', 5, 13, 15000, 865, 6, 2, 34, 0, 0),
(255, 0, 0, 0, 0, 0, 'Mangrove 4', 5, 13, 15000, 950, 3, 2, 36, 0, 0),
(256, 0, 0, 0, 0, 0, 'Coastwood 10', 5, 19, 22000, 1630, 5, 3, 48, 0, 0),
(257, 0, 0, 0, 0, 0, 'Mangrove 1', 5, 24, 27000, 1750, 4, 3, 54, 0, 0),
(258, 0, 0, 0, 0, 0, 'Coastwood 1', 5, 11, 13000, 980, 5, 2, 34, 0, 0),
(259, 0, 0, 0, 0, 0, 'Coastwood 2', 5, 11, 13000, 980, 4, 2, 28, 0, 0),
(260, 0, 0, 0, 0, 0, 'Mangrove 2', 5, 20, 22000, 1350, 3, 2, 47, 0, 0),
(262, 0, 0, 0, 0, 0, 'Mangrove 3', 5, 16, 18000, 1150, 2, 2, 41, 0, 0),
(263, 0, 0, 0, 0, 0, 'Coastwood 9', 5, 14, 15000, 935, 6, 1, 34, 0, 0),
(264, 0, 0, 0, 0, 0, 'Coastwood 8', 5, 17, 19000, 1255, 7, 2, 41, 0, 0),
(265, 0, 0, 0, 0, 0, 'Coastwood 6 (Shop)', 5, 24, 25000, 1595, 6, 1, 51, 0, 0),
(266, 0, 0, 0, 0, 0, 'Coastwood 7', 5, 9, 10000, 660, 4, 1, 29, 0, 0),
(267, 0, 0, 0, 0, 0, 'Coastwood 5', 5, 21, 23000, 1530, 6, 2, 49, 0, 0),
(268, 0, 0, 0, 0, 0, 'Coastwood 4', 5, 14, 16000, 1145, 4, 2, 42, 0, 0),
(269, 0, 0, 0, 0, 0, 'Coastwood 3', 5, 17, 19000, 1310, 4, 2, 36, 0, 0),
(270, 0, 0, 0, 0, 0, 'Treetop 11', 5, 11, 13000, 900, 6, 2, 34, 0, 0),
(271, 0, 0, 0, 0, 0, 'Treetop 5 (Shop)', 5, 18, 19000, 1350, 7, 1, 53, 0, 0),
(272, 0, 0, 0, 0, 0, 'Treetop 7', 5, 14, 15000, 800, 4, 1, 28, 0, 0),
(273, 0, 0, 0, 0, 0, 'Treetop 6', 5, 7, 8000, 450, 4, 1, 23, 0, 0),
(274, 0, 0, 0, 0, 0, 'Treetop 8', 5, 14, 15000, 800, 5, 1, 35, 0, 0),
(275, 0, 0, 0, 0, 0, 'Treetop 9', 5, 16, 18000, 1150, 3, 2, 34, 0, 0),
(276, 0, 0, 0, 0, 0, 'Treetop 10', 5, 16, 18000, 1150, 5, 2, 42, 0, 0),
(277, 0, 0, 0, 0, 0, 'Treetop 4 (Shop)', 5, 20, 21000, 1250, 7, 1, 48, 0, 0),
(278, 0, 0, 0, 0, 0, 'Treetop 3 (Shop)', 5, 20, 21000, 1250, 9, 1, 60, 0, 0),
(279, 0, 0, 0, 0, 0, 'Treetop 2', 5, 10, 11000, 650, 3, 1, 29, 0, 0),
(280, 0, 0, 0, 0, 0, 'Treetop 1', 5, 10, 11000, 650, 3, 1, 24, 0, 0),
(281, 0, 0, 0, 0, 0, 'Treetop 12 (Shop)', 5, 20, 21000, 1350, 9, 1, 53, 0, 0),
(469, 0, 0, 0, 0, 0, 'Darashia 2, Flat 07', 10, 22, 23000, 1000, 1, 1, 48, 0, 0),
(470, 0, 0, 0, 0, 0, 'Darashia 2, Flat 01', 10, 23, 24000, 1000, 1, 1, 48, 0, 0),
(471, 0, 0, 0, 0, 0, 'Darashia 2, Flat 02', 10, 22, 23000, 1000, 1, 1, 42, 0, 0),
(472, 0, 0, 0, 0, 0, 'Darashia 2, Flat 06', 10, 10, 11000, 520, 1, 1, 24, 0, 0),
(473, 0, 0, 0, 0, 0, 'Darashia 2, Flat 05', 10, 24, 26000, 1260, 1, 2, 48, 0, 0),
(474, 0, 0, 0, 0, 0, 'Darashia 2, Flat 04', 10, 10, 11000, 520, 1, 1, 24, 0, 0),
(475, 0, 0, 0, 0, 0, 'Darashia 2, Flat 03', 10, 26, 27000, 1160, 1, 1, 42, 0, 0),
(476, 0, 0, 0, 0, 0, 'Darashia 2, Flat 13', 10, 26, 27000, 1160, 1, 1, 42, 0, 0),
(477, 0, 0, 0, 0, 0, 'Darashia 2, Flat 12', 10, 10, 11000, 520, 1, 1, 24, 0, 0),
(478, 0, 0, 0, 0, 0, 'Darashia 2, Flat 11', 10, 22, 23000, 1000, 1, 1, 42, 0, 0),
(479, 0, 0, 0, 0, 0, 'Darashia 2, Flat 14', 10, 10, 11000, 520, 1, 1, 24, 0, 0),
(480, 0, 0, 0, 0, 0, 'Darashia 2, Flat 15', 10, 24, 26000, 1260, 1, 2, 47, 0, 0),
(481, 0, 0, 0, 0, 0, 'Darashia 2, Flat 16', 10, 15, 16000, 680, 1, 1, 30, 0, 0),
(482, 0, 0, 0, 0, 0, 'Darashia 2, Flat 17', 10, 22, 23000, 1000, 1, 1, 48, 0, 0),
(483, 0, 0, 0, 0, 0, 'Darashia 2, Flat 18', 10, 14, 15000, 680, 1, 1, 30, 0, 0),
(484, 0, 0, 0, 0, 0, 'Darashia 1, Flat 05', 10, 20, 22000, 1100, 1, 2, 48, 0, 0),
(485, 0, 0, 0, 0, 0, 'Darashia 1, Flat 01', 10, 20, 22000, 1100, 1, 2, 48, 0, 0),
(486, 0, 0, 0, 0, 0, 'Darashia 1, Flat 04', 10, 22, 23000, 1000, 1, 1, 42, 0, 0),
(487, 0, 0, 0, 0, 0, 'Darashia 1, Flat 03', 10, 48, 52000, 2660, 3, 4, 96, 0, 0),
(488, 0, 0, 0, 0, 0, 'Darashia 1, Flat 02', 10, 22, 23000, 1000, 1, 1, 41, 0, 0),
(490, 0, 0, 0, 0, 0, 'Darashia 1, Flat 12', 10, 37, 39000, 1780, 2, 2, 66, 0, 0),
(491, 0, 0, 0, 0, 0, 'Darashia 1, Flat 11', 10, 20, 22000, 1100, 1, 2, 41, 0, 0),
(492, 0, 0, 0, 0, 0, 'Darashia 1, Flat 13', 10, 37, 39000, 1780, 2, 2, 72, 0, 0),
(493, 0, 0, 0, 0, 0, 'Darashia 1, Flat 14', 10, 48, 53000, 2760, 3, 5, 108, 0, 0),
(494, 0, 0, 0, 0, 0, 'Darashia 4, Flat 01', 10, 22, 23000, 1000, 1, 1, 48, 0, 0),
(495, 0, 0, 0, 0, 0, 'Darashia 4, Flat 05', 10, 21, 23000, 1100, 1, 2, 48, 0, 0),
(496, 0, 0, 0, 0, 0, 'Darashia 4, Flat 04', 10, 38, 40000, 1780, 2, 2, 72, 0, 0),
(497, 0, 0, 0, 0, 0, 'Darashia 4, Flat 03', 10, 23, 24000, 1000, 1, 1, 42, 0, 0),
(498, 0, 0, 0, 0, 0, 'Darashia 4, Flat 02', 10, 38, 40000, 1780, 2, 2, 66, 0, 0),
(499, 0, 0, 0, 0, 0, 'Darashia 4, Flat 13', 10, 37, 39000, 1780, 2, 2, 78, 0, 0),
(500, 0, 0, 0, 0, 0, 'Darashia 4, Flat 14', 10, 37, 39000, 1780, 2, 2, 72, 0, 0),
(501, 0, 0, 0, 0, 0, 'Darashia 4, Flat 11', 10, 22, 23000, 1000, 1, 1, 41, 0, 0),
(502, 0, 0, 0, 0, 0, 'Darashia 4, Flat 12', 10, 52, 55000, 2560, 3, 3, 96, 0, 0),
(503, 0, 0, 0, 0, 0, 'Darashia 7, Flat 05', 10, 20, 22000, 1225, 1, 2, 40, 0, 0),
(504, 0, 0, 0, 0, 0, 'Darashia 7, Flat 01', 10, 22, 23000, 1125, 1, 1, 40, 0, 0),
(505, 0, 0, 0, 0, 0, 'Darashia 7, Flat 02', 10, 22, 23000, 1125, 1, 1, 41, 0, 0),
(506, 0, 0, 0, 0, 0, 'Darashia 7, Flat 03', 10, 50, 54000, 2955, 3, 4, 108, 0, 0),
(507, 0, 0, 0, 0, 0, 'Darashia 7, Flat 04', 10, 23, 24000, 1125, 1, 1, 42, 0, 0),
(508, 0, 0, 0, 0, 0, 'Darashia 7, Flat 14', 10, 48, 52000, 2955, 3, 4, 108, 0, 0),
(509, 0, 0, 0, 0, 0, 'Darashia 7, Flat 13', 10, 22, 23000, 1125, 1, 1, 42, 0, 0),
(510, 0, 0, 0, 0, 0, 'Darashia 7, Flat 11', 10, 22, 23000, 1125, 1, 1, 41, 0, 0),
(511, 0, 0, 0, 0, 0, 'Darashia 7, Flat 12', 10, 49, 53000, 2955, 3, 4, 95, 0, 0),
(512, 0, 0, 0, 0, 0, 'Darashia 5, Flat 01', 10, 22, 23000, 1000, 1, 1, 48, 0, 0),
(513, 0, 0, 0, 0, 0, 'Darashia 5, Flat 05', 10, 22, 23000, 1000, 1, 1, 48, 0, 0),
(514, 0, 0, 0, 0, 0, 'Darashia 5, Flat 02', 10, 32, 34000, 1620, 2, 2, 61, 0, 0),
(515, 0, 0, 0, 0, 0, 'Darashia 5, Flat 03', 10, 22, 23000, 1000, 1, 1, 41, 0, 0),
(516, 0, 0, 0, 0, 0, 'Darashia 5, Flat 04', 10, 32, 34000, 1620, 2, 2, 66, 0, 0),
(517, 0, 0, 0, 0, 0, 'Darashia 5, Flat 11', 10, 37, 39000, 1780, 2, 2, 66, 0, 0),
(518, 0, 0, 0, 0, 0, 'Darashia 5, Flat 12', 10, 34, 36000, 1620, 2, 2, 65, 0, 0),
(519, 0, 0, 0, 0, 0, 'Darashia 5, Flat 13', 10, 37, 39000, 1780, 2, 2, 78, 0, 0),
(520, 0, 0, 0, 0, 0, 'Darashia 5, Flat 14', 10, 33, 35000, 1620, 2, 2, 66, 0, 0),
(521, 0, 0, 0, 0, 0, 'Darashia 6a', 10, 62, 64000, 3115, 3, 2, 117, 0, 0),
(522, 0, 0, 0, 0, 0, 'Darashia 6b', 10, 69, 71000, 3430, 2, 2, 139, 0, 0),
(523, 0, 0, 0, 0, 0, 'Darashia, Villa', 10, 93, 97000, 5385, 11, 4, 233, 0, 0),
(525, 0, 0, 0, 0, 0, 'Darashia, Western Guildhall', 10, 154, 168000, 10435, 16, 14, 376, 0, 0),
(526, 0, 0, 0, 0, 0, 'Darashia 3, Flat 01', 10, 20, 22000, 1100, 1, 2, 40, 0, 0),
(527, 0, 0, 0, 0, 0, 'Darashia 3, Flat 05', 10, 22, 23000, 1000, 1, 1, 40, 0, 0),
(529, 0, 0, 0, 0, 0, 'Darashia 3, Flat 02', 10, 32, 34000, 1620, 2, 2, 65, 0, 0),
(530, 0, 0, 0, 0, 0, 'Darashia 3, Flat 03', 10, 20, 22000, 1100, 1, 2, 42, 0, 0),
(531, 0, 0, 0, 0, 0, 'Darashia 3, Flat 04', 10, 33, 35000, 1620, 2, 2, 72, 0, 0),
(532, 0, 0, 0, 0, 0, 'Darashia 3, Flat 13', 10, 20, 22000, 1100, 1, 2, 42, 0, 0),
(533, 0, 0, 0, 0, 0, 'Darashia 3, Flat 14', 10, 46, 49000, 2400, 3, 3, 102, 0, 0),
(534, 0, 0, 0, 0, 0, 'Darashia 3, Flat 11', 10, 22, 23000, 1000, 1, 1, 41, 0, 0),
(535, 0, 0, 0, 0, 0, 'Darashia 3, Flat 12', 10, 42, 47000, 2600, 3, 5, 90, 0, 0),
(541, 0, 0, 0, 0, 0, 'Darashia 8, Flat 11', 10, 37, 39000, 1990, 2, 2, 66, 0, 0),
(542, 0, 0, 0, 0, 0, 'Darashia 8, Flat 12', 10, 32, 34000, 1810, 2, 2, 65, 0, 0),
(544, 0, 0, 0, 0, 0, 'Darashia 8, Flat 14', 10, 32, 34000, 1810, 2, 2, 66, 0, 0),
(545, 0, 0, 0, 0, 0, 'Darashia 8, Flat 13', 10, 36, 38000, 1990, 2, 2, 78, 0, 0),
(574, 0, 0, 0, 0, 0, 'Oskahl I j', 9, 14, 15000, 680, 1, 1, 25, 0, 0),
(575, 0, 0, 0, 0, 0, 'Oskahl I f', 9, 18, 19000, 840, 1, 1, 34, 0, 0),
(576, 0, 0, 0, 0, 0, 'Oskahl I i', 9, 18, 19000, 840, 1, 1, 30, 0, 0),
(577, 0, 0, 0, 0, 0, 'Oskahl I g', 9, 21, 23000, 1140, 1, 2, 42, 0, 0),
(578, 0, 0, 0, 0, 0, 'Oskahl I h', 9, 32, 35000, 1760, 3, 3, 63, 0, 0),
(579, 0, 0, 0, 0, 0, 'Oskahl I d', 9, 21, 23000, 1140, 1, 2, 36, 0, 0),
(580, 0, 0, 0, 0, 0, 'Oskahl I b', 9, 18, 19000, 840, 1, 1, 30, 0, 0),
(581, 0, 0, 0, 0, 0, 'Oskahl I c', 9, 14, 15000, 680, 1, 1, 29, 0, 0),
(582, 0, 0, 0, 0, 0, 'Oskahl I e', 9, 18, 19000, 840, 1, 1, 33, 0, 0),
(583, 0, 0, 0, 0, 0, 'Oskahl I a', 9, 32, 34000, 1580, 1, 2, 52, 0, 0),
(584, 0, 0, 0, 0, 0, 'Chameken I', 9, 17, 18000, 850, 1, 1, 33, 0, 0),
(585, 0, 0, 0, 0, 0, 'Charsirakh III', 9, 14, 15000, 680, 1, 1, 30, 0, 0),
(586, 0, 0, 0, 0, 0, 'Murkhol I d', 9, 8, 9000, 440, 1, 1, 21, 0, 0),
(587, 0, 0, 0, 0, 0, 'Murkhol I c', 9, 8, 9000, 440, 1, 1, 18, 0, 0),
(588, 0, 0, 0, 0, 0, 'Murkhol I b', 9, 8, 9000, 440, 1, 1, 18, 0, 0),
(589, 0, 0, 0, 0, 0, 'Murkhol I a', 9, 8, 9000, 440, 1, 1, 20, 0, 0),
(590, 0, 0, 0, 0, 0, 'Charsirakh II', 9, 21, 23000, 1140, 1, 2, 39, 0, 0),
(591, 0, 0, 0, 0, 0, 'Thanah II h', 9, 21, 23000, 1400, 2, 2, 40, 0, 0),
(592, 0, 0, 0, 0, 0, 'Thanah II g', 9, 26, 28000, 1650, 1, 2, 45, 0, 0),
(593, 0, 0, 0, 0, 0, 'Thanah II f', 9, 45, 48000, 2850, 3, 3, 80, 0, 0),
(594, 0, 0, 0, 0, 0, 'Thanah II b', 9, 7, 8000, 450, 1, 1, 20, 0, 0),
(595, 0, 0, 0, 0, 0, 'Thanah II c', 9, 6, 7000, 450, 1, 1, 15, 0, 0),
(596, 0, 0, 0, 0, 0, 'Thanah II d', 9, 4, 5000, 350, 1, 1, 16, 0, 0),
(597, 0, 0, 0, 0, 0, 'Thanah II e', 9, 4, 5000, 350, 1, 1, 12, 0, 0),
(599, 0, 0, 0, 0, 0, 'Thanah II a', 9, 22, 23000, 850, 1, 1, 37, 0, 0),
(600, 0, 0, 0, 0, 0, 'Thrarhor I c (Shop)', 9, 25, 27000, 1050, 2, 2, 57, 0, 0),
(601, 0, 0, 0, 0, 0, 'Thrarhor I d (Shop)', 9, 10, 11000, 1050, 1, 1, 21, 0, 0),
(602, 0, 0, 0, 0, 0, 'Thrarhor I a (Shop)', 9, 10, 11000, 1050, 1, 1, 32, 0, 0),
(603, 0, 0, 0, 0, 0, 'Thrarhor I b (Shop)', 9, 10, 11000, 1050, 1, 1, 24, 0, 0),
(604, 0, 0, 0, 0, 0, 'Thanah I c', 9, 51, 54000, 3250, 4, 3, 91, 0, 0),
(605, 0, 0, 0, 0, 0, 'Thanah I d', 9, 42, 46000, 2900, 4, 4, 80, 0, 0),
(606, 0, 0, 0, 0, 0, 'Thanah I b', 9, 50, 53000, 3000, 3, 3, 84, 0, 0),
(607, 0, 0, 0, 0, 0, 'Thanah I a', 9, 14, 15000, 850, 1, 1, 27, 0, 0),
(608, 0, 0, 0, 0, 0, 'Harrah I', 9, 96, 106000, 5740, 7, 10, 190, 0, 0),
(609, 0, 0, 0, 0, 0, 'Charsirakh I b', 9, 32, 34000, 1580, 1, 2, 51, 0, 0),
(610, 0, 0, 0, 0, 0, 'Charsirakh I a', 9, 4, 5000, 280, 1, 1, 15, 0, 0),
(611, 0, 0, 0, 0, 0, 'Othehothep I d', 9, 34, 38000, 2020, 3, 4, 68, 0, 0),
(612, 0, 0, 0, 0, 0, 'Othehothep I c', 9, 31, 34000, 1720, 2, 3, 58, 0, 0),
(613, 0, 0, 0, 0, 0, 'Othehothep I b', 9, 26, 28000, 1380, 2, 2, 49, 0, 0),
(614, 0, 0, 0, 0, 0, 'Othehothep I a', 9, 5, 6000, 280, 1, 1, 14, 0, 0),
(615, 0, 0, 0, 0, 0, 'Othehothep II e', 9, 26, 28000, 1340, 1, 2, 44, 0, 0),
(616, 0, 0, 0, 0, 0, 'Othehothep II f', 9, 27, 29000, 1340, 1, 2, 44, 0, 0),
(617, 0, 0, 0, 0, 0, 'Othehothep II d', 9, 18, 19000, 840, 1, 1, 32, 0, 0),
(618, 0, 0, 0, 0, 0, 'Othehothep II c', 9, 18, 19000, 840, 1, 1, 30, 0, 0),
(619, 0, 0, 0, 0, 0, 'Othehothep II b', 9, 36, 39000, 1920, 3, 3, 67, 0, 0),
(620, 0, 0, 0, 0, 0, 'Othehothep II a', 9, 8, 9000, 400, 1, 1, 18, 0, 0),
(621, 0, 0, 0, 0, 0, 'Mothrem I', 9, 21, 23000, 1140, 1, 2, 38, 0, 0),
(622, 0, 0, 0, 0, 0, 'Arakmehn I', 9, 21, 24000, 1320, 1, 3, 41, 0, 0),
(623, 0, 0, 0, 0, 0, 'Othehothep III d', 9, 23, 24000, 1040, 1, 1, 36, 0, 0),
(624, 0, 0, 0, 0, 0, 'Othehothep III c', 9, 16, 18000, 940, 1, 2, 30, 0, 0),
(625, 0, 0, 0, 0, 0, 'Othehothep III e', 9, 18, 19000, 840, 1, 1, 32, 0, 0),
(626, 0, 0, 0, 0, 0, 'Othehothep III f', 9, 14, 15000, 680, 1, 1, 27, 0, 0),
(627, 0, 0, 0, 0, 0, 'Othehothep III b', 9, 26, 28000, 1340, 3, 2, 49, 0, 0),
(628, 0, 0, 0, 0, 0, 'Othehothep III a', 9, 4, 5000, 280, 1, 1, 14, 0, 0),
(629, 0, 0, 0, 0, 0, 'Unklath I d', 9, 30, 33000, 1680, 1, 3, 49, 0, 0),
(630, 0, 0, 0, 0, 0, 'Unklath I e', 9, 32, 34000, 1580, 1, 2, 51, 0, 0),
(631, 0, 0, 0, 0, 0, 'Unklath I g', 9, 34, 35000, 1480, 1, 1, 51, 0, 0),
(632, 0, 0, 0, 0, 0, 'Unklath I f', 9, 32, 34000, 1580, 1, 2, 51, 0, 0),
(633, 0, 0, 0, 0, 0, 'Unklath I c', 9, 29, 31000, 1460, 2, 2, 50, 0, 0),
(634, 0, 0, 0, 0, 0, 'Unklath I b', 9, 28, 30000, 1460, 2, 2, 50, 0, 0),
(635, 0, 0, 0, 0, 0, 'Unklath I a', 9, 21, 23000, 1140, 1, 2, 38, 0, 0),
(636, 0, 0, 0, 0, 0, 'Arakmehn II', 9, 23, 24000, 1040, 1, 1, 38, 0, 0),
(637, 0, 0, 0, 0, 0, 'Arakmehn III', 9, 21, 23000, 1140, 1, 2, 38, 0, 0),
(638, 0, 0, 0, 0, 0, 'Unklath II b', 9, 14, 15000, 680, 1, 1, 25, 0, 0),
(639, 0, 0, 0, 0, 0, 'Unklath II c', 9, 14, 15000, 680, 1, 1, 27, 0, 0),
(640, 0, 0, 0, 0, 0, 'Unklath II d', 9, 32, 34000, 1580, 1, 2, 52, 0, 0),
(641, 0, 0, 0, 0, 0, 'Unklath II a', 9, 23, 24000, 1040, 1, 1, 36, 0, 0),
(642, 0, 0, 0, 0, 0, 'Arakmehn IV', 9, 24, 26000, 1220, 1, 2, 41, 0, 0),
(643, 0, 0, 0, 0, 0, 'Rathal I b', 9, 14, 15000, 680, 1, 1, 25, 0, 0),
(644, 0, 0, 0, 0, 0, 'Rathal I c', 9, 14, 15000, 680, 1, 1, 27, 0, 0),
(645, 0, 0, 0, 0, 0, 'Rathal I e', 9, 12, 14000, 780, 1, 2, 27, 0, 0),
(646, 0, 0, 0, 0, 0, 'Rathal I d', 9, 12, 14000, 780, 1, 2, 27, 0, 0),
(647, 0, 0, 0, 0, 0, 'Rathal I a', 9, 21, 23000, 1140, 1, 2, 36, 0, 0),
(648, 0, 0, 0, 0, 0, 'Rathal II b', 9, 14, 15000, 680, 1, 1, 25, 0, 0),
(649, 0, 0, 0, 0, 0, 'Rathal II c', 9, 14, 15000, 680, 1, 1, 27, 0, 0),
(650, 0, 0, 0, 0, 0, 'Rathal II d', 9, 29, 31000, 1460, 2, 2, 52, 0, 0),
(651, 0, 0, 0, 0, 0, 'Rathal II a', 9, 24, 25000, 1040, 1, 1, 38, 0, 0),
(653, 0, 0, 0, 0, 0, 'Esuph II a', 9, 4, 5000, 280, 1, 1, 14, 0, 0),
(654, 0, 0, 0, 0, 0, 'Uthemath II', 9, 76, 84000, 4460, 3, 8, 138, 0, 0),
(655, 0, 0, 0, 0, 0, 'Uthemath I e', 9, 16, 18000, 940, 1, 2, 32, 0, 0),
(656, 0, 0, 0, 0, 0, 'Uthemath I d', 9, 18, 19000, 840, 1, 1, 30, 0, 0),
(657, 0, 0, 0, 0, 0, 'Uthemath I f', 9, 49, 52000, 2440, 4, 3, 86, 0, 0),
(658, 0, 0, 0, 0, 0, 'Uthemath I b', 9, 17, 18000, 800, 2, 1, 32, 0, 0),
(659, 0, 0, 0, 0, 0, 'Uthemath I c', 9, 15, 17000, 900, 2, 2, 34, 0, 0),
(660, 0, 0, 0, 0, 0, 'Uthemath I a', 9, 7, 8000, 400, 1, 1, 18, 0, 0),
(661, 0, 0, 0, 0, 0, 'Botham I c', 9, 26, 28000, 1700, 2, 2, 49, 0, 0),
(662, 0, 0, 0, 0, 0, 'Botham I e', 9, 27, 29000, 1650, 1, 2, 44, 0, 0),
(663, 0, 0, 0, 0, 0, 'Botham I d', 9, 50, 53000, 3050, 2, 3, 80, 0, 0),
(664, 0, 0, 0, 0, 0, 'Botham I b', 9, 47, 50000, 3000, 3, 3, 83, 0, 0),
(666, 0, 0, 0, 0, 0, 'Horakhal', 9, 174, 188000, 9420, 5, 14, 277, 0, 0),
(667, 0, 0, 0, 0, 0, 'Esuph III b', 9, 26, 28000, 1340, 3, 2, 49, 0, 0),
(668, 0, 0, 0, 0, 0, 'Esuph III a', 9, 4, 5000, 280, 1, 1, 14, 0, 0),
(669, 0, 0, 0, 0, 0, 'Esuph IV b', 9, 7, 8000, 400, 1, 1, 16, 0, 0),
(670, 0, 0, 0, 0, 0, 'Esuph IV c', 9, 7, 8000, 400, 1, 1, 18, 0, 0),
(671, 0, 0, 0, 0, 0, 'Esuph IV d', 9, 16, 17000, 800, 2, 1, 34, 0, 0),
(672, 0, 0, 0, 0, 0, 'Esuph IV a', 9, 7, 8000, 400, 1, 1, 16, 0, 0),
(673, 0, 0, 0, 0, 0, 'Botham II e', 9, 26, 28000, 1650, 1, 2, 42, 0, 0),
(674, 0, 0, 0, 0, 0, 'Botham II g', 9, 21, 23000, 1400, 1, 2, 38, 0, 0),
(675, 0, 0, 0, 0, 0, 'Botham II f', 9, 26, 28000, 1650, 1, 2, 44, 0, 0),
(676, 0, 0, 0, 0, 0, 'Botham II d', 9, 32, 34000, 1950, 1, 2, 49, 0, 0),
(677, 0, 0, 0, 0, 0, 'Botham II c', 9, 17, 19000, 1250, 2, 2, 38, 0, 0),
(678, 0, 0, 0, 0, 0, 'Botham II b', 9, 26, 28000, 1600, 2, 2, 47, 0, 0),
(679, 0, 0, 0, 0, 0, 'Botham II a', 9, 14, 15000, 850, 1, 1, 25, 0, 0),
(680, 0, 0, 0, 0, 0, 'Botham III g', 9, 26, 28000, 1650, 1, 2, 42, 0, 0),
(681, 0, 0, 0, 0, 0, 'Botham III f', 9, 36, 39000, 2350, 1, 3, 56, 0, 0),
(682, 0, 0, 0, 0, 0, 'Botham III h', 9, 64, 67000, 3750, 3, 3, 98, 0, 0),
(683, 0, 0, 0, 0, 0, 'Botham III d', 9, 14, 15000, 850, 1, 1, 27, 0, 0),
(684, 0, 0, 0, 0, 0, 'Botham III e', 9, 15, 16000, 850, 1, 1, 27, 0, 0),
(685, 0, 0, 0, 0, 0, 'Botham III b', 9, 12, 14000, 950, 1, 2, 25, 0, 0),
(686, 0, 0, 0, 0, 0, 'Botham III c', 9, 14, 15000, 850, 1, 1, 27, 0, 0),
(687, 0, 0, 0, 0, 0, 'Botham III a', 9, 22, 24000, 1400, 1, 2, 36, 0, 0),
(688, 0, 0, 0, 0, 0, 'Botham IV i', 9, 26, 29000, 1800, 2, 3, 51, 0, 0),
(689, 0, 0, 0, 0, 0, 'Botham IV h', 9, 34, 35000, 1850, 1, 1, 49, 0, 0),
(690, 0, 0, 0, 0, 0, 'Botham IV f', 9, 26, 28000, 1700, 2, 2, 49, 0, 0),
(691, 0, 0, 0, 0, 0, 'Botham IV g', 9, 24, 26000, 1650, 3, 2, 49, 0, 0),
(692, 0, 0, 0, 0, 0, 'Botham IV c', 9, 14, 15000, 850, 1, 1, 27, 0, 0),
(693, 0, 0, 0, 0, 0, 'Botham IV e', 9, 14, 15000, 850, 1, 1, 27, 0, 0),
(694, 0, 0, 0, 0, 0, 'Botham IV d', 9, 14, 15000, 850, 1, 1, 27, 0, 0),
(695, 0, 0, 0, 0, 0, 'Botham IV b', 9, 14, 15000, 850, 1, 1, 25, 0, 0),
(696, 0, 0, 0, 0, 0, 'Botham IV a', 9, 22, 24000, 1400, 1, 2, 36, 0, 0),
(697, 0, 0, 0, 0, 0, 'Ramen Tah', 9, 90, 106000, 7650, 4, 16, 182, 0, 0),
(698, 0, 0, 0, 0, 0, 'Banana Bay 1', 8, 7, 8000, 450, 3, 1, 25, 0, 0),
(699, 0, 0, 0, 0, 0, 'Banana Bay 2', 8, 14, 15000, 765, 5, 1, 36, 0, 0),
(700, 0, 0, 0, 0, 0, 'Banana Bay 3', 8, 7, 8000, 450, 3, 1, 25, 0, 0),
(701, 0, 0, 0, 0, 0, 'Banana Bay 4', 8, 7, 8000, 450, 2, 1, 25, 0, 0),
(702, 0, 0, 0, 0, 0, 'Shark Manor', 8, 127, 142000, 8780, 10, 15, 286, 0, 0),
(703, 0, 0, 0, 0, 0, 'Coconut Quay 1', 8, 32, 34000, 1765, 5, 2, 64, 0, 0),
(704, 0, 0, 0, 0, 0, 'Coconut Quay 2', 8, 16, 18000, 1045, 5, 2, 42, 0, 0),
(705, 0, 0, 0, 0, 0, 'Coconut Quay 3', 8, 32, 36000, 2145, 6, 4, 70, 0, 0),
(706, 0, 0, 0, 0, 0, 'Coconut Quay 4', 8, 36, 39000, 2135, 6, 3, 72, 0, 0),
(707, 0, 0, 0, 0, 0, 'Crocodile Bridge 3', 8, 22, 24000, 1270, 7, 2, 49, 0, 0),
(708, 0, 0, 0, 0, 0, 'Crocodile Bridge 2', 8, 12, 14000, 865, 5, 2, 36, 0, 0),
(709, 0, 0, 0, 0, 0, 'Crocodile Bridge 1', 8, 17, 19000, 1045, 7, 2, 42, 0, 0),
(710, 0, 0, 0, 0, 0, 'Bamboo Garden 1', 8, 25, 28000, 1640, 2, 3, 63, 0, 0),
(711, 0, 0, 0, 0, 0, 'Crocodile Bridge 4', 8, 88, 92000, 4755, 17, 4, 176, 0, 0),
(712, 0, 0, 0, 0, 0, 'Crocodile Bridge 5', 8, 80, 82000, 3970, 13, 2, 157, 0, 0),
(713, 0, 0, 0, 0, 0, 'Woodway 1', 8, 14, 15000, 765, 3, 1, 36, 0, 0),
(714, 0, 0, 0, 0, 0, 'Woodway 2', 8, 11, 12000, 585, 3, 1, 30, 0, 0),
(715, 0, 0, 0, 0, 0, 'Woodway 3', 8, 27, 29000, 1540, 8, 2, 65, 0, 0),
(716, 0, 0, 0, 0, 0, 'Woodway 4', 8, 6, 7000, 405, 5, 1, 24, 0, 0),
(717, 0, 0, 0, 0, 0, 'Flamingo Flats 5', 8, 38, 39000, 1845, 10, 1, 84, 0, 0),
(718, 0, 0, 0, 0, 0, 'Bamboo Fortress', 8, 381, 401000, 21970, 38, 20, 848, 0, 0),
(719, 0, 0, 0, 0, 0, 'Bamboo Garden 3', 8, 27, 29000, 1540, 4, 2, 63, 0, 0),
(720, 0, 0, 0, 0, 0, 'Bamboo Garden 2', 8, 16, 18000, 1045, 3, 2, 42, 0, 0),
(721, 0, 0, 0, 0, 0, 'Flamingo Flats 4', 8, 12, 14000, 865, 5, 2, 36, 0, 0),
(722, 0, 0, 0, 0, 0, 'Flamingo Flats 2', 8, 16, 18000, 1045, 6, 2, 42, 0, 0),
(723, 0, 0, 0, 0, 0, 'Flamingo Flats 3', 8, 8, 10000, 685, 3, 2, 30, 0, 0),
(724, 0, 0, 0, 0, 0, 'Flamingo Flats 1', 8, 8, 10000, 685, 4, 2, 30, 0, 0),
(725, 0, 0, 0, 0, 0, 'Jungle Edge 4', 8, 12, 14000, 865, 5, 2, 36, 0, 0),
(726, 0, 0, 0, 0, 0, 'Jungle Edge 5', 8, 12, 14000, 865, 6, 2, 36, 0, 0),
(727, 0, 0, 0, 0, 0, 'Jungle Edge 6', 8, 7, 8000, 450, 2, 1, 25, 0, 0),
(728, 0, 0, 0, 0, 0, 'Jungle Edge 2', 8, 59, 62000, 3170, 14, 3, 128, 0, 0),
(729, 0, 0, 0, 0, 0, 'Jungle Edge 3', 8, 12, 14000, 865, 4, 2, 36, 0, 0),
(730, 0, 0, 0, 0, 0, 'Jungle Edge 1', 8, 44, 47000, 2495, 8, 3, 98, 0, 0),
(731, 0, 0, 0, 0, 0, 'Haggler''s Hangout 6', 8, 113, 117000, 6450, 14, 4, 208, 0, 0),
(732, 0, 0, 0, 0, 0, 'Haggler''s Hangout 5 (Shop)', 8, 24, 25000, 1550, 5, 1, 56, 0, 0),
(733, 0, 0, 0, 0, 0, 'Haggler''s Hangout 4a (Shop)', 8, 30, 31000, 1850, 4, 1, 56, 0, 0),
(734, 0, 0, 0, 0, 0, 'Haggler''s Hangout 4b (Shop)', 8, 24, 25000, 1550, 5, 1, 56, 0, 0),
(735, 0, 0, 0, 0, 0, 'Haggler''s Hangout 3', 8, 137, 141000, 7550, 14, 4, 256, 0, 0),
(736, 0, 0, 0, 0, 0, 'Haggler''s Hangout 2', 8, 23, 24000, 1300, 4, 1, 49, 0, 0),
(737, 0, 0, 0, 0, 0, 'Haggler''s Hangout 1', 8, 22, 24000, 1400, 4, 2, 49, 0, 0),
(738, 0, 0, 0, 0, 0, 'River Homes 1', 8, 66, 69000, 3485, 11, 3, 128, 0, 0),
(739, 0, 0, 0, 0, 0, 'River Homes 2a', 8, 21, 23000, 1270, 5, 2, 42, 0, 0),
(740, 0, 0, 0, 0, 0, 'River Homes 2b', 8, 24, 27000, 1595, 6, 3, 56, 0, 0),
(741, 0, 0, 0, 0, 0, 'River Homes 3', 8, 82, 89000, 5055, 11, 7, 176, 0, 0),
(742, 0, 0, 0, 0, 0, 'The Treehouse', 8, 484, 507000, 24120, 13, 23, 897, 0, 0),
(743, 0, 0, 0, 0, 0, 'Corner Shop (Shop)', 12, 36, 38000, 2215, 11, 2, 96, 0, 0),
(744, 0, 0, 0, 0, 0, 'Tusk Flats 1', 12, 14, 16000, 765, 4, 2, 40, 0, 0),
(745, 0, 0, 0, 0, 0, 'Tusk Flats 2', 12, 16, 18000, 835, 3, 2, 42, 0, 0),
(746, 0, 0, 0, 0, 0, 'Tusk Flats 3', 12, 11, 13000, 660, 3, 2, 34, 0, 0),
(747, 0, 0, 0, 0, 0, 'Tusk Flats 4', 12, 6, 7000, 315, 2, 1, 24, 0, 0),
(748, 0, 0, 0, 0, 0, 'Tusk Flats 6', 12, 12, 14000, 660, 3, 2, 35, 0, 0),
(749, 0, 0, 0, 0, 0, 'Tusk Flats 5', 12, 11, 12000, 455, 3, 1, 30, 0, 0),
(750, 0, 0, 0, 0, 0, 'Shady Rocks 5', 12, 57, 59000, 2890, 7, 2, 110, 0, 0),
(751, 0, 0, 0, 0, 0, 'Shady Rocks 4 (Shop)', 12, 50, 52000, 2710, 11, 2, 110, 0, 0),
(752, 0, 0, 0, 0, 0, 'Shady Rocks 3', 12, 77, 80000, 4115, 13, 3, 154, 0, 0),
(753, 0, 0, 0, 0, 0, 'Shady Rocks 2', 12, 29, 33000, 2010, 6, 4, 77, 0, 0),
(754, 0, 0, 0, 0, 0, 'Shady Rocks 1', 12, 65, 69000, 3630, 9, 4, 132, 0, 0),
(755, 0, 0, 0, 0, 0, 'Crystal Glance', 12, 237, 261000, 19625, 29, 24, 569, 0, 0),
(756, 0, 0, 0, 0, 0, 'Arena Walk 3', 12, 59, 62000, 3550, 9, 3, 126, 0, 0),
(757, 0, 0, 0, 0, 0, 'Arena Walk 2', 12, 21, 23000, 1400, 5, 2, 54, 0, 0),
(758, 0, 0, 0, 0, 0, 'Arena Walk 1', 12, 55, 58000, 3250, 10, 3, 128, 0, 0),
(759, 0, 0, 0, 0, 0, 'Bears Paw 2', 12, 44, 46000, 2305, 8, 2, 100, 0, 0),
(760, 0, 0, 0, 0, 0, 'Bears Paw 1', 12, 33, 35000, 1810, 6, 2, 72, 0, 0),
(761, 0, 0, 0, 0, 0, 'Spirit Homes 5', 12, 21, 23000, 1450, 4, 2, 56, 0, 0),
(762, 0, 0, 0, 0, 0, 'Glacier Side 3', 12, 30, 32000, 1950, 7, 2, 75, 0, 0),
(763, 0, 0, 0, 0, 0, 'Glacier Side 2', 12, 83, 86000, 4750, 11, 3, 154, 0, 0),
(764, 0, 0, 0, 0, 0, 'Glacier Side 1', 12, 26, 28000, 1600, 7, 2, 65, 0, 0),
(765, 0, 0, 0, 0, 0, 'Spirit Homes 1', 12, 27, 29000, 1700, 5, 2, 56, 0, 0),
(766, 0, 0, 0, 0, 0, 'Spirit Homes 2', 12, 31, 33000, 1900, 6, 2, 72, 0, 0),
(767, 0, 0, 0, 0, 0, 'Spirit Homes 3', 12, 75, 78000, 4250, 6, 3, 128, 0, 0),
(768, 0, 0, 0, 0, 0, 'Spirit Homes 4', 12, 19, 20000, 1100, 4, 1, 49, 0, 0),
(770, 0, 0, 0, 0, 0, 'Glacier Side 4', 12, 38, 39000, 2050, 8, 1, 75, 0, 0),
(771, 0, 0, 0, 0, 0, 'Shelf Site', 12, 83, 86000, 4800, 11, 3, 160, 0, 0),
(772, 0, 0, 0, 0, 0, 'Raven Corner 1', 12, 15, 16000, 855, 5, 1, 45, 0, 0),
(773, 0, 0, 0, 0, 0, 'Raven Corner 2', 12, 25, 28000, 1685, 6, 3, 60, 0, 0),
(774, 0, 0, 0, 0, 0, 'Raven Corner 3', 12, 15, 16000, 855, 5, 1, 45, 0, 0),
(775, 0, 0, 0, 0, 0, 'Bears Paw 3', 12, 35, 38000, 2090, 8, 3, 82, 0, 0),
(776, 0, 0, 0, 0, 0, 'Bears Paw 4', 12, 99, 103000, 5205, 15, 4, 189, 0, 0),
(778, 0, 0, 0, 0, 0, 'Bears Paw 5', 12, 34, 37000, 2045, 7, 3, 81, 0, 0),
(779, 0, 0, 0, 0, 0, 'Trout Plaza 5 (Shop)', 12, 73, 75000, 3880, 12, 2, 144, 0, 0),
(780, 0, 0, 0, 0, 0, 'Pilchard Bin 1', 12, 8, 10000, 685, 2, 2, 30, 0, 0),
(781, 0, 0, 0, 0, 0, 'Pilchard Bin 2', 12, 8, 10000, 685, 2, 2, 24, 0, 0),
(782, 0, 0, 0, 0, 0, 'Pilchard Bin 3', 12, 10, 11000, 585, 2, 1, 24, 0, 0),
(783, 0, 0, 0, 0, 0, 'Pilchard Bin 4', 12, 10, 11000, 585, 2, 1, 24, 0, 0),
(784, 0, 0, 0, 0, 0, 'Pilchard Bin 5', 12, 8, 10000, 685, 2, 2, 24, 0, 0),
(785, 0, 0, 0, 0, 0, 'Pilchard Bin 10', 12, 7, 8000, 450, 2, 1, 20, 0, 0),
(786, 0, 0, 0, 0, 0, 'Pilchard Bin 9', 12, 7, 8000, 450, 2, 1, 20, 0, 0),
(787, 0, 0, 0, 0, 0, 'Pilchard Bin 8', 12, 6, 8000, 450, 2, 2, 20, 0, 0),
(789, 0, 0, 0, 0, 0, 'Pilchard Bin 7', 12, 7, 8000, 450, 2, 1, 20, 0, 0),
(790, 0, 0, 0, 0, 0, 'Pilchard Bin 6', 12, 7, 8000, 450, 2, 1, 25, 0, 0),
(791, 0, 0, 0, 0, 0, 'Trout Plaza 1', 12, 43, 45000, 2395, 9, 2, 112, 0, 0),
(792, 0, 0, 0, 0, 0, 'Trout Plaza 2', 12, 26, 28000, 1540, 6, 2, 64, 0, 0),
(793, 0, 0, 0, 0, 0, 'Trout Plaza 3', 12, 18, 19000, 900, 4, 1, 36, 0, 0),
(794, 0, 0, 0, 0, 0, 'Trout Plaza 4', 12, 18, 19000, 900, 4, 1, 45, 0, 0),
(795, 0, 0, 0, 0, 0, 'Skiffs End 1', 12, 28, 30000, 1540, 6, 2, 70, 0, 0),
(796, 0, 0, 0, 0, 0, 'Skiffs End 2', 12, 13, 15000, 910, 5, 2, 42, 0, 0),
(797, 0, 0, 0, 0, 0, 'Furrier Quarter 3', 12, 20, 22000, 1010, 5, 2, 54, 0, 0),
(798, 0, 0, 0, 0, 0, 'Mammoth Belly', 12, 278, 308000, 22810, 39, 30, 634, 0, 0),
(799, 0, 0, 0, 0, 0, 'Furrier Quarter 2', 12, 21, 23000, 1045, 6, 2, 56, 0, 0),
(800, 0, 0, 0, 0, 0, 'Furrier Quarter 1', 12, 34, 37000, 1635, 8, 3, 84, 0, 0),
(801, 0, 0, 0, 0, 0, 'Fimbul Shelf 3', 12, 28, 30000, 1255, 6, 2, 66, 0, 0),
(802, 0, 0, 0, 0, 0, 'Fimbul Shelf 4', 12, 22, 24000, 1045, 4, 2, 56, 0, 0),
(803, 0, 0, 0, 0, 0, 'Fimbul Shelf 2', 12, 21, 23000, 1045, 5, 2, 56, 0, 0),
(804, 0, 0, 0, 0, 0, 'Fimbul Shelf 1', 12, 20, 22000, 975, 4, 2, 48, 0, 0),
(805, 0, 0, 0, 0, 0, 'Frost Manor', 12, 382, 406000, 26370, 39, 24, 806, 0, 0),
(806, 0, 0, 0, 0, 0, 'Lower Barracks 11', 3, 7, 8000, 300, 1, 1, 20, 0, 0),
(807, 0, 0, 0, 0, 0, 'Lower Barracks 12', 3, 7, 8000, 300, 1, 1, 16, 0, 0),
(808, 0, 0, 0, 0, 0, 'Lower Barracks 9', 3, 7, 8000, 300, 1, 1, 20, 0, 0),
(809, 0, 0, 0, 0, 0, 'Lower Barracks 10', 3, 7, 8000, 300, 1, 1, 19, 0, 0),
(810, 0, 0, 0, 0, 0, 'Lower Barracks 7', 3, 7, 8000, 300, 1, 1, 20, 0, 0),
(811, 0, 0, 0, 0, 0, 'Lower Barracks 8', 3, 7, 8000, 300, 1, 1, 16, 0, 0),
(812, 0, 0, 0, 0, 0, 'Lower Barracks 5', 3, 7, 8000, 300, 1, 1, 20, 0, 0),
(813, 0, 0, 0, 0, 0, 'Lower Barracks 6', 3, 7, 8000, 300, 1, 1, 16, 0, 0),
(814, 0, 0, 0, 0, 0, 'Lower Barracks 3', 3, 7, 8000, 300, 1, 1, 20, 0, 0),
(815, 0, 0, 0, 0, 0, 'Lower Barracks 4', 3, 7, 8000, 300, 1, 1, 19, 0, 0),
(816, 0, 0, 0, 0, 0, 'Lower Barracks 1', 3, 7, 8000, 300, 1, 1, 20, 0, 0),
(817, 0, 0, 0, 0, 0, 'Lower Barracks 2', 3, 7, 8000, 300, 1, 1, 16, 0, 0),
(818, 0, 0, 0, 0, 0, 'Lower Barracks 24', 3, 7, 8000, 300, 1, 1, 20, 0, 0),
(819, 0, 0, 0, 0, 0, 'Lower Barracks 23', 3, 7, 8000, 300, 1, 1, 16, 0, 0),
(820, 0, 0, 0, 0, 0, 'Lower Barracks 22', 3, 7, 8000, 300, 1, 1, 20, 0, 0),
(821, 0, 0, 0, 0, 0, 'Lower Barracks 21', 3, 7, 8000, 300, 1, 1, 16, 0, 0),
(822, 0, 0, 0, 0, 0, 'Lower Barracks 20', 3, 7, 8000, 300, 1, 1, 20, 0, 0),
(823, 0, 0, 0, 0, 0, 'Lower Barracks 19', 3, 7, 8000, 300, 1, 1, 16, 0, 0),
(824, 0, 0, 0, 0, 0, 'Lower Barracks 18', 3, 7, 8000, 300, 1, 1, 20, 0, 0),
(825, 0, 0, 0, 0, 0, 'Lower Barracks 17', 3, 7, 8000, 300, 1, 1, 16, 0, 0),
(826, 0, 0, 0, 0, 0, 'Lower Barracks 16', 3, 7, 8000, 300, 1, 1, 20, 0, 0),
(828, 0, 0, 0, 0, 0, 'Lower Barracks 15', 3, 7, 8000, 300, 1, 1, 16, 0, 0),
(829, 0, 0, 0, 0, 0, 'Lower Barracks 14', 3, 7, 8000, 300, 1, 1, 20, 0, 0),
(830, 0, 0, 0, 0, 0, 'Lower Barracks 13', 3, 7, 8000, 300, 1, 1, 16, 0, 0),
(831, 0, 0, 0, 0, 0, 'Marble Guildhall', 3, 282, 299000, 16810, 18, 17, 540, 0, 0),
(832, 0, 0, 0, 0, 0, 'Iron Guildhall', 3, 243, 260000, 15560, 15, 17, 464, 0, 0),
(833, 0, 0, 0, 0, 0, 'The Market 1 (Shop)', 3, 8, 9000, 650, 2, 1, 25, 0, 0),
(834, 0, 0, 0, 0, 0, 'The Market 3 (Shop)', 3, 22, 23000, 1450, 2, 1, 40, 0, 0),
(835, 0, 0, 0, 0, 0, 'The Market 2 (Shop)', 3, 17, 18000, 1100, 2, 1, 40, 0, 0),
(836, 0, 0, 0, 0, 0, 'The Market 4 (Shop)', 3, 28, 29000, 1800, 2, 1, 48, 0, 0),
(837, 0, 0, 0, 0, 0, 'Granite Guildhall', 3, 296, 313000, 17845, 18, 17, 589, 0, 0),
(838, 0, 0, 0, 0, 0, 'Upper Barracks 1', 3, 4, 5000, 210, 1, 1, 20, 0, 0),
(839, 0, 0, 0, 0, 0, 'Upper Barracks 2', 3, 4, 5000, 210, 1, 1, 15, 0, 0),
(840, 0, 0, 0, 0, 0, 'Upper Barracks 3', 3, 4, 5000, 210, 1, 1, 15, 0, 0),
(841, 0, 0, 0, 0, 0, 'Upper Barracks 4', 3, 4, 5000, 210, 1, 1, 15, 0, 0),
(842, 0, 0, 0, 0, 0, 'Upper Barracks 5', 3, 4, 5000, 210, 1, 1, 12, 0, 0),
(843, 0, 0, 0, 0, 0, 'Upper Barracks 6', 3, 4, 5000, 210, 1, 1, 12, 0, 0),
(844, 0, 0, 0, 0, 0, 'Upper Barracks 7', 3, 4, 5000, 210, 1, 1, 16, 0, 0),
(845, 0, 0, 0, 0, 0, 'Upper Barracks 8', 3, 4, 5000, 210, 1, 1, 20, 0, 0),
(847, 0, 0, 0, 0, 0, 'Upper Barracks 10', 3, 4, 5000, 210, 1, 1, 15, 0, 0),
(848, 0, 0, 0, 0, 0, 'Upper Barracks 11', 3, 4, 5000, 210, 1, 1, 15, 0, 0),
(849, 0, 0, 0, 0, 0, 'Upper Barracks 12', 3, 4, 5000, 210, 1, 1, 16, 0, 0),
(850, 0, 0, 0, 0, 0, 'Upper Barracks 13', 3, 11, 13000, 580, 1, 2, 24, 0, 0),
(851, 0, 0, 0, 0, 0, 'Nobility Quarter 4', 3, 14, 15000, 765, 1, 1, 25, 0, 0),
(852, 0, 0, 0, 0, 0, 'Nobility Quarter 5', 3, 15, 16000, 765, 1, 1, 25, 0, 0),
(853, 0, 0, 0, 0, 0, 'Nobility Quarter 7', 3, 14, 15000, 765, 1, 1, 30, 0, 0),
(854, 0, 0, 0, 0, 0, 'Nobility Quarter 6', 3, 14, 15000, 765, 1, 1, 30, 0, 0),
(855, 0, 0, 0, 0, 0, 'Nobility Quarter 8', 3, 14, 15000, 765, 1, 1, 30, 0, 0),
(856, 0, 0, 0, 0, 0, 'Nobility Quarter 9', 3, 14, 15000, 765, 1, 1, 30, 0, 0),
(857, 0, 0, 0, 0, 0, 'Nobility Quarter 2', 3, 30, 33000, 1865, 1, 3, 56, 0, 0),
(858, 0, 0, 0, 0, 0, 'Nobility Quarter 3', 3, 30, 33000, 1865, 1, 3, 56, 0, 0),
(859, 0, 0, 0, 0, 0, 'Nobility Quarter 1', 3, 30, 33000, 1865, 1, 3, 62, 0, 0),
(863, 0, 0, 0, 0, 0, 'The Farms 6, Fishing Hut', 3, 16, 18000, 1255, 1, 2, 36, 0, 0),
(864, 0, 0, 0, 0, 0, 'The Farms 5', 3, 21, 23000, 1530, 1, 2, 36, 0, 0),
(865, 0, 0, 0, 0, 0, 'The Farms 4', 3, 21, 23000, 1530, 1, 2, 36, 0, 0),
(866, 0, 0, 0, 0, 0, 'The Farms 3', 3, 21, 23000, 1530, 1, 2, 36, 0, 0),
(867, 0, 0, 0, 0, 0, 'The Farms 2', 3, 21, 23000, 1530, 1, 2, 36, 0, 0),
(868, 0, 0, 0, 0, 0, 'The Farms 1', 3, 34, 37000, 2510, 2, 3, 60, 0, 0),
(869, 0, 0, 0, 0, 0, 'Outlaw Camp 12 (Shop)', 3, 6, 6000, 280, 1, 0, 12, 0, 0),
(870, 0, 0, 0, 0, 0, 'Outlaw Camp 13 (Shop)', 3, 6, 6000, 280, 1, 0, 12, 0, 0),
(871, 0, 0, 0, 0, 0, 'Outlaw Camp 14 (Shop)', 3, 16, 16000, 640, 1, 0, 30, 0, 0),
(872, 0, 0, 0, 0, 0, 'Outlaw Camp 7', 3, 12, 14000, 780, 1, 2, 38, 0, 0),
(874, 0, 0, 0, 0, 0, 'Outlaw Camp 8', 3, 5, 6000, 280, 1, 1, 20, 0, 0),
(877, 0, 0, 0, 0, 0, 'Outlaw Camp 9', 3, 3, 4000, 200, 1, 1, 12, 0, 0),
(878, 0, 0, 0, 0, 0, 'Outlaw Camp 10', 3, 2, 3000, 200, 1, 1, 12, 0, 0),
(879, 0, 0, 0, 0, 0, 'Outlaw Camp 11', 3, 2, 3000, 200, 1, 1, 16, 0, 0),
(880, 0, 0, 0, 0, 0, 'Outlaw Camp 2', 3, 4, 5000, 280, 3, 1, 20, 0, 0),
(881, 0, 0, 0, 0, 0, 'Outlaw Camp 3', 3, 11, 13000, 740, 4, 2, 35, 0, 0),
(882, 0, 0, 0, 0, 0, 'Outlaw Camp 4', 3, 2, 3000, 200, 3, 1, 12, 0, 0),
(883, 0, 0, 0, 0, 0, 'Outlaw Camp 5', 3, 2, 3000, 200, 3, 1, 12, 0, 0),
(884, 0, 0, 0, 0, 0, 'Outlaw Camp 6', 3, 2, 3000, 200, 3, 1, 16, 0, 0),
(885, 0, 0, 0, 0, 0, 'Outlaw Camp 1', 3, 46, 48000, 1660, 1, 2, 91, 0, 0),
(886, 0, 0, 0, 0, 0, 'Outlaw Castle', 3, 158, 167000, 8000, 11, 9, 410, 0, 0),
(888, 0, 0, 0, 0, 0, 'Tunnel Gardens 1', 3, 20, 23000, 1820, 1, 3, 44, 0, 0),
(889, 0, 0, 0, 0, 0, 'Tunnel Gardens 3', 3, 23, 26000, 2000, 1, 3, 48, 0, 0),
(890, 0, 0, 0, 0, 0, 'Tunnel Gardens 4', 3, 24, 27000, 2000, 1, 3, 45, 0, 0),
(891, 0, 0, 0, 0, 0, 'Tunnel Gardens 2', 3, 20, 23000, 1820, 1, 3, 47, 0, 0),
(892, 0, 0, 0, 0, 0, 'Tunnel Gardens 5', 3, 16, 18000, 1360, 1, 2, 35, 0, 0),
(893, 0, 0, 0, 0, 0, 'Tunnel Gardens 6', 3, 16, 18000, 1360, 1, 2, 38, 0, 0),
(894, 0, 0, 0, 0, 0, 'Tunnel Gardens 8', 3, 16, 18000, 1360, 1, 2, 35, 0, 0),
(895, 0, 0, 0, 0, 0, 'Tunnel Gardens 7', 3, 16, 18000, 1360, 1, 2, 35, 0, 0),
(896, 0, 0, 0, 0, 0, 'Tunnel Gardens 12', 3, 11, 13000, 1060, 1, 2, 24, 0, 0),
(897, 0, 0, 0, 0, 0, 'Tunnel Gardens 11', 3, 11, 13000, 1060, 1, 2, 32, 0, 0),
(898, 0, 0, 0, 0, 0, 'Tunnel Gardens 9', 3, 10, 12000, 1000, 1, 2, 29, 0, 0),
(899, 0, 0, 0, 0, 0, 'Tunnel Gardens 10', 3, 10, 12000, 1000, 1, 2, 29, 0, 0),
(900, 0, 0, 0, 0, 0, 'Wolftower', 3, 316, 339000, 21550, 35, 23, 699, 0, 0),
(901, 0, 0, 0, 0, 0, 'Paupers Palace, Flat 11', 1, 4, 5000, 315, 2, 1, 14, 0, 0),
(902, 0, 0, 0, 0, 0, 'Upper Barracks 9', 3, 4, 5000, 210, 1, 1, 15, 0, 0),
(905, 0, 0, 0, 0, 0, 'Botham I a', 9, 21, 22000, 950, 1, 1, 36, 0, 0),
(906, 0, 0, 0, 0, 0, 'Esuph I', 9, 18, 19000, 680, 1, 1, 39, 0, 0),
(907, 0, 0, 0, 0, 0, 'Esuph II b', 9, 26, 28000, 1380, 2, 2, 51, 0, 0),
(1883, 0, 0, 0, 0, 0, 'Aureate Court 1', 13, 116, 119000, 5240, 7, 3, 276, 0, 0),
(1884, 0, 0, 0, 0, 0, 'Aureate Court 2', 13, 120, 122000, 4860, 2, 2, 198, 0, 0),
(1885, 0, 0, 0, 0, 0, 'Aureate Court 3', 13, 115, 117000, 4300, 4, 2, 226, 0, 0),
(1886, 0, 0, 0, 0, 0, 'Aureate Court 4', 13, 82, 86000, 3980, 5, 4, 208, 0, 0),
(1887, 0, 0, 0, 0, 0, 'Fortune Wing 1', 13, 237, 241000, 10180, 4, 4, 420, 0, 0),
(1888, 0, 0, 0, 0, 0, 'Fortune Wing 2', 13, 130, 132000, 5580, 5, 2, 260, 0, 0),
(1889, 0, 0, 0, 0, 0, 'Fortune Wing 3', 13, 135, 137000, 5740, 4, 2, 258, 0, 0),
(1890, 0, 0, 0, 0, 0, 'Fortune Wing 4', 13, 129, 133000, 5740, 4, 4, 305, 0, 0),
(1891, 0, 0, 0, 0, 0, 'Luminous Arc 1', 13, 147, 149000, 6460, 8, 2, 344, 0, 0),
(1892, 0, 0, 0, 0, 0, 'Luminous Arc 2', 13, 145, 149000, 6460, 3, 4, 301, 0, 0),
(1893, 0, 0, 0, 0, 0, 'Luminous Arc 3', 13, 121, 124000, 5400, 6, 3, 249, 0, 0),
(1894, 0, 0, 0, 0, 0, 'Luminous Arc 4', 13, 175, 180000, 8000, 7, 5, 343, 0, 0),
(1895, 0, 0, 0, 0, 0, 'Radiant Plaza 1', 13, 123, 127000, 5620, 5, 4, 276, 0, 0),
(1896, 0, 0, 0, 0, 0, 'Radiant Plaza 2', 13, 87, 89000, 3820, 2, 2, 179, 0, 0),
(1897, 0, 0, 0, 0, 0, 'Radiant Plaza 3', 13, 114, 116000, 4900, 4, 2, 256, 0, 0),
(1898, 0, 0, 0, 0, 0, 'Radiant Plaza 4', 13, 178, 181000, 7460, 4, 3, 367, 0, 0),
(1899, 0, 0, 0, 0, 0, 'Sun Palace', 13, 460, 487000, 23120, 12, 27, 974, 0, 0),
(1900, 0, 0, 0, 0, 0, 'Halls of Serenity', 13, 432, 465000, 23360, 21, 33, 1090, 0, 0),
(1901, 0, 0, 0, 0, 0, 'Cascade Towers', 13, 315, 348000, 19500, 24, 33, 810, 0, 0),
(1902, 0, 0, 0, 0, 0, 'Sorcerer''s Avenue 5', 2, 42, 43000, 2695, 6, 1, 96, 0, 0),
(1903, 0, 0, 0, 0, 0, 'Sorcerer''s Avenue 1a', 2, 16, 18000, 1255, 4, 2, 42, 0, 0),
(1904, 0, 0, 0, 0, 0, 'Sorcerer''s Avenue 1b', 2, 12, 14000, 1035, 3, 2, 36, 0, 0),
(1905, 0, 0, 0, 0, 0, 'Sorcerer''s Avenue 1c', 2, 16, 18000, 1255, 5, 2, 36, 0, 0),
(1906, 0, 0, 0, 0, 0, 'Beach Home Apartments, Flat 06', 2, 14, 16000, 1145, 6, 2, 40, 0, 0),
(1907, 0, 0, 0, 0, 0, 'Beach Home Apartments, Flat 01', 2, 10, 11000, 715, 4, 1, 30, 0, 0),
(1908, 0, 0, 0, 0, 0, 'Beach Home Apartments, Flat 02', 2, 10, 11000, 715, 4, 1, 25, 0, 0),
(1909, 0, 0, 0, 0, 0, 'Beach Home Apartments, Flat 03', 2, 10, 11000, 715, 3, 1, 30, 0, 0),
(1910, 0, 0, 0, 0, 0, 'Beach Home Apartments, Flat 04', 2, 10, 11000, 715, 2, 1, 24, 0, 0),
(1911, 0, 0, 0, 0, 0, 'Beach Home Apartments, Flat 05', 2, 10, 11000, 715, 3, 1, 24, 0, 0),
(1912, 0, 0, 0, 0, 0, 'Beach Home Apartments, Flat 16', 2, 14, 16000, 1145, 3, 2, 40, 0, 0),
(1913, 0, 0, 0, 0, 0, 'Beach Home Apartments, Flat 11', 2, 10, 11000, 715, 3, 1, 30, 0, 0),
(1914, 0, 0, 0, 0, 0, 'Beach Home Apartments, Flat 12', 2, 13, 14000, 880, 3, 1, 30, 0, 0),
(1915, 0, 0, 0, 0, 0, 'Beach Home Apartments, Flat 13', 2, 13, 14000, 880, 4, 1, 29, 0, 0),
(1916, 0, 0, 0, 0, 0, 'Beach Home Apartments, Flat 14', 2, 4, 5000, 385, 2, 1, 15, 0, 0),
(1917, 0, 0, 0, 0, 0, 'Beach Home Apartments, Flat 15', 2, 4, 5000, 385, 3, 1, 15, 0, 0),
(1918, 0, 0, 0, 0, 0, 'Thais Clanhall', 2, 154, 164000, 8420, 30, 10, 370, 0, 0),
(1919, 0, 0, 0, 0, 0, 'Harbour Street 4', 2, 14, 15000, 935, 2, 1, 30, 0, 0),
(1920, 0, 0, 0, 0, 0, 'Thais Hostel', 2, 63, 87000, 6980, 15, 24, 171, 0, 0),
(1921, 0, 0, 0, 0, 0, 'Lower Swamp Lane 1', 2, 62, 66000, 4740, 13, 4, 166, 0, 0),
(1923, 0, 0, 0, 0, 0, 'Lower Swamp Lane 3', 2, 62, 66000, 4740, 13, 4, 161, 0, 0),
(1924, 0, 0, 0, 0, 0, 'Sunset Homes, Flat 01', 2, 10, 11000, 520, 3, 1, 25, 0, 0),
(1925, 0, 0, 0, 0, 0, 'Sunset Homes, Flat 02', 2, 10, 11000, 520, 2, 1, 30, 0, 0),
(1926, 0, 0, 0, 0, 0, 'Sunset Homes, Flat 03', 2, 10, 11000, 520, 2, 1, 30, 0, 0),
(1927, 0, 0, 0, 0, 0, 'Sunset Homes, Flat 14', 2, 10, 11000, 520, 5, 1, 30, 0, 0),
(1929, 0, 0, 0, 0, 0, 'Sunset Homes, Flat 13', 2, 15, 17000, 860, 4, 2, 35, 0, 0),
(1930, 0, 0, 0, 0, 0, 'Sunset Homes, Flat 12', 2, 10, 11000, 520, 3, 1, 25, 0, 0),
(1932, 0, 0, 0, 0, 0, 'Sunset Homes, Flat 11', 2, 10, 11000, 520, 3, 1, 25, 0, 0),
(1935, 0, 0, 0, 0, 0, 'Sunset Homes, Flat 24', 2, 10, 11000, 520, 5, 1, 30, 0, 0),
(1936, 0, 0, 0, 0, 0, 'Sunset Homes, Flat 23', 2, 14, 16000, 860, 4, 2, 35, 0, 0),
(1937, 0, 0, 0, 0, 0, 'Sunset Homes, Flat 22', 2, 10, 11000, 520, 3, 1, 25, 0, 0),
(1938, 0, 0, 0, 0, 0, 'Sunset Homes, Flat 21', 2, 10, 11000, 520, 3, 1, 25, 0, 0),
(1939, 0, 0, 0, 0, 0, 'Harbour Place 1 (Shop)', 2, 16, 16000, 1100, 3, 0, 48, 0, 0),
(1940, 0, 0, 0, 0, 0, 'Harbour Place 2 (Shop)', 2, 19, 20000, 1300, 3, 1, 48, 0, 0),
(1941, 0, 0, 0, 0, 0, 'Warriors Guildhall', 2, 255, 266000, 14725, 33, 11, 522, 0, 0),
(1942, 0, 0, 0, 0, 0, 'Farm Lane, 1st floor (Shop)', 2, 15, 15000, 945, 3, 0, 42, 0, 0),
(1943, 0, 0, 0, 0, 0, 'Farm Lane, Basement (Shop)', 2, 15, 15000, 945, 2, 0, 36, 0, 0),
(1944, 0, 0, 0, 0, 0, 'Main Street 9, 1st floor (Shop)', 2, 24, 24000, 1440, 3, 0, 47, 0, 0),
(1945, 0, 0, 0, 0, 0, 'Main Street 9a, 2nd floor (Shop)', 2, 12, 12000, 765, 3, 0, 30, 0, 0),
(1946, 0, 0, 0, 0, 0, 'Main Street 9b, 2nd floor (Shop)', 2, 23, 23000, 1260, 5, 0, 48, 0, 0),
(1947, 0, 0, 0, 0, 0, 'Farm Lane, 2nd Floor (Shop)', 2, 15, 15000, 945, 2, 0, 42, 0, 0),
(1948, 0, 0, 0, 0, 0, 'The City Wall 5a', 2, 10, 11000, 585, 5, 1, 24, 0, 0),
(1949, 0, 0, 0, 0, 0, 'The City Wall 5c', 2, 10, 11000, 585, 3, 1, 24, 0, 0),
(1950, 0, 0, 0, 0, 0, 'The City Wall 5e', 2, 10, 11000, 585, 5, 1, 30, 0, 0),
(1951, 0, 0, 0, 0, 0, 'The City Wall 5b', 2, 10, 11000, 585, 5, 1, 24, 0, 0),
(1952, 0, 0, 0, 0, 0, 'The City Wall 5d', 2, 10, 11000, 585, 3, 1, 24, 0, 0),
(1953, 0, 0, 0, 0, 0, 'The City Wall 5f', 2, 10, 11000, 585, 5, 1, 30, 0, 0),
(1954, 0, 0, 0, 0, 0, 'The City Wall 3a', 2, 16, 18000, 1045, 3, 2, 42, 0, 0),
(1955, 0, 0, 0, 0, 0, 'The City Wall 3b', 2, 16, 18000, 1045, 3, 2, 35, 0, 0),
(1956, 0, 0, 0, 0, 0, 'The City Wall 3c', 2, 16, 18000, 1045, 3, 2, 35, 0, 0),
(1957, 0, 0, 0, 0, 0, 'The City Wall 3d', 2, 16, 18000, 1045, 3, 2, 42, 0, 0),
(1958, 0, 0, 0, 0, 0, 'The City Wall 3e', 2, 16, 18000, 1045, 3, 2, 35, 0, 0),
(1959, 0, 0, 0, 0, 0, 'The City Wall 3f', 2, 16, 18000, 1045, 3, 2, 35, 0, 0),
(1960, 0, 0, 0, 0, 0, 'The City Wall 1a', 2, 21, 23000, 1270, 7, 2, 49, 0, 0),
(1961, 0, 0, 0, 0, 0, 'Mill Avenue 3', 2, 21, 23000, 1400, 7, 2, 49, 0, 0),
(1962, 0, 0, 0, 0, 0, 'The City Wall 1b', 2, 21, 23000, 1270, 6, 2, 49, 0, 0),
(1963, 0, 0, 0, 0, 0, 'Mill Avenue 4', 2, 21, 23000, 1400, 8, 2, 49, 0, 0),
(1964, 0, 0, 0, 0, 0, 'Mill Avenue 5', 2, 49, 53000, 3250, 14, 4, 128, 0, 0),
(1965, 0, 0, 0, 0, 0, 'Mill Avenue 1 (Shop)', 2, 17, 18000, 1300, 8, 1, 54, 0, 0),
(1966, 0, 0, 0, 0, 0, 'Mill Avenue 2 (Shop)', 2, 38, 40000, 2350, 8, 2, 80, 0, 0),
(1967, 0, 0, 0, 0, 0, 'The City Wall 7c', 2, 12, 14000, 865, 6, 2, 36, 0, 0),
(1968, 0, 0, 0, 0, 0, 'The City Wall 7a', 2, 10, 11000, 585, 6, 1, 30, 0, 0),
(1969, 0, 0, 0, 0, 0, 'The City Wall 7e', 2, 12, 14000, 865, 6, 2, 36, 0, 0),
(1970, 0, 0, 0, 0, 0, 'The City Wall 7g', 2, 10, 11000, 585, 6, 1, 30, 0, 0),
(1971, 0, 0, 0, 0, 0, 'The City Wall 7d', 2, 12, 14000, 865, 6, 2, 36, 0, 0),
(1972, 0, 0, 0, 0, 0, 'The City Wall 7b', 2, 10, 11000, 585, 6, 1, 30, 0, 0),
(1973, 0, 0, 0, 0, 0, 'The City Wall 7f', 2, 12, 14000, 865, 6, 2, 35, 0, 0),
(1974, 0, 0, 0, 0, 0, 'The City Wall 7h', 2, 10, 11000, 585, 6, 1, 30, 0, 0),
(1975, 0, 0, 0, 0, 0, 'The City Wall 9', 2, 14, 16000, 955, 7, 2, 50, 0, 0),
(1976, 0, 0, 0, 0, 0, 'Upper Swamp Lane 12', 2, 46, 49000, 3800, 16, 3, 116, 0, 0),
(1977, 0, 0, 0, 0, 0, 'Upper Swamp Lane 10', 2, 25, 28000, 2060, 10, 3, 70, 0, 0),
(1978, 0, 0, 0, 0, 0, 'Upper Swamp Lane 8', 2, 124, 127000, 8120, 17, 3, 216, 0, 0),
(1979, 0, 0, 0, 0, 0, 'Southern Thais Guildhall', 2, 284, 300000, 22440, 38, 16, 596, 0, 0),
(1980, 0, 0, 0, 0, 0, 'Alai Flats, Flat 04', 2, 14, 15000, 765, 3, 1, 30, 0, 0),
(1981, 0, 0, 0, 0, 0, 'Alai Flats, Flat 05', 2, 20, 22000, 1225, 4, 2, 38, 0, 0),
(1982, 0, 0, 0, 0, 0, 'Alai Flats, Flat 06', 2, 20, 22000, 1225, 1, 2, 48, 0, 0),
(1983, 0, 0, 0, 0, 0, 'Alai Flats, Flat 07', 2, 14, 15000, 765, 2, 1, 30, 0, 0),
(1984, 0, 0, 0, 0, 0, 'Alai Flats, Flat 08', 2, 14, 15000, 765, 2, 1, 30, 0, 0),
(1985, 0, 0, 0, 0, 0, 'Alai Flats, Flat 03', 2, 14, 15000, 765, 2, 1, 35, 0, 0),
(1986, 0, 0, 0, 0, 0, 'Alai Flats, Flat 01', 2, 15, 16000, 765, 1, 1, 25, 0, 0),
(1987, 0, 0, 0, 0, 0, 'Alai Flats, Flat 02', 2, 14, 15000, 765, 2, 1, 36, 0, 0),
(1988, 0, 0, 0, 0, 0, 'Alai Flats, Flat 14', 2, 16, 17000, 900, 4, 1, 33, 0, 0),
(1989, 0, 0, 0, 0, 0, 'Alai Flats, Flat 15', 2, 24, 26000, 1450, 6, 2, 48, 0, 0),
(1990, 0, 0, 0, 0, 0, 'Alai Flats, Flat 16', 2, 24, 26000, 1450, 3, 2, 54, 0, 0),
(1991, 0, 0, 0, 0, 0, 'Alai Flats, Flat 17', 2, 18, 19000, 900, 4, 1, 38, 0, 0),
(1992, 0, 0, 0, 0, 0, 'Alai Flats, Flat 18', 2, 16, 17000, 900, 4, 1, 38, 0, 0),
(1993, 0, 0, 0, 0, 0, 'Alai Flats, Flat 13', 2, 14, 15000, 765, 3, 1, 36, 0, 0),
(1994, 0, 0, 0, 0, 0, 'Alai Flats, Flat 12', 2, 14, 15000, 765, 1, 1, 25, 0, 0),
(1995, 0, 0, 0, 0, 0, 'Alai Flats, Flat 11', 2, 14, 15000, 765, 3, 1, 35, 0, 0),
(1996, 0, 0, 0, 0, 0, 'Alai Flats, Flat 24', 2, 16, 17000, 900, 4, 1, 36, 0, 0),
(1997, 0, 0, 0, 0, 0, 'Alai Flats, Flat 25', 2, 24, 26000, 1450, 6, 2, 52, 0, 0),
(1998, 0, 0, 0, 0, 0, 'Alai Flats, Flat 26', 2, 24, 26000, 1450, 3, 2, 60, 0, 0),
(1999, 0, 0, 0, 0, 0, 'Alai Flats, Flat 27', 2, 16, 17000, 900, 4, 1, 38, 0, 0),
(2000, 0, 0, 0, 0, 0, 'Alai Flats, Flat 28', 2, 16, 17000, 900, 4, 1, 38, 0, 0),
(2001, 0, 0, 0, 0, 0, 'Alai Flats, Flat 23', 2, 14, 15000, 765, 3, 1, 35, 0, 0),
(2002, 0, 0, 0, 0, 0, 'Alai Flats, Flat 22', 2, 14, 15000, 765, 1, 1, 25, 0, 0),
(2003, 0, 0, 0, 0, 0, 'Alai Flats, Flat 21', 2, 14, 15000, 765, 3, 1, 36, 0, 0),
(2004, 0, 0, 0, 0, 0, 'Upper Swamp Lane 4', 2, 59, 63000, 4740, 13, 4, 165, 0, 0),
(2005, 0, 0, 0, 0, 0, 'Upper Swamp Lane 2', 2, 60, 64000, 4740, 13, 4, 159, 0, 0),
(2006, 0, 0, 0, 0, 0, 'Sorcerer''s Avenue Labs 2c', 2, 10, 11000, 715, 1, 1, 20, 0, 0),
(2007, 0, 0, 0, 0, 0, 'Sorcerer''s Avenue Labs 2d', 2, 10, 11000, 715, 1, 1, 20, 0, 0),
(2008, 0, 0, 0, 0, 0, 'Sorcerer''s Avenue Labs 2e', 2, 10, 11000, 715, 1, 1, 20, 0, 0),
(2009, 0, 0, 0, 0, 0, 'Sorcerer''s Avenue Labs 2f', 2, 10, 11000, 715, 1, 1, 20, 0, 0),
(2010, 0, 0, 0, 0, 0, 'Sorcerer''s Avenue Labs 2b', 2, 10, 11000, 715, 1, 1, 24, 0, 0),
(2011, 0, 0, 0, 0, 0, 'Sorcerer''s Avenue Labs 2a', 2, 10, 11000, 715, 1, 1, 24, 0, 0),
(2012, 0, 0, 0, 0, 0, 'Ivory Circle 1', 7, 71, 73000, 4280, 5, 2, 160, 0, 0),
(2013, 0, 0, 0, 0, 0, 'Admiral''s Avenue 3', 7, 68, 70000, 4115, 3, 2, 142, 0, 0),
(2014, 0, 0, 0, 0, 0, 'Admiral''s Avenue 2', 7, 85, 89000, 5470, 5, 4, 176, 0, 0),
(2015, 0, 0, 0, 0, 0, 'Admiral''s Avenue 1', 7, 83, 85000, 5105, 5, 2, 168, 0, 0),
(2016, 0, 0, 0, 0, 0, 'Sugar Street 5', 7, 20, 22000, 1350, 1, 2, 48, 0, 0),
(2017, 0, 0, 0, 0, 0, 'Freedom Street 1', 7, 41, 43000, 2450, 2, 2, 84, 0, 0),
(2018, 0, 0, 0, 0, 0, 'Freedom Street 2', 7, 103, 107000, 6050, 12, 4, 208, 0, 0),
(2019, 0, 0, 0, 0, 0, 'Trader''s Point 2 (Shop)', 7, 93, 95000, 5350, 11, 2, 198, 0, 0),
(2020, 0, 0, 0, 0, 0, 'Trader''s Point 3 (Shop)', 7, 106, 108000, 5950, 10, 2, 195, 0, 0),
(2021, 0, 0, 0, 0, 0, 'Ivory Circle 2', 7, 120, 122000, 7030, 3, 2, 214, 0, 0),
(2022, 0, 0, 0, 0, 0, 'The Tavern 1a', 7, 40, 44000, 2750, 4, 4, 72, 0, 0),
(2023, 0, 0, 0, 0, 0, 'The Tavern 1b', 7, 31, 33000, 1900, 3, 2, 54, 0, 0),
(2024, 0, 0, 0, 0, 0, 'The Tavern 1c', 7, 73, 76000, 4150, 9, 3, 132, 0, 0);
INSERT INTO `houses` (`id`, `world_id`, `owner`, `paid`, `warnings`, `lastwarning`, `name`, `town`, `size`, `price`, `rent`, `doors`, `beds`, `tiles`, `guild`, `clear`) VALUES
(2025, 0, 0, 0, 0, 0, 'The Tavern 1d', 7, 24, 26000, 1550, 5, 2, 48, 0, 0),
(2026, 0, 0, 0, 0, 0, 'The Tavern 2d', 7, 20, 22000, 1350, 3, 2, 40, 0, 0),
(2027, 0, 0, 0, 0, 0, 'The Tavern 2c', 7, 16, 17000, 950, 2, 1, 32, 0, 0),
(2028, 0, 0, 0, 0, 0, 'The Tavern 2b', 7, 27, 29000, 1700, 6, 2, 62, 0, 0),
(2029, 0, 0, 0, 0, 0, 'The Tavern 2a', 7, 92, 97000, 5550, 11, 5, 163, 0, 0),
(2030, 0, 0, 0, 0, 0, 'Straycat''s Corner 4', 7, 4, 5000, 210, 3, 1, 20, 0, 0),
(2031, 0, 0, 0, 0, 0, 'Straycat''s Corner 3', 7, 4, 5000, 210, 2, 1, 20, 0, 0),
(2032, 0, 0, 0, 0, 0, 'Straycat''s Corner 2', 7, 18, 19000, 660, 6, 1, 49, 0, 0),
(2033, 0, 0, 0, 0, 0, 'Litter Promenade 5', 7, 11, 13000, 580, 4, 2, 35, 0, 0),
(2034, 0, 0, 0, 0, 0, 'Litter Promenade 4', 7, 10, 11000, 390, 3, 1, 30, 0, 0),
(2035, 0, 0, 0, 0, 0, 'Litter Promenade 3', 7, 12, 13000, 450, 3, 1, 36, 0, 0),
(2036, 0, 0, 0, 0, 0, 'Litter Promenade 2', 7, 7, 8000, 300, 3, 1, 25, 0, 0),
(2037, 0, 0, 0, 0, 0, 'Litter Promenade 1', 7, 6, 8000, 400, 2, 2, 25, 0, 0),
(2038, 0, 0, 0, 0, 0, 'The Shelter', 7, 282, 313000, 13590, 28, 31, 560, 0, 0),
(2039, 0, 0, 0, 0, 0, 'Straycat''s Corner 6', 7, 7, 8000, 300, 3, 1, 25, 0, 0),
(2040, 0, 0, 0, 0, 0, 'Straycat''s Corner 5', 7, 16, 18000, 760, 3, 2, 48, 0, 0),
(2042, 0, 0, 0, 0, 0, 'Rum Alley 3', 7, 9, 10000, 330, 2, 1, 28, 0, 0),
(2043, 0, 0, 0, 0, 0, 'Straycat''s Corner 1', 7, 7, 8000, 300, 3, 1, 25, 0, 0),
(2044, 0, 0, 0, 0, 0, 'Rum Alley 2', 7, 7, 8000, 300, 4, 1, 25, 0, 0),
(2045, 0, 0, 0, 0, 0, 'Rum Alley 1', 7, 14, 15000, 510, 3, 1, 36, 0, 0),
(2046, 0, 0, 0, 0, 0, 'Smuggler Backyard 3', 7, 15, 17000, 700, 6, 2, 40, 0, 0),
(2048, 0, 0, 0, 0, 0, 'Shady Trail 3', 7, 7, 8000, 300, 3, 1, 25, 0, 0),
(2049, 0, 0, 0, 0, 0, 'Shady Trail 1', 7, 14, 19000, 1150, 5, 5, 48, 0, 0),
(2050, 0, 0, 0, 0, 0, 'Shady Trail 2', 7, 8, 10000, 490, 5, 2, 30, 0, 0),
(2051, 0, 0, 0, 0, 0, 'Smuggler Backyard 5', 7, 11, 13000, 610, 4, 2, 35, 0, 0),
(2052, 0, 0, 0, 0, 0, 'Smuggler Backyard 4', 7, 10, 11000, 390, 3, 1, 30, 0, 0),
(2053, 0, 0, 0, 0, 0, 'Smuggler Backyard 2', 7, 15, 17000, 670, 3, 2, 40, 0, 0),
(2054, 0, 0, 0, 0, 0, 'Smuggler Backyard 1', 7, 14, 16000, 670, 5, 2, 40, 0, 0),
(2055, 0, 0, 0, 0, 0, 'Sugar Street 2', 7, 39, 42000, 2550, 6, 3, 84, 0, 0),
(2056, 0, 0, 0, 0, 0, 'Sugar Street 1', 7, 50, 53000, 3000, 6, 3, 84, 0, 0),
(2057, 0, 0, 0, 0, 0, 'Sugar Street 3a', 7, 22, 25000, 1650, 5, 3, 54, 0, 0),
(2058, 0, 0, 0, 0, 0, 'Sugar Street 3b', 7, 30, 33000, 2050, 6, 3, 60, 0, 0),
(2059, 0, 0, 0, 0, 0, 'Harvester''s Haven, Flat 01', 7, 12, 14000, 950, 1, 2, 36, 0, 0),
(2060, 0, 0, 0, 0, 0, 'Harvester''s Haven, Flat 03', 7, 12, 14000, 950, 1, 2, 30, 0, 0),
(2061, 0, 0, 0, 0, 0, 'Harvester''s Haven, Flat 05', 7, 12, 14000, 950, 1, 2, 30, 0, 0),
(2062, 0, 0, 0, 0, 0, 'Harvester''s Haven, Flat 02', 7, 12, 14000, 950, 1, 2, 36, 0, 0),
(2063, 0, 0, 0, 0, 0, 'Harvester''s Haven, Flat 04', 7, 12, 14000, 950, 1, 2, 30, 0, 0),
(2064, 0, 0, 0, 0, 0, 'Harvester''s Haven, Flat 06', 7, 12, 14000, 950, 1, 2, 30, 0, 0),
(2065, 0, 0, 0, 0, 0, 'Harvester''s Haven, Flat 07', 7, 12, 14000, 950, 3, 2, 30, 0, 0),
(2066, 0, 0, 0, 0, 0, 'Harvester''s Haven, Flat 09', 7, 13, 15000, 950, 2, 2, 30, 0, 0),
(2067, 0, 0, 0, 0, 0, 'Harvester''s Haven, Flat 11', 7, 12, 14000, 950, 3, 2, 36, 0, 0),
(2068, 0, 0, 0, 0, 0, 'Harvester''s Haven, Flat 12', 7, 13, 15000, 950, 3, 2, 36, 0, 0),
(2069, 0, 0, 0, 0, 0, 'Harvester''s Haven, Flat 10', 7, 12, 14000, 950, 2, 2, 30, 0, 0),
(2070, 0, 0, 0, 0, 0, 'Harvester''s Haven, Flat 08', 7, 12, 14000, 950, 3, 2, 30, 0, 0),
(2071, 0, 0, 0, 0, 0, 'Marble Lane 4', 7, 102, 106000, 6350, 11, 4, 192, 0, 0),
(2072, 0, 0, 0, 0, 0, 'Marble Lane 2', 7, 106, 109000, 6415, 3, 3, 200, 0, 0),
(2073, 0, 0, 0, 0, 0, 'Marble Lane 3', 7, 133, 137000, 8055, 4, 4, 240, 0, 0),
(2074, 0, 0, 0, 0, 0, 'Marble Lane 1', 7, 178, 184000, 11060, 7, 6, 320, 0, 0),
(2075, 0, 0, 0, 0, 0, 'Ivy Cottage', 7, 469, 495000, 30650, 10, 26, 858, 0, 0),
(2076, 0, 0, 0, 0, 0, 'Sugar Street 4d', 7, 8, 10000, 750, 3, 2, 24, 0, 0),
(2077, 0, 0, 0, 0, 0, 'Sugar Street 4c', 7, 10, 11000, 650, 2, 1, 24, 0, 0),
(2078, 0, 0, 0, 0, 0, 'Sugar Street 4b', 7, 12, 14000, 950, 3, 2, 36, 0, 0),
(2079, 0, 0, 0, 0, 0, 'Sugar Street 4a', 7, 12, 14000, 950, 3, 2, 30, 0, 0),
(2080, 0, 0, 0, 0, 0, 'Trader''s Point 1', 7, 38, 40000, 2200, 2, 2, 77, 0, 0),
(2081, 0, 0, 0, 0, 0, 'Mountain Hideout', 7, 234, 251000, 15550, 14, 17, 486, 0, 0),
(2082, 0, 0, 0, 0, 0, 'Dark Mansion', 2, 294, 311000, 17845, 28, 17, 573, 0, 0),
(2083, 0, 0, 0, 0, 0, 'Halls of the Adventurers', 2, 243, 261000, 15380, 22, 18, 518, 0, 0),
(2084, 0, 0, 0, 0, 0, 'Castle of Greenshore', 2, 254, 266000, 18860, 18, 12, 600, 0, 0),
(2085, 0, 0, 0, 0, 0, 'Greenshore Clanhall', 2, 133, 143000, 10800, 23, 10, 312, 0, 0),
(2086, 0, 0, 0, 0, 0, 'Greenshore Village 1', 2, 30, 33000, 2420, 3, 3, 64, 0, 0),
(2087, 0, 0, 0, 0, 0, 'Greenshore Village, Shop', 2, 20, 21000, 1800, 6, 1, 56, 0, 0),
(2088, 0, 0, 0, 0, 0, 'Greenshore Village, Villa', 2, 117, 121000, 8700, 20, 4, 263, 0, 0),
(2089, 0, 0, 0, 0, 0, 'Greenshore Village 2', 2, 10, 11000, 780, 3, 1, 30, 0, 0),
(2090, 0, 0, 0, 0, 0, 'Greenshore Village 3', 2, 10, 11000, 780, 3, 1, 25, 0, 0),
(2091, 0, 0, 0, 0, 0, 'Greenshore Village 5', 2, 10, 11000, 780, 3, 1, 30, 0, 0),
(2092, 0, 0, 0, 0, 0, 'Greenshore Village 4', 2, 10, 11000, 780, 3, 1, 25, 0, 0),
(2093, 0, 0, 0, 0, 0, 'Greenshore Village 6', 2, 61, 63000, 4360, 9, 2, 118, 0, 0),
(2094, 0, 0, 0, 0, 0, 'Greenshore Village 7', 2, 18, 19000, 1260, 3, 1, 42, 0, 0),
(2095, 0, 0, 0, 0, 0, 'The Tibianic', 2, 445, 467000, 34500, 10, 22, 871, 0, 0),
(2097, 0, 0, 0, 0, 0, 'Fibula Village 5', 2, 21, 23000, 1790, 2, 2, 42, 0, 0),
(2098, 0, 0, 0, 0, 0, 'Fibula Village 4', 2, 21, 23000, 1790, 2, 2, 42, 0, 0),
(2099, 0, 0, 0, 0, 0, 'Fibula Village, Tower Flat', 2, 72, 74000, 5105, 5, 2, 161, 0, 0),
(2100, 0, 0, 0, 0, 0, 'Fibula Village 1', 2, 10, 11000, 845, 3, 1, 30, 0, 0),
(2101, 0, 0, 0, 0, 0, 'Fibula Village 2', 2, 10, 11000, 845, 3, 1, 30, 0, 0),
(2102, 0, 0, 0, 0, 0, 'Fibula Village 3', 2, 45, 49000, 3810, 6, 4, 110, 0, 0),
(2103, 0, 0, 0, 0, 0, 'Mercenary Tower', 2, 525, 551000, 41955, 26, 26, 996, 0, 0),
(2104, 0, 0, 0, 0, 0, 'Guildhall of the Red Rose', 2, 340, 355000, 27725, 14, 15, 572, 0, 0),
(2105, 0, 0, 0, 0, 0, 'Fibula Village, Bar', 2, 59, 61000, 5235, 7, 2, 122, 0, 0),
(2106, 0, 0, 0, 0, 0, 'Fibula Village, Villa', 2, 181, 186000, 11490, 33, 5, 402, 0, 0),
(2107, 0, 0, 0, 0, 0, 'Fibula Clanhall', 2, 128, 138000, 11430, 28, 10, 290, 0, 0),
(2108, 0, 0, 0, 0, 0, 'Spiritkeep', 2, 316, 339000, 19210, 19, 23, 783, 0, 0),
(2109, 0, 0, 0, 0, 0, 'Snake Tower', 2, 532, 553000, 29720, 38, 21, 1064, 0, 0),
(2110, 0, 0, 0, 0, 0, 'Bloodhall', 2, 245, 260000, 15270, 31, 15, 569, 0, 0),
(2125, 0, 0, 0, 0, 0, 'Rosebud C', 4, 30, 30000, 1340, 6, 0, 70, 0, 0),
(2127, 0, 0, 0, 0, 0, 'Rosebud A', 4, 22, 23000, 1000, 5, 1, 60, 0, 0),
(2128, 0, 0, 0, 0, 0, 'Rosebud B', 4, 22, 23000, 1000, 5, 1, 60, 0, 0),
(2129, 0, 0, 0, 0, 0, 'Nordic Stronghold', 4, 330, 351000, 18400, 28, 21, 751, 0, 0),
(2130, 0, 0, 0, 0, 0, 'Northport Village 2', 4, 20, 22000, 1475, 4, 2, 40, 0, 0),
(2131, 0, 0, 0, 0, 0, 'Northport Village 1', 4, 20, 22000, 1475, 4, 2, 48, 0, 0),
(2132, 0, 0, 0, 0, 0, 'Northport Village 3', 4, 96, 98000, 5435, 8, 2, 178, 0, 0),
(2133, 0, 0, 0, 0, 0, 'Northport Village 4', 4, 42, 44000, 2630, 4, 2, 81, 0, 0),
(2134, 0, 0, 0, 0, 0, 'Northport Village 5', 4, 26, 28000, 1805, 4, 2, 56, 0, 0),
(2135, 0, 0, 0, 0, 0, 'Northport Village 6', 4, 32, 34000, 2135, 6, 2, 64, 0, 0),
(2136, 0, 0, 0, 0, 0, 'Seawatch', 4, 364, 383000, 25010, 15, 19, 749, 0, 0),
(2137, 0, 0, 0, 0, 0, 'Northport Clanhall', 4, 130, 140000, 9810, 20, 10, 292, 0, 0),
(2138, 0, 0, 0, 0, 0, 'Druids Retreat D', 4, 22, 24000, 1180, 1, 2, 54, 0, 0),
(2139, 0, 0, 0, 0, 0, 'Druids Retreat A', 4, 26, 28000, 1340, 1, 2, 60, 0, 0),
(2140, 0, 0, 0, 0, 0, 'Druids Retreat C', 4, 17, 19000, 980, 1, 2, 45, 0, 0),
(2141, 0, 0, 0, 0, 0, 'Druids Retreat B', 4, 24, 26000, 980, 1, 2, 55, 0, 0),
(2142, 0, 0, 0, 0, 0, 'Theater Avenue 14 (Shop)', 4, 36, 37000, 2115, 3, 1, 83, 0, 0),
(2143, 0, 0, 0, 0, 0, 'Theater Avenue 12', 4, 14, 16000, 955, 2, 2, 28, 0, 0),
(2144, 0, 0, 0, 0, 0, 'Theater Avenue 10', 4, 17, 19000, 1090, 1, 2, 45, 0, 0),
(2145, 0, 0, 0, 0, 0, 'Theater Avenue 11c', 4, 10, 11000, 585, 2, 1, 24, 0, 0),
(2146, 0, 0, 0, 0, 0, 'Theater Avenue 11b', 4, 10, 11000, 585, 2, 1, 24, 0, 0),
(2147, 0, 0, 0, 0, 0, 'Theater Avenue 11a', 4, 24, 26000, 1405, 4, 2, 54, 0, 0),
(2148, 0, 0, 0, 0, 0, 'Magician''s Alley 1', 4, 14, 16000, 1050, 1, 2, 35, 0, 0),
(2149, 0, 0, 0, 0, 0, 'Magician''s Alley 1a', 4, 7, 9000, 700, 1, 2, 29, 0, 0),
(2150, 0, 0, 0, 0, 0, 'Magician''s Alley 1d', 4, 6, 7000, 450, 1, 1, 24, 0, 0),
(2151, 0, 0, 0, 0, 0, 'Magician''s Alley 1b', 4, 8, 10000, 750, 1, 2, 24, 0, 0),
(2152, 0, 0, 0, 0, 0, 'Magician''s Alley 1c', 4, 7, 8000, 500, 1, 1, 20, 0, 0),
(2153, 0, 0, 0, 0, 0, 'Magician''s Alley 5a', 4, 4, 5000, 350, 1, 1, 14, 0, 0),
(2154, 0, 0, 0, 0, 0, 'Magician''s Alley 5b', 4, 7, 8000, 500, 1, 1, 25, 0, 0),
(2155, 0, 0, 0, 0, 0, 'Magician''s Alley 5d', 4, 7, 8000, 500, 1, 1, 20, 0, 0),
(2156, 0, 0, 0, 0, 0, 'Magician''s Alley 5e', 4, 7, 8000, 500, 1, 1, 25, 0, 0),
(2157, 0, 0, 0, 0, 0, 'Magician''s Alley 5c', 4, 16, 18000, 1150, 1, 2, 35, 0, 0),
(2158, 0, 0, 0, 0, 0, 'Magician''s Alley 5f', 4, 16, 18000, 1150, 1, 2, 42, 0, 0),
(2159, 0, 0, 0, 0, 0, 'Carlin Clanhall', 4, 167, 177000, 10750, 3, 10, 364, 0, 0),
(2160, 0, 0, 0, 0, 0, 'Magician''s Alley 4', 4, 40, 44000, 2750, 1, 4, 96, 0, 0),
(2161, 0, 0, 0, 0, 0, 'Lonely Sea Side Hostel', 4, 218, 226000, 10540, 6, 8, 454, 0, 0),
(2162, 0, 0, 0, 0, 0, 'Suntower', 4, 204, 211000, 10080, 26, 7, 450, 0, 0),
(2163, 0, 0, 0, 0, 0, 'Harbour Lane 3', 4, 77, 80000, 3560, 1, 3, 145, 0, 0),
(2164, 0, 0, 0, 0, 0, 'Harbour Flats, Flat 11', 4, 10, 11000, 520, 2, 1, 24, 0, 0),
(2165, 0, 0, 0, 0, 0, 'Harbour Flats, Flat 13', 4, 10, 11000, 520, 1, 1, 24, 0, 0),
(2166, 0, 0, 0, 0, 0, 'Harbour Flats, Flat 15', 4, 6, 7000, 360, 1, 1, 18, 0, 0),
(2167, 0, 0, 0, 0, 0, 'Harbour Flats, Flat 17', 4, 6, 7000, 360, 1, 1, 24, 0, 0),
(2168, 0, 0, 0, 0, 0, 'Harbour Flats, Flat 12', 4, 7, 8000, 400, 1, 1, 20, 0, 0),
(2169, 0, 0, 0, 0, 0, 'Harbour Flats, Flat 14', 4, 7, 8000, 400, 1, 1, 20, 0, 0),
(2170, 0, 0, 0, 0, 0, 'Harbour Flats, Flat 16', 4, 7, 8000, 400, 1, 1, 20, 0, 0),
(2171, 0, 0, 0, 0, 0, 'Harbour Flats, Flat 18', 4, 7, 8000, 400, 1, 1, 25, 0, 0),
(2172, 0, 0, 0, 0, 0, 'Harbour Flats, Flat 21', 4, 14, 16000, 860, 1, 2, 35, 0, 0),
(2173, 0, 0, 0, 0, 0, 'Harbour Flats, Flat 22', 4, 17, 19000, 980, 1, 2, 45, 0, 0),
(2174, 0, 0, 0, 0, 0, 'Harbour Flats, Flat 23', 4, 7, 8000, 400, 1, 1, 25, 0, 0),
(2175, 0, 0, 0, 0, 0, 'Harbour Lane 2a (Shop)', 4, 12, 12000, 680, 2, 0, 32, 0, 0),
(2176, 0, 0, 0, 0, 0, 'Harbour Lane 2b (Shop)', 4, 12, 12000, 680, 2, 0, 40, 0, 0),
(2177, 0, 0, 0, 0, 0, 'Harbour Lane 1 (Shop)', 4, 19, 19000, 1040, 2, 0, 54, 0, 0),
(2178, 0, 0, 0, 0, 0, 'Theater Avenue 6e', 4, 11, 13000, 820, 3, 2, 31, 0, 0),
(2179, 0, 0, 0, 0, 0, 'Theater Avenue 6c', 4, 2, 3000, 225, 2, 1, 12, 0, 0),
(2180, 0, 0, 0, 0, 0, 'Theater Avenue 6a', 4, 11, 13000, 820, 3, 2, 35, 0, 0),
(2181, 0, 0, 0, 0, 0, 'Theater Avenue 6f', 4, 11, 13000, 820, 3, 2, 31, 0, 0),
(2182, 0, 0, 0, 0, 0, 'Theater Avenue 6d', 4, 2, 3000, 225, 2, 1, 12, 0, 0),
(2183, 0, 0, 0, 0, 0, 'Theater Avenue 6b', 4, 11, 13000, 820, 3, 2, 35, 0, 0),
(2184, 0, 0, 0, 0, 0, 'East Lane 1a', 4, 48, 50000, 2260, 1, 2, 95, 0, 0),
(2185, 0, 0, 0, 0, 0, 'East Lane 1b', 4, 34, 36000, 1700, 0, 2, 83, 0, 0),
(2186, 0, 0, 0, 0, 0, 'East Lane 2', 4, 87, 89000, 3900, 2, 2, 172, 0, 0),
(2191, 0, 0, 0, 0, 0, 'Northern Street 5', 4, 41, 43000, 1980, 1, 2, 94, 0, 0),
(2192, 0, 0, 0, 0, 0, 'Northern Street 7', 4, 34, 36000, 1700, 1, 2, 83, 0, 0),
(2193, 0, 0, 0, 0, 0, 'Northern Street 3a', 4, 11, 13000, 740, 1, 2, 31, 0, 0),
(2194, 0, 0, 0, 0, 0, 'Northern Street 3b', 4, 12, 14000, 780, 1, 2, 36, 0, 0),
(2195, 0, 0, 0, 0, 0, 'Northern Street 1c', 4, 11, 13000, 740, 1, 2, 31, 0, 0),
(2196, 0, 0, 0, 0, 0, 'Northern Street 1b', 4, 16, 18000, 740, 1, 2, 37, 0, 0),
(2197, 0, 0, 0, 0, 0, 'Northern Street 1a', 4, 16, 18000, 940, 1, 2, 41, 0, 0),
(2198, 0, 0, 0, 0, 0, 'Theater Avenue 7, Flat 06', 4, 4, 5000, 315, 2, 1, 20, 0, 0),
(2199, 0, 0, 0, 0, 0, 'Theater Avenue 7, Flat 01', 4, 4, 5000, 315, 2, 1, 15, 0, 0),
(2200, 0, 0, 0, 0, 0, 'Theater Avenue 7, Flat 05', 4, 6, 7000, 405, 2, 1, 20, 0, 0),
(2201, 0, 0, 0, 0, 0, 'Theater Avenue 7, Flat 02', 4, 6, 7000, 405, 2, 1, 20, 0, 0),
(2202, 0, 0, 0, 0, 0, 'Theater Avenue 7, Flat 04', 4, 8, 9000, 495, 2, 1, 20, 0, 0),
(2203, 0, 0, 0, 0, 0, 'Theater Avenue 7, Flat 03', 4, 6, 7000, 405, 2, 1, 19, 0, 0),
(2204, 0, 0, 0, 0, 0, 'Theater Avenue 7, Flat 14', 4, 8, 9000, 495, 1, 1, 20, 0, 0),
(2205, 0, 0, 0, 0, 0, 'Theater Avenue 7, Flat 13', 4, 6, 7000, 405, 1, 1, 17, 0, 0),
(2206, 0, 0, 0, 0, 0, 'Theater Avenue 7, Flat 15', 4, 6, 7000, 405, 1, 1, 19, 0, 0),
(2207, 0, 0, 0, 0, 0, 'Theater Avenue 7, Flat 16', 4, 6, 7000, 405, 1, 1, 20, 0, 0),
(2208, 0, 0, 0, 0, 0, 'Theater Avenue 7, Flat 11', 4, 8, 9000, 495, 1, 1, 23, 0, 0),
(2209, 0, 0, 0, 0, 0, 'Theater Avenue 7, Flat 12', 4, 6, 7000, 405, 1, 1, 15, 0, 0),
(2210, 0, 0, 0, 0, 0, 'Theater Avenue 8a', 4, 21, 23000, 1270, 1, 2, 50, 0, 0),
(2211, 0, 0, 0, 0, 0, 'Theater Avenue 8b', 4, 19, 22000, 1370, 2, 3, 49, 0, 0),
(2212, 0, 0, 0, 0, 0, 'Central Plaza 3', 4, 8, 8000, 600, 1, 0, 20, 0, 0),
(2213, 0, 0, 0, 0, 0, 'Central Plaza 2', 4, 8, 8000, 600, 1, 0, 20, 0, 0),
(2214, 0, 0, 0, 0, 0, 'Central Plaza 1', 4, 8, 8000, 600, 1, 0, 20, 0, 0),
(2215, 0, 0, 0, 0, 0, 'Park Lane 1a', 4, 21, 23000, 1220, 1, 2, 53, 0, 0),
(2216, 0, 0, 0, 0, 0, 'Park Lane 3a', 4, 21, 23000, 1220, 3, 2, 48, 0, 0),
(2217, 0, 0, 0, 0, 0, 'Park Lane 1b', 4, 27, 29000, 1380, 2, 2, 64, 0, 0),
(2218, 0, 0, 0, 0, 0, 'Park Lane 3b', 4, 20, 22000, 1100, 1, 2, 48, 0, 0),
(2219, 0, 0, 0, 0, 0, 'Park Lane 4', 4, 16, 18000, 980, 1, 2, 42, 0, 0),
(2220, 0, 0, 0, 0, 0, 'Park Lane 2', 4, 16, 18000, 980, 1, 2, 42, 0, 0),
(2221, 0, 0, 0, 0, 0, 'Magician''s Alley 8', 4, 21, 23000, 1400, 1, 2, 42, 0, 0),
(2222, 0, 0, 0, 0, 0, 'Moonkeep', 4, 240, 256000, 13020, 20, 16, 522, 0, 0),
(2225, 0, 0, 0, 0, 0, 'Castle, Basement, Flat 01', 11, 10, 11000, 585, 1, 1, 30, 0, 0),
(2226, 0, 0, 0, 0, 0, 'Castle, Basement, Flat 02', 11, 10, 11000, 585, 1, 1, 20, 0, 0),
(2227, 0, 0, 0, 0, 0, 'Castle, Basement, Flat 03', 11, 10, 11000, 585, 1, 1, 20, 0, 0),
(2228, 0, 0, 0, 0, 0, 'Castle, Basement, Flat 04', 11, 10, 11000, 585, 1, 1, 20, 0, 0),
(2229, 0, 0, 0, 0, 0, 'Castle, Basement, Flat 07', 11, 10, 11000, 585, 1, 1, 20, 0, 0),
(2230, 0, 0, 0, 0, 0, 'Castle, Basement, Flat 08', 11, 10, 11000, 585, 1, 1, 20, 0, 0),
(2231, 0, 0, 0, 0, 0, 'Castle, Basement, Flat 09', 11, 10, 11000, 585, 1, 1, 24, 0, 0),
(2232, 0, 0, 0, 0, 0, 'Castle, Basement, Flat 06', 11, 10, 11000, 585, 1, 1, 24, 0, 0),
(2233, 0, 0, 0, 0, 0, 'Castle, Basement, Flat 05', 11, 10, 11000, 585, 1, 1, 24, 0, 0),
(2234, 0, 0, 0, 0, 0, 'Castle Shop 1', 11, 31, 32000, 1890, 4, 1, 67, 0, 0),
(2235, 0, 0, 0, 0, 0, 'Castle Shop 2', 11, 31, 32000, 1890, 4, 1, 70, 0, 0),
(2236, 0, 0, 0, 0, 0, 'Castle Shop 3', 11, 31, 32000, 1890, 4, 1, 67, 0, 0),
(2237, 0, 0, 0, 0, 0, 'Castle, 4th Floor, Flat 09', 11, 13, 14000, 720, 2, 1, 28, 0, 0),
(2238, 0, 0, 0, 0, 0, 'Castle, 4th Floor, Flat 08', 11, 18, 19000, 945, 2, 1, 42, 0, 0),
(2239, 0, 0, 0, 0, 0, 'Castle, 4th Floor, Flat 06', 11, 18, 19000, 945, 1, 1, 36, 0, 0),
(2240, 0, 0, 0, 0, 0, 'Castle, 4th Floor, Flat 07', 11, 13, 14000, 720, 2, 1, 30, 0, 0),
(2241, 0, 0, 0, 0, 0, 'Castle, 4th Floor, Flat 05', 11, 14, 15000, 765, 2, 1, 30, 0, 0),
(2242, 0, 0, 0, 0, 0, 'Castle, 4th Floor, Flat 04', 11, 10, 11000, 585, 2, 1, 25, 0, 0),
(2243, 0, 0, 0, 0, 0, 'Castle, 4th Floor, Flat 03', 11, 10, 11000, 585, 2, 1, 30, 0, 0),
(2244, 0, 0, 0, 0, 0, 'Castle, 4th Floor, Flat 02', 11, 14, 15000, 765, 2, 1, 30, 0, 0),
(2245, 0, 0, 0, 0, 0, 'Castle, 4th Floor, Flat 01', 11, 10, 11000, 585, 2, 1, 30, 0, 0),
(2246, 0, 0, 0, 0, 0, 'Castle, 3rd Floor, Flat 01', 11, 10, 11000, 585, 3, 1, 30, 0, 0),
(2247, 0, 0, 0, 0, 0, 'Castle, 3rd Floor, Flat 02', 11, 14, 15000, 765, 2, 1, 30, 0, 0),
(2248, 0, 0, 0, 0, 0, 'Castle, 3rd Floor, Flat 03', 11, 10, 11000, 585, 1, 1, 25, 0, 0),
(2249, 0, 0, 0, 0, 0, 'Castle, 3rd Floor, Flat 05', 11, 14, 15000, 765, 2, 1, 30, 0, 0),
(2250, 0, 0, 0, 0, 0, 'Castle, 3rd Floor, Flat 04', 11, 10, 11000, 585, 1, 1, 25, 0, 0),
(2251, 0, 0, 0, 0, 0, 'Castle, 3rd Floor, Flat 06', 11, 16, 18000, 1045, 2, 2, 36, 0, 0),
(2252, 0, 0, 0, 0, 0, 'Castle, 3rd Floor, Flat 07', 11, 13, 14000, 720, 2, 1, 30, 0, 0),
(2253, 0, 0, 0, 0, 0, 'Castle Street 1', 11, 53, 56000, 2900, 12, 3, 112, 0, 0),
(2254, 0, 0, 0, 0, 0, 'Castle Street 2', 11, 26, 28000, 1495, 5, 2, 56, 0, 0),
(2255, 0, 0, 0, 0, 0, 'Castle Street 3', 11, 32, 34000, 1765, 5, 2, 56, 0, 0),
(2256, 0, 0, 0, 0, 0, 'Castle Street 4', 11, 32, 34000, 1765, 4, 2, 64, 0, 0),
(2257, 0, 0, 0, 0, 0, 'Castle Street 5', 11, 32, 34000, 1765, 4, 2, 61, 0, 0),
(2258, 0, 0, 0, 0, 0, 'Edron Flats, Basement Flat 2', 11, 31, 33000, 1540, 1, 2, 48, 0, 0),
(2259, 0, 0, 0, 0, 0, 'Edron Flats, Basement Flat 1', 11, 31, 33000, 1540, 1, 2, 48, 0, 0),
(2260, 0, 0, 0, 0, 0, 'Edron Flats, Flat 01', 11, 7, 8000, 400, 1, 1, 20, 0, 0),
(2261, 0, 0, 0, 0, 0, 'Edron Flats, Flat 02', 11, 14, 16000, 860, 1, 2, 28, 0, 0),
(2262, 0, 0, 0, 0, 0, 'Edron Flats, Flat 03', 11, 7, 8000, 400, 2, 1, 20, 0, 0),
(2263, 0, 0, 0, 0, 0, 'Edron Flats, Flat 04', 11, 7, 8000, 400, 1, 1, 20, 0, 0),
(2264, 0, 0, 0, 0, 0, 'Edron Flats, Flat 06', 11, 7, 8000, 400, 2, 1, 20, 0, 0),
(2265, 0, 0, 0, 0, 0, 'Edron Flats, Flat 05', 11, 7, 8000, 400, 1, 1, 20, 0, 0),
(2266, 0, 0, 0, 0, 0, 'Edron Flats, Flat 07', 11, 7, 8000, 400, 2, 1, 20, 0, 0),
(2267, 0, 0, 0, 0, 0, 'Edron Flats, Flat 08', 11, 7, 8000, 400, 1, 1, 20, 0, 0),
(2268, 0, 0, 0, 0, 0, 'Edron Flats, Flat 11', 11, 7, 8000, 400, 2, 1, 25, 0, 0),
(2269, 0, 0, 0, 0, 0, 'Edron Flats, Flat 12', 11, 7, 8000, 400, 3, 1, 25, 0, 0),
(2270, 0, 0, 0, 0, 0, 'Edron Flats, Flat 14', 11, 7, 8000, 400, 1, 1, 25, 0, 0),
(2271, 0, 0, 0, 0, 0, 'Edron Flats, Flat 13', 11, 7, 8000, 400, 2, 1, 25, 0, 0),
(2272, 0, 0, 0, 0, 0, 'Edron Flats, Flat 16', 11, 7, 8000, 400, 2, 1, 20, 0, 0),
(2273, 0, 0, 0, 0, 0, 'Edron Flats, Flat 15', 11, 7, 8000, 400, 1, 1, 20, 0, 0),
(2274, 0, 0, 0, 0, 0, 'Edron Flats, Flat 18', 11, 7, 8000, 400, 1, 1, 20, 0, 0),
(2275, 0, 0, 0, 0, 0, 'Edron Flats, Flat 17', 11, 7, 8000, 400, 2, 1, 20, 0, 0),
(2276, 0, 0, 0, 0, 0, 'Edron Flats, Flat 22', 11, 7, 8000, 400, 3, 1, 25, 0, 0),
(2277, 0, 0, 0, 0, 0, 'Edron Flats, Flat 21', 11, 14, 16000, 860, 2, 2, 40, 0, 0),
(2278, 0, 0, 0, 0, 0, 'Edron Flats, Flat 24', 11, 7, 8000, 400, 1, 1, 20, 0, 0),
(2279, 0, 0, 0, 0, 0, 'Edron Flats, Flat 23', 11, 7, 8000, 400, 2, 1, 25, 0, 0),
(2280, 0, 0, 0, 0, 0, 'Edron Flats, Flat 26', 11, 7, 8000, 400, 2, 1, 20, 0, 0),
(2281, 0, 0, 0, 0, 0, 'Edron Flats, Flat 27', 11, 7, 8000, 400, 2, 1, 20, 0, 0),
(2282, 0, 0, 0, 0, 0, 'Edron Flats, Flat 28', 11, 7, 8000, 400, 1, 1, 20, 0, 0),
(2283, 0, 0, 0, 0, 0, 'Edron Flats, Flat 25', 11, 7, 8000, 400, 1, 1, 20, 0, 0),
(2284, 0, 0, 0, 0, 0, 'Central Circle 1', 11, 66, 68000, 3020, 6, 2, 119, 0, 0),
(2285, 0, 0, 0, 0, 0, 'Central Circle 2', 11, 73, 75000, 3300, 6, 2, 108, 0, 0),
(2286, 0, 0, 0, 0, 0, 'Central Circle 3', 11, 79, 84000, 4160, 10, 5, 147, 0, 0),
(2287, 0, 0, 0, 0, 0, 'Central Circle 4', 11, 79, 84000, 4160, 8, 5, 147, 0, 0),
(2288, 0, 0, 0, 0, 0, 'Central Circle 5', 11, 79, 84000, 4160, 10, 5, 161, 0, 0),
(2289, 0, 0, 0, 0, 0, 'Central Circle 6 (Shop)', 11, 84, 86000, 3980, 10, 2, 182, 0, 0),
(2290, 0, 0, 0, 0, 0, 'Central Circle 7 (Shop)', 11, 84, 86000, 3980, 10, 2, 161, 0, 0),
(2291, 0, 0, 0, 0, 0, 'Central Circle 8 (Shop)', 11, 84, 86000, 3980, 10, 2, 166, 0, 0),
(2292, 0, 0, 0, 0, 0, 'Central Circle 9a', 11, 16, 18000, 940, 3, 2, 42, 0, 0),
(2293, 0, 0, 0, 0, 0, 'Central Circle 9b', 11, 18, 20000, 940, 3, 2, 44, 0, 0),
(2294, 0, 0, 0, 0, 0, 'Sky Lane, Guild 1', 11, 342, 365000, 21145, 28, 23, 666, 0, 0),
(2295, 0, 0, 0, 0, 0, 'Sky Lane, Guild 2', 11, 344, 358000, 19300, 31, 14, 650, 0, 0),
(2296, 0, 0, 0, 0, 0, 'Sky Lane, Guild 3', 11, 296, 314000, 17315, 32, 18, 564, 0, 0),
(2297, 0, 0, 0, 0, 0, 'Sky Lane, Sea Tower', 11, 80, 86000, 4775, 14, 6, 196, 0, 0),
(2298, 0, 0, 0, 0, 0, 'Wood Avenue 6a', 11, 23, 25000, 1450, 7, 2, 56, 0, 0),
(2299, 0, 0, 0, 0, 0, 'Wood Avenue 9a', 11, 26, 28000, 1540, 3, 2, 56, 0, 0),
(2300, 0, 0, 0, 0, 0, 'Wood Avenue 10a', 11, 26, 28000, 1540, 5, 2, 64, 0, 0),
(2301, 0, 0, 0, 0, 0, 'Wood Avenue 11', 11, 130, 136000, 7205, 18, 6, 253, 0, 0),
(2302, 0, 0, 0, 0, 0, 'Wood Avenue 8', 11, 117, 120000, 5960, 9, 3, 198, 0, 0),
(2303, 0, 0, 0, 0, 0, 'Wood Avenue 7', 11, 117, 120000, 5960, 10, 3, 191, 0, 0),
(2304, 0, 0, 0, 0, 0, 'Wood Avenue 6b', 11, 23, 25000, 1450, 8, 2, 56, 0, 0),
(2305, 0, 0, 0, 0, 0, 'Wood Avenue 9b', 11, 25, 27000, 1495, 4, 2, 56, 0, 0),
(2306, 0, 0, 0, 0, 0, 'Wood Avenue 10b', 11, 22, 25000, 1595, 7, 3, 64, 0, 0),
(2307, 0, 0, 0, 0, 0, 'Wood Avenue 5', 11, 32, 34000, 1765, 4, 2, 64, 0, 0),
(2308, 0, 0, 0, 0, 0, 'Wood Avenue 4a', 11, 26, 28000, 1495, 3, 2, 56, 0, 0),
(2309, 0, 0, 0, 0, 0, 'Wood Avenue 4b', 11, 26, 28000, 1495, 5, 2, 56, 0, 0),
(2310, 0, 0, 0, 0, 0, 'Wood Avenue 4c', 11, 32, 34000, 1765, 5, 2, 56, 0, 0),
(2311, 0, 0, 0, 0, 0, 'Wood Avenue 4', 11, 32, 34000, 1765, 4, 2, 64, 0, 0),
(2312, 0, 0, 0, 0, 0, 'Wood Avenue 3', 11, 32, 34000, 1765, 3, 2, 56, 0, 0),
(2313, 0, 0, 0, 0, 0, 'Wood Avenue 2', 11, 32, 34000, 1765, 2, 2, 49, 0, 0),
(2314, 0, 0, 0, 0, 0, 'Wood Avenue 1', 11, 32, 34000, 1765, 5, 2, 64, 0, 0),
(2315, 0, 0, 0, 0, 0, 'Magic Academy, Guild', 11, 155, 169000, 12025, 7, 14, 414, 0, 0),
(2316, 0, 0, 0, 0, 0, 'Magic Academy, Flat 1', 11, 16, 19000, 1465, 2, 3, 57, 0, 0),
(2317, 0, 0, 0, 0, 0, 'Magic Academy, Flat 2', 11, 21, 23000, 1530, 1, 2, 55, 0, 0),
(2318, 0, 0, 0, 0, 0, 'Magic Academy, Flat 3', 11, 24, 25000, 1430, 1, 1, 55, 0, 0),
(2319, 0, 0, 0, 0, 0, 'Magic Academy, Flat 4', 11, 21, 23000, 1530, 1, 2, 55, 0, 0),
(2320, 0, 0, 0, 0, 0, 'Magic Academy, Flat 5', 11, 23, 24000, 1430, 1, 1, 55, 0, 0),
(2321, 0, 0, 0, 0, 0, 'Magic Academy, Shop', 11, 18, 19000, 1595, 1, 1, 48, 0, 0),
(2322, 0, 0, 0, 0, 0, 'Stonehome Village 1', 11, 36, 38000, 1780, 5, 2, 74, 0, 0),
(2323, 0, 0, 0, 0, 0, 'Stonehome Flats, Flat 05', 11, 7, 8000, 400, 2, 1, 20, 0, 0),
(2324, 0, 0, 0, 0, 0, 'Stonehome Flats, Flat 04', 11, 7, 8000, 400, 2, 1, 25, 0, 0),
(2325, 0, 0, 0, 0, 0, 'Stonehome Flats, Flat 06', 11, 7, 8000, 400, 2, 1, 20, 0, 0),
(2326, 0, 0, 0, 0, 0, 'Stonehome Flats, Flat 03', 11, 7, 8000, 400, 2, 1, 20, 0, 0),
(2327, 0, 0, 0, 0, 0, 'Stonehome Flats, Flat 01', 11, 7, 8000, 400, 2, 1, 20, 0, 0),
(2328, 0, 0, 0, 0, 0, 'Stonehome Flats, Flat 02', 11, 11, 13000, 740, 3, 2, 30, 0, 0),
(2329, 0, 0, 0, 0, 0, 'Stonehome Flats, Flat 11', 11, 11, 13000, 740, 2, 2, 35, 0, 0),
(2330, 0, 0, 0, 0, 0, 'Stonehome Flats, Flat 12', 11, 11, 13000, 740, 3, 2, 35, 0, 0),
(2331, 0, 0, 0, 0, 0, 'Stonehome Flats, Flat 13', 11, 7, 8000, 400, 2, 1, 20, 0, 0),
(2332, 0, 0, 0, 0, 0, 'Stonehome Flats, Flat 14', 11, 7, 8000, 400, 2, 1, 20, 0, 0),
(2333, 0, 0, 0, 0, 0, 'Stonehome Flats, Flat 16', 11, 7, 8000, 400, 2, 1, 20, 0, 0),
(2334, 0, 0, 0, 0, 0, 'Stonehome Flats, Flat 15', 11, 7, 8000, 400, 2, 1, 20, 0, 0),
(2335, 0, 0, 0, 0, 0, 'Stonehome Village 2', 11, 13, 14000, 640, 4, 1, 35, 0, 0),
(2336, 0, 0, 0, 0, 0, 'Stonehome Village 3', 11, 14, 15000, 680, 4, 1, 36, 0, 0),
(2337, 0, 0, 0, 0, 0, 'Stonehome Village 4', 11, 16, 18000, 940, 3, 2, 42, 0, 0),
(2338, 0, 0, 0, 0, 0, 'Stonehome Village 6', 11, 25, 27000, 1300, 5, 2, 55, 0, 0),
(2339, 0, 0, 0, 0, 0, 'Stonehome Village 5', 11, 28, 30000, 1140, 4, 2, 56, 0, 0),
(2340, 0, 0, 0, 0, 0, 'Stonehome Village 7', 11, 21, 23000, 1140, 3, 2, 49, 0, 0),
(2341, 0, 0, 0, 0, 0, 'Stonehome Village 8', 11, 14, 15000, 680, 3, 1, 36, 0, 0),
(2342, 0, 0, 0, 0, 0, 'Stonehome Village 9', 11, 14, 15000, 680, 3, 1, 36, 0, 0),
(2343, 0, 0, 0, 0, 0, 'Stonehome Clanhall', 11, 157, 166000, 8580, 28, 9, 345, 0, 0),
(2344, 0, 0, 0, 0, 0, 'Cormaya 1', 11, 21, 23000, 1270, 5, 2, 49, 0, 0),
(2345, 0, 0, 0, 0, 0, 'Cormaya 2', 11, 70, 73000, 3710, 9, 3, 145, 0, 0),
(2346, 0, 0, 0, 0, 0, 'Cormaya Flats, Flat 01', 11, 7, 8000, 450, 2, 1, 20, 0, 0),
(2347, 0, 0, 0, 0, 0, 'Cormaya Flats, Flat 02', 11, 7, 8000, 450, 2, 1, 20, 0, 0),
(2348, 0, 0, 0, 0, 0, 'Cormaya Flats, Flat 03', 11, 11, 13000, 820, 2, 2, 30, 0, 0),
(2349, 0, 0, 0, 0, 0, 'Cormaya Flats, Flat 06', 11, 7, 8000, 450, 2, 1, 20, 0, 0),
(2350, 0, 0, 0, 0, 0, 'Cormaya Flats, Flat 05', 11, 7, 8000, 450, 2, 1, 20, 0, 0),
(2351, 0, 0, 0, 0, 0, 'Cormaya Flats, Flat 04', 11, 11, 13000, 820, 2, 2, 30, 0, 0),
(2352, 0, 0, 0, 0, 0, 'Cormaya Flats, Flat 13', 11, 11, 13000, 820, 2, 2, 30, 0, 0),
(2353, 0, 0, 0, 0, 0, 'Cormaya Flats, Flat 14', 11, 11, 13000, 820, 2, 2, 35, 0, 0),
(2354, 0, 0, 0, 0, 0, 'Cormaya Flats, Flat 15', 11, 7, 8000, 450, 2, 1, 20, 0, 0),
(2355, 0, 0, 0, 0, 0, 'Cormaya Flats, Flat 16', 11, 7, 8000, 450, 2, 1, 20, 0, 0),
(2356, 0, 0, 0, 0, 0, 'Cormaya Flats, Flat 11', 11, 7, 8000, 450, 2, 1, 20, 0, 0),
(2357, 0, 0, 0, 0, 0, 'Cormaya Flats, Flat 12', 11, 7, 8000, 450, 2, 1, 20, 0, 0),
(2358, 0, 0, 0, 0, 0, 'Cormaya 3', 11, 38, 40000, 2035, 5, 2, 72, 0, 0),
(2359, 0, 0, 0, 0, 0, 'Castle of the White Dragon', 11, 442, 461000, 25110, 24, 19, 882, 0, 0),
(2360, 0, 0, 0, 0, 0, 'Cormaya 4', 11, 31, 33000, 1720, 4, 2, 63, 0, 0),
(2361, 0, 0, 0, 0, 0, 'Cormaya 5', 11, 77, 80000, 4250, 10, 3, 167, 0, 0),
(2362, 0, 0, 0, 0, 0, 'Cormaya 6', 11, 46, 48000, 2395, 6, 2, 84, 0, 0),
(2363, 0, 0, 0, 0, 0, 'Cormaya 7', 11, 46, 48000, 2395, 4, 2, 84, 0, 0),
(2364, 0, 0, 0, 0, 0, 'Cormaya 8', 11, 53, 55000, 2710, 7, 2, 113, 0, 0),
(2365, 0, 0, 0, 0, 0, 'Cormaya 9b', 11, 50, 52000, 2620, 4, 2, 88, 0, 0),
(2366, 0, 0, 0, 0, 0, 'Cormaya 9a', 11, 20, 22000, 1225, 4, 2, 48, 0, 0),
(2367, 0, 0, 0, 0, 0, 'Cormaya 9c', 11, 20, 22000, 1225, 4, 2, 48, 0, 0),
(2368, 0, 0, 0, 0, 0, 'Cormaya 9d', 11, 50, 52000, 2620, 6, 2, 88, 0, 0),
(2369, 0, 0, 0, 0, 0, 'Cormaya 10', 11, 73, 76000, 3800, 7, 3, 140, 0, 0),
(2370, 0, 0, 0, 0, 0, 'Cormaya 11', 11, 38, 40000, 2035, 5, 2, 72, 0, 0),
(2371, 0, 0, 0, 0, 0, 'Demon Tower', 2, 50, 52000, 3340, 1, 2, 127, 0, 0),
(2372, 0, 0, 0, 0, 0, 'Nautic Observer', 4, 145, 149000, 6540, 4, 4, 300, 0, 0),
(2373, 0, 0, 0, 0, 0, 'Riverspring', 3, 284, 302000, 19450, 41, 18, 632, 0, 0),
(2374, 0, 0, 0, 0, 0, 'House of Recreation', 4, 337, 353000, 22540, 5, 16, 702, 0, 0),
(2375, 0, 0, 0, 0, 0, 'Valorous Venore', 1, 271, 280000, 14435, 46, 9, 507, 0, 0),
(2376, 0, 0, 0, 0, 0, 'Ab''Dendriel Clanhall', 5, 264, 274000, 14850, 24, 10, 498, 0, 0),
(2377, 0, 0, 0, 0, 0, 'Castle of the Winds', 5, 422, 440000, 23885, 30, 18, 842, 0, 0),
(2378, 0, 0, 0, 0, 0, 'The Hideout', 5, 321, 341000, 20800, 14, 20, 597, 0, 0),
(2379, 0, 0, 0, 0, 0, 'Shadow Towers', 5, 348, 366000, 21800, 28, 18, 750, 0, 0),
(2380, 0, 0, 0, 0, 0, 'Hill Hideout', 3, 193, 208000, 13950, 8, 15, 346, 0, 0),
(2381, 0, 0, 0, 0, 0, 'Meriana Beach', 7, 140, 143000, 8230, 3, 3, 184, 0, 0),
(2382, 0, 0, 0, 0, 0, 'Darashia 8, Flat 01', 10, 48, 50000, 2485, 1, 2, 80, 0, 0),
(2383, 0, 0, 0, 0, 0, 'Darashia 8, Flat 02', 10, 67, 69000, 3385, 2, 2, 114, 0, 0),
(2384, 0, 0, 0, 0, 0, 'Darashia 8, Flat 03', 10, 90, 93000, 4700, 5, 3, 171, 0, 0),
(2385, 0, 0, 0, 0, 0, 'Darashia 8, Flat 04', 10, 56, 58000, 2845, 1, 2, 90, 0, 0),
(2386, 0, 0, 0, 0, 0, 'Darashia 8, Flat 05', 10, 52, 54000, 2665, 1, 2, 85, 0, 0),
(2387, 0, 0, 0, 0, 0, 'Darashia, Eastern Guildhall', 10, 204, 220000, 12660, 15, 16, 444, 0, 0),
(2388, 0, 0, 0, 0, 0, 'Theater Avenue 5a', 4, 7, 8000, 450, 1, 1, 20, 0, 0),
(2389, 0, 0, 0, 0, 0, 'Theater Avenue 5b', 4, 7, 8000, 450, 1, 1, 19, 0, 0),
(2390, 0, 0, 0, 0, 0, 'Theater Avenue 5c', 4, 7, 8000, 450, 1, 1, 16, 0, 0),
(2391, 0, 0, 0, 0, 0, 'Theater Avenue 5d', 4, 7, 8000, 450, 1, 1, 16, 0, 0),
(2392, 0, 0, 0, 0, 0, 'Ashmura #1', 26, 97, 99000, 0, 4, 2, 170, 0, 0),
(2393, 0, 0, 0, 0, 0, 'Ashmura #2', 26, 129, 131000, 0, 5, 2, 195, 0, 0),
(2394, 0, 0, 0, 0, 0, 'Ashmura #3', 26, 115, 117000, 0, 4, 2, 198, 0, 0),
(2395, 0, 0, 0, 0, 0, 'Ashmura #4', 26, 123, 127000, 0, 5, 4, 227, 0, 0),
(2396, 0, 0, 0, 0, 0, 'Ashmura #5', 26, 36, 36000, 0, 1, 0, 59, 0, 0),
(2397, 0, 0, 0, 0, 0, 'Ashmura #6', 26, 72, 75000, 0, 5, 3, 130, 0, 0),
(2398, 0, 0, 0, 0, 0, 'Ashmura #7', 26, 40, 43000, 0, 5, 3, 82, 0, 0),
(2399, 0, 0, 0, 0, 0, 'Ashmura #8', 26, 42, 43000, 0, 5, 1, 84, 0, 0),
(2400, 0, 0, 0, 0, 0, 'Ashmura #9', 26, 87, 89000, 0, 2, 2, 137, 0, 0),
(2401, 0, 0, 0, 0, 0, 'Ashmura #10', 26, 179, 181000, 0, 4, 2, 300, 0, 0),
(2402, 0, 0, 0, 0, 0, 'Dathios #1', 28, 60, 60000, 0, 9, 0, 91, 0, 0),
(2403, 0, 0, 0, 0, 0, 'Dathios #2', 28, 14, 15000, 0, 5, 1, 25, 0, 0),
(2404, 0, 0, 0, 0, 0, 'Dathios #3', 28, 36, 38000, 0, 8, 2, 58, 0, 0),
(2406, 0, 0, 0, 0, 0, 'Dathios #5', 28, 32, 33000, 0, 5, 1, 51, 0, 0),
(2407, 0, 0, 0, 0, 0, 'Dathios #6', 28, 23, 24000, 0, 4, 1, 36, 0, 0),
(2408, 0, 0, 0, 0, 0, 'Dathios #7', 28, 31, 32000, 0, 4, 1, 65, 0, 0),
(2409, 0, 0, 0, 0, 0, 'Dathios #8', 28, 14, 15000, 0, 5, 1, 32, 0, 0),
(2410, 0, 0, 0, 0, 0, 'Dathios #9', 28, 12, 13000, 0, 2, 1, 37, 0, 0),
(2411, 0, 0, 0, 0, 0, 'Dathios #10', 28, 44, 45000, 0, 12, 1, 81, 0, 0),
(2412, 0, 0, 0, 0, 0, 'Dathios #11', 28, 41, 42000, 0, 7, 1, 80, 0, 0),
(2413, 0, 0, 0, 0, 0, 'Dathios #12', 28, 72, 74000, 0, 8, 2, 112, 0, 0),
(2414, 0, 0, 0, 0, 0, 'Dathios #13', 28, 7, 8000, 0, 1, 1, 21, 0, 0),
(2415, 0, 0, 0, 0, 0, 'Dathios #14', 28, 7, 8000, 0, 2, 1, 35, 0, 0),
(2416, 0, 0, 0, 0, 0, 'Dathios #15', 28, 15, 16000, 0, 4, 1, 26, 0, 0),
(2417, 0, 0, 0, 0, 0, 'Dathios #16', 28, 43, 44000, 0, 4, 1, 71, 0, 0),
(2418, 0, 0, 0, 0, 0, 'Dathios #17', 28, 34, 34000, 0, 7, 0, 62, 0, 0),
(2419, 0, 0, 0, 0, 0, 'Dathios #18', 28, 14, 15000, 0, 8, 1, 36, 0, 0),
(2420, 0, 0, 0, 0, 0, 'Dathios #19', 28, 7, 8000, 0, 2, 1, 13, 0, 0),
(2421, 0, 0, 0, 0, 0, 'Dathios #20', 28, 16, 17000, 0, 3, 1, 33, 0, 0),
(2422, 0, 0, 0, 0, 0, 'Dathios #21', 28, 7, 8000, 0, 3, 1, 25, 0, 0),
(2423, 0, 0, 0, 0, 0, 'Dathios #22', 28, 31, 32000, 0, 7, 1, 52, 0, 0),
(2424, 0, 0, 0, 0, 0, 'Dathios #23', 28, 22, 23000, 0, 6, 1, 43, 0, 0),
(2425, 0, 0, 0, 0, 0, 'Dathios #24', 28, 20, 21000, 0, 6, 1, 42, 0, 0),
(2426, 0, 0, 0, 0, 0, 'Materos #1', 27, 40, 41000, 0, 15, 1, 76, 0, 0),
(2427, 0, 0, 0, 0, 0, 'Materos #2', 27, 26, 28000, 0, 5, 2, 48, 0, 0),
(2428, 0, 0, 0, 0, 0, 'Materos #3', 27, 72, 73000, 0, 8, 1, 101, 0, 0),
(2429, 0, 0, 0, 0, 0, 'Materos #4', 27, 62, 63000, 0, 13, 1, 101, 0, 0),
(2430, 0, 0, 0, 0, 0, 'Materos #5', 27, 51, 53000, 0, 10, 2, 96, 0, 0),
(2431, 0, 0, 0, 0, 0, 'Materos #6', 27, 35, 36000, 0, 9, 1, 67, 0, 0),
(2432, 0, 0, 0, 0, 0, 'Materos #7', 27, 59, 60000, 0, 6, 1, 91, 0, 0),
(2433, 0, 0, 0, 0, 0, 'Materos #8', 27, 51, 54000, 0, 5, 3, 92, 0, 0),
(2434, 0, 0, 0, 0, 0, 'Materos #9', 27, 35, 37000, 0, 3, 2, 71, 0, 0),
(2435, 0, 0, 0, 0, 0, 'Materos #10', 27, 36, 37000, 0, 3, 1, 58, 0, 0),
(2436, 0, 0, 0, 0, 0, 'Materos #11', 27, 40, 40000, 0, 3, 0, 61, 0, 0),
(2437, 0, 0, 0, 0, 0, 'Materos #12', 27, 14, 15000, 0, 1, 1, 24, 0, 0),
(2438, 0, 0, 0, 0, 0, 'Materos #13', 27, 56, 58000, 0, 1, 2, 86, 0, 0),
(2439, 0, 0, 0, 0, 0, 'Materos #14', 27, 40, 40000, 0, 1, 0, 66, 0, 0),
(2440, 0, 0, 0, 0, 0, 'Materos #15', 27, 26, 28000, 0, 1, 2, 55, 0, 0),
(2441, 0, 0, 0, 0, 0, 'Materos #16', 27, 44, 47000, 0, 1, 3, 88, 0, 0),
(2442, 0, 0, 0, 0, 0, 'Materos #17', 27, 7, 8000, 0, 1, 1, 16, 0, 0),
(2443, 0, 0, 0, 0, 0, 'Materos #18', 27, 7, 8000, 0, 1, 1, 12, 0, 0),
(2444, 0, 0, 0, 0, 0, 'Materos #19', 27, 7, 8000, 0, 1, 1, 16, 0, 0),
(2445, 0, 0, 0, 0, 0, 'Materos #20', 27, 36, 38000, 0, 1, 2, 71, 0, 0),
(2446, 0, 0, 0, 0, 0, 'Materos #21', 27, 20, 22000, 0, 1, 2, 35, 0, 0),
(2447, 0, 0, 0, 0, 0, 'Materos #22', 27, 20, 22000, 0, 1, 2, 46, 0, 0),
(2448, 0, 0, 0, 0, 0, 'Shiva #1', 29, 31, 33000, 0, 2, 2, 58, 0, 0),
(2449, 0, 0, 0, 0, 0, 'Shiva #2', 29, 29, 31000, 0, 3, 2, 51, 0, 0),
(2450, 0, 0, 0, 0, 0, 'Shiva #3', 29, 34, 35000, 0, 3, 1, 53, 0, 0),
(2451, 0, 0, 0, 0, 0, 'Shiva #4', 29, 20, 21000, 0, 3, 1, 48, 0, 0),
(2452, 0, 0, 0, 0, 0, 'Shiva #5', 29, 33, 34000, 0, 3, 1, 61, 0, 0),
(2453, 0, 0, 0, 0, 0, 'Shiva #6', 29, 41, 43000, 0, 4, 2, 76, 0, 0),
(2454, 0, 0, 0, 0, 0, 'Shiva #7', 29, 45, 47000, 0, 3, 2, 91, 0, 0),
(2455, 0, 0, 0, 0, 0, 'Shiva #8', 29, 25, 26000, 0, 2, 1, 48, 0, 0),
(2456, 0, 0, 0, 0, 0, 'Shiva #9', 29, 53, 55000, 0, 4, 2, 94, 0, 0),
(2457, 0, 0, 0, 0, 0, 'Shiva #10', 29, 26, 28000, 0, 2, 2, 53, 0, 0),
(2458, 0, 0, 0, 0, 0, 'Shiva #11', 29, 25, 27000, 0, 4, 2, 45, 0, 0),
(2459, 0, 0, 0, 0, 0, 'Shiva #12', 29, 27, 28000, 0, 4, 1, 46, 0, 0),
(2460, 0, 0, 0, 0, 0, 'Shiva #13', 29, 20, 21000, 0, 3, 1, 37, 0, 0),
(2461, 0, 0, 0, 0, 0, 'Shiva #14', 29, 41, 43000, 0, 3, 2, 76, 0, 0),
(2462, 0, 0, 0, 0, 0, 'Shiva #15', 29, 31, 33000, 0, 2, 2, 66, 0, 0),
(2463, 0, 0, 0, 0, 0, 'Shiva #16', 29, 16, 17000, 0, 1, 1, 24, 0, 0),
(2464, 0, 0, 0, 0, 0, 'Shiva #17', 29, 29, 30000, 0, 3, 1, 53, 0, 0),
(2465, 0, 0, 0, 0, 0, 'Shiva #18', 29, 40, 42000, 0, 3, 2, 72, 0, 0),
(2466, 0, 0, 0, 0, 0, 'Shiva #19', 29, 30, 32000, 0, 3, 2, 59, 0, 0),
(2467, 0, 0, 0, 0, 0, 'Shiva #20', 29, 139, 145000, 0, 9, 6, 238, 0, 0),
(2468, 0, 0, 0, 0, 0, 'Senja Village #1', 4, 30, 32000, 0, 3, 2, 55, 0, 0),
(2469, 0, 0, 0, 0, 0, 'Senja Village #2', 4, 48, 50000, 0, 3, 2, 84, 0, 0),
(2470, 0, 0, 0, 0, 0, 'Senja Village #3', 4, 50, 52000, 0, 2, 2, 80, 0, 0),
(2471, 0, 0, 0, 0, 0, 'Senja Village #5', 4, 30, 31000, 0, 4, 1, 70, 0, 0),
(2472, 0, 0, 0, 0, 0, 'Senja Village #6', 4, 14, 15000, 0, 2, 1, 23, 0, 0),
(2473, 0, 0, 0, 0, 0, 'Senja Village #7', 4, 14, 15000, 0, 3, 1, 31, 0, 0),
(2474, 0, 0, 0, 0, 0, 'Senja Village #8', 4, 20, 22000, 0, 4, 2, 39, 0, 0),
(2475, 0, 0, 0, 0, 0, 'Senja Village #9', 4, 14, 15000, 0, 2, 1, 28, 0, 0),
(2476, 0, 0, 0, 0, 0, 'Senja Village #10', 4, 28, 30000, 0, 3, 2, 49, 0, 0),
(2477, 0, 0, 0, 0, 0, 'Senja Village #11', 4, 14, 15000, 0, 3, 1, 28, 0, 0),
(2478, 0, 0, 0, 0, 0, 'Senja Village #12', 4, 28, 30000, 0, 6, 2, 56, 0, 0),
(2479, 0, 0, 0, 0, 0, 'Senja Village #13', 4, 14, 15000, 0, 3, 1, 28, 0, 0),
(2480, 0, 0, 0, 0, 0, 'Senja Village #14', 4, 172, 181000, 0, 23, 9, 345, 0, 0),
(2481, 0, 0, 0, 0, 0, 'Senja Village #4', 4, 12, 14000, 0, 1, 2, 23, 0, 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `house_auctions`
--

CREATE TABLE IF NOT EXISTS `house_auctions` (
  `house_id` int(10) unsigned NOT NULL,
  `world_id` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `player_id` int(11) NOT NULL,
  `bid` int(10) unsigned NOT NULL DEFAULT '0',
  `limit` int(10) unsigned NOT NULL DEFAULT '0',
  `endtime` bigint(20) unsigned NOT NULL DEFAULT '0',
  UNIQUE KEY `house_id` (`house_id`,`world_id`),
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `house_auctions`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `house_data`
--

CREATE TABLE IF NOT EXISTS `house_data` (
  `house_id` int(10) unsigned NOT NULL,
  `world_id` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `data` longblob NOT NULL,
  UNIQUE KEY `house_id` (`house_id`,`world_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `house_data`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `house_lists`
--

CREATE TABLE IF NOT EXISTS `house_lists` (
  `house_id` int(10) unsigned NOT NULL,
  `world_id` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `listid` int(11) NOT NULL,
  `list` text NOT NULL,
  UNIQUE KEY `house_id` (`house_id`,`world_id`,`listid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `house_lists`
--


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

--
-- Extraindo dados da tabela `killers`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `login_history`
--

CREATE TABLE IF NOT EXISTS `login_history` (
  `account_id` int(11) NOT NULL DEFAULT '0',
  `player_id` int(11) NOT NULL DEFAULT '0',
  `type` tinyint(1) NOT NULL DEFAULT '0',
  `login` tinyint(1) NOT NULL DEFAULT '0',
  `ip` int(11) NOT NULL DEFAULT '0',
  `date` int(11) NOT NULL DEFAULT '0',
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `login_history`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `lottery`
--

CREATE TABLE IF NOT EXISTS `lottery` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `item` varchar(255) NOT NULL,
  `world_id` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `item_name` varchar(255) NOT NULL,
  `date` varchar(256) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `lottery`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `market_history`
--

CREATE TABLE IF NOT EXISTS `market_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `world_id` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `player_id` int(11) NOT NULL,
  `sale` tinyint(1) NOT NULL DEFAULT '0',
  `itemtype` int(10) unsigned NOT NULL,
  `amount` smallint(5) unsigned NOT NULL,
  `price` int(10) unsigned NOT NULL DEFAULT '0',
  `expires_at` bigint(20) unsigned NOT NULL,
  `inserted` bigint(20) unsigned NOT NULL,
  `state` tinyint(1) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `player_id` (`player_id`,`sale`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `market_history`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `market_offers`
--

CREATE TABLE IF NOT EXISTS `market_offers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `world_id` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `player_id` int(11) NOT NULL,
  `sale` tinyint(1) NOT NULL DEFAULT '0',
  `itemtype` int(10) unsigned NOT NULL,
  `amount` smallint(5) unsigned NOT NULL,
  `created` bigint(20) unsigned NOT NULL,
  `anonymous` tinyint(1) NOT NULL DEFAULT '0',
  `price` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sale` (`sale`,`itemtype`),
  KEY `created` (`created`),
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `market_offers`
--


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
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `marriage_system`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `pagsegurotransacoes`
--

CREATE TABLE IF NOT EXISTS `pagsegurotransacoes` (
  `TransacaoID` varchar(36) NOT NULL,
  `VendedorEmail` varchar(200) NOT NULL,
  `Referencia` varchar(200) DEFAULT NULL,
  `TipoFrete` char(2) DEFAULT NULL,
  `ValorFrete` decimal(10,2) DEFAULT NULL,
  `Extras` decimal(10,2) DEFAULT NULL,
  `Anotacao` text,
  `TipoPagamento` varchar(50) NOT NULL,
  `StatusTransacao` varchar(50) NOT NULL,
  `CliNome` varchar(200) NOT NULL,
  `CliEmail` varchar(200) NOT NULL,
  `CliEndereco` varchar(200) NOT NULL,
  `CliNumero` varchar(10) DEFAULT NULL,
  `CliComplemento` varchar(100) DEFAULT NULL,
  `CliBairro` varchar(100) NOT NULL,
  `CliCidade` varchar(100) NOT NULL,
  `CliEstado` char(2) NOT NULL,
  `CliCEP` varchar(9) NOT NULL,
  `CliTelefone` varchar(14) DEFAULT NULL,
  `NumItens` int(11) NOT NULL,
  `Data` datetime NOT NULL,
  `ProdQuantidade_x` int(5) NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  UNIQUE KEY `TransacaoID` (`TransacaoID`,`StatusTransacao`),
  KEY `Referencia` (`Referencia`),
  KEY `status` (`status`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `pagsegurotransacoes`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `players`
--

CREATE TABLE IF NOT EXISTS `players` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `world_id` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `group_id` int(11) NOT NULL DEFAULT '1',
  `account_id` int(11) NOT NULL DEFAULT '0',
  `level` int(11) NOT NULL DEFAULT '1',
  `vocation` int(11) NOT NULL DEFAULT '0',
  `health` int(11) NOT NULL DEFAULT '150',
  `healthmax` int(11) NOT NULL DEFAULT '150',
  `experience` bigint(20) unsigned NOT NULL DEFAULT '0',
  `lookbody` int(11) NOT NULL DEFAULT '0',
  `lookfeet` int(11) NOT NULL DEFAULT '0',
  `lookhead` int(11) NOT NULL DEFAULT '0',
  `looklegs` int(11) NOT NULL DEFAULT '0',
  `looktype` int(11) NOT NULL DEFAULT '136',
  `lookaddons` int(11) NOT NULL DEFAULT '0',
  `lookmount` int(11) NOT NULL DEFAULT '0',
  `maglevel` int(11) NOT NULL DEFAULT '0',
  `mana` int(11) NOT NULL DEFAULT '0',
  `manamax` int(11) NOT NULL DEFAULT '0',
  `manaspent` bigint(20) unsigned NOT NULL DEFAULT '0',
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
  `lastlogout` bigint(20) unsigned NOT NULL DEFAULT '0',
  `blessings` tinyint(2) NOT NULL DEFAULT '0',
  `pvp_blessing` tinyint(1) NOT NULL DEFAULT '0',
  `balance` bigint(20) unsigned NOT NULL DEFAULT '0',
  `stamina` bigint(20) unsigned NOT NULL DEFAULT '151200000' COMMENT 'stored in miliseconds',
  `direction` int(11) NOT NULL DEFAULT '2',
  `loss_experience` int(11) NOT NULL DEFAULT '100',
  `loss_mana` int(11) NOT NULL DEFAULT '100',
  `loss_skills` int(11) NOT NULL DEFAULT '100',
  `loss_containers` int(11) NOT NULL DEFAULT '100',
  `loss_items` int(11) NOT NULL DEFAULT '100',
  `premend` int(11) NOT NULL DEFAULT '0' COMMENT 'NOT IN USE BY THE SERVER',
  `online` tinyint(1) NOT NULL DEFAULT '0',
  `marriage` int(10) unsigned NOT NULL DEFAULT '0',
  `promotion` int(11) NOT NULL DEFAULT '0',
  `deleted` int(11) NOT NULL DEFAULT '0',
  `description` varchar(255) NOT NULL DEFAULT '',
  `offlinetraining_time` smallint(5) unsigned NOT NULL DEFAULT '43200',
  `offlinetraining_skill` int(11) NOT NULL DEFAULT '-1',
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
  `stars` int(10) NOT NULL DEFAULT '0',
  `ip` varchar(17) NOT NULL DEFAULT '0',
  `cast` tinyint(4) NOT NULL DEFAULT '0',
  `castViewers` int(11) NOT NULL DEFAULT '0',
  `castDescription` varchar(255) NOT NULL,
  `broadcasting` tinyint(4) DEFAULT '0',
  `viewers` int(1) DEFAULT '0',
  `frags` int(15) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`deleted`),
  KEY `account_id` (`account_id`),
  KEY `group_id` (`group_id`),
  KEY `online` (`online`),
  KEY `deleted` (`deleted`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

--
-- Extraindo dados da tabela `players`
--

INSERT INTO `players` (`id`, `name`, `world_id`, `group_id`, `account_id`, `level`, `vocation`, `health`, `healthmax`, `experience`, `lookbody`, `lookfeet`, `lookhead`, `looklegs`, `looktype`, `lookaddons`, `lookmount`, `maglevel`, `mana`, `manamax`, `manaspent`, `soul`, `town_id`, `posx`, `posy`, `posz`, `conditions`, `cap`, `sex`, `lastlogin`, `lastip`, `save`, `skull`, `skulltime`, `rank_id`, `guildnick`, `lastlogout`, `blessings`, `pvp_blessing`, `balance`, `stamina`, `direction`, `loss_experience`, `loss_mana`, `loss_skills`, `loss_containers`, `loss_items`, `premend`, `online`, `marriage`, `promotion`, `deleted`, `description`, `offlinetraining_time`, `offlinetraining_skill`, `created`, `nick_verify`, `old_name`, `hide_char`, `worldtransfer`, `comment`, `show_outfit`, `show_eq`, `show_bars`, `show_skills`, `show_quests`, `stars`, `ip`, `cast`, `castViewers`, `castDescription`, `broadcasting`, `viewers`, `frags`) VALUES
(1, 'Account Manager', 0, 1, 1, 1, 0, 150, 150, 0, 30, 50, 20, 40, 225, 0, 0, 0, 0, 0, 0, 0, 0, 160, 51, 7, '', 400, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 201660000, 0, 100, 100, 100, 100, 100, 0, 0, 0, 0, 0, '', 43200, -1, 0, 0, '', 0, 0, '', 1, 1, 1, 1, 1, 0, '0', 0, 0, '', 0, 0, 0),
(2, 'Rook Sample', 0, 1, 4032593, 1, 0, 185, 185, 0, 0, 0, 0, 0, 110, 0, 0, 0, 0, 0, 0, 0, 0, 50, 50, 7, '', 400, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 201660000, 0, 100, 100, 100, 100, 100, 0, 0, 0, 0, 0, '', 43200, -1, 0, 0, '', 0, 0, '', 1, 1, 1, 1, 1, 0, '0', 0, 0, '', 0, 0, 0),
(3, 'Sorcerer Sample', 0, 1, 4032593, 8, 1, 185, 185, 4200, 68, 114, 78, 58, 128, 0, 0, 0, 35, 35, 0, 0, 2, 32369, 32241, 7, '', 400, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 201660000, 0, 100, 100, 100, 100, 100, 0, 0, 0, 0, 0, '', 43200, -1, 0, 0, '', 0, 0, '', 1, 1, 1, 1, 1, 0, '0', 0, 0, '', 0, 0, 0),
(4, 'Druid Sample', 0, 1, 4032593, 8, 2, 185, 185, 4200, 68, 114, 78, 58, 128, 0, 0, 0, 35, 35, 0, 0, 2, 32369, 32241, 7, '', 400, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 201660000, 0, 100, 100, 100, 100, 100, 0, 0, 0, 0, 0, '', 43200, -1, 0, 0, '', 0, 0, '', 1, 1, 1, 1, 1, 0, '0', 0, 0, '', 0, 0, 0),
(5, 'Paladin Sample', 0, 1, 4032593, 8, 3, 185, 185, 4200, 68, 114, 78, 58, 128, 0, 0, 0, 35, 35, 0, 0, 2, 32369, 32241, 7, '', 500, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 201660000, 0, 100, 100, 100, 100, 100, 0, 0, 0, 0, 0, '', 43200, -1, 0, 0, '', 0, 0, '', 1, 1, 1, 1, 1, 0, '0', 0, 0, '', 0, 0, 0),
(6, 'Knight Sample', 0, 1, 4032593, 8, 4, 185, 185, 4200, 68, 114, 78, 58, 128, 0, 0, 0, 35, 35, 0, 0, 2, 160, 51, 7, '', 550, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0, 201660000, 0, 100, 100, 100, 100, 100, 0, 0, 0, 0, 0, '', 43200, -1, 0, 0, '', 0, 0, '', 1, 1, 1, 1, 1, 0, '0', 0, 0, '', 0, 0, 0),
(10, 'GOD Raymond', 0, 6, 4465942, 8, 2, 185, 185, 4200, 68, 114, 78, 58, 128, 0, 0, 0, 35, 35, 0, 0, 1, 160, 51, 7, '', 400, 1, 0, 0, 1, 0, 0, 0, '', 0, 0, 0, 0, 151200000, 2, 100, 100, 100, 100, 100, 0, 0, 0, 0, 0, '', 43200, -1, 1489877287, 0, '', 0, 0, '', 1, 1, 1, 1, 1, 0, '0', 0, 0, '', 0, 0, 0);

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

--
-- Extraindo dados da tabela `player_deaths`
--


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
  `m_uid` int(11) NOT NULL DEFAULT '0',
  `serial` varchar(255) NOT NULL DEFAULT '',
  UNIQUE KEY `player_id_2` (`player_id`,`sid`),
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `player_depotitems`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `player_inboxitems`
--

CREATE TABLE IF NOT EXISTS `player_inboxitems` (
  `player_id` int(11) NOT NULL,
  `sid` int(11) NOT NULL,
  `pid` int(11) NOT NULL DEFAULT '0',
  `itemtype` smallint(6) NOT NULL,
  `count` smallint(5) NOT NULL DEFAULT '0',
  `attributes` blob NOT NULL,
  `serial` varchar(255) NOT NULL DEFAULT '',
  UNIQUE KEY `player_id_2` (`player_id`,`sid`),
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `player_inboxitems`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `player_items`
--

CREATE TABLE IF NOT EXISTS `player_items` (
  `player_id` int(11) NOT NULL,
  `pid` int(11) NOT NULL DEFAULT '0',
  `sid` int(11) NOT NULL DEFAULT '0',
  `itemtype` int(11) NOT NULL DEFAULT '0',
  `count` int(11) NOT NULL DEFAULT '0',
  `attributes` blob NOT NULL,
  `m_uid` int(11) NOT NULL DEFAULT '0',
  `serial` varchar(255) NOT NULL DEFAULT '',
  UNIQUE KEY `player_id_2` (`player_id`,`sid`),
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `player_items`
--


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

--
-- Extraindo dados da tabela `player_killers`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `player_namelocks`
--

CREATE TABLE IF NOT EXISTS `player_namelocks` (
  `player_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `new_name` varchar(255) NOT NULL,
  `date` bigint(20) NOT NULL DEFAULT '0',
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `player_namelocks`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `player_skills`
--

CREATE TABLE IF NOT EXISTS `player_skills` (
  `player_id` int(11) NOT NULL,
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
(2, 0, 10, 0),
(2, 1, 10, 0),
(2, 2, 10, 0),
(2, 3, 10, 0),
(2, 4, 10, 0),
(2, 5, 10, 0),
(2, 6, 10, 0),
(3, 0, 10, 0),
(3, 1, 10, 0),
(3, 2, 10, 0),
(3, 3, 10, 0),
(3, 4, 10, 0),
(3, 5, 10, 0),
(3, 6, 10, 0),
(4, 0, 10, 0),
(4, 1, 10, 0),
(4, 2, 10, 0),
(4, 3, 10, 0),
(4, 4, 10, 0),
(4, 5, 10, 0),
(4, 6, 10, 0),
(5, 0, 10, 0),
(5, 1, 10, 0),
(5, 2, 10, 0),
(5, 3, 10, 0),
(5, 4, 10, 0),
(5, 5, 10, 0),
(5, 6, 10, 0),
(6, 0, 10, 0),
(6, 1, 10, 0),
(6, 2, 10, 0),
(6, 3, 10, 0),
(6, 4, 10, 0),
(6, 5, 10, 0),
(6, 6, 10, 0),
(10, 0, 10, 0),
(10, 1, 10, 0),
(10, 2, 10, 0),
(10, 3, 10, 0),
(10, 4, 10, 0),
(10, 5, 10, 0),
(10, 6, 10, 0);

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

--
-- Extraindo dados da tabela `player_spells`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `player_statements`
--

CREATE TABLE IF NOT EXISTS `player_statements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `channel_id` int(11) NOT NULL DEFAULT '0',
  `text` varchar(255) NOT NULL,
  `date` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `player_id` (`player_id`),
  KEY `channel_id` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `player_statements`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `player_storage`
--

CREATE TABLE IF NOT EXISTS `player_storage` (
  `player_id` int(11) NOT NULL,
  `key` varchar(32) NOT NULL DEFAULT '0',
  `value` text NOT NULL,
  UNIQUE KEY `player_id_2` (`player_id`,`key`),
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `player_storage`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `player_viplist`
--

CREATE TABLE IF NOT EXISTS `player_viplist` (
  `player_id` int(11) NOT NULL,
  `vip_id` int(11) NOT NULL,
  `description` varchar(128) NOT NULL,
  `icon` int(11) unsigned NOT NULL,
  `notify` tinyint(1) NOT NULL,
  UNIQUE KEY `player_id_2` (`player_id`,`vip_id`),
  KEY `player_id` (`player_id`),
  KEY `vip_id` (`vip_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `player_viplist`
--


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
('db_version', '41'),
('encryption', '2');

-- --------------------------------------------------------

--
-- Estrutura da tabela `server_motd`
--

CREATE TABLE IF NOT EXISTS `server_motd` (
  `id` int(10) unsigned NOT NULL,
  `world_id` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `text` text NOT NULL,
  UNIQUE KEY `id` (`id`,`world_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `server_motd`
--

INSERT INTO `server_motd` (`id`, `world_id`, `text`) VALUES
(196, 0, 'Welcome to the Rivals Global!'),
(197, 0, 'Welcome to the Dark Global!');

-- --------------------------------------------------------

--
-- Estrutura da tabela `server_record`
--

CREATE TABLE IF NOT EXISTS `server_record` (
  `record` int(11) NOT NULL,
  `world_id` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `timestamp` bigint(20) NOT NULL,
  UNIQUE KEY `record` (`record`,`world_id`,`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `server_record`
--

INSERT INTO `server_record` (`record`, `world_id`, `timestamp`) VALUES
(1, 0, 1401253237);

-- --------------------------------------------------------

--
-- Estrutura da tabela `server_reports`
--

CREATE TABLE IF NOT EXISTS `server_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `world_id` tinyint(4) unsigned NOT NULL DEFAULT '0',
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

--
-- Extraindo dados da tabela `server_reports`
--


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
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `shop_npc`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `thanks`
--

CREATE TABLE IF NOT EXISTS `thanks` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `account_id` varchar(30) NOT NULL,
  `forum_id` text NOT NULL,
  `player_name` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `thanks`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `tiles`
--

CREATE TABLE IF NOT EXISTS `tiles` (
  `id` int(10) unsigned NOT NULL,
  `world_id` tinyint(4) unsigned NOT NULL DEFAULT '0',
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


-- --------------------------------------------------------

--
-- Estrutura da tabela `tile_items`
--

CREATE TABLE IF NOT EXISTS `tile_items` (
  `tile_id` int(10) unsigned NOT NULL,
  `world_id` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `sid` int(11) NOT NULL,
  `pid` int(11) NOT NULL DEFAULT '0',
  `itemtype` int(11) NOT NULL,
  `count` int(11) NOT NULL DEFAULT '0',
  `attributes` blob NOT NULL,
  `serial` varchar(255) NOT NULL DEFAULT '',
  UNIQUE KEY `tile_id` (`tile_id`,`world_id`,`sid`),
  KEY `sid` (`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `tile_items`
--


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

--
-- Extraindo dados da tabela `tile_store`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `videos`
--

CREATE TABLE IF NOT EXISTS `videos` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(20) NOT NULL,
  `url` varchar(50) NOT NULL,
  `autor` varchar(20) NOT NULL,
  `data` varchar(50) NOT NULL,
  `tag` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Extraindo dados da tabela `videos`
--


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
-- Extraindo dados da tabela `woe`
--

INSERT INTO `woe` (`id`, `started`, `guild`, `breaker`, `time`) VALUES
(2, 1388268039, 5, 102, 1374364555),
(3, 1389477658, 1, 50, 1389478672),
(4, 1389650432, 1, 50, 1389478672);

-- --------------------------------------------------------

--
-- Estrutura da tabela `z_bug_logs`
--

CREATE TABLE IF NOT EXISTS `z_bug_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `description` text NOT NULL,
  `time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `z_bug_logs`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `z_forum`
--

CREATE TABLE IF NOT EXISTS `z_forum` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sticky` tinyint(1) NOT NULL DEFAULT '0',
  `closed` tinyint(1) NOT NULL DEFAULT '0',
  `first_post` int(11) NOT NULL DEFAULT '0',
  `last_post` int(11) NOT NULL DEFAULT '0',
  `section` int(3) NOT NULL DEFAULT '0',
  `icon_id` int(3) NOT NULL DEFAULT '1',
  `replies` int(20) NOT NULL DEFAULT '0',
  `views` int(20) NOT NULL DEFAULT '0',
  `author_aid` int(20) NOT NULL DEFAULT '0',
  `author_guid` int(20) NOT NULL DEFAULT '0',
  `post_text` text NOT NULL,
  `post_topic` varchar(255) NOT NULL,
  `post_smile` tinyint(1) NOT NULL DEFAULT '0',
  `post_date` int(20) NOT NULL DEFAULT '0',
  `last_edit_aid` int(20) NOT NULL DEFAULT '0',
  `edit_date` int(20) NOT NULL DEFAULT '0',
  `post_ip` varchar(32) NOT NULL DEFAULT '0.0.0.0',
  PRIMARY KEY (`id`),
  KEY `section` (`section`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Extraindo dados da tabela `z_forum`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `z_helpdesk`
--

CREATE TABLE IF NOT EXISTS `z_helpdesk` (
  `account` varchar(255) NOT NULL,
  `type` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `text` text NOT NULL,
  `id` int(11) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `priority` int(11) NOT NULL,
  `reply` int(11) NOT NULL,
  `who` int(11) NOT NULL,
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `tag` int(11) NOT NULL,
  `registered` int(11) NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `z_helpdesk`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `z_monsters`
--

CREATE TABLE IF NOT EXISTS `z_monsters` (
  `hide_creature` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `mana` int(11) NOT NULL,
  `exp` int(11) NOT NULL,
  `health` int(11) NOT NULL,
  `speed_lvl` int(11) NOT NULL DEFAULT '1',
  `use_haste` tinyint(1) NOT NULL,
  `voices` text NOT NULL,
  `immunities` varchar(255) NOT NULL,
  `summonable` tinyint(1) NOT NULL,
  `convinceable` tinyint(1) NOT NULL,
  `race` varchar(255) NOT NULL,
  `loot` text NOT NULL,
  `gfx_name` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `z_monsters`
--

INSERT INTO `z_monsters` (`hide_creature`, `name`, `mana`, `exp`, `health`, `speed_lvl`, `use_haste`, `voices`, `immunities`, `summonable`, `convinceable`, `race`, `loot`, `gfx_name`) VALUES
(0, 'Draken Spellweaver', 0, 2600, 5000, 10, 0, '', 'fire, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/11307.gif" />&nbsp;&nbsp;<img src="images/items/11296.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/11348.gif" />&nbsp;&nbsp;', 'drakenspellweaver.gif'),
(0, 'Draken Warmaster', 0, 2400, 4150, 1, 0, '', 'fire', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2152.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/11298.gif" />&nbsp;&nbsp;<img src="images/items/11316.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/11297.gif" />&nbsp;&nbsp;', 'drakenwarmaster.gif'),
(0, 'Gnarlhound', 0, 60, 198, 1, 0, '"Gnarlll!", "Grrrrrr!"', '', 127, 0, 'blood', '<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/11317.gif" />&nbsp;&nbsp;', 'gnarlhound.gif'),
(0, 'Koshei The Deathless', 0, 100, 20000, 85, 0, '"Your pain will be beyond imagination!", "You can''t defeat me! I will ressurect and take your soul!", "Death is my ally!", "Welcome to my domain, visitor!", "You will be my toy on the other side!", "What a disgusting smell of life!"', 'death, earth, paralyze, invisible', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2401.gif" />&nbsp;&nbsp;<img src="images/items/2171.gif" />&nbsp;&nbsp;<img src="images/items/8266.gif" />&nbsp;&nbsp;<img src="images/items/2656.gif" />&nbsp;&nbsp;<img src="images/items/7893.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2535.gif" />&nbsp;&nbsp;<img src="images/items/2165.gif" />&nbsp;&nbsp;<img src="images/items/2237.gif" />&nbsp;&nbsp;<img src="images/items/2175.gif" />&nbsp;&nbsp;<img src="images/items/2179.gif" />&nbsp;&nbsp;<img src="images/items/3961.gif" />&nbsp;&nbsp;', 'kosheithedeathless.gif'),
(0, 'Insect Swarm', 0, 40, 50, 1, 0, '', 'earth', 0, 127, 'venom', '', 'insectswarm.gif'),
(0, 'Killer Caiman', 350, 800, 1500, 10, 0, '', 'invisible', 1, 1, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/11189.gif" />&nbsp;&nbsp;<img src="images/items/3982.gif" />&nbsp;&nbsp;<img src="images/items/2179.gif" />&nbsp;&nbsp;<img src="images/items/11238.gif" />&nbsp;&nbsp;', 'killercaiman.gif'),
(0, 'Lancer Beetle', 0, 250, 400, 1, 0, '"Crump!"', 'earth, invisible, lifedrain, paralyze', 0, 127, 'venom', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/10615.gif" />&nbsp;&nbsp;<img src="images/items/10563.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/11365.gif" />&nbsp;&nbsp;<img src="images/items/11367.gif" />&nbsp;&nbsp;<img src="images/items/2150.gif" />&nbsp;&nbsp;', 'lancerbeetle.gif'),
(0, 'Lizard Chosen', 0, 2200, 3050, 10, 0, '"Grzzzzzzz!"', 'earth, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/11319.gif" />&nbsp;&nbsp;<img src="images/items/11318.gif" />&nbsp;&nbsp;<img src="images/items/11296.gif" />&nbsp;&nbsp;<img src="images/items/5876.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/11320.gif" />&nbsp;&nbsp;<img src="images/items/11295.gif" />&nbsp;&nbsp;<img src="images/items/3963.gif" />&nbsp;&nbsp;<img src="images/items/5881.gif" />&nbsp;&nbsp;', 'lizardchosen.gif'),
(0, 'Lizard Dragon Priest', 0, 1200, 1450, 50, 0, '', 'earth, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/11354.gif" />&nbsp;&nbsp;<img src="images/items/2181.gif" />&nbsp;&nbsp;<img src="images/items/2205.gif" />&nbsp;&nbsp;<img src="images/items/5876.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/11349.gif" />&nbsp;&nbsp;<img src="images/items/11296.gif" />&nbsp;&nbsp;<img src="images/items/2154.gif" />&nbsp;&nbsp;', 'lizarddragonpriest.gif'),
(0, 'Lizard High Guard', 0, 1450, 1800, 60, 0, '"Grzzzzzzz!"', 'earth, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/11238.gif" />&nbsp;&nbsp;<img src="images/items/11318.gif" />&nbsp;&nbsp;<img src="images/items/591.gif" />&nbsp;&nbsp;<img src="images/items/5881.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/11296.gif" />&nbsp;&nbsp;<img src="images/items/11325.gif" />&nbsp;&nbsp;<img src="images/items/11294.gif" />&nbsp;&nbsp;<img src="images/items/11297.gif" />&nbsp;&nbsp;<img src="images/items/11199.gif" />&nbsp;&nbsp;<img src="images/items/11326.gif" />&nbsp;&nbsp;<img src="images/items/2149.gif" />&nbsp;&nbsp;<img src="images/items/5876.gif" />&nbsp;&nbsp;', 'lizardhighguard.gif'),
(0, 'Lizard Legionnaire', 0, 1100, 1400, 1, 0, '"Tssss!"', 'earth, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/11328.gif" />&nbsp;&nbsp;<img src="images/items/11316.gif" />&nbsp;&nbsp;<img src="images/items/11327.gif" />&nbsp;&nbsp;<img src="images/items/11329.gif" />&nbsp;&nbsp;<img src="images/items/11298.gif" />&nbsp;&nbsp;<img src="images/items/11296.gif" />&nbsp;&nbsp;<img src="images/items/11294.gif" />&nbsp;&nbsp;<img src="images/items/7618.gif" />&nbsp;&nbsp;<img src="images/items/11199.gif" />&nbsp;&nbsp;', 'lizardlegionnaire.gif'),
(0, 'Lizard Zaogun', 0, 1700, 2955, 100, 0, '', 'earth, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/11324.gif" />&nbsp;&nbsp;<img src="images/items/7591.gif" />&nbsp;&nbsp;<img src="images/items/11199.gif" />&nbsp;&nbsp;<img src="images/items/11323.gif" />&nbsp;&nbsp;<img src="images/items/7588.gif" />&nbsp;&nbsp;<img src="images/items/5881.gif" />&nbsp;&nbsp;<img src="images/items/2149.gif" />&nbsp;&nbsp;<img src="images/items/11297.gif" />&nbsp;&nbsp;', 'lizardzaogun.gif'),
(0, 'Orc Marauder', 0, 205, 235, 85, 1, '"Grrrrrr"', 'invisible', 0, 127, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2428.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/2456.gif" />&nbsp;&nbsp;<img src="images/items/2425.gif" />&nbsp;&nbsp;<img src="images/items/11317.gif" />&nbsp;&nbsp;<img src="images/items/11108.gif" />&nbsp;&nbsp;<img src="images/items/8857.gif" />&nbsp;&nbsp;', 'orcmarauder.gif'),
(0, 'Sandcrawler', 0, 20, 30, 1, 0, '"Chrk chrk!"', '', 1, 0, 'venom', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/11366.gif" />&nbsp;&nbsp;', 'sandcrawler.gif'),
(0, 'Terramite', 0, 160, 365, 1, 0, '"Zrp zrp!"', 'invisible', 1, 0, 'venom', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/11364.gif" />&nbsp;&nbsp;<img src="images/items/11363.gif" />&nbsp;&nbsp;<img src="images/items/11362.gif" />&nbsp;&nbsp;', 'terramite.gif'),
(0, 'Ghastly Dragon', 0, 4600, 7800, 95, 0, '"EMBRACE MY GIFTS!", "I WILL FEAST ON YOUR SOUL!"', 'paralyze, invisible, death, earth', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2152.gif" />&nbsp;&nbsp;<img src="images/items/11316.gif" />&nbsp;&nbsp;<img src="images/items/8473.gif" />&nbsp;&nbsp;<img src="images/items/7591.gif" />&nbsp;&nbsp;<img src="images/items/8472.gif" />&nbsp;&nbsp;<img src="images/items/5944.gif" />&nbsp;&nbsp;<img src="images/items/11360.gif" />&nbsp;&nbsp;<img src="images/items/11361.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/6500.gif" />&nbsp;&nbsp;<img src="images/items/11359.gif" />&nbsp;&nbsp;<img src="images/items/9808.gif" />&nbsp;&nbsp;<img src="images/items/11297.gif" />&nbsp;&nbsp;<img src="images/items/11298.gif" />&nbsp;&nbsp;<img src="images/items/11348.gif" />&nbsp;&nbsp;<img src="images/items/11119.gif" />&nbsp;&nbsp;<img src="images/items/11233.gif" />&nbsp;&nbsp;<img src="images/items/11295.gif" />&nbsp;&nbsp;', 'ghastlydragon.gif'),
(0, 'Wailing Widow', 0, 4600, 7800, 30, 0, '"EMBRACE MY GIFTS!", "I WILL FEAST ON YOUR SOUL!"', 'paralyze, invisible, death, earth', 0, 0, 'venom', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/7620.gif" />&nbsp;&nbsp;<img src="images/items/7618.gif" />&nbsp;&nbsp;<img src="images/items/2796.gif" />&nbsp;&nbsp;<img src="images/items/2510.gif" />&nbsp;&nbsp;<img src="images/items/11321.gif" />&nbsp;&nbsp;<img src="images/items/11322.gif" />&nbsp;&nbsp;<img src="images/items/11316.gif" />&nbsp;&nbsp;', 'wailingwidow.gif'),
(0, 'Abomination Fury', 0, 900, 1300, 1, 0, '"Zrp zrp!"', 'invisible', 1, 0, 'venom', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/11365.gif" />&nbsp;&nbsp;<img src="images/items/11364.gif" />&nbsp;&nbsp;<img src="images/items/11363.gif" />&nbsp;&nbsp;', 'abominationfury.gif'),
(0, 'Brimstone Bug', 0, 900, 1300, 1, 0, '"Zrp zrp!"', 'invisible', 1, 0, 'venom', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/11365.gif" />&nbsp;&nbsp;<img src="images/items/11364.gif" />&nbsp;&nbsp;<img src="images/items/11363.gif" />&nbsp;&nbsp;', 'brimstonebug.gif'),
(0, 'Butterfly Demon', 0, 900, 1300, 1, 0, '"Zrp zrp!"', 'invisible', 1, 0, 'venom', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/11365.gif" />&nbsp;&nbsp;<img src="images/items/11364.gif" />&nbsp;&nbsp;<img src="images/items/11363.gif" />&nbsp;&nbsp;', 'butterflydemon.gif'),
(0, 'Draken Abomination', 0, 900, 1300, 1, 0, '"Zrp zrp!"', 'invisible', 1, 0, 'venom', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/11365.gif" />&nbsp;&nbsp;<img src="images/items/11364.gif" />&nbsp;&nbsp;<img src="images/items/11363.gif" />&nbsp;&nbsp;', 'drakenabomination.gif'),
(0, 'Draken Elite', 0, 4200, 5550, 90, 1, '"For ze emperor!"', 'lifedrain, paralyze, invisible', 0, 0, 'fire', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2393.gif" />&nbsp;&nbsp;<img src="images/items/2514.gif" />&nbsp;&nbsp;<img src="images/items/2432.gif" />&nbsp;&nbsp;<img src="images/items/2472.gif" />&nbsp;&nbsp;<img src="images/items/5906.gif" />&nbsp;&nbsp;<img src="images/items/5954.gif" />&nbsp;&nbsp;<img src="images/items/2164.gif" />&nbsp;&nbsp;<img src="images/items/2176.gif" />&nbsp;&nbsp;<img src="images/items/1982.gif" />&nbsp;&nbsp;<img src="images/items/7368.gif" />&nbsp;&nbsp;<img src="images/items/2165.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2214.gif" />&nbsp;&nbsp;<img src="images/items/2396.gif" />&nbsp;&nbsp;<img src="images/items/2179.gif" />&nbsp;&nbsp;<img src="images/items/2795.gif" />&nbsp;&nbsp;<img src="images/items/2678.gif" />&nbsp;&nbsp;<img src="images/items/2151.gif" />&nbsp;&nbsp;<img src="images/items/2462.gif" />&nbsp;&nbsp;<img src="images/items/2149.gif" />&nbsp;&nbsp;<img src="images/items/2171.gif" />&nbsp;&nbsp;<img src="images/items/2387.gif" />&nbsp;&nbsp;<img src="images/items/2470.gif" />&nbsp;&nbsp;<img src="images/items/2520.gif" />&nbsp;&nbsp;<img src="images/items/2418.gif" />&nbsp;&nbsp;<img src="images/items/7382.gif" />&nbsp;&nbsp;<img src="images/items/2377.gif" />&nbsp;&nbsp;', 'drakenelite.gif'),
(0, 'Finger Killer', 0, 900, 1300, 1, 0, '"Zrp zrp!"', 'invisible', 1, 0, 'venom', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/11365.gif" />&nbsp;&nbsp;<img src="images/items/11364.gif" />&nbsp;&nbsp;<img src="images/items/11363.gif" />&nbsp;&nbsp;', 'fingerkiller.gif'),
(0, 'Living Plant', 0, 900, 1300, 1, 0, '"Zrp zrp!"', 'invisible', 1, 0, 'venom', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/11365.gif" />&nbsp;&nbsp;<img src="images/items/11364.gif" />&nbsp;&nbsp;<img src="images/items/11363.gif" />&nbsp;&nbsp;', 'livingplant.gif'),
(0, 'Lizard Abomination', 0, 900, 1300, 1, 0, '"Zrp zrp!"', 'invisible', 1, 0, 'venom', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/11365.gif" />&nbsp;&nbsp;<img src="images/items/11364.gif" />&nbsp;&nbsp;<img src="images/items/11363.gif" />&nbsp;&nbsp;', 'lizardabomination.gif'),
(0, 'Phantom Lord', 0, 900, 1300, 1, 0, '"Zrp zrp!"', 'invisible', 1, 0, 'venom', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/11365.gif" />&nbsp;&nbsp;<img src="images/items/11364.gif" />&nbsp;&nbsp;<img src="images/items/11363.gif" />&nbsp;&nbsp;', 'phantomlord.gif'),
(0, 'Purple Turtle', 0, 900, 1300, 1, 0, '"Zrp zrp!"', 'invisible', 1, 0, 'venom', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/11365.gif" />&nbsp;&nbsp;<img src="images/items/11364.gif" />&nbsp;&nbsp;<img src="images/items/11363.gif" />&nbsp;&nbsp;', 'purpleturtle.gif'),
(0, 'Snake God Essence', 0, 1350, 20000, 90, 1, '"AHHH ZHE POWER...", "ZHE TIME OF ZHE SNAKE HAZ COME!"', 'lifedrain, paralyze, invisible', 0, 0, 'fire', '', 'snakegodessence.gif'),
(0, 'Souleater', 0, 900, 1300, 1, 0, '"Zrp zrp!"', 'invisible', 1, 0, 'venom', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/11365.gif" />&nbsp;&nbsp;<img src="images/items/11364.gif" />&nbsp;&nbsp;<img src="images/items/11363.gif" />&nbsp;&nbsp;', 'souleater.gif'),
(0, 'Triple Medusa', 0, 900, 1300, 1, 0, '"Zrp zrp!"', 'invisible', 1, 0, 'venom', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/11365.gif" />&nbsp;&nbsp;<img src="images/items/11364.gif" />&nbsp;&nbsp;<img src="images/items/11363.gif" />&nbsp;&nbsp;', 'triplemedusa.gif'),
(0, 'Acid Blob', 0, 250, 250, 1, 0, '', 'death, earth', 0, 0, 'venom', '<img src="images/items/9967.gif" />&nbsp;&nbsp;', 'acidblob.gif'),
(0, 'Crazed Beggar', 300, 35, 100, 1, 0, '"You are one of THEM! Die!", "Wanna buy roses??"', '', 1, 1, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/2237.gif" />&nbsp;&nbsp;<img src="images/items/2744.gif" />&nbsp;&nbsp;<img src="images/items/2370.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2690.gif" />&nbsp;&nbsp;<img src="images/items/2567.gif" />&nbsp;&nbsp;<img src="images/items/1681.gif" />&nbsp;&nbsp;<img src="images/items/2213.gif" />&nbsp;&nbsp;<img src="images/items/9808.gif" />&nbsp;&nbsp;', 'crazedbeggar.gif'),
(0, 'Medusa', 0, 4050, 4500, 10, 0, '"You will ssuch a fine ssstatue!", "There isss no chhhanccce of esscape", "Are you tired or why are you moving thhat sslow"', 'earth, paralyze, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;<img src="images/items/7590.gif" />&nbsp;&nbsp;<img src="images/items/2476.gif" />&nbsp;&nbsp;<img src="images/items/2536.gif" />&nbsp;&nbsp;<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2149.gif" />&nbsp;&nbsp;<img src="images/items/2004.gif" />&nbsp;&nbsp;<img src="images/items/2152.gif" />&nbsp;&nbsp;<img src="images/items/9808.gif" />&nbsp;&nbsp;<img src="images/items/7887.gif" />&nbsp;&nbsp;<img src="images/items/7885.gif" />&nbsp;&nbsp;<img src="images/items/7884.gif" />&nbsp;&nbsp;<img src="images/items/7413.gif" />&nbsp;&nbsp;<img src="images/items/8473.gif" />&nbsp;&nbsp;<img src="images/items/2143.gif" />&nbsp;&nbsp;', 'medusa.gif'),
(0, 'Damaged Worker Golem', 0, 95, 260, 25, 0, '"Klonk klonk klonk", "Failure! Failire!", "Good morning citizen. How may I serve you?", "Target identified: Rat! Termination initiated!"', 'invisible, paralyze', 0, 0, 'undead', '<img src="images/items/8309.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/5880.gif" />&nbsp;&nbsp;<img src="images/items/9808.gif" />&nbsp;&nbsp;<img src="images/items/2207.gif" />&nbsp;&nbsp;', 'damagedworkergolem.gif'),
(0, 'Death Blob', 0, 300, 320, 1, 0, '', '', 0, 0, 'undead', '<img src="images/items/9968.gif" />&nbsp;&nbsp;', 'deathblob.gif'),
(0, 'Gang Member', 420, 70, 295, 1, 0, '"I don''t like the way you look!", "You''re wearing the wrong colours!", "This is our territory!"', '', 1, 1, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2468.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/2389.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2649.gif" />&nbsp;&nbsp;<img src="images/items/2689.gif" />&nbsp;&nbsp;<img src="images/items/2209.gif" />&nbsp;&nbsp;', 'gangmember.gif'),
(0, 'Gladiator', 470, 90, 185, 1, 1, '"You are no match for me!", "Feel my prowess", "Fight!"', '', 1, 1, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/8872.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/2465.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2398.gif" />&nbsp;&nbsp;<img src="images/items/2459.gif" />&nbsp;&nbsp;<img src="images/items/2510.gif" />&nbsp;&nbsp;<img src="images/items/2509.gif" />&nbsp;&nbsp;', 'gladiator.gif'),
(0, 'Gozzler', 800, 180, 240, 1, 1, '"Huhuhuhuuu!", "Let the fun begin!", "Yihahaha!", "I''ll bite you! Nyehehehehe!"', 'invisible', 1, 0, 'blood', '<img src="images/items/2015.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2394.gif" />&nbsp;&nbsp;<img src="images/items/2385.gif" />&nbsp;&nbsp;<img src="images/items/2051.gif" />&nbsp;&nbsp;<img src="images/items/2510.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2378.gif" />&nbsp;&nbsp;<img src="images/items/2409.gif" />&nbsp;&nbsp;<img src="images/items/2423.gif" />&nbsp;&nbsp;<img src="images/items/2213.gif" />&nbsp;&nbsp;<img src="images/items/2146.gif" />&nbsp;&nbsp;', 'gozzler.gif'),
(0, 'Hellspawn', 0, 2550, 3500, 70, 0, '"Your fragile bones are like toothpicks to me.", "You little weasel will not live to see another day.", "I''m just a messenger of what''s yet to come."', 'paralyze, invisible', 0, 0, 'blood', '<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/7368.gif" />&nbsp;&nbsp;<img src="images/items/6500.gif" />&nbsp;&nbsp;<img src="images/items/2475.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2394.gif" />&nbsp;&nbsp;<img src="images/items/9970.gif" />&nbsp;&nbsp;<img src="images/items/2476.gif" />&nbsp;&nbsp;<img src="images/items/2477.gif" />&nbsp;&nbsp;<img src="images/items/7421.gif" />&nbsp;&nbsp;<img src="images/items/9948.gif" />&nbsp;&nbsp;<img src="images/items/9969.gif" />&nbsp;&nbsp;<img src="images/items/7452.gif" />&nbsp;&nbsp;', 'hellspawn.gif'),
(0, 'Infernalist', 0, 4000, 3650, 20, 0, '"Nothing will remain but your scorched bones!", "Some like it hot!", "Feel the heat of battle!"', 'energy, fire, paralyze, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/8840.gif" />&nbsp;&nbsp;<img src="images/items/9971.gif" />&nbsp;&nbsp;<img src="images/items/7590.gif" />&nbsp;&nbsp;<img src="images/items/7591.gif" />&nbsp;&nbsp;<img src="images/items/7891.gif" />&nbsp;&nbsp;<img src="images/items/5904.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/7760.gif" />&nbsp;&nbsp;<img src="images/items/9980.gif" />&nbsp;&nbsp;<img src="images/items/2167.gif" />&nbsp;&nbsp;<img src="images/items/2436.gif" />&nbsp;&nbsp;<img src="images/items/2114.gif" />&nbsp;&nbsp;<img src="images/items/7410.gif" />&nbsp;&nbsp;<img src="images/items/8092.gif" />&nbsp;&nbsp;', 'infernalist.gif'),
(0, 'Mad Scientist', 0, 205, 325, 1, 0, '"Die in the name of Science!", "I will study your corpse", "You will regret interrupting my studies!", "Let me test this!"', 'drown, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2787.gif" />&nbsp;&nbsp;<img src="images/items/2308.gif" />&nbsp;&nbsp;<img src="images/items/7620.gif" />&nbsp;&nbsp;<img src="images/items/7618.gif" />&nbsp;&nbsp;<img src="images/items/2687.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/7762.gif" />&nbsp;&nbsp;<img src="images/items/2177.gif" />&nbsp;&nbsp;<img src="images/items/6324.gif" />&nbsp;&nbsp;<img src="images/items/2162.gif" />&nbsp;&nbsp;<img src="images/items/2190.gif" />&nbsp;&nbsp;<img src="images/items/7440.gif" />&nbsp;&nbsp;', 'madscientist.gif'),
(0, 'Mercury Blob', 0, 180, 150, 1, 0, '"Crackle"', 'death', 0, 0, 'undead', '<img src="images/items/9966.gif" />&nbsp;&nbsp;', 'mercuryblob.gif'),
(0, 'Mutated Rat', 0, 450, 550, 13, 0, '"Grrrrrrrrrrrrrr!", "Fcccccchhhhhh"', 'death, earth, paralyze, lifedrain, drunk, drown, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2320.gif" />&nbsp;&nbsp;<img src="images/items/2335.gif" />&nbsp;&nbsp;<img src="images/items/2799.gif" />&nbsp;&nbsp;<img src="images/items/2796.gif" />&nbsp;&nbsp;<img src="images/items/7618.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2510.gif" />&nbsp;&nbsp;<img src="images/items/2381.gif" />&nbsp;&nbsp;<img src="images/items/2165.gif" />&nbsp;&nbsp;<img src="images/items/8900.gif" />&nbsp;&nbsp;<img src="images/items/2528.gif" />&nbsp;&nbsp;', 'mutatedrat.gif'),
(0, 'Mutated Human', 0, 150, 240, 13, 0, '"Take that creature off my back!! I can fell it!", "HEEEEEEEELP!", "You will be the next infected one... GRAAAAAAAAARRR!", "Science... is a curse.", "Run as fast as you can.", "Oh by the gods! What is this... aaaaaargh!"', 'death, earth, paralyze, lifedrain, drunk, drown, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;<img src="images/items/2696.gif" />&nbsp;&nbsp;<img src="images/items/2226.gif" />&nbsp;&nbsp;<img src="images/items/2484.gif" />&nbsp;&nbsp;<img src="images/items/2801.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2406.gif" />&nbsp;&nbsp;<img src="images/items/2376.gif" />&nbsp;&nbsp;<img src="images/items/2170.gif" />&nbsp;&nbsp;<img src="images/items/2161.gif" />&nbsp;&nbsp;<img src="images/items/9808.gif" />&nbsp;&nbsp;<img src="images/items/7910.gif" />&nbsp;&nbsp;', 'mutatedhuman.gif'),
(0, 'Mutated Bat', 0, 615, 900, 13, 0, '"Shriiiiek"', 'death, earth, drown, invisible, drunk', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2800.gif" />&nbsp;&nbsp;<img src="images/items/5894.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2513.gif" />&nbsp;&nbsp;<img src="images/items/2150.gif" />&nbsp;&nbsp;<img src="images/items/2144.gif" />&nbsp;&nbsp;<img src="images/items/7386.gif" />&nbsp;&nbsp;<img src="images/items/2165.gif" />&nbsp;&nbsp;<img src="images/items/10016.gif" />&nbsp;&nbsp;', 'mutatedbat.gif'),
(0, 'Mutated Tiger', 0, 750, 1100, 13, 0, '"GRAAARRRRRR", "CHHHHHHHHHHH"', 'paralyze, drunk, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/7588.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2509.gif" />&nbsp;&nbsp;<img src="images/items/.gif" />&nbsp;&nbsp;<img src="images/items/2515.gif" />&nbsp;&nbsp;<img src="images/items/2168.gif" />&nbsp;&nbsp;<img src="images/items/7454.gif" />&nbsp;&nbsp;<img src="images/items/7436.gif" />&nbsp;&nbsp;', 'mutatedtiger.gif'),
(0, 'The Mutated Pumpkin', 0, 30000, 100000, 1, 0, '"I had the Halloween Hare for breakfast!", "Your soul will be mine...wait, wrong line", "Trick or treat? I saw death!", "No wait! Don''t kill me! It''s me, your friend!", "Bunnies, bah! I''m the real thing!", "Muahahahaha!", "I''ve come to avenge all those mutilated pumpkins!", "Wait until I get you!", "Fear the spirit of Halloween!"', 'invisible', 0, 0, 'fire', '<img src="images/items/9006.gif" />&nbsp;&nbsp;<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/8860.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/6492.gif" />&nbsp;&nbsp;<img src="images/items/6524.gif" />&nbsp;&nbsp;', 'themutatedpumpkin.gif'),
(0, 'Nightmare Scion', 0, 1350, 1400, 70, 1, '"Weeeheeheee!"', 'earth, death, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2152.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/6300.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;<img src="images/items/2230.gif" />&nbsp;&nbsp;<img src="images/items/6574.gif" />&nbsp;&nbsp;<img src="images/items/6500.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2387.gif" />&nbsp;&nbsp;<img src="images/items/2491.gif" />&nbsp;&nbsp;<img src="images/items/8871.gif" />&nbsp;&nbsp;<img src="images/items/7451.gif" />&nbsp;&nbsp;', 'nightmarescion.gif'),
(0, 'Vampire Bride', 0, 1050, 1200, 23, 0, '"Kneel before your Mistress!", "Dead is the new alive.", "Come, let me kiss you, darling. Oh wait, I meant kill.", "Enjoy the pain - I know you love it."', 'death, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/7588.gif" />&nbsp;&nbsp;<img src="images/items/7589.gif" />&nbsp;&nbsp;<img src="images/items/2145.gif" />&nbsp;&nbsp;<img src="images/items/2127.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2186.gif" />&nbsp;&nbsp;<img src="images/items/9837.gif" />&nbsp;&nbsp;<img src="images/items/5670.gif" />&nbsp;&nbsp;<img src="images/items/9808.gif" />&nbsp;&nbsp;<img src="images/items/2195.gif" />&nbsp;&nbsp;', 'vampirebride.gif'),
(0, 'War Golem', 0, 2550, 4300, 25, 1, '"Azerus barada nikto!", "Klonk klonk klonk", "Engaging Enemy!", "Threat level processed.", "Charging weapon systems!", "Auto repair in progress.", "The battle is joined!", "Termination initialized!", "Rrrtttarrrttarrrtta"', 'invisible, paralyze', 0, 0, 'undead', '<img src="images/items/8309.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/7893.gif" />&nbsp;&nbsp;<img src="images/items/9980.gif" />&nbsp;&nbsp;<img src="images/items/2645.gif" />&nbsp;&nbsp;<img src="images/items/5880.gif" />&nbsp;&nbsp;<img src="images/items/7403.gif" />&nbsp;&nbsp;<img src="images/items/7422.gif" />&nbsp;&nbsp;', 'wargolem.gif'),
(0, 'Worker Golem', 0, 1250, 1400, 25, 0, '"INTRUDER ALARM!", "klonk klonk klonk", "Rrrtttarrrttarrrtta", "Awaiting orders.", "Secret objective complete."', 'invisible, paralyze', 0, 0, 'undead', '<img src="images/items/8309.gif" />&nbsp;&nbsp;<img src="images/items/9690.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/5880.gif" />&nbsp;&nbsp;<img src="images/items/7591.gif" />&nbsp;&nbsp;<img src="images/items/8472.gif" />&nbsp;&nbsp;<img src="images/items/7452.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2145.gif" />&nbsp;&nbsp;<img src="images/items/7439.gif" />&nbsp;&nbsp;<img src="images/items/2177.gif" />&nbsp;&nbsp;<img src="images/items/9811.gif" />&nbsp;&nbsp;<img src="images/items/9808.gif" />&nbsp;&nbsp;<img src="images/items/2164.gif" />&nbsp;&nbsp;<img src="images/items/2391.gif" />&nbsp;&nbsp;<img src="images/items/9976.gif" />&nbsp;&nbsp;<img src="images/items/7428.gif" />&nbsp;&nbsp;<img src="images/items/2207.gif" />&nbsp;&nbsp;', 'workergolem.gif'),
(0, 'Zombie', 0, 280, 500, 1, 0, '"Mst.... klll....", "Whrrrr... ssss.... mmm.... grrrrl", "Dnnnt... cmmm... clsrrr....", "Httt.... hmnnsss..."', 'death, energy, ice, earth, lifedrain, paralyze', 0, 0, 'undead', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2381.gif" />&nbsp;&nbsp;<img src="images/items/2398.gif" />&nbsp;&nbsp;<img src="images/items/2457.gif" />&nbsp;&nbsp;<img src="images/items/2056.gif" />&nbsp;&nbsp;<img src="images/items/7620.gif" />&nbsp;&nbsp;<img src="images/items/9808.gif" />&nbsp;&nbsp;<img src="images/items/2205.gif" />&nbsp;&nbsp;', 'zombie.gif'),
(0, 'Pythius The Rotten', 0, 100, 8350, 40, 0, '"YOU''LL NEVER GET MY TREASURE!"', 'death, earth, fire, drown, lifedrain, paralyze, invisible', 0, 0, 'undead', '', 'pythiustherotten.gif'),
(0, 'Lavahole', 0, 1200, 9950, 1, 0, '', 'physical, energy, fire, poison, lifedrain, paralyze, outfit, drunk, invisible', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;', 'lavahole.gif'),
(0, 'Yalahari', 0, 5, 150, 24, 0, '"Welcome to Yalahar, outsider.", "Our wisdom and knowledge are unequalled in this world.", "One day Yalahar will return to its former glory.", "That knowledge would overburden your fragile mind."', 'paralyze, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;', 'yalahari.gif'),
(0, 'Diseased Dan', 0, 300, 2000, 15, 0, '"Tchhh!", "Slurp!"', 'paralyze, invisible', 0, 0, 'venom', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/8472.gif" />&nbsp;&nbsp;<img src="images/items/8473.gif" />&nbsp;&nbsp;<img src="images/items/8873.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/8912.gif" />&nbsp;&nbsp;<img src="images/items/2467.gif" />&nbsp;&nbsp;<img src="images/items/8891.gif" />&nbsp;&nbsp;', 'diseaseddan.gif'),
(0, 'Bandit', 450, 65, 245, 1, 0, '"Your money or your life!", "Hand me your purse!"', '', 1, 1, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2388.gif" />&nbsp;&nbsp;<img src="images/items/2386.gif" />&nbsp;&nbsp;<img src="images/items/2484.gif" />&nbsp;&nbsp;<img src="images/items/2530.gif" />&nbsp;&nbsp;<img src="images/items/2649.gif" />&nbsp;&nbsp;<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2787.gif" />&nbsp;&nbsp;', 'bandit.gif'),
(0, 'Seagull', 250, 0, 25, 1, 0, '', '', 1, 0, 'blood', '', 'seagull.gif'),
(0, 'Butterfly', 0, 0, 2, 40, 0, '', 'poison, paralyze, drunk', 0, 0, 'venom', '', 'butterfly.gif'),
(0, 'Undead Gladiator', 0, 800, 1000, 15, 0, '', 'invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;<img src="images/items/2470.gif" />&nbsp;&nbsp;<img src="images/items/6300.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2513.gif" />&nbsp;&nbsp;<img src="images/items/6500.gif" />&nbsp;&nbsp;<img src="images/items/2557.gif" />&nbsp;&nbsp;<img src="images/items/2558.gif" />&nbsp;&nbsp;<img src="images/items/5944.gif" />&nbsp;&nbsp;<img src="images/items/5801.gif" />&nbsp;&nbsp;<img src="images/items/5480.gif" />&nbsp;&nbsp;', 'undeadgladiator.gif'),
(0, 'The Incendier', 0, 2900, 25600, 40, 0, '', 'paralyze, invisible', 0, 0, 'fire', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2147.gif" />&nbsp;&nbsp;<img src="images/items/7894.gif" />&nbsp;&nbsp;<img src="images/items/7899.gif" />&nbsp;&nbsp;<img src="images/items/5944.gif" />&nbsp;&nbsp;<img src="images/items/2239.gif" />&nbsp;&nbsp;<img src="images/items/2136.gif" />&nbsp;&nbsp;<img src="images/items/2187.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2432.gif" />&nbsp;&nbsp;<img src="images/items/2145.gif" />&nbsp;&nbsp;<img src="images/items/2392.gif" />&nbsp;&nbsp;', 'theincendier.gif'),
(0, 'Bones', 0, 3750, 9500, 40, 0, '"Your new name is breakfast.", "Keep that dog away!", "Out Fluffy! Out! Bad dog!"', 'drunk, invisible', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/5741.gif" />&nbsp;&nbsp;<img src="images/items/6500.gif" />&nbsp;&nbsp;<img src="images/items/6570.gif" />&nbsp;&nbsp;<img src="images/items/6571.gif" />&nbsp;&nbsp;<img src="images/items/2472.gif" />&nbsp;&nbsp;<img src="images/items/6300.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/5944.gif" />&nbsp;&nbsp;<img src="images/items/4851.gif" />&nbsp;&nbsp;<img src="images/items/2207.gif" />&nbsp;&nbsp;<img src="images/items/7430.gif" />&nbsp;&nbsp;<img src="images/items/2413.gif" />&nbsp;&nbsp;', 'bones.gif'),
(0, 'Fluffy', 0, 3550, 4500, 45, 0, '"Wooof!"', 'drunk, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/5944.gif" />&nbsp;&nbsp;<img src="images/items/6570.gif" />&nbsp;&nbsp;<img src="images/items/6571.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;<img src="images/items/2230.gif" />&nbsp;&nbsp;<img src="images/items/6500.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2430.gif" />&nbsp;&nbsp;<img src="images/items/2383.gif" />&nbsp;&nbsp;<img src="images/items/6558.gif" />&nbsp;&nbsp;', 'fluffy.gif'),
(0, 'Grynch Clan Goblin', 0, 4, 80, 90, 1, '"T''was not me hand in your pocket!", "Look! Cool stuff in house. Let''s get it!", "Uhh! Nobody home!", "Me just borrowed it!", "Me no steal! Me found it!", "Me had it for five minutes. It''s family heirloom now!", "Nice human won''t hurt little, good goblin?", "Gimmegimme!", "Invite me in you lovely house plx!", "Other Goblin stole it!", "All presents mine!", "Me got ugly ones purse", "Free itans plz!", "Not me! Not me!", "Guys, help me here! Guys? Guys???", "That only much dust in me pocket! Honest!", "Can me have your stuff?", "Halp, Big dumb one is after me!", "Uh, So many shiny things!", "Utani hur hur hur!", "Mee? Stealing? Never!!!", "Oh what fun it is to steal a one-horse open sleigh!", "Must have it! Must have it!", "Where me put me lockpick?", "Catch me if you can!"', 'fire, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2676.gif" />&nbsp;&nbsp;<img src="images/items/6501.gif" />&nbsp;&nbsp;<img src="images/items/2675.gif" />&nbsp;&nbsp;<img src="images/items/2687.gif" />&nbsp;&nbsp;<img src="images/items/2679.gif" />&nbsp;&nbsp;<img src="images/items/2674.gif" />&nbsp;&nbsp;<img src="images/items/2678.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2695.gif" />&nbsp;&nbsp;<img src="images/items/2688.gif" />&nbsp;&nbsp;<img src="images/items/6394.gif" />&nbsp;&nbsp;<img src="images/items/6393.gif" />&nbsp;&nbsp;<img src="images/items/2111.gif" />&nbsp;&nbsp;<img src="images/items/6497.gif" />&nbsp;&nbsp;<img src="images/items/6277.gif" />&nbsp;&nbsp;<img src="images/items/1988.gif" />&nbsp;&nbsp;<img src="images/items/2260.gif" />&nbsp;&nbsp;<img src="images/items/2163.gif" />&nbsp;&nbsp;<img src="images/items/4839.gif" />&nbsp;&nbsp;<img src="images/items/1852.gif" />&nbsp;&nbsp;<img src="images/items/2172.gif" />&nbsp;&nbsp;<img src="images/items/1949.gif" />&nbsp;&nbsp;<img src="images/items/2661.gif" />&nbsp;&nbsp;<img src="images/items/5890.gif" />&nbsp;&nbsp;<img src="images/items/5894.gif" />&nbsp;&nbsp;<img src="images/items/5902.gif" />&nbsp;&nbsp;<img src="images/items/6091.gif" />&nbsp;&nbsp;<img src="images/items/2551.gif" />&nbsp;&nbsp;<img src="images/items/2114.gif" />&nbsp;&nbsp;<img src="images/items/5792.gif" />&nbsp;&nbsp;<img src="images/items/2560.gif" />&nbsp;&nbsp;<img src="images/items/1684.gif" />&nbsp;&nbsp;<img src="images/items/4873.gif" />&nbsp;&nbsp;<img src="images/items/2102.gif" />&nbsp;&nbsp;<img src="images/items/2159.gif" />&nbsp;&nbsp;<img src="images/items/5900.gif" />&nbsp;&nbsp;<img src="images/items/5022.gif" />&nbsp;&nbsp;<img src="images/items/2160.gif" />&nbsp;&nbsp;<img src="images/items/2534.gif" />&nbsp;&nbsp;', 'grynchclangoblin.gif'),
(0, 'Hacker', 0, 45, 430, 15, 1, '"Feel the wrath of me dos attack!", "You''re next!", "Gimme free gold!", "Me sooo smart!", "Me have a cheating link for you!", "Me is GM!", "Gimme your password!", "Me just need the code!", "Me not stink!", "Me other char is highlevel!"', 'energy, fire, poison, drunk', 0, 1, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;<img src="images/items/6570.gif" />&nbsp;&nbsp;<img src="images/items/6571.gif" />&nbsp;&nbsp;<img src="images/items/2044.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2381.gif" />&nbsp;&nbsp;<img src="images/items/2386.gif" />&nbsp;&nbsp;<img src="images/items/2391.gif" />&nbsp;&nbsp;<img src="images/items/2378.gif" />&nbsp;&nbsp;', 'hacker.gif'),
(0, 'Minishabaal', 0, 4000, 3500, 240, 1, '"I had Princess Lumelia as breakfast!", "Naaa-Nana-Naaa-Naaa!", "My brother will come and get you for this!", "Get them Fluffy!", "He He He!", "Pftt, Ferumbras such an upstart!", "My dragon is not that old, it''s just second hand!", "My other dragon is a red one!", "When I am big I want to become the ruthless eighth!", "WHERE''S FLUFFY?", "Muahaha!"', 'energy, fire, poison, lifedrain, paralyze, outfit, drunk, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2150.gif" />&nbsp;&nbsp;<img src="images/items/2548.gif" />&nbsp;&nbsp;<img src="images/items/2432.gif" />&nbsp;&nbsp;<img src="images/items/5944.gif" />&nbsp;&nbsp;<img src="images/items/2520.gif" />&nbsp;&nbsp;<img src="images/items/6500.gif" />&nbsp;&nbsp;<img src="images/items/2470.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2488.gif" />&nbsp;&nbsp;<img src="images/items/2515.gif" />&nbsp;&nbsp;<img src="images/items/2136.gif" />&nbsp;&nbsp;<img src="images/items/2542.gif" />&nbsp;&nbsp;', 'minishabaal.gif'),
(0, 'Primitive', 0, 45, 200, 40, 0, '"We don''t need a future!", "I''ll rook you all!", "They thought they''d beaten us!", "You are history!", "There can only be one world!", "Valor who?", "Die noob!", "There are no dragons!", "I''ll quit forever! Again ...", "You all are noobs!", "Beware of the cyclops!", "Just had a disconnect.", "Magic is only good for girls!", "We''ll be back!"', 'energy, fire, drunk, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2484.gif" />&nbsp;&nbsp;<img src="images/items/2482.gif" />&nbsp;&nbsp;<img src="images/items/2526.gif" />&nbsp;&nbsp;<img src="images/items/2385.gif" />&nbsp;&nbsp;<img src="images/items/2386.gif" />&nbsp;&nbsp;<img src="images/items/6570.gif" />&nbsp;&nbsp;<img src="images/items/6571.gif" />&nbsp;&nbsp;', 'primitive.gif'),
(0, 'Tibia Bug', 250, 50, 270, 10, 0, '"My father was a year 2k bug.", "Psst, I''ll make you rich.", "You are bugged ... by me!"', 'energy, fire, drunk', 1, 1, 'venom', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/6570.gif" />&nbsp;&nbsp;<img src="images/items/6571.gif" />&nbsp;&nbsp;', 'tibiabug.gif'),
(0, 'Undead Minion', 620, 550, 850, 5, 0, '', 'fire, poison, lifedrain, drunk', 0, 1, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2260.gif" />&nbsp;&nbsp;<img src="images/items/2417.gif" />&nbsp;&nbsp;<img src="images/items/2513.gif" />&nbsp;&nbsp;<img src="images/items/6570.gif" />&nbsp;&nbsp;<img src="images/items/6571.gif" />&nbsp;&nbsp;<img src="images/items/2515.gif" />&nbsp;&nbsp;', 'undeadminion.gif'),
(0, 'Amazon', 390, 60, 110, 1, 0, '"Yeeee ha!", "Your head shall be mine!"', '', 1, 1, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2467.gif" />&nbsp;&nbsp;<img src="images/items/2385.gif" />&nbsp;&nbsp;<img src="images/items/2229.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2691.gif" />&nbsp;&nbsp;<img src="images/items/2050.gif" />&nbsp;&nbsp;', 'amazon.gif'),
(0, 'Valkyrie', 450, 85, 190, 1, 0, '"Another head for me!", "Stand still!", "One more head for me!", "Head off!"', '', 1, 1, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2464.gif" />&nbsp;&nbsp;<img src="images/items/2125.gif" />&nbsp;&nbsp;<img src="images/items/2387.gif" />&nbsp;&nbsp;<img src="images/items/2458.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2674.gif" />&nbsp;&nbsp;<img src="images/items/3965.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/2147.gif" />&nbsp;&nbsp;<img src="images/items/2145.gif" />&nbsp;&nbsp;<img src="images/items/2200.gif" />&nbsp;&nbsp;<img src="images/items/2463.gif" />&nbsp;&nbsp;', 'valkyrie.gif'),
(0, 'Xenia', 450, 255, 290, 1, 0, '"Stand still!", "One more head for me!", "Head off!"', '', 0, 1, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2420.gif" />&nbsp;&nbsp;<img src="images/items/2463.gif" />&nbsp;&nbsp;', 'xenia.gif'),
(0, 'Carrion Worm', 280, 70, 145, 1, 0, '', '', 0, 1, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2530.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2398.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;<img src="images/items/2376.gif" />&nbsp;&nbsp;<img src="images/items/2463.gif" />&nbsp;&nbsp;', 'carrionworm.gif'),
(0, 'Rotworm', 0, 40, 65, 1, 0, '', '', 0, 1, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2480.gif" />&nbsp;&nbsp;<img src="images/items/2530.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2398.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;<img src="images/items/2376.gif" />&nbsp;&nbsp;<img src="images/items/2412.gif" />&nbsp;&nbsp;', 'rotworm.gif'),
(0, 'Rotworm Queen', 0, 85, 105, 1, 0, '"..."', '', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/3976.gif" />&nbsp;&nbsp;', 'rotwormqueen.gif'),
(0, 'Kongra', 0, 115, 340, 1, 1, '"Hugah!", "Ungh! Ungh!", "Huaauaauaauaa!"', '', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/1294.gif" />&nbsp;&nbsp;<img src="images/items/5883.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2676.gif" />&nbsp;&nbsp;<img src="images/items/2200.gif" />&nbsp;&nbsp;<img src="images/items/2209.gif" />&nbsp;&nbsp;<img src="images/items/2166.gif" />&nbsp;&nbsp;<img src="images/items/2463.gif" />&nbsp;&nbsp;', 'kongra.gif'),
(0, 'Hairman The Huge', 0, 335, 600, 5, 1, '"Hugah!", "Ungh! Ungh!", "Huaauaauaauaa!"', 'invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/5883.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2676.gif" />&nbsp;&nbsp;<img src="images/items/2200.gif" />&nbsp;&nbsp;<img src="images/items/2166.gif" />&nbsp;&nbsp;<img src="images/items/2463.gif" />&nbsp;&nbsp;', 'hairmanthehuge.gif'),
(0, 'Merlkin', 0, 145, 230, 1, 0, '"Ugh! Ugh! Ugh!", "Holy banana!", "Chakka! Chakka!"', 'invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2150.gif" />&nbsp;&nbsp;<img src="images/items/2675.gif" />&nbsp;&nbsp;<img src="images/items/5883.gif" />&nbsp;&nbsp;<img src="images/items/2676.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/3966.gif" />&nbsp;&nbsp;<img src="images/items/2188.gif" />&nbsp;&nbsp;<img src="images/items/2162.gif" />&nbsp;&nbsp;', 'merlkin.gif'),
(0, 'Sibang', 0, 115, 225, 1, 1, '"Eeeeek! Eeeeek", "Huh! Huh! Huh!", "Ahhuuaaa!"', 'invisible', 0, 0, 'blood', '<img src="images/items/2678.gif" />&nbsp;&nbsp;<img src="images/items/5883.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2675.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2682.gif" />&nbsp;&nbsp;<img src="images/items/1294.gif" />&nbsp;&nbsp;', 'sibang.gif'),
(0, 'Crystal Spider', 0, 900, 1250, 35, 1, '"Screeech!"', 'ice, fire, paralyze, drunk, invisible', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2463.gif" />&nbsp;&nbsp;<img src="images/items/2476.gif" />&nbsp;&nbsp;<img src="images/items/2457.gif" />&nbsp;&nbsp;<img src="images/items/2171.gif" />&nbsp;&nbsp;<img src="images/items/7437.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/7449.gif" />&nbsp;&nbsp;<img src="images/items/2477.gif" />&nbsp;&nbsp;<img src="images/items/7364.gif" />&nbsp;&nbsp;<img src="images/items/7290.gif" />&nbsp;&nbsp;<img src="images/items/7441.gif" />&nbsp;&nbsp;<img src="images/items/7902.gif" />&nbsp;&nbsp;', 'crystalspider.gif'),
(0, 'Giant Spider', 0, 900, 1300, 25, 1, '', 'earth, invisible', 0, 0, 'VENOM', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2463.gif" />&nbsp;&nbsp;<img src="images/items/2171.gif" />&nbsp;&nbsp;<img src="images/items/2459.gif" />&nbsp;&nbsp;<img src="images/items/5879.gif" />&nbsp;&nbsp;<img src="images/items/7901.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2545.gif" />&nbsp;&nbsp;<img src="images/items/2457.gif" />&nbsp;&nbsp;<img src="images/items/2476.gif" />&nbsp;&nbsp;<img src="images/items/2477.gif" />&nbsp;&nbsp;<img src="images/items/2478.gif" />&nbsp;&nbsp;<img src="images/items/2169.gif" />&nbsp;&nbsp;', 'giantspider.gif'),
(0, 'Poison Spider', 270, 22, 26, 1, 0, '', 'earth', 1, 1, 'VENOM', '<img src="images/items/2148.gif" />&nbsp;&nbsp;', 'poisonspider.gif'),
(0, 'Scorpion', 310, 45, 45, 1, 0, '', 'earth', 1, 1, 'VENOM', '', 'scorpion.gif'),
(0, 'Spider', 210, 12, 20, 1, 0, '', '', 1, 1, 'VENOM', '<img src="images/items/2148.gif" />&nbsp;&nbsp;', 'spider.gif'),
(0, 'Tarantula', 485, 120, 225, 30, 1, '', '', 1, 1, 'VENOM', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2478.gif" />&nbsp;&nbsp;<img src="images/items/2463.gif" />&nbsp;&nbsp;<img src="images/items/2457.gif" />&nbsp;&nbsp;<img src="images/items/2169.gif" />&nbsp;&nbsp;', 'tarantula.gif'),
(0, 'The Old Widow', 0, 2800, 3200, 50, 1, '', 'earth, fire, invisible', 0, 0, 'venom', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2463.gif" />&nbsp;&nbsp;<img src="images/items/2171.gif" />&nbsp;&nbsp;<img src="images/items/2459.gif" />&nbsp;&nbsp;<img src="images/items/5879.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2457.gif" />&nbsp;&nbsp;<img src="images/items/2476.gif" />&nbsp;&nbsp;<img src="images/items/2477.gif" />&nbsp;&nbsp;<img src="images/items/2478.gif" />&nbsp;&nbsp;<img src="images/items/2169.gif" />&nbsp;&nbsp;', 'theoldwidow.gif'),
(0, 'Drasilla', 0, 700, 1000, 1, 0, '"FCHHHHHHHH!", "GROOOOAAAAAAAAR!"', 'fire, poison, drunk, invisible', 0, 0, 'blood', '', 'drasilla.gif'),
(0, 'Grimgor Guteater', 0, 670, 1115, 10, 0, '"Renat Ulderek.", "Ikem Rambo Zambo."', 'fire, poison, invisible', 0, 0, 'blood', '', 'grimgorguteater.gif'),
(0, 'Slim', 0, 580, 1025, 1, 0, '"Knooorrr!"', 'poison, paralyze', 0, 0, 'undead', '', 'slim.gif'),
(0, 'Spirit Of Earth', 0, 800, 1285, 1, 0, '', 'fire, poison, paralyze, drunk', 0, 1, 'undead', '', 'spiritofearth.gif'),
(0, 'Spirit Of Fire', 0, 950, 2140, 1, 0, '', 'fire, poison, lifedrain, paralyze, outfit, drunk, invisible', 0, 0, 'blood', '', 'spiritoffire.gif'),
(0, 'Spirit Of Water', 0, 850, 1430, 1, 0, '', 'fire, poison, paralyze, invisible', 0, 0, 'undead', '', 'spiritofwater.gif'),
(0, 'Darakan The Executioner', 0, 1600, 3500, 18, 0, '"FIGHT LIKE A BARBARIAN!", "VICTORY IS MINE!", "I AM your father!", "To be the man you have to beat the man!"', 'invisible', 0, 1, 'blood', '', 'darakantheexecutioner.gif'),
(0, 'Deathbringer', 0, 5100, 10000, 40, 0, '"YOU FOOLS WILL PAY!", "YOU ALL WILL DIE!!", "DEATH, DESTRUCTION!", "I will eat your soul!"', 'death, energy, invisible', 0, 0, 'undead', '', 'deathbringer.gif'),
(0, 'Gnorre Chyllson', 0, 4000, 7100, 80, 0, '"I am like the merciless northwind", "Snow will be your death shroud."', 'earth, ice, fire, paralyze, invisible', 0, 0, 'blood', '', 'gnorrechyllson.gif'),
(0, 'Norgle Glacierbeard', 0, 2100, 4300, 23, 0, '"I''ll extinguish you warmbloods.", "REVENGE!", "Far too hot.", "Revenge is sweetest when served cold."', 'invisible', 0, 1, 'undead', '', 'norgleglacierbeard.gif'),
(0, 'Svoren The Mad', 0, 3000, 6300, 20, 0, '"NO mommy NO. Leave me alone!"', 'energy, fire, poison', 0, 1, 'blood', '', 'svorenthemad.gif'),
(0, 'The Masked Marauder', 0, 3500, 6800, 15, 0, '"Didn''t you leave your house door open?", "Oops, your shoelaces are open!"', 'fire, paralyze, invisible', 0, 0, 'blood', '', 'themaskedmarauder.gif'),
(0, 'The Obliverator', 0, 6000, 10500, 30, 0, '"NO ONE WILL BEAT ME!"', 'fire, invisible', 0, 0, 'fire', '', 'theobliverator.gif'),
(0, 'The Pit Lord', 0, 2500, 4500, 30, 1, '"I''LL GET YOU ALL!", "I won''t let you escape!", "I''ll crush you beneath my feet!"', 'invisible', 0, 0, 'blood', '', 'thepitlord.gif'),
(0, 'Webster', 0, 1200, 1750, 40, 0, '"You are lost!", "Come my little morsel."', 'ice, invisible', 0, 0, 'undead', '', 'webster.gif');
INSERT INTO `z_monsters` (`hide_creature`, `name`, `mana`, `exp`, `health`, `speed_lvl`, `use_haste`, `voices`, `immunities`, `summonable`, `convinceable`, `race`, `loot`, `gfx_name`) VALUES
(0, 'Barbarian Bloodwalker', 590, 195, 305, 1, 1, '"YAAAHEEE!", "SLAUGHTER!", "CARNAGE!"', 'drunk, invisible', 0, 1, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;<img src="images/items/2381.gif" />&nbsp;&nbsp;<img src="images/items/2378.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2458.gif" />&nbsp;&nbsp;<img src="images/items/2050.gif" />&nbsp;&nbsp;<img src="images/items/2464.gif" />&nbsp;&nbsp;<img src="images/items/7457.gif" />&nbsp;&nbsp;<img src="images/items/5911.gif" />&nbsp;&nbsp;<img src="images/items/7290.gif" />&nbsp;&nbsp;<img src="images/items/3962.gif" />&nbsp;&nbsp;', 'barbarianbloodwalker.gif'),
(0, 'Barbarian Brutetamer', 0, 115, 145, 10, 0, '"To me, creatures of the wild!", "My instincts tell me about your cowardice."', 'lifedrain, paralyze, drunk, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2686.gif" />&nbsp;&nbsp;<img src="images/items/2464.gif" />&nbsp;&nbsp;<img src="images/items/2401.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;<img src="images/items/7343.gif" />&nbsp;&nbsp;<img src="images/items/7463.gif" />&nbsp;&nbsp;<img src="images/items/3965.gif" />&nbsp;&nbsp;<img src="images/items/7457.gif" />&nbsp;&nbsp;<img src="images/items/7379.gif" />&nbsp;&nbsp;<img src="images/items/7464.gif" />&nbsp;&nbsp;', 'barbarianbrutetamer.gif'),
(0, 'Barbarian Headsplitter', 0, 85, 100, 15, 0, '"I will regain my honor with your blood!", "Surrender is not option!", "Its you or me!"', 'poison, paralyze', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2111.gif" />&nbsp;&nbsp;<img src="images/items/2473.gif" />&nbsp;&nbsp;<img src="images/items/7457.gif" />&nbsp;&nbsp;<img src="images/items/2460.gif" />&nbsp;&nbsp;<img src="images/items/2403.gif" />&nbsp;&nbsp;<img src="images/items/5913.gif" />&nbsp;&nbsp;<img src="images/items/2050.gif" />&nbsp;&nbsp;<img src="images/items/7449.gif" />&nbsp;&nbsp;<img src="images/items/7461.gif" />&nbsp;&nbsp;<img src="images/items/2320.gif" />&nbsp;&nbsp;', 'barbarianheadsplitter.gif'),
(0, 'Barbarian Skullhunter', 0, 85, 135, 25, 0, '"You will become my trophy.", "Fight harder, coward.", "Show that you are a worthy opponent."', 'drunk, paralyze', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2403.gif" />&nbsp;&nbsp;<img src="images/items/2460.gif" />&nbsp;&nbsp;<img src="images/items/2050.gif" />&nbsp;&nbsp;<img src="images/items/2168.gif" />&nbsp;&nbsp;<img src="images/items/7462.gif" />&nbsp;&nbsp;<img src="images/items/7449.gif" />&nbsp;&nbsp;', 'barbarianskullhunter.gif'),
(0, 'Barbaria', 0, 355, 555, 30, 0, '"To me, creatures of the wild!", "My instincts tell me about your cowardice."', 'lifedrain, paralyze, drunk, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2686.gif" />&nbsp;&nbsp;<img src="images/items/2464.gif" />&nbsp;&nbsp;<img src="images/items/2401.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;<img src="images/items/7343.gif" />&nbsp;&nbsp;<img src="images/items/7463.gif" />&nbsp;&nbsp;<img src="images/items/3965.gif" />&nbsp;&nbsp;<img src="images/items/7457.gif" />&nbsp;&nbsp;<img src="images/items/7379.gif" />&nbsp;&nbsp;<img src="images/items/7464.gif" />&nbsp;&nbsp;', 'barbaria.gif'),
(0, 'Bear', 300, 23, 80, 1, 0, '"grrrr", "groar"', '', 1, 1, 'blood', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;<img src="images/items/5902.gif" />&nbsp;&nbsp;<img src="images/items/5896.gif" />&nbsp;&nbsp;', 'bear.gif'),
(0, 'Panda', 300, 23, 80, 10, 0, '"Grrrr", "Groar"', 'earth', 1, 1, 'blood', '<img src="images/items/2671.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/3976.gif" />&nbsp;&nbsp;', 'panda.gif'),
(0, 'Polar Bear', 315, 28, 85, 1, 0, '"Grrrrrr", "GROARRR!"', '', 1, 1, 'blood', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;', 'polarbear.gif'),
(0, 'Braindeath', 0, 895, 1225, 25, 0, '"You have disturbed my thoughts!", "Let me turn you into something more useful!", "Let me taste your brain!", "You will be punished!"', 'earth, death, invisible', 0, 0, 'undead', '<img src="images/items/2509.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2445.gif" />&nbsp;&nbsp;<img src="images/items/2397.gif" />&nbsp;&nbsp;<img src="images/items/2518.gif" />&nbsp;&nbsp;<img src="images/items/2181.gif" />&nbsp;&nbsp;<img src="images/items/3972.gif" />&nbsp;&nbsp;<img src="images/items/2451.gif" />&nbsp;&nbsp;<img src="images/items/5898.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2377.gif" />&nbsp;&nbsp;<img src="images/items/2175.gif" />&nbsp;&nbsp;<img src="images/items/2394.gif" />&nbsp;&nbsp;<img src="images/items/2423.gif" />&nbsp;&nbsp;<img src="images/items/2391.gif" />&nbsp;&nbsp;', 'braindeath.gif'),
(0, 'Beholder', 0, 170, 260, 1, 0, '"Eye for eye!", "Here''s looking at you!", "Let me take a look at you!", "You''ve got the look!"', 'poison, lifedrain, outfit, drunk, invisible', 0, 0, 'VENOM', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2175.gif" />&nbsp;&nbsp;<img src="images/items/2181.gif" />&nbsp;&nbsp;<img src="images/items/2509.gif" />&nbsp;&nbsp;<img src="images/items/2377.gif" />&nbsp;&nbsp;<img src="images/items/3972.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2512.gif" />&nbsp;&nbsp;<img src="images/items/2394.gif" />&nbsp;&nbsp;<img src="images/items/2518.gif" />&nbsp;&nbsp;<img src="images/items/2397.gif" />&nbsp;&nbsp;<img src="images/items/5898.gif" />&nbsp;&nbsp;', 'beholder.gif'),
(0, 'Elder Beholder', 0, 280, 1100, 25, 0, '"Let me take a look at you!", "Inferior creatures, bow before my power!"', 'poison, lifedrain, outfit, drunk, invisible', 0, 0, 'blood', '<img src="images/items/2509.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2445.gif" />&nbsp;&nbsp;<img src="images/items/2397.gif" />&nbsp;&nbsp;<img src="images/items/2518.gif" />&nbsp;&nbsp;<img src="images/items/2181.gif" />&nbsp;&nbsp;<img src="images/items/3972.gif" />&nbsp;&nbsp;<img src="images/items/2451.gif" />&nbsp;&nbsp;<img src="images/items/5898.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2377.gif" />&nbsp;&nbsp;<img src="images/items/2175.gif" />&nbsp;&nbsp;<img src="images/items/2394.gif" />&nbsp;&nbsp;<img src="images/items/2423.gif" />&nbsp;&nbsp;<img src="images/items/2391.gif" />&nbsp;&nbsp;', 'elderbeholder.gif'),
(0, 'Gazer', 0, 90, 120, 10, 1, '"Mommy!?", "Buuuuhaaaahhaaaaa!", "Me need mana!"', 'poison, lifedrain, outfit, drunk, invisible', 0, 0, 'VENOM', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2050.gif" />&nbsp;&nbsp;<img src="images/items/2483.gif" />&nbsp;&nbsp;<img src="images/items/2473.gif" />&nbsp;&nbsp;<img src="images/items/2398.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2460.gif" />&nbsp;&nbsp;<img src="images/items/2229.gif" />&nbsp;&nbsp;<img src="images/items/2403.gif" />&nbsp;&nbsp;<img src="images/items/2168.gif" />&nbsp;&nbsp;<img src="images/items/3972.gif" />&nbsp;&nbsp;', 'gazer.gif'),
(0, 'The Evil Eye', 0, 1500, 1200, 10, 0, '"653768764!", "Let me take a look at you!", "Inferior creatures, bow before my power!", "659978 54764!"', 'poison, lifedrain, paralyze, outfit, drunk, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2445.gif" />&nbsp;&nbsp;<img src="images/items/2451.gif" />&nbsp;&nbsp;<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/5898.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2423.gif" />&nbsp;&nbsp;<img src="images/items/2391.gif" />&nbsp;&nbsp;', 'theevileye.gif'),
(0, 'Eye Of The Seven', 0, 90, 1, 1, 0, '', 'physical, holy, energy, fire, death, earth, ice, poison, lifedrain', 0, 0, 'VENOM', '', 'eyeoftheseven.gif'),
(0, 'Carniphila', 0, 150, 255, 1, 0, '', 'earth, invisible', 0, 0, 'VENOM', '<img src="images/items/2804.gif" />&nbsp;&nbsp;<img src="images/items/2802.gif" />&nbsp;&nbsp;<img src="images/items/2792.gif" />&nbsp;&nbsp;<img src="images/items/7732.gif" />&nbsp;&nbsp;', 'carniphila.gif'),
(0, 'Spit Nettle', 0, 20, 150, 1, 0, '', 'energy, poison, lifedrain, paralyze, outfit, drunk, invisible', 0, 0, 'venom', '', 'spitnettle.gif'),
(0, 'The Abomination', 0, 25000, 38050, 60, 0, '"Blubb"', 'earth, energy, invisible', 0, 0, 'venom', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2152.gif" />&nbsp;&nbsp;<img src="images/items/6500.gif" />&nbsp;&nbsp;<img src="images/items/5944.gif" />&nbsp;&nbsp;', 'theabomination.gif'),
(0, 'Son Of Verminor', 0, 5900, 8500, 1, 0, '"Blub!", "Blub! Blub!", "Come''on Daddy! Help me"', 'poison, paralyze, outfit, drunk, invisible', 0, 0, 'venom', '', 'sonofverminor.gif'),
(0, 'Defiler', 0, 3700, 3650, 13, 0, '"Blubb"', 'earth, paralyze, invisible', 0, 0, 'venom', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2152.gif" />&nbsp;&nbsp;<img src="images/items/6500.gif" />&nbsp;&nbsp;<img src="images/items/5944.gif" />&nbsp;&nbsp;<img src="images/items/2147.gif" />&nbsp;&nbsp;<img src="images/items/2149.gif" />&nbsp;&nbsp;', 'defiler.gif'),
(0, 'Slime2', 0, 260, 150, 1, 0, '"Blubb"', 'poison', 0, 0, 'VENOM', '', 'slime2.gif'),
(0, 'Slime', 0, 160, 150, 1, 0, '', 'earth', 0, 0, 'VENOM', '', 'slime.gif'),
(0, 'Bog Raider', 0, 800, 1300, 40, 0, '"Tchhh!", "Slurp!"', 'paralyze, invisible', 0, 0, 'venom', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/8473.gif" />&nbsp;&nbsp;<img src="images/items/8472.gif" />&nbsp;&nbsp;<img src="images/items/8872.gif" />&nbsp;&nbsp;<img src="images/items/8912.gif" />&nbsp;&nbsp;<img src="images/items/8873.gif" />&nbsp;&nbsp;<img src="images/items/8891.gif" />&nbsp;&nbsp;', 'bograider.gif'),
(0, 'Tiquandas Revenge', 0, 2635, 2400, 5, 1, '', 'earth, invisible', 0, 0, 'VENOM', '<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/2804.gif" />&nbsp;&nbsp;<img src="images/items/2802.gif" />&nbsp;&nbsp;<img src="images/items/2792.gif" />&nbsp;&nbsp;<img src="images/items/5015.gif" />&nbsp;&nbsp;<img src="images/items/7732.gif" />&nbsp;&nbsp;', 'tiquandasrevenge.gif'),
(0, 'Chicken', 220, 0, 15, 1, 0, '"gokgoooook", "cluck cluck"', '', 1, 1, 'blood', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2695.gif" />&nbsp;&nbsp;<img src="images/items/5890.gif" />&nbsp;&nbsp;', 'chicken.gif'),
(0, 'Dire Penguin', 0, 120, 173, 1, 0, '', 'fire, outfit', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2669.gif" />&nbsp;&nbsp;', 'direpenguin.gif'),
(0, 'Flamingo', 250, 0, 25, 1, 0, '', '', 1, 1, 'blood', '<img src="images/items/3976.gif" />&nbsp;&nbsp;', 'flamingo.gif'),
(0, 'Penguin', 300, 1, 33, 1, 0, '', '', 1, 1, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2669.gif" />&nbsp;&nbsp;<img src="images/items/2667.gif" />&nbsp;&nbsp;', 'penguin.gif'),
(0, 'Terror Bird', 490, 150, 300, 30, 0, '"CRAAAHHH!", "Gruuuh Gruuuh.", "Carrah Carrah!"', '', 1, 1, 'blood', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2406.gif" />&nbsp;&nbsp;<img src="images/items/2209.gif" />&nbsp;&nbsp;<img src="images/items/2463.gif" />&nbsp;&nbsp;<img src="images/items/2490.gif" />&nbsp;&nbsp;<img src="images/items/2129.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2513.gif" />&nbsp;&nbsp;<img src="images/items/2511.gif" />&nbsp;&nbsp;<img src="images/items/2381.gif" />&nbsp;&nbsp;<img src="images/items/3970.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;', 'terrorbird.gif'),
(0, 'Bazir', 0, 30000, 110000, 155, 1, '"COME HERE! FREE ITEMS FOR EVERYONE!", "BOW TO THE POWER OF THE RUTHLESS SEVEN!", "Slay your friends and I will spare you!", "DON''T BE AFRAID! I AM COMING IN PEACE!"', 'energy, fire, poison, lifedrain, paralyze, outfit, drunk, invisible', 0, 0, 'fire', '<img src="images/items/2142.gif" />&nbsp;&nbsp;<img src="images/items/2231.gif" />&nbsp;&nbsp;<img src="images/items/2144.gif" />&nbsp;&nbsp;<img src="images/items/2158.gif" />&nbsp;&nbsp;<img src="images/items/2195.gif" />&nbsp;&nbsp;<img src="images/items/2186.gif" />&nbsp;&nbsp;<img src="images/items/2192.gif" />&nbsp;&nbsp;<img src="images/items/2125.gif" />&nbsp;&nbsp;<img src="images/items/2124.gif" />&nbsp;&nbsp;<img src="images/items/2520.gif" />&nbsp;&nbsp;<img src="images/items/2462.gif" />&nbsp;&nbsp;<img src="images/items/2387.gif" />&nbsp;&nbsp;<img src="images/items/2434.gif" />&nbsp;&nbsp;<img src="images/items/2167.gif" />&nbsp;&nbsp;<img src="images/items/2432.gif" />&nbsp;&nbsp;<img src="images/items/2393.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2179.gif" />&nbsp;&nbsp;<img src="images/items/2470.gif" />&nbsp;&nbsp;<img src="images/items/2033.gif" />&nbsp;&nbsp;<img src="images/items/2418.gif" />&nbsp;&nbsp;<img src="images/items/2182.gif" />&nbsp;&nbsp;<img src="images/items/2155.gif" />&nbsp;&nbsp;<img src="images/items/2188.gif" />&nbsp;&nbsp;<img src="images/items/2396.gif" />&nbsp;&nbsp;<img src="images/items/2177.gif" />&nbsp;&nbsp;<img src="images/items/2162.gif" />&nbsp;&nbsp;<img src="images/items/2472.gif" />&nbsp;&nbsp;<img src="images/items/2514.gif" />&nbsp;&nbsp;<img src="images/items/2164.gif" />&nbsp;&nbsp;<img src="images/items/2178.gif" />&nbsp;&nbsp;<img src="images/items/2176.gif" />&nbsp;&nbsp;<img src="images/items/2171.gif" />&nbsp;&nbsp;<img src="images/items/2200.gif" />&nbsp;&nbsp;<img src="images/items/1982.gif" />&nbsp;&nbsp;<img src="images/items/2214.gif" />&nbsp;&nbsp;<img src="images/items/2123.gif" />&nbsp;&nbsp;<img src="images/items/2170.gif" />&nbsp;&nbsp;<img src="images/items/2402.gif" />&nbsp;&nbsp;<img src="images/items/2436.gif" />&nbsp;&nbsp;<img src="images/items/2150.gif" />&nbsp;&nbsp;<img src="images/items/2145.gif" />&nbsp;&nbsp;<img src="images/items/2149.gif" />&nbsp;&nbsp;<img src="images/items/2146.gif" />&nbsp;&nbsp;<img src="images/items/2165.gif" />&nbsp;&nbsp;<img src="images/items/2197.gif" />&nbsp;&nbsp;<img src="images/items/2174.gif" />&nbsp;&nbsp;<img src="images/items/2151.gif" />&nbsp;&nbsp;<img src="images/items/2112.gif" />&nbsp;&nbsp;<img src="images/items/2421.gif" />&nbsp;&nbsp;<img src="images/items/2377.gif" />&nbsp;&nbsp;<img src="images/items/3955.gif" />&nbsp;&nbsp;<img src="images/items/2185.gif" />&nbsp;&nbsp;<img src="images/items/2143.gif" />&nbsp;&nbsp;', 'bazir.gif'),
(0, 'Infernatil', 0, 85000, 270000, 193, 1, '"Worship Zathroth pathetic mortal!", "Your soul will be mine!", "ASHES TO ASHES!", "YOU WILL ALL BURN!", "THE DAY OF RECKONING IS AT HAND!", "BOW TO THE POWER OF THE RUTHLESS SEVEN!"', 'energy, fire, poison, lifedrain, paralyze, outfit, drunk, invisible', 0, 0, 'fire', '<img src="images/items/2142.gif" />&nbsp;&nbsp;<img src="images/items/2231.gif" />&nbsp;&nbsp;<img src="images/items/2144.gif" />&nbsp;&nbsp;<img src="images/items/2158.gif" />&nbsp;&nbsp;<img src="images/items/2195.gif" />&nbsp;&nbsp;<img src="images/items/2192.gif" />&nbsp;&nbsp;<img src="images/items/2125.gif" />&nbsp;&nbsp;<img src="images/items/2124.gif" />&nbsp;&nbsp;<img src="images/items/2520.gif" />&nbsp;&nbsp;<img src="images/items/2462.gif" />&nbsp;&nbsp;<img src="images/items/2387.gif" />&nbsp;&nbsp;<img src="images/items/2434.gif" />&nbsp;&nbsp;<img src="images/items/2167.gif" />&nbsp;&nbsp;<img src="images/items/2432.gif" />&nbsp;&nbsp;<img src="images/items/2393.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2179.gif" />&nbsp;&nbsp;<img src="images/items/2470.gif" />&nbsp;&nbsp;<img src="images/items/2033.gif" />&nbsp;&nbsp;<img src="images/items/2418.gif" />&nbsp;&nbsp;<img src="images/items/2155.gif" />&nbsp;&nbsp;<img src="images/items/2396.gif" />&nbsp;&nbsp;<img src="images/items/2177.gif" />&nbsp;&nbsp;<img src="images/items/2162.gif" />&nbsp;&nbsp;<img src="images/items/2472.gif" />&nbsp;&nbsp;<img src="images/items/2514.gif" />&nbsp;&nbsp;<img src="images/items/2164.gif" />&nbsp;&nbsp;<img src="images/items/2178.gif" />&nbsp;&nbsp;<img src="images/items/2186.gif" />&nbsp;&nbsp;<img src="images/items/2176.gif" />&nbsp;&nbsp;<img src="images/items/2171.gif" />&nbsp;&nbsp;<img src="images/items/2200.gif" />&nbsp;&nbsp;<img src="images/items/1982.gif" />&nbsp;&nbsp;<img src="images/items/2214.gif" />&nbsp;&nbsp;<img src="images/items/2123.gif" />&nbsp;&nbsp;<img src="images/items/2170.gif" />&nbsp;&nbsp;<img src="images/items/2402.gif" />&nbsp;&nbsp;<img src="images/items/2436.gif" />&nbsp;&nbsp;<img src="images/items/2150.gif" />&nbsp;&nbsp;<img src="images/items/2145.gif" />&nbsp;&nbsp;<img src="images/items/2149.gif" />&nbsp;&nbsp;<img src="images/items/2146.gif" />&nbsp;&nbsp;<img src="images/items/2182.gif" />&nbsp;&nbsp;<img src="images/items/2165.gif" />&nbsp;&nbsp;<img src="images/items/2197.gif" />&nbsp;&nbsp;<img src="images/items/2174.gif" />&nbsp;&nbsp;<img src="images/items/2151.gif" />&nbsp;&nbsp;<img src="images/items/2112.gif" />&nbsp;&nbsp;<img src="images/items/2421.gif" />&nbsp;&nbsp;<img src="images/items/2377.gif" />&nbsp;&nbsp;<img src="images/items/2185.gif" />&nbsp;&nbsp;<img src="images/items/3955.gif" />&nbsp;&nbsp;<img src="images/items/2188.gif" />&nbsp;&nbsp;<img src="images/items/2143.gif" />&nbsp;&nbsp;', 'infernatil.gif'),
(0, 'Zoralurk', 0, 30000, 55000, 90, 1, '"I AM ZORALURK, THE DEMON WITH A THOUSAND FACES!", "BRING IT, COCKROACHES!"', 'energy, fire, poison, lifedrain, paralyze, outfit, drunk, invisible', 0, 0, 'UNDEAD', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2143.gif" />&nbsp;&nbsp;<img src="images/items/2407.gif" />&nbsp;&nbsp;<img src="images/items/6530.gif" />&nbsp;&nbsp;<img src="images/items/7342.gif" />&nbsp;&nbsp;<img src="images/items/2641.gif" />&nbsp;&nbsp;<img src="images/items/2393.gif" />&nbsp;&nbsp;<img src="images/items/2195.gif" />&nbsp;&nbsp;<img src="images/items/2408.gif" />&nbsp;&nbsp;', 'zoralurk.gif'),
(0, 'Apocalypse', 0, 35000, 80000, 80, 1, '"BOW TO THE POWER OF THE RUTHLESS SEVEN!", "DESTRUCTION!", "CHAOS!", "DEATH TO ALL!"', 'energy, fire, poison, lifedrain, paralyze, outfit, drunk, invisible', 0, 0, 'fire', '<img src="images/items/2142.gif" />&nbsp;&nbsp;<img src="images/items/2231.gif" />&nbsp;&nbsp;<img src="images/items/2144.gif" />&nbsp;&nbsp;<img src="images/items/2158.gif" />&nbsp;&nbsp;<img src="images/items/2195.gif" />&nbsp;&nbsp;<img src="images/items/2192.gif" />&nbsp;&nbsp;<img src="images/items/2125.gif" />&nbsp;&nbsp;<img src="images/items/2124.gif" />&nbsp;&nbsp;<img src="images/items/2520.gif" />&nbsp;&nbsp;<img src="images/items/2462.gif" />&nbsp;&nbsp;<img src="images/items/2387.gif" />&nbsp;&nbsp;<img src="images/items/2434.gif" />&nbsp;&nbsp;<img src="images/items/2167.gif" />&nbsp;&nbsp;<img src="images/items/2432.gif" />&nbsp;&nbsp;<img src="images/items/2393.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2179.gif" />&nbsp;&nbsp;<img src="images/items/2470.gif" />&nbsp;&nbsp;<img src="images/items/2033.gif" />&nbsp;&nbsp;<img src="images/items/2418.gif" />&nbsp;&nbsp;<img src="images/items/2155.gif" />&nbsp;&nbsp;<img src="images/items/2396.gif" />&nbsp;&nbsp;<img src="images/items/2177.gif" />&nbsp;&nbsp;<img src="images/items/2162.gif" />&nbsp;&nbsp;<img src="images/items/2472.gif" />&nbsp;&nbsp;<img src="images/items/2514.gif" />&nbsp;&nbsp;<img src="images/items/2164.gif" />&nbsp;&nbsp;<img src="images/items/2178.gif" />&nbsp;&nbsp;<img src="images/items/2186.gif" />&nbsp;&nbsp;<img src="images/items/2176.gif" />&nbsp;&nbsp;<img src="images/items/2171.gif" />&nbsp;&nbsp;<img src="images/items/2200.gif" />&nbsp;&nbsp;<img src="images/items/1982.gif" />&nbsp;&nbsp;<img src="images/items/2214.gif" />&nbsp;&nbsp;<img src="images/items/2123.gif" />&nbsp;&nbsp;<img src="images/items/2170.gif" />&nbsp;&nbsp;<img src="images/items/2402.gif" />&nbsp;&nbsp;<img src="images/items/2436.gif" />&nbsp;&nbsp;<img src="images/items/2150.gif" />&nbsp;&nbsp;<img src="images/items/2145.gif" />&nbsp;&nbsp;<img src="images/items/2149.gif" />&nbsp;&nbsp;<img src="images/items/2146.gif" />&nbsp;&nbsp;<img src="images/items/2182.gif" />&nbsp;&nbsp;<img src="images/items/2165.gif" />&nbsp;&nbsp;<img src="images/items/2197.gif" />&nbsp;&nbsp;<img src="images/items/2174.gif" />&nbsp;&nbsp;<img src="images/items/2151.gif" />&nbsp;&nbsp;<img src="images/items/2112.gif" />&nbsp;&nbsp;<img src="images/items/2421.gif" />&nbsp;&nbsp;<img src="images/items/2377.gif" />&nbsp;&nbsp;<img src="images/items/2185.gif" />&nbsp;&nbsp;<img src="images/items/3955.gif" />&nbsp;&nbsp;<img src="images/items/2188.gif" />&nbsp;&nbsp;<img src="images/items/2143.gif" />&nbsp;&nbsp;', 'apocalypse.gif'),
(0, 'Ghazbaran', 0, 15000, 60000, 90, 1, '"COME HERE AND DIE!", "COME AND GIVE ME SOME AMUSEMENT!", "IS THAT THE BEST YOU HAVE TO OFFER, TIBIANS?", "I AM GHAZBARAN OF THE TRIANGLE... AND I AM HERE TO CHALLENGE YOU ALL!", "FLAWLESS VICTORY!"', 'energy, earth, fire, paralyze, invisible', 0, 0, 'UNDEAD', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2152.gif" />&nbsp;&nbsp;<img src="images/items/2160.gif" />&nbsp;&nbsp;<img src="images/items/7365.gif" />&nbsp;&nbsp;<img src="images/items/7368.gif" />&nbsp;&nbsp;<img src="images/items/2143.gif" />&nbsp;&nbsp;<img src="images/items/2144.gif" />&nbsp;&nbsp;<img src="images/items/2149.gif" />&nbsp;&nbsp;<img src="images/items/2150.gif" />&nbsp;&nbsp;<img src="images/items/2146.gif" />&nbsp;&nbsp;<img src="images/items/2151.gif" />&nbsp;&nbsp;<img src="images/items/6500.gif" />&nbsp;&nbsp;<img src="images/items/2145.gif" />&nbsp;&nbsp;<img src="images/items/2155.gif" />&nbsp;&nbsp;<img src="images/items/2158.gif" />&nbsp;&nbsp;<img src="images/items/5954.gif" />&nbsp;&nbsp;<img src="images/items/2179.gif" />&nbsp;&nbsp;<img src="images/items/6300.gif" />&nbsp;&nbsp;<img src="images/items/2436.gif" />&nbsp;&nbsp;<img src="images/items/5943.gif" />&nbsp;&nbsp;<img src="images/items/8903.gif" />&nbsp;&nbsp;<img src="images/items/1984.gif" />&nbsp;&nbsp;<img src="images/items/8901.gif" />&nbsp;&nbsp;<img src="images/items/8918.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/7896.gif" />&nbsp;&nbsp;<img src="images/items/2520.gif" />&nbsp;&nbsp;<img src="images/items/2514.gif" />&nbsp;&nbsp;<img src="images/items/2472.gif" />&nbsp;&nbsp;<img src="images/items/2421.gif" />&nbsp;&nbsp;<img src="images/items/7431.gif" />&nbsp;&nbsp;<img src="images/items/2646.gif" />&nbsp;&nbsp;<img src="images/items/2447.gif" />&nbsp;&nbsp;<img src="images/items/8904.gif" />&nbsp;&nbsp;<img src="images/items/8878.gif" />&nbsp;&nbsp;<img src="images/items/7405.gif" />&nbsp;&nbsp;<img src="images/items/8884.gif" />&nbsp;&nbsp;<img src="images/items/6553.gif" />&nbsp;&nbsp;<img src="images/items/8887.gif" />&nbsp;&nbsp;<img src="images/items/7428.gif" />&nbsp;&nbsp;<img src="images/items/8866.gif" />&nbsp;&nbsp;', 'ghazbaran.gif'),
(0, 'Morgaroth', 0, 15000, 55000, 90, 1, '"I AM MORGAROTH, LORD OF THE TRIANGLE... AND YOU ARE LOST!", "MY SEED IS FEAR AND MY HARVEST ARE YOUR SOULS!", "THE TRIANGLE OF TERROR WILL RISE!", "ZATHROTH! LOOK AT THE DESTRUCTION I AM CAUSING IN YOUR NAME!"', 'paralyze, invisible', 0, 0, 'UNDEAD', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2151.gif" />&nbsp;&nbsp;<img src="images/items/6500.gif" />&nbsp;&nbsp;<img src="images/items/2149.gif" />&nbsp;&nbsp;<img src="images/items/2145.gif" />&nbsp;&nbsp;<img src="images/items/7431.gif" />&nbsp;&nbsp;<img src="images/items/2462.gif" />&nbsp;&nbsp;<img src="images/items/2387.gif" />&nbsp;&nbsp;<img src="images/items/2167.gif" />&nbsp;&nbsp;<img src="images/items/2162.gif" />&nbsp;&nbsp;<img src="images/items/2472.gif" />&nbsp;&nbsp;<img src="images/items/7899.gif" />&nbsp;&nbsp;<img src="images/items/2514.gif" />&nbsp;&nbsp;<img src="images/items/2164.gif" />&nbsp;&nbsp;<img src="images/items/2178.gif" />&nbsp;&nbsp;<img src="images/items/2171.gif" />&nbsp;&nbsp;<img src="images/items/1982.gif" />&nbsp;&nbsp;<img src="images/items/2214.gif" />&nbsp;&nbsp;<img src="images/items/2123.gif" />&nbsp;&nbsp;<img src="images/items/2170.gif" />&nbsp;&nbsp;<img src="images/items/2402.gif" />&nbsp;&nbsp;<img src="images/items/2436.gif" />&nbsp;&nbsp;<img src="images/items/2165.gif" />&nbsp;&nbsp;<img src="images/items/2197.gif" />&nbsp;&nbsp;<img src="images/items/2174.gif" />&nbsp;&nbsp;<img src="images/items/2377.gif" />&nbsp;&nbsp;<img src="images/items/8473.gif" />&nbsp;&nbsp;<img src="images/items/8850.gif" />&nbsp;&nbsp;<img src="images/items/8865.gif" />&nbsp;&nbsp;<img src="images/items/8881.gif" />&nbsp;&nbsp;<img src="images/items/2522.gif" />&nbsp;&nbsp;<img src="images/items/8886.gif" />&nbsp;&nbsp;<img src="images/items/5943.gif" />&nbsp;&nbsp;<img src="images/items/8928.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2432.gif" />&nbsp;&nbsp;<img src="images/items/2393.gif" />&nbsp;&nbsp;<img src="images/items/2033.gif" />&nbsp;&nbsp;<img src="images/items/2470.gif" />&nbsp;&nbsp;<img src="images/items/7591.gif" />&nbsp;&nbsp;<img src="images/items/7590.gif" />&nbsp;&nbsp;<img src="images/items/8472.gif" />&nbsp;&nbsp;<img src="images/items/2155.gif" />&nbsp;&nbsp;<img src="images/items/2396.gif" />&nbsp;&nbsp;<img src="images/items/2177.gif" />&nbsp;&nbsp;<img src="images/items/2143.gif" />&nbsp;&nbsp;<img src="images/items/2146.gif" />&nbsp;&nbsp;<img src="images/items/2144.gif" />&nbsp;&nbsp;<img src="images/items/9971.gif" />&nbsp;&nbsp;<img src="images/items/5954.gif" />&nbsp;&nbsp;<img src="images/items/6529.gif" />&nbsp;&nbsp;<img src="images/items/2142.gif" />&nbsp;&nbsp;<img src="images/items/2158.gif" />&nbsp;&nbsp;<img src="images/items/2195.gif" />&nbsp;&nbsp;<img src="images/items/2192.gif" />&nbsp;&nbsp;<img src="images/items/2124.gif" />&nbsp;&nbsp;<img src="images/items/6300.gif" />&nbsp;&nbsp;<img src="images/items/2520.gif" />&nbsp;&nbsp;<img src="images/items/2185.gif" />&nbsp;&nbsp;<img src="images/items/2186.gif" />&nbsp;&nbsp;<img src="images/items/7421.gif" />&nbsp;&nbsp;<img src="images/items/2176.gif" />&nbsp;&nbsp;<img src="images/items/8851.gif" />&nbsp;&nbsp;<img src="images/items/2112.gif" />&nbsp;&nbsp;<img src="images/items/8852.gif" />&nbsp;&nbsp;<img src="images/items/8853.gif" />&nbsp;&nbsp;<img src="images/items/8929.gif" />&nbsp;&nbsp;<img src="images/items/2421.gif" />&nbsp;&nbsp;', 'morgaroth.gif'),
(0, 'Orshabaal', 0, 10000, 20500, 65, 1, '"PRAISED BE MY MASTERS, THE RUTHLESS SEVEN!", "YOU ARE DOOMED!", "ORSHABAAL IS BACK!", "Be prepared for the day my masters will come for you!", "SOULS FOR ORSHABAAL!"', 'earth, fire, lifedrain, paralyze, invisible', 0, 0, 'fire', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2377.gif" />&nbsp;&nbsp;<img src="images/items/2188.gif" />&nbsp;&nbsp;<img src="images/items/2393.gif" />&nbsp;&nbsp;<img src="images/items/2432.gif" />&nbsp;&nbsp;<img src="images/items/2472.gif" />&nbsp;&nbsp;<img src="images/items/2390.gif" />&nbsp;&nbsp;<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/5906.gif" />&nbsp;&nbsp;<img src="images/items/5954.gif" />&nbsp;&nbsp;<img src="images/items/2182.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2421.gif" />&nbsp;&nbsp;<img src="images/items/2678.gif" />&nbsp;&nbsp;<img src="images/items/2144.gif" />&nbsp;&nbsp;<img src="images/items/2462.gif" />&nbsp;&nbsp;<img src="images/items/2149.gif" />&nbsp;&nbsp;<img src="images/items/2171.gif" />&nbsp;&nbsp;<img src="images/items/2387.gif" />&nbsp;&nbsp;<img src="images/items/2470.gif" />&nbsp;&nbsp;<img src="images/items/2520.gif" />&nbsp;&nbsp;<img src="images/items/2418.gif" />&nbsp;&nbsp;', 'orshabaal.gif'),
(0, 'Dog', 220, 0, 20, 1, 0, '"hufhuf"', '', 1, 1, 'blood', '', 'dog.gif'),
(0, 'Hellhound', 0, 6800, 7500, 45, 0, '"GROOOWL!", "GRRRRR!"', 'fire, lifedrain, paralyze, outfit, drunk, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/5944.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;<img src="images/items/2230.gif" />&nbsp;&nbsp;<img src="images/items/6500.gif" />&nbsp;&nbsp;<img src="images/items/2231.gif" />&nbsp;&nbsp;<img src="images/items/2393.gif" />&nbsp;&nbsp;<img src="images/items/2144.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2430.gif" />&nbsp;&nbsp;<img src="images/items/2383.gif" />&nbsp;&nbsp;<img src="images/items/2410.gif" />&nbsp;&nbsp;<img src="images/items/6558.gif" />&nbsp;&nbsp;<img src="images/items/6553.gif" />&nbsp;&nbsp;', 'hellhound.gif'),
(0, 'War Wolf', 0, 55, 140, 1, 0, '"Grrrrrrr", "Yoooohhuuuu!"', '', 0, 1, 'blood', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;<img src="images/items/5897.gif" />&nbsp;&nbsp;', 'warwolf.gif'),
(0, 'Winter Wolf', 260, 20, 30, 1, 0, '', '', 1, 1, 'blood', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;', 'winterwolf.gif'),
(0, 'Wolf', 255, 18, 25, 1, 0, '', '', 1, 1, 'blood', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/5897.gif" />&nbsp;&nbsp;', 'wolf.gif'),
(0, 'Chakoya Toolshaper', 0, 40, 80, 25, 0, '"Chikuva!!", "Jinuma jamjam!"', 'energy', 0, 0, 'blood', '<img src="images/items/2667.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2553.gif" />&nbsp;&nbsp;', 'chakoyatoolshaper.gif'),
(0, 'Chakoya Tribewarden', 305, 40, 68, 25, 0, '"Chikuva!", "Quisavu tukavi!", "Si siyoqua jamjam!", "Achuq! jinuma!", "Si ji jusipa!"', 'energy', 0, 1, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;<img src="images/items/2667.gif" />&nbsp;&nbsp;<img src="images/items/2541.gif" />&nbsp;&nbsp;<img src="images/items/2398.gif" />&nbsp;&nbsp;<img src="images/items/7381.gif" />&nbsp;&nbsp;', 'chakoyatribewarden.gif'),
(0, 'Chakoya Windcaller', 305, 48, 84, 25, 0, '"Chikuva!", "Siqsiq ji jusipa!", "Jagura taluka taqua!"', 'energy', 0, 1, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/7290.gif" />&nbsp;&nbsp;<img src="images/items/7158.gif" />&nbsp;&nbsp;', 'chakoyawindcaller.gif'),
(0, 'Blood Crab', 505, 160, 290, 1, 0, '', 'poison, lifedrain, invisible', 1, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2667.gif" />&nbsp;&nbsp;<img src="images/items/2478.gif" />&nbsp;&nbsp;<img src="images/items/2464.gif" />&nbsp;&nbsp;<img src="images/items/2143.gif" />&nbsp;&nbsp;', 'bloodcrab.gif'),
(0, 'Crab', 305, 30, 55, 1, 0, '"crab crab!"', 'poison', 1, 1, 'blood', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;', 'crab.gif'),
(0, 'Ice Golem', 0, 295, 385, 8, 0, '"Chrr."', 'fire, ice, holy, death, lifedrain, paralyze, invisible', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2144.gif" />&nbsp;&nbsp;<img src="images/items/7290.gif" />&nbsp;&nbsp;<img src="images/items/2145.gif" />&nbsp;&nbsp;<img src="images/items/7441.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2146.gif" />&nbsp;&nbsp;<img src="images/items/2396.gif" />&nbsp;&nbsp;<img src="images/items/2479.gif" />&nbsp;&nbsp;<img src="images/items/7449.gif" />&nbsp;&nbsp;<img src="images/items/2383.gif" />&nbsp;&nbsp;', 'icegolem.gif'),
(0, 'Yeti', 0, 460, 950, 25, 0, '"Yooodelaaahooohooo!", "Yooodelaaaheeeheee!"', 'energy, poison, lifedrain, paralyze, outfit, drunk, invisible', 0, 0, 'blood', '<img src="images/items/2671.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/2111.gif" />&nbsp;&nbsp;<img src="images/items/2425.gif" />&nbsp;&nbsp;<img src="images/items/4848.gif" />&nbsp;&nbsp;<img src="images/items/2197.gif" />&nbsp;&nbsp;<img src="images/items/2381.gif" />&nbsp;&nbsp;<img src="images/items/2177.gif" />&nbsp;&nbsp;<img src="images/items/2044.gif" />&nbsp;&nbsp;<img src="images/items/2448.gif" />&nbsp;&nbsp;<img src="images/items/2688.gif" />&nbsp;&nbsp;', 'yeti.gif'),
(0, 'Acolyte Of The Cult', 0, 300, 390, 5, 0, '"Praise voodoo!"', 'fire, poison', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2149.gif" />&nbsp;&nbsp;<img src="images/items/2201.gif" />&nbsp;&nbsp;<img src="images/items/6087.gif" />&nbsp;&nbsp;<img src="images/items/2394.gif" />&nbsp;&nbsp;<img src="images/items/2169.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2181.gif" />&nbsp;&nbsp;<img src="images/items/2168.gif" />&nbsp;&nbsp;<img src="images/items/5810.gif" />&nbsp;&nbsp;<img src="images/items/2652.gif" />&nbsp;&nbsp;<img src="images/items/5801.gif" />&nbsp;&nbsp;', 'acolyteofthecult.gif'),
(0, 'Adept Of The Cult', 0, 400, 430, 1, 0, '', 'fire, poison', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2147.gif" />&nbsp;&nbsp;<img src="images/items/2169.gif" />&nbsp;&nbsp;<img src="images/items/2423.gif" />&nbsp;&nbsp;<img src="images/items/2655.gif" />&nbsp;&nbsp;<img src="images/items/7451.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/5810.gif" />&nbsp;&nbsp;<img src="images/items/7426.gif" />&nbsp;&nbsp;<img src="images/items/6087.gif" />&nbsp;&nbsp;<img src="images/items/5801.gif" />&nbsp;&nbsp;<img src="images/items/2183.gif" />&nbsp;&nbsp;', 'adeptofthecult.gif'),
(0, 'Enlightened Of The Cult', 0, 500, 700, 1, 0, '', 'poison, lifedrain, paralyze, outfit, drunk, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2654.gif" />&nbsp;&nbsp;<img src="images/items/2187.gif" />&nbsp;&nbsp;<img src="images/items/5801.gif" />&nbsp;&nbsp;<img src="images/items/2167.gif" />&nbsp;&nbsp;<img src="images/items/2171.gif" />&nbsp;&nbsp;<img src="images/items/7426.gif" />&nbsp;&nbsp;<img src="images/items/2656.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2114.gif" />&nbsp;&nbsp;<img src="images/items/6087.gif" />&nbsp;&nbsp;<img src="images/items/5810.gif" />&nbsp;&nbsp;<img src="images/items/2146.gif" />&nbsp;&nbsp;<img src="images/items/2436.gif" />&nbsp;&nbsp;<img src="images/items/2200.gif" />&nbsp;&nbsp;<img src="images/items/5669.gif" />&nbsp;&nbsp;', 'enlightenedofthecult.gif'),
(0, 'Novice Of The Cult', 0, 100, 285, 1, 0, '"Fear us!", "You will not tell anyone what you have seen.", "Your curiosity will be punished!"', 'poison, lifedrain, paralyze, outfit, drunk', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2661.gif" />&nbsp;&nbsp;<img src="images/items/2145.gif" />&nbsp;&nbsp;<img src="images/items/5810.gif" />&nbsp;&nbsp;<img src="images/items/2213.gif" />&nbsp;&nbsp;<img src="images/items/2478.gif" />&nbsp;&nbsp;<img src="images/items/2398.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2199.gif" />&nbsp;&nbsp;<img src="images/items/2190.gif" />&nbsp;&nbsp;<img src="images/items/6087.gif" />&nbsp;&nbsp;', 'noviceofthecult.gif'),
(0, 'Grandfather Tridian', 0, 1400, 1800, 13, 0, '', 'paralyze, invisible', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2187.gif" />&nbsp;&nbsp;<img src="images/items/2656.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2114.gif" />&nbsp;&nbsp;<img src="images/items/6087.gif" />&nbsp;&nbsp;<img src="images/items/5810.gif" />&nbsp;&nbsp;<img src="images/items/2789.gif" />&nbsp;&nbsp;<img src="images/items/2436.gif" />&nbsp;&nbsp;<img src="images/items/5669.gif" />&nbsp;&nbsp;<img src="images/items/8922.gif" />&nbsp;&nbsp;', 'grandfathertridian.gif'),
(0, 'Ungreez', 10000, 500, 8200, 30, 0, '"I''ll teach you that even heros can die", "You wil die Begging like the others did"', 'energy, fire, lifedrain, paralyze, outfit, drunk, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/7590.gif" />&nbsp;&nbsp;<img src="images/items/7591.gif" />&nbsp;&nbsp;', 'ungreez.gif'),
(0, 'Dark Torturer', 0, 4650, 7350, 33, 0, '"You like it, don''t you?", "IahaEhheAie!"', 'fire, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2152.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;<img src="images/items/6558.gif" />&nbsp;&nbsp;<img src="images/items/6300.gif" />&nbsp;&nbsp;<img src="images/items/2645.gif" />&nbsp;&nbsp;<img src="images/items/9971.gif" />&nbsp;&nbsp;<img src="images/items/7368.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2513.gif" />&nbsp;&nbsp;<img src="images/items/6500.gif" />&nbsp;&nbsp;<img src="images/items/2557.gif" />&nbsp;&nbsp;<img src="images/items/2558.gif" />&nbsp;&nbsp;<img src="images/items/7388.gif" />&nbsp;&nbsp;<img src="images/items/2470.gif" />&nbsp;&nbsp;<img src="images/items/7412.gif" />&nbsp;&nbsp;<img src="images/items/5801.gif" />&nbsp;&nbsp;<img src="images/items/5480.gif" />&nbsp;&nbsp;', 'darktorturer.gif'),
(0, 'Demon', 10000, 6000, 8200, 28, 1, '"MUHAHAHAHA!", "I SMELL FEEEEEAAAR!", "CHAMEK ATH UTHUL ARAK!", "Your resistance is futile!", "Your soul will be mine!"', 'fire, drown, paralyze, invisible', 0, 0, 'fire', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2152.gif" />&nbsp;&nbsp;<img src="images/items/2514.gif" />&nbsp;&nbsp;<img src="images/items/2472.gif" />&nbsp;&nbsp;<img src="images/items/2795.gif" />&nbsp;&nbsp;<img src="images/items/5906.gif" />&nbsp;&nbsp;<img src="images/items/5954.gif" />&nbsp;&nbsp;<img src="images/items/2164.gif" />&nbsp;&nbsp;<img src="images/items/2176.gif" />&nbsp;&nbsp;<img src="images/items/1982.gif" />&nbsp;&nbsp;<img src="images/items/2165.gif" />&nbsp;&nbsp;<img src="images/items/7591.gif" />&nbsp;&nbsp;<img src="images/items/10518.gif" />&nbsp;&nbsp;<img src="images/items/2393.gif" />&nbsp;&nbsp;<img src="images/items/2432.gif" />&nbsp;&nbsp;<img src="images/items/2214.gif" />&nbsp;&nbsp;<img src="images/items/2396.gif" />&nbsp;&nbsp;<img src="images/items/2179.gif" />&nbsp;&nbsp;<img src="images/items/2678.gif" />&nbsp;&nbsp;<img src="images/items/2151.gif" />&nbsp;&nbsp;<img src="images/items/2462.gif" />&nbsp;&nbsp;<img src="images/items/2149.gif" />&nbsp;&nbsp;<img src="images/items/2171.gif" />&nbsp;&nbsp;<img src="images/items/2387.gif" />&nbsp;&nbsp;<img src="images/items/2470.gif" />&nbsp;&nbsp;<img src="images/items/7382.gif" />&nbsp;&nbsp;<img src="images/items/7393.gif" />&nbsp;&nbsp;<img src="images/items/2520.gif" />&nbsp;&nbsp;<img src="images/items/2418.gif" />&nbsp;&nbsp;<img src="images/items/2377.gif" />&nbsp;&nbsp;', 'demon.gif'),
(0, 'Destroyer', 0, 2500, 3700, 25, 1, '"Destructiooooon!", "It''s a good day to destroy!"', 'energy, paralyze, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2645.gif" />&nbsp;&nbsp;<img src="images/items/2152.gif" />&nbsp;&nbsp;<img src="images/items/2393.gif" />&nbsp;&nbsp;<img src="images/items/5741.gif" />&nbsp;&nbsp;<img src="images/items/7419.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2463.gif" />&nbsp;&nbsp;<img src="images/items/2416.gif" />&nbsp;&nbsp;<img src="images/items/2489.gif" />&nbsp;&nbsp;<img src="images/items/2150.gif" />&nbsp;&nbsp;<img src="images/items/7427.gif" />&nbsp;&nbsp;', 'destroyer.gif'),
(0, 'Diabolic Imp', 0, 2900, 1950, 15, 1, '"Muahaha!", "He he he!"', 'fire, lifedrain, paralyze, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2152.gif" />&nbsp;&nbsp;<img src="images/items/2050.gif" />&nbsp;&nbsp;<img src="images/items/6558.gif" />&nbsp;&nbsp;<img src="images/items/2260.gif" />&nbsp;&nbsp;<img src="images/items/6300.gif" />&nbsp;&nbsp;<img src="images/items/2465.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2548.gif" />&nbsp;&nbsp;<img src="images/items/6529.gif" />&nbsp;&nbsp;<img src="images/items/2185.gif" />&nbsp;&nbsp;<img src="images/items/2464.gif" />&nbsp;&nbsp;<img src="images/items/5944.gif" />&nbsp;&nbsp;<img src="images/items/7899.gif" />&nbsp;&nbsp;<img src="images/items/7900.gif" />&nbsp;&nbsp;<img src="images/items/6500.gif" />&nbsp;&nbsp;<img src="images/items/2150.gif" />&nbsp;&nbsp;<img src="images/items/2165.gif" />&nbsp;&nbsp;', 'diabolicimp.gif'),
(0, 'Fire Devil', 530, 110, 200, 1, 0, '"Hot, eh?", "Hell, oh hell!"', 'fire', 1, 1, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/2185.gif" />&nbsp;&nbsp;<img src="images/items/2050.gif" />&nbsp;&nbsp;<img src="images/items/2419.gif" />&nbsp;&nbsp;<img src="images/items/2387.gif" />&nbsp;&nbsp;<img src="images/items/2568.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2187.gif" />&nbsp;&nbsp;<img src="images/items/2515.gif" />&nbsp;&nbsp;<img src="images/items/2260.gif" />&nbsp;&nbsp;<img src="images/items/2691.gif" />&nbsp;&nbsp;<img src="images/items/2150.gif" />&nbsp;&nbsp;<img src="images/items/2191.gif" />&nbsp;&nbsp;', 'firedevil.gif'),
(0, 'Fury', 0, 4500, 4100, 95, 0, '"Fire hot!", "Ahhhhrrrrr", "Carnage!"', 'fire, lifedrain, paralyze, outfit, drunk, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2645.gif" />&nbsp;&nbsp;<img src="images/items/6558.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/6500.gif" />&nbsp;&nbsp;<img src="images/items/5944.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2487.gif" />&nbsp;&nbsp;<img src="images/items/2181.gif" />&nbsp;&nbsp;<img src="images/items/9811.gif" />&nbsp;&nbsp;<img src="images/items/2143.gif" />&nbsp;&nbsp;<img src="images/items/2156.gif" />&nbsp;&nbsp;<img src="images/items/7404.gif" />&nbsp;&nbsp;<img src="images/items/5911.gif" />&nbsp;&nbsp;', 'fury.gif'),
(0, 'Hand Of Cursed Fate', 0, 5000, 10500, 40, 1, '', 'death, energy, fire, poison, paralyze, invisible', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2654.gif" />&nbsp;&nbsp;<img src="images/items/2152.gif" />&nbsp;&nbsp;<img src="images/items/2187.gif" />&nbsp;&nbsp;<img src="images/items/8974.gif" />&nbsp;&nbsp;<img src="images/items/2463.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2487.gif" />&nbsp;&nbsp;<img src="images/items/2476.gif" />&nbsp;&nbsp;<img src="images/items/6500.gif" />&nbsp;&nbsp;<img src="images/items/2153.gif" />&nbsp;&nbsp;<img src="images/items/7414.gif" />&nbsp;&nbsp;', 'handofcursedfate.gif'),
(0, 'Juggernaut', 0, 8700, 20000, 80, 1, '"WAHHHH!", "RAAARRR!", "GRRRRRR!"', 'paralyze, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2152.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/2672.gif" />&nbsp;&nbsp;<img src="images/items/2220.gif" />&nbsp;&nbsp;<img src="images/items/2228.gif" />&nbsp;&nbsp;<img src="images/items/2136.gif" />&nbsp;&nbsp;<img src="images/items/2452.gif" />&nbsp;&nbsp;<img src="images/items/6558.gif" />&nbsp;&nbsp;<img src="images/items/6500.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2514.gif" />&nbsp;&nbsp;<img src="images/items/7590.gif" />&nbsp;&nbsp;<img src="images/items/7591.gif" />&nbsp;&nbsp;<img src="images/items/7452.gif" />&nbsp;&nbsp;<img src="images/items/7404.gif" />&nbsp;&nbsp;<img src="images/items/5944.gif" />&nbsp;&nbsp;<img src="images/items/2434.gif" />&nbsp;&nbsp;<img src="images/items/2466.gif" />&nbsp;&nbsp;<img src="images/items/2470.gif" />&nbsp;&nbsp;<img src="images/items/8889.gif" />&nbsp;&nbsp;', 'juggernaut.gif'),
(0, 'Nightmare', 0, 2150, 2750, 95, 1, '"Close your eyes... I want to show you something!", "I will haunt you forever!", "I will make you scream!"', 'death, lifedrain, paralyze, outfit, drunk, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2152.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;<img src="images/items/2230.gif" />&nbsp;&nbsp;<img src="images/items/6558.gif" />&nbsp;&nbsp;<img src="images/items/2532.gif" />&nbsp;&nbsp;<img src="images/items/6500.gif" />&nbsp;&nbsp;<img src="images/items/2387.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2491.gif" />&nbsp;&nbsp;<img src="images/items/7419.gif" />&nbsp;&nbsp;<img src="images/items/5944.gif" />&nbsp;&nbsp;<img src="images/items/2457.gif" />&nbsp;&nbsp;<img src="images/items/6300.gif" />&nbsp;&nbsp;<img src="images/items/2477.gif" />&nbsp;&nbsp;<img src="images/items/2195.gif" />&nbsp;&nbsp;<img src="images/items/6526.gif" />&nbsp;&nbsp;<img src="images/items/5810.gif" />&nbsp;&nbsp;', 'nightmare.gif'),
(0, 'Plaguesmith', 0, 4500, 8250, 65, 1, '"You are looking a bit feverish today!", "Hachoo!", "Cough Cough!"', 'poison, paralyze, invisible', 0, 0, 'venom', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2235.gif" />&nbsp;&nbsp;<img src="images/items/2237.gif" />&nbsp;&nbsp;<img src="images/items/2416.gif" />&nbsp;&nbsp;<img src="images/items/2645.gif" />&nbsp;&nbsp;<img src="images/items/6500.gif" />&nbsp;&nbsp;<img src="images/items/5888.gif" />&nbsp;&nbsp;<img src="images/items/5887.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2492.gif" />&nbsp;&nbsp;<img src="images/items/7365.gif" />&nbsp;&nbsp;<img src="images/items/9808.gif" />&nbsp;&nbsp;<img src="images/items/2477.gif" />&nbsp;&nbsp;<img src="images/items/2444.gif" />&nbsp;&nbsp;<img src="images/items/2417.gif" />&nbsp;&nbsp;<img src="images/items/2509.gif" />&nbsp;&nbsp;<img src="images/items/5944.gif" />&nbsp;&nbsp;<img src="images/items/3957.gif" />&nbsp;&nbsp;<img src="images/items/2209.gif" />&nbsp;&nbsp;', 'plaguesmith.gif'),
(0, 'Blue Djinn', 0, 215, 330, 1, 0, '"Simsalabim", "Feel the power of my magic, tiny mortal!", "Be careful what you wish for.", "Wishes can come true."', 'paralyze, invisible', 0, 0, 'blood', '<img src="images/items/1978.gif" />&nbsp;&nbsp;<img src="images/items/2745.gif" />&nbsp;&nbsp;<img src="images/items/7378.gif" />&nbsp;&nbsp;<img src="images/items/2146.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2684.gif" />&nbsp;&nbsp;<img src="images/items/2663.gif" />&nbsp;&nbsp;<img src="images/items/1971.gif" />&nbsp;&nbsp;<img src="images/items/2044.gif" />&nbsp;&nbsp;<img src="images/items/2063.gif" />&nbsp;&nbsp;<img src="images/items/5912.gif" />&nbsp;&nbsp;', 'bluedjinn.gif'),
(0, 'Efreet', 0, 325, 550, 10, 0, '"I grant you a deathwish!", "Muhahahaha!", "I wish you a merry trip to hell!", "Tell me your last wish!", "Good wishes are for fairytales"', 'paralyze, invisible', 0, 0, 'blood', '<img src="images/items/2155.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2673.gif" />&nbsp;&nbsp;<img src="images/items/2044.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/7378.gif" />&nbsp;&nbsp;<img src="images/items/2063.gif" />&nbsp;&nbsp;<img src="images/items/2149.gif" />&nbsp;&nbsp;<img src="images/items/2663.gif" />&nbsp;&nbsp;<img src="images/items/1860.gif" />&nbsp;&nbsp;<img src="images/items/2442.gif" />&nbsp;&nbsp;<img src="images/items/2187.gif" />&nbsp;&nbsp;', 'efreet.gif'),
(0, 'Green Djinn', 0, 225, 330, 1, 0, '"I grant you a deathwish!", "Muhahahaha!", "I wish you a merry trip to hell!", "Tell me your last wish!", "Good wishes are for fairytales"', 'invisible', 0, 0, 'VENOM', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2696.gif" />&nbsp;&nbsp;<img src="images/items/2747.gif" />&nbsp;&nbsp;<img src="images/items/7378.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2187.gif" />&nbsp;&nbsp;<img src="images/items/2062.gif" />&nbsp;&nbsp;<img src="images/items/2176.gif" />&nbsp;&nbsp;', 'greendjinn.gif');
INSERT INTO `z_monsters` (`hide_creature`, `name`, `mana`, `exp`, `health`, `speed_lvl`, `use_haste`, `voices`, `immunities`, `summonable`, `convinceable`, `race`, `loot`, `gfx_name`) VALUES
(0, 'Marid', 0, 325, 550, 1, 0, '"Simsalabim", "Feel the power of my magic, tiny mortal!", "Be careful what you wish for.", "Wishes can come true."', 'paralyze, invisible', 0, 0, 'blood', '<img src="images/items/2158.gif" />&nbsp;&nbsp;<img src="images/items/1872.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2442.gif" />&nbsp;&nbsp;<img src="images/items/2183.gif" />&nbsp;&nbsp;<img src="images/items/5912.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2070.gif" />&nbsp;&nbsp;<img src="images/items/2146.gif" />&nbsp;&nbsp;<img src="images/items/2063.gif" />&nbsp;&nbsp;<img src="images/items/2677.gif" />&nbsp;&nbsp;<img src="images/items/2177.gif" />&nbsp;&nbsp;', 'marid.gif'),
(0, 'Frost Dragon', 390, 2100, 1800, 20, 0, '"CHHHRRRR", "HISSSS"', 'ice, fire, earth, paralyze, lifedrain, invisible', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2672.gif" />&nbsp;&nbsp;<img src="images/items/2033.gif" />&nbsp;&nbsp;<img src="images/items/1976.gif" />&nbsp;&nbsp;<img src="images/items/2413.gif" />&nbsp;&nbsp;<img src="images/items/7290.gif" />&nbsp;&nbsp;<img src="images/items/7378.gif" />&nbsp;&nbsp;<img src="images/items/2546.gif" />&nbsp;&nbsp;<img src="images/items/2547.gif" />&nbsp;&nbsp;<img src="images/items/2796.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2146.gif" />&nbsp;&nbsp;<img src="images/items/2528.gif" />&nbsp;&nbsp;<img src="images/items/7441.gif" />&nbsp;&nbsp;<img src="images/items/7402.gif" />&nbsp;&nbsp;<img src="images/items/2498.gif" />&nbsp;&nbsp;<img src="images/items/2492.gif" />&nbsp;&nbsp;', 'frostdragon.gif'),
(0, 'Wyrm', 0, 1450, 1825, 35, 0, '"GRRR!", "GRROARR!"', 'energy, paralyze, invisible', 0, 0, 'blood', '<img src="images/items/2672.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2647.gif" />&nbsp;&nbsp;<img src="images/items/8921.gif" />&nbsp;&nbsp;<img src="images/items/7411.gif" />&nbsp;&nbsp;<img src="images/items/2546.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/7430.gif" />&nbsp;&nbsp;<img src="images/items/7588.gif" />&nbsp;&nbsp;<img src="images/items/8871.gif" />&nbsp;&nbsp;', 'wyrm.gif'),
(0, 'Sea Serpent', 390, 2300, 3200, 65, 0, '"CHHHRRRR", "HISSSS"', 'ice, paralyze, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2146.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/2214.gif" />&nbsp;&nbsp;<img src="images/items/7391.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2672.gif" />&nbsp;&nbsp;<img src="images/items/7888.gif" />&nbsp;&nbsp;<img src="images/items/8887.gif" />&nbsp;&nbsp;<img src="images/items/7424.gif" />&nbsp;&nbsp;', 'seaserpent.gif'),
(0, 'Dragon Lord', 0, 2100, 1900, 13, 0, '"ZCHHHHH", "YOU WILL BURN!"', 'fire, paralyze, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2672.gif" />&nbsp;&nbsp;<img src="images/items/2033.gif" />&nbsp;&nbsp;<img src="images/items/1976.gif" />&nbsp;&nbsp;<img src="images/items/2413.gif" />&nbsp;&nbsp;<img src="images/items/2498.gif" />&nbsp;&nbsp;<img src="images/items/2492.gif" />&nbsp;&nbsp;<img src="images/items/7378.gif" />&nbsp;&nbsp;<img src="images/items/2547.gif" />&nbsp;&nbsp;<img src="images/items/2796.gif" />&nbsp;&nbsp;<img src="images/items/5948.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2149.gif" />&nbsp;&nbsp;<img src="images/items/2392.gif" />&nbsp;&nbsp;<img src="images/items/2146.gif" />&nbsp;&nbsp;<img src="images/items/2528.gif" />&nbsp;&nbsp;<img src="images/items/7402.gif" />&nbsp;&nbsp;<img src="images/items/2414.gif" />&nbsp;&nbsp;<img src="images/items/5882.gif" />&nbsp;&nbsp;', 'dragonlord.gif'),
(0, 'Dragon', 0, 700, 1000, 1, 0, '"GROOAAARRR", "FCHHHHH"', 'fire, paralyze, invisible', 0, 0, 'blood', '<img src="images/items/2672.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2455.gif" />&nbsp;&nbsp;<img src="images/items/2434.gif" />&nbsp;&nbsp;<img src="images/items/2509.gif" />&nbsp;&nbsp;<img src="images/items/2406.gif" />&nbsp;&nbsp;<img src="images/items/2647.gif" />&nbsp;&nbsp;<img src="images/items/2457.gif" />&nbsp;&nbsp;<img src="images/items/2387.gif" />&nbsp;&nbsp;<img src="images/items/7430.gif" />&nbsp;&nbsp;<img src="images/items/2397.gif" />&nbsp;&nbsp;<img src="images/items/2546.gif" />&nbsp;&nbsp;<img src="images/items/5877.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2398.gif" />&nbsp;&nbsp;<img src="images/items/2187.gif" />&nbsp;&nbsp;<img src="images/items/2516.gif" />&nbsp;&nbsp;<img src="images/items/2145.gif" />&nbsp;&nbsp;<img src="images/items/2177.gif" />&nbsp;&nbsp;<img src="images/items/2413.gif" />&nbsp;&nbsp;<img src="images/items/2409.gif" />&nbsp;&nbsp;<img src="images/items/5920.gif" />&nbsp;&nbsp;', 'dragon.gif'),
(0, 'Hydra', 0, 1900, 2250, 10, 0, '"FCHHHHH", "HISSSS"', 'poison, lifedrain, paralyze, outfit, drunk, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2498.gif" />&nbsp;&nbsp;<img src="images/items/2195.gif" />&nbsp;&nbsp;<img src="images/items/2475.gif" />&nbsp;&nbsp;<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2214.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/2146.gif" />&nbsp;&nbsp;<img src="images/items/2177.gif" />&nbsp;&nbsp;<img src="images/items/2476.gif" />&nbsp;&nbsp;<img src="images/items/4850.gif" />&nbsp;&nbsp;<img src="images/items/2149.gif" />&nbsp;&nbsp;<img src="images/items/2536.gif" />&nbsp;&nbsp;<img src="images/items/2168.gif" />&nbsp;&nbsp;<img src="images/items/2197.gif" />&nbsp;&nbsp;', 'hydra.gif'),
(0, 'Dragon Hatchling', 0, 185, 380, 1, 0, '"Fchu?"', 'fire, paralyze, outfit, drunk, invisible', 0, 0, 'blood', '<img src="images/items/7618.gif" />&nbsp;&nbsp;<img src="images/items/2672.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;', 'dragonhatchling.gif'),
(0, 'Dragon Lord Hatchling', 0, 645, 750, 1, 0, '"Zchu?"', 'fire, paralyze, outfit, drunk, invisible', 0, 0, 'blood', '<img src="images/items/7620.gif" />&nbsp;&nbsp;<img src="images/items/2672.gif" />&nbsp;&nbsp;<img src="images/items/2796.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/7891.gif" />&nbsp;&nbsp;', 'dragonlordhatchling.gif'),
(0, 'Frost Dragon Hatchling', 0, 745, 800, 1, 0, '"Rooawwrr", "Fchu?"', 'fire, earth, ice, paralyze, invisible', 0, 0, 'undead', '<img src="images/items/7618.gif" />&nbsp;&nbsp;<img src="images/items/2672.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;', 'frostdragonhatchling.gif'),
(0, 'Demodras', 0, 3100, 4500, 40, 0, '"ZCHHHHH", "I WILL SET THE WORLD IN FIRE!", "I WILL PROTECT MY BROOD!"', 'fire, poison, lifedrain, paralyze, outfit, drunk, invisible', 0, 0, 'fire', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2672.gif" />&nbsp;&nbsp;<img src="images/items/2033.gif" />&nbsp;&nbsp;<img src="images/items/1976.gif" />&nbsp;&nbsp;<img src="images/items/2413.gif" />&nbsp;&nbsp;<img src="images/items/2498.gif" />&nbsp;&nbsp;<img src="images/items/2492.gif" />&nbsp;&nbsp;<img src="images/items/2547.gif" />&nbsp;&nbsp;<img src="images/items/2546.gif" />&nbsp;&nbsp;<img src="images/items/2796.gif" />&nbsp;&nbsp;<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2149.gif" />&nbsp;&nbsp;<img src="images/items/2392.gif" />&nbsp;&nbsp;<img src="images/items/2146.gif" />&nbsp;&nbsp;<img src="images/items/2528.gif" />&nbsp;&nbsp;<img src="images/items/5948.gif" />&nbsp;&nbsp;<img src="images/items/5882.gif" />&nbsp;&nbsp;<img src="images/items/5919.gif" />&nbsp;&nbsp;', 'demodras.gif'),
(0, 'Dwarf Geomancer', 0, 245, 380, 1, 0, '"Hail Durin!", "Earth is the strongest element.", "Dust to dust."', 'fire, poison, lifedrain, paralyze, outfit, drunk, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2673.gif" />&nbsp;&nbsp;<img src="images/items/2260.gif" />&nbsp;&nbsp;<img src="images/items/2649.gif" />&nbsp;&nbsp;<img src="images/items/2643.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2162.gif" />&nbsp;&nbsp;<img src="images/items/2787.gif" />&nbsp;&nbsp;', 'dwarfgeomancer.gif'),
(0, 'Dwarf Guard', 650, 165, 245, 1, 0, '"Hail Durin!"', 'invisible', 1, 1, 'blood', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2483.gif" />&nbsp;&nbsp;<img src="images/items/2417.gif" />&nbsp;&nbsp;<img src="images/items/2387.gif" />&nbsp;&nbsp;<img src="images/items/2787.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/5880.gif" />&nbsp;&nbsp;<img src="images/items/2459.gif" />&nbsp;&nbsp;<img src="images/items/2513.gif" />&nbsp;&nbsp;<img src="images/items/2150.gif" />&nbsp;&nbsp;<img src="images/items/2378.gif" />&nbsp;&nbsp;<img src="images/items/2169.gif" />&nbsp;&nbsp;', 'dwarfguard.gif'),
(0, 'Dwarf Soldier', 360, 70, 135, 1, 0, '"Hail Durin!"', '', 1, 1, 'blood', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2543.gif" />&nbsp;&nbsp;<img src="images/items/2481.gif" />&nbsp;&nbsp;<img src="images/items/2455.gif" />&nbsp;&nbsp;<img src="images/items/2554.gif" />&nbsp;&nbsp;<img src="images/items/2464.gif" />&nbsp;&nbsp;<img src="images/items/2643.gif" />&nbsp;&nbsp;<img src="images/items/2696.gif" />&nbsp;&nbsp;<img src="images/items/7363.gif" />&nbsp;&nbsp;<img src="images/items/5880.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2525.gif" />&nbsp;&nbsp;<img src="images/items/2378.gif" />&nbsp;&nbsp;<img src="images/items/2213.gif" />&nbsp;&nbsp;', 'dwarfsoldier.gif'),
(0, 'Dwarf', 320, 45, 90, 1, 0, '"Hail Durin!"', '', 1, 1, 'blood', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2388.gif" />&nbsp;&nbsp;<img src="images/items/2386.gif" />&nbsp;&nbsp;<img src="images/items/2484.gif" />&nbsp;&nbsp;<img src="images/items/2530.gif" />&nbsp;&nbsp;<img src="images/items/2649.gif" />&nbsp;&nbsp;<img src="images/items/5880.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2787.gif" />&nbsp;&nbsp;', 'dwarf.gif'),
(0, 'Mad Technomancer', 0, 55, 1000, 1, 0, '"I''m going to make them an offer they can''t refuse.", "My masterplan cannot fail!", "Gentlemen, you can''t fight here! This is the War Room!"', 'invisible', 0, 0, 'blood', '<img src="images/items/7699.gif" />&nbsp;&nbsp;', 'madtechnomancer.gif'),
(0, 'Dworc Fleshhunter', 0, 35, 85, 10, 0, '"Grak brrretz!", "Grow truk grrrrr.", "Prek tars, dekklep zurk."', 'poison', 0, 1, 'blood', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/2512.gif" />&nbsp;&nbsp;<img src="images/items/2530.gif" />&nbsp;&nbsp;<img src="images/items/3956.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/3952.gif" />&nbsp;&nbsp;<img src="images/items/2385.gif" />&nbsp;&nbsp;<img src="images/items/2464.gif" />&nbsp;&nbsp;<img src="images/items/2420.gif" />&nbsp;&nbsp;<img src="images/items/2448.gif" />&nbsp;&nbsp;<img src="images/items/2007.gif" />&nbsp;&nbsp;', 'dworcfleshhunter.gif'),
(0, 'Dworc Venomsniper', 0, 30, 80, 10, 0, '"grak brrretz!", "grow truk grrrrr.", "prek tars, dekklep zurk."', 'poison', 0, 1, 'blood', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/3983.gif" />&nbsp;&nbsp;<img src="images/items/3975.gif" />&nbsp;&nbsp;<img src="images/items/2512.gif" />&nbsp;&nbsp;<img src="images/items/2530.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2385.gif" />&nbsp;&nbsp;<img src="images/items/2464.gif" />&nbsp;&nbsp;<img src="images/items/2420.gif" />&nbsp;&nbsp;<img src="images/items/2448.gif" />&nbsp;&nbsp;<img src="images/items/2007.gif" />&nbsp;&nbsp;', 'dworcvenomsniper.gif'),
(0, 'Dworc Voodoomaster', 0, 50, 80, 10, 1, '"grak brrretz!", "grow truk grrrrr.", "prek tars, dekklep zurk."', 'poison', 0, 1, 'blood', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/2512.gif" />&nbsp;&nbsp;<img src="images/items/2530.gif" />&nbsp;&nbsp;<img src="images/items/3973.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/3967.gif" />&nbsp;&nbsp;<img src="images/items/3955.gif" />&nbsp;&nbsp;<img src="images/items/2385.gif" />&nbsp;&nbsp;<img src="images/items/2464.gif" />&nbsp;&nbsp;<img src="images/items/2420.gif" />&nbsp;&nbsp;<img src="images/items/2448.gif" />&nbsp;&nbsp;<img src="images/items/2007.gif" />&nbsp;&nbsp;', 'dworcvoodoomaster.gif'),
(0, 'Elephant', 500, 160, 320, 10, 0, '"Hooooot-Toooooot!", "Tooooot.", "Troooooot!"', '', 1, 1, 'blood', '<img src="images/items/3973.gif" />&nbsp;&nbsp;<img src="images/items/3956.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;', 'elephant.gif'),
(0, 'Mammoth', 0, 160, 320, 10, 0, '"Moohhhhooooo!"', '', 0, 0, 'blood', '<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;', 'mammoth.gif'),
(0, 'Elf Arcanist', 0, 175, 220, 5, 0, '"Feel my wrath!", "For the Daughter of the Stars!", "I''ll bring balance upon you!", "Tha''shi Cenath!", "Vihil Ealuel!"', 'energy, fire, poison, outfit, drunk, invisible', 0, 0, 'blood', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/1949.gif" />&nbsp;&nbsp;<img src="images/items/2578.gif" />&nbsp;&nbsp;<img src="images/items/2260.gif" />&nbsp;&nbsp;<img src="images/items/2401.gif" />&nbsp;&nbsp;<img src="images/items/2642.gif" />&nbsp;&nbsp;<img src="images/items/2682.gif" />&nbsp;&nbsp;<img src="images/items/2802.gif" />&nbsp;&nbsp;<img src="images/items/2600.gif" />&nbsp;&nbsp;<img src="images/items/2177.gif" />&nbsp;&nbsp;<img src="images/items/2689.gif" />&nbsp;&nbsp;<img src="images/items/5922.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2189.gif" />&nbsp;&nbsp;<img src="images/items/2652.gif" />&nbsp;&nbsp;<img src="images/items/2544.gif" />&nbsp;&nbsp;<img src="images/items/2456.gif" />&nbsp;&nbsp;<img src="images/items/2032.gif" />&nbsp;&nbsp;<img src="images/items/2062.gif" />&nbsp;&nbsp;<img src="images/items/2125.gif" />&nbsp;&nbsp;<img src="images/items/2154.gif" />&nbsp;&nbsp;', 'elfarcanist.gif'),
(0, 'Elf Scout', 360, 75, 160, 3, 0, '"Tha''shi Ab''Dendriel!", "Feel the sting of my arrows!", "Thy blood will quench the soil''s thirst!", "Evicor guide my arrow.", "Your existence will end here!"', 'outfit, drunk, invisible', 1, 1, 'blood', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2544.gif" />&nbsp;&nbsp;<img src="images/items/2484.gif" />&nbsp;&nbsp;<img src="images/items/2456.gif" />&nbsp;&nbsp;<img src="images/items/5922.gif" />&nbsp;&nbsp;<img src="images/items/2681.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2642.gif" />&nbsp;&nbsp;<img src="images/items/2397.gif" />&nbsp;&nbsp;<img src="images/items/5921.gif" />&nbsp;&nbsp;', 'elfscout.gif'),
(0, 'Elf', 320, 42, 100, 1, 0, '"Ulathil beia Thratha!", "Bahaha aka!", "You are not welcome here.", "Flee as long as you can.", "Death to the defilers!"', 'outfit, drunk, invisible', 1, 1, 'blood', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2544.gif" />&nbsp;&nbsp;<img src="images/items/2480.gif" />&nbsp;&nbsp;<img src="images/items/2484.gif" />&nbsp;&nbsp;<img src="images/items/2478.gif" />&nbsp;&nbsp;<img src="images/items/2643.gif" />&nbsp;&nbsp;<img src="images/items/2005.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2397.gif" />&nbsp;&nbsp;<img src="images/items/2674.gif" />&nbsp;&nbsp;<img src="images/items/2642.gif" />&nbsp;&nbsp;<img src="images/items/2456.gif" />&nbsp;&nbsp;<img src="images/items/5921.gif" />&nbsp;&nbsp;', 'elf.gif'),
(0, 'Dharalion', 0, 1200, 1200, 10, 1, '"You desecrated this temple!", "Noone will stop my ascension!", "My powers are divine!", "Muahahaha!"', 'fire, poison, lifedrain, outfit, drunk, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/1949.gif" />&nbsp;&nbsp;<img src="images/items/2578.gif" />&nbsp;&nbsp;<img src="images/items/2260.gif" />&nbsp;&nbsp;<img src="images/items/2401.gif" />&nbsp;&nbsp;<img src="images/items/2642.gif" />&nbsp;&nbsp;<img src="images/items/2682.gif" />&nbsp;&nbsp;<img src="images/items/2802.gif" />&nbsp;&nbsp;<img src="images/items/2600.gif" />&nbsp;&nbsp;<img src="images/items/2177.gif" />&nbsp;&nbsp;<img src="images/items/2689.gif" />&nbsp;&nbsp;<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2652.gif" />&nbsp;&nbsp;<img src="images/items/2544.gif" />&nbsp;&nbsp;<img src="images/items/2456.gif" />&nbsp;&nbsp;<img src="images/items/2032.gif" />&nbsp;&nbsp;<img src="images/items/2062.gif" />&nbsp;&nbsp;<img src="images/items/2125.gif" />&nbsp;&nbsp;<img src="images/items/2154.gif" />&nbsp;&nbsp;', 'dharalion.gif'),
(0, 'Charged Energy Elemental', 0, 450, 500, 25, 0, '', 'energy, invisible', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/8303.gif" />&nbsp;&nbsp;<img src="images/items/7838.gif" />&nbsp;&nbsp;', 'chargedenergyelemental.gif'),
(0, 'Energy Elemental', 0, 450, 500, 15, 0, '', 'ice, fire, energy, invisible', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/8303.gif" />&nbsp;&nbsp;<img src="images/items/7439.gif" />&nbsp;&nbsp;<img src="images/items/2150.gif" />&nbsp;&nbsp;<img src="images/items/8920.gif" />&nbsp;&nbsp;', 'energyelemental.gif'),
(0, 'Massive Energy Elemental', 0, 850, 1100, 40, 0, '', 'ice, energy, fire, invisible', 0, 0, 'undead', '', 'massiveenergyelemental.gif'),
(0, 'Overcharged Energy Elemental', 0, 1300, 1700, 40, 0, '', 'ice, energy, invisible', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/8303.gif" />&nbsp;&nbsp;<img src="images/items/7439.gif" />&nbsp;&nbsp;<img src="images/items/2150.gif" />&nbsp;&nbsp;<img src="images/items/8920.gif" />&nbsp;&nbsp;', 'overchargedenergyelemental.gif'),
(0, 'Energy Overlord', 0, 2800, 4000, 35, 0, '', 'ice, energy, poison, invisible', 0, 0, 'undead', '', 'energyoverlord.gif'),
(0, 'Cat', 200, 0, 20, 1, 0, '"Mew!", "Meow Meow!"', '', 1, 1, 'blood', '', 'cat.gif'),
(0, 'Lion', 320, 30, 80, 1, 0, '"Grrrrh"', '', 1, 1, 'blood', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;', 'lion.gif'),
(0, 'Tiger', 420, 40, 75, 10, 1, '', '', 1, 1, 'blood', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;', 'tiger.gif'),
(0, 'Azure Frog', 305, 20, 60, 5, 0, '"ribbit!ribbit!"', '', 1, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/3976.gif" />&nbsp;&nbsp;', 'azurefrog.gif'),
(0, 'Coral Frog', 305, 20, 60, 5, 0, '"ribbit!"', '', 1, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/3976.gif" />&nbsp;&nbsp;', 'coralfrog.gif'),
(0, 'Crimson Frog', 305, 20, 60, 5, 0, '"Ribbit!Ribbit!"', '', 1, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/3976.gif" />&nbsp;&nbsp;', 'crimsonfrog.gif'),
(0, 'Orchid Frog', 0, 20, 60, 5, 0, '"Ribbit!Ribbit!"', '', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/3976.gif" />&nbsp;&nbsp;', 'orchidfrog.gif'),
(0, 'Toad', 400, 60, 135, 10, 0, '"Ribbit!Ribbit!"', 'poison', 1, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/2667.gif" />&nbsp;&nbsp;<img src="images/items/2398.gif" />&nbsp;&nbsp;<img src="images/items/2382.gif" />&nbsp;&nbsp;<img src="images/items/2391.gif" />&nbsp;&nbsp;', 'toad.gif'),
(0, 'Jagged Earth Elemental', 0, 1300, 1500, 30, 0, '"Stomp STOMP"', 'paralyze, invisible, earth', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/8298.gif" />&nbsp;&nbsp;<img src="images/items/5880.gif" />&nbsp;&nbsp;<img src="images/items/2149.gif" />&nbsp;&nbsp;', 'jaggedearthelemental.gif'),
(0, 'Muddy Earth Elemental', 0, 450, 650, 20, 0, '', 'paralyze, invisible, earth', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/5880.gif" />&nbsp;&nbsp;<img src="images/items/8298.gif" />&nbsp;&nbsp;', 'muddyearthelemental.gif'),
(0, 'Earth Elemental', 0, 450, 650, 55, 0, '', 'paralyze, invisible, earth, energy', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/7850.gif" />&nbsp;&nbsp;<img src="images/items/1294.gif" />&nbsp;&nbsp;<img src="images/items/7732.gif" />&nbsp;&nbsp;', 'earthelemental.gif'),
(0, 'Massive Earth Elemental', 0, 850, 1330, 35, 0, '', 'paralyze, invisible, earth, energy', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/1294.gif" />&nbsp;&nbsp;<img src="images/items/2436.gif" />&nbsp;&nbsp;', 'massiveearthelemental.gif'),
(0, 'Earth Overlord', 0, 2800, 4000, 55, 0, '', 'paralyze, invisible, earth, energy', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2152.gif" />&nbsp;&nbsp;<img src="images/items/8305.gif" />&nbsp;&nbsp;', 'earthoverlord.gif'),
(0, 'Gargoyle', 0, 150, 450, 15, 0, '"Harrrr Harrrr!", "Stone sweet stone.", "Feel my claws, softskin.", "Chhhhhrrrrk!", "There is a stone in your shoe!"', 'fire, poison, lifedrain', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/2457.gif" />&nbsp;&nbsp;<img src="images/items/2513.gif" />&nbsp;&nbsp;<img src="images/items/2209.gif" />&nbsp;&nbsp;<img src="images/items/2394.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2489.gif" />&nbsp;&nbsp;', 'gargoyle.gif'),
(0, 'Stone Golem', 590, 280, 270, 1, 0, '', 'fire, poison, paralyze', 1, 1, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2483.gif" />&nbsp;&nbsp;<img src="images/items/5880.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/1295.gif" />&nbsp;&nbsp;<img src="images/items/1294.gif" />&nbsp;&nbsp;<img src="images/items/2395.gif" />&nbsp;&nbsp;<img src="images/items/2050.gif" />&nbsp;&nbsp;<img src="images/items/2580.gif" />&nbsp;&nbsp;', 'stonegolem.gif'),
(0, 'Grorlam', 0, 2400, 3000, 30, 1, '', 'fire, poison, paralyze', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2483.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/1295.gif" />&nbsp;&nbsp;<img src="images/items/1294.gif" />&nbsp;&nbsp;<img src="images/items/2395.gif" />&nbsp;&nbsp;<img src="images/items/2050.gif" />&nbsp;&nbsp;<img src="images/items/2580.gif" />&nbsp;&nbsp;', 'grorlam.gif'),
(0, 'Ghost', 100, 120, 150, 1, 0, '"Huh!", "Shhhhhh", "Buuuuuh"', 'physical, earth, death, lifedrain, paralyze', 0, 0, 'UNDEAD', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2642.gif" />&nbsp;&nbsp;<img src="images/items/2404.gif" />&nbsp;&nbsp;<img src="images/items/5909.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2394.gif" />&nbsp;&nbsp;<img src="images/items/2804.gif" />&nbsp;&nbsp;<img src="images/items/2532.gif" />&nbsp;&nbsp;<img src="images/items/2182.gif" />&nbsp;&nbsp;<img src="images/items/2165.gif" />&nbsp;&nbsp;<img src="images/items/2423.gif" />&nbsp;&nbsp;<img src="images/items/1962.gif" />&nbsp;&nbsp;', 'ghost.gif'),
(0, 'Phantasm', 0, 0, 65, 15, 0, '"Oh my, you forgot to put your pants on!", "Weeheeheeheehee!", "Its nothing but a dream!", "Give in!"', '', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;', 'phantasm.gif'),
(0, 'Pirate Ghost', 0, 250, 275, 5, 0, '"Yooh Ho Hooh Ho!", "Hell is waiting for You!"', 'physical, poison, lifedrain, paralyze, outfit, drunk, invisible', 0, 0, 'UNDEAD', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2655.gif" />&nbsp;&nbsp;<img src="images/items/2237.gif" />&nbsp;&nbsp;<img src="images/items/2236.gif" />&nbsp;&nbsp;<img src="images/items/2165.gif" />&nbsp;&nbsp;<img src="images/items/2383.gif" />&nbsp;&nbsp;<img src="images/items/1951.gif" />&nbsp;&nbsp;<img src="images/items/5917.gif" />&nbsp;&nbsp;', 'pirateghost.gif'),
(0, 'Spectre', 0, 1350, 1350, 15, 0, '"Revenge ... is so ... sweet!", "Life...force!", "Feed me your... lifeforce!"', 'earth, death, lifedrain, paralyze, invisible', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2152.gif" />&nbsp;&nbsp;<img src="images/items/2260.gif" />&nbsp;&nbsp;<img src="images/items/5909.gif" />&nbsp;&nbsp;<img src="images/items/2134.gif" />&nbsp;&nbsp;<img src="images/items/2642.gif" />&nbsp;&nbsp;<img src="images/items/2071.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2189.gif" />&nbsp;&nbsp;<img src="images/items/6500.gif" />&nbsp;&nbsp;<img src="images/items/5944.gif" />&nbsp;&nbsp;<img src="images/items/6300.gif" />&nbsp;&nbsp;<img src="images/items/2136.gif" />&nbsp;&nbsp;', 'spectre.gif'),
(0, 'Wisp', 0, 65, 115, 1, 1, '', 'physical, paralyze, drunk', 0, 1, 'undead', '', 'wisp.gif'),
(0, 'Frost Giant', 490, 150, 270, 8, 0, '"Hmm Humansoup", "Stand still ya tasy snack!", "Joh Thun!", "Brore Smode!", "Horre Sjan Flan!"', 'ice', 0, 1, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2406.gif" />&nbsp;&nbsp;<img src="images/items/2381.gif" />&nbsp;&nbsp;<img src="images/items/7441.gif" />&nbsp;&nbsp;<img src="images/items/2510.gif" />&nbsp;&nbsp;<img src="images/items/7290.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2513.gif" />&nbsp;&nbsp;<img src="images/items/2490.gif" />&nbsp;&nbsp;<img src="images/items/2209.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;', 'frostgiant.gif'),
(0, 'Frost Giantess', 490, 150, 275, 3, 0, '"Ymirs Mjalle!", "No run so much, must stay fat!", "Horre, Sjan Flan!", "Damned fast food.", "Come kiss the cook!"', 'ice', 0, 1, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2406.gif" />&nbsp;&nbsp;<img src="images/items/2381.gif" />&nbsp;&nbsp;<img src="images/items/2209.gif" />&nbsp;&nbsp;<img src="images/items/2510.gif" />&nbsp;&nbsp;<img src="images/items/7290.gif" />&nbsp;&nbsp;<img src="images/items/2490.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2513.gif" />&nbsp;&nbsp;<img src="images/items/7441.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;', 'frostgiantess.gif'),
(0, 'Cyclops Smith', 490, 255, 435, 1, 0, '"Whack da humy", "Outis emoi g'' onoma."', '', 1, 1, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2406.gif" />&nbsp;&nbsp;<img src="images/items/2381.gif" />&nbsp;&nbsp;<img src="images/items/2209.gif" />&nbsp;&nbsp;<img src="images/items/2490.gif" />&nbsp;&nbsp;<img src="images/items/2129.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2513.gif" />&nbsp;&nbsp;<img src="images/items/2511.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;', 'cyclopssmith.gif'),
(0, 'Cyclops Drone', 490, 200, 325, 1, 0, '"Fee! Fie! Foe! Fum!", "Luttl pest!"', '', 1, 1, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2513.gif" />&nbsp;&nbsp;<img src="images/items/2406.gif" />&nbsp;&nbsp;<img src="images/items/2381.gif" />&nbsp;&nbsp;<img src="images/items/7588.gif" />&nbsp;&nbsp;<img src="images/items/2129.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;', 'cyclopsdrone.gif'),
(0, 'Behemoth', 0, 2500, 4000, 30, 1, '"You''re so little!", "Human flesh - delicious!", "Crush the intruders!"', 'lifedrain, paralyze, outfit, drunk, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;<img src="images/items/2023.gif" />&nbsp;&nbsp;<img src="images/items/7368.gif" />&nbsp;&nbsp;<img src="images/items/2174.gif" />&nbsp;&nbsp;<img src="images/items/2387.gif" />&nbsp;&nbsp;<img src="images/items/2377.gif" />&nbsp;&nbsp;<img src="images/items/2231.gif" />&nbsp;&nbsp;<img src="images/items/5930.gif" />&nbsp;&nbsp;<img src="images/items/2393.gif" />&nbsp;&nbsp;<img src="images/items/2454.gif" />&nbsp;&nbsp;<img src="images/items/2150.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2463.gif" />&nbsp;&nbsp;<img src="images/items/2553.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/2489.gif" />&nbsp;&nbsp;<img src="images/items/2125.gif" />&nbsp;&nbsp;<img src="images/items/2416.gif" />&nbsp;&nbsp;<img src="images/items/2645.gif" />&nbsp;&nbsp;<img src="images/items/2188.gif" />&nbsp;&nbsp;<img src="images/items/2161.gif" />&nbsp;&nbsp;<img src="images/items/5893.gif" />&nbsp;&nbsp;', 'behemoth.gif'),
(0, 'Cyclops', 490, 150, 260, 1, 0, '"Il lorstok human!", "Toks utat.", "Human, uh whil dyh!", "Youh ah trak!", "Let da mashing begin!"', '', 1, 1, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2209.gif" />&nbsp;&nbsp;<img src="images/items/2490.gif" />&nbsp;&nbsp;<img src="images/items/2129.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2406.gif" />&nbsp;&nbsp;<img src="images/items/2513.gif" />&nbsp;&nbsp;<img src="images/items/2511.gif" />&nbsp;&nbsp;<img src="images/items/2381.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;', 'cyclops.gif'),
(0, 'Stonecracker', 0, 3500, 4000, 45, 1, '"HUAHAHA"', 'paralyze, invisible', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;<img src="images/items/2023.gif" />&nbsp;&nbsp;<img src="images/items/7368.gif" />&nbsp;&nbsp;<img src="images/items/2174.gif" />&nbsp;&nbsp;<img src="images/items/2387.gif" />&nbsp;&nbsp;<img src="images/items/2377.gif" />&nbsp;&nbsp;<img src="images/items/2231.gif" />&nbsp;&nbsp;<img src="images/items/5930.gif" />&nbsp;&nbsp;<img src="images/items/2393.gif" />&nbsp;&nbsp;<img src="images/items/2454.gif" />&nbsp;&nbsp;<img src="images/items/2150.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2463.gif" />&nbsp;&nbsp;<img src="images/items/2553.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/2489.gif" />&nbsp;&nbsp;<img src="images/items/2125.gif" />&nbsp;&nbsp;<img src="images/items/2416.gif" />&nbsp;&nbsp;<img src="images/items/2645.gif" />&nbsp;&nbsp;<img src="images/items/2188.gif" />&nbsp;&nbsp;<img src="images/items/2161.gif" />&nbsp;&nbsp;<img src="images/items/5893.gif" />&nbsp;&nbsp;', 'stonecracker.gif'),
(0, 'Slick Water Elemental', 0, 450, 550, 30, 0, '"Blubb", "Splipsh Splash"', 'ice', 0, 0, 'undead', '', 'slickwaterelemental.gif'),
(0, 'Roaring Water Elemental', 0, 1300, 1750, 85, 0, '', 'fire, lifedrain, paralyze, invisible', 0, 0, 'undead', '', 'roaringwaterelemental.gif'),
(0, 'Ice Overlord', 0, 1950, 2800, 85, 0, '', 'fire, lifedrain, paralyze, invisible', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/8300.gif" />&nbsp;&nbsp;<img src="images/items/8878.gif" />&nbsp;&nbsp;', 'iceoverlord.gif'),
(0, 'Water Elemental', 0, 450, 550, 30, 0, '', 'ice, fire, poison, paralyze, invisible', 0, 0, 'undead', '', 'waterelemental.gif'),
(0, 'Massive Water Elemental', 0, 1950, 2350, 85, 0, '', 'fire, lifedrain, paralyze, outfit, drunk, invisible', 0, 0, 'undead', '', 'massivewaterelemental.gif'),
(0, 'Ancient Scarab', 0, 720, 1000, 55, 1, '', 'earth, paralyze, invisible', 0, 0, 'VENOM', '<img src="images/items/2150.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2162.gif" />&nbsp;&nbsp;<img src="images/items/2463.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2149.gif" />&nbsp;&nbsp;<img src="images/items/2135.gif" />&nbsp;&nbsp;<img src="images/items/2159.gif" />&nbsp;&nbsp;<img src="images/items/2142.gif" />&nbsp;&nbsp;<img src="images/items/2440.gif" />&nbsp;&nbsp;<img src="images/items/2540.gif" />&nbsp;&nbsp;', 'ancientscarab.gif'),
(0, 'Bug', 250, 18, 29, 1, 0, '', '', 1, 1, 'venom', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2679.gif" />&nbsp;&nbsp;', 'bug.gif'),
(0, 'Centipede', 335, 30, 70, 1, 0, '', 'poison', 1, 1, 'venom', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2480.gif" />&nbsp;&nbsp;<img src="images/items/2530.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2398.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;<img src="images/items/2376.gif" />&nbsp;&nbsp;<img src="images/items/2412.gif" />&nbsp;&nbsp;', 'centipede.gif'),
(0, 'Cockroach', 0, 0, 1, 1, 0, '', 'poison', 0, 0, 'venom', '<img src="images/items/8616.gif" />&nbsp;&nbsp;', 'cockroach.gif'),
(0, 'Exp Bug', 250, 2000000, 29, 10, 0, '', '', 0, 1, 'venom', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2679.gif" />&nbsp;&nbsp;', 'expbug.gif'),
(0, 'Larva', 355, 40, 70, 1, 0, '', 'poison, paralyze', 1, 1, 'VENOM', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;', 'larva.gif'),
(0, 'Scarab', 395, 120, 320, 1, 1, '', 'earth, paralyze', 1, 1, 'VENOM', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/2544.gif" />&nbsp;&nbsp;<img src="images/items/2439.gif" />&nbsp;&nbsp;<img src="images/items/2442.gif" />&nbsp;&nbsp;<img src="images/items/2159.gif" />&nbsp;&nbsp;<img src="images/items/2149.gif" />&nbsp;&nbsp;<img src="images/items/2150.gif" />&nbsp;&nbsp;', 'scarab.gif'),
(0, 'Wasp', 280, 25, 35, 120, 0, '"Bsssssss"', 'poison', 1, 1, 'VENOM', '<img src="images/items/5902.gif" />&nbsp;&nbsp;', 'wasp.gif'),
(0, 'Lizard Sentinel', 0, 110, 265, 10, 0, '"Tssss!"', 'earth, invisible', 0, 1, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2182.gif" />&nbsp;&nbsp;<img src="images/items/2425.gif" />&nbsp;&nbsp;<img src="images/items/2381.gif" />&nbsp;&nbsp;<img src="images/items/2457.gif" />&nbsp;&nbsp;<img src="images/items/3974.gif" />&nbsp;&nbsp;<img src="images/items/3965.gif" />&nbsp;&nbsp;<img src="images/items/5876.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2147.gif" />&nbsp;&nbsp;<img src="images/items/2654.gif" />&nbsp;&nbsp;<img src="images/items/5881.gif" />&nbsp;&nbsp;', 'lizardsentinel.gif'),
(0, 'Lizard Snakecharmer', 0, 210, 325, 1, 0, '"I ssssmell warm blood!", "Shhhhhhhh"', 'poison, outfit, drunk, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2154.gif" />&nbsp;&nbsp;<img src="images/items/2191.gif" />&nbsp;&nbsp;<img src="images/items/2182.gif" />&nbsp;&nbsp;<img src="images/items/5876.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2181.gif" />&nbsp;&nbsp;<img src="images/items/2150.gif" />&nbsp;&nbsp;<img src="images/items/2654.gif" />&nbsp;&nbsp;<img src="images/items/5881.gif" />&nbsp;&nbsp;', 'lizardsnakecharmer.gif'),
(0, 'Lizard Templar', 0, 115, 410, 1, 0, '"Hissss!"', 'earth', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2376.gif" />&nbsp;&nbsp;<img src="images/items/3973.gif" />&nbsp;&nbsp;<img src="images/items/2463.gif" />&nbsp;&nbsp;<img src="images/items/5876.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/3974.gif" />&nbsp;&nbsp;<img src="images/items/2457.gif" />&nbsp;&nbsp;<img src="images/items/3963.gif" />&nbsp;&nbsp;<img src="images/items/5881.gif" />&nbsp;&nbsp;', 'lizardtemplar.gif'),
(0, 'Minotaur Archer', 390, 65, 100, 1, 0, '"Ruan Wihmpy!", "Kaplar!"', '', 1, 1, 'blood', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2543.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/2483.gif" />&nbsp;&nbsp;<img src="images/items/2481.gif" />&nbsp;&nbsp;<img src="images/items/5878.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2455.gif" />&nbsp;&nbsp;<img src="images/items/7363.gif" />&nbsp;&nbsp;<img src="images/items/2465.gif" />&nbsp;&nbsp;<img src="images/items/2464.gif" />&nbsp;&nbsp;<img src="images/items/2648.gif" />&nbsp;&nbsp;<img src="images/items/2458.gif" />&nbsp;&nbsp;', 'minotaurarcher.gif'),
(0, 'Minotaur Guard', 550, 160, 185, 1, 0, '"Kirll Karrrl!", "Kaplar!"', '', 1, 1, 'blood', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/2387.gif" />&nbsp;&nbsp;<img src="images/items/2649.gif" />&nbsp;&nbsp;<img src="images/items/5878.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2386.gif" />&nbsp;&nbsp;<img src="images/items/2580.gif" />&nbsp;&nbsp;<img src="images/items/2648.gif" />&nbsp;&nbsp;<img src="images/items/2458.gif" />&nbsp;&nbsp;<img src="images/items/2465.gif" />&nbsp;&nbsp;<img src="images/items/2513.gif" />&nbsp;&nbsp;', 'minotaurguard.gif'),
(0, 'Minotaur Mage', 0, 150, 155, 1, 0, '"#W Learrn tha secrret uf deathhh!", "Kaplar!"', 'energy, outfit, drunk, invisible', 0, 0, 'blood', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2050.gif" />&nbsp;&nbsp;<img src="images/items/2461.gif" />&nbsp;&nbsp;<img src="images/items/2649.gif" />&nbsp;&nbsp;<img src="images/items/5878.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2189.gif" />&nbsp;&nbsp;<img src="images/items/2404.gif" />&nbsp;&nbsp;<img src="images/items/2362.gif" />&nbsp;&nbsp;<img src="images/items/2817.gif" />&nbsp;&nbsp;<img src="images/items/2311.gif" />&nbsp;&nbsp;<img src="images/items/2465.gif" />&nbsp;&nbsp;<img src="images/items/2648.gif" />&nbsp;&nbsp;<img src="images/items/7425.gif" />&nbsp;&nbsp;', 'minotaurmage.gif'),
(0, 'Minotaur', 330, 50, 100, 1, 0, '"kaplar!"', '', 1, 1, 'blood', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2464.gif" />&nbsp;&nbsp;<img src="images/items/2386.gif" />&nbsp;&nbsp;<img src="images/items/2649.gif" />&nbsp;&nbsp;<img src="images/items/2554.gif" />&nbsp;&nbsp;<img src="images/items/5878.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2458.gif" />&nbsp;&nbsp;<img src="images/items/2460.gif" />&nbsp;&nbsp;<img src="images/items/2510.gif" />&nbsp;&nbsp;<img src="images/items/2398.gif" />&nbsp;&nbsp;<img src="images/items/2172.gif" />&nbsp;&nbsp;', 'minotaur.gif'),
(0, 'Apprentice Sheng', 0, 100, 95, 1, 0, '"I will protect the secrets of my master!", "This isle will become ours alone!", "Kaplar!"', 'energy', 0, 0, 'blood', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2050.gif" />&nbsp;&nbsp;<img src="images/items/2461.gif" />&nbsp;&nbsp;<img src="images/items/2649.gif" />&nbsp;&nbsp;<img src="images/items/5878.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2404.gif" />&nbsp;&nbsp;<img src="images/items/2362.gif" />&nbsp;&nbsp;<img src="images/items/2817.gif" />&nbsp;&nbsp;<img src="images/items/2311.gif" />&nbsp;&nbsp;<img src="images/items/7425.gif" />&nbsp;&nbsp;', 'apprenticesheng.gif'),
(0, 'The Horned Fox', 0, 200, 265, 1, 0, '"You will never get me!", "I''ll be back!", "Catch me, if you can!", "Help me, boys!"', 'outfit, drunk, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2410.gif" />&nbsp;&nbsp;<img src="images/items/2419.gif" />&nbsp;&nbsp;<img src="images/items/2510.gif" />&nbsp;&nbsp;<img src="images/items/2667.gif" />&nbsp;&nbsp;<img src="images/items/2647.gif" />&nbsp;&nbsp;<img src="images/items/2413.gif" />&nbsp;&nbsp;<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/5804.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2189.gif" />&nbsp;&nbsp;<img src="images/items/2207.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/2379.gif" />&nbsp;&nbsp;<img src="images/items/2475.gif" />&nbsp;&nbsp;<img src="images/items/2397.gif" />&nbsp;&nbsp;<img src="images/items/2652.gif" />&nbsp;&nbsp;<img src="images/items/2478.gif" />&nbsp;&nbsp;<img src="images/items/2463.gif" />&nbsp;&nbsp;', 'thehornedfox.gif'),
(0, 'General Murius', 0, 1300, 1200, 10, 0, '"Feel the power of the Mooh''Tah!", "You will get what you deserve!", "For the king!", "Guards!"', 'lifedrain, outfit, drunk, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2410.gif" />&nbsp;&nbsp;<img src="images/items/2419.gif" />&nbsp;&nbsp;<img src="images/items/2510.gif" />&nbsp;&nbsp;<img src="images/items/2667.gif" />&nbsp;&nbsp;<img src="images/items/2647.gif" />&nbsp;&nbsp;<img src="images/items/2413.gif" />&nbsp;&nbsp;<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/1988.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2207.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/2379.gif" />&nbsp;&nbsp;<img src="images/items/2475.gif" />&nbsp;&nbsp;<img src="images/items/2397.gif" />&nbsp;&nbsp;<img src="images/items/2652.gif" />&nbsp;&nbsp;<img src="images/items/2478.gif" />&nbsp;&nbsp;<img src="images/items/2463.gif" />&nbsp;&nbsp;', 'generalmurius.gif'),
(0, 'Squirrel', 200, 0, 15, 1, 0, '"ChChCh"', '', 1, 1, 'blood', '<img src="images/items/2684.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/6541.gif" />&nbsp;&nbsp;<img src="images/items/6542.gif" />&nbsp;&nbsp;<img src="images/items/6543.gif" />&nbsp;&nbsp;<img src="images/items/6544.gif" />&nbsp;&nbsp;<img src="images/items/6545.gif" />&nbsp;&nbsp;<img src="images/items/1989.gif" />&nbsp;&nbsp;', 'squirrel.gif'),
(0, 'Goblin Demon', 290, 25, 50, 1, 0, '"MUHAHAHAHA!", "I SMELL FEEEEEAAAR!", "CHAMEK ATH UTHUL ARAK!", "Your resistance is futile!", "Your soul will be mine!"', '', 1, 1, 'blood', '<img src="images/items/2230.gif" />&nbsp;&nbsp;<img src="images/items/2449.gif" />&nbsp;&nbsp;<img src="images/items/2379.gif" />&nbsp;&nbsp;<img src="images/items/2667.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2467.gif" />&nbsp;&nbsp;<img src="images/items/2461.gif" />&nbsp;&nbsp;<img src="images/items/2235.gif" />&nbsp;&nbsp;<img src="images/items/2406.gif" />&nbsp;&nbsp;<img src="images/items/2559.gif" />&nbsp;&nbsp;<img src="images/items/1294.gif" />&nbsp;&nbsp;', 'goblindemon.gif'),
(0, 'Badger', 200, 5, 20, 1, 0, '', '', 1, 1, 'blood', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;', 'badger.gif'),
(0, 'Bat', 250, 10, 30, 1, 0, '', '', 1, 1, 'blood', '<img src="images/items/5894.gif" />&nbsp;&nbsp;', 'bat.gif'),
(0, 'Deer', 260, 0, 25, 1, 0, '', '', 1, 1, 'blood', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;', 'deer.gif'),
(0, 'The Halloween Hare', 0, 0, 2000, 1, 0, '', '', 0, 0, 'blood', '', 'thehalloweenhare.gif'),
(0, 'Hyaena', 275, 20, 60, 1, 0, '', '', 1, 1, 'blood', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;', 'hyaena.gif'),
(0, 'Pig', 255, 0, 150, 1, 0, '', '', 1, 1, 'blood', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;', 'pig.gif'),
(0, 'Rabbit', 220, 0, 15, 1, 0, '', '', 1, 1, 'blood', '<img src="images/items/2684.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;', 'rabbit.gif'),
(0, 'Silver Rabbit', 220, 0, 15, 1, 0, '', '', 1, 1, 'blood', '<img src="images/items/2362.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;', 'silverrabbit.gif'),
(0, 'Skunk', 200, 3, 20, 1, 0, '', 'poison', 1, 1, 'blood', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;', 'skunk.gif'),
(0, 'Dark Monk', 0, 145, 1200, 1, 1, '"This is where your path will end!", "Your end has come.", "You are no match for us!"', 'outfit, drunk, invisible', 0, 1, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2439.gif" />&nbsp;&nbsp;<img src="images/items/1949.gif" />&nbsp;&nbsp;<img src="images/items/2467.gif" />&nbsp;&nbsp;<img src="images/items/2642.gif" />&nbsp;&nbsp;<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2177.gif" />&nbsp;&nbsp;<img src="images/items/2044.gif" />&nbsp;&nbsp;<img src="images/items/2689.gif" />&nbsp;&nbsp;<img src="images/items/2401.gif" />&nbsp;&nbsp;<img src="images/items/2440.gif" />&nbsp;&nbsp;<img src="images/items/2166.gif" />&nbsp;&nbsp;', 'darkmonk.gif'),
(0, 'Monk', 600, 200, 240, 1, 1, '"''Repent heretic!, Feel my kick!. A prayer for Zathroth"', 'outfit, drunk, invisible', 1, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/1949.gif" />&nbsp;&nbsp;<img src="images/items/2467.gif" />&nbsp;&nbsp;<img src="images/items/2642.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2044.gif" />&nbsp;&nbsp;<img src="images/items/2689.gif" />&nbsp;&nbsp;<img src="images/items/2401.gif" />&nbsp;&nbsp;<img src="images/items/2166.gif" />&nbsp;&nbsp;', 'monk.gif'),
(0, 'Tha Exp Carrier', 600, 2000, 1000000, 60, 1, '"Come kill me and get exp ^^"', 'outfit, drunk, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/1949.gif" />&nbsp;&nbsp;<img src="images/items/2467.gif" />&nbsp;&nbsp;<img src="images/items/2642.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2044.gif" />&nbsp;&nbsp;<img src="images/items/2689.gif" />&nbsp;&nbsp;<img src="images/items/2401.gif" />&nbsp;&nbsp;<img src="images/items/2166.gif" />&nbsp;&nbsp;', 'thaexpcarrier.gif'),
(0, 'Fernfang', 0, 320, 250, 10, 1, '"You desecrated this place!", "I will cleanse this isle!", "Grrrrrrr", "Yoooohhuuuu!"', 'poison, lifedrain, outfit, drunk, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/1949.gif" />&nbsp;&nbsp;<img src="images/items/2467.gif" />&nbsp;&nbsp;<img src="images/items/2642.gif" />&nbsp;&nbsp;<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2044.gif" />&nbsp;&nbsp;<img src="images/items/2689.gif" />&nbsp;&nbsp;<img src="images/items/2401.gif" />&nbsp;&nbsp;<img src="images/items/2166.gif" />&nbsp;&nbsp;', 'fernfang.gif'),
(0, 'Trainer', 0, 0, 240000, 1, 0, '', 'invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/1949.gif" />&nbsp;&nbsp;<img src="images/items/2467.gif" />&nbsp;&nbsp;<img src="images/items/2642.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2044.gif" />&nbsp;&nbsp;<img src="images/items/2689.gif" />&nbsp;&nbsp;<img src="images/items/2401.gif" />&nbsp;&nbsp;<img src="images/items/2166.gif" />&nbsp;&nbsp;', 'trainer.gif');
INSERT INTO `z_monsters` (`hide_creature`, `name`, `mana`, `exp`, `health`, `speed_lvl`, `use_haste`, `voices`, `immunities`, `summonable`, `convinceable`, `race`, `loot`, `gfx_name`) VALUES
(0, 'Target', 0, 0, 240000, 1, 0, '', 'invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/1949.gif" />&nbsp;&nbsp;<img src="images/items/2467.gif" />&nbsp;&nbsp;<img src="images/items/2642.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2044.gif" />&nbsp;&nbsp;<img src="images/items/2689.gif" />&nbsp;&nbsp;<img src="images/items/2401.gif" />&nbsp;&nbsp;<img src="images/items/2166.gif" />&nbsp;&nbsp;', 'target.gif'),
(0, 'Training', 0, 0, 240000, 1, 0, '', 'invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/1949.gif" />&nbsp;&nbsp;<img src="images/items/2467.gif" />&nbsp;&nbsp;<img src="images/items/2642.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2044.gif" />&nbsp;&nbsp;<img src="images/items/2689.gif" />&nbsp;&nbsp;<img src="images/items/2401.gif" />&nbsp;&nbsp;<img src="images/items/2166.gif" />&nbsp;&nbsp;', 'training.gif'),
(0, 'Necromancer', 0, 580, 580, 1, 0, '"Your corpse will be mine!", "Taste the sweetness of death!"', 'earth, invisible', 0, 0, 'blood', '<img src="images/items/2186.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2032.gif" />&nbsp;&nbsp;<img src="images/items/2804.gif" />&nbsp;&nbsp;<img src="images/items/2182.gif" />&nbsp;&nbsp;<img src="images/items/2406.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2412.gif" />&nbsp;&nbsp;<img src="images/items/2483.gif" />&nbsp;&nbsp;<img src="images/items/2796.gif" />&nbsp;&nbsp;<img src="images/items/2229.gif" />&nbsp;&nbsp;<img src="images/items/2747.gif" />&nbsp;&nbsp;<img src="images/items/2436.gif" />&nbsp;&nbsp;<img src="images/items/2663.gif" />&nbsp;&nbsp;<img src="images/items/2195.gif" />&nbsp;&nbsp;<img src="images/items/2423.gif" />&nbsp;&nbsp;', 'necromancer.gif'),
(0, 'Priestess', 0, 420, 390, 1, 0, '"Your energy is mine.", "Now, your life has come to an end, hahahha!", "Throw the soul on the altar!"', 'invisible', 0, 0, 'blood', '<img src="images/items/2674.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2183.gif" />&nbsp;&nbsp;<img src="images/items/1977.gif" />&nbsp;&nbsp;<img src="images/items/2032.gif" />&nbsp;&nbsp;<img src="images/items/2070.gif" />&nbsp;&nbsp;<img src="images/items/2529.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2423.gif" />&nbsp;&nbsp;<img src="images/items/2379.gif" />&nbsp;&nbsp;<img src="images/items/2125.gif" />&nbsp;&nbsp;<img src="images/items/2802.gif" />&nbsp;&nbsp;<img src="images/items/2803.gif" />&nbsp;&nbsp;<img src="images/items/2420.gif" />&nbsp;&nbsp;<img src="images/items/2143.gif" />&nbsp;&nbsp;<img src="images/items/2760.gif" />&nbsp;&nbsp;<img src="images/items/2791.gif" />&nbsp;&nbsp;<img src="images/items/2192.gif" />&nbsp;&nbsp;<img src="images/items/2114.gif" />&nbsp;&nbsp;<img src="images/items/2134.gif" />&nbsp;&nbsp;<img src="images/items/2151.gif" />&nbsp;&nbsp;<img src="images/items/2145.gif" />&nbsp;&nbsp;', 'priestess.gif'),
(0, 'Necropharus', 0, 1100, 800, 10, 0, '"You will rise as my servant!", "Praise to my master Urgith!"', 'poison, lifedrain, outfit, drunk, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/5809.gif" />&nbsp;&nbsp;<img src="images/items/3969.gif" />&nbsp;&nbsp;<img src="images/items/2392.gif" />&nbsp;&nbsp;<img src="images/items/2804.gif" />&nbsp;&nbsp;<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2186.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2483.gif" />&nbsp;&nbsp;<img src="images/items/2796.gif" />&nbsp;&nbsp;<img src="images/items/2231.gif" />&nbsp;&nbsp;<img src="images/items/2230.gif" />&nbsp;&nbsp;<img src="images/items/2449.gif" />&nbsp;&nbsp;<img src="images/items/2541.gif" />&nbsp;&nbsp;<img src="images/items/2412.gif" />&nbsp;&nbsp;<img src="images/items/2229.gif" />&nbsp;&nbsp;<img src="images/items/2747.gif" />&nbsp;&nbsp;<img src="images/items/2436.gif" />&nbsp;&nbsp;<img src="images/items/2663.gif" />&nbsp;&nbsp;<img src="images/items/2195.gif" />&nbsp;&nbsp;<img src="images/items/2423.gif" />&nbsp;&nbsp;', 'necropharus.gif'),
(0, 'Orc Berserker', 590, 195, 210, 15, 1, '"KRAK ORRRRRRK!"', 'poison', 1, 1, 'blood', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/2381.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2464.gif" />&nbsp;&nbsp;<img src="images/items/2458.gif" />&nbsp;&nbsp;<img src="images/items/2044.gif" />&nbsp;&nbsp;<img src="images/items/2378.gif" />&nbsp;&nbsp;', 'orcberserker.gif'),
(0, 'Orc Leader', 640, 270, 450, 5, 0, '"Ulderek futgyr human!"', 'fire, outfit, drunk, invisible', 1, 1, 'blood', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2410.gif" />&nbsp;&nbsp;<img src="images/items/2419.gif" />&nbsp;&nbsp;<img src="images/items/2510.gif" />&nbsp;&nbsp;<img src="images/items/2667.gif" />&nbsp;&nbsp;<img src="images/items/2647.gif" />&nbsp;&nbsp;<img src="images/items/2413.gif" />&nbsp;&nbsp;<img src="images/items/1988.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2207.gif" />&nbsp;&nbsp;<img src="images/items/7378.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/2379.gif" />&nbsp;&nbsp;<img src="images/items/2475.gif" />&nbsp;&nbsp;<img src="images/items/2397.gif" />&nbsp;&nbsp;<img src="images/items/2652.gif" />&nbsp;&nbsp;<img src="images/items/2478.gif" />&nbsp;&nbsp;<img src="images/items/2463.gif" />&nbsp;&nbsp;', 'orcleader.gif'),
(0, 'Orc Rider', 0, 110, 180, 60, 1, '"Grrrrrrr", "Orc arga Huummmak!"', '', 0, 1, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/2129.gif" />&nbsp;&nbsp;<img src="images/items/1988.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2428.gif" />&nbsp;&nbsp;<img src="images/items/2480.gif" />&nbsp;&nbsp;<img src="images/items/2425.gif" />&nbsp;&nbsp;<img src="images/items/2513.gif" />&nbsp;&nbsp;', 'orcrider.gif'),
(0, 'Orc Shaman', 0, 110, 115, 1, 0, '', 'energy, poison, outfit, drunk, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2401.gif" />&nbsp;&nbsp;<img src="images/items/2458.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2817.gif" />&nbsp;&nbsp;<img src="images/items/2389.gif" />&nbsp;&nbsp;<img src="images/items/2079.gif" />&nbsp;&nbsp;<img src="images/items/2190.gif" />&nbsp;&nbsp;<img src="images/items/2188.gif" />&nbsp;&nbsp;', 'orcshaman.gif'),
(0, 'Orc Spearman', 310, 38, 105, 1, 0, '"Ugaar!"', '', 1, 1, 'blood', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/2468.gif" />&nbsp;&nbsp;<img src="images/items/2220.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2420.gif" />&nbsp;&nbsp;<img src="images/items/2389.gif" />&nbsp;&nbsp;', 'orcspearman.gif'),
(0, 'Orc Warlord', 0, 670, 950, 15, 0, '"Ranat Ulderek!", "Orc buta bana!", "Ikem rambo zambo!", "Futchi maruk buta!"', 'fire, outfit, drunk, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/2667.gif" />&nbsp;&nbsp;<img src="images/items/2392.gif" />&nbsp;&nbsp;<img src="images/items/2647.gif" />&nbsp;&nbsp;<img src="images/items/2463.gif" />&nbsp;&nbsp;<img src="images/items/2399.gif" />&nbsp;&nbsp;<img src="images/items/2428.gif" />&nbsp;&nbsp;<img src="images/items/1988.gif" />&nbsp;&nbsp;<img src="images/items/2478.gif" />&nbsp;&nbsp;<img src="images/items/2165.gif" />&nbsp;&nbsp;<img src="images/items/2200.gif" />&nbsp;&nbsp;<img src="images/items/2490.gif" />&nbsp;&nbsp;<img src="images/items/2377.gif" />&nbsp;&nbsp;<img src="images/items/2434.gif" />&nbsp;&nbsp;<img src="images/items/2497.gif" />&nbsp;&nbsp;<img src="images/items/2179.gif" />&nbsp;&nbsp;<img src="images/items/2499.gif" />&nbsp;&nbsp;<img src="images/items/2500.gif" />&nbsp;&nbsp;<img src="images/items/2537.gif" />&nbsp;&nbsp;', 'orcwarlord.gif'),
(0, 'Orc Warrior', 360, 50, 125, 1, 0, '"Grow truk grrrr.", "Trak grrrr brik.", "Alk!"', '', 1, 1, 'blood', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/2512.gif" />&nbsp;&nbsp;<img src="images/items/2530.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2385.gif" />&nbsp;&nbsp;<img src="images/items/2464.gif" />&nbsp;&nbsp;<img src="images/items/2420.gif" />&nbsp;&nbsp;<img src="images/items/2448.gif" />&nbsp;&nbsp;<img src="images/items/2007.gif" />&nbsp;&nbsp;', 'orcwarrior.gif'),
(0, 'Orc', 300, 25, 70, 1, 0, '"Grak brrretz!", "Grow truk grrrrr.", "Prek tars, dekklep zurk."', '', 1, 1, 'blood', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/2484.gif" />&nbsp;&nbsp;<img src="images/items/2480.gif" />&nbsp;&nbsp;<img src="images/items/2385.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2526.gif" />&nbsp;&nbsp;<img src="images/items/2386.gif" />&nbsp;&nbsp;', 'orc.gif'),
(0, 'Warlord Ruzad', 0, 1700, 1950, 25, 0, '"Ranat Ulderek!", "Orc buta bana!", "Ikem rambo zambo!", "Futchi maruk buta!"', 'invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/2667.gif" />&nbsp;&nbsp;<img src="images/items/2392.gif" />&nbsp;&nbsp;<img src="images/items/2463.gif" />&nbsp;&nbsp;<img src="images/items/2399.gif" />&nbsp;&nbsp;<img src="images/items/2428.gif" />&nbsp;&nbsp;<img src="images/items/1988.gif" />&nbsp;&nbsp;<img src="images/items/2478.gif" />&nbsp;&nbsp;<img src="images/items/2200.gif" />&nbsp;&nbsp;<img src="images/items/2377.gif" />&nbsp;&nbsp;<img src="images/items/2497.gif" />&nbsp;&nbsp;<img src="images/items/2179.gif" />&nbsp;&nbsp;', 'warlordruzad.gif'),
(0, 'Goblin Leader', 290, 50, 75, 1, 0, '"Go go, Gobo attack !!", "Me the greenest and the meanest!", "Me have power to crush you!", "Goblinkiller! Catch him !!"', '', 1, 1, 'blood', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2461.gif" />&nbsp;&nbsp;<img src="images/items/2406.gif" />&nbsp;&nbsp;<img src="images/items/2467.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2559.gif" />&nbsp;&nbsp;<img src="images/items/1294.gif" />&nbsp;&nbsp;<img src="images/items/2667.gif" />&nbsp;&nbsp;<img src="images/items/2230.gif" />&nbsp;&nbsp;<img src="images/items/2235.gif" />&nbsp;&nbsp;<img src="images/items/2449.gif" />&nbsp;&nbsp;', 'goblinleader.gif'),
(0, 'Goblin Scavenger', 310, 37, 60, 1, 0, '"Shiny, Shiny!", "You mean!", "All mine!", "Uhh!"', '', 1, 1, 'blood', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2461.gif" />&nbsp;&nbsp;<img src="images/items/2406.gif" />&nbsp;&nbsp;<img src="images/items/2467.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2559.gif" />&nbsp;&nbsp;<img src="images/items/1294.gif" />&nbsp;&nbsp;<img src="images/items/2667.gif" />&nbsp;&nbsp;<img src="images/items/2230.gif" />&nbsp;&nbsp;<img src="images/items/2235.gif" />&nbsp;&nbsp;', 'goblinscavenger.gif'),
(0, 'Goblin', 290, 25, 50, 1, 0, '"Me have him!", "Zig Zag! Gobo attack!", "Help! Goblinkiller!", "Bugga! Bugga!", "Me green, me mean!"', '', 1, 1, 'blood', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2420.gif" />&nbsp;&nbsp;<img src="images/items/2461.gif" />&nbsp;&nbsp;<img src="images/items/2406.gif" />&nbsp;&nbsp;<img src="images/items/2467.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2559.gif" />&nbsp;&nbsp;<img src="images/items/1294.gif" />&nbsp;&nbsp;<img src="images/items/2667.gif" />&nbsp;&nbsp;<img src="images/items/2230.gif" />&nbsp;&nbsp;<img src="images/items/2235.gif" />&nbsp;&nbsp;<img src="images/items/2449.gif" />&nbsp;&nbsp;', 'goblin.gif'),
(0, 'Goblin Assassin', 360, 52, 75, 1, 0, '"Goblin Powahhh!"', '', 1, 1, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2667.gif" />&nbsp;&nbsp;<img src="images/items/2235.gif" />&nbsp;&nbsp;<img src="images/items/2461.gif" />&nbsp;&nbsp;<img src="images/items/2230.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/1294.gif" />&nbsp;&nbsp;<img src="images/items/2449.gif" />&nbsp;&nbsp;<img src="images/items/2406.gif" />&nbsp;&nbsp;<img src="images/items/2559.gif" />&nbsp;&nbsp;<img src="images/items/2379.gif" />&nbsp;&nbsp;', 'goblinassassin.gif'),
(0, 'Assasin', 450, 105, 175, 2, 1, '"Die!", "Feel the hand of death!", "You are on my deathlist!"', 'invisible', 0, 1, 'blood', '<img src="images/items/2513.gif" />&nbsp;&nbsp;<img src="images/items/2404.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2399.gif" />&nbsp;&nbsp;<img src="images/items/3969.gif" />&nbsp;&nbsp;<img src="images/items/2403.gif" />&nbsp;&nbsp;<img src="images/items/3968.gif" />&nbsp;&nbsp;<img src="images/items/2510.gif" />&nbsp;&nbsp;<img src="images/items/2145.gif" />&nbsp;&nbsp;<img src="images/items/2457.gif" />&nbsp;&nbsp;<img src="images/items/7366.gif" />&nbsp;&nbsp;<img src="images/items/2509.gif" />&nbsp;&nbsp;<img src="images/items/2050.gif" />&nbsp;&nbsp;', 'assasin.gif'),
(0, 'Black Knight', 0, 1600, 1800, 60, 0, '"MINE!", "NO PRISONERS!", "NO MERCY!", "By Bolg''s Blood!", "You''re no match for me!"', 'energy, fire, poison, paralyze, outfit, drunk, invisible', 0, 0, 'blood', '<img src="images/items/2457.gif" />&nbsp;&nbsp;<img src="images/items/2417.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2476.gif" />&nbsp;&nbsp;<img src="images/items/2489.gif" />&nbsp;&nbsp;<img src="images/items/2490.gif" />&nbsp;&nbsp;<img src="images/items/2381.gif" />&nbsp;&nbsp;<img src="images/items/2389.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2477.gif" />&nbsp;&nbsp;<img src="images/items/2691.gif" />&nbsp;&nbsp;<img src="images/items/2478.gif" />&nbsp;&nbsp;<img src="images/items/2475.gif" />&nbsp;&nbsp;<img src="images/items/2463.gif" />&nbsp;&nbsp;<img src="images/items/2120.gif" />&nbsp;&nbsp;<img src="images/items/2387.gif" />&nbsp;&nbsp;<img src="images/items/2377.gif" />&nbsp;&nbsp;<img src="images/items/2430.gif" />&nbsp;&nbsp;<img src="images/items/2414.gif" />&nbsp;&nbsp;<img src="images/items/2195.gif" />&nbsp;&nbsp;<img src="images/items/2133.gif" />&nbsp;&nbsp;', 'blackknight.gif'),
(0, 'Hero', 0, 1200, 1400, 24, 0, '"Let''s have a fight!", "Welcome to my battleground.", "Have you seen princess Lumelia?", "I will sing a tune at your grave."', 'paralyze, invisible', 0, 0, 'blood', '<img src="images/items/2491.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2120.gif" />&nbsp;&nbsp;<img src="images/items/1949.gif" />&nbsp;&nbsp;<img src="images/items/2456.gif" />&nbsp;&nbsp;<img src="images/items/2661.gif" />&nbsp;&nbsp;<img src="images/items/2681.gif" />&nbsp;&nbsp;<img src="images/items/2121.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/5911.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2377.gif" />&nbsp;&nbsp;<img src="images/items/2487.gif" />&nbsp;&nbsp;<img src="images/items/2392.gif" />&nbsp;&nbsp;<img src="images/items/2519.gif" />&nbsp;&nbsp;<img src="images/items/2488.gif" />&nbsp;&nbsp;<img src="images/items/2071.gif" />&nbsp;&nbsp;<img src="images/items/2544.gif" />&nbsp;&nbsp;<img src="images/items/2652.gif" />&nbsp;&nbsp;<img src="images/items/2164.gif" />&nbsp;&nbsp;<img src="images/items/7364.gif" />&nbsp;&nbsp;<img src="images/items/2391.gif" />&nbsp;&nbsp;<img src="images/items/2744.gif" />&nbsp;&nbsp;', 'hero.gif'),
(0, 'Hunter', 0, 150, 150, 1, 0, '"Guess who we''re hunting, haha!"', 'poison', 0, 1, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2465.gif" />&nbsp;&nbsp;<img src="images/items/2461.gif" />&nbsp;&nbsp;<img src="images/items/2649.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;<img src="images/items/5875.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2456.gif" />&nbsp;&nbsp;<img src="images/items/2544.gif" />&nbsp;&nbsp;<img src="images/items/2546.gif" />&nbsp;&nbsp;<img src="images/items/2147.gif" />&nbsp;&nbsp;<img src="images/items/2675.gif" />&nbsp;&nbsp;<img src="images/items/2690.gif" />&nbsp;&nbsp;<img src="images/items/2050.gif" />&nbsp;&nbsp;<img src="images/items/2478.gif" />&nbsp;&nbsp;<img src="images/items/2652.gif" />&nbsp;&nbsp;<img src="images/items/2201.gif" />&nbsp;&nbsp;', 'hunter.gif'),
(0, 'Nomad', 420, 60, 160, 1, 0, '"We are swift as the wind of the desert", "We are the true sons of the desert!"', '', 1, 1, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2465.gif" />&nbsp;&nbsp;<img src="images/items/2461.gif" />&nbsp;&nbsp;<img src="images/items/2649.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2456.gif" />&nbsp;&nbsp;<img src="images/items/2544.gif" />&nbsp;&nbsp;<img src="images/items/2546.gif" />&nbsp;&nbsp;<img src="images/items/2147.gif" />&nbsp;&nbsp;<img src="images/items/2675.gif" />&nbsp;&nbsp;<img src="images/items/2690.gif" />&nbsp;&nbsp;<img src="images/items/2050.gif" />&nbsp;&nbsp;<img src="images/items/2478.gif" />&nbsp;&nbsp;<img src="images/items/2652.gif" />&nbsp;&nbsp;<img src="images/items/2201.gif" />&nbsp;&nbsp;', 'nomad.gif'),
(0, 'Smuggler', 390, 48, 130, 1, 0, '"I will silence you forever!", "You saw something you shouldn''t!"', '', 1, 1, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2465.gif" />&nbsp;&nbsp;<img src="images/items/2461.gif" />&nbsp;&nbsp;<img src="images/items/2649.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2456.gif" />&nbsp;&nbsp;<img src="images/items/2544.gif" />&nbsp;&nbsp;<img src="images/items/2546.gif" />&nbsp;&nbsp;<img src="images/items/2147.gif" />&nbsp;&nbsp;<img src="images/items/2675.gif" />&nbsp;&nbsp;<img src="images/items/2690.gif" />&nbsp;&nbsp;<img src="images/items/2050.gif" />&nbsp;&nbsp;<img src="images/items/2478.gif" />&nbsp;&nbsp;<img src="images/items/2652.gif" />&nbsp;&nbsp;<img src="images/items/2201.gif" />&nbsp;&nbsp;', 'smuggler.gif'),
(0, 'Stalker', 0, 90, 150, 1, 0, '', 'lifedrain, outfit, drunk, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2649.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2260.gif" />&nbsp;&nbsp;<img src="images/items/2399.gif" />&nbsp;&nbsp;<img src="images/items/2478.gif" />&nbsp;&nbsp;<img src="images/items/2425.gif" />&nbsp;&nbsp;', 'stalker.gif'),
(0, 'Poacher', 0, 150, 150, 1, 0, '"You will not live to tell anyone!", "You are my game today!"', 'poison', 0, 1, 'blood', '<img src="images/items/2649.gif" />&nbsp;&nbsp;<img src="images/items/2461.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2456.gif" />&nbsp;&nbsp;<img src="images/items/2544.gif" />&nbsp;&nbsp;<img src="images/items/2545.gif" />&nbsp;&nbsp;<img src="images/items/2050.gif" />&nbsp;&nbsp;<img src="images/items/2579.gif" />&nbsp;&nbsp;', 'poacher.gif'),
(0, 'Wild Warrior', 420, 55, 120, 1, 1, '"An enemy!", "Gimme your money!"', '', 1, 1, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2511.gif" />&nbsp;&nbsp;<img src="images/items/2465.gif" />&nbsp;&nbsp;<img src="images/items/2509.gif" />&nbsp;&nbsp;<img src="images/items/2391.gif" />&nbsp;&nbsp;<img src="images/items/2530.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2398.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/2649.gif" />&nbsp;&nbsp;<img src="images/items/2110.gif" />&nbsp;&nbsp;<img src="images/items/2459.gif" />&nbsp;&nbsp;', 'wildwarrior.gif'),
(0, 'Man In The Cave', 0, 555, 770, 1, 0, '"THE MONKS ARE MINE!", "I will rope you up! All of you!", "You have been roped up!", "A MIC to rule them all!"', 'fire, lifedrain, outfit, drunk, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2120.gif" />&nbsp;&nbsp;<img src="images/items/2691.gif" />&nbsp;&nbsp;<img src="images/items/5913.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/7290.gif" />&nbsp;&nbsp;<img src="images/items/7463.gif" />&nbsp;&nbsp;<img src="images/items/7386.gif" />&nbsp;&nbsp;<img src="images/items/7458.gif" />&nbsp;&nbsp;<img src="images/items/2173.gif" />&nbsp;&nbsp;', 'maninthecave.gif'),
(0, 'Rukor Zad', 450, 380, 380, 15, 1, '"I can kill a man in a thousand ways, and thats only with a spoon!", "You shouldn''t have come here"', 'invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/3969.gif" />&nbsp;&nbsp;', 'rukorzad.gif'),
(0, 'Smuggler Baron Silvertoe', 390, 170, 280, 5, 0, '"i will make your dead look like an accident!", "you should not have interferred with my bussiness"', '', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2398.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;', 'smugglerbaronsilvertoe.gif'),
(0, 'Ashmunrah', 0, 3100, 5000, 28, 0, '"Ahhhh all those long years.", "No mortal or undead will steal my secrets."', 'earth, death, paralyze, invisible', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/4845.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/7590.gif" />&nbsp;&nbsp;<img src="images/items/2164.gif" />&nbsp;&nbsp;<img src="images/items/2487.gif" />&nbsp;&nbsp;<img src="images/items/2140.gif" />&nbsp;&nbsp;', 'ashmunrah.gif'),
(0, 'Dipthrah', 0, 2900, 4200, 35, 0, '"Come closer to learn the final lesson.", "You can''t escape death forever."', 'physical, death, invisible', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2176.gif" />&nbsp;&nbsp;<img src="images/items/2353.gif" />&nbsp;&nbsp;<img src="images/items/2436.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2158.gif" />&nbsp;&nbsp;<img src="images/items/7590.gif" />&nbsp;&nbsp;<img src="images/items/2146.gif" />&nbsp;&nbsp;<img src="images/items/2446.gif" />&nbsp;&nbsp;', 'dipthrah.gif'),
(0, 'Mahrdis', 0, 3050, 3900, 30, 0, '"Ashes to ashes!", "Fire, Fire!", "The eternal flame demands its due!", "Burnnnnnnnnn!", "May my flames engulf you!"', 'death, fire, invisible', 0, 0, 'fire', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2146.gif" />&nbsp;&nbsp;<img src="images/items/2353.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2141.gif" />&nbsp;&nbsp;<img src="images/items/2539.gif" />&nbsp;&nbsp;<img src="images/items/7591.gif" />&nbsp;&nbsp;<img src="images/items/2432.gif" />&nbsp;&nbsp;<img src="images/items/2147.gif" />&nbsp;&nbsp;', 'mahrdis.gif'),
(0, 'Morguthis', 0, 3000, 4800, 30, 1, '"Vengeance!", "I am the supreme warrior!"', 'paralyze, invisible', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2350.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2430.gif" />&nbsp;&nbsp;<img src="images/items/2443.gif" />&nbsp;&nbsp;<img src="images/items/2645.gif" />&nbsp;&nbsp;<img src="images/items/7591.gif" />&nbsp;&nbsp;<img src="images/items/7368.gif" />&nbsp;&nbsp;', 'morguthis.gif'),
(0, 'Omruc', 0, 2950, 4300, 75, 0, '"Now chhhou shhhee me ... Now chhhou don''t!!", "Catchhhh me if chhhou can."', 'death, paralyze, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2144.gif" />&nbsp;&nbsp;<img src="images/items/2354.gif" />&nbsp;&nbsp;<img src="images/items/2544.gif" />&nbsp;&nbsp;<img src="images/items/2545.gif" />&nbsp;&nbsp;<img src="images/items/2546.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2195.gif" />&nbsp;&nbsp;<img src="images/items/2444.gif" />&nbsp;&nbsp;<img src="images/items/7365.gif" />&nbsp;&nbsp;<img src="images/items/2547.gif" />&nbsp;&nbsp;<img src="images/items/2145.gif" />&nbsp;&nbsp;', 'omruc.gif'),
(0, 'Rahemos', 0, 3100, 3700, 40, 0, '"It''s a kind of magic.", "Abrah Kadabrah!", "Nothing hidden in my warpings.", "It''s not a trick, it''s Rahemos.", "Meet my dear friend from hell.", "I will make you believe in magic."', 'death, ice, earth, paralyze, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2185.gif" />&nbsp;&nbsp;<img src="images/items/2348.gif" />&nbsp;&nbsp;<img src="images/items/2153.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2150.gif" />&nbsp;&nbsp;<img src="images/items/2214.gif" />&nbsp;&nbsp;<img src="images/items/2447.gif" />&nbsp;&nbsp;<img src="images/items/2184.gif" />&nbsp;&nbsp;', 'rahemos.gif'),
(0, 'Thalas', 0, 2950, 4100, 50, 0, '"You will become a feast for my maggots.", "Death and decay!"', '', 0, 0, 'venom', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2351.gif" />&nbsp;&nbsp;<img src="images/items/2409.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2149.gif" />&nbsp;&nbsp;<img src="images/items/2451.gif" />&nbsp;&nbsp;<img src="images/items/2255.gif" />&nbsp;&nbsp;<img src="images/items/7591.gif" />&nbsp;&nbsp;', 'thalas.gif'),
(0, 'Vashresamun', 0, 2945, 4000, 45, 1, '"Come my maidens, we have visitors!", "Are you enjoying my music?", "If music is the food of death, drop dead."', 'death, invisible, lifedrain', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/7590.gif" />&nbsp;&nbsp;<img src="images/items/2646.gif" />&nbsp;&nbsp;<img src="images/items/2349.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2445.gif" />&nbsp;&nbsp;<img src="images/items/2139.gif" />&nbsp;&nbsp;', 'vashresamun.gif'),
(0, 'Brutus Bloodbeard', 0, 1100, 1900, 40, 0, '', 'invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2229.gif" />&nbsp;&nbsp;<img src="images/items/6099.gif" />&nbsp;&nbsp;<img src="images/items/2387.gif" />&nbsp;&nbsp;<img src="images/items/2463.gif" />&nbsp;&nbsp;<img src="images/items/2379.gif" />&nbsp;&nbsp;<img src="images/items/2476.gif" />&nbsp;&nbsp;', 'brutusbloodbeard.gif'),
(0, 'Lethal Lissy', 0, 2700, 3000, 40, 0, '', 'invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2229.gif" />&nbsp;&nbsp;<img src="images/items/6100.gif" />&nbsp;&nbsp;<img src="images/items/2387.gif" />&nbsp;&nbsp;<img src="images/items/2463.gif" />&nbsp;&nbsp;<img src="images/items/2379.gif" />&nbsp;&nbsp;<img src="images/items/2476.gif" />&nbsp;&nbsp;', 'lethallissy.gif'),
(0, 'Deadeye Devious', 0, 800, 2200, 40, 0, '"Let''s kill ''em", "Arrrgh!", "You''ll never take me alive!"', 'invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2229.gif" />&nbsp;&nbsp;<img src="images/items/6102.gif" />&nbsp;&nbsp;<img src="images/items/2387.gif" />&nbsp;&nbsp;<img src="images/items/2463.gif" />&nbsp;&nbsp;<img src="images/items/2379.gif" />&nbsp;&nbsp;<img src="images/items/2476.gif" />&nbsp;&nbsp;', 'deadeyedevious.gif'),
(0, 'Ron The Ripper', 0, 1000, 2500, 40, 0, '', 'invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2229.gif" />&nbsp;&nbsp;<img src="images/items/6101.gif" />&nbsp;&nbsp;<img src="images/items/2387.gif" />&nbsp;&nbsp;<img src="images/items/2463.gif" />&nbsp;&nbsp;<img src="images/items/2379.gif" />&nbsp;&nbsp;<img src="images/items/2476.gif" />&nbsp;&nbsp;', 'rontheripper.gif'),
(0, 'Pirate Buccaneer', 595, 250, 425, 5, 0, '"Give up!"', '', 1, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2050.gif" />&nbsp;&nbsp;<img src="images/items/2385.gif" />&nbsp;&nbsp;<img src="images/items/2463.gif" />&nbsp;&nbsp;<img src="images/items/2238.gif" />&nbsp;&nbsp;<img src="images/items/6095.gif" />&nbsp;&nbsp;<img src="images/items/5553.gif" />&nbsp;&nbsp;<img src="images/items/5926.gif" />&nbsp;&nbsp;<img src="images/items/5091.gif" />&nbsp;&nbsp;<img src="images/items/5792.gif" />&nbsp;&nbsp;<img src="images/items/2376.gif" />&nbsp;&nbsp;<img src="images/items/6126.gif" />&nbsp;&nbsp;<img src="images/items/6098.gif" />&nbsp;&nbsp;<img src="images/items/6097.gif" />&nbsp;&nbsp;', 'piratebuccaneer.gif'),
(0, 'Pirate Corsair', 775, 350, 675, 5, 0, '', 'invisible', 0, 1, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2385.gif" />&nbsp;&nbsp;<img src="images/items/2489.gif" />&nbsp;&nbsp;<img src="images/items/2521.gif" />&nbsp;&nbsp;<img src="images/items/6096.gif" />&nbsp;&nbsp;<img src="images/items/6095.gif" />&nbsp;&nbsp;<img src="images/items/5926.gif" />&nbsp;&nbsp;<img src="images/items/5091.gif" />&nbsp;&nbsp;<img src="images/items/5462.gif" />&nbsp;&nbsp;<img src="images/items/5792.gif" />&nbsp;&nbsp;<img src="images/items/2376.gif" />&nbsp;&nbsp;<img src="images/items/6098.gif" />&nbsp;&nbsp;', 'piratecorsair.gif'),
(0, 'Pirate Cutthroat', 495, 175, 325, 5, 0, '', '', 0, 1, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2483.gif" />&nbsp;&nbsp;<img src="images/items/5918.gif" />&nbsp;&nbsp;<img src="images/items/6095.gif" />&nbsp;&nbsp;<img src="images/items/5710.gif" />&nbsp;&nbsp;<img src="images/items/5553.gif" />&nbsp;&nbsp;<img src="images/items/5927.gif" />&nbsp;&nbsp;<img src="images/items/5091.gif" />&nbsp;&nbsp;<img src="images/items/2509.gif" />&nbsp;&nbsp;<img src="images/items/5792.gif" />&nbsp;&nbsp;<img src="images/items/2376.gif" />&nbsp;&nbsp;<img src="images/items/6126.gif" />&nbsp;&nbsp;<img src="images/items/6098.gif" />&nbsp;&nbsp;<img src="images/items/6097.gif" />&nbsp;&nbsp;', 'piratecutthroat.gif'),
(0, 'Pirate Marauder', 490, 125, 210, 5, 0, '"Plundeeeeer!"', '', 0, 1, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2376.gif" />&nbsp;&nbsp;<img src="images/items/2050.gif" />&nbsp;&nbsp;<img src="images/items/5917.gif" />&nbsp;&nbsp;<img src="images/items/2464.gif" />&nbsp;&nbsp;<img src="images/items/6098.gif" />&nbsp;&nbsp;<img src="images/items/6095.gif" />&nbsp;&nbsp;<img src="images/items/5926.gif" />&nbsp;&nbsp;<img src="images/items/5091.gif" />&nbsp;&nbsp;<img src="images/items/5792.gif" />&nbsp;&nbsp;<img src="images/items/6126.gif" />&nbsp;&nbsp;<img src="images/items/6097.gif" />&nbsp;&nbsp;', 'piratemarauder.gif'),
(0, 'The Plasmother', 0, 8900, 16050, 45, 0, '"Blubb"', 'poison, lifedrain, paralyze, invisible', 0, 0, 'venom', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2152.gif" />&nbsp;&nbsp;<img src="images/items/6500.gif" />&nbsp;&nbsp;<img src="images/items/5944.gif" />&nbsp;&nbsp;<img src="images/items/6535.gif" />&nbsp;&nbsp;', 'theplasmother.gif'),
(0, 'Dracola', 0, 7750, 16200, 65, 0, '"FEEEED MY ETERNAL HUNGER!"', 'earth, fire, death, poison, lifedrain, paralyze, outfit, drunk, invisible', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2152.gif" />&nbsp;&nbsp;<img src="images/items/6546.gif" />&nbsp;&nbsp;<img src="images/items/2236.gif" />&nbsp;&nbsp;<img src="images/items/2413.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/7420.gif" />&nbsp;&nbsp;<img src="images/items/6500.gif" />&nbsp;&nbsp;<img src="images/items/5944.gif" />&nbsp;&nbsp;<img src="images/items/2547.gif" />&nbsp;&nbsp;', 'dracola.gif'),
(0, 'The Handmaiden', 0, 8300, 16500, 115, 1, '', 'energy, fire, earth, poison, lifedrain, paralyze, invisible', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/6539.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/6500.gif" />&nbsp;&nbsp;<img src="images/items/2153.gif" />&nbsp;&nbsp;', 'thehandmaiden.gif'),
(0, 'Mr. Punish', 0, 7550, 20000, 55, 0, '"I kept my axe sharp, especially for you!"', 'lifedrain, paralyze, invisible', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2152.gif" />&nbsp;&nbsp;<img src="images/items/6537.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/6500.gif" />&nbsp;&nbsp;<img src="images/items/5944.gif" />&nbsp;&nbsp;<img src="images/items/6492.gif" />&nbsp;&nbsp;', 'mr.punish.gif'),
(0, 'The Countess Sorrow', 0, 5150, 13500, 60, 0, '"Oh my, you forgot to put your pants on!", "Weeheeheeheehee!", "Welcome to my nightmare!", "Its nothing but a dream!", "Give in!"', 'physical, poison, lifedrain, paralyze, outfit, drunk, invisible', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2230.gif" />&nbsp;&nbsp;<img src="images/items/2804.gif" />&nbsp;&nbsp;<img src="images/items/2260.gif" />&nbsp;&nbsp;<img src="images/items/6536.gif" />&nbsp;&nbsp;<img src="images/items/5944.gif" />&nbsp;&nbsp;<img src="images/items/2149.gif" />&nbsp;&nbsp;', 'thecountesssorrow.gif'),
(0, 'The Imperor', 0, 8000, 15000, 55, 1, '"Muahaha!", "He he he!"', 'fire, poison, lifedrain, paralyze, outfit, drunk, invisible', 0, 0, 'fire', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2050.gif" />&nbsp;&nbsp;<img src="images/items/6558.gif" />&nbsp;&nbsp;<img src="images/items/2260.gif" />&nbsp;&nbsp;<img src="images/items/6534.gif" />&nbsp;&nbsp;<img src="images/items/6300.gif" />&nbsp;&nbsp;<img src="images/items/2465.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2548.gif" />&nbsp;&nbsp;<img src="images/items/6529.gif" />&nbsp;&nbsp;<img src="images/items/2185.gif" />&nbsp;&nbsp;<img src="images/items/2464.gif" />&nbsp;&nbsp;<img src="images/items/5944.gif" />&nbsp;&nbsp;<img src="images/items/7899.gif" />&nbsp;&nbsp;<img src="images/items/7900.gif" />&nbsp;&nbsp;<img src="images/items/7891.gif" />&nbsp;&nbsp;<img src="images/items/6500.gif" />&nbsp;&nbsp;<img src="images/items/2150.gif" />&nbsp;&nbsp;<img src="images/items/2165.gif" />&nbsp;&nbsp;', 'theimperor.gif'),
(0, 'Massacre', 0, 14000, 30000, 85, 1, '', 'earth, energy, fire, paralyze, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2152.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/2452.gif" />&nbsp;&nbsp;<img src="images/items/6500.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/6540.gif" />&nbsp;&nbsp;<img src="images/items/2522.gif" />&nbsp;&nbsp;<img src="images/items/5944.gif" />&nbsp;&nbsp;', 'massacre.gif'),
(0, 'Fire Overlord', 0, 2800, 4000, 40, 0, '', 'fire, poison, lifedrain, paralyze, outfit, drunk, invisible', 0, 0, 'fire', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2152.gif" />&nbsp;&nbsp;<img src="images/items/8304.gif" />&nbsp;&nbsp;<img src="images/items/8877.gif" />&nbsp;&nbsp;<img src="images/items/7899.gif" />&nbsp;&nbsp;', 'fireoverlord.gif'),
(0, 'Massive Fire Elemental', 0, 950, 1800, 20, 0, '', 'fire, lifedrain, paralyze, invisible', 0, 0, 'fire', '', 'massivefireelemental.gif'),
(0, 'Blistering Fire Elemental', 850, 1300, 1500, 5, 0, '', 'fire', 1, 1, 'fire', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2147.gif" />&nbsp;&nbsp;<img src="images/items/8299.gif" />&nbsp;&nbsp;<img src="images/items/8921.gif" />&nbsp;&nbsp;', 'blisteringfireelemental.gif'),
(0, 'Blazing Fire Elemental', 850, 580, 580, 1, 0, '', 'fire', 1, 1, 'fire', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/8299.gif" />&nbsp;&nbsp;', 'blazingfireelemental.gif'),
(0, 'Fire Elemental', 650, 280, 280, 1, 0, '', 'fire, death, invisible', 1, 1, 'fire', '', 'fireelemental.gif'),
(0, 'Hellfire Fighter', 0, 2200, 3800, 23, 0, '"Fire!"', 'fire, poison, lifedrain, paralyze, outfit, drunk, invisible', 0, 0, 'fire', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2147.gif" />&nbsp;&nbsp;<img src="images/items/5944.gif" />&nbsp;&nbsp;<img src="images/items/2239.gif" />&nbsp;&nbsp;<img src="images/items/2136.gif" />&nbsp;&nbsp;<img src="images/items/2187.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2260.gif" />&nbsp;&nbsp;<img src="images/items/2432.gif" />&nbsp;&nbsp;<img src="images/items/7899.gif" />&nbsp;&nbsp;<img src="images/items/7894.gif" />&nbsp;&nbsp;<img src="images/items/2145.gif" />&nbsp;&nbsp;<img src="images/items/2376.gif" />&nbsp;&nbsp;<img src="images/items/2392.gif" />&nbsp;&nbsp;', 'hellfirefighter.gif'),
(0, 'Quara Constrictor Scout', 670, 250, 450, 35, 0, '', 'fire, ice', 0, 1, 'undead', '<img src="images/items/2670.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2150.gif" />&nbsp;&nbsp;<img src="images/items/2397.gif" />&nbsp;&nbsp;<img src="images/items/2381.gif" />&nbsp;&nbsp;<img src="images/items/2460.gif" />&nbsp;&nbsp;<img src="images/items/2465.gif" />&nbsp;&nbsp;<img src="images/items/5895.gif" />&nbsp;&nbsp;', 'quaraconstrictorscout.gif'),
(0, 'Quara Hydromancer Scout', 0, 800, 1100, 30, 0, '"Qua hah tsh!"', 'ice, fire, lifedrain, paralyze, invisible', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2670.gif" />&nbsp;&nbsp;<img src="images/items/5895.gif" />&nbsp;&nbsp;<img src="images/items/2189.gif" />&nbsp;&nbsp;<img src="images/items/2240.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2143.gif" />&nbsp;&nbsp;<img src="images/items/2144.gif" />&nbsp;&nbsp;<img src="images/items/2214.gif" />&nbsp;&nbsp;<img src="images/items/2150.gif" />&nbsp;&nbsp;<img src="images/items/2476.gif" />&nbsp;&nbsp;', 'quarahydromancerscout.gif'),
(0, 'Quara Mantassin Scout', 480, 100, 220, 25, 0, '"Zuerk Pachak!", "Shrrrr"', 'ice, fire, lifedrain, paralyze, invisible', 0, 1, 'blood', '<img src="images/items/2670.gif" />&nbsp;&nbsp;<img src="images/items/5895.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2377.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2229.gif" />&nbsp;&nbsp;<img src="images/items/2165.gif" />&nbsp;&nbsp;<img src="images/items/2146.gif" />&nbsp;&nbsp;', 'quaramantassinscout.gif'),
(0, 'Quara Pincher Scout', 0, 600, 775, 15, 0, '"Clank clank!", "Clap!"', 'fire, poison, lifedrain, paralyze, outfit, drunk, invisible', 0, 0, 'blood', '<img src="images/items/2670.gif" />&nbsp;&nbsp;<img src="images/items/5895.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2475.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2398.gif" />&nbsp;&nbsp;<img src="images/items/2381.gif" />&nbsp;&nbsp;<img src="images/items/2487.gif" />&nbsp;&nbsp;<img src="images/items/2147.gif" />&nbsp;&nbsp;', 'quarapincherscout.gif'),
(0, 'Quara Predator Scout', 0, 400, 890, 35, 0, '"Gnarrr!"', 'ice, fire, lifedrain, paralyze, invisible', 0, 0, 'blood', '<img src="images/items/2670.gif" />&nbsp;&nbsp;<img src="images/items/5895.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2387.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2473.gif" />&nbsp;&nbsp;<img src="images/items/2145.gif" />&nbsp;&nbsp;<img src="images/items/2483.gif" />&nbsp;&nbsp;', 'quarapredatorscout.gif'),
(0, 'Quara Constrictor', 670, 250, 450, 150, 0, '', 'fire, ice', 0, 1, 'undead', '<img src="images/items/2670.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2150.gif" />&nbsp;&nbsp;<img src="images/items/2397.gif" />&nbsp;&nbsp;<img src="images/items/2381.gif" />&nbsp;&nbsp;<img src="images/items/2460.gif" />&nbsp;&nbsp;<img src="images/items/2465.gif" />&nbsp;&nbsp;<img src="images/items/5895.gif" />&nbsp;&nbsp;', 'quaraconstrictor.gif'),
(0, 'Quara Hydromancer', 0, 800, 1100, 45, 0, '"Qua hah tsh!"', 'ice, fire, lifedrain, paralyze, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2670.gif" />&nbsp;&nbsp;<img src="images/items/5895.gif" />&nbsp;&nbsp;<img src="images/items/2189.gif" />&nbsp;&nbsp;<img src="images/items/2401.gif" />&nbsp;&nbsp;<img src="images/items/5741.gif" />&nbsp;&nbsp;<img src="images/items/2240.gif" />&nbsp;&nbsp;<img src="images/items/2377.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2143.gif" />&nbsp;&nbsp;<img src="images/items/2144.gif" />&nbsp;&nbsp;<img src="images/items/2214.gif" />&nbsp;&nbsp;<img src="images/items/2150.gif" />&nbsp;&nbsp;<img src="images/items/2476.gif" />&nbsp;&nbsp;', 'quarahydromancer.gif'),
(0, 'Quara Mantassin', 480, 400, 800, 150, 0, '"Zuerk Pachak!", "Shrrrr"', 'ice, fire, lifedrain, paralyze, invisible', 0, 1, 'blood', '<img src="images/items/2670.gif" />&nbsp;&nbsp;<img src="images/items/5895.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2377.gif" />&nbsp;&nbsp;<img src="images/items/7892.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2229.gif" />&nbsp;&nbsp;<img src="images/items/2165.gif" />&nbsp;&nbsp;<img src="images/items/2656.gif" />&nbsp;&nbsp;', 'quaramantassin.gif'),
(0, 'Quara Pincher', 0, 1200, 1800, 10, 0, '"Clank clank!", "Clap!"', 'fire, poison, lifedrain, paralyze, outfit, drunk, invisible', 0, 0, 'blood', '<img src="images/items/2670.gif" />&nbsp;&nbsp;<img src="images/items/5895.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2475.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2398.gif" />&nbsp;&nbsp;<img src="images/items/2381.gif" />&nbsp;&nbsp;<img src="images/items/2487.gif" />&nbsp;&nbsp;<img src="images/items/2147.gif" />&nbsp;&nbsp;', 'quarapincher.gif'),
(0, 'Quara Predator', 0, 1600, 2200, 45, 0, '"Gnarrr!"', 'ice, fire, lifedrain, paralyze, invisible', 0, 0, 'blood', '<img src="images/items/2670.gif" />&nbsp;&nbsp;<img src="images/items/5895.gif" />&nbsp;&nbsp;<img src="images/items/7368.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/7897.gif" />&nbsp;&nbsp;<img src="images/items/2387.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2473.gif" />&nbsp;&nbsp;<img src="images/items/2145.gif" />&nbsp;&nbsp;<img src="images/items/2483.gif" />&nbsp;&nbsp;<img src="images/items/5741.gif" />&nbsp;&nbsp;', 'quarapredator.gif'),
(0, 'Thul', 0, 1800, 3000, 1, 0, '"Gaaahhh!"', 'ice', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/5895.gif" />&nbsp;&nbsp;<img src="images/items/5741.gif" />&nbsp;&nbsp;<img src="images/items/7383.gif" />&nbsp;&nbsp;', 'thul.gif'),
(0, 'Cave Rat', 250, 10, 30, 1, 0, '"Meeeeep!", "Meep!"', '', 1, 1, 'blood', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2696.gif" />&nbsp;&nbsp;', 'caverat.gif'),
(0, 'Rat', 200, 5, 20, 1, 0, '', '', 1, 1, 'blood', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2696.gif" />&nbsp;&nbsp;', 'rat.gif'),
(0, 'Munster', 250, 23, 58, 1, 0, '"Meeeeep!"', '', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2696.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2687.gif" />&nbsp;&nbsp;<img src="images/items/2650.gif" />&nbsp;&nbsp;<img src="images/items/2449.gif" />&nbsp;&nbsp;', 'munster.gif'),
(0, 'Cobra', 275, 30, 65, 1, 0, '"zzzzzz"', 'poison', 1, 1, 'blood', '<img src="images/items/2220.gif" />&nbsp;&nbsp;<img src="images/items/2230.gif" />&nbsp;&nbsp;', 'cobra.gif'),
(0, 'Crocodile', 350, 40, 105, 1, 0, '', '', 1, 1, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/3982.gif" />&nbsp;&nbsp;<img src="images/items/3983.gif" />&nbsp;&nbsp;<img src="images/items/3976.gif" />&nbsp;&nbsp;', 'crocodile.gif'),
(0, 'Serpent Spawn', 0, 2000, 3000, 10, 1, '"Ssssolus for the one", "HISSSS", "Tsssse one will risssse again", "I bring you deathhhh, mortalssss"', 'paralyze, invisible', 0, 0, 'VENOM', '<img src="images/items/2182.gif" />&nbsp;&nbsp;<img src="images/items/2195.gif" />&nbsp;&nbsp;<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2476.gif" />&nbsp;&nbsp;<img src="images/items/1976.gif" />&nbsp;&nbsp;<img src="images/items/3971.gif" />&nbsp;&nbsp;<img src="images/items/2492.gif" />&nbsp;&nbsp;<img src="images/items/2167.gif" />&nbsp;&nbsp;<img src="images/items/2392.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2033.gif" />&nbsp;&nbsp;<img src="images/items/2796.gif" />&nbsp;&nbsp;<img src="images/items/2177.gif" />&nbsp;&nbsp;<img src="images/items/2168.gif" />&nbsp;&nbsp;<img src="images/items/2547.gif" />&nbsp;&nbsp;<img src="images/items/2498.gif" />&nbsp;&nbsp;<img src="images/items/2146.gif" />&nbsp;&nbsp;<img src="images/items/2479.gif" />&nbsp;&nbsp;<img src="images/items/2528.gif" />&nbsp;&nbsp;', 'serpentspawn.gif'),
(0, 'Snake', 205, 10, 15, 1, 0, '"Zzzzzzt"', 'poison', 1, 1, 'blood', '', 'snake.gif'),
(0, 'Wyvern', 0, 515, 795, 48, 0, '"Shiiiiiek"', 'earth, drunk, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2672.gif" />&nbsp;&nbsp;<img src="images/items/1976.gif" />&nbsp;&nbsp;<img src="images/items/2547.gif" />&nbsp;&nbsp;<img src="images/items/2647.gif" />&nbsp;&nbsp;<img src="images/items/7408.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2127.gif" />&nbsp;&nbsp;<img src="images/items/2187.gif" />&nbsp;&nbsp;<img src="images/items/2146.gif" />&nbsp;&nbsp;', 'wyvern.gif'),
(0, 'Black Sheep', 250, 15, 20, 1, 0, '"maeh"', '', 1, 1, 'blood', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;', 'blacksheep.gif'),
(0, 'Sheep', 250, 0, 20, 1, 0, '"Maeh"', '', 1, 1, 'blood', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;', 'sheep.gif'),
(0, 'Mimic', 0, 70, 50, 390, 0, '', '', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;', 'mimic.gif'),
(0, 'Betrayed Wraith', 0, 3500, 4200, 25, 1, '"Rrrah!"', 'death, energy, fire, poison, lifedrain, paralyze, invisible', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2152.gif" />&nbsp;&nbsp;<img src="images/items/7365.gif" />&nbsp;&nbsp;<img src="images/items/7590.gif" />&nbsp;&nbsp;<img src="images/items/2394.gif" />&nbsp;&nbsp;<img src="images/items/5799.gif" />&nbsp;&nbsp;<img src="images/items/2173.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/6558.gif" />&nbsp;&nbsp;<img src="images/items/2387.gif" />&nbsp;&nbsp;<img src="images/items/7364.gif" />&nbsp;&nbsp;<img src="images/items/2226.gif" />&nbsp;&nbsp;<img src="images/items/5741.gif" />&nbsp;&nbsp;<img src="images/items/7416.gif" />&nbsp;&nbsp;<img src="images/items/2145.gif" />&nbsp;&nbsp;<img src="images/items/3976.gif" />&nbsp;&nbsp;', 'betrayedwraith.gif'),
(0, 'Bonebeast', 0, 580, 515, 1, 0, '"Cccchhhhhhhhh!", "Knooorrrrr!"', 'death, earth, lifedrain, paralyze, invisible', 0, 0, 'UNDEAD', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2229.gif" />&nbsp;&nbsp;<img src="images/items/2231.gif" />&nbsp;&nbsp;<img src="images/items/2463.gif" />&nbsp;&nbsp;<img src="images/items/5925.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2541.gif" />&nbsp;&nbsp;<img src="images/items/2450.gif" />&nbsp;&nbsp;<img src="images/items/2449.gif" />&nbsp;&nbsp;', 'bonebeast.gif');
INSERT INTO `z_monsters` (`hide_creature`, `name`, `mana`, `exp`, `health`, `speed_lvl`, `use_haste`, `voices`, `immunities`, `summonable`, `convinceable`, `race`, `loot`, `gfx_name`) VALUES
(0, 'Demon Skeleton', 620, 240, 400, 5, 0, '', 'fire, poison, lifedrain, death, drunk', 1, 1, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2399.gif" />&nbsp;&nbsp;<img src="images/items/2515.gif" />&nbsp;&nbsp;<img src="images/items/2178.gif" />&nbsp;&nbsp;<img src="images/items/2050.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2417.gif" />&nbsp;&nbsp;<img src="images/items/2482.gif" />&nbsp;&nbsp;<img src="images/items/2194.gif" />&nbsp;&nbsp;<img src="images/items/2398.gif" />&nbsp;&nbsp;', 'demonskeleton.gif'),
(0, 'Lost Soul', 0, 4000, 8500, 30, 1, '"Forgive Meeeee!", "Mouuuurn meeee!"', 'fire, poison, death, paralyze, invisible', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2152.gif" />&nbsp;&nbsp;<img src="images/items/2227.gif" />&nbsp;&nbsp;<img src="images/items/2260.gif" />&nbsp;&nbsp;<img src="images/items/2480.gif" />&nbsp;&nbsp;<img src="images/items/5806.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2463.gif" />&nbsp;&nbsp;<img src="images/items/2483.gif" />&nbsp;&nbsp;<img src="images/items/7413.gif" />&nbsp;&nbsp;<img src="images/items/6526.gif" />&nbsp;&nbsp;<img src="images/items/5801.gif" />&nbsp;&nbsp;<img src="images/items/2197.gif" />&nbsp;&nbsp;', 'lostsoul.gif'),
(0, 'Pirate Skeleton', 0, 85, 190, 5, 0, '', 'fire, invisible', 0, 0, 'UNDEAD', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2229.gif" />&nbsp;&nbsp;<img src="images/items/2231.gif" />&nbsp;&nbsp;<img src="images/items/6095.gif" />&nbsp;&nbsp;<img src="images/items/5927.gif" />&nbsp;&nbsp;<img src="images/items/2376.gif" />&nbsp;&nbsp;<img src="images/items/2449.gif" />&nbsp;&nbsp;', 'pirateskeleton.gif'),
(0, 'Skeleton', 300, 35, 50, 1, 0, '', 'poison, lifedrain', 1, 1, 'UNDEAD', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2480.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2388.gif" />&nbsp;&nbsp;<img src="images/items/2398.gif" />&nbsp;&nbsp;<img src="images/items/2511.gif" />&nbsp;&nbsp;<img src="images/items/2473.gif" />&nbsp;&nbsp;<img src="images/items/2376.gif" />&nbsp;&nbsp;<img src="images/items/2050.gif" />&nbsp;&nbsp;', 'skeleton.gif'),
(0, 'Skeleton Warrior', 350, 45, 65, 1, 0, '', 'death', 1, 1, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2230.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2398.gif" />&nbsp;&nbsp;<img src="images/items/2511.gif" />&nbsp;&nbsp;<img src="images/items/2787.gif" />&nbsp;&nbsp;<img src="images/items/2789.gif" />&nbsp;&nbsp;', 'skeletonwarrior.gif'),
(0, 'Undead Dragon', 0, 7200, 8350, 40, 0, '"FEEEED MY ETERNAL HUNGER!"', 'death, earth, fire, drown, lifedrain, paralyze, invisible', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2152.gif" />&nbsp;&nbsp;<img src="images/items/2236.gif" />&nbsp;&nbsp;<img src="images/items/2413.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2498.gif" />&nbsp;&nbsp;<img src="images/items/2492.gif" />&nbsp;&nbsp;<img src="images/items/6500.gif" />&nbsp;&nbsp;<img src="images/items/5944.gif" />&nbsp;&nbsp;<img src="images/items/2547.gif" />&nbsp;&nbsp;<img src="images/items/2466.gif" />&nbsp;&nbsp;<img src="images/items/2454.gif" />&nbsp;&nbsp;<img src="images/items/2476.gif" />&nbsp;&nbsp;<img src="images/items/8910.gif" />&nbsp;&nbsp;', 'undeaddragon.gif'),
(0, 'Dark Apprentice', 0, 100, 225, 1, 0, '"Outch!", "I must dispose of my masters enemies!", "Oops, I did it again.", "From the spirits that I called Sir, deliver me!"', 'invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/7620.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/5934.gif" />&nbsp;&nbsp;<img src="images/items/2260.gif" />&nbsp;&nbsp;<img src="images/items/2188.gif" />&nbsp;&nbsp;', 'darkapprentice.gif'),
(0, 'Dark Magician', 0, 185, 325, 5, 1, '"Feel the power of my runes!", "Killing you is getting expensive", "My secrets are mine alone!"', 'invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/7620.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/5934.gif" />&nbsp;&nbsp;<img src="images/items/2260.gif" />&nbsp;&nbsp;<img src="images/items/7762.gif" />&nbsp;&nbsp;', 'darkmagician.gif'),
(0, 'Ice Witch', 0, 580, 540, 1, 0, '"So you think you are cool?", "I hope it is not too cold for you! HeHeHe.", "Freeze!"', 'ice, paralyze, invisible', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/7449.gif" />&nbsp;&nbsp;<img src="images/items/7441.gif" />&nbsp;&nbsp;<img src="images/items/7387.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/7896.gif" />&nbsp;&nbsp;<img src="images/items/2423.gif" />&nbsp;&nbsp;<img src="images/items/2796.gif" />&nbsp;&nbsp;<img src="images/items/2663.gif" />&nbsp;&nbsp;<img src="images/items/7459.gif" />&nbsp;&nbsp;', 'icewitch.gif'),
(0, 'Ferumbras', 0, 12000, 35000, 35, 1, '"NOONE WILL STOP ME THIS TIME!", "THE POWER IS MINE!", "I returned from death and you dream about defeating me?"', 'lifedrain, paralyze, outfit, drunk, invisible', 0, 0, 'venom', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/7894.gif" />&nbsp;&nbsp;<img src="images/items/7896.gif" />&nbsp;&nbsp;<img src="images/items/7895.gif" />&nbsp;&nbsp;<img src="images/items/8885.gif" />&nbsp;&nbsp;<img src="images/items/7885.gif" />&nbsp;&nbsp;<img src="images/items/2393.gif" />&nbsp;&nbsp;<img src="images/items/2472.gif" />&nbsp;&nbsp;<img src="images/items/2470.gif" />&nbsp;&nbsp;<img src="images/items/2466.gif" />&nbsp;&nbsp;<img src="images/items/2195.gif" />&nbsp;&nbsp;<img src="images/items/2112.gif" />&nbsp;&nbsp;<img src="images/items/2150.gif" />&nbsp;&nbsp;<img src="images/items/9970.gif" />&nbsp;&nbsp;<img src="images/items/2147.gif" />&nbsp;&nbsp;<img src="images/items/2146.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2678.gif" />&nbsp;&nbsp;<img src="images/items/5903.gif" />&nbsp;&nbsp;<img src="images/items/8928.gif" />&nbsp;&nbsp;<img src="images/items/8924.gif" />&nbsp;&nbsp;<img src="images/items/8930.gif" />&nbsp;&nbsp;<img src="images/items/8918.gif" />&nbsp;&nbsp;<img src="images/items/7388.gif" />&nbsp;&nbsp;<img src="images/items/7423.gif" />&nbsp;&nbsp;<img src="images/items/1986.gif" />&nbsp;&nbsp;<img src="images/items/2539.gif" />&nbsp;&nbsp;<img src="images/items/7411.gif" />&nbsp;&nbsp;<img src="images/items/7414.gif" />&nbsp;&nbsp;<img src="images/items/7410.gif" />&nbsp;&nbsp;<img src="images/items/7403.gif" />&nbsp;&nbsp;<img src="images/items/7427.gif" />&nbsp;&nbsp;<img src="images/items/8902.gif" />&nbsp;&nbsp;<img src="images/items/2421.gif" />&nbsp;&nbsp;<img src="images/items/7422.gif" />&nbsp;&nbsp;<img src="images/items/7435.gif" />&nbsp;&nbsp;<img src="images/items/8904.gif" />&nbsp;&nbsp;<img src="images/items/2522.gif" />&nbsp;&nbsp;<img src="images/items/8903.gif" />&nbsp;&nbsp;<img src="images/items/6500.gif" />&nbsp;&nbsp;<img src="images/items/2149.gif" />&nbsp;&nbsp;<img src="images/items/2143.gif" />&nbsp;&nbsp;<img src="images/items/2144.gif" />&nbsp;&nbsp;', 'ferumbras.gif'),
(0, 'Warlock', 0, 4000, 3500, 23, 0, '"Learn the secret of our magic! YOUR death!", "Even a rat is a better mage than you.", "We don''t like intruders!"', 'energy, fire, ice, paralyze, outfit, drunk, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2185.gif" />&nbsp;&nbsp;<img src="images/items/1986.gif" />&nbsp;&nbsp;<img src="images/items/2600.gif" />&nbsp;&nbsp;<img src="images/items/2124.gif" />&nbsp;&nbsp;<img src="images/items/2689.gif" />&nbsp;&nbsp;<img src="images/items/2167.gif" />&nbsp;&nbsp;<img src="images/items/2197.gif" />&nbsp;&nbsp;<img src="images/items/2151.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2146.gif" />&nbsp;&nbsp;<img src="images/items/2178.gif" />&nbsp;&nbsp;<img src="images/items/2679.gif" />&nbsp;&nbsp;<img src="images/items/2047.gif" />&nbsp;&nbsp;<img src="images/items/2411.gif" />&nbsp;&nbsp;<img src="images/items/2792.gif" />&nbsp;&nbsp;<img src="images/items/2793.gif" />&nbsp;&nbsp;<img src="images/items/2656.gif" />&nbsp;&nbsp;<img src="images/items/7898.gif" />&nbsp;&nbsp;<img src="images/items/7895.gif" />&nbsp;&nbsp;<img src="images/items/2466.gif" />&nbsp;&nbsp;<img src="images/items/2436.gif" />&nbsp;&nbsp;<img src="images/items/2123.gif" />&nbsp;&nbsp;', 'warlock.gif'),
(0, 'Witch', 0, 120, 300, 1, 0, '"Horax pokti!", "Hihihihi!", "Herba budinia ex!"', 'energy, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2129.gif" />&nbsp;&nbsp;<img src="images/items/2185.gif" />&nbsp;&nbsp;<img src="images/items/2643.gif" />&nbsp;&nbsp;<img src="images/items/2651.gif" />&nbsp;&nbsp;<img src="images/items/2696.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2405.gif" />&nbsp;&nbsp;<img src="images/items/2442.gif" />&nbsp;&nbsp;<img src="images/items/2324.gif" />&nbsp;&nbsp;<img src="images/items/2654.gif" />&nbsp;&nbsp;<img src="images/items/2418.gif" />&nbsp;&nbsp;<img src="images/items/2199.gif" />&nbsp;&nbsp;<img src="images/items/2801.gif" />&nbsp;&nbsp;', 'witch.gif'),
(0, 'Zarabustor', 0, 8000, 5100, 23, 0, '"Killing is a splendid diversion for my studies."', 'energy, fire, ice, paralyze, outfit, drunk, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/7368.gif" />&nbsp;&nbsp;<img src="images/items/2146.gif" />&nbsp;&nbsp;<img src="images/items/1980.gif" />&nbsp;&nbsp;<img src="images/items/2656.gif" />&nbsp;&nbsp;<img src="images/items/2466.gif" />&nbsp;&nbsp;<img src="images/items/2436.gif" />&nbsp;&nbsp;<img src="images/items/2123.gif" />&nbsp;&nbsp;', 'zarabustor.gif'),
(0, 'Yakchal', 0, 4400, 5400, 20, 0, '"YOU BETTER DIE TO MY MINIONS BECAUSE YOU''LL WHISH YOU DID IF I COME FOR YOU!", "You are mine!", "I will make you all pay!"', 'ice, paralyze, invisible', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/7290.gif" />&nbsp;&nbsp;<img src="images/items/5912.gif" />&nbsp;&nbsp;<img src="images/items/7387.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/7896.gif" />&nbsp;&nbsp;<img src="images/items/7897.gif" />&nbsp;&nbsp;<img src="images/items/7459.gif" />&nbsp;&nbsp;<img src="images/items/7410.gif" />&nbsp;&nbsp;', 'yakchal.gif'),
(0, 'Annihilon', 0, 100000, 60000, 80, 1, '"Annihilation!"', 'lifedrain, invisible', 0, 0, 'fire', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2150.gif" />&nbsp;&nbsp;<img src="images/items/2520.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2158.gif" />&nbsp;&nbsp;<img src="images/items/2165.gif" />&nbsp;&nbsp;', 'annihilon.gif'),
(0, 'Hellgorak', 0, 10000, 40000, 70, 0, '"??", "??"', 'lifedrain, paralyze, invisible', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2150.gif" />&nbsp;&nbsp;<img src="images/items/7388.gif" />&nbsp;&nbsp;<img src="images/items/2130.gif" />&nbsp;&nbsp;<img src="images/items/2208.gif" />&nbsp;&nbsp;<img src="images/items/8871.gif" />&nbsp;&nbsp;<img src="images/items/2158.gif" />&nbsp;&nbsp;<img src="images/items/2155.gif" />&nbsp;&nbsp;<img src="images/items/2210.gif" />&nbsp;&nbsp;<img src="images/items/9970.gif" />&nbsp;&nbsp;<img src="images/items/6500.gif" />&nbsp;&nbsp;<img src="images/items/2143.gif" />&nbsp;&nbsp;<img src="images/items/2470.gif" />&nbsp;&nbsp;<img src="images/items/7368.gif" />&nbsp;&nbsp;<img src="images/items/2144.gif" />&nbsp;&nbsp;<img src="images/items/2145.gif" />&nbsp;&nbsp;<img src="images/items/2514.gif" />&nbsp;&nbsp;<img src="images/items/8932.gif" />&nbsp;&nbsp;<img src="images/items/8925.gif" />&nbsp;&nbsp;<img src="images/items/2466.gif" />&nbsp;&nbsp;<img src="images/items/7412.gif" />&nbsp;&nbsp;<img src="images/items/7590.gif" />&nbsp;&nbsp;<img src="images/items/8904.gif" />&nbsp;&nbsp;<img src="images/items/7591.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/8901.gif" />&nbsp;&nbsp;<img src="images/items/2415.gif" />&nbsp;&nbsp;<img src="images/items/8926.gif" />&nbsp;&nbsp;<img src="images/items/2645.gif" />&nbsp;&nbsp;<img src="images/items/8902.gif" />&nbsp;&nbsp;<img src="images/items/2136.gif" />&nbsp;&nbsp;<img src="images/items/2488.gif" />&nbsp;&nbsp;<img src="images/items/8879.gif" />&nbsp;&nbsp;<img src="images/items/2146.gif" />&nbsp;&nbsp;<img src="images/items/2195.gif" />&nbsp;&nbsp;<img src="images/items/8918.gif" />&nbsp;&nbsp;', 'hellgorak.gif'),
(0, 'Latrivan', 0, 10000, 40000, 60, 0, '"I might reward you for killing my brother ~ with a swift dead!"', 'fire', 0, 0, 'fire', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2152.gif" />&nbsp;&nbsp;<img src="images/items/2144.gif" />&nbsp;&nbsp;<img src="images/items/7440.gif" />&nbsp;&nbsp;<img src="images/items/2514.gif" />&nbsp;&nbsp;<img src="images/items/2171.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2151.gif" />&nbsp;&nbsp;<img src="images/items/2470.gif" />&nbsp;&nbsp;<img src="images/items/2432.gif" />&nbsp;&nbsp;', 'latrivan.gif'),
(0, 'Madareth', 0, 100000, 55000, 80, 0, '"I AM GOING TO PLAY WITH YOURSELF!"', 'energy, fire, invisible', 0, 0, 'fire', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2514.gif" />&nbsp;&nbsp;<img src="images/items/2214.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2520.gif" />&nbsp;&nbsp;<img src="images/items/2145.gif" />&nbsp;&nbsp;', 'madareth.gif'),
(0, 'Zugurosh', 0, 10000, 95000, 60, 0, '"You will run out of resources soon enough!!", "One little mistake and your all are mine!", "I sense your strength fading!"', 'death, paralyze, invisible', 0, 0, 'fire', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/6300.gif" />&nbsp;&nbsp;<img src="images/items/2195.gif" />&nbsp;&nbsp;<img src="images/items/2393.gif" />&nbsp;&nbsp;<img src="images/items/2432.gif" />&nbsp;&nbsp;<img src="images/items/2402.gif" />&nbsp;&nbsp;<img src="images/items/2477.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2151.gif" />&nbsp;&nbsp;<img src="images/items/2462.gif" />&nbsp;&nbsp;<img src="images/items/2149.gif" />&nbsp;&nbsp;<img src="images/items/2171.gif" />&nbsp;&nbsp;<img src="images/items/2158.gif" />&nbsp;&nbsp;<img src="images/items/2470.gif" />&nbsp;&nbsp;<img src="images/items/2520.gif" />&nbsp;&nbsp;', 'zugurosh.gif'),
(0, 'Ushuriel', 0, 10000, 50000, 65, 1, '', 'lifedrain, paralyze, invisible', 0, 0, 'fire', '<img src="images/items/2136.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2150.gif" />&nbsp;&nbsp;<img src="images/items/7388.gif" />&nbsp;&nbsp;<img src="images/items/2130.gif" />&nbsp;&nbsp;<img src="images/items/2208.gif" />&nbsp;&nbsp;<img src="images/items/8871.gif" />&nbsp;&nbsp;<img src="images/items/2158.gif" />&nbsp;&nbsp;<img src="images/items/2155.gif" />&nbsp;&nbsp;<img src="images/items/2210.gif" />&nbsp;&nbsp;<img src="images/items/9970.gif" />&nbsp;&nbsp;<img src="images/items/6500.gif" />&nbsp;&nbsp;<img src="images/items/2143.gif" />&nbsp;&nbsp;<img src="images/items/2470.gif" />&nbsp;&nbsp;<img src="images/items/7368.gif" />&nbsp;&nbsp;<img src="images/items/2144.gif" />&nbsp;&nbsp;<img src="images/items/2145.gif" />&nbsp;&nbsp;<img src="images/items/2514.gif" />&nbsp;&nbsp;<img src="images/items/8932.gif" />&nbsp;&nbsp;<img src="images/items/8925.gif" />&nbsp;&nbsp;<img src="images/items/2466.gif" />&nbsp;&nbsp;<img src="images/items/7412.gif" />&nbsp;&nbsp;<img src="images/items/7590.gif" />&nbsp;&nbsp;<img src="images/items/8904.gif" />&nbsp;&nbsp;<img src="images/items/7591.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/8901.gif" />&nbsp;&nbsp;<img src="images/items/2415.gif" />&nbsp;&nbsp;<img src="images/items/8926.gif" />&nbsp;&nbsp;<img src="images/items/2645.gif" />&nbsp;&nbsp;<img src="images/items/8902.gif" />&nbsp;&nbsp;<img src="images/items/2488.gif" />&nbsp;&nbsp;<img src="images/items/8879.gif" />&nbsp;&nbsp;<img src="images/items/2146.gif" />&nbsp;&nbsp;<img src="images/items/2195.gif" />&nbsp;&nbsp;<img src="images/items/8918.gif" />&nbsp;&nbsp;', 'ushuriel.gif'),
(0, 'Golgordan', 0, 10000, 40000, 65, 0, '"Latrivan your fool"', 'death', 0, 0, 'fire', '', 'golgordan.gif'),
(0, 'Thornback Tortoise', 490, 150, 300, 1, 0, '', '', 0, 1, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/5678.gif" />&nbsp;&nbsp;<img src="images/items/2667.gif" />&nbsp;&nbsp;<img src="images/items/2789.gif" />&nbsp;&nbsp;<img src="images/items/2391.gif" />&nbsp;&nbsp;<img src="images/items/2787.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;', 'thornbacktortoise.gif'),
(0, 'Tortoise', 445, 90, 150, 1, 0, '', '', 0, 1, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/5899.gif" />&nbsp;&nbsp;<img src="images/items/5678.gif" />&nbsp;&nbsp;<img src="images/items/6131.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;<img src="images/items/2417.gif" />&nbsp;&nbsp;<img src="images/items/2510.gif" />&nbsp;&nbsp;', 'tortoise.gif'),
(0, 'Deathslicer', 0, 340, 2000, 75, 0, '', 'physical, holy, energy, fire, death, earth, ice, poison, lifedrain, outfit, drunk, invisible', 0, 0, 'undead', '', 'deathslicer.gif'),
(0, 'Flamethrower', 0, 1200, 9950, 1, 0, '', 'physical, energy, fire, poison, lifedrain, paralyze, outfit, drunk, invisible', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;', 'flamethrower.gif'),
(0, 'Magicthrower', 0, 1200, 9950, 1, 0, '', 'physical, energy, fire, poison, lifedrain, paralyze, outfit, drunk, invisible', 0, 0, 'undead', '', 'magicthrower.gif'),
(0, 'Plaguethrower', 0, 1300, 9950, 1, 0, '', 'physical, energy, fire, poison, lifedrain, paralyze, outfit, drunk, invisible', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;', 'plaguethrower.gif'),
(0, 'Poisonthrower', 0, 1200, 9950, 1, 0, '', 'energy, fire, poison, lifedrain, paralyze, outfit, drunk, invisible', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;', 'poisonthrower.gif'),
(0, 'Shredderthrower', 0, 18, 100, 1, 0, '', 'physical, energy, fire, poison, lifedrain, paralyze, outfit, drunk, invisible', 0, 0, 'undead', '', 'shredderthrower.gif'),
(0, 'Troll Champion', 340, 30, 75, 1, 0, '"Meee maity!", "Grrrr", "Whaaaz up!?", "Gruntz!"', '', 1, 1, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2380.gif" />&nbsp;&nbsp;<img src="images/items/2643.gif" />&nbsp;&nbsp;<img src="images/items/2461.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/2120.gif" />&nbsp;&nbsp;<img src="images/items/2389.gif" />&nbsp;&nbsp;<img src="images/items/2448.gif" />&nbsp;&nbsp;<img src="images/items/2512.gif" />&nbsp;&nbsp;', 'trollchampion.gif'),
(0, 'Frost Troll', 300, 23, 55, 1, 0, '"Brrrr", "Broar!"', '', 1, 1, 'blood', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2382.gif" />&nbsp;&nbsp;<img src="images/items/2512.gif" />&nbsp;&nbsp;<img src="images/items/2651.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2384.gif" />&nbsp;&nbsp;<img src="images/items/2667.gif" />&nbsp;&nbsp;<img src="images/items/2448.gif" />&nbsp;&nbsp;', 'frosttroll.gif'),
(0, 'Island Troll', 290, 20, 50, 1, 0, '"Hmmm, turtles", "HHmmm, dogs", "Groar", "Gruntz!"', '', 1, 0, 'blood', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2389.gif" />&nbsp;&nbsp;<img src="images/items/2643.gif" />&nbsp;&nbsp;<img src="images/items/2461.gif" />&nbsp;&nbsp;<img src="images/items/2120.gif" />&nbsp;&nbsp;<img src="images/items/2172.gif" />&nbsp;&nbsp;<img src="images/items/5901.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2512.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/2380.gif" />&nbsp;&nbsp;<img src="images/items/2170.gif" />&nbsp;&nbsp;<img src="images/items/2448.gif" />&nbsp;&nbsp;', 'islandtroll.gif'),
(0, 'Swamp Troll', 320, 65, 55, 1, 0, '"Grrrr", "Groar!", "Me strong! Me ate spinach!"', '', 1, 1, 'VENOM', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2667.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2643.gif" />&nbsp;&nbsp;<img src="images/items/2050.gif" />&nbsp;&nbsp;<img src="images/items/2580.gif" />&nbsp;&nbsp;', 'swamptroll.gif'),
(0, 'Troll', 290, 20, 50, 1, 0, '"Grrrr", "Groar", "Gruntz!", "Hmmm, bugs.", "Hmmm, dogs."', '', 1, 1, 'blood', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2389.gif" />&nbsp;&nbsp;<img src="images/items/2643.gif" />&nbsp;&nbsp;<img src="images/items/2461.gif" />&nbsp;&nbsp;<img src="images/items/2120.gif" />&nbsp;&nbsp;<img src="images/items/2172.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2512.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/2380.gif" />&nbsp;&nbsp;<img src="images/items/2170.gif" />&nbsp;&nbsp;<img src="images/items/2448.gif" />&nbsp;&nbsp;', 'troll.gif'),
(0, 'Banshee', 0, 900, 1000, 1, 0, '"Are you ready to rock?", "That''s what I call easy listening!", "Let the music play!", "I will mourn your death!", "IIIIEEEeeeeeehhhHHHHH!", "Dance for me your dance of death!", "Feel my gentle kiss of death."', 'death, earth, fire, lifedrain, paralyze, invisible', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2144.gif" />&nbsp;&nbsp;<img src="images/items/2657.gif" />&nbsp;&nbsp;<img src="images/items/2168.gif" />&nbsp;&nbsp;<img src="images/items/2170.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2654.gif" />&nbsp;&nbsp;<img src="images/items/2655.gif" />&nbsp;&nbsp;<img src="images/items/2656.gif" />&nbsp;&nbsp;', 'banshee.gif'),
(0, 'Blightwalker', 0, 3350, 8900, 25, 0, '"I can see you decaying!", "Let me taste your mortality!"', 'earth, death, lifedrain, paralyze, invisible', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2694.gif" />&nbsp;&nbsp;<img src="images/items/2050.gif" />&nbsp;&nbsp;<img src="images/items/2230.gif" />&nbsp;&nbsp;<img src="images/items/2260.gif" />&nbsp;&nbsp;<img src="images/items/5902.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2386.gif" />&nbsp;&nbsp;<img src="images/items/2649.gif" />&nbsp;&nbsp;<img src="images/items/6500.gif" />&nbsp;&nbsp;<img src="images/items/5944.gif" />&nbsp;&nbsp;<img src="images/items/2436.gif" />&nbsp;&nbsp;<img src="images/items/2550.gif" />&nbsp;&nbsp;<img src="images/items/7884.gif" />&nbsp;&nbsp;<img src="images/items/7885.gif" />&nbsp;&nbsp;', 'blightwalker.gif'),
(0, 'Crypt Shambler', 0, 195, 330, 1, 0, '"Uhhhhhhh!", "Aaaaahhhh!", "Hoooohhh!", "Chhhhhhh!"', 'poison, lifedrain, paralyze', 0, 1, 'UNDEAD', '<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2377.gif" />&nbsp;&nbsp;<img src="images/items/2399.gif" />&nbsp;&nbsp;<img src="images/items/2450.gif" />&nbsp;&nbsp;<img src="images/items/2482.gif" />&nbsp;&nbsp;<img src="images/items/2541.gif" />&nbsp;&nbsp;', 'cryptshambler.gif'),
(0, 'Ghoul', 450, 85, 100, 1, 0, '', 'death, lifedrain, paralyze, invisible', 1, 1, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/2050.gif" />&nbsp;&nbsp;<img src="images/items/2483.gif" />&nbsp;&nbsp;<img src="images/items/2473.gif" />&nbsp;&nbsp;<img src="images/items/2398.gif" />&nbsp;&nbsp;<img src="images/items/5913.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2460.gif" />&nbsp;&nbsp;<img src="images/items/2229.gif" />&nbsp;&nbsp;<img src="images/items/2403.gif" />&nbsp;&nbsp;<img src="images/items/2168.gif" />&nbsp;&nbsp;', 'ghoul.gif'),
(0, 'Lich', 0, 900, 880, 23, 0, '"Doomed be the living!", "You will endure agony beyond thy death!", "Death awaits all!", "Thy living flesh offends me!", "Death and Decay!"', 'death, earth, paralyze, invisible', 0, 0, 'UNDEAD', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2401.gif" />&nbsp;&nbsp;<img src="images/items/2171.gif" />&nbsp;&nbsp;<img src="images/items/2656.gif" />&nbsp;&nbsp;<img src="images/items/2144.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2535.gif" />&nbsp;&nbsp;<img src="images/items/2165.gif" />&nbsp;&nbsp;<img src="images/items/2143.gif" />&nbsp;&nbsp;<img src="images/items/2237.gif" />&nbsp;&nbsp;<img src="images/items/2175.gif" />&nbsp;&nbsp;<img src="images/items/2179.gif" />&nbsp;&nbsp;<img src="images/items/3961.gif" />&nbsp;&nbsp;', 'lich.gif'),
(0, 'Mummy', 0, 150, 240, 1, 0, '', 'earth, death, lifedrain, paralyze, invisible', 0, 0, 'UNDEAD', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2161.gif" />&nbsp;&nbsp;<img src="images/items/2162.gif" />&nbsp;&nbsp;<img src="images/items/2134.gif" />&nbsp;&nbsp;<img src="images/items/2411.gif" />&nbsp;&nbsp;<img src="images/items/2529.gif" />&nbsp;&nbsp;<img src="images/items/5914.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2144.gif" />&nbsp;&nbsp;<img src="images/items/2124.gif" />&nbsp;&nbsp;<img src="images/items/2169.gif" />&nbsp;&nbsp;<img src="images/items/2170.gif" />&nbsp;&nbsp;', 'mummy.gif'),
(0, 'Vampire', 100, 305, 475, 18, 1, '"BLOOD!", "Let me kiss your neck.", "I smell warm blood.", "I call you, my bats! Come!"', 'earth, death, lifedrain, paralyze, invisible', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2649.gif" />&nbsp;&nbsp;<img src="images/items/2383.gif" />&nbsp;&nbsp;<img src="images/items/5905.gif" />&nbsp;&nbsp;<img src="images/items/2172.gif" />&nbsp;&nbsp;<img src="images/items/2127.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2032.gif" />&nbsp;&nbsp;<img src="images/items/2229.gif" />&nbsp;&nbsp;<img src="images/items/2412.gif" />&nbsp;&nbsp;<img src="images/items/2747.gif" />&nbsp;&nbsp;<img src="images/items/2534.gif" />&nbsp;&nbsp;<img src="images/items/2396.gif" />&nbsp;&nbsp;<img src="images/items/2144.gif" />&nbsp;&nbsp;<img src="images/items/2479.gif" />&nbsp;&nbsp;', 'vampire.gif'),
(0, 'Grim Reaper', 0, 4500, 4100, 75, 0, '"Death!", "Come a little closer!", "The end is near!"', 'lifedrain, paralyze, invisible', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2152.gif" />&nbsp;&nbsp;<img src="images/items/2150.gif" />&nbsp;&nbsp;<img src="images/items/6558.gif" />&nbsp;&nbsp;<img src="images/items/6500.gif" />&nbsp;&nbsp;<img src="images/items/6300.gif" />&nbsp;&nbsp;<img src="images/items/5909.gif" />&nbsp;&nbsp;<img src="images/items/2521.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/5022.gif" />&nbsp;&nbsp;<img src="images/items/8889.gif" />&nbsp;&nbsp;<img src="images/items/7418.gif" />&nbsp;&nbsp;<img src="images/items/7589.gif" />&nbsp;&nbsp;<img src="images/items/8910.gif" />&nbsp;&nbsp;<img src="images/items/8473.gif" />&nbsp;&nbsp;', 'grimreaper.gif'),
(0, 'The Count', 0, 1750, 4600, 75, 0, '', 'lifedrain, death, invisible', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/8752.gif" />&nbsp;&nbsp;<img src="images/items/2391.gif" />&nbsp;&nbsp;', 'thecount.gif'),
(0, 'Gravelord Oshuran', 0, 2400, 3100, 30, 0, '"Your mortality is disgusting"', 'death, earth, paralyze, invisible', 0, 0, 'UNDEAD', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/7893.gif" />&nbsp;&nbsp;<img src="images/items/2656.gif" />&nbsp;&nbsp;<img src="images/items/8978.gif" />&nbsp;&nbsp;<img src="images/items/2144.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2165.gif" />&nbsp;&nbsp;<img src="images/items/2143.gif" />&nbsp;&nbsp;<img src="images/items/8904.gif" />&nbsp;&nbsp;', 'gravelordoshuran.gif'),
(0, 'Arachir The Ancient One', 0, 1800, 1600, 40, 0, '"I was the shadow that haunted the cradle of humanity!", "I exist since eons and you want to defy me?", "Can you feel the passage of time, mortal?"', 'lifedrain, death, invisible', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2152.gif" />&nbsp;&nbsp;<img src="images/items/8978.gif" />&nbsp;&nbsp;<img src="images/items/2216.gif" />&nbsp;&nbsp;<img src="images/items/7598.gif" />&nbsp;&nbsp;<img src="images/items/2534.gif" />&nbsp;&nbsp;<img src="images/items/2144.gif" />&nbsp;&nbsp;', 'arachirtheancientone.gif'),
(0, 'Diblis The Fair', 0, 1800, 1600, 30, 0, '"I envy you to be slain by someone as beautiful as me.", "I will drain your ugly corpses of the last drop of blood."', 'lifedrain, death, invisible', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2152.gif" />&nbsp;&nbsp;<img src="images/items/8978.gif" />&nbsp;&nbsp;<img src="images/items/2216.gif" />&nbsp;&nbsp;<img src="images/items/7598.gif" />&nbsp;&nbsp;<img src="images/items/2534.gif" />&nbsp;&nbsp;<img src="images/items/2144.gif" />&nbsp;&nbsp;<img src="images/items/8903.gif" />&nbsp;&nbsp;', 'diblisthefair.gif'),
(0, 'Sir Valorcrest', 0, 1800, 1600, 25, 0, '"I challenge you!"', 'lifedrain, death, invisible', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2152.gif" />&nbsp;&nbsp;<img src="images/items/8978.gif" />&nbsp;&nbsp;<img src="images/items/2216.gif" />&nbsp;&nbsp;<img src="images/items/7598.gif" />&nbsp;&nbsp;<img src="images/items/2534.gif" />&nbsp;&nbsp;', 'sirvalorcrest.gif'),
(0, 'Zevelon Duskbringer', 0, 1800, 1600, 45, 0, '"Human blood is not suitable for drinking", "Your short live is coming to an end", "Ashari Mortals. Come and stay forever!"', 'lifedrain, death, invisible', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2152.gif" />&nbsp;&nbsp;<img src="images/items/8978.gif" />&nbsp;&nbsp;<img src="images/items/2216.gif" />&nbsp;&nbsp;<img src="images/items/7598.gif" />&nbsp;&nbsp;<img src="images/items/2534.gif" />&nbsp;&nbsp;', 'zevelonduskbringer.gif'),
(0, 'Forest Dragon', 0, 1100, 1200, 8, 0, '"GROOAAARRR", "FCHHHHH"', 'fire, poison, paralyze, outfit, drunk, invisible', 0, 0, 'blood', '<img src="images/items/2413.gif" />&nbsp;&nbsp;<img src="images/items/2546.gif" />&nbsp;&nbsp;<img src="images/items/2455.gif" />&nbsp;&nbsp;<img src="images/items/2387.gif" />&nbsp;&nbsp;<img src="images/items/2672.gif" />&nbsp;&nbsp;<img src="images/items/2434.gif" />&nbsp;&nbsp;<img src="images/items/2516.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2177.gif" />&nbsp;&nbsp;<img src="images/items/2397.gif" />&nbsp;&nbsp;<img src="images/items/2398.gif" />&nbsp;&nbsp;<img src="images/items/2647.gif" />&nbsp;&nbsp;<img src="images/items/2409.gif" />&nbsp;&nbsp;<img src="images/items/2406.gif" />&nbsp;&nbsp;<img src="images/items/2145.gif" />&nbsp;&nbsp;<img src="images/items/2457.gif" />&nbsp;&nbsp;<img src="images/items/2509.gif" />&nbsp;&nbsp;<img src="images/items/2187.gif" />&nbsp;&nbsp;', 'forestdragon.gif'),
(0, 'Knight', 0, 2500, 2500, 85, 1, '"Power by Melee!"', 'paralyze, outfit, drunk, invisible', 0, 0, 'blood', '<img src="images/items/2544.gif" />&nbsp;&nbsp;<img src="images/items/2456.gif" />&nbsp;&nbsp;<img src="images/items/2487.gif" />&nbsp;&nbsp;<img src="images/items/2491.gif" />&nbsp;&nbsp;<img src="images/items/2488.gif" />&nbsp;&nbsp;<img src="images/items/2519.gif" />&nbsp;&nbsp;<img src="images/items/2392.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2681.gif" />&nbsp;&nbsp;<img src="images/items/2652.gif" />&nbsp;&nbsp;<img src="images/items/2071.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/2164.gif" />&nbsp;&nbsp;<img src="images/items/2744.gif" />&nbsp;&nbsp;<img src="images/items/2120.gif" />&nbsp;&nbsp;<img src="images/items/2661.gif" />&nbsp;&nbsp;<img src="images/items/1949.gif" />&nbsp;&nbsp;<img src="images/items/2377.gif" />&nbsp;&nbsp;<img src="images/items/2391.gif" />&nbsp;&nbsp;<img src="images/items/2121.gif" />&nbsp;&nbsp;', 'knight.gif'),
(0, 'Paladin', 0, 2500, 2000, 70, 1, '"Exori San"', 'energy, fire, poison, paralyze, outfit, drunk, invisible', 0, 0, 'blood', '<img src="images/items/2544.gif" />&nbsp;&nbsp;<img src="images/items/2456.gif" />&nbsp;&nbsp;<img src="images/items/2487.gif" />&nbsp;&nbsp;<img src="images/items/2491.gif" />&nbsp;&nbsp;<img src="images/items/2488.gif" />&nbsp;&nbsp;<img src="images/items/2519.gif" />&nbsp;&nbsp;<img src="images/items/2392.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2681.gif" />&nbsp;&nbsp;<img src="images/items/2652.gif" />&nbsp;&nbsp;<img src="images/items/2071.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/2164.gif" />&nbsp;&nbsp;<img src="images/items/2744.gif" />&nbsp;&nbsp;<img src="images/items/2120.gif" />&nbsp;&nbsp;<img src="images/items/2661.gif" />&nbsp;&nbsp;<img src="images/items/1949.gif" />&nbsp;&nbsp;<img src="images/items/2377.gif" />&nbsp;&nbsp;<img src="images/items/2391.gif" />&nbsp;&nbsp;<img src="images/items/2121.gif" />&nbsp;&nbsp;', 'paladin.gif'),
(0, 'Druid', 0, 2500, 1500, 85, 1, '"Let''s have a fight!", "Welcome to my battleground.", "Have you seen princess Lumelia?", "I will sing a tune at your grave."', 'energy, fire, poison, paralyze, outfit, drunk, invisible', 0, 0, 'blood', '<img src="images/items/2544.gif" />&nbsp;&nbsp;<img src="images/items/2456.gif" />&nbsp;&nbsp;<img src="images/items/2487.gif" />&nbsp;&nbsp;<img src="images/items/2491.gif" />&nbsp;&nbsp;<img src="images/items/2488.gif" />&nbsp;&nbsp;<img src="images/items/2519.gif" />&nbsp;&nbsp;<img src="images/items/2392.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2681.gif" />&nbsp;&nbsp;<img src="images/items/2652.gif" />&nbsp;&nbsp;<img src="images/items/2071.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/2164.gif" />&nbsp;&nbsp;<img src="images/items/2744.gif" />&nbsp;&nbsp;<img src="images/items/2120.gif" />&nbsp;&nbsp;<img src="images/items/2661.gif" />&nbsp;&nbsp;<img src="images/items/1949.gif" />&nbsp;&nbsp;<img src="images/items/2377.gif" />&nbsp;&nbsp;<img src="images/items/2391.gif" />&nbsp;&nbsp;<img src="images/items/2121.gif" />&nbsp;&nbsp;', 'druid.gif'),
(0, 'Sorcerer', 0, 2500, 1500, 85, 1, '"Noob!!"', 'invisible', 0, 0, 'blood', '<img src="images/items/2544.gif" />&nbsp;&nbsp;<img src="images/items/2456.gif" />&nbsp;&nbsp;<img src="images/items/2487.gif" />&nbsp;&nbsp;<img src="images/items/2491.gif" />&nbsp;&nbsp;<img src="images/items/2488.gif" />&nbsp;&nbsp;<img src="images/items/2519.gif" />&nbsp;&nbsp;<img src="images/items/2392.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2681.gif" />&nbsp;&nbsp;<img src="images/items/2652.gif" />&nbsp;&nbsp;<img src="images/items/2071.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/2164.gif" />&nbsp;&nbsp;<img src="images/items/2744.gif" />&nbsp;&nbsp;<img src="images/items/2120.gif" />&nbsp;&nbsp;<img src="images/items/2661.gif" />&nbsp;&nbsp;<img src="images/items/1949.gif" />&nbsp;&nbsp;<img src="images/items/2377.gif" />&nbsp;&nbsp;<img src="images/items/2391.gif" />&nbsp;&nbsp;<img src="images/items/2121.gif" />&nbsp;&nbsp;', 'sorcerer.gif'),
(0, 'Emperium', 0, 0, 50000, 1, 0, '', '', 1, 0, 'undead', '', 'emperium.gif'),
(0, 'Guard', 0, 0, 20000, 1, 1, '', 'invisible', 0, 0, 'blood', '', 'guard.gif'),
(0, 'Mercenary', 0, 1600, 1800, 85, 0, '"MINE!", "NO PRISONERS!", "NO MERCY!", "By Bolg''s Blood!", "You''re no match for me!"', 'energy, fire, poison, paralyze, outfit, drunk, invisible', 0, 0, 'blood', '<img src="images/items/2417.gif" />&nbsp;&nbsp;<img src="images/items/2195.gif" />&nbsp;&nbsp;<img src="images/items/2478.gif" />&nbsp;&nbsp;<img src="images/items/2691.gif" />&nbsp;&nbsp;<img src="images/items/2489.gif" />&nbsp;&nbsp;<img src="images/items/2490.gif" />&nbsp;&nbsp;<img src="images/items/2414.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2381.gif" />&nbsp;&nbsp;<img src="images/items/2476.gif" />&nbsp;&nbsp;<img src="images/items/2430.gif" />&nbsp;&nbsp;<img src="images/items/2477.gif" />&nbsp;&nbsp;<img src="images/items/2463.gif" />&nbsp;&nbsp;<img src="images/items/2120.gif" />&nbsp;&nbsp;<img src="images/items/2133.gif" />&nbsp;&nbsp;<img src="images/items/2389.gif" />&nbsp;&nbsp;<img src="images/items/2457.gif" />&nbsp;&nbsp;<img src="images/items/2377.gif" />&nbsp;&nbsp;<img src="images/items/2475.gif" />&nbsp;&nbsp;', 'mercenary.gif'),
(0, 'Thief', 0, 500, 500, 35, 0, '"Sneak Sneak!", "Let me look in your backpack!"', 'energy, fire, poison, paralyze, outfit, drunk, invisible', 0, 0, 'blood', '<img src="images/items/2544.gif" />&nbsp;&nbsp;<img src="images/items/2456.gif" />&nbsp;&nbsp;<img src="images/items/2487.gif" />&nbsp;&nbsp;<img src="images/items/2491.gif" />&nbsp;&nbsp;<img src="images/items/2488.gif" />&nbsp;&nbsp;<img src="images/items/2519.gif" />&nbsp;&nbsp;<img src="images/items/2392.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2681.gif" />&nbsp;&nbsp;<img src="images/items/2652.gif" />&nbsp;&nbsp;<img src="images/items/2071.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/2164.gif" />&nbsp;&nbsp;<img src="images/items/2744.gif" />&nbsp;&nbsp;<img src="images/items/2120.gif" />&nbsp;&nbsp;<img src="images/items/2661.gif" />&nbsp;&nbsp;<img src="images/items/1949.gif" />&nbsp;&nbsp;<img src="images/items/2377.gif" />&nbsp;&nbsp;<img src="images/items/2391.gif" />&nbsp;&nbsp;<img src="images/items/2121.gif" />&nbsp;&nbsp;', 'thief.gif'),
(0, 'Toxiros', 0, 30000, 125000, 160, 1, '"Got antidote?", "The path of poisen!", "I''m Toxic!", "My dear scarab.."', 'energy, fire, poison, lifedrain, paralyze, outfit, drunk, invisible', 0, 0, 'fire', '<img src="images/items/2142.gif" />&nbsp;&nbsp;<img src="images/items/2231.gif" />&nbsp;&nbsp;<img src="images/items/2144.gif" />&nbsp;&nbsp;<img src="images/items/2158.gif" />&nbsp;&nbsp;<img src="images/items/2195.gif" />&nbsp;&nbsp;<img src="images/items/2192.gif" />&nbsp;&nbsp;<img src="images/items/2125.gif" />&nbsp;&nbsp;<img src="images/items/2124.gif" />&nbsp;&nbsp;<img src="images/items/2520.gif" />&nbsp;&nbsp;<img src="images/items/2462.gif" />&nbsp;&nbsp;<img src="images/items/2387.gif" />&nbsp;&nbsp;<img src="images/items/2434.gif" />&nbsp;&nbsp;<img src="images/items/2167.gif" />&nbsp;&nbsp;<img src="images/items/2432.gif" />&nbsp;&nbsp;<img src="images/items/2393.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2179.gif" />&nbsp;&nbsp;<img src="images/items/2470.gif" />&nbsp;&nbsp;<img src="images/items/2033.gif" />&nbsp;&nbsp;<img src="images/items/2418.gif" />&nbsp;&nbsp;<img src="images/items/2155.gif" />&nbsp;&nbsp;<img src="images/items/2396.gif" />&nbsp;&nbsp;<img src="images/items/2177.gif" />&nbsp;&nbsp;<img src="images/items/2162.gif" />&nbsp;&nbsp;<img src="images/items/2472.gif" />&nbsp;&nbsp;<img src="images/items/2514.gif" />&nbsp;&nbsp;<img src="images/items/2164.gif" />&nbsp;&nbsp;<img src="images/items/2178.gif" />&nbsp;&nbsp;<img src="images/items/2186.gif" />&nbsp;&nbsp;<img src="images/items/2176.gif" />&nbsp;&nbsp;<img src="images/items/2171.gif" />&nbsp;&nbsp;<img src="images/items/2200.gif" />&nbsp;&nbsp;<img src="images/items/1982.gif" />&nbsp;&nbsp;<img src="images/items/2214.gif" />&nbsp;&nbsp;<img src="images/items/2123.gif" />&nbsp;&nbsp;<img src="images/items/2170.gif" />&nbsp;&nbsp;<img src="images/items/2402.gif" />&nbsp;&nbsp;<img src="images/items/2436.gif" />&nbsp;&nbsp;<img src="images/items/2150.gif" />&nbsp;&nbsp;<img src="images/items/2145.gif" />&nbsp;&nbsp;<img src="images/items/2149.gif" />&nbsp;&nbsp;<img src="images/items/2146.gif" />&nbsp;&nbsp;<img src="images/items/2182.gif" />&nbsp;&nbsp;<img src="images/items/2165.gif" />&nbsp;&nbsp;<img src="images/items/2197.gif" />&nbsp;&nbsp;<img src="images/items/2174.gif" />&nbsp;&nbsp;<img src="images/items/2151.gif" />&nbsp;&nbsp;<img src="images/items/2112.gif" />&nbsp;&nbsp;<img src="images/items/2421.gif" />&nbsp;&nbsp;<img src="images/items/2377.gif" />&nbsp;&nbsp;<img src="images/items/2185.gif" />&nbsp;&nbsp;<img src="images/items/3955.gif" />&nbsp;&nbsp;<img src="images/items/2188.gif" />&nbsp;&nbsp;<img src="images/items/2143.gif" />&nbsp;&nbsp;', 'toxiros.gif'),
(0, 'Pyramo', 0, 30000, 125000, 160, 1, '"You fear fire, I can feel it!", "Feel the heat!", "Hot Eh?", "HA HA HA HA HA.."', 'energy, fire, poison, lifedrain, paralyze, outfit, drunk, invisible', 0, 0, 'fire', '<img src="images/items/2142.gif" />&nbsp;&nbsp;<img src="images/items/2231.gif" />&nbsp;&nbsp;<img src="images/items/2144.gif" />&nbsp;&nbsp;<img src="images/items/2158.gif" />&nbsp;&nbsp;<img src="images/items/2195.gif" />&nbsp;&nbsp;<img src="images/items/2192.gif" />&nbsp;&nbsp;<img src="images/items/2125.gif" />&nbsp;&nbsp;<img src="images/items/2124.gif" />&nbsp;&nbsp;<img src="images/items/2520.gif" />&nbsp;&nbsp;<img src="images/items/2462.gif" />&nbsp;&nbsp;<img src="images/items/2387.gif" />&nbsp;&nbsp;<img src="images/items/2434.gif" />&nbsp;&nbsp;<img src="images/items/2167.gif" />&nbsp;&nbsp;<img src="images/items/2432.gif" />&nbsp;&nbsp;<img src="images/items/2393.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2179.gif" />&nbsp;&nbsp;<img src="images/items/2470.gif" />&nbsp;&nbsp;<img src="images/items/2033.gif" />&nbsp;&nbsp;<img src="images/items/2418.gif" />&nbsp;&nbsp;<img src="images/items/2155.gif" />&nbsp;&nbsp;<img src="images/items/2396.gif" />&nbsp;&nbsp;<img src="images/items/2177.gif" />&nbsp;&nbsp;<img src="images/items/2162.gif" />&nbsp;&nbsp;<img src="images/items/2472.gif" />&nbsp;&nbsp;<img src="images/items/2514.gif" />&nbsp;&nbsp;<img src="images/items/2164.gif" />&nbsp;&nbsp;<img src="images/items/2178.gif" />&nbsp;&nbsp;<img src="images/items/2186.gif" />&nbsp;&nbsp;<img src="images/items/2176.gif" />&nbsp;&nbsp;<img src="images/items/2171.gif" />&nbsp;&nbsp;<img src="images/items/2200.gif" />&nbsp;&nbsp;<img src="images/items/1982.gif" />&nbsp;&nbsp;<img src="images/items/2214.gif" />&nbsp;&nbsp;<img src="images/items/2123.gif" />&nbsp;&nbsp;<img src="images/items/2170.gif" />&nbsp;&nbsp;<img src="images/items/2402.gif" />&nbsp;&nbsp;<img src="images/items/2436.gif" />&nbsp;&nbsp;<img src="images/items/2150.gif" />&nbsp;&nbsp;<img src="images/items/2145.gif" />&nbsp;&nbsp;<img src="images/items/2149.gif" />&nbsp;&nbsp;<img src="images/items/2146.gif" />&nbsp;&nbsp;<img src="images/items/2182.gif" />&nbsp;&nbsp;<img src="images/items/2165.gif" />&nbsp;&nbsp;<img src="images/items/2197.gif" />&nbsp;&nbsp;<img src="images/items/2174.gif" />&nbsp;&nbsp;<img src="images/items/2151.gif" />&nbsp;&nbsp;<img src="images/items/2112.gif" />&nbsp;&nbsp;<img src="images/items/2421.gif" />&nbsp;&nbsp;<img src="images/items/2377.gif" />&nbsp;&nbsp;<img src="images/items/2185.gif" />&nbsp;&nbsp;<img src="images/items/3955.gif" />&nbsp;&nbsp;<img src="images/items/2188.gif" />&nbsp;&nbsp;<img src="images/items/2143.gif" />&nbsp;&nbsp;', 'pyramo.gif'),
(0, 'Lazarus', 0, 30000, 125000, 160, 1, '"VOLTAGE!!", "The keeper of ENERGY", "BRrZzzZzZZZ"', 'energy, fire, poison, lifedrain, paralyze, outfit, drunk, invisible', 0, 0, 'fire', '<img src="images/items/2142.gif" />&nbsp;&nbsp;<img src="images/items/2231.gif" />&nbsp;&nbsp;<img src="images/items/2144.gif" />&nbsp;&nbsp;<img src="images/items/2158.gif" />&nbsp;&nbsp;<img src="images/items/2195.gif" />&nbsp;&nbsp;<img src="images/items/2192.gif" />&nbsp;&nbsp;<img src="images/items/2125.gif" />&nbsp;&nbsp;<img src="images/items/2124.gif" />&nbsp;&nbsp;<img src="images/items/2520.gif" />&nbsp;&nbsp;<img src="images/items/2462.gif" />&nbsp;&nbsp;<img src="images/items/2387.gif" />&nbsp;&nbsp;<img src="images/items/2434.gif" />&nbsp;&nbsp;<img src="images/items/2167.gif" />&nbsp;&nbsp;<img src="images/items/2432.gif" />&nbsp;&nbsp;<img src="images/items/2393.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2179.gif" />&nbsp;&nbsp;<img src="images/items/2470.gif" />&nbsp;&nbsp;<img src="images/items/2033.gif" />&nbsp;&nbsp;<img src="images/items/2418.gif" />&nbsp;&nbsp;<img src="images/items/2155.gif" />&nbsp;&nbsp;<img src="images/items/2396.gif" />&nbsp;&nbsp;<img src="images/items/2177.gif" />&nbsp;&nbsp;<img src="images/items/2162.gif" />&nbsp;&nbsp;<img src="images/items/2472.gif" />&nbsp;&nbsp;<img src="images/items/2514.gif" />&nbsp;&nbsp;<img src="images/items/2164.gif" />&nbsp;&nbsp;<img src="images/items/2178.gif" />&nbsp;&nbsp;<img src="images/items/2186.gif" />&nbsp;&nbsp;<img src="images/items/2176.gif" />&nbsp;&nbsp;<img src="images/items/2171.gif" />&nbsp;&nbsp;<img src="images/items/2200.gif" />&nbsp;&nbsp;<img src="images/items/1982.gif" />&nbsp;&nbsp;<img src="images/items/2214.gif" />&nbsp;&nbsp;<img src="images/items/2123.gif" />&nbsp;&nbsp;<img src="images/items/2170.gif" />&nbsp;&nbsp;<img src="images/items/2402.gif" />&nbsp;&nbsp;<img src="images/items/2436.gif" />&nbsp;&nbsp;<img src="images/items/2150.gif" />&nbsp;&nbsp;<img src="images/items/2145.gif" />&nbsp;&nbsp;<img src="images/items/2149.gif" />&nbsp;&nbsp;<img src="images/items/2146.gif" />&nbsp;&nbsp;<img src="images/items/2182.gif" />&nbsp;&nbsp;<img src="images/items/2165.gif" />&nbsp;&nbsp;<img src="images/items/2197.gif" />&nbsp;&nbsp;<img src="images/items/2174.gif" />&nbsp;&nbsp;<img src="images/items/2151.gif" />&nbsp;&nbsp;<img src="images/items/2112.gif" />&nbsp;&nbsp;<img src="images/items/2421.gif" />&nbsp;&nbsp;<img src="images/items/2377.gif" />&nbsp;&nbsp;<img src="images/items/2185.gif" />&nbsp;&nbsp;<img src="images/items/3955.gif" />&nbsp;&nbsp;<img src="images/items/2188.gif" />&nbsp;&nbsp;<img src="images/items/2143.gif" />&nbsp;&nbsp;', 'lazarus.gif');
INSERT INTO `z_monsters` (`hide_creature`, `name`, `mana`, `exp`, `health`, `speed_lvl`, `use_haste`, `voices`, `immunities`, `summonable`, `convinceable`, `race`, `loot`, `gfx_name`) VALUES
(0, 'Zathroth', 0, 9999, 28000, 85, 1, '"Want to feel some Aim?", "You can Run but never Hide!"', 'energy, fire, poison, lifedrain, paralyze, outfit, drunk, invisible', 0, 0, 'venom', '<img src="images/items/2142.gif" />&nbsp;&nbsp;<img src="images/items/2144.gif" />&nbsp;&nbsp;<img src="images/items/2158.gif" />&nbsp;&nbsp;<img src="images/items/2195.gif" />&nbsp;&nbsp;<img src="images/items/2186.gif" />&nbsp;&nbsp;<img src="images/items/2192.gif" />&nbsp;&nbsp;<img src="images/items/2125.gif" />&nbsp;&nbsp;<img src="images/items/2124.gif" />&nbsp;&nbsp;<img src="images/items/2520.gif" />&nbsp;&nbsp;<img src="images/items/2462.gif" />&nbsp;&nbsp;<img src="images/items/2387.gif" />&nbsp;&nbsp;<img src="images/items/2434.gif" />&nbsp;&nbsp;<img src="images/items/2167.gif" />&nbsp;&nbsp;<img src="images/items/2432.gif" />&nbsp;&nbsp;<img src="images/items/2393.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2179.gif" />&nbsp;&nbsp;<img src="images/items/2470.gif" />&nbsp;&nbsp;<img src="images/items/2033.gif" />&nbsp;&nbsp;<img src="images/items/2418.gif" />&nbsp;&nbsp;<img src="images/items/2182.gif" />&nbsp;&nbsp;<img src="images/items/2155.gif" />&nbsp;&nbsp;<img src="images/items/2188.gif" />&nbsp;&nbsp;<img src="images/items/2396.gif" />&nbsp;&nbsp;<img src="images/items/2177.gif" />&nbsp;&nbsp;<img src="images/items/2162.gif" />&nbsp;&nbsp;<img src="images/items/2472.gif" />&nbsp;&nbsp;<img src="images/items/2514.gif" />&nbsp;&nbsp;<img src="images/items/2164.gif" />&nbsp;&nbsp;<img src="images/items/2178.gif" />&nbsp;&nbsp;<img src="images/items/2176.gif" />&nbsp;&nbsp;<img src="images/items/2171.gif" />&nbsp;&nbsp;<img src="images/items/2200.gif" />&nbsp;&nbsp;<img src="images/items/1982.gif" />&nbsp;&nbsp;<img src="images/items/2214.gif" />&nbsp;&nbsp;<img src="images/items/2123.gif" />&nbsp;&nbsp;<img src="images/items/2170.gif" />&nbsp;&nbsp;<img src="images/items/2402.gif" />&nbsp;&nbsp;<img src="images/items/2436.gif" />&nbsp;&nbsp;<img src="images/items/2150.gif" />&nbsp;&nbsp;<img src="images/items/2145.gif" />&nbsp;&nbsp;<img src="images/items/2149.gif" />&nbsp;&nbsp;<img src="images/items/2146.gif" />&nbsp;&nbsp;<img src="images/items/2165.gif" />&nbsp;&nbsp;<img src="images/items/2197.gif" />&nbsp;&nbsp;<img src="images/items/2174.gif" />&nbsp;&nbsp;<img src="images/items/2151.gif" />&nbsp;&nbsp;<img src="images/items/2112.gif" />&nbsp;&nbsp;<img src="images/items/2421.gif" />&nbsp;&nbsp;<img src="images/items/2377.gif" />&nbsp;&nbsp;<img src="images/items/3955.gif" />&nbsp;&nbsp;<img src="images/items/2185.gif" />&nbsp;&nbsp;<img src="images/items/2143.gif" />&nbsp;&nbsp;', 'zathroth.gif'),
(0, 'Goshnar', 0, 4000, 10000, 167, 1, '"Renat Ulderek.", "Ikem King Zambo."', 'fire, outfit, drunk, invisible', 0, 0, 'blood', '<img src="images/items/2465.gif" />&nbsp;&nbsp;<img src="images/items/2478.gif" />&nbsp;&nbsp;<img src="images/items/2497.gif" />&nbsp;&nbsp;<img src="images/items/2490.gif" />&nbsp;&nbsp;<img src="images/items/2434.gif" />&nbsp;&nbsp;<img src="images/items/2667.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/2428.gif" />&nbsp;&nbsp;<img src="images/items/2463.gif" />&nbsp;&nbsp;<img src="images/items/2647.gif" />&nbsp;&nbsp;<img src="images/items/2200.gif" />&nbsp;&nbsp;<img src="images/items/2419.gif" />&nbsp;&nbsp;<img src="images/items/2165.gif" />&nbsp;&nbsp;<img src="images/items/2399.gif" />&nbsp;&nbsp;<img src="images/items/2377.gif" />&nbsp;&nbsp;', 'goshnar.gif'),
(0, 'Durin', 0, 4000, 10000, 168, 1, '"Fear my Axe!"', 'poison, outfit, drunk, invisible', 0, 1, 'blood', '<img src="images/items/2208.gif" />&nbsp;&nbsp;<img src="images/items/2417.gif" />&nbsp;&nbsp;<img src="images/items/2513.gif" />&nbsp;&nbsp;<img src="images/items/2387.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2643.gif" />&nbsp;&nbsp;<img src="images/items/2483.gif" />&nbsp;&nbsp;<img src="images/items/2150.gif" />&nbsp;&nbsp;<img src="images/items/2457.gif" />&nbsp;&nbsp;<img src="images/items/2787.gif" />&nbsp;&nbsp;', 'durin.gif'),
(0, 'Demora', 0, 400, 2000, 100, 0, '"MWIAHAIA!", "Your soul will be mine someday!"', 'energy, fire, poison, lifedrain, paralyze, outfit, drunk, invisible', 0, 0, 'fire', '<img src="images/items/2520.gif" />&nbsp;&nbsp;<img src="images/items/2462.gif" />&nbsp;&nbsp;<img src="images/items/2387.gif" />&nbsp;&nbsp;<img src="images/items/2432.gif" />&nbsp;&nbsp;<img src="images/items/2795.gif" />&nbsp;&nbsp;<img src="images/items/2393.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2179.gif" />&nbsp;&nbsp;<img src="images/items/2470.gif" />&nbsp;&nbsp;<img src="images/items/2418.gif" />&nbsp;&nbsp;<img src="images/items/2396.gif" />&nbsp;&nbsp;<img src="images/items/2472.gif" />&nbsp;&nbsp;<img src="images/items/2514.gif" />&nbsp;&nbsp;<img src="images/items/2164.gif" />&nbsp;&nbsp;<img src="images/items/2176.gif" />&nbsp;&nbsp;<img src="images/items/2171.gif" />&nbsp;&nbsp;<img src="images/items/1982.gif" />&nbsp;&nbsp;<img src="images/items/2214.gif" />&nbsp;&nbsp;<img src="images/items/2149.gif" />&nbsp;&nbsp;<img src="images/items/2165.gif" />&nbsp;&nbsp;<img src="images/items/2151.gif" />&nbsp;&nbsp;', 'demora.gif'),
(0, 'Orc Champion', 0, 505, 1010, 65, 1, '"CRARRGG GROARR!"', 'poison', 1, 1, 'blood', '<img src="images/items/2378.gif" />&nbsp;&nbsp;<img src="images/items/2464.gif" />&nbsp;&nbsp;<img src="images/items/2458.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2381.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;<img src="images/items/2044.gif" />&nbsp;&nbsp;', 'orcchampion.gif'),
(0, 'Lumenia', 0, 1350, 1500, 40, 0, '"Let''s have a fight!", "Wheres my Hero?", "OHH I NEED MY HERO...", "Welcome to my battleground!"', 'energy, fire, poison, paralyze, outfit, drunk, invisible', 0, 0, 'blood', '<img src="images/items/2544.gif" />&nbsp;&nbsp;<img src="images/items/2456.gif" />&nbsp;&nbsp;<img src="images/items/2487.gif" />&nbsp;&nbsp;<img src="images/items/2491.gif" />&nbsp;&nbsp;<img src="images/items/2488.gif" />&nbsp;&nbsp;<img src="images/items/2519.gif" />&nbsp;&nbsp;<img src="images/items/2392.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2681.gif" />&nbsp;&nbsp;<img src="images/items/2652.gif" />&nbsp;&nbsp;<img src="images/items/2071.gif" />&nbsp;&nbsp;<img src="images/items/2666.gif" />&nbsp;&nbsp;<img src="images/items/2164.gif" />&nbsp;&nbsp;<img src="images/items/2744.gif" />&nbsp;&nbsp;<img src="images/items/2120.gif" />&nbsp;&nbsp;<img src="images/items/2661.gif" />&nbsp;&nbsp;<img src="images/items/1949.gif" />&nbsp;&nbsp;<img src="images/items/2377.gif" />&nbsp;&nbsp;<img src="images/items/2391.gif" />&nbsp;&nbsp;<img src="images/items/2121.gif" />&nbsp;&nbsp;', 'lumenia.gif'),
(0, 'Dracula', 0, 2000, 5000, 40, 0, '"BLOOD!", "Let me kiss your neck.", "I smell warm blood.", "I call you, my bats! Come!"', 'poison, lifedrain, paralyze, outfit, drunk, invisible', 0, 0, 'undead', '<img src="images/items/2144.gif" />&nbsp;&nbsp;<img src="images/items/2032.gif" />&nbsp;&nbsp;<img src="images/items/2172.gif" />&nbsp;&nbsp;<img src="images/items/2127.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2747.gif" />&nbsp;&nbsp;<img src="images/items/2396.gif" />&nbsp;&nbsp;<img src="images/items/2412.gif" />&nbsp;&nbsp;<img src="images/items/2649.gif" />&nbsp;&nbsp;<img src="images/items/2229.gif" />&nbsp;&nbsp;<img src="images/items/2383.gif" />&nbsp;&nbsp;<img src="images/items/2479.gif" />&nbsp;&nbsp;<img src="images/items/2534.gif" />&nbsp;&nbsp;', 'dracula.gif'),
(0, 'Alezzo', 0, 4000, 6000, 1, 0, '"Shhhhhhhh.", "I ssssmell warm blood!"', 'poison, outfit, drunk, invisible', 0, 0, 'blood', '<img src="images/items/2654.gif" />&nbsp;&nbsp;<img src="images/items/3971.gif" />&nbsp;&nbsp;<img src="images/items/2817.gif" />&nbsp;&nbsp;<img src="images/items/2237.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2177.gif" />&nbsp;&nbsp;<img src="images/items/2168.gif" />&nbsp;&nbsp;<img src="images/items/2181.gif" />&nbsp;&nbsp;<img src="images/items/2150.gif" />&nbsp;&nbsp;<img src="images/items/2182.gif" />&nbsp;&nbsp;<img src="images/items/2154.gif" />&nbsp;&nbsp;', 'alezzo.gif'),
(0, 'Prince Almirith', 0, 2400, 5000, 20, 0, '"Im the Prince of this Forest!", "This is my forest!", "How did you get here?", "Stand still!"', 'energy, fire, poison, outfit, drunk, invisible', 0, 0, 'blood', '<img src="images/items/2544.gif" />&nbsp;&nbsp;<img src="images/items/2260.gif" />&nbsp;&nbsp;<img src="images/items/2032.gif" />&nbsp;&nbsp;<img src="images/items/2689.gif" />&nbsp;&nbsp;<img src="images/items/2047.gif" />&nbsp;&nbsp;<img src="images/items/2198.gif" />&nbsp;&nbsp;<img src="images/items/2747.gif" />&nbsp;&nbsp;<img src="images/items/2652.gif" />&nbsp;&nbsp;<img src="images/items/2600.gif" />&nbsp;&nbsp;<img src="images/items/2177.gif" />&nbsp;&nbsp;<img src="images/items/2682.gif" />&nbsp;&nbsp;<img src="images/items/2642.gif" />&nbsp;&nbsp;<img src="images/items/1949.gif" />&nbsp;&nbsp;<img src="images/items/2802.gif" />&nbsp;&nbsp;<img src="images/items/2401.gif" />&nbsp;&nbsp;<img src="images/items/2189.gif" />&nbsp;&nbsp;<img src="images/items/2154.gif" />&nbsp;&nbsp;', 'princealmirith.gif'),
(0, 'Elf Warlord', 0, 1200, 2000, 1, 0, '"Protect the Prince!!", "Intruder!"', 'outfit, drunk, invisible', 0, 1, 'blood', '<img src="images/items/2544.gif" />&nbsp;&nbsp;<img src="images/items/2456.gif" />&nbsp;&nbsp;<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2681.gif" />&nbsp;&nbsp;<img src="images/items/2397.gif" />&nbsp;&nbsp;<img src="images/items/2545.gif" />&nbsp;&nbsp;<img src="images/items/2642.gif" />&nbsp;&nbsp;<img src="images/items/2484.gif" />&nbsp;&nbsp;<img src="images/items/2482.gif" />&nbsp;&nbsp;<img src="images/items/2031.gif" />&nbsp;&nbsp;', 'elfwarlord.gif'),
(0, 'Random Noob', 390, 480000, 1950, 85, 0, '"Come here, free itenz!", "Come, look! A bug!", "I found a bug! Come and look!"', '', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2465.gif" />&nbsp;&nbsp;<img src="images/items/2461.gif" />&nbsp;&nbsp;<img src="images/items/2649.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2456.gif" />&nbsp;&nbsp;<img src="images/items/2544.gif" />&nbsp;&nbsp;<img src="images/items/2546.gif" />&nbsp;&nbsp;<img src="images/items/2147.gif" />&nbsp;&nbsp;<img src="images/items/2675.gif" />&nbsp;&nbsp;<img src="images/items/2690.gif" />&nbsp;&nbsp;<img src="images/items/2050.gif" />&nbsp;&nbsp;<img src="images/items/2478.gif" />&nbsp;&nbsp;<img src="images/items/2652.gif" />&nbsp;&nbsp;<img src="images/items/2201.gif" />&nbsp;&nbsp;', 'randomnoob.gif'),
(0, 'Magebomb', 390, 480000, 1900, 75, 0, '"Noob!", "Noob 2x!"', '', 0, 0, 'blood', '<img src="images/items/2148.gif" />&nbsp;&nbsp;<img src="images/items/2465.gif" />&nbsp;&nbsp;<img src="images/items/2461.gif" />&nbsp;&nbsp;<img src="images/items/2649.gif" />&nbsp;&nbsp;<img src="images/items/2671.gif" />&nbsp;&nbsp;<img src="images/items/3976.gif" />&nbsp;&nbsp;<img src="images/items/1987.gif" />&nbsp;&nbsp;<img src="images/items/2456.gif" />&nbsp;&nbsp;<img src="images/items/2544.gif" />&nbsp;&nbsp;<img src="images/items/2546.gif" />&nbsp;&nbsp;<img src="images/items/2147.gif" />&nbsp;&nbsp;<img src="images/items/2675.gif" />&nbsp;&nbsp;<img src="images/items/2690.gif" />&nbsp;&nbsp;<img src="images/items/2050.gif" />&nbsp;&nbsp;<img src="images/items/2478.gif" />&nbsp;&nbsp;<img src="images/items/2652.gif" />&nbsp;&nbsp;<img src="images/items/2201.gif" />&nbsp;&nbsp;', 'magebomb.gif'),
(0, 'Gerador Azul I', 0, 10000000, 1000000, 1, 0, '', 'poison, lifedrain, paralyze, outfit, drunk, invisible', 0, 0, 'undead', '', 'geradorazuli.gif'),
(0, 'Gerador Azul II', 0, 15000000, 1500000, 1, 0, '', 'poison, lifedrain, paralyze, outfit, drunk, invisible', 0, 0, 'undead', '', 'geradorazulii.gif'),
(0, 'Gerador Azul III', 0, 20000000, 2000000, 1, 0, '', 'poison, lifedrain, paralyze, outfit, drunk, invisible', 0, 0, 'undead', '', 'geradorazuliii.gif'),
(0, 'Gerador Vermelho I', 0, 10000000, 1000000, 1, 0, '', 'poison, lifedrain, paralyze, outfit, drunk, invisible', 0, 0, 'undead', '', 'geradorvermelhoi.gif'),
(0, 'Gerador Vermelho II', 0, 15000000, 1500000, 1, 0, '', 'poison, lifedrain, paralyze, outfit, drunk, invisible', 0, 0, 'undead', '', 'geradorvermelhoii.gif'),
(0, 'Gerador Vermelho III', 0, 20000000, 2000000, 1, 0, '', 'poison, lifedrain, paralyze, outfit, drunk, invisible', 0, 0, 'undead', '', 'geradorvermelhoiii.gif'),
(0, 'Protect Statue', 0, 15000, 100000, 1, 0, '', 'lifedrain, manadrain, paralyze, drunk, outfit, invisible', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;', 'protectstatue.gif'),
(0, 'Castle', 0, 25000, 400000, 1, 0, '', 'lifedrain, manadrain, paralyze, drunk, outfit, invisible', 0, 0, 'undead', '<img src="images/items/2148.gif" />&nbsp;&nbsp;', 'castle.gif'),
(0, 'Protect Castle', 0, 25000, 110000, 1, 0, '', 'energy, fire, lifedrain, manadrain, paralyze, drunk, outfit, invisible', 0, 0, 'undead', '<img src="images/items/2518.gif" />&nbsp;&nbsp;', 'protectcastle.gif');

-- --------------------------------------------------------

--
-- Estrutura da tabela `z_news_tickers`
--

CREATE TABLE IF NOT EXISTS `z_news_tickers` (
  `date` int(11) NOT NULL DEFAULT '1',
  `author` int(11) NOT NULL,
  `image_id` int(3) NOT NULL DEFAULT '0',
  `text` text NOT NULL,
  `hide_ticker` tinyint(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `z_news_tickers`
--

INSERT INTO `z_news_tickers` (`date`, `author`, `image_id`, `text`, `hide_ticker`) VALUES
(1389376651, 4627594, 4, '<a> Styller Website</a> - Melhor OTserv!', 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `z_ots_comunication`
--

CREATE TABLE IF NOT EXISTS `z_ots_comunication` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `action` varchar(255) NOT NULL,
  `param1` varchar(255) NOT NULL,
  `param2` varchar(255) NOT NULL,
  `param3` varchar(255) NOT NULL,
  `param4` varchar(255) NOT NULL,
  `param5` varchar(255) NOT NULL,
  `param6` varchar(255) NOT NULL,
  `param7` varchar(255) NOT NULL,
  `delete_it` int(2) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=28 ;

--
-- Extraindo dados da tabela `z_ots_comunication`
--

INSERT INTO `z_ots_comunication` (`id`, `name`, `type`, `action`, `param1`, `param2`, `param3`, `param4`, `param5`, `param6`, `param7`, `delete_it`) VALUES
(7, 'Cruel Killer', 'login', 'give_item', '12642', '1', '', '', 'item', 'Royal Draken Mail', '', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `z_polls`
--

CREATE TABLE IF NOT EXISTS `z_polls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question` varchar(255) NOT NULL,
  `end` int(11) NOT NULL,
  `start` int(11) NOT NULL,
  `answers` int(11) NOT NULL,
  `votes_all` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `z_polls`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `z_polls_answers`
--

CREATE TABLE IF NOT EXISTS `z_polls_answers` (
  `poll_id` int(11) NOT NULL,
  `answer_id` int(11) NOT NULL,
  `answer` varchar(255) NOT NULL,
  `votes` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `z_polls_answers`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `z_shopguild_history_item`
--

CREATE TABLE IF NOT EXISTS `z_shopguild_history_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `to_name` varchar(255) NOT NULL DEFAULT '0',
  `to_account` int(11) NOT NULL DEFAULT '0',
  `from_nick` varchar(255) NOT NULL,
  `from_account` int(11) NOT NULL DEFAULT '0',
  `price` int(11) NOT NULL DEFAULT '0',
  `offer_id` int(11) NOT NULL DEFAULT '0',
  `trans_state` varchar(255) NOT NULL,
  `trans_start` int(11) NOT NULL DEFAULT '0',
  `trans_real` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `z_shopguild_history_item`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `z_shopguild_history_pacc`
--

CREATE TABLE IF NOT EXISTS `z_shopguild_history_pacc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `to_name` varchar(255) NOT NULL DEFAULT '0',
  `to_account` int(11) NOT NULL DEFAULT '0',
  `from_nick` varchar(255) NOT NULL,
  `from_account` int(11) NOT NULL DEFAULT '0',
  `price` int(11) NOT NULL DEFAULT '0',
  `pacc_days` int(11) NOT NULL DEFAULT '0',
  `trans_state` varchar(255) NOT NULL,
  `trans_start` int(11) NOT NULL DEFAULT '0',
  `trans_real` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `z_shopguild_history_pacc`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `z_shopguild_offer`
--

CREATE TABLE IF NOT EXISTS `z_shopguild_offer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `points` int(11) NOT NULL DEFAULT '0',
  `itemid1` int(11) NOT NULL DEFAULT '0',
  `count1` int(11) NOT NULL DEFAULT '0',
  `itemid2` int(11) NOT NULL DEFAULT '0',
  `count2` int(11) NOT NULL DEFAULT '0',
  `offer_type` varchar(255) DEFAULT NULL,
  `offer_description` text NOT NULL,
  `offer_name` varchar(255) NOT NULL,
  `pid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=54 ;

--
-- Extraindo dados da tabela `z_shopguild_offer`
--

INSERT INTO `z_shopguild_offer` (`id`, `points`, `itemid1`, `count1`, `itemid2`, `count2`, `offer_type`, `offer_description`, `offer_name`, `pid`) VALUES
(3, 8, 2640, 1, 0, 0, 'item', 'You see a pair of soft boots that is brand-new.<br>\r\nIt weighs 8.00 oz.', 'Soft Boots', 0),
(2, 6, 2160, 100, 0, 0, 'item', 'Buy 100 Crystal Coins.', 'Crystal Coins', 0),
(35, 10, 0, 0, 0, 0, 'redskull', 'Remove your skull or your friend.<br>\r\n<b>(NEED STAY OFFLINE)</b>', 'Skull Remover', 0),
(49, 6, 11302, 1, 0, 0, 'item', 'You see a zaoan helmet (Arm:9, protection physical +5%).\r\nIt can only be wielded properly by paladins and knights.\r\nIt weighs 66.00 oz.', 'Zaoan Helmet', 0),
(53, 6, 11356, 1, 0, 0, 'item', 'You see a zaoan robe (Arm:11, protection fire +10%, ice -10%).\r\nIt can only be wielded properly by sorcerers and druids of level 60 or higher.\r\nIt weighs 24.50 oz.', 'Zaoan Robe', 0),
(47, 6, 11301, 1, 0, 0, 'item', 'You see a zaoan armor (Arm:13, speed +10).\r\nIt can only be wielded properly by paladins and knights of level 50 or higher.\r\nIt weighs 95.50 oz.', 'Zaoan Armor', 0),
(48, 6, 11304, 1, 0, 0, 'item', 'You see a zaoan legs (Arm:8, protection physical +2%).\r\nIt weighs 66.00 oz.', 'Zaoan Legs', 0),
(50, 7, 11303, 1, 0, 0, 'item', 'You see a zaoan shoes (Arm:1, speed +5).\r\nIt weighs 7.00 oz.', 'Zaoan Shoes', 0),
(51, 5, 11323, 1, 0, 0, 'item', 'You see a zaoan halberd (Atk:37, Def:15).\r\nIt can only be wielded properly by players of level 25 or higher.\r\nIt weighs 87.00 oz.', 'Zaoan Halberd', 0),
(52, 5, 11307, 1, 0, 0, 'item', 'You see a zaoan sword (Atk:43, Def:18 +2).\r\nIt can only be wielded properly by players of level 55 or higher.\r\nIt weighs 49.00 oz.', 'Zaoan Sword', 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `z_shop_history_item`
--

CREATE TABLE IF NOT EXISTS `z_shop_history_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `to_name` varchar(255) NOT NULL DEFAULT '0',
  `to_account` int(11) NOT NULL DEFAULT '0',
  `from_nick` varchar(255) NOT NULL,
  `from_account` int(11) NOT NULL DEFAULT '0',
  `price` int(11) NOT NULL DEFAULT '0',
  `offer_id` int(11) NOT NULL DEFAULT '0',
  `trans_state` varchar(255) NOT NULL,
  `trans_start` int(11) NOT NULL DEFAULT '0',
  `trans_real` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `z_shop_history_item`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `z_shop_history_pacc`
--

CREATE TABLE IF NOT EXISTS `z_shop_history_pacc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `to_name` varchar(255) NOT NULL DEFAULT '0',
  `to_account` int(11) NOT NULL DEFAULT '0',
  `from_nick` varchar(255) NOT NULL,
  `from_account` int(11) NOT NULL DEFAULT '0',
  `price` int(11) NOT NULL DEFAULT '0',
  `pacc_days` int(11) NOT NULL DEFAULT '0',
  `trans_state` varchar(255) NOT NULL,
  `trans_start` int(11) NOT NULL DEFAULT '0',
  `trans_real` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Extraindo dados da tabela `z_shop_history_pacc`
--


-- --------------------------------------------------------

--
-- Estrutura da tabela `z_shop_offer`
--

CREATE TABLE IF NOT EXISTS `z_shop_offer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `points` int(11) NOT NULL DEFAULT '0',
  `itemid1` int(11) NOT NULL DEFAULT '0',
  `count1` int(11) NOT NULL DEFAULT '0',
  `itemid2` int(11) NOT NULL DEFAULT '0',
  `count2` int(11) NOT NULL DEFAULT '0',
  `offer_type` varchar(255) DEFAULT NULL,
  `offer_description` text NOT NULL,
  `offer_name` varchar(255) NOT NULL,
  `pid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=54 ;

--
-- Extraindo dados da tabela `z_shop_offer`
--

INSERT INTO `z_shop_offer` (`id`, `points`, `itemid1`, `count1`, `itemid2`, `count2`, `offer_type`, `offer_description`, `offer_name`, `pid`) VALUES
(31, 10, 7423, 1, 0, 0, 'itemvip', 'You see a vip club (Atk:57, Def:40 +3).<br>\r\nIt can only be wielded properly by knights of level 85 or higher.<br>\r\nIt weighs 120.00 oz.', 'VIP Club', 0),
(30, 10, 8931, 1, 0, 0, 'itemvip', 'You see a vip sword (Atk:58, Def:39 +2).<br>\r\nIt can only be wielded properly by players of level 140 or higher.<br>\r\nIt weighs 67.00 oz.', 'VIP Sword', 0),
(29, 10, 7455, 1, 0, 0, 'itemvip', 'You see a vip axe (Atk:59, Def:38 +1).<br>\r\nIt can only be wielded properly by players of level 80 or higher.<br>\r\nIt weighs 55.00 oz.', 'VIP Axe', 0),
(27, 10, 2184, 1, 0, 0, 'itemvip', 'The best attack for druids!', 'VIP Rod', 0),
(28, 10, 7735, 1, 0, 0, 'itemvip', 'The best attack for sorceres!', 'VIP Wand', 0),
(25, 5, 8474, 1, 0, 0, 'itemvip', 'Regenerate your stamina to full.', 'Stamina Refuel', 0),
(26, 9, 2474, 1, 0, 0, 'itemvip', 'You see a vip helmet (Arm:11, speed +7).<br>\r\nIt weighs 12.00 oz.<br>\r\nProtection 10% of fire, poision, energy and more speed.', 'VIP Helmet', 0),
(19, 2, 2798, 30, 0, 0, 'item', '30 blood herbs.<br>\r\nFor your house!', 'Blood Herbs', 0),
(23, 6, 9693, 1, 0, 0, 'itemvip', 'This item give a full addon for you.<br>\r\nUse <b>!addon addonname</b>', 'Addon Doll', 0),
(18, 4, 8888, 1, 0, 0, 'item', 'You see a master archer''s armor (Arm:15, distance fighting +3).<br>\r\nIt can only be wielded properly by paladins of level 100 or higher.<br>\r\nIt weighs 69.00 oz.', 'Master Archer''s Armor', 0),
(17, 6, 8927, 1, 0, 0, 'item', 'You see a dark trinity mace (Atk:51, Def:32 -1).<br>\r\nIt can only be wielded properly by players of level 120 or higher.<br>\r\nIt weighs 99.00 oz.', 'Dark Trinity Mace', 0),
(16, 6, 8925, 1, 0, 0, 'item', 'You see a solar axe (Atk:52, Def:29 +3).<br>\r\nIt can only be wielded properly by players of level 130 or higher.<br>\r\nIt weighs 110.00 oz', 'Solar Axe', 0),
(14, 4, 8881, 1, 0, 0, 'item', 'You see a fireborn giant armor (Arm:15, sword fighting +2, protection fire +5%, ice -5%).<br>\r\nIt can only be wielded properly by knights of level 100 or higher.<br>\r\nIt weighs 120.00 oz.', 'Fireborn Giant Armor', 0),
(13, 4, 8883, 1, 0, 0, 'item', 'You see a windborn colossus armor (Arm:15, club fighting +2, protection energy +5%, earth -5%).<br>\r\nIt can only be wielded properly by knights of level 100 or higher.<br>\r\nIt weighs 120.00 oz.', 'Windborn Colossus Armor', 0),
(12, 5, 8882, 1, 0, 0, 'item', 'You see an earthborn titan armor (Arm:15, axe fighting +2, protection earth +5%, fire -5%).<br>\r\nIt can only be wielded properly by knights of level 100 or higher.<br>\r\nIt weighs 120.00 oz.', 'Earthborn Titan Armor', 0),
(10, 3, 2504, 1, 0, 0, 'item', 'You see dwarven legs (Arm:7, protection physical +3%).<br>\r\nIt weighs 49.00 oz.', 'Dwarven Legs', 0),
(15, 6, 8930, 1, 0, 0, 'item', 'You see an emerald sword (Atk:49, Def:33 +3).<br>\r\nIt can only be wielded properly by players of level 100 or higher.<br>\r\nIt weighs 41.00 oz.', 'Emerald Sword', 0),
(9, 3, 12645, 1, 0, 0, 'item', 'You see an elite draken helmet (Arm:9, distance fighting +1, protection death +3%).<br>\r\nIt can only be wielded properly by paladins of level 100 or higher.<br>\r\nIt weighs 43.00 oz.', 'Elite Draken Helmet', 0),
(8, 5, 8918, 1, 0, 0, 'item', 'You see a spellbook of dark mysteries (Def:16, magic level +3).<br>\r\nIt can only be wielded properly by sorcerers and druids of level 80 or higher.<br>\r\nIt weighs 28.50 oz.<br>\r\nIt shows your spells and can also shield against attacks when worn.', 'Spellbook of Dark Mysteries', 0),
(7, 4, 12643, 1, 0, 0, 'item', 'You see a royal scale robe (Arm:12, magic level +2, protection fire +5%).<br>\r\nIt can only be wielded properly by sorcerers and druids of level 100 or higher.<br>\r\nIt weighs 45.00 oz.', 'Royal Scale Robe', 0),
(6, 4, 12642, 1, 0, 0, 'item', 'You see a royal draken mail (Arm:16, shielding +3, protection physical +5%).<br>\r\nIt can only be wielded properly by knights of level 100 or higher.<br>\r\nIt weighs 130.00 oz.', 'Royal Draken Mail', 0),
(5, 2, 2471, 1, 0, 0, 'item', 'You see a golden helmet (Arm:12).<br>\r\nIt weighs 32.00 oz.<br>\r\nIt''s the famous Helmet of the Stars.', 'Golden Helmet', 0),
(4, 2, 2646, 1, 0, 0, 'item', 'You see golden boots (Arm:4).<br>\r\nIt weighs 31.00 oz.', 'Golden Boots', 0),
(3, 3, 2495, 1, 0, 0, 'item', 'You see demon legs (Arm:9).<br>\r\nIt weighs 70.00 oz.', 'Demon Legs', 0),
(2, 3, 2472, 1, 0, 0, 'item', 'You see a magic plate armor (Arm:17).<br>\r\nIt can only be wielded properly by knights and paladins.<br>\r\nIt weighs 85.00 oz.', 'Magic Plate Armor', 0),
(1, 4, 2160, 100, 0, 0, 'item', 'Buy 100 Crystal Coins.', 'Crystal Coins', 0),
(32, 12, 2358, 1, 0, 0, 'itemvip', 'The best HP/mana regenerator and more speed!<br>\r\n<i>Este item é infinito.</i>', 'VIP Boots', 0),
(33, 12, 0, 0, 0, 0, 'changename', 'Change name of your character.<br>\r\n<b>(NEED STAY OFFLINE)</b>', 'Change Name', 0),
(35, 10, 0, 0, 0, 0, 'redskull', 'Remove your skull or your friend.<br>\r\n<b>(NEED STAY OFFLINE)</b>', 'Skull Remover', 0),
(36, 10, 0, 0, 0, 0, 'unban', 'Remove your account banned or your friend.', 'Unban', 0),
(37, 4, 2640, 1, 0, 0, 'item', 'You see a pair of soft boots that is brand-new.<br>\r\nIt weighs 8.00 oz.', 'Soft Boots', 0),
(45, 13, 0, 30, 0, 0, 'vipdays', 'Buy 15 Days of VIP Account.', '30 Days of VIP', 0),
(44, 8, 0, 15, 0, 0, 'vipdays', 'Buy 15 Days of VIP Account.', '15 Days of VIP', 0),
(46, 10, 2352, 1, 0, 0, 'itemvip', 'The best attack for Paladins! (use with Crossbow)<br>\r\n<i>Este item é infinito.</i>', 'VIP Bolt', 0),
(43, 6, 0, 7, 0, 0, 'vipdays', 'Buy 7 Days of VIP Account.', '7 Days of VIP', 0),
(51, 4, 11323, 1, 0, 0, 'item', 'You see a zaoan halberd (Atk:37, Def:15).\r\nIt can only be wielded properly by players of level 25 or higher.\r\nIt weighs 87.00 oz.', 'Zaoan Halberd', 0),
(48, 4, 11304, 1, 0, 0, 'item', 'You see a zaoan legs (Arm:8, protection physical +2%).\r\nIt weighs 66.00 oz.', 'Zaoan Legs', 0),
(50, 2, 11303, 1, 0, 0, 'item', 'You see a zaoan shoes (Arm:1, speed +5).\r\nIt weighs 7.00 oz.', 'Zaoan Shoes', 0),
(47, 3, 11301, 1, 0, 0, 'item', 'You see a zaoan armor (Arm:13, speed +10).\r\nIt can only be wielded properly by paladins and knights of level 50 or higher.\r\nIt weighs 95.50 oz.', 'Zaoan Armor', 0),
(53, 3, 11356, 1, 0, 0, 'item', 'You see a zaoan robe (Arm:11, protection fire +10%, ice -10%).\r\nIt can only be wielded properly by sorcerers and druids of level 60 or higher.\r\nIt weighs 24.50 oz.', 'Zaoan Robe', 0),
(49, 2, 11302, 1, 0, 0, 'item', 'You see a zaoan helmet (Arm:9, protection physical +5%).\r\nIt can only be wielded properly by paladins and knights.\r\nIt weighs 66.00 oz.', 'Zaoan Helmet', 0),
(52, 4, 11307, 1, 0, 0, 'item', 'You see a zaoan sword (Atk:43, Def:18 +2).\r\nIt can only be wielded properly by players of level 55 or higher.\r\nIt weighs 49.00 oz.', 'Zaoan Sword', 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `z_spells`
--

CREATE TABLE IF NOT EXISTS `z_spells` (
  `name` varchar(255) NOT NULL,
  `spell` varchar(255) NOT NULL,
  `spell_type` varchar(255) NOT NULL,
  `mana` int(11) NOT NULL DEFAULT '0',
  `lvl` int(11) NOT NULL DEFAULT '0',
  `mlvl` int(11) NOT NULL DEFAULT '0',
  `soul` int(11) NOT NULL DEFAULT '0',
  `pacc` varchar(255) NOT NULL,
  `vocations` varchar(255) NOT NULL,
  `conj_count` int(11) NOT NULL DEFAULT '0',
  `hide_spell` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `z_spells`
--

INSERT INTO `z_spells` (`name`, `spell`, `spell_type`, `mana`, `lvl`, `mlvl`, `soul`, `pacc`, `vocations`, `conj_count`, `hide_spell`) VALUES
('Conjure Arrow', 'exevo con', 'conjure', 100, 13, 0, 1, 'no', '', 10, 0),
('Poisoned Arrow', 'exevo con pox', 'conjure', 130, 16, 0, 2, 'no', '', 7, 0),
('Conjure Bolt', 'exevo con mort', 'conjure', 140, 17, 0, 2, 'yes', '', 5, 0),
('Conjure Sniper Arrow', 'exevo con hur', 'conjure', 160, 24, 0, 3, 'yes', '', 5, 0),
('Explosive Arrow', 'exevo con flam', 'conjure', 290, 25, 0, 3, 'no', '', 8, 0),
('Conjure Piercing Bolt', 'exevo con grav', 'conjure', 180, 33, 0, 3, 'yes', '', 5, 0),
('Enchant Staff', 'exeta vis', 'conjure', 80, 41, 0, 0, 'yes', '', 0, 0),
('Enchant Spear', 'exeta con', 'conjure', 350, 45, 0, 3, 'yes', '', 0, 0),
('Power Bolt', 'exevo con vis', 'conjure', 800, 59, 0, 4, 'yes', '', 10, 0),
('Conjure Assassin', 'exevo con san', 'conjure', 500, 80, 0, 0, 'no', '1;3', 15, 0),
('Conjure Blank', 'adori blank', 'conjure', 200, 20, 0, 0, 'no', '', 1, 0),
('Poison Field', 'adevo grav pox', 'conjure', 200, 14, 0, 1, 'no', '', 3, 0),
('Light Magic Missile', 'adori min vis', 'conjure', 120, 15, 0, 1, 'no', '', 10, 0),
('Fire Field', 'adevo grav flam', 'conjure', 240, 15, 0, 1, 'no', '', 3, 0),
('Fireball', 'adori flam', 'conjure', 460, 27, 0, 3, 'yes', '', 5, 0),
('Energy Field', 'adevo grav vis', 'conjure', 320, 18, 0, 2, 'no', '', 3, 0),
('Stalagmite', 'adori tera', 'conjure', 400, 24, 0, 2, 'no', '', 10, 0),
('Great Fireball', 'adori mas flam', 'conjure', 530, 30, 0, 3, 'no', '', 4, 0),
('Heavy Magic Missile', 'adori vis', 'conjure', 350, 25, 0, 2, 'no', '', 10, 0),
('Poison Bomb', 'adevo mas pox', 'conjure', 520, 25, 0, 2, 'yes', '', 2, 0),
('Firebomb', 'adevo mas flam', 'conjure', 600, 27, 0, 4, 'no', '', 2, 0),
('Soulfire', 'adevo res flam', 'conjure', 600, 27, 0, 3, 'yes', '', 3, 0),
('Poison Wall', 'adevo mas grav pox', 'conjure', 640, 29, 0, 3, 'no', '', 4, 0),
('Explosion', 'adevo mas hur', 'conjure', 570, 31, 0, 4, 'no', '', 6, 0),
('Fire Wall', 'adevo mas grav flam', 'conjure', 780, 33, 0, 4, 'no', '', 4, 0),
('Energybomb', 'adevo mas vis', 'conjure', 880, 37, 0, 5, 'yes', '', 2, 0),
('Energy Wall', 'adevo mas grav vis', 'conjure', 1000, 41, 0, 5, 'no', '', 4, 0),
('Sudden Death', 'adori gran mort', 'conjure', 985, 45, 0, 5, 'no', '', 3, 0),
('Antidote Rune', 'adana pox', 'conjure', 200, 15, 0, 1, 'no', '', 1, 0),
('Intense Healing Rune', 'adura gran', 'conjure', 240, 15, 0, 2, 'no', '', 1, 0),
('Ultimate Healing Rune', 'adura vita', 'conjure', 400, 24, 0, 3, 'no', '', 1, 0),
('Convince Creature', 'adeta sio', 'conjure', 200, 16, 0, 3, 'no', '', 1, 0),
('Animate Dead', 'adana mort', 'conjure', 600, 27, 0, 5, 'yes', '', 1, 0),
('Chameleon', 'adevo ina', 'conjure', 600, 27, 0, 2, 'no', '', 1, 0),
('Destroy Field', 'adito grav', 'conjure', 120, 17, 0, 2, 'no', '', 3, 0),
('Desintegrate', 'adito tera', 'conjure', 200, 21, 0, 3, 'yes', '', 3, 0),
('Magic Wall', 'adevo grav tera', 'conjure', 750, 32, 0, 5, 'yes', '', 3, 0),
('Wild Growth', 'adevo grav vita', 'conjure', 600, 27, 0, 5, 'yes', '', 2, 0),
('Paralyze', 'adana ani', 'conjure', 1400, 54, 0, 3, 'yes', '', 1, 0),
('Icicle', 'adori frigo', 'conjure', 460, 28, 0, 3, 'yes', '', 5, 0),
('Avalanche', 'adori mas frigo', 'conjure', 530, 30, 0, 3, 'no', '', 4, 0),
('Stone Shower', 'adori mas tera', 'conjure', 430, 28, 0, 3, 'yes', '', 4, 0),
('Thunderstorm', 'adori mas vis', 'conjure', 430, 28, 0, 3, 'yes', '', 4, 0),
('Holy Missile', 'adori san', 'conjure', 350, 27, 0, 3, 'yes', '', 5, 0),
('Death Strike', 'exori mort', 'instant', 20, 16, 0, 0, 'yes', '', 0, 0),
('Flame Strike', 'exori flam', 'instant', 20, 12, 0, 0, 'yes', '', 0, 0),
('Energy Strike', 'exori vis', 'instant', 20, 12, 0, 0, 'yes', '', 0, 0),
('Whirlwind Throw', 'exori hur', 'instant', 40, 15, 0, 0, 'yes', '', 0, 0),
('Fire Wave', 'exevo flam hur', 'instant', 25, 18, 0, 0, 'no', '', 0, 0),
('Ethereal Spear', 'exori con', 'instant', 25, 23, 0, 0, 'yes', '', 0, 0),
('Energy Beam', 'exevo vis lux', 'instant', 40, 23, 0, 0, 'no', '', 0, 0),
('Great Energy Beam', 'exevo gran vis lux', 'instant', 110, 29, 0, 0, 'no', '', 0, 0),
('Groundshaker', 'exori mas', 'instant', 160, 33, 0, 0, 'yes', '', 0, 0),
('Berserk', 'exori', 'instant', 115, 35, 0, 0, 'yes', '', 0, 0),
('Energy Wave', 'exevo vis hur', 'instant', 170, 38, 0, 0, 'no', '', 0, 0),
('Rage of the Skies', 'exevo gran mas vis', 'instant', 650, 55, 0, 0, 'yes', '', 0, 0),
('Fierce Berserk', 'exori gran', 'instant', 340, 70, 0, 0, 'yes', '', 0, 0),
('Hells Core', 'exevo gran mas flam', 'instant', 1200, 60, 0, 0, 'yes', '', 0, 0),
('Divine Missile', 'exori san', 'instant', 20, 40, 0, 0, 'yes', '', 0, 0),
('Divine Caldera', 'exevo mas san', 'instant', 160, 50, 0, 0, 'yes', '', 0, 0),
('Eternal Winter', 'exevo gran mas frigo', 'instant', 1200, 60, 0, 0, 'yes', '', 0, 0),
('Ice Strike', 'exori frigo', 'instant', 20, 15, 0, 0, 'yes', '', 0, 0),
('Ice Wave', 'exevo frigo hur', 'instant', 25, 18, 0, 0, 'no', '', 0, 0),
('Terra Strike', 'exori tera', 'instant', 20, 13, 0, 0, 'yes', '', 0, 0),
('Terra Wave', 'exevo tera hur', 'instant', 210, 38, 0, 0, 'no', '', 0, 0),
('Wrath of Nature', 'exevo gran mas tera', 'instant', 770, 55, 0, 0, 'yes', '', 0, 0),
('Light Healing', 'exura', 'instant', 20, 9, 0, 0, 'no', '', 0, 0),
('Antidote', 'exana pox', 'instant', 30, 10, 0, 0, 'no', '', 0, 0),
('Antiflame', 'exana flam', 'instant', 35, 15, 0, 0, 'no', '', 0, 0),
('Intense Healing', 'exura gran', 'instant', 70, 11, 0, 0, 'no', '', 0, 0),
('Heal Friend', 'exura sio', 'instant', 140, 18, 0, 0, 'yes', '', 0, 0),
('Ultimate Healing', 'exura vita', 'instant', 160, 20, 0, 0, 'no', '', 0, 0),
('Mass Healing', 'exura gran mas res', 'instant', 150, 36, 0, 0, 'yes', '', 0, 0),
('Divine Healing', 'exura san', 'instant', 210, 35, 0, 0, 'yes', '', 0, 0),
('Wound Cleansing', 'exana mort', 'instant', 65, 30, 0, 0, 'yes', '', 0, 0),
('Light', 'utevo lux', 'instant', 20, 8, 0, 0, 'no', '', 0, 0),
('Find Person', 'exiva', 'instant', 20, 8, 0, 0, 'no', '', 0, 0),
('Magic Rope', 'exani tera', 'instant', 20, 9, 0, 0, 'yes', '', 0, 0),
('Levitate', 'exani hur', 'instant', 50, 12, 0, 0, 'yes', '', 0, 0),
('Great Light', 'utevo gran lux', 'instant', 60, 13, 0, 0, 'no', '', 0, 0),
('Magic Shield', 'utamo vita', 'instant', 50, 14, 0, 0, 'no', '', 0, 0),
('Haste', 'utani hur', 'instant', 60, 14, 0, 0, 'yes', '', 0, 0),
('Charge', 'utani tempo hur', 'instant', 100, 25, 0, 0, 'yes', '', 0, 0),
('Swift Foot', 'utamo tempo san', 'instant', 400, 55, 0, 0, 'yes', '', 0, 0),
('Challenge', 'exeta res', 'instant', 30, 20, 0, 0, 'yes', '', 0, 0),
('Strong Haste', 'utani gran hur', 'instant', 100, 20, 0, 0, 'yes', '', 0, 0),
('Creature Illusion', 'utevo res ina', 'instant', 100, 23, 0, 0, 'no', '', 0, 0),
('Ultimate Light', 'utevo vis lux', 'instant', 140, 26, 0, 0, 'yes', '', 0, 0),
('Cancel Invisibility', 'exana ina', 'instant', 200, 26, 0, 0, 'yes', '', 0, 0),
('Invisibility', 'utana vid', 'instant', 440, 35, 0, 0, 'no', '', 0, 0),
('Sharpshooter', 'utito tempo san', 'instant', 450, 60, 0, 0, 'yes', '', 0, 0),
('Protector', 'utamo tempo', 'instant', 200, 55, 0, 0, 'yes', '', 0, 0),
('Blood Rage', 'utito tempo', 'instant', 290, 60, 0, 0, 'yes', '', 0, 0),
('Train Party', 'utito mas sio', 'instant', 60, 32, 0, 0, 'yes', '', 0, 0),
('Protect Party', 'utamo mas sio', 'instant', 90, 32, 0, 0, 'yes', '', 0, 0),
('Heal Party', 'utura mas sio', 'instant', 120, 32, 0, 0, 'yes', '', 0, 0),
('Enchant Party', 'utori mas sio', 'instant', 120, 32, 0, 0, 'yes', '', 0, 0),
('Summon Creature', 'utevo res', 'instant', 0, 25, 0, 0, 'no', '', 0, 0),
('Food', 'exevo pan', 'instant', 120, 14, 0, 1, 'no', '', 0, 0),
('Annihilation', 'exori gran ico', 'instant', 300, 110, 0, 0, 'yes', '', 0, 0),
('Brutal Strike', 'exori ico', 'instant', 30, 16, 0, 0, 'yes', '', 0, 0),
('Curser', 'utori mort', 'instant', 30, 75, 0, 0, 'yes', '', 0, 0),
('Electrify', 'utori vis', 'instant', 30, 34, 0, 0, 'yes', '', 0, 0),
('Envenom', 'utori pox', 'instant', 30, 40, 0, 0, 'yes', '', 0, 0),
('Front Sweep', 'exori min', 'instant', 200, 70, 0, 0, 'yes', '', 0, 0),
('Ignite', 'utori flam', 'instant', 30, 26, 0, 0, 'yes', '', 0, 0),
('Inflict Wound', 'utori kor', 'instant', 30, 40, 0, 0, 'yes', '', 0, 0),
('Lightning', 'exori amp vis', 'instant', 160, 55, 0, 0, 'yes', '', 0, 0),
('Physical Strike', 'exori moe ico', 'instant', 20, 16, 0, 0, 'yes', '', 0, 0),
('Strong Ethereal Spear', 'exori gran con', 'instant', 55, 90, 0, 0, 'yes', '', 0, 0),
('Intense Recovery', 'utura gran', 'instant', 165, 100, 0, 0, 'yes', '', 0, 0),
('Intense Wound Cleansing', 'exura gran ico', 'instant', 200, 80, 0, 0, 'yes', '', 0, 0),
('Recovery', 'utura', 'instant', 75, 50, 0, 0, 'yes', '', 0, 0),
('Salvation', 'exura gran san', 'instant', 210, 60, 0, 0, 'yes', '', 0, 0),
('Holy Flash', 'utori san', 'instant', 50, 70, 0, 0, 'yes', '', 0, 0);

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
  ADD CONSTRAINT `guild_kills_ibfk_1` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `guild_kills_ibfk_2` FOREIGN KEY (`war_id`) REFERENCES `guild_wars` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `guild_kills_ibfk_3` FOREIGN KEY (`death_id`) REFERENCES `player_deaths` (`id`) ON DELETE CASCADE;

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
-- Restrições para a tabela `login_history`
--
ALTER TABLE `login_history`
  ADD CONSTRAINT `login_history_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`);

--
-- Restrições para a tabela `market_history`
--
ALTER TABLE `market_history`
  ADD CONSTRAINT `market_history_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para a tabela `market_offers`
--
ALTER TABLE `market_offers`
  ADD CONSTRAINT `market_offers_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

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
-- Restrições para a tabela `player_inboxitems`
--
ALTER TABLE `player_inboxitems`
  ADD CONSTRAINT `player_inboxitems_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

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
-- Restrições para a tabela `player_statements`
--
ALTER TABLE `player_statements`
  ADD CONSTRAINT `player_statements_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

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
