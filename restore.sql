/*
 Navicat MySQL Dump SQL

 Source Server         : database
 Source Server Type    : MySQL
 Source Server Version : 80405 (8.4.5)
 Source Host           : localhost:3306
 Source Schema         : mahjongreservation

 Target Server Type    : MySQL
 Target Server Version : 80405 (8.4.5)
 File Encoding         : 65001

 Date: 16/05/2025 03:00:33
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of auth_group
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
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

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
BEGIN;
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (4, 'Can view log entry', 1, 'view_logentry');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (5, 'Can add permission', 2, 'add_permission');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (6, 'Can change permission', 2, 'change_permission');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (7, 'Can delete permission', 2, 'delete_permission');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (8, 'Can view permission', 2, 'view_permission');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (9, 'Can add group', 3, 'add_group');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (10, 'Can change group', 3, 'change_group');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (11, 'Can delete group', 3, 'delete_group');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (12, 'Can view group', 3, 'view_group');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (13, 'Can add user', 4, 'add_user');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (14, 'Can change user', 4, 'change_user');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (15, 'Can delete user', 4, 'delete_user');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (16, 'Can view user', 4, 'view_user');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (17, 'Can add content type', 5, 'add_contenttype');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (18, 'Can change content type', 5, 'change_contenttype');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (19, 'Can delete content type', 5, 'delete_contenttype');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (20, 'Can view content type', 5, 'view_contenttype');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (21, 'Can add session', 6, 'add_session');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (22, 'Can change session', 6, 'change_session');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (23, 'Can delete session', 6, 'delete_session');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (24, 'Can view session', 6, 'view_session');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (25, 'Can add announcement', 7, 'add_announcement');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (26, 'Can change announcement', 7, 'change_announcement');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (27, 'Can delete announcement', 7, 'delete_announcement');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (28, 'Can view announcement', 7, 'view_announcement');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (29, 'Can add customer', 8, 'add_customer');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (30, 'Can change customer', 8, 'change_customer');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (31, 'Can delete customer', 8, 'delete_customer');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (32, 'Can view customer', 8, 'view_customer');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (33, 'Can add income', 9, 'add_income');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (34, 'Can change income', 9, 'change_income');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (35, 'Can delete income', 9, 'delete_income');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (36, 'Can view income', 9, 'view_income');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (37, 'Can add item', 10, 'add_item');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (38, 'Can change item', 10, 'change_item');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (39, 'Can delete item', 10, 'delete_item');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (40, 'Can view item', 10, 'view_item');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (41, 'Can add room', 11, 'add_room');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (42, 'Can change room', 11, 'change_room');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (43, 'Can delete room', 11, 'delete_room');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (44, 'Can view room', 11, 'view_room');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (45, 'Can add staff', 12, 'add_staff');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (46, 'Can change staff', 12, 'change_staff');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (47, 'Can delete staff', 12, 'delete_staff');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (48, 'Can view staff', 12, 'view_staff');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (49, 'Can add room reservation', 13, 'add_roomreservation');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (50, 'Can change room reservation', 13, 'change_roomreservation');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (51, 'Can delete room reservation', 13, 'delete_roomreservation');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (52, 'Can view room reservation', 13, 'view_roomreservation');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (53, 'Can add room usage order', 14, 'add_roomusageorder');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (54, 'Can change room usage order', 14, 'change_roomusageorder');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (55, 'Can delete room usage order', 14, 'delete_roomusageorder');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (56, 'Can view room usage order', 14, 'view_roomusageorder');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (57, 'Can add room cleaning order', 15, 'add_roomcleaningorder');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (58, 'Can change room cleaning order', 15, 'change_roomcleaningorder');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (59, 'Can delete room cleaning order', 15, 'delete_roomcleaningorder');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (60, 'Can view room cleaning order', 15, 'view_roomcleaningorder');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (61, 'Can add product order', 16, 'add_productorder');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (62, 'Can change product order', 16, 'change_productorder');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (63, 'Can delete product order', 16, 'delete_productorder');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (64, 'Can view product order', 16, 'view_productorder');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (65, 'Can add user profile', 17, 'add_userprofile');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (66, 'Can change user profile', 17, 'change_userprofile');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (67, 'Can delete user profile', 17, 'delete_userprofile');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (68, 'Can view user profile', 17, 'view_userprofile');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (69, 'Can add admin', 18, 'add_admin');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (70, 'Can change admin', 18, 'change_admin');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (71, 'Can delete admin', 18, 'delete_admin');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (72, 'Can view admin', 18, 'view_admin');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (73, 'Can add order item', 19, 'add_orderitem');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (74, 'Can change order item', 19, 'change_orderitem');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (75, 'Can delete order item', 19, 'delete_orderitem');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (76, 'Can view order item', 19, 'view_orderitem');
COMMIT;

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of auth_user
-- ----------------------------
BEGIN;
INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES (1, 'pbkdf2_sha256$1000000$TPs8O0H9nVLr9e5G5Lu3It$d0ca/7MdW4J5wQ93qk/tDwJP4spEnet37DJAI9VQvzs=', '2025-05-12 20:44:46.925745', 1, 'root', '', '', 'mail@edu.cn', 1, 1, '2025-05-04 12:04:15.362095');
INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES (2, 'pbkdf2_sha256$1000000$cNodcETk7M45QJcGJryjNi$mhJvu/PfCxjG6WPSojM1TNJHGVwfLKlyweb1zxayF/c=', '2025-05-05 18:15:24.902416', 0, 'staff01', '', '', '', 0, 1, '2025-05-05 08:44:59.992228');
INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES (3, 'pbkdf2_sha256$1000000$yNXYJ9OHFL0Y7Ut1yAQHpW$X4KzdWfHG1m5VKTN1jQDKB6/jpe0O/Hh8wYABDagAhc=', NULL, 0, 'staff02', '', '', '', 0, 1, '2025-05-05 08:45:06.248080');
INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES (4, 'pbkdf2_sha256$1000000$adr9Se49TFxmPmH17RoiDM$k5VMF3Wak/5FBYi5t8FOzmIR7RJflHiL453M2TA4yXc=', NULL, 0, 'staff03', '', '', '', 0, 1, '2025-05-05 08:45:14.293942');
INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES (5, 'pbkdf2_sha256$1000000$CVXymQEAkIRYONcup8ZKpR$CRyWiLOmHASBT/5L/wwRYSYXRpeR+p4Vt2QgvozupYE=', NULL, 0, 'staff04', '', '', '', 0, 1, '2025-05-05 08:45:23.043613');
INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES (10, 'pbkdf2_sha256$1000000$we2GzmLnLk1bn5wKMwG2Hk$Veo9NszLy54kwAsxXIhTlWM/IwZP3ePxRVFgmUsmVyg=', NULL, 0, 'customer01', '', '', '', 0, 1, '2025-05-05 12:20:02.892902');
INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES (11, 'pbkdf2_sha256$1000000$2LR90XmynFxODKrccNoOqY$m2V5CVSerYGv3ODy8MkXPMbiwfTEkJhpnSVMkPOd0cc=', '2025-05-15 19:00:00.001020', 0, 'customer02', '', '', '', 0, 1, '2025-05-05 12:20:12.942369');
INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES (12, 'pbkdf2_sha256$1000000$Cd3z4qXbVqQHD0V0nWJmOv$W8+f8mdnZriECReta5kN6GooxkEAxvpt6MOqFrUFNOg=', NULL, 0, 'customer03', '', '', '', 0, 1, '2025-05-05 12:20:24.259831');
INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES (13, 'pbkdf2_sha256$1000000$f3klAeRfx0dx3No519CEij$xzWFxTsXA8E9oOXigEwlKaCy5pRvS2HWzlpNiRDFJLI=', NULL, 0, 'customer04', '', '', '', 0, 1, '2025-05-05 12:20:31.194276');
INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES (14, 'pbkdf2_sha256$1000000$wjyhmmBN7OTeYYcG5QoXRt$M2LiobA8GeEiPpQ0hbOCsNQa8UNjCLIzYrCPciqiFaM=', NULL, 0, 'customer05', '', '', '', 0, 1, '2025-05-05 12:20:41.059789');
COMMIT;

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
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

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
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

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
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
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------
BEGIN;
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (1, '2025-05-04 12:10:11.286930', '1', 'root (admin)', 1, '[{\"added\": {}}]', 17, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (2, '2025-05-04 12:10:25.035500', '1', 'root', 1, '[{\"added\": {}}]', 18, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (3, '2025-05-05 08:45:00.106169', '2', 'staff01', 1, '[{\"added\": {}}]', 4, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (4, '2025-05-05 08:45:06.342635', '3', 'staff02', 1, '[{\"added\": {}}]', 4, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (5, '2025-05-05 08:45:14.373205', '4', 'staff03', 1, '[{\"added\": {}}]', 4, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (6, '2025-05-05 08:45:23.154832', '5', 'staff04', 1, '[{\"added\": {}}]', 4, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (7, '2025-05-05 08:45:33.468788', '6', 'staff05', 1, '[{\"added\": {}}]', 4, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (8, '2025-05-05 08:46:22.473249', '2', 'staff01 (staff)', 1, '[{\"added\": {}}]', 17, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (9, '2025-05-05 08:46:33.343466', '3', 'staff02 (staff)', 1, '[{\"added\": {}}]', 17, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (10, '2025-05-05 08:46:36.723655', '4', 'staff03 (staff)', 1, '[{\"added\": {}}]', 17, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (11, '2025-05-05 08:46:40.178806', '5', 'staff04 (staff)', 1, '[{\"added\": {}}]', 17, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (12, '2025-05-05 08:46:51.845321', '6', 'staff05 (staff)', 1, '[{\"added\": {}}]', 17, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (13, '2025-05-05 08:47:16.947491', '1', 'staff01', 1, '[{\"added\": {}}]', 12, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (14, '2025-05-05 08:47:21.068424', '2', 'staff02', 1, '[{\"added\": {}}]', 12, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (15, '2025-05-05 08:47:25.627487', '3', 'staff03', 1, '[{\"added\": {}}]', 12, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (16, '2025-05-05 08:47:31.809602', '4', 'staff04', 1, '[{\"added\": {}}]', 12, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (17, '2025-05-05 08:47:35.960619', '5', 'staff05', 1, '[{\"added\": {}}]', 12, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (18, '2025-05-05 10:07:52.820365', '1', 'staff01', 2, '[{\"changed\": {\"fields\": [\"Name\"]}}]', 12, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (19, '2025-05-05 10:07:57.559581', '2', 'staff02', 2, '[{\"changed\": {\"fields\": [\"Name\"]}}]', 12, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (20, '2025-05-05 10:08:01.653557', '3', 'staff03', 2, '[{\"changed\": {\"fields\": [\"Name\"]}}]', 12, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (21, '2025-05-05 10:08:06.354552', '4', 'staff04', 2, '[{\"changed\": {\"fields\": [\"Name\"]}}]', 12, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (22, '2025-05-05 10:08:11.287855', '5', 'staff05', 2, '[{\"changed\": {\"fields\": [\"Name\"]}}]', 12, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (23, '2025-05-05 10:15:53.179394', '7', 'staff06', 3, '', 4, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (24, '2025-05-05 12:20:03.013945', '10', 'customer01', 1, '[{\"added\": {}}]', 4, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (25, '2025-05-05 12:20:13.053731', '11', 'customer02', 1, '[{\"added\": {}}]', 4, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (26, '2025-05-05 12:20:24.371600', '12', 'customer03', 1, '[{\"added\": {}}]', 4, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (27, '2025-05-05 12:20:31.304687', '13', 'customer04', 1, '[{\"added\": {}}]', 4, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (28, '2025-05-05 12:20:41.170709', '14', 'customer05', 1, '[{\"added\": {}}]', 4, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (29, '2025-05-05 12:20:57.744406', '8', 'customer01 (customer)', 1, '[{\"added\": {}}]', 17, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (30, '2025-05-05 12:21:03.404343', '9', 'customer02 (customer)', 1, '[{\"added\": {}}]', 17, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (31, '2025-05-05 12:21:06.483019', '10', 'customer03 (customer)', 1, '[{\"added\": {}}]', 17, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (32, '2025-05-05 12:21:09.282419', '11', 'customer04 (customer)', 1, '[{\"added\": {}}]', 17, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (33, '2025-05-05 12:21:13.769439', '12', 'customer05 (customer)', 1, '[{\"added\": {}}]', 17, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (34, '2025-05-05 12:21:51.375020', '1', '13811111111', 1, '[{\"added\": {}}]', 8, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (35, '2025-05-05 12:22:08.342731', '2', '13822222222', 1, '[{\"added\": {}}]', 8, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (36, '2025-05-05 12:22:30.209515', '3', '13833333333', 1, '[{\"added\": {}}]', 8, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (37, '2025-05-05 12:22:42.242083', '4', '13844444444', 1, '[{\"added\": {}}]', 8, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (38, '2025-05-05 12:22:55.443435', '5', '13855555555', 1, '[{\"added\": {}}]', 8, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (39, '2025-05-05 19:58:13.272273', '10', 'Murakami Ryota', 2, '[{\"changed\": {\"fields\": [\"Description\"]}}]', 11, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (40, '2025-05-05 19:58:16.117507', '10', 'Murakami Ryota', 2, '[]', 11, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (41, '2025-05-05 19:58:22.139964', '9', 'Aaron Kelley', 2, '[{\"changed\": {\"fields\": [\"Description\"]}}]', 11, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (42, '2025-05-05 19:58:27.114623', '8', 'Valerie Wagner', 2, '[{\"changed\": {\"fields\": [\"Description\"]}}]', 11, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (43, '2025-05-05 19:58:32.370690', '7', 'Fujiwara Ayano', 2, '[{\"changed\": {\"fields\": [\"Description\"]}}]', 11, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (44, '2025-05-05 19:58:34.598001', '7', 'Fujiwara Ayano', 2, '[]', 11, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (45, '2025-05-05 19:58:38.999320', '6', 'Li Xiaoming', 2, '[{\"changed\": {\"fields\": [\"Description\"]}}]', 11, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (46, '2025-05-05 19:58:43.803812', '5', 'Mo Yuning', 2, '[{\"changed\": {\"fields\": [\"Description\"]}}]', 11, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (47, '2025-05-05 19:58:50.251077', '4', 'Lee Wai San', 2, '[{\"changed\": {\"fields\": [\"Description\"]}}]', 11, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (48, '2025-05-05 19:58:56.137850', '3', 'Ichikawa Hana', 2, '[{\"changed\": {\"fields\": [\"Description\"]}}]', 11, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (49, '2025-05-05 19:59:00.717646', '2', 'Carmen Russell', 2, '[{\"changed\": {\"fields\": [\"Description\"]}}]', 11, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (50, '2025-05-05 19:59:05.340508', '1', 'Lui Ching Wan', 2, '[{\"changed\": {\"fields\": [\"Description\"]}}]', 11, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (51, '2025-05-05 20:00:05.712837', '1', 'Lui Ching Wan', 3, '', 11, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (52, '2025-05-05 21:05:16.003776', '1', 'Usage Order 1', 1, '[{\"added\": {}}]', 14, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (53, '2025-05-05 21:33:51.010187', '2', 'Usage Order 2', 1, '[{\"added\": {}}]', 14, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (54, '2025-05-05 21:34:25.289125', '3', 'Usage Order 3', 1, '[{\"added\": {}}]', 14, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (55, '2025-05-05 21:37:00.651308', '3', 'Usage Order 3', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 14, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (56, '2025-05-05 21:37:48.339302', '4', 'Usage Order 4', 1, '[{\"added\": {}}]', 14, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (57, '2025-05-05 21:38:07.408795', '8', 'Valerie Wagner', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 11, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (58, '2025-05-05 21:38:53.368929', '5', 'Usage Order 5', 1, '[{\"added\": {}}]', 14, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (59, '2025-05-05 21:59:11.144994', '6', '扑克牌', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 10, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (60, '2025-05-05 22:13:49.757986', '6', '扑克牌', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 10, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (61, '2025-05-05 22:14:03.906343', '6', '扑克牌', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 10, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (62, '2025-05-05 22:14:24.848793', '6', '扑克牌', 3, '', 10, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (63, '2025-05-05 22:15:37.768711', '1', '矿泉水', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 10, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (64, '2025-05-05 22:20:58.136354', '1', '矿泉水', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 10, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (65, '2025-05-05 22:21:05.349265', '7', '纸巾', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 10, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (66, '2025-05-05 22:35:36.137691', '7', '纸巾', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 10, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (67, '2025-05-05 22:35:42.396758', '7', '纸巾', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 10, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (68, '2025-05-05 23:01:09.675638', '7', '纸巾', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 10, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (69, '2025-05-05 23:01:21.204228', '7', '纸巾', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 10, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (70, '2025-05-05 23:15:27.155102', '7', '纸巾', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 10, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (71, '2025-05-05 23:15:35.111485', '7', '纸巾', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 10, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (72, '2025-05-06 00:23:30.859905', '1', 'Order 1', 1, '[{\"added\": {}}]', 16, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (73, '2025-05-06 00:23:35.048674', '1', 'Order 1', 2, '[]', 16, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (74, '2025-05-06 00:23:41.247588', '1', 'Order 1', 2, '[]', 16, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (75, '2025-05-06 00:23:47.628150', '2', 'Order 2', 1, '[{\"added\": {}}]', 16, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (76, '2025-05-06 00:23:57.088613', '3', 'Order 3', 1, '[{\"added\": {}}]', 16, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (77, '2025-05-06 00:24:35.328133', '1', 'Order 1 - Item 矿泉水 x1', 1, '[{\"added\": {}}]', 19, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (78, '2025-05-06 00:24:44.229979', '2', 'Order 1 - Item 可乐 x2', 1, '[{\"added\": {}}]', 19, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (79, '2025-05-06 00:24:52.695595', '3', 'Order 2 - Item 啤酒 x5', 1, '[{\"added\": {}}]', 19, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (80, '2025-05-06 00:24:59.281895', '4', 'Order 2 - Item 扑克牌 x1', 1, '[{\"added\": {}}]', 19, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (81, '2025-05-06 00:25:07.698518', '5', 'Order 2 - Item 纸巾 x1', 1, '[{\"added\": {}}]', 19, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (82, '2025-05-06 00:25:14.431449', '6', 'Order 3 - Item 橙汁 x1', 1, '[{\"added\": {}}]', 19, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (83, '2025-05-06 00:25:21.487401', '7', 'Order 3 - Item 绿茶 x3', 1, '[{\"added\": {}}]', 19, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (84, '2025-05-06 01:09:18.858031', '3', 'Order 3', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 16, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (85, '2025-05-06 01:09:23.198779', '3', 'Order 3', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 16, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (86, '2025-05-06 01:09:36.028285', '1', 'Order 1', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 16, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (87, '2025-05-06 01:21:38.778450', '1', 'Cleaning Order 1', 1, '[{\"added\": {}}]', 15, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (88, '2025-05-06 01:45:41.956688', '1', 'Cleaning Order 1', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 15, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (89, '2025-05-06 01:58:39.703090', '1', 'Announcement 1', 1, '[{\"added\": {}}]', 7, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (90, '2025-05-10 19:46:57.881459', '1', '13811111111', 2, '[{\"changed\": {\"fields\": [\"BlacklistStatus\"]}}]', 8, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (91, '2025-05-10 23:54:24.028179', '3', 'Ichikawa Hana', 2, '[{\"changed\": {\"fields\": [\"Price\"]}}]', 11, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (92, '2025-05-10 23:54:27.432178', '10', 'Murakami Ryota', 2, '[]', 11, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (93, '2025-05-10 23:54:34.969696', '9', 'Aaron Kelley', 2, '[{\"changed\": {\"fields\": [\"Price\"]}}]', 11, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (94, '2025-05-10 23:54:39.967840', '8', 'Valerie Wagner', 2, '[{\"changed\": {\"fields\": [\"Price\"]}}]', 11, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (95, '2025-05-10 23:54:44.099495', '7', 'Fujiwara Ayano', 2, '[{\"changed\": {\"fields\": [\"Price\"]}}]', 11, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (96, '2025-05-10 23:54:48.273003', '5', 'Mo Yuning', 2, '[{\"changed\": {\"fields\": [\"Price\"]}}]', 11, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (97, '2025-05-10 23:54:50.490259', '5', 'Mo Yuning', 2, '[]', 11, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (98, '2025-05-10 23:54:55.001717', '4', 'Lee Wai San', 2, '[{\"changed\": {\"fields\": [\"Price\"]}}]', 11, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (99, '2025-05-11 02:52:34.404938', '7', '扑克牌', 2, '[{\"changed\": {\"fields\": [\"Quantity\"]}}]', 10, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (100, '2025-05-11 08:36:59.609916', '5', 'Mo Yuning', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 11, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (101, '2025-05-11 08:38:27.283386', '5', 'Mo Yuning', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 11, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (102, '2025-05-11 08:39:37.393653', '5', 'Mo Yuning', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 11, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (103, '2025-05-11 08:44:03.354060', '5', 'Mo Yuning', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 11, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (104, '2025-05-11 08:47:41.329029', '5', 'Mo Yuning', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 11, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (105, '2025-05-11 08:50:40.950382', '5', 'Mo Yuning', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 11, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (106, '2025-05-11 08:53:03.659994', '5', 'Mo Yuning', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 11, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (107, '2025-05-15 15:27:02.884108', '1', '矿泉水', 2, '[{\"changed\": {\"fields\": [\"Disabled\"]}}]', 10, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (108, '2025-05-15 15:27:06.007509', '2', '可乐', 2, '[{\"changed\": {\"fields\": [\"Disabled\"]}}]', 10, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (109, '2025-05-15 15:27:08.917596', '3', '橙汁', 2, '[{\"changed\": {\"fields\": [\"Disabled\"]}}]', 10, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (110, '2025-05-15 15:27:12.887883', '4', '绿茶', 2, '[{\"changed\": {\"fields\": [\"Disabled\"]}}]', 10, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (111, '2025-05-15 15:45:24.471952', '7', '扑克牌', 2, '[{\"changed\": {\"fields\": [\"Quantity\"]}}]', 10, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (112, '2025-05-15 17:54:37.612888', '15', 'Usage Order 15', 3, '', 14, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (113, '2025-05-15 17:54:40.712339', '16', 'Usage Order 16', 3, '', 14, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (114, '2025-05-15 17:54:47.674870', '14', 'Usage Order 14', 3, '', 14, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (115, '2025-05-15 17:54:51.082206', '13', 'Usage Order 13', 3, '', 14, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (116, '2025-05-15 17:54:54.145522', '12', 'Usage Order 12', 3, '', 14, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (117, '2025-05-15 17:54:56.914618', '11', 'Usage Order 11', 3, '', 14, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (118, '2025-05-15 17:55:00.379508', '10', 'Usage Order 10', 3, '', 14, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (119, '2025-05-15 17:55:04.036498', '9', 'Usage Order 9', 3, '', 14, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (120, '2025-05-15 17:55:07.264142', '8', 'Usage Order 8', 3, '', 14, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (121, '2025-05-15 17:55:10.237986', '7', 'Usage Order 7', 3, '', 14, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (122, '2025-05-15 17:55:13.098560', '6', 'Usage Order 6', 3, '', 14, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (123, '2025-05-15 18:00:38.530829', '2', 'Usage Order 2', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 14, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (124, '2025-05-15 18:15:00.808369', '2', 'Usage Order 2', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 14, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (125, '2025-05-15 18:16:40.151159', '5', 'Usage Order 5', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 14, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (126, '2025-05-15 18:16:57.298656', '2', 'Usage Order 2', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 14, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (127, '2025-05-15 18:17:56.245895', '2', 'Usage Order 2', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 14, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (128, '2025-05-15 18:30:25.582680', '5', 'Mo Yuning', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 11, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (129, '2025-05-15 18:44:12.886634', '1', 'Cleaning Order 1', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 15, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (130, '2025-05-15 18:47:30.749152', '1', 'Cleaning Order 1', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 15, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (131, '2025-05-15 18:48:03.059235', '1', 'Cleaning Order 1', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 15, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (132, '2025-05-15 18:48:17.110214', '4', 'Lee Wai San', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 11, 1);
COMMIT;

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
BEGIN;
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (1, 'admin', 'logentry');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (3, 'auth', 'group');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (2, 'auth', 'permission');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (4, 'auth', 'user');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (5, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (18, 'management', 'admin');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (7, 'management', 'announcement');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (8, 'management', 'customer');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (9, 'management', 'income');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (10, 'management', 'item');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (19, 'management', 'orderitem');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (16, 'management', 'productorder');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (11, 'management', 'room');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (15, 'management', 'roomcleaningorder');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (13, 'management', 'roomreservation');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (14, 'management', 'roomusageorder');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (12, 'management', 'staff');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (17, 'management', 'userprofile');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (6, 'sessions', 'session');
COMMIT;

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
BEGIN;
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (1, 'contenttypes', '0001_initial', '2025-05-04 11:02:47.182779');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (2, 'auth', '0001_initial', '2025-05-04 11:02:47.242271');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (3, 'admin', '0001_initial', '2025-05-04 11:02:47.258861');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (4, 'admin', '0002_logentry_remove_auto_add', '2025-05-04 11:02:47.260614');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (5, 'admin', '0003_logentry_add_action_flag_choices', '2025-05-04 11:02:47.262278');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (6, 'contenttypes', '0002_remove_content_type_name', '2025-05-04 11:02:47.275697');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (7, 'auth', '0002_alter_permission_name_max_length', '2025-05-04 11:02:47.282117');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (8, 'auth', '0003_alter_user_email_max_length', '2025-05-04 11:02:47.287009');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (9, 'auth', '0004_alter_user_username_opts', '2025-05-04 11:02:47.288535');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (10, 'auth', '0005_alter_user_last_login_null', '2025-05-04 11:02:47.294465');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (11, 'auth', '0006_require_contenttypes_0002', '2025-05-04 11:02:47.294847');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (12, 'auth', '0007_alter_validators_add_error_messages', '2025-05-04 11:02:47.296269');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (13, 'auth', '0008_alter_user_username_max_length', '2025-05-04 11:02:47.304556');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (14, 'auth', '0009_alter_user_last_name_max_length', '2025-05-04 11:02:47.311655');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (15, 'auth', '0010_alter_group_name_max_length', '2025-05-04 11:02:47.315874');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (16, 'auth', '0011_update_proxy_permissions', '2025-05-04 11:02:47.318083');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (17, 'auth', '0012_alter_user_first_name_max_length', '2025-05-04 11:02:47.329692');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (18, 'management', '0001_initial', '2025-05-04 11:02:47.432251');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (19, 'sessions', '0001_initial', '2025-05-04 11:02:47.435876');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (20, 'management', '0002_staff_name', '2025-05-05 10:05:01.657407');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (21, 'management', '0003_rename_customerphone_roomusageorder_customer_and_more', '2025-05-05 19:44:04.572561');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (22, 'management', '0004_room_closed', '2025-05-05 19:46:13.225671');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (23, 'management', '0005_roomusageorder_status', '2025-05-05 19:54:56.735502');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (24, 'management', '0006_delete_roomreservation', '2025-05-05 21:33:03.577401');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (25, 'management', '0007_alter_roomusageorder_status', '2025-05-05 21:36:44.667867');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (26, 'management', '0008_announcement_image_item_image', '2025-05-05 21:41:43.464139');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (27, 'management', '0009_item_disabled', '2025-05-05 21:57:37.714895');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (28, 'management', '0010_alter_announcement_image_alter_item_image', '2025-05-06 00:21:36.541992');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (29, 'management', '0011_remove_productorder_itemid_and_more', '2025-05-06 00:21:36.626030');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (30, 'management', '0012_alter_productorder_staffid', '2025-05-06 00:23:22.867417');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (31, 'management', '0013_roomcleaningorder_status_alter_productorder_status', '2025-05-06 01:18:54.688641');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (32, 'management', '0014_alter_roomcleaningorder_staffid_and_more', '2025-05-15 15:12:07.576414');
COMMIT;

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of django_session
-- ----------------------------
BEGIN;
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES ('0llmxtcjsp0b2mwyxbz8it67xnv3g5rp', '.eJxVjMEOwiAQBf-FsyEgsIBH7_0GAgsrVQNJaU_Gf9cmPej1zcx7sRC3tYZtlCXMmV2YlOz0O6aIj9J2ku-x3TrH3tZlTnxX-EEHn3ouz-vh_h3UOOq3RqGTiSCkVUAAVluPLp0FZSQ0qJIqULQmrbKSEkGS8d4RWUCMTiF7fwAA-DhB:1uDtDf:FSsXuKXmZVtMK8GGBieDtYOdN-mGSUv4A08yzrW5Lqo', '2025-05-24 23:02:59.237404');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES ('3emse3jak10at5n5tks3iuyvosdfkldq', '.eJxVjEEOwiAQRe_C2hAoUBiX7j0DgZlBqoYmpV0Z765NutDtf-_9l4hpW2vcOi9xInEWWovT75gTPrjthO6p3WaJc1uXKctdkQft8joTPy-H-3dQU6_fWlkLwKyUD-CNHgsPUBSkwMNYSFF2WZFFRkJEB9phLi54GowBDMWK9wcDgTh6:1uDqwN:N_EusLCycv7Fs2TdRTCB835qtVbH_SAnKArzOyQoPHs', '2025-05-24 20:36:59.867700');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES ('5077jovjqcd2ejp2vcztp6uex9xd5i7y', '.eJxVjEEOwiAQRe_C2hAoUBiX7j0DgZlBqoYmpV0Z765NutDtf-_9l4hpW2vcOi9xInEWWovT75gTPrjthO6p3WaJc1uXKctdkQft8joTPy-H-3dQU6_fWlkLwKyUD-CNHgsPUBSkwMNYSFF2WZFFRkJEB9phLi54GowBDMWK9wcDgTh6:1uDqmA:nqU5YXqKBSBA9CHdoJowjoFor8ibPPzU9jbepgT3clM', '2025-05-24 20:26:26.174227');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES ('5l6c6o8fo8bu60n7osqao9wfqh5muz0d', '.eJxVjDsOwjAQBe_iGlnGv_VS0ucM1tre4ABypDipEHeHSCmgfTPzXiLStta4dV7iVMRFnMXpd0uUH9x2UO7UbrPMc1uXKcldkQftcpgLP6-H-3dQqddvrQEcGE5KQ2KrMRONAZxBj96S10guKOV0Nilby2BRsQ7oRyYVijfi_QG_fjb4:1uEa10:RFtZDYW2KlvZP7AuFr52kxOyzw6DnLevwzhxR9UDNX8', '2025-05-26 20:44:46.927780');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES ('6uh18d0bysqei2879negfz444tsnqc7u', '.eJxVjEEOwiAQRe_C2hAoUBiX7j0DgZlBqoYmpV0Z765NutDtf-_9l4hpW2vcOi9xInEWWovT75gTPrjthO6p3WaJc1uXKctdkQft8joTPy-H-3dQU6_fWlkLwKyUD-CNHgsPUBSkwMNYSFF2WZFFRkJEB9phLi54GowBDMWK9wcDgTh6:1uDqed:Fkrl6oY1hzawHlZLsGe1lpPArSjz8FdI8kzvN5LSma4', '2025-05-24 20:18:39.791316');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES ('97mb3u7ojuwljni4rork085n0943vw7o', '.eJxVjEEOwiAQRe_C2hAoUBiX7j0DgZlBqoYmpV0Z765NutDtf-_9l4hpW2vcOi9xInEWWovT75gTPrjthO6p3WaJc1uXKctdkQft8joTPy-H-3dQU6_fWlkLwKyUD-CNHgsPUBSkwMNYSFF2WZFFRkJEB9phLi54GowBDMWK9wcDgTh6:1uDqkA:txnulBWWf-gkpydfyy4Qy3msQGeuTX16GwTz-NRrImk', '2025-05-24 20:24:22.125343');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES ('97up0xg1nifnn70x6jjfs0ejrvfnzhjx', '.eJxVjEEOwiAQRe_C2hAoUBiX7j0DgZlBqoYmpV0Z765NutDtf-_9l4hpW2vcOi9xInEWWovT75gTPrjthO6p3WaJc1uXKctdkQft8joTPy-H-3dQU6_fWlkLwKyUD-CNHgsPUBSkwMNYSFF2WZFFRkJEB9phLi54GowBDMWK9wcDgTh6:1uDqeJ:jAsn847G6bwhZWSuGb4FN11TBDhMedmUXZ8EdKIRI1w', '2025-05-24 20:18:19.363594');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES ('auqi5yhbutmqq11glfzgcidyjmmmjw6d', '.eJxVjEEOwiAQRe_C2hAoUBiX7j0DgZlBqoYmpV0Z765NutDtf-_9l4hpW2vcOi9xInEWWovT75gTPrjthO6p3WaJc1uXKctdkQft8joTPy-H-3dQU6_fWlkLwKyUD-CNHgsPUBSkwMNYSFF2WZFFRkJEB9phLi54GowBDMWK9wcDgTh6:1uDqtx:dtDWEKryG9Q_cMjf7DgI0ZQwYVA5E95rPy0DuLj7IlU', '2025-05-24 20:34:29.043378');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES ('b6rkaad84466utavjnucfow122iv9d34', '.eJxVjEEOwiAQRe_C2hAoUBiX7j0DgZlBqoYmpV0Z765NutDtf-_9l4hpW2vcOi9xInEWWovT75gTPrjthO6p3WaJc1uXKctdkQft8joTPy-H-3dQU6_fWlkLwKyUD-CNHgsPUBSkwMNYSFF2WZFFRkJEB9phLi54GowBDMWK9wcDgTh6:1uDqWg:gcpcCEiKmqf-PVgGr3AGmRlbvg5e6LWDy1YrsfGMnkg', '2025-05-24 20:10:26.555058');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES ('b9qg269h9ltzcx8mjwa3xqu5w07ynbh7', '.eJxVjMEOwiAQBf-FsyEgsIBH7_0GAgsrVQNJaU_Gf9cmPej1zcx7sRC3tYZtlCXMmV2YlOz0O6aIj9J2ku-x3TrH3tZlTnxX-EEHn3ouz-vh_h3UOOq3RqGTiSCkVUAAVluPLp0FZSQ0qJIqULQmrbKSEkGS8d4RWUCMTiF7fwAA-DhB:1uDtH5:sBu4wy2UxwX6XHcIFAbNxheUYFnHA9z3FEYChX6kW38', '2025-05-24 23:06:31.542025');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES ('cu3z1s28m0bxj3mvmqhootpi944ct8ca', '.eJxVjEEOwiAQRe_C2hAoUBiX7j0DgZlBqoYmpV0Z765NutDtf-_9l4hpW2vcOi9xInEWWovT75gTPrjthO6p3WaJc1uXKctdkQft8joTPy-H-3dQU6_fWlkLwKyUD-CNHgsPUBSkwMNYSFF2WZFFRkJEB9phLi54GowBDMWK9wcDgTh6:1uDrDQ:2nr7nni3bpLtqGvQS5dad1wXdVeJV9u-ZD9A4mjmDUE', '2025-05-24 20:54:36.786016');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES ('dquplogsr7s2zaw7lwb2ixoit4y1ufyp', '.eJxVjEEOwiAQRe_C2hAoUBiX7j0DgZlBqoYmpV0Z765NutDtf-_9l4hpW2vcOi9xInEWWovT75gTPrjthO6p3WaJc1uXKctdkQft8joTPy-H-3dQU6_fWlkLwKyUD-CNHgsPUBSkwMNYSFF2WZFFRkJEB9phLi54GowBDMWK9wcDgTh6:1uDr1Q:fcESDfYeowOaqZ7QLmFfrLgujf7CVAlHf-AjhodpSUc', '2025-05-24 20:42:12.055200');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES ('dxfi53zbmtdo4cjl424h10doazzjsynn', '.eJxVjEEOwiAQRe_C2hAoUBiX7j0DgZlBqoYmpV0Z765NutDtf-_9l4hpW2vcOi9xInEWWovT75gTPrjthO6p3WaJc1uXKctdkQft8joTPy-H-3dQU6_fWlkLwKyUD-CNHgsPUBSkwMNYSFF2WZFFRkJEB9phLi54GowBDMWK9wcDgTh6:1uDr91:uyKvn3eejSbXv2xXzVgHYV0eOYSMeVj2ywBqZ6FhjzA', '2025-05-24 20:50:03.525237');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES ('ejmff2hzx3603mytwnlnebyj5elz263y', '.eJxVjEEOwiAQRe_C2hAoUBiX7j0DgZlBqoYmpV0Z765NutDtf-_9l4hpW2vcOi9xInEWWovT75gTPrjthO6p3WaJc1uXKctdkQft8joTPy-H-3dQU6_fWlkLwKyUD-CNHgsPUBSkwMNYSFF2WZFFRkJEB9phLi54GowBDMWK9wcDgTh6:1uDrAd:iek9b90XvPHjyeE7RdE9Z14njfopxBkCtyFkZbIr0P4', '2025-05-24 20:51:43.469508');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES ('g8qu9kzvyhz3o3s2wmx6ite8gznln1ia', '.eJxVjEEOwiAQRe_C2hAoUBiX7j0DgZlBqoYmpV0Z765NutDtf-_9l4hpW2vcOi9xInEWWovT75gTPrjthO6p3WaJc1uXKctdkQft8joTPy-H-3dQU6_fWlkLwKyUD-CNHgsPUBSkwMNYSFF2WZFFRkJEB9phLi54GowBDMWK9wcDgTh6:1uDqxO:vKs1IKXlxJDaroPdYAz0jSYbOlu9I3BmNa-rOGhNf9E', '2025-05-24 20:38:02.229616');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES ('geprjuvr42s1ur7vb0wqk3l78nwvco0j', '.eJxVjMEOwiAQBf-FsyEgsIBH7_0GAgsrVQNJaU_Gf9cmPej1zcx7sRC3tYZtlCXMmV2YlOz0O6aIj9J2ku-x3TrH3tZlTnxX-EEHn3ouz-vh_h3UOOq3RqGTiSCkVUAAVluPLp0FZSQ0qJIqULQmrbKSEkGS8d4RWUCMTiF7fwAA-DhB:1uDtHi:UIjmcKhRCfqtEnj-LPSUccilIFojDYFXdK3BWVD37vk', '2025-05-24 23:07:10.375434');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES ('gitcrgoggt7cmmtgni5pp3uq1jkm9wyb', '.eJxVjEEOwiAQRe_C2hAoUBiX7j0DgZlBqoYmpV0Z765NutDtf-_9l4hpW2vcOi9xInEWWovT75gTPrjthO6p3WaJc1uXKctdkQft8joTPy-H-3dQU6_fWlkLwKyUD-CNHgsPUBSkwMNYSFF2WZFFRkJEB9phLi54GowBDMWK9wcDgTh6:1uDqkY:NiE_O2STdp9pp7t4odSNZDhri75qMTN6njBXA4O9DDA', '2025-05-24 20:24:46.026996');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES ('gqd1ujhfpiygcaqu4igiaraftnnx2vfc', '.eJxVjEEOwiAQRe_C2hAoUBiX7j0DgZlBqoYmpV0Z765NutDtf-_9l4hpW2vcOi9xInEWWovT75gTPrjthO6p3WaJc1uXKctdkQft8joTPy-H-3dQU6_fWlkLwKyUD-CNHgsPUBSkwMNYSFF2WZFFRkJEB9phLi54GowBDMWK9wcDgTh6:1uDqvA:seVbX_MgV_5o6j9UPDJuWFAmXANGTbs9m7qvJ2PW78Y', '2025-05-24 20:35:44.263330');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES ('hd6jaai60o209vebnpud4lzamnc052ew', '.eJxVjMEOwiAQBf-FsyEgsIBH7_0GAgsrVQNJaU_Gf9cmPej1zcx7sRC3tYZtlCXMmV2YlOz0O6aIj9J2ku-x3TrH3tZlTnxX-EEHn3ouz-vh_h3UOOq3RqGTiSCkVUAAVluPLp0FZSQ0qJIqULQmrbKSEkGS8d4RWUCMTiF7fwAA-DhB:1uDtEo:eqyRlFEcdHUoW7JGdegMWzl04pZmV91hcfq3WBlyEeA', '2025-05-24 23:04:10.397183');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES ('hs1rtbyrydizl48j2bdqob5acfb8ztxc', '.eJxVjEEOwiAQRe_C2hCHkTK4dO8ZCDCDVA1NSrsy3l2bdKHb_977LxXiutSwdpnDyOqsANThd0wxP6RthO-x3Sadp7bMY9Kbonfa9XVieV529--gxl6_tWXhCF5EyonRYhmORCTEBgqSJ5dQnEHIbBiTzT7DkAC99S5bil69Px2WOCY:1uFdoG:BzflTu5cXyFcVnGYFv3X9ugUU1bOGa7oyI_UM6L2j-s', '2025-05-29 19:00:00.001737');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES ('idjo5h519xatgxme4695hd14yysa6djt', '.eJxVjMEOwiAQBf-FsyEgsIBH7_0GAgsrVQNJaU_Gf9cmPej1zcx7sRC3tYZtlCXMmV2YlOz0O6aIj9J2ku-x3TrH3tZlTnxX-EEHn3ouz-vh_h3UOOq3RqGTiSCkVUAAVluPLp0FZSQ0qJIqULQmrbKSEkGS8d4RWUCMTiF7fwAA-DhB:1uDt77:kERXJHr8DSz1rRlTlF-4l1BDtDQDz08UrqMiowvfTtA', '2025-05-24 22:56:13.594307');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES ('jgrhht9raqxrit5lxwrcue4vrpl1v7ok', '.eJxVjEEOwiAQRe_C2hAoUBiX7j0DgZlBqoYmpV0Z765NutDtf-_9l4hpW2vcOi9xInEWWovT75gTPrjthO6p3WaJc1uXKctdkQft8joTPy-H-3dQU6_fWlkLwKyUD-CNHgsPUBSkwMNYSFF2WZFFRkJEB9phLi54GowBDMWK9wcDgTh6:1uDqiy:8aEmpgFc6gmE33OGaS3Eogfxjhz3bv4IXi-gkZ9mDks', '2025-05-24 20:23:08.808545');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES ('k57t7rzv6wr2o2dw7ksmciqfjh0va6y1', '.eJxVjMEOwiAQBf-FsyEgsIBH7_0GAgsrVQNJaU_Gf9cmPej1zcx7sRC3tYZtlCXMmV2YlOz0O6aIj9J2ku-x3TrH3tZlTnxX-EEHn3ouz-vh_h3UOOq3RqGTiSCkVUAAVluPLp0FZSQ0qJIqULQmrbKSEkGS8d4RWUCMTiF7fwAA-DhB:1uDtOG:l7iGumStnlbQ5bYpCwHHzo31ST1UK9TGrzLRahZsdpM', '2025-05-24 23:13:56.002687');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES ('nt4mj10vuuer82b1yfhwm93447sperkt', '.eJxVjEEOwiAQRe_C2hAoUBiX7j0DgZlBqoYmpV0Z765NutDtf-_9l4hpW2vcOi9xInEWWovT75gTPrjthO6p3WaJc1uXKctdkQft8joTPy-H-3dQU6_fWlkLwKyUD-CNHgsPUBSkwMNYSFF2WZFFRkJEB9phLi54GowBDMWK9wcDgTh6:1uDrEe:BmczGiMo0Q8SJ9dMxBeRRHhUmJ3jfVPpxWaO1SqnzDs', '2025-05-24 20:55:52.783737');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES ('qi1yr22g6e3i9fc3pfeqmyw4ncbvbc60', '.eJxVjEEOwiAQRe_C2hAoUBiX7j0DgZlBqoYmpV0Z765NutDtf-_9l4hpW2vcOi9xInEWWovT75gTPrjthO6p3WaJc1uXKctdkQft8joTPy-H-3dQU6_fWlkLwKyUD-CNHgsPUBSkwMNYSFF2WZFFRkJEB9phLi54GowBDMWK9wcDgTh6:1uDqEK:1iodWRB4_HvEDc-xJWdLACdvlRGe7aiuo6FkH9Cj-ls', '2025-05-24 19:51:28.280098');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES ('saxx1b2rwrzoiawak36drp7mgr839zkm', '.eJxVjMEOwiAQBf-FsyEgsIBH7_0GAgsrVQNJaU_Gf9cmPej1zcx7sRC3tYZtlCXMmV2YlOz0O6aIj9J2ku-x3TrH3tZlTnxX-EEHn3ouz-vh_h3UOOq3RqGTiSCkVUAAVluPLp0FZSQ0qJIqULQmrbKSEkGS8d4RWUCMTiF7fwAA-DhB:1uDt8u:0sMuuJUFYs90QfJANcHoR1a0D4WUE052BDDkjZi1xZI', '2025-05-24 22:58:04.930251');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES ('sqrroflabffy5kxzi5w1ae4esw3ckvtg', '.eJxVjEEOwiAQRe_C2hAoUBiX7j0DgZlBqoYmpV0Z765NutDtf-_9l4hpW2vcOi9xInEWWovT75gTPrjthO6p3WaJc1uXKctdkQft8joTPy-H-3dQU6_fWlkLwKyUD-CNHgsPUBSkwMNYSFF2WZFFRkJEB9phLi54GowBDMWK9wcDgTh6:1uDszd:_HqNElw8nABCKN2l0U5FjvJ5GapIuHh_WnQp8opfMZo', '2025-05-24 22:48:29.318551');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES ('sxzh8gvftchqeypg8qtd7qqpstrit30q', '.eJxVjDsOwjAQBe_iGlnGv_VS0ucM1tre4ABypDipEHeHSCmgfTPzXiLStta4dV7iVMRFnMXpd0uUH9x2UO7UbrPMc1uXKcldkQftcpgLP6-H-3dQqddvrQEcGE5KQ2KrMRONAZxBj96S10guKOV0Nilby2BRsQ7oRyYVijfi_QG_fjb4:1uC3Oi:XIiBSIONG5b-d85MVO-KctIN9AOJxigpy5qzep-H19g', '2025-05-19 21:30:48.760281');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES ('tj9y06c2j83yf5scyw3ysc4w2lsmh3dq', '.eJxVjMEOwiAQBf-FsyEgsIBH7_0GAgsrVQNJaU_Gf9cmPej1zcx7sRC3tYZtlCXMmV2YlOz0O6aIj9J2ku-x3TrH3tZlTnxX-EEHn3ouz-vh_h3UOOq3RqGTiSCkVUAAVluPLp0FZSQ0qJIqULQmrbKSEkGS8d4RWUCMTiF7fwAA-DhB:1uEaEx:QqDFs1EkRhG_hltgPT_tUzkN7VDY5lMU3NG4zf3yBa8', '2025-05-26 20:59:11.009335');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES ('w1gpnk9nqqaktls0oswrd89vmlcxbtwh', '.eJxVjMEOwiAQBf-FsyEgsIBH7_0GAgsrVQNJaU_Gf9cmPej1zcx7sRC3tYZtlCXMmV2YlOz0O6aIj9J2ku-x3TrH3tZlTnxX-EEHn3ouz-vh_h3UOOq3RqGTiSCkVUAAVluPLp0FZSQ0qJIqULQmrbKSEkGS8d4RWUCMTiF7fwAA-DhB:1uE0If:XxblCJyw4E-BZHYovxaa_INkMtBzTdEYAiuUigRAycA', '2025-05-25 06:36:37.227382');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES ('wdzkaswzuiemtmim5nddb0t509203w08', '.eJxVjMEOwiAQBf-FsyEgsIBH7_0GAgsrVQNJaU_Gf9cmPej1zcx7sRC3tYZtlCXMmV2YlOz0O6aIj9J2ku-x3TrH3tZlTnxX-EEHn3ouz-vh_h3UOOq3RqGTiSCkVUAAVluPLp0FZSQ0qJIqULQmrbKSEkGS8d4RWUCMTiF7fwAA-DhB:1uFbs2:_bZsuHKGRWiR5HXGIN8Djup0xfcEzAfDVwIDQxNYzAc', '2025-05-29 16:55:46.242509');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES ('wuef8s9tzk1nsk3rqi1bxy0i0px48yh4', '.eJxVjMEOwiAQBf-FsyEgsIBH7_0GAgsrVQNJaU_Gf9cmPej1zcx7sRC3tYZtlCXMmV2YlOz0O6aIj9J2ku-x3TrH3tZlTnxX-EEHn3ouz-vh_h3UOOq3RqGTiSCkVUAAVluPLp0FZSQ0qJIqULQmrbKSEkGS8d4RWUCMTiF7fwAA-DhB:1uE0MX:5g85KDZmtHc5IMNZqt7stZCurFMNK4vSnAM3x5C0RAo', '2025-05-25 06:40:37.769940');
COMMIT;

-- ----------------------------
-- Table structure for management_admin
-- ----------------------------
DROP TABLE IF EXISTS `management_admin`;
CREATE TABLE `management_admin` (
  `AdminID` int NOT NULL AUTO_INCREMENT,
  `AccessLevel` int NOT NULL,
  `profile_id` bigint NOT NULL,
  PRIMARY KEY (`AdminID`),
  UNIQUE KEY `profile_id` (`profile_id`),
  CONSTRAINT `management_admin_profile_id_bca1689a_fk_managemen` FOREIGN KEY (`profile_id`) REFERENCES `management_userprofile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of management_admin
-- ----------------------------
BEGIN;
INSERT INTO `management_admin` (`AdminID`, `AccessLevel`, `profile_id`) VALUES (1, 1, 1);
COMMIT;

-- ----------------------------
-- Table structure for management_announcement
-- ----------------------------
DROP TABLE IF EXISTS `management_announcement`;
CREATE TABLE `management_announcement` (
  `AnnouncementID` int NOT NULL AUTO_INCREMENT,
  `Content` longtext NOT NULL,
  `Image` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`AnnouncementID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of management_announcement
-- ----------------------------
BEGIN;
INSERT INTO `management_announcement` (`AnnouncementID`, `Content`, `Image`) VALUES (1, '本店新增茶饮服务，欢迎体验！', '/media/index1.avif');
INSERT INTO `management_announcement` (`AnnouncementID`, `Content`, `Image`) VALUES (3, '会员充值送豪礼，详情咨询店员。', '/media/index2.jpeg');
INSERT INTO `management_announcement` (`AnnouncementID`, `Content`, `Image`) VALUES (4, '感谢您的支持，祝您愉快！', '/media/index3.jpg');
INSERT INTO `management_announcement` (`AnnouncementID`, `Content`, `Image`) VALUES (5, '这个是一个测试公告', '');
COMMIT;

-- ----------------------------
-- Table structure for management_customer
-- ----------------------------
DROP TABLE IF EXISTS `management_customer`;
CREATE TABLE `management_customer` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `PhoneNumber` varchar(15) NOT NULL,
  `AccountBalance` decimal(10,2) NOT NULL,
  `RoomUsageStatus` int NOT NULL,
  `BlacklistStatus` tinyint(1) NOT NULL,
  `profile_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `PhoneNumber` (`PhoneNumber`),
  UNIQUE KEY `profile_id` (`profile_id`),
  CONSTRAINT `management_customer_profile_id_2fe0a923_fk_managemen` FOREIGN KEY (`profile_id`) REFERENCES `management_userprofile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of management_customer
-- ----------------------------
BEGIN;
INSERT INTO `management_customer` (`id`, `PhoneNumber`, `AccountBalance`, `RoomUsageStatus`, `BlacklistStatus`, `profile_id`) VALUES (1, '13811111111', 50.00, 0, 1, 8);
INSERT INTO `management_customer` (`id`, `PhoneNumber`, `AccountBalance`, `RoomUsageStatus`, `BlacklistStatus`, `profile_id`) VALUES (2, '13822222222', 204.00, 0, 0, 9);
INSERT INTO `management_customer` (`id`, `PhoneNumber`, `AccountBalance`, `RoomUsageStatus`, `BlacklistStatus`, `profile_id`) VALUES (3, '13833333333', 70.00, 0, 0, 10);
INSERT INTO `management_customer` (`id`, `PhoneNumber`, `AccountBalance`, `RoomUsageStatus`, `BlacklistStatus`, `profile_id`) VALUES (4, '13844444444', 130.00, 1, 0, 11);
INSERT INTO `management_customer` (`id`, `PhoneNumber`, `AccountBalance`, `RoomUsageStatus`, `BlacklistStatus`, `profile_id`) VALUES (5, '13855555555', 0.00, 0, 1, 12);
COMMIT;

-- ----------------------------
-- Table structure for management_income
-- ----------------------------
DROP TABLE IF EXISTS `management_income`;
CREATE TABLE `management_income` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `total_income` decimal(12,2) NOT NULL,
  `item_income` decimal(12,2) NOT NULL,
  `room_income` decimal(12,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `date` (`date`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of management_income
-- ----------------------------
BEGIN;
INSERT INTO `management_income` (`id`, `date`, `total_income`, `item_income`, `room_income`) VALUES (1, '2015-11-04', 0.00, 0.00, 0.00);
INSERT INTO `management_income` (`id`, `date`, `total_income`, `item_income`, `room_income`) VALUES (2, '2005-05-30', 37.09, 5.00, 32.09);
INSERT INTO `management_income` (`id`, `date`, `total_income`, `item_income`, `room_income`) VALUES (3, '2010-01-27', 119.54, 9.54, 110.00);
INSERT INTO `management_income` (`id`, `date`, `total_income`, `item_income`, `room_income`) VALUES (4, '2025-04-25', 861.38, 61.38, 800.00);
INSERT INTO `management_income` (`id`, `date`, `total_income`, `item_income`, `room_income`) VALUES (5, '2025-04-26', 715.24, 115.24, 600.00);
INSERT INTO `management_income` (`id`, `date`, `total_income`, `item_income`, `room_income`) VALUES (6, '2025-04-28', 548.29, 300.00, 248.29);
INSERT INTO `management_income` (`id`, `date`, `total_income`, `item_income`, `room_income`) VALUES (7, '2025-04-29', 273.35, 73.00, 200.55);
INSERT INTO `management_income` (`id`, `date`, `total_income`, `item_income`, `room_income`) VALUES (8, '2025-04-30', 706.23, 106.23, 600.00);
INSERT INTO `management_income` (`id`, `date`, `total_income`, `item_income`, `room_income`) VALUES (9, '2025-05-01', 832.03, 132.03, 700.00);
INSERT INTO `management_income` (`id`, `date`, `total_income`, `item_income`, `room_income`) VALUES (10, '2025-05-02', 838.58, 138.00, 700.58);
COMMIT;

-- ----------------------------
-- Table structure for management_item
-- ----------------------------
DROP TABLE IF EXISTS `management_item`;
CREATE TABLE `management_item` (
  `ItemID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Price` decimal(10,2) NOT NULL,
  `Quantity` int NOT NULL,
  `Description` longtext NOT NULL,
  `Image` varchar(100) DEFAULT NULL,
  `Disabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`ItemID`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of management_item
-- ----------------------------
BEGIN;
INSERT INTO `management_item` (`ItemID`, `Name`, `Price`, `Quantity`, `Description`, `Image`, `Disabled`) VALUES (1, '矿泉水', 3.00, 100, '清凉解渴水', '/media/water.jpeg', 0);
INSERT INTO `management_item` (`ItemID`, `Name`, `Price`, `Quantity`, `Description`, `Image`, `Disabled`) VALUES (2, '可乐', 5.00, 50, '冰爽可乐，适合聚会饮用', '', 0);
INSERT INTO `management_item` (`ItemID`, `Name`, `Price`, `Quantity`, `Description`, `Image`, `Disabled`) VALUES (3, '橙汁', 8.00, 30, '新鲜橙汁，富含维生素C', '', 0);
INSERT INTO `management_item` (`ItemID`, `Name`, `Price`, `Quantity`, `Description`, `Image`, `Disabled`) VALUES (4, '绿茶', 6.00, 40, '清香绿茶，提神醒脑', '', 0);
INSERT INTO `management_item` (`ItemID`, `Name`, `Price`, `Quantity`, `Description`, `Image`, `Disabled`) VALUES (5, '啤酒', 9.00, 70, '冰镇啤酒，麻将房畅饮必备', '/media/bear.jpeg', 0);
INSERT INTO `management_item` (`ItemID`, `Name`, `Price`, `Quantity`, `Description`, `Image`, `Disabled`) VALUES (7, '扑克牌', 3.00, 6, '一副扑克牌', '/media/test.jpeg', 0);
INSERT INTO `management_item` (`ItemID`, `Name`, `Price`, `Quantity`, `Description`, `Image`, `Disabled`) VALUES (17, '纸巾', 1.00, 200, '必需品', '/media/tissue_eNbBUxn.jpeg', 0);
COMMIT;

-- ----------------------------
-- Table structure for management_orderitem
-- ----------------------------
DROP TABLE IF EXISTS `management_orderitem`;
CREATE TABLE `management_orderitem` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `Quantity` int unsigned NOT NULL,
  `Item_id` int NOT NULL,
  `ProductOrder_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `management_orderitem_Item_id_acba282f_fk_management_item_ItemID` (`Item_id`),
  KEY `management_orderitem_ProductOrder_id_bc7f3b30_fk_managemen` (`ProductOrder_id`),
  CONSTRAINT `management_orderitem_Item_id_acba282f_fk_management_item_ItemID` FOREIGN KEY (`Item_id`) REFERENCES `management_item` (`ItemID`),
  CONSTRAINT `management_orderitem_ProductOrder_id_bc7f3b30_fk_managemen` FOREIGN KEY (`ProductOrder_id`) REFERENCES `management_productorder` (`OrderID`),
  CONSTRAINT `management_orderitem_chk_1` CHECK ((`Quantity` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of management_orderitem
-- ----------------------------
BEGIN;
INSERT INTO `management_orderitem` (`id`, `Quantity`, `Item_id`, `ProductOrder_id`) VALUES (1, 1, 1, 1);
INSERT INTO `management_orderitem` (`id`, `Quantity`, `Item_id`, `ProductOrder_id`) VALUES (2, 2, 2, 1);
INSERT INTO `management_orderitem` (`id`, `Quantity`, `Item_id`, `ProductOrder_id`) VALUES (3, 5, 5, 2);
INSERT INTO `management_orderitem` (`id`, `Quantity`, `Item_id`, `ProductOrder_id`) VALUES (4, 1, 7, 2);
INSERT INTO `management_orderitem` (`id`, `Quantity`, `Item_id`, `ProductOrder_id`) VALUES (5, 1, 17, 2);
INSERT INTO `management_orderitem` (`id`, `Quantity`, `Item_id`, `ProductOrder_id`) VALUES (6, 1, 3, 3);
INSERT INTO `management_orderitem` (`id`, `Quantity`, `Item_id`, `ProductOrder_id`) VALUES (7, 3, 4, 3);
INSERT INTO `management_orderitem` (`id`, `Quantity`, `Item_id`, `ProductOrder_id`) VALUES (8, 1, 7, 4);
COMMIT;

-- ----------------------------
-- Table structure for management_productorder
-- ----------------------------
DROP TABLE IF EXISTS `management_productorder`;
CREATE TABLE `management_productorder` (
  `OrderID` int NOT NULL AUTO_INCREMENT,
  `OrderTime` datetime(6) DEFAULT NULL,
  `Status` int NOT NULL,
  `CustomerPhone_id` bigint NOT NULL,
  `StaffID_id` int DEFAULT NULL,
  PRIMARY KEY (`OrderID`),
  KEY `management_productor_CustomerPhone_id_1481f9eb_fk_managemen` (`CustomerPhone_id`),
  KEY `management_productor_StaffID_id_b094e05e_fk_managemen` (`StaffID_id`),
  CONSTRAINT `management_productor_CustomerPhone_id_1481f9eb_fk_managemen` FOREIGN KEY (`CustomerPhone_id`) REFERENCES `management_customer` (`id`),
  CONSTRAINT `management_productor_StaffID_id_b094e05e_fk_managemen` FOREIGN KEY (`StaffID_id`) REFERENCES `management_staff` (`StaffID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of management_productorder
-- ----------------------------
BEGIN;
INSERT INTO `management_productorder` (`OrderID`, `OrderTime`, `Status`, `CustomerPhone_id`, `StaffID_id`) VALUES (1, '2025-05-06 00:22:18.000000', 1, 1, NULL);
INSERT INTO `management_productorder` (`OrderID`, `OrderTime`, `Status`, `CustomerPhone_id`, `StaffID_id`) VALUES (2, '2025-05-06 00:23:43.000000', 0, 2, NULL);
INSERT INTO `management_productorder` (`OrderID`, `OrderTime`, `Status`, `CustomerPhone_id`, `StaffID_id`) VALUES (3, '2025-05-06 00:23:53.000000', 0, 3, NULL);
INSERT INTO `management_productorder` (`OrderID`, `OrderTime`, `Status`, `CustomerPhone_id`, `StaffID_id`) VALUES (4, '2025-05-11 04:17:30.795846', 0, 2, NULL);
COMMIT;

-- ----------------------------
-- Table structure for management_room
-- ----------------------------
DROP TABLE IF EXISTS `management_room`;
CREATE TABLE `management_room` (
  `RoomID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Price` decimal(10,2) NOT NULL,
  `Description` longtext NOT NULL,
  `Status` int NOT NULL,
  `Closed` tinyint(1) NOT NULL,
  PRIMARY KEY (`RoomID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of management_room
-- ----------------------------
BEGIN;
INSERT INTO `management_room` (`RoomID`, `Name`, `Price`, `Description`, `Status`, `Closed`) VALUES (2, 'Carmen Russ', 335.38, '房间9', 1, 0);
INSERT INTO `management_room` (`RoomID`, `Name`, `Price`, `Description`, `Status`, `Closed`) VALUES (3, 'Ichikawa Hana', 9.49, '房间8', 2, 0);
INSERT INTO `management_room` (`RoomID`, `Name`, `Price`, `Description`, `Status`, `Closed`) VALUES (4, 'Lee Wai San', 8.18, '房间7', 3, 0);
INSERT INTO `management_room` (`RoomID`, `Name`, `Price`, `Description`, `Status`, `Closed`) VALUES (5, 'Mo Yuning', 7.08, '房间6', 0, 0);
INSERT INTO `management_room` (`RoomID`, `Name`, `Price`, `Description`, `Status`, `Closed`) VALUES (6, 'Li Xiaoming', 698.02, '房间5', 1, 0);
INSERT INTO `management_room` (`RoomID`, `Name`, `Price`, `Description`, `Status`, `Closed`) VALUES (7, 'Fujiwara Ayano', 6.46, '房间4', 0, 0);
INSERT INTO `management_room` (`RoomID`, `Name`, `Price`, `Description`, `Status`, `Closed`) VALUES (8, 'Valerie Wagner', 2.80, '房间3', 0, 0);
INSERT INTO `management_room` (`RoomID`, `Name`, `Price`, `Description`, `Status`, `Closed`) VALUES (9, 'Aaron Kelley', 6.79, '房间1', 0, 0);
INSERT INTO `management_room` (`RoomID`, `Name`, `Price`, `Description`, `Status`, `Closed`) VALUES (10, 'Murakami Ryota', 31.71, '房间2', 0, 0);
INSERT INTO `management_room` (`RoomID`, `Name`, `Price`, `Description`, `Status`, `Closed`) VALUES (11, 'test', 1334.10, 'testroom', 0, 0);
COMMIT;

-- ----------------------------
-- Table structure for management_roomcleaningorder
-- ----------------------------
DROP TABLE IF EXISTS `management_roomcleaningorder`;
CREATE TABLE `management_roomcleaningorder` (
  `CleaningID` int NOT NULL AUTO_INCREMENT,
  `CleaningTime` datetime(6) NOT NULL,
  `RoomID_id` int NOT NULL,
  `StaffID_id` int DEFAULT NULL,
  `Status` int NOT NULL,
  PRIMARY KEY (`CleaningID`),
  KEY `management_roomclean_RoomID_id_d6f56b1e_fk_managemen` (`RoomID_id`),
  KEY `management_roomclean_StaffID_id_c8cbb568_fk_managemen` (`StaffID_id`),
  CONSTRAINT `management_roomclean_RoomID_id_d6f56b1e_fk_managemen` FOREIGN KEY (`RoomID_id`) REFERENCES `management_room` (`RoomID`),
  CONSTRAINT `management_roomclean_StaffID_id_c8cbb568_fk_managemen` FOREIGN KEY (`StaffID_id`) REFERENCES `management_staff` (`StaffID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of management_roomcleaningorder
-- ----------------------------
BEGIN;
INSERT INTO `management_roomcleaningorder` (`CleaningID`, `CleaningTime`, `RoomID_id`, `StaffID_id`, `Status`) VALUES (1, '2025-05-06 01:21:38.776568', 4, NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for management_roomusageorder
-- ----------------------------
DROP TABLE IF EXISTS `management_roomusageorder`;
CREATE TABLE `management_roomusageorder` (
  `UsageID` int NOT NULL AUTO_INCREMENT,
  `EndTime` datetime(6) NOT NULL,
  `DurationTime` int NOT NULL,
  `Customer_id` bigint NOT NULL,
  `Room_id` int NOT NULL,
  `StartTime` datetime(6) NOT NULL,
  `Status` int NOT NULL,
  PRIMARY KEY (`UsageID`),
  KEY `management_roomusage_Customer_id_aea4df51_fk_managemen` (`Customer_id`),
  KEY `management_roomusage_Room_id_61ba9f82_fk_managemen` (`Room_id`),
  CONSTRAINT `management_roomusage_Customer_id_aea4df51_fk_managemen` FOREIGN KEY (`Customer_id`) REFERENCES `management_customer` (`id`),
  CONSTRAINT `management_roomusage_Room_id_61ba9f82_fk_managemen` FOREIGN KEY (`Room_id`) REFERENCES `management_room` (`RoomID`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of management_roomusageorder
-- ----------------------------
BEGIN;
INSERT INTO `management_roomusageorder` (`UsageID`, `EndTime`, `DurationTime`, `Customer_id`, `Room_id`, `StartTime`, `Status`) VALUES (1, '2025-05-05 23:02:06.000000', 120, 1, 2, '2025-05-05 21:02:06.000000', 0);
INSERT INTO `management_roomusageorder` (`UsageID`, `EndTime`, `DurationTime`, `Customer_id`, `Room_id`, `StartTime`, `Status`) VALUES (2, '2025-05-05 23:03:19.000000', 90, 2, 3, '2025-05-05 21:33:19.000000', 2);
INSERT INTO `management_roomusageorder` (`UsageID`, `EndTime`, `DurationTime`, `Customer_id`, `Room_id`, `StartTime`, `Status`) VALUES (3, '2025-05-05 22:04:00.000000', 30, 1, 4, '2025-05-05 21:34:00.000000', 2);
INSERT INTO `management_roomusageorder` (`UsageID`, `EndTime`, `DurationTime`, `Customer_id`, `Room_id`, `StartTime`, `Status`) VALUES (4, '2025-05-06 00:57:25.000000', 200, 4, 6, '2025-05-05 21:37:25.000000', 0);
INSERT INTO `management_roomusageorder` (`UsageID`, `EndTime`, `DurationTime`, `Customer_id`, `Room_id`, `StartTime`, `Status`) VALUES (5, '2025-05-06 00:38:20.000000', 180, 3, 7, '2025-05-05 21:38:20.000000', 3);
INSERT INTO `management_roomusageorder` (`UsageID`, `EndTime`, `DurationTime`, `Customer_id`, `Room_id`, `StartTime`, `Status`) VALUES (17, '2025-05-15 09:00:00.000000', 60, 2, 5, '2025-05-15 08:00:00.000000', 3);
INSERT INTO `management_roomusageorder` (`UsageID`, `EndTime`, `DurationTime`, `Customer_id`, `Room_id`, `StartTime`, `Status`) VALUES (18, '2025-05-15 09:00:00.000000', 60, 2, 5, '2025-05-15 08:00:00.000000', 3);
INSERT INTO `management_roomusageorder` (`UsageID`, `EndTime`, `DurationTime`, `Customer_id`, `Room_id`, `StartTime`, `Status`) VALUES (19, '2025-05-15 09:00:00.000000', 60, 2, 5, '2025-05-15 08:00:00.000000', 3);
INSERT INTO `management_roomusageorder` (`UsageID`, `EndTime`, `DurationTime`, `Customer_id`, `Room_id`, `StartTime`, `Status`) VALUES (20, '2025-05-15 11:00:00.000000', 180, 2, 8, '2025-05-15 08:00:00.000000', 3);
COMMIT;

-- ----------------------------
-- Table structure for management_staff
-- ----------------------------
DROP TABLE IF EXISTS `management_staff`;
CREATE TABLE `management_staff` (
  `StaffID` int NOT NULL AUTO_INCREMENT,
  `Status` int NOT NULL,
  `profile_id` bigint NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`StaffID`),
  UNIQUE KEY `profile_id` (`profile_id`),
  CONSTRAINT `management_staff_profile_id_ae3d02ff_fk_managemen` FOREIGN KEY (`profile_id`) REFERENCES `management_userprofile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of management_staff
-- ----------------------------
BEGIN;
INSERT INTO `management_staff` (`StaffID`, `Status`, `profile_id`, `name`) VALUES (1, 1, 2, '01号员工');
INSERT INTO `management_staff` (`StaffID`, `Status`, `profile_id`, `name`) VALUES (2, 0, 3, '02号员工');
INSERT INTO `management_staff` (`StaffID`, `Status`, `profile_id`, `name`) VALUES (3, 0, 4, '03号员工');
INSERT INTO `management_staff` (`StaffID`, `Status`, `profile_id`, `name`) VALUES (4, 1, 5, '04号员工');
COMMIT;

-- ----------------------------
-- Table structure for management_userprofile
-- ----------------------------
DROP TABLE IF EXISTS `management_userprofile`;
CREATE TABLE `management_userprofile` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `role` varchar(10) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `management_userprofile_user_id_3e317d27_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of management_userprofile
-- ----------------------------
BEGIN;
INSERT INTO `management_userprofile` (`id`, `role`, `user_id`) VALUES (1, 'admin', 1);
INSERT INTO `management_userprofile` (`id`, `role`, `user_id`) VALUES (2, 'staff', 2);
INSERT INTO `management_userprofile` (`id`, `role`, `user_id`) VALUES (3, 'staff', 3);
INSERT INTO `management_userprofile` (`id`, `role`, `user_id`) VALUES (4, 'staff', 4);
INSERT INTO `management_userprofile` (`id`, `role`, `user_id`) VALUES (5, 'staff', 5);
INSERT INTO `management_userprofile` (`id`, `role`, `user_id`) VALUES (8, 'customer', 10);
INSERT INTO `management_userprofile` (`id`, `role`, `user_id`) VALUES (9, 'customer', 11);
INSERT INTO `management_userprofile` (`id`, `role`, `user_id`) VALUES (10, 'customer', 12);
INSERT INTO `management_userprofile` (`id`, `role`, `user_id`) VALUES (11, 'customer', 13);
INSERT INTO `management_userprofile` (`id`, `role`, `user_id`) VALUES (12, 'customer', 14);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
