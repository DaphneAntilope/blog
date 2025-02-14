-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : ven. 14 fév. 2025 à 12:32
-- Version du serveur : 8.3.0
-- Version de PHP : 8.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `forum_flarum`
--
CREATE DATABASE IF NOT EXISTS `forum_flarum` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `forum_flarum`;

-- --------------------------------------------------------

--
-- Structure de la table `foaccess_tokens`
--

DROP TABLE IF EXISTS `foaccess_tokens`;
CREATE TABLE IF NOT EXISTS `foaccess_tokens` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `token` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `last_activity_at` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_user_agent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `foaccess_tokens_token_unique` (`token`),
  KEY `foaccess_tokens_user_id_foreign` (`user_id`),
  KEY `foaccess_tokens_type_index` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `foapi_keys`
--

DROP TABLE IF EXISTS `foapi_keys`;
CREATE TABLE IF NOT EXISTS `foapi_keys` (
  `key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `allowed_ips` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `last_activity_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `foapi_keys_key_unique` (`key`),
  KEY `foapi_keys_user_id_foreign` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `fodiscussions`
--

DROP TABLE IF EXISTS `fodiscussions`;
CREATE TABLE IF NOT EXISTS `fodiscussions` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment_count` int NOT NULL DEFAULT '1',
  `participant_count` int UNSIGNED NOT NULL DEFAULT '0',
  `post_number_index` int UNSIGNED NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `user_id` int UNSIGNED DEFAULT NULL,
  `first_post_id` int UNSIGNED DEFAULT NULL,
  `last_posted_at` datetime DEFAULT NULL,
  `last_posted_user_id` int UNSIGNED DEFAULT NULL,
  `last_post_id` int UNSIGNED DEFAULT NULL,
  `last_post_number` int UNSIGNED DEFAULT NULL,
  `hidden_at` datetime DEFAULT NULL,
  `hidden_user_id` int UNSIGNED DEFAULT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_private` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fodiscussions_hidden_user_id_foreign` (`hidden_user_id`),
  KEY `fodiscussions_first_post_id_foreign` (`first_post_id`),
  KEY `fodiscussions_last_post_id_foreign` (`last_post_id`),
  KEY `fodiscussions_last_posted_at_index` (`last_posted_at`),
  KEY `fodiscussions_last_posted_user_id_index` (`last_posted_user_id`),
  KEY `fodiscussions_created_at_index` (`created_at`),
  KEY `fodiscussions_user_id_index` (`user_id`),
  KEY `fodiscussions_comment_count_index` (`comment_count`),
  KEY `fodiscussions_participant_count_index` (`participant_count`),
  KEY `fodiscussions_hidden_at_index` (`hidden_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `fodiscussion_user`
--

DROP TABLE IF EXISTS `fodiscussion_user`;
CREATE TABLE IF NOT EXISTS `fodiscussion_user` (
  `user_id` int UNSIGNED NOT NULL,
  `discussion_id` int UNSIGNED NOT NULL,
  `last_read_at` datetime DEFAULT NULL,
  `last_read_post_number` int UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`user_id`,`discussion_id`),
  KEY `fodiscussion_user_discussion_id_foreign` (`discussion_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `foemail_tokens`
--

DROP TABLE IF EXISTS `foemail_tokens`;
CREATE TABLE IF NOT EXISTS `foemail_tokens` (
  `token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`token`),
  KEY `foemail_tokens_user_id_foreign` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `fogroups`
--

DROP TABLE IF EXISTS `fogroups`;
CREATE TABLE IF NOT EXISTS `fogroups` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `name_singular` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_plural` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `color` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_hidden` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `fogroups`
--

INSERT INTO `fogroups` (`id`, `name_singular`, `name_plural`, `color`, `icon`, `is_hidden`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 'Admins', '#B72A2A', 'fas fa-wrench', 0, NULL, NULL),
(2, 'Guest', 'Guests', NULL, NULL, 0, NULL, NULL),
(3, 'Member', 'Members', NULL, NULL, 0, NULL, NULL),
(4, 'Mod', 'Mods', '#80349E', 'fas fa-bolt', 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `fogroup_permission`
--

DROP TABLE IF EXISTS `fogroup_permission`;
CREATE TABLE IF NOT EXISTS `fogroup_permission` (
  `group_id` int UNSIGNED NOT NULL,
  `permission` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`group_id`,`permission`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `fogroup_permission`
--

INSERT INTO `fogroup_permission` (`group_id`, `permission`) VALUES
(2, 'viewForum'),
(3, 'discussion.reply'),
(3, 'searchUsers'),
(3, 'startDiscussion'),
(4, 'discussion.editPosts'),
(4, 'discussion.hide'),
(4, 'discussion.hidePosts'),
(4, 'discussion.rename'),
(4, 'discussion.viewIpsPosts'),
(4, 'user.viewLastSeenAt');

-- --------------------------------------------------------

--
-- Structure de la table `fogroup_user`
--

DROP TABLE IF EXISTS `fogroup_user`;
CREATE TABLE IF NOT EXISTS `fogroup_user` (
  `user_id` int UNSIGNED NOT NULL,
  `group_id` int UNSIGNED NOT NULL,
  PRIMARY KEY (`user_id`,`group_id`),
  KEY `fogroup_user_group_id_foreign` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `fologin_providers`
--

DROP TABLE IF EXISTS `fologin_providers`;
CREATE TABLE IF NOT EXISTS `fologin_providers` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `provider` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `identifier` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `last_login_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `fologin_providers_provider_identifier_unique` (`provider`,`identifier`),
  KEY `fologin_providers_user_id_foreign` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `fomigrations`
--

DROP TABLE IF EXISTS `fomigrations`;
CREATE TABLE IF NOT EXISTS `fomigrations` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `extension` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `fomigrations`
--

INSERT INTO `fomigrations` (`id`, `migration`, `extension`) VALUES
(1, '2015_02_24_000000_create_access_tokens_table', NULL),
(2, '2015_02_24_000000_create_api_keys_table', NULL),
(3, '2015_02_24_000000_create_config_table', NULL),
(4, '2015_02_24_000000_create_discussions_table', NULL),
(5, '2015_02_24_000000_create_email_tokens_table', NULL),
(6, '2015_02_24_000000_create_groups_table', NULL),
(7, '2015_02_24_000000_create_notifications_table', NULL),
(8, '2015_02_24_000000_create_password_tokens_table', NULL),
(9, '2015_02_24_000000_create_permissions_table', NULL),
(10, '2015_02_24_000000_create_posts_table', NULL),
(11, '2015_02_24_000000_create_users_discussions_table', NULL),
(12, '2015_02_24_000000_create_users_groups_table', NULL),
(13, '2015_02_24_000000_create_users_table', NULL),
(14, '2015_09_15_000000_create_auth_tokens_table', NULL),
(15, '2015_09_20_224327_add_hide_to_discussions', NULL),
(16, '2015_09_22_030432_rename_notification_read_time', NULL),
(17, '2015_10_07_130531_rename_config_to_settings', NULL),
(18, '2015_10_24_194000_add_ip_address_to_posts', NULL),
(19, '2015_12_05_042721_change_access_tokens_columns', NULL),
(20, '2015_12_17_194247_change_settings_value_column_to_text', NULL),
(21, '2016_02_04_095452_add_slug_to_discussions', NULL),
(22, '2017_04_07_114138_add_is_private_to_discussions', NULL),
(23, '2017_04_07_114138_add_is_private_to_posts', NULL),
(24, '2018_01_11_093900_change_access_tokens_columns', NULL),
(25, '2018_01_11_094000_change_access_tokens_add_foreign_keys', NULL),
(26, '2018_01_11_095000_change_api_keys_columns', NULL),
(27, '2018_01_11_101800_rename_auth_tokens_to_registration_tokens', NULL),
(28, '2018_01_11_102000_change_registration_tokens_rename_id_to_token', NULL),
(29, '2018_01_11_102100_change_registration_tokens_created_at_to_datetime', NULL),
(30, '2018_01_11_120604_change_posts_table_to_innodb', NULL),
(31, '2018_01_11_155200_change_discussions_rename_columns', NULL),
(32, '2018_01_11_155300_change_discussions_add_foreign_keys', NULL),
(33, '2018_01_15_071700_rename_users_discussions_to_discussion_user', NULL),
(34, '2018_01_15_071800_change_discussion_user_rename_columns', NULL),
(35, '2018_01_15_071900_change_discussion_user_add_foreign_keys', NULL),
(36, '2018_01_15_072600_change_email_tokens_rename_id_to_token', NULL),
(37, '2018_01_15_072700_change_email_tokens_add_foreign_keys', NULL),
(38, '2018_01_15_072800_change_email_tokens_created_at_to_datetime', NULL),
(39, '2018_01_18_130400_rename_permissions_to_group_permission', NULL),
(40, '2018_01_18_130500_change_group_permission_add_foreign_keys', NULL),
(41, '2018_01_18_130600_rename_users_groups_to_group_user', NULL),
(42, '2018_01_18_130700_change_group_user_add_foreign_keys', NULL),
(43, '2018_01_18_133000_change_notifications_columns', NULL),
(44, '2018_01_18_133100_change_notifications_add_foreign_keys', NULL),
(45, '2018_01_18_134400_change_password_tokens_rename_id_to_token', NULL),
(46, '2018_01_18_134500_change_password_tokens_add_foreign_keys', NULL),
(47, '2018_01_18_134600_change_password_tokens_created_at_to_datetime', NULL),
(48, '2018_01_18_135000_change_posts_rename_columns', NULL),
(49, '2018_01_18_135100_change_posts_add_foreign_keys', NULL),
(50, '2018_01_30_112238_add_fulltext_index_to_discussions_title', NULL),
(51, '2018_01_30_220100_create_post_user_table', NULL),
(52, '2018_01_30_222900_change_users_rename_columns', NULL),
(55, '2018_09_15_041340_add_users_indicies', NULL),
(56, '2018_09_15_041828_add_discussions_indicies', NULL),
(57, '2018_09_15_043337_add_notifications_indices', NULL),
(58, '2018_09_15_043621_add_posts_indices', NULL),
(59, '2018_09_22_004100_change_registration_tokens_columns', NULL),
(60, '2018_09_22_004200_create_login_providers_table', NULL),
(61, '2018_10_08_144700_add_shim_prefix_to_group_icons', NULL),
(62, '2019_10_12_195349_change_posts_add_discussion_foreign_key', NULL),
(63, '2020_03_19_134512_change_discussions_default_comment_count', NULL),
(64, '2020_04_21_130500_change_permission_groups_add_is_hidden', NULL),
(65, '2021_03_02_040000_change_access_tokens_add_type', NULL),
(66, '2021_03_02_040500_change_access_tokens_add_id', NULL),
(67, '2021_03_02_041000_change_access_tokens_add_title_ip_agent', NULL),
(68, '2021_04_18_040500_change_migrations_add_id_primary_key', NULL),
(69, '2021_04_18_145100_change_posts_content_column_to_mediumtext', NULL),
(70, '2018_07_21_000000_seed_default_groups', NULL),
(71, '2018_07_21_000100_seed_default_group_permissions', NULL),
(72, '2021_05_10_000000_rename_permissions', NULL),
(73, '2022_05_20_000000_add_timestamps_to_groups_table', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `fonotifications`
--

DROP TABLE IF EXISTS `fonotifications`;
CREATE TABLE IF NOT EXISTS `fonotifications` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `from_user_id` int UNSIGNED DEFAULT NULL,
  `type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject_id` int UNSIGNED DEFAULT NULL,
  `data` blob,
  `created_at` datetime NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `read_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fonotifications_from_user_id_foreign` (`from_user_id`),
  KEY `fonotifications_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `fopassword_tokens`
--

DROP TABLE IF EXISTS `fopassword_tokens`;
CREATE TABLE IF NOT EXISTS `fopassword_tokens` (
  `token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`token`),
  KEY `fopassword_tokens_user_id_foreign` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `foposts`
--

DROP TABLE IF EXISTS `foposts`;
CREATE TABLE IF NOT EXISTS `foposts` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `discussion_id` int UNSIGNED NOT NULL,
  `number` int UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `user_id` int UNSIGNED DEFAULT NULL,
  `type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT ' ',
  `edited_at` datetime DEFAULT NULL,
  `edited_user_id` int UNSIGNED DEFAULT NULL,
  `hidden_at` datetime DEFAULT NULL,
  `hidden_user_id` int UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_private` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `foposts_discussion_id_number_unique` (`discussion_id`,`number`),
  KEY `foposts_edited_user_id_foreign` (`edited_user_id`),
  KEY `foposts_hidden_user_id_foreign` (`hidden_user_id`),
  KEY `foposts_discussion_id_number_index` (`discussion_id`,`number`),
  KEY `foposts_discussion_id_created_at_index` (`discussion_id`,`created_at`),
  KEY `foposts_user_id_created_at_index` (`user_id`,`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `fopost_user`
--

DROP TABLE IF EXISTS `fopost_user`;
CREATE TABLE IF NOT EXISTS `fopost_user` (
  `post_id` int UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  PRIMARY KEY (`post_id`,`user_id`),
  KEY `fopost_user_user_id_foreign` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `foregistration_tokens`
--

DROP TABLE IF EXISTS `foregistration_tokens`;
CREATE TABLE IF NOT EXISTS `foregistration_tokens` (
  `token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `provider` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_attributes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `fosettings`
--

DROP TABLE IF EXISTS `fosettings`;
CREATE TABLE IF NOT EXISTS `fosettings` (
  `key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `fousers`
--

DROP TABLE IF EXISTS `fousers`;
CREATE TABLE IF NOT EXISTS `fousers` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_email_confirmed` tinyint(1) NOT NULL DEFAULT '0',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar_url` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `preferences` blob,
  `joined_at` datetime DEFAULT NULL,
  `last_seen_at` datetime DEFAULT NULL,
  `marked_all_as_read_at` datetime DEFAULT NULL,
  `read_notifications_at` datetime DEFAULT NULL,
  `discussion_count` int UNSIGNED NOT NULL DEFAULT '0',
  `comment_count` int UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fousers_username_unique` (`username`),
  UNIQUE KEY `fousers_email_unique` (`email`),
  KEY `fousers_joined_at_index` (`joined_at`),
  KEY `fousers_last_seen_at_index` (`last_seen_at`),
  KEY `fousers_discussion_count_index` (`discussion_count`),
  KEY `fousers_comment_count_index` (`comment_count`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `fodiscussions`
--
ALTER TABLE `fodiscussions` ADD FULLTEXT KEY `title` (`title`);

--
-- Index pour la table `foposts`
--
ALTER TABLE `foposts` ADD FULLTEXT KEY `content` (`content`);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `foaccess_tokens`
--
ALTER TABLE `foaccess_tokens`
  ADD CONSTRAINT `foaccess_tokens_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `fousers` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `foapi_keys`
--
ALTER TABLE `foapi_keys`
  ADD CONSTRAINT `foapi_keys_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `fousers` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `fodiscussions`
--
ALTER TABLE `fodiscussions`
  ADD CONSTRAINT `fodiscussions_first_post_id_foreign` FOREIGN KEY (`first_post_id`) REFERENCES `foposts` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fodiscussions_hidden_user_id_foreign` FOREIGN KEY (`hidden_user_id`) REFERENCES `fousers` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fodiscussions_last_post_id_foreign` FOREIGN KEY (`last_post_id`) REFERENCES `foposts` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fodiscussions_last_posted_user_id_foreign` FOREIGN KEY (`last_posted_user_id`) REFERENCES `fousers` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fodiscussions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `fousers` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `fodiscussion_user`
--
ALTER TABLE `fodiscussion_user`
  ADD CONSTRAINT `fodiscussion_user_discussion_id_foreign` FOREIGN KEY (`discussion_id`) REFERENCES `fodiscussions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fodiscussion_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `fousers` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `foemail_tokens`
--
ALTER TABLE `foemail_tokens`
  ADD CONSTRAINT `foemail_tokens_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `fousers` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `fogroup_permission`
--
ALTER TABLE `fogroup_permission`
  ADD CONSTRAINT `fogroup_permission_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `fogroups` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `fogroup_user`
--
ALTER TABLE `fogroup_user`
  ADD CONSTRAINT `fogroup_user_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `fogroups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fogroup_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `fousers` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `fologin_providers`
--
ALTER TABLE `fologin_providers`
  ADD CONSTRAINT `fologin_providers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `fousers` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `fonotifications`
--
ALTER TABLE `fonotifications`
  ADD CONSTRAINT `fonotifications_from_user_id_foreign` FOREIGN KEY (`from_user_id`) REFERENCES `fousers` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fonotifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `fousers` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `fopassword_tokens`
--
ALTER TABLE `fopassword_tokens`
  ADD CONSTRAINT `fopassword_tokens_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `fousers` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `foposts`
--
ALTER TABLE `foposts`
  ADD CONSTRAINT `foposts_discussion_id_foreign` FOREIGN KEY (`discussion_id`) REFERENCES `fodiscussions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `foposts_edited_user_id_foreign` FOREIGN KEY (`edited_user_id`) REFERENCES `fousers` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `foposts_hidden_user_id_foreign` FOREIGN KEY (`hidden_user_id`) REFERENCES `fousers` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `foposts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `fousers` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `fopost_user`
--
ALTER TABLE `fopost_user`
  ADD CONSTRAINT `fopost_user_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `foposts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fopost_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `fousers` (`id`) ON DELETE CASCADE;
--
-- Base de données : `locavoit`
--
CREATE DATABASE IF NOT EXISTS `locavoit` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `locavoit`;

-- --------------------------------------------------------

--
-- Structure de la table `voitures`
--

DROP TABLE IF EXISTS `voitures`;
CREATE TABLE IF NOT EXISTS `voitures` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom_modele` varchar(100) NOT NULL,
  `prix_par_jour` decimal(10,2) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `voitures`
--

INSERT INTO `voitures` (`id`, `nom_modele`, `prix_par_jour`, `image_url`) VALUES
(1, 'Renault R5 Turbo', 100.00, 'images/voiture_1.jpg\r\n'),
(2, 'Mazda 3 Hatchback', 50.00, 'images/voiture_2.jpg'),
(3, 'Honda Civic FK8 type R', 150.00, 'images/voiture_3.jpg'),
(4, 'Ford Mustang', 180.00, 'images/voiture_4.jpg'),
(5, 'Chevrolet Camaro', 170.00, 'images/voiture_5.jpg'),
(6, 'Dodge Charger', 160.00, 'images/voiture_6.jpg'),
(7, 'BMW M3', 200.00, 'images/voiture_7.jpg'),
(8, 'Audi RS5', 190.00, 'images/voiture_8.jpg'),
(9, 'Mercedes-AMG C63', 210.00, 'images/voiture_9.jpg');
--
-- Base de données : `mon_blog`
--
CREATE DATABASE IF NOT EXISTS `mon_blog` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `mon_blog`;

-- --------------------------------------------------------

--
-- Structure de la table `articles`
--

DROP TABLE IF EXISTS `articles`;
CREATE TABLE IF NOT EXISTS `articles` (
  `id_article` int NOT NULL AUTO_INCREMENT,
  `titre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `extrait` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `contenu` text COLLATE utf8mb4_general_ci NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_publication` datetime DEFAULT CURRENT_TIMESTAMP,
  `id_categorie` int NOT NULL,
  `id_auteur` int NOT NULL,
  PRIMARY KEY (`id_article`),
  KEY `id_auteur` (`id_auteur`),
  KEY `id_categorie` (`id_categorie`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `id_categorie` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id_categorie`),
  UNIQUE KEY `nom` (`nom`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `commentaires`
--

DROP TABLE IF EXISTS `commentaires`;
CREATE TABLE IF NOT EXISTS `commentaires` (
  `id_commentaire` int NOT NULL AUTO_INCREMENT,
  `contenu` text COLLATE utf8mb4_general_ci NOT NULL,
  `date_publication` datetime DEFAULT CURRENT_TIMESTAMP,
  `id_article` int NOT NULL,
  `id_utilisateur` int NOT NULL,
  PRIMARY KEY (`id_commentaire`),
  KEY `id_article` (`id_article`),
  KEY `id_utilisateur` (`id_utilisateur`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateurs`
--

DROP TABLE IF EXISTS `utilisateurs`;
CREATE TABLE IF NOT EXISTS `utilisateurs` (
  `id_utilisateur` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prenom` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `pseudo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mot_de_passe` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `role` enum('utilisateur','admin') COLLATE utf8mb4_general_ci DEFAULT 'utilisateur',
  PRIMARY KEY (`id_utilisateur`),
  UNIQUE KEY `pseudo` (`pseudo`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `utilisateurs`
--

INSERT INTO `utilisateurs` (`id_utilisateur`, `nom`, `prenom`, `pseudo`, `mot_de_passe`, `email`, `role`) VALUES
(1, 'Bob', 'Sponge', 'Administrateur', 'blog123456', 'bob.sponge@gmail.com', 'admin');
--
-- Base de données : `php_blog`
--
CREATE DATABASE IF NOT EXISTS `php_blog` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `php_blog`;

-- --------------------------------------------------------

--
-- Structure de la table `carousels`
--

DROP TABLE IF EXISTS `carousels`;
CREATE TABLE IF NOT EXISTS `carousels` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category_id` int NOT NULL,
  `user` varchar(25) NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`),
  KEY `user` (`user`),
  KEY `category_id` (`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `carousels_categories`
--

DROP TABLE IF EXISTS `carousels_categories`;
CREATE TABLE IF NOT EXISTS `carousels_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `carousels_images`
--

DROP TABLE IF EXISTS `carousels_images`;
CREATE TABLE IF NOT EXISTS `carousels_images` (
  `carousel_id` int DEFAULT NULL,
  `image_id` int DEFAULT NULL,
  KEY `carousel_id` (`carousel_id`),
  KEY `image_id` (`image_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `images`
--

DROP TABLE IF EXISTS `images`;
CREATE TABLE IF NOT EXISTS `images` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user` varchar(25) NOT NULL,
  `imgpath` varchar(200) NOT NULL,
  `caption` varchar(250) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `imgpath` (`imgpath`),
  KEY `user` (`user`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `posts`
--

DROP TABLE IF EXISTS `posts`;
CREATE TABLE IF NOT EXISTS `posts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user` varchar(25) NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` text,
  `body` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`),
  KEY `user` (`user`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `posts`
--

INSERT INTO `posts` (`id`, `user`, `title`, `description`, `body`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'First Post', 'First Post Description', 'First Post Body', '2025-02-10 01:38:53', '2025-02-09 21:38:53'),
(2, 'vishal', 'Second Post', 'Second Post Description', 'Second Post Body', '2025-02-10 01:38:53', '2025-02-09 21:38:53'),
(3, 'vishal', 'Third Post', 'Third Post Description', 'Third Post Body', '2025-02-10 01:38:53', '2025-02-09 21:38:53');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(25) NOT NULL,
  `password` varchar(100) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `role` varchar(10) NOT NULL DEFAULT 'editor',
  `email` varchar(200) DEFAULT NULL,
  `reset_link_token` varchar(200) DEFAULT NULL,
  `exp_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `name`, `role`, `email`, `reset_link_token`, `exp_date`) VALUES
(1, 'admin', '21232f297a57a5a743894a0e4a801fc3', 'Administrator', 'admin', 'vshlbndr@gmail.com', NULL, NULL),
(2, 'vishal', '8b64d2451b7a8f3fd17390f88ea35917', 'Vishal Bandre', 'editor', 'iamvshlbndr@gmail.com', NULL, NULL);
--
-- Base de données : `voitures_db`
--
CREATE DATABASE IF NOT EXISTS `voitures_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `voitures_db`;

-- --------------------------------------------------------

--
-- Structure de la table `commande`
--

DROP TABLE IF EXISTS `commande`;
CREATE TABLE IF NOT EXISTS `commande` (
  `id` int NOT NULL AUTO_INCREMENT,
  `total` decimal(10,2) NOT NULL,
  `date_commande` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `commande`
--

INSERT INTO `commande` (`id`, `total`, `date_commande`) VALUES
(1, 20.50, '2025-01-16 07:48:04'),
(2, 0.00, '2025-01-16 07:48:34'),
(3, 140.50, '2025-01-16 07:48:55'),
(4, 0.00, '2025-01-16 07:49:12'),
(5, 120.00, '2025-01-21 14:26:25'),
(6, 61.50, '2025-02-09 20:00:32');

-- --------------------------------------------------------

--
-- Structure de la table `commandedetail`
--

DROP TABLE IF EXISTS `commandedetail`;
CREATE TABLE IF NOT EXISTS `commandedetail` (
  `id` int NOT NULL AUTO_INCREMENT,
  `commande_id` int DEFAULT NULL,
  `produit_id` int DEFAULT NULL,
  `quantite` int DEFAULT NULL,
  `prix_unitaire` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `commande_id` (`commande_id`),
  KEY `produit_id` (`produit_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `commandedetail`
--

INSERT INTO `commandedetail` (`id`, `commande_id`, `produit_id`, `quantite`, `prix_unitaire`) VALUES
(1, 1, 1, 1, 20.50),
(2, 3, 2, 1, 120.00),
(3, 3, 1, 1, 20.50),
(4, 5, 2, 1, 120.00),
(5, 6, 1, 3, 20.50);

-- --------------------------------------------------------

--
-- Structure de la table `fichetechnique`
--

DROP TABLE IF EXISTS `fichetechnique`;
CREATE TABLE IF NOT EXISTS `fichetechnique` (
  `id` int NOT NULL AUTO_INCREMENT,
  `modele_id` int DEFAULT NULL,
  `moteur` varchar(100) DEFAULT NULL,
  `puissance` int DEFAULT NULL,
  `consommation` decimal(5,2) DEFAULT NULL,
  `autres_details` text,
  PRIMARY KEY (`id`),
  KEY `modele_id` (`modele_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `fichetechnique`
--

INSERT INTO `fichetechnique` (`id`, `modele_id`, `moteur`, `puissance`, `consommation`, `autres_details`) VALUES
(1, 1, '1.8L', 140, 6.50, 'Berline compacte'),
(2, 2, '5.0L V8', 450, 12.00, 'Muscle car'),
(3, 3, '3.0L V6', 300, 10.00, 'SUV de luxe');

-- --------------------------------------------------------

--
-- Structure de la table `marque`
--

DROP TABLE IF EXISTS `marque`;
CREATE TABLE IF NOT EXISTS `marque` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `marque`
--

INSERT INTO `marque` (`id`, `nom`) VALUES
(1, 'Toyota'),
(2, 'Ford'),
(3, 'BMW');

-- --------------------------------------------------------

--
-- Structure de la table `modele`
--

DROP TABLE IF EXISTS `modele`;
CREATE TABLE IF NOT EXISTS `modele` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  `marque_id` int DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `marque_id` (`marque_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `modele`
--

INSERT INTO `modele` (`id`, `nom`, `marque_id`, `type`) VALUES
(1, 'Corolla', 1, 'Berline'),
(2, 'Mustang', 2, 'Cabriolet'),
(3, 'X5', 3, 'SUV');

-- --------------------------------------------------------

--
-- Structure de la table `panier`
--

DROP TABLE IF EXISTS `panier`;
CREATE TABLE IF NOT EXISTS `panier` (
  `id` int NOT NULL AUTO_INCREMENT,
  `produit_id` int DEFAULT NULL,
  `quantite` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `produit_id` (`produit_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `panier`
--

INSERT INTO `panier` (`id`, `produit_id`, `quantite`) VALUES
(8, 5, 2);

-- --------------------------------------------------------

--
-- Structure de la table `produit`
--

DROP TABLE IF EXISTS `produit`;
CREATE TABLE IF NOT EXISTS `produit` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  `description` text,
  `prix` decimal(10,2) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `produit`
--

INSERT INTO `produit` (`id`, `nom`, `description`, `prix`, `image_url`) VALUES
(1, 'Filtre à huile', 'Filtre à huile pour moteur, compatible avec plusieurs modèles.', 20.50, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYQSnamCY4vRHYKm7HKCkf6XDcIRD7LkPO3w&s'),
(2, 'Batterie de voiture', 'Batterie de voiture haute performance.', 120.00, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQjzf2gaNntBJlRDxiEbKYpJ8-QVVwvYmnVw&s'),
(3, 'Balais d\'essuie-glace', 'Balais d\'essuie-glace de haute qualité.', 15.00, 'https://www.cdiscount.com/pdt2/5/5/9/1/700x700/auc9347236698559/rw/essuie-glaces-voiture-26-17-14-paille-d-essuie.jpg'),
(4, 'Bougies d\'allumage', 'Bougies d\'allumage pour une meilleure performance.', 35.00, 'https://cdn.autodoc.de/uploads/info_section/article/632/1706264969_7687_afdc94243ce41bdec8c50e2fab6f1d41.jpeg'),
(5, 'Pneus', 'Pneus tout-terrain robustes.', 100.00, 'https://www.bpsracing.com/media/catalog/product/4/2/7/7/8/5/xlarge-ADVAN_SPORT_V105S_15.png');

-- --------------------------------------------------------

--
-- Structure de la table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
CREATE TABLE IF NOT EXISTS `reservation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `voiture_id` int DEFAULT NULL,
  `date_debut` date DEFAULT NULL,
  `date_fin` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `voiture_id` (`voiture_id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `reservation`
--

INSERT INTO `reservation` (`id`, `voiture_id`, `date_debut`, `date_fin`) VALUES
(1, 1, '2025-05-23', '2025-01-14'),
(2, 2, '2025-01-10', '2025-01-17'),
(3, 2, '2025-01-10', '2025-01-17'),
(4, 2, '2025-01-10', '2025-01-17'),
(5, 2, '2025-01-10', '2025-01-17'),
(6, 2, '2025-01-10', '2025-01-17'),
(7, 2, '2025-01-10', '2025-01-17'),
(8, 2, '2025-01-10', '2025-01-17'),
(9, 2, '2025-01-10', '2025-01-17'),
(10, 1, '2025-01-20', '2025-01-24');

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

DROP TABLE IF EXISTS `utilisateur`;
CREATE TABLE IF NOT EXISTS `utilisateur` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `pseudo` varchar(50) NOT NULL,
  `mot_de_passe` varchar(255) NOT NULL,
  `avatar_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `pseudo` (`pseudo`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`id`, `email`, `pseudo`, `mot_de_passe`, `avatar_url`) VALUES
(1, 'daphne.antilope@outlook.fr', 'Solaris', '$2y$10$LmpQd/LPLJyGCey/OMd7Quz5xFUqD.hipwS5gQ3KsJodU96EEvU0O', 'images/avatar_user/58f37952a4fa116215a9241f.png');

-- --------------------------------------------------------

--
-- Structure de la table `voiture_location`
--

DROP TABLE IF EXISTS `voiture_location`;
CREATE TABLE IF NOT EXISTS `voiture_location` (
  `id` int NOT NULL AUTO_INCREMENT,
  `marque` varchar(100) NOT NULL,
  `modele` varchar(100) NOT NULL,
  `prix_par_jour` decimal(10,2) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `voiture_location`
--

INSERT INTO `voiture_location` (`id`, `marque`, `modele`, `prix_par_jour`, `image_url`) VALUES
(1, 'Toyota', 'Corolla', 50.00, 'images/location/toyota_corolla.jpg'),
(2, 'Ford', 'Mustang', 100.00, 'images/location/ford_mustang.jpg'),
(3, 'BMW', 'X5', 150.00, 'images/location/bmw_x5.jpg'),
(4, 'Toyota', 'C-HR', 30.00, 'images/location/toyota_chr.jpg'),
(5, 'Toyota', 'Rav4', 40.00, 'images/location/toyota_rav4.jpg');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
