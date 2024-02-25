/*
 Navicat Premium Data Transfer

 Source Server         : 本地连接
 Source Server Type    : MySQL
 Source Server Version : 50723
 Source Host           : localhost:3306
 Source Schema         : stu-room

 Target Server Type    : MySQL
 Target Server Version : 50723
 File Encoding         : 65001

 Date: 24/09/2022 12:38:43
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for apply_change
-- ----------------------------
DROP TABLE IF EXISTS `apply_change`;
CREATE TABLE `apply_change`  (
  `apply_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '调换id',
  `apply_user_id` int(11) NULL DEFAULT NULL COMMENT '申请人id',
  `apply_user_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '申请人姓名',
  `apply_bed_id` int(11) NULL DEFAULT NULL COMMENT '申请人床位id',
  `apply_bed_code` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '申请人床位编号',
  `change_user_id` int(11) NULL DEFAULT NULL COMMENT '调换人id',
  `change_user_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '调换人姓名',
  `change_bed_id` int(11) NULL DEFAULT NULL COMMENT '调换人的床位id',
  `change_bed_code` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '调换人的床位编号',
  `status` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '0：待审核 1：审核通过 2：拒绝',
  PRIMARY KEY (`apply_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of apply_change
-- ----------------------------
INSERT INTO `apply_change` VALUES (3, 8, '李四', 44, 'A103-2', 14, '张明华', 45, 'A103-3', '1');

-- ----------------------------
-- Table structure for assign_bed
-- ----------------------------
DROP TABLE IF EXISTS `assign_bed`;
CREATE TABLE `assign_bed`  (
  `assign_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `bed_id` int(11) NULL DEFAULT NULL COMMENT '床位id',
  `class_id` int(11) NULL DEFAULT NULL COMMENT '班级id',
  PRIMARY KEY (`assign_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 217 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of assign_bed
-- ----------------------------
INSERT INTO `assign_bed` VALUES (151, 40, 1);
INSERT INTO `assign_bed` VALUES (152, 133, 1);
INSERT INTO `assign_bed` VALUES (153, 136, 1);
INSERT INTO `assign_bed` VALUES (154, 137, 1);
INSERT INTO `assign_bed` VALUES (155, 138, 1);
INSERT INTO `assign_bed` VALUES (156, 139, 1);
INSERT INTO `assign_bed` VALUES (161, 770, 10);
INSERT INTO `assign_bed` VALUES (162, 771, 10);
INSERT INTO `assign_bed` VALUES (163, 772, 10);
INSERT INTO `assign_bed` VALUES (164, 791, 12);
INSERT INTO `assign_bed` VALUES (165, 792, 12);
INSERT INTO `assign_bed` VALUES (166, 793, 12);
INSERT INTO `assign_bed` VALUES (167, 794, 12);
INSERT INTO `assign_bed` VALUES (168, 644, 11);
INSERT INTO `assign_bed` VALUES (169, 645, 11);
INSERT INTO `assign_bed` VALUES (170, 646, 11);
INSERT INTO `assign_bed` VALUES (171, 647, 11);
INSERT INTO `assign_bed` VALUES (172, 648, 11);
INSERT INTO `assign_bed` VALUES (173, 649, 11);
INSERT INTO `assign_bed` VALUES (174, 604, 2);
INSERT INTO `assign_bed` VALUES (175, 605, 2);
INSERT INTO `assign_bed` VALUES (176, 606, 2);
INSERT INTO `assign_bed` VALUES (177, 607, 2);
INSERT INTO `assign_bed` VALUES (178, 795, 3);
INSERT INTO `assign_bed` VALUES (179, 796, 3);
INSERT INTO `assign_bed` VALUES (180, 797, 3);
INSERT INTO `assign_bed` VALUES (181, 798, 3);
INSERT INTO `assign_bed` VALUES (182, 799, 3);
INSERT INTO `assign_bed` VALUES (183, 800, 3);
INSERT INTO `assign_bed` VALUES (184, 801, 3);
INSERT INTO `assign_bed` VALUES (185, 802, 3);
INSERT INTO `assign_bed` VALUES (186, 803, 5);
INSERT INTO `assign_bed` VALUES (187, 804, 5);
INSERT INTO `assign_bed` VALUES (188, 805, 5);
INSERT INTO `assign_bed` VALUES (189, 806, 5);
INSERT INTO `assign_bed` VALUES (190, 650, 6);
INSERT INTO `assign_bed` VALUES (191, 651, 6);
INSERT INTO `assign_bed` VALUES (192, 652, 6);
INSERT INTO `assign_bed` VALUES (193, 653, 6);
INSERT INTO `assign_bed` VALUES (194, 654, 6);
INSERT INTO `assign_bed` VALUES (195, 655, 6);
INSERT INTO `assign_bed` VALUES (196, 608, 8);
INSERT INTO `assign_bed` VALUES (197, 609, 8);
INSERT INTO `assign_bed` VALUES (198, 773, 4);
INSERT INTO `assign_bed` VALUES (199, 774, 9);
INSERT INTO `assign_bed` VALUES (200, 775, 9);
INSERT INTO `assign_bed` VALUES (201, 140, 10);
INSERT INTO `assign_bed` VALUES (202, 141, 10);
INSERT INTO `assign_bed` VALUES (203, 142, 10);
INSERT INTO `assign_bed` VALUES (204, 143, 10);
INSERT INTO `assign_bed` VALUES (205, 144, 10);
INSERT INTO `assign_bed` VALUES (206, 145, 10);
INSERT INTO `assign_bed` VALUES (207, 524, 5);
INSERT INTO `assign_bed` VALUES (208, 525, 5);
INSERT INTO `assign_bed` VALUES (209, 526, 5);
INSERT INTO `assign_bed` VALUES (210, 527, 5);
INSERT INTO `assign_bed` VALUES (211, 528, 5);
INSERT INTO `assign_bed` VALUES (212, 529, 5);
INSERT INTO `assign_bed` VALUES (213, 530, 5);
INSERT INTO `assign_bed` VALUES (214, 531, 5);
INSERT INTO `assign_bed` VALUES (215, 776, 7);
INSERT INTO `assign_bed` VALUES (216, 777, 4);

-- ----------------------------
-- Table structure for dorm_room
-- ----------------------------
DROP TABLE IF EXISTS `dorm_room`;
CREATE TABLE `dorm_room`  (
  `room_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '宿舍id',
  `storey_id` int(11) NULL DEFAULT NULL COMMENT '层数id',
  `root_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '宿舍编号 1:1人间 2：2人间 4:4人间  6:6人间',
  `room_code` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '宿舍编号',
  `total_bed` int(11) NULL DEFAULT NULL COMMENT '容纳人数',
  PRIMARY KEY (`room_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 259 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dorm_room
-- ----------------------------
INSERT INTO `dorm_room` VALUES (38, 17, '6', 'A101', 6);
INSERT INTO `dorm_room` VALUES (39, 17, '2', 'A102', 2);
INSERT INTO `dorm_room` VALUES (40, 17, '6', 'A103', 6);
INSERT INTO `dorm_room` VALUES (41, 17, '2', 'A104', 2);
INSERT INTO `dorm_room` VALUES (43, 18, '4', 'B101', 4);
INSERT INTO `dorm_room` VALUES (44, 18, '4', 'B102', 4);
INSERT INTO `dorm_room` VALUES (45, 18, '4', 'B103', 4);
INSERT INTO `dorm_room` VALUES (46, 18, '4', 'B104', 4);
INSERT INTO `dorm_room` VALUES (47, 18, '4', 'B105', 4);
INSERT INTO `dorm_room` VALUES (48, 18, '4', 'B106', 4);
INSERT INTO `dorm_room` VALUES (49, 18, '4', 'B107', 4);
INSERT INTO `dorm_room` VALUES (50, 18, '4', 'B108', 4);
INSERT INTO `dorm_room` VALUES (51, 18, '4', 'B109', 4);
INSERT INTO `dorm_room` VALUES (52, 18, '4', 'B110', 4);
INSERT INTO `dorm_room` VALUES (53, 18, '4', 'B111', 4);
INSERT INTO `dorm_room` VALUES (54, 18, '4', 'B112', 4);
INSERT INTO `dorm_room` VALUES (55, 18, '4', 'B113', 4);
INSERT INTO `dorm_room` VALUES (56, 18, '4', 'B114', 4);
INSERT INTO `dorm_room` VALUES (57, 18, '4', 'B115', 4);
INSERT INTO `dorm_room` VALUES (58, 18, '4', 'B116', 4);
INSERT INTO `dorm_room` VALUES (59, 18, '4', 'B117', 4);
INSERT INTO `dorm_room` VALUES (60, 18, '4', 'B118', 4);
INSERT INTO `dorm_room` VALUES (61, 18, '4', 'B119', 4);
INSERT INTO `dorm_room` VALUES (62, 18, '4', 'B120', 4);
INSERT INTO `dorm_room` VALUES (63, 22, '6', 'C10001', 6);
INSERT INTO `dorm_room` VALUES (64, 22, '6', 'C10002', 6);
INSERT INTO `dorm_room` VALUES (65, 22, '6', 'C10003', 6);
INSERT INTO `dorm_room` VALUES (66, 22, '6', 'C10004', 6);
INSERT INTO `dorm_room` VALUES (67, 22, '6', 'C10005', 6);
INSERT INTO `dorm_room` VALUES (68, 22, '6', 'C10006', 6);
INSERT INTO `dorm_room` VALUES (69, 22, '6', 'C10007', 6);
INSERT INTO `dorm_room` VALUES (70, 22, '6', 'C10008', 6);
INSERT INTO `dorm_room` VALUES (71, 22, '6', 'C10009', 6);
INSERT INTO `dorm_room` VALUES (72, 22, '6', 'C10010', 6);
INSERT INTO `dorm_room` VALUES (73, 22, '6', 'C10011', 6);
INSERT INTO `dorm_room` VALUES (74, 22, '6', 'C10012', 6);
INSERT INTO `dorm_room` VALUES (75, 22, '6', 'C10013', 6);
INSERT INTO `dorm_room` VALUES (76, 22, '6', 'C10014', 6);
INSERT INTO `dorm_room` VALUES (77, 22, '6', 'C10015', 6);
INSERT INTO `dorm_room` VALUES (78, 22, '6', 'C10016', 6);
INSERT INTO `dorm_room` VALUES (79, 22, '6', 'C10017', 6);
INSERT INTO `dorm_room` VALUES (80, 22, '6', 'C10018', 6);
INSERT INTO `dorm_room` VALUES (81, 22, '6', 'C10019', 6);
INSERT INTO `dorm_room` VALUES (82, 22, '6', 'C10020', 6);
INSERT INTO `dorm_room` VALUES (83, 22, '6', 'C10021', 6);
INSERT INTO `dorm_room` VALUES (84, 22, '6', 'C10022', 6);
INSERT INTO `dorm_room` VALUES (85, 22, '6', 'C10023', 6);
INSERT INTO `dorm_room` VALUES (86, 22, '6', 'C10024', 6);
INSERT INTO `dorm_room` VALUES (87, 22, '6', 'C10025', 6);
INSERT INTO `dorm_room` VALUES (88, 22, '6', 'C10026', 6);
INSERT INTO `dorm_room` VALUES (89, 22, '6', 'C10027', 6);
INSERT INTO `dorm_room` VALUES (90, 22, '6', 'C10028', 6);
INSERT INTO `dorm_room` VALUES (91, 22, '6', 'C10029', 6);
INSERT INTO `dorm_room` VALUES (92, 22, '6', 'C10030', 6);
INSERT INTO `dorm_room` VALUES (95, 17, '2', 'A105', 2);
INSERT INTO `dorm_room` VALUES (96, 17, '4', 'B200', 4);
INSERT INTO `dorm_room` VALUES (97, 17, '4', 'B201', 4);
INSERT INTO `dorm_room` VALUES (98, 17, '4', 'B202', 4);
INSERT INTO `dorm_room` VALUES (99, 17, '4', 'B203', 4);
INSERT INTO `dorm_room` VALUES (100, 17, '4', 'B204', 4);
INSERT INTO `dorm_room` VALUES (101, 17, '4', 'B205', 4);
INSERT INTO `dorm_room` VALUES (102, 17, '4', 'B206', 4);
INSERT INTO `dorm_room` VALUES (103, 17, '4', 'B207', 4);
INSERT INTO `dorm_room` VALUES (104, 17, '4', 'B208', 4);
INSERT INTO `dorm_room` VALUES (105, 17, '4', 'B209', 4);
INSERT INTO `dorm_room` VALUES (106, 17, '4', 'B210', 4);
INSERT INTO `dorm_room` VALUES (107, 17, '4', 'B211', 4);
INSERT INTO `dorm_room` VALUES (108, 17, '4', 'B212', 4);
INSERT INTO `dorm_room` VALUES (109, 17, '4', 'B213', 4);
INSERT INTO `dorm_room` VALUES (110, 17, '4', 'B214', 4);
INSERT INTO `dorm_room` VALUES (111, 17, '4', 'B215', 4);
INSERT INTO `dorm_room` VALUES (112, 17, '4', 'B216', 4);
INSERT INTO `dorm_room` VALUES (113, 17, '4', 'B217', 4);
INSERT INTO `dorm_room` VALUES (114, 17, '4', 'B218', 4);
INSERT INTO `dorm_room` VALUES (115, 17, '4', 'B219', 4);
INSERT INTO `dorm_room` VALUES (116, 17, '4', 'B220', 4);
INSERT INTO `dorm_room` VALUES (117, 17, '4', 'B221', 4);
INSERT INTO `dorm_room` VALUES (118, 17, '4', 'B222', 4);
INSERT INTO `dorm_room` VALUES (119, 17, '4', 'B223', 4);
INSERT INTO `dorm_room` VALUES (120, 17, '4', 'B224', 4);
INSERT INTO `dorm_room` VALUES (121, 17, '4', 'B225', 4);
INSERT INTO `dorm_room` VALUES (122, 17, '4', 'B226', 4);
INSERT INTO `dorm_room` VALUES (123, 17, '4', 'B227', 4);
INSERT INTO `dorm_room` VALUES (124, 17, '4', 'B228', 4);
INSERT INTO `dorm_room` VALUES (125, 17, '4', 'B229', 4);
INSERT INTO `dorm_room` VALUES (126, 17, '4', 'B230', 4);
INSERT INTO `dorm_room` VALUES (127, 17, '4', 'B231', 4);
INSERT INTO `dorm_room` VALUES (128, 17, '4', 'B232', 4);
INSERT INTO `dorm_room` VALUES (129, 17, '4', 'B233', 4);
INSERT INTO `dorm_room` VALUES (130, 17, '4', 'B234', 4);
INSERT INTO `dorm_room` VALUES (131, 17, '4', 'B235', 4);
INSERT INTO `dorm_room` VALUES (132, 17, '4', 'B236', 4);
INSERT INTO `dorm_room` VALUES (133, 17, '4', 'B237', 4);
INSERT INTO `dorm_room` VALUES (134, 17, '4', 'B238', 4);
INSERT INTO `dorm_room` VALUES (135, 17, '4', 'B239', 4);
INSERT INTO `dorm_room` VALUES (136, 17, '4', 'B240', 4);
INSERT INTO `dorm_room` VALUES (137, 17, '4', 'B241', 4);
INSERT INTO `dorm_room` VALUES (138, 17, '4', 'B242', 4);
INSERT INTO `dorm_room` VALUES (139, 17, '4', 'B243', 4);
INSERT INTO `dorm_room` VALUES (140, 17, '4', 'B244', 4);
INSERT INTO `dorm_room` VALUES (141, 17, '4', 'B245', 4);
INSERT INTO `dorm_room` VALUES (142, 17, '4', 'B246', 4);
INSERT INTO `dorm_room` VALUES (143, 17, '4', 'B247', 4);
INSERT INTO `dorm_room` VALUES (144, 17, '4', 'B248', 4);
INSERT INTO `dorm_room` VALUES (145, 17, '4', 'B249', 4);
INSERT INTO `dorm_room` VALUES (146, 17, '4', 'B250', 4);
INSERT INTO `dorm_room` VALUES (147, 32, '4', 'D101', 4);
INSERT INTO `dorm_room` VALUES (148, 32, '4', 'D102', 4);
INSERT INTO `dorm_room` VALUES (149, 32, '4', 'D103', 4);
INSERT INTO `dorm_room` VALUES (150, 32, '4', 'D104', 4);
INSERT INTO `dorm_room` VALUES (151, 32, '4', 'D105', 4);
INSERT INTO `dorm_room` VALUES (152, 32, '4', 'D106', 4);
INSERT INTO `dorm_room` VALUES (153, 32, '4', 'D107', 4);
INSERT INTO `dorm_room` VALUES (154, 32, '4', 'D108', 4);
INSERT INTO `dorm_room` VALUES (155, 32, '4', 'D109', 4);
INSERT INTO `dorm_room` VALUES (156, 32, '4', 'D110', 4);
INSERT INTO `dorm_room` VALUES (157, 32, '4', 'D111', 4);
INSERT INTO `dorm_room` VALUES (158, 32, '4', 'D112', 4);
INSERT INTO `dorm_room` VALUES (159, 32, '4', 'D113', 4);
INSERT INTO `dorm_room` VALUES (160, 32, '4', 'D114', 4);
INSERT INTO `dorm_room` VALUES (161, 32, '4', 'D115', 4);
INSERT INTO `dorm_room` VALUES (162, 32, '4', 'D116', 4);
INSERT INTO `dorm_room` VALUES (163, 32, '4', 'D117', 4);
INSERT INTO `dorm_room` VALUES (164, 32, '4', 'D118', 4);
INSERT INTO `dorm_room` VALUES (165, 32, '4', 'D119', 4);
INSERT INTO `dorm_room` VALUES (166, 32, '4', 'D120', 4);
INSERT INTO `dorm_room` VALUES (167, 38, '2', 'E301', 2);
INSERT INTO `dorm_room` VALUES (168, 38, '2', 'E302', 2);
INSERT INTO `dorm_room` VALUES (169, 38, '2', 'E303', 2);
INSERT INTO `dorm_room` VALUES (170, 38, '2', 'E304', 2);
INSERT INTO `dorm_room` VALUES (171, 38, '2', 'E305', 2);
INSERT INTO `dorm_room` VALUES (172, 38, '2', 'E306', 2);
INSERT INTO `dorm_room` VALUES (173, 38, '2', 'E307', 2);
INSERT INTO `dorm_room` VALUES (174, 38, '2', 'E308', 2);
INSERT INTO `dorm_room` VALUES (175, 38, '2', 'E309', 2);
INSERT INTO `dorm_room` VALUES (176, 38, '2', 'E310', 2);
INSERT INTO `dorm_room` VALUES (177, 38, '2', 'E311', 2);
INSERT INTO `dorm_room` VALUES (178, 38, '2', 'E312', 2);
INSERT INTO `dorm_room` VALUES (179, 38, '2', 'E313', 2);
INSERT INTO `dorm_room` VALUES (180, 38, '2', 'E314', 2);
INSERT INTO `dorm_room` VALUES (181, 38, '2', 'E315', 2);
INSERT INTO `dorm_room` VALUES (182, 38, '2', 'E316', 2);
INSERT INTO `dorm_room` VALUES (183, 38, '2', 'E317', 2);
INSERT INTO `dorm_room` VALUES (184, 38, '2', 'E318', 2);
INSERT INTO `dorm_room` VALUES (185, 38, '2', 'E319', 2);
INSERT INTO `dorm_room` VALUES (186, 38, '2', 'E320', 2);
INSERT INTO `dorm_room` VALUES (187, 45, '6', 'F601', 6);
INSERT INTO `dorm_room` VALUES (188, 45, '6', 'F602', 6);
INSERT INTO `dorm_room` VALUES (189, 45, '6', 'F603', 6);
INSERT INTO `dorm_room` VALUES (190, 45, '6', 'F604', 6);
INSERT INTO `dorm_room` VALUES (191, 45, '6', 'F605', 6);
INSERT INTO `dorm_room` VALUES (192, 45, '6', 'F606', 6);
INSERT INTO `dorm_room` VALUES (193, 45, '6', 'F607', 6);
INSERT INTO `dorm_room` VALUES (194, 45, '6', 'F608', 6);
INSERT INTO `dorm_room` VALUES (195, 45, '6', 'F609', 6);
INSERT INTO `dorm_room` VALUES (196, 45, '6', 'F610', 6);
INSERT INTO `dorm_room` VALUES (197, 45, '6', 'F611', 6);
INSERT INTO `dorm_room` VALUES (198, 45, '6', 'F612', 6);
INSERT INTO `dorm_room` VALUES (199, 45, '6', 'F613', 6);
INSERT INTO `dorm_room` VALUES (200, 45, '6', 'F614', 6);
INSERT INTO `dorm_room` VALUES (201, 45, '6', 'F615', 6);
INSERT INTO `dorm_room` VALUES (202, 45, '6', 'F616', 6);
INSERT INTO `dorm_room` VALUES (203, 45, '6', 'F617', 6);
INSERT INTO `dorm_room` VALUES (204, 45, '6', 'F618', 6);
INSERT INTO `dorm_room` VALUES (205, 45, '6', 'F619', 6);
INSERT INTO `dorm_room` VALUES (206, 45, '6', 'F620', 6);
INSERT INTO `dorm_room` VALUES (207, 45, '6', 'F621', 6);
INSERT INTO `dorm_room` VALUES (208, 51, '1', 'G701', 1);
INSERT INTO `dorm_room` VALUES (209, 51, '1', 'G702', 1);
INSERT INTO `dorm_room` VALUES (210, 51, '1', 'G703', 1);
INSERT INTO `dorm_room` VALUES (211, 51, '1', 'G704', 1);
INSERT INTO `dorm_room` VALUES (212, 51, '1', 'G705', 1);
INSERT INTO `dorm_room` VALUES (213, 51, '1', 'G706', 1);
INSERT INTO `dorm_room` VALUES (214, 51, '1', 'G707', 1);
INSERT INTO `dorm_room` VALUES (215, 51, '1', 'G708', 1);
INSERT INTO `dorm_room` VALUES (216, 51, '1', 'G709', 1);
INSERT INTO `dorm_room` VALUES (217, 51, '1', 'G710', 1);
INSERT INTO `dorm_room` VALUES (218, 51, '1', 'G711', 1);
INSERT INTO `dorm_room` VALUES (219, 51, '1', 'G712', 1);
INSERT INTO `dorm_room` VALUES (220, 51, '1', 'G713', 1);
INSERT INTO `dorm_room` VALUES (221, 51, '1', 'G714', 1);
INSERT INTO `dorm_room` VALUES (222, 51, '1', 'G715', 1);
INSERT INTO `dorm_room` VALUES (223, 51, '1', 'G716', 1);
INSERT INTO `dorm_room` VALUES (224, 51, '1', 'G717', 1);
INSERT INTO `dorm_room` VALUES (225, 51, '1', 'G718', 1);
INSERT INTO `dorm_room` VALUES (226, 51, '1', 'G719', 1);
INSERT INTO `dorm_room` VALUES (227, 51, '1', 'G720', 1);
INSERT INTO `dorm_room` VALUES (228, 51, '1', 'G721', 1);
INSERT INTO `dorm_room` VALUES (229, 57, '2', '9001', 2);
INSERT INTO `dorm_room` VALUES (230, 57, '2', '9002', 2);
INSERT INTO `dorm_room` VALUES (231, 57, '2', '9003', 2);
INSERT INTO `dorm_room` VALUES (232, 57, '2', '9004', 2);
INSERT INTO `dorm_room` VALUES (233, 57, '2', '9005', 2);
INSERT INTO `dorm_room` VALUES (234, 57, '2', '9006', 2);
INSERT INTO `dorm_room` VALUES (235, 57, '2', '9007', 2);
INSERT INTO `dorm_room` VALUES (236, 57, '2', '9008', 2);
INSERT INTO `dorm_room` VALUES (237, 57, '2', '9009', 2);
INSERT INTO `dorm_room` VALUES (238, 57, '2', '9010', 2);
INSERT INTO `dorm_room` VALUES (239, 63, '4', 'N101', 4);
INSERT INTO `dorm_room` VALUES (240, 63, '4', 'N102', 4);
INSERT INTO `dorm_room` VALUES (241, 63, '4', 'N103', 4);
INSERT INTO `dorm_room` VALUES (242, 63, '4', 'N104', 4);
INSERT INTO `dorm_room` VALUES (243, 63, '4', 'N105', 4);
INSERT INTO `dorm_room` VALUES (244, 63, '4', 'N106', 4);
INSERT INTO `dorm_room` VALUES (245, 63, '4', 'N107', 4);
INSERT INTO `dorm_room` VALUES (246, 63, '4', 'N108', 4);
INSERT INTO `dorm_room` VALUES (247, 63, '4', 'N109', 4);
INSERT INTO `dorm_room` VALUES (248, 63, '4', 'N110', 4);
INSERT INTO `dorm_room` VALUES (249, 86, '4', 'M501', 4);
INSERT INTO `dorm_room` VALUES (250, 86, '4', 'M502', 4);
INSERT INTO `dorm_room` VALUES (251, 86, '4', 'M503', 4);
INSERT INTO `dorm_room` VALUES (252, 86, '4', 'M504', 4);
INSERT INTO `dorm_room` VALUES (253, 86, '4', 'M505', 4);
INSERT INTO `dorm_room` VALUES (254, 86, '4', 'M506', 4);
INSERT INTO `dorm_room` VALUES (255, 86, '4', 'M507', 4);
INSERT INTO `dorm_room` VALUES (256, 86, '4', 'M508', 4);
INSERT INTO `dorm_room` VALUES (257, 86, '4', 'M509', 4);
INSERT INTO `dorm_room` VALUES (258, 86, '4', 'M510', 4);

-- ----------------------------
-- Table structure for drom_build
-- ----------------------------
DROP TABLE IF EXISTS `drom_build`;
CREATE TABLE `drom_build`  (
  `build_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '栋数id',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '用户id',
  `build_storey` int(11) NULL DEFAULT NULL COMMENT '层数',
  `sex` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '性别 0：男 1：女',
  `build_name` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '栋数名称',
  `order_num` int(11) NULL DEFAULT NULL COMMENT '序号',
  PRIMARY KEY (`build_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of drom_build
-- ----------------------------
INSERT INTO `drom_build` VALUES (3, 5, 6, '0', '1栋', 1);
INSERT INTO `drom_build` VALUES (4, 5, 12, '1', '2栋', 2);
INSERT INTO `drom_build` VALUES (5, 7, 6, '0', '3栋', 3);
INSERT INTO `drom_build` VALUES (6, 6, 5, '1', '4栋', 4);
INSERT INTO `drom_build` VALUES (7, 5, 6, '1', '5栋', 5);
INSERT INTO `drom_build` VALUES (8, 6, 6, '0', '6栋', 6);
INSERT INTO `drom_build` VALUES (9, 7, 6, '0', '7栋', 7);
INSERT INTO `drom_build` VALUES (10, 6, 6, '0', '8栋', 8);
INSERT INTO `drom_build` VALUES (11, 6, 6, '0', '9栋', 9);
INSERT INTO `drom_build` VALUES (12, 5, 6, '0', '10栋', 10);
INSERT INTO `drom_build` VALUES (13, 5, 8, '1', '11栋', 11);

-- ----------------------------
-- Table structure for drom_into
-- ----------------------------
DROP TABLE IF EXISTS `drom_into`;
CREATE TABLE `drom_into`  (
  `into_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `into_time` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '出入时间',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '物品名称',
  `into_text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '备注',
  `user_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '联系人',
  `phone` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '联系电话',
  `leader` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '值班人',
  `status` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '类型 ： 1：进楼 2：出楼',
  PRIMARY KEY (`into_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of drom_into
-- ----------------------------
INSERT INTO `drom_into` VALUES (1, '2022-04-09 00:03:00', '桌子', '自己购买', '李四', '184456431323', '张师', '2');
INSERT INTO `drom_into` VALUES (3, '2022-04-07 14:19:00', '床架', '维修回收', '张武', '165461312313', '杨师', '1');

-- ----------------------------
-- Table structure for drom_leave
-- ----------------------------
DROP TABLE IF EXISTS `drom_leave`;
CREATE TABLE `drom_leave`  (
  `leave_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `classes` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '班级',
  `stu_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '姓名',
  `drom_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '宿舍名称',
  `leave_time` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '缺勤时间',
  PRIMARY KEY (`leave_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of drom_leave
-- ----------------------------
INSERT INTO `drom_leave` VALUES (1, '软件工程1班', '李四', 'A101', '2022-04-08');
INSERT INTO `drom_leave` VALUES (2, '软件工程1班', '李四', 'A101', '2022-04-08');
INSERT INTO `drom_leave` VALUES (5, '单片机技术1班', '张武', 'B101', '2022-04-05');
INSERT INTO `drom_leave` VALUES (6, '软件工程1班', '张三', 'A501', '2022-04-07');

-- ----------------------------
-- Table structure for drom_look
-- ----------------------------
DROP TABLE IF EXISTS `drom_look`;
CREATE TABLE `drom_look`  (
  `look_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `look_time` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '来访时间',
  `user_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '来访人姓名',
  `phone` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '来访人电话',
  `look_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '被访人姓名',
  `look_room` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '被访人宿舍',
  `leader` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '值班人',
  `look_text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '备注',
  PRIMARY KEY (`look_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of drom_look
-- ----------------------------
INSERT INTO `drom_look` VALUES (1, '2022-04-08 00:00:00', '赵柳', '1546464654', '昭明', 'B501', '赵师', '11');
INSERT INTO `drom_look` VALUES (2, '2022-04-09 12:00:00', '张三', '178945644313', '李四', 'A101', '李师', '玩');

-- ----------------------------
-- Table structure for drom_repair
-- ----------------------------
DROP TABLE IF EXISTS `drom_repair`;
CREATE TABLE `drom_repair`  (
  `repair_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '联系人',
  `phone` varchar(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '联系电话',
  `drom_name` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '宿舍名称',
  `repair_text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '维修说明',
  `repair_time` datetime(0) NULL DEFAULT NULL COMMENT '报修时间',
  `status` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '维修状态 //0 ： 待维修 1： 已维修',
  PRIMARY KEY (`repair_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of drom_repair
-- ----------------------------
INSERT INTO `drom_repair` VALUES (3, '李四', '18787171906', 'B501', '床架倒了', '2022-04-09 08:45:05', '1');
INSERT INTO `drom_repair` VALUES (4, '李明', '18787451230', 'C1001', '灯泡坏了', '2022-04-09 08:47:04', '1');
INSERT INTO `drom_repair` VALUES (5, '孙明', '1564643132', '窗户玻璃坏了', '窗户玻璃坏了', '2022-04-10 21:38:09', '1');

-- ----------------------------
-- Table structure for drom_room_bed
-- ----------------------------
DROP TABLE IF EXISTS `drom_room_bed`;
CREATE TABLE `drom_room_bed`  (
  `bed_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '床位id',
  `room_id` int(11) NULL DEFAULT NULL COMMENT '宿舍id',
  `bed_code` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '床位编号',
  PRIMARY KEY (`bed_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 851 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of drom_room_bed
-- ----------------------------
INSERT INTO `drom_room_bed` VALUES (40, 38, 'A101-1');
INSERT INTO `drom_room_bed` VALUES (41, 39, 'A102-1');
INSERT INTO `drom_room_bed` VALUES (42, 39, 'A102-2');
INSERT INTO `drom_room_bed` VALUES (43, 40, 'A103-1');
INSERT INTO `drom_room_bed` VALUES (44, 40, 'A103-2');
INSERT INTO `drom_room_bed` VALUES (45, 40, 'A103-3');
INSERT INTO `drom_room_bed` VALUES (46, 40, 'A103-4');
INSERT INTO `drom_room_bed` VALUES (47, 40, 'A103-5');
INSERT INTO `drom_room_bed` VALUES (48, 40, 'A103-6');
INSERT INTO `drom_room_bed` VALUES (49, 41, 'A104-1');
INSERT INTO `drom_room_bed` VALUES (50, 41, 'A104-2');
INSERT INTO `drom_room_bed` VALUES (51, 95, 'A105-1');
INSERT INTO `drom_room_bed` VALUES (52, 95, 'A105-2');
INSERT INTO `drom_room_bed` VALUES (53, 43, 'B101-1');
INSERT INTO `drom_room_bed` VALUES (54, 43, 'B101-2');
INSERT INTO `drom_room_bed` VALUES (55, 43, 'B101-3');
INSERT INTO `drom_room_bed` VALUES (56, 43, 'B101-4');
INSERT INTO `drom_room_bed` VALUES (57, 44, 'B102-1');
INSERT INTO `drom_room_bed` VALUES (58, 44, 'B102-2');
INSERT INTO `drom_room_bed` VALUES (59, 44, 'B102-3');
INSERT INTO `drom_room_bed` VALUES (60, 44, 'B102-4');
INSERT INTO `drom_room_bed` VALUES (61, 45, 'B103-1');
INSERT INTO `drom_room_bed` VALUES (62, 45, 'B103-2');
INSERT INTO `drom_room_bed` VALUES (63, 45, 'B103-3');
INSERT INTO `drom_room_bed` VALUES (64, 45, 'B103-4');
INSERT INTO `drom_room_bed` VALUES (65, 46, 'B104-1');
INSERT INTO `drom_room_bed` VALUES (66, 46, 'B104-2');
INSERT INTO `drom_room_bed` VALUES (67, 46, 'B104-3');
INSERT INTO `drom_room_bed` VALUES (68, 46, 'B104-4');
INSERT INTO `drom_room_bed` VALUES (69, 47, 'B105-1');
INSERT INTO `drom_room_bed` VALUES (70, 47, 'B105-2');
INSERT INTO `drom_room_bed` VALUES (71, 47, 'B105-3');
INSERT INTO `drom_room_bed` VALUES (72, 47, 'B105-4');
INSERT INTO `drom_room_bed` VALUES (73, 48, 'B106-1');
INSERT INTO `drom_room_bed` VALUES (74, 48, 'B106-2');
INSERT INTO `drom_room_bed` VALUES (75, 48, 'B106-3');
INSERT INTO `drom_room_bed` VALUES (76, 48, 'B106-4');
INSERT INTO `drom_room_bed` VALUES (77, 49, 'B107-1');
INSERT INTO `drom_room_bed` VALUES (78, 49, 'B107-2');
INSERT INTO `drom_room_bed` VALUES (79, 49, 'B107-3');
INSERT INTO `drom_room_bed` VALUES (80, 49, 'B107-4');
INSERT INTO `drom_room_bed` VALUES (81, 50, 'B108-1');
INSERT INTO `drom_room_bed` VALUES (82, 50, 'B108-2');
INSERT INTO `drom_room_bed` VALUES (83, 50, 'B108-3');
INSERT INTO `drom_room_bed` VALUES (84, 50, 'B108-4');
INSERT INTO `drom_room_bed` VALUES (85, 51, 'B109-1');
INSERT INTO `drom_room_bed` VALUES (86, 51, 'B109-2');
INSERT INTO `drom_room_bed` VALUES (87, 51, 'B109-3');
INSERT INTO `drom_room_bed` VALUES (88, 51, 'B109-4');
INSERT INTO `drom_room_bed` VALUES (89, 52, 'B110-1');
INSERT INTO `drom_room_bed` VALUES (90, 52, 'B110-2');
INSERT INTO `drom_room_bed` VALUES (91, 52, 'B110-3');
INSERT INTO `drom_room_bed` VALUES (92, 52, 'B110-4');
INSERT INTO `drom_room_bed` VALUES (93, 53, 'B111-1');
INSERT INTO `drom_room_bed` VALUES (94, 53, 'B111-2');
INSERT INTO `drom_room_bed` VALUES (95, 53, 'B111-3');
INSERT INTO `drom_room_bed` VALUES (96, 53, 'B111-4');
INSERT INTO `drom_room_bed` VALUES (97, 54, 'B112-1');
INSERT INTO `drom_room_bed` VALUES (98, 54, 'B112-2');
INSERT INTO `drom_room_bed` VALUES (99, 54, 'B112-3');
INSERT INTO `drom_room_bed` VALUES (100, 54, 'B112-4');
INSERT INTO `drom_room_bed` VALUES (101, 55, 'B113-1');
INSERT INTO `drom_room_bed` VALUES (102, 55, 'B113-2');
INSERT INTO `drom_room_bed` VALUES (103, 55, 'B113-3');
INSERT INTO `drom_room_bed` VALUES (104, 55, 'B113-4');
INSERT INTO `drom_room_bed` VALUES (105, 56, 'B114-1');
INSERT INTO `drom_room_bed` VALUES (106, 56, 'B114-2');
INSERT INTO `drom_room_bed` VALUES (107, 56, 'B114-3');
INSERT INTO `drom_room_bed` VALUES (108, 56, 'B114-4');
INSERT INTO `drom_room_bed` VALUES (109, 57, 'B115-1');
INSERT INTO `drom_room_bed` VALUES (110, 57, 'B115-2');
INSERT INTO `drom_room_bed` VALUES (111, 57, 'B115-3');
INSERT INTO `drom_room_bed` VALUES (112, 57, 'B115-4');
INSERT INTO `drom_room_bed` VALUES (113, 58, 'B116-1');
INSERT INTO `drom_room_bed` VALUES (114, 58, 'B116-2');
INSERT INTO `drom_room_bed` VALUES (115, 58, 'B116-3');
INSERT INTO `drom_room_bed` VALUES (116, 58, 'B116-4');
INSERT INTO `drom_room_bed` VALUES (117, 59, 'B117-1');
INSERT INTO `drom_room_bed` VALUES (118, 59, 'B117-2');
INSERT INTO `drom_room_bed` VALUES (119, 59, 'B117-3');
INSERT INTO `drom_room_bed` VALUES (120, 59, 'B117-4');
INSERT INTO `drom_room_bed` VALUES (121, 60, 'B118-1');
INSERT INTO `drom_room_bed` VALUES (122, 60, 'B118-2');
INSERT INTO `drom_room_bed` VALUES (123, 60, 'B118-3');
INSERT INTO `drom_room_bed` VALUES (124, 60, 'B118-4');
INSERT INTO `drom_room_bed` VALUES (125, 61, 'B119-1');
INSERT INTO `drom_room_bed` VALUES (126, 61, 'B119-2');
INSERT INTO `drom_room_bed` VALUES (127, 61, 'B119-3');
INSERT INTO `drom_room_bed` VALUES (128, 61, 'B119-4');
INSERT INTO `drom_room_bed` VALUES (129, 62, 'B120-1');
INSERT INTO `drom_room_bed` VALUES (130, 62, 'B120-2');
INSERT INTO `drom_room_bed` VALUES (131, 62, 'B120-3');
INSERT INTO `drom_room_bed` VALUES (132, 62, 'B120-4');
INSERT INTO `drom_room_bed` VALUES (133, 38, 'A101-2');
INSERT INTO `drom_room_bed` VALUES (136, 38, 'A101-3');
INSERT INTO `drom_room_bed` VALUES (137, 38, 'A101-4');
INSERT INTO `drom_room_bed` VALUES (138, 38, 'A101-5');
INSERT INTO `drom_room_bed` VALUES (139, 38, 'A101-6');
INSERT INTO `drom_room_bed` VALUES (140, 63, 'C10001-1');
INSERT INTO `drom_room_bed` VALUES (141, 63, 'C10001-2');
INSERT INTO `drom_room_bed` VALUES (142, 63, 'C10001-3');
INSERT INTO `drom_room_bed` VALUES (143, 63, 'C10001-4');
INSERT INTO `drom_room_bed` VALUES (144, 63, 'C10001-5');
INSERT INTO `drom_room_bed` VALUES (145, 63, 'C10001-6');
INSERT INTO `drom_room_bed` VALUES (146, 64, 'C10002-1');
INSERT INTO `drom_room_bed` VALUES (147, 64, 'C10002-2');
INSERT INTO `drom_room_bed` VALUES (148, 64, 'C10002-3');
INSERT INTO `drom_room_bed` VALUES (149, 64, 'C10002-4');
INSERT INTO `drom_room_bed` VALUES (150, 64, 'C10002-5');
INSERT INTO `drom_room_bed` VALUES (151, 64, 'C10002-6');
INSERT INTO `drom_room_bed` VALUES (152, 65, 'C10003-1');
INSERT INTO `drom_room_bed` VALUES (153, 65, 'C10003-2');
INSERT INTO `drom_room_bed` VALUES (154, 65, 'C10003-3');
INSERT INTO `drom_room_bed` VALUES (155, 65, 'C10003-4');
INSERT INTO `drom_room_bed` VALUES (156, 65, 'C10003-5');
INSERT INTO `drom_room_bed` VALUES (157, 65, 'C10003-6');
INSERT INTO `drom_room_bed` VALUES (158, 66, 'C10004-1');
INSERT INTO `drom_room_bed` VALUES (159, 66, 'C10004-2');
INSERT INTO `drom_room_bed` VALUES (160, 66, 'C10004-3');
INSERT INTO `drom_room_bed` VALUES (161, 66, 'C10004-4');
INSERT INTO `drom_room_bed` VALUES (162, 66, 'C10004-5');
INSERT INTO `drom_room_bed` VALUES (163, 66, 'C10004-6');
INSERT INTO `drom_room_bed` VALUES (164, 67, 'C10005-1');
INSERT INTO `drom_room_bed` VALUES (165, 67, 'C10005-2');
INSERT INTO `drom_room_bed` VALUES (166, 67, 'C10005-3');
INSERT INTO `drom_room_bed` VALUES (167, 67, 'C10005-4');
INSERT INTO `drom_room_bed` VALUES (168, 67, 'C10005-5');
INSERT INTO `drom_room_bed` VALUES (169, 67, 'C10005-6');
INSERT INTO `drom_room_bed` VALUES (170, 68, 'C10006-1');
INSERT INTO `drom_room_bed` VALUES (171, 68, 'C10006-2');
INSERT INTO `drom_room_bed` VALUES (172, 68, 'C10006-3');
INSERT INTO `drom_room_bed` VALUES (173, 68, 'C10006-4');
INSERT INTO `drom_room_bed` VALUES (174, 68, 'C10006-5');
INSERT INTO `drom_room_bed` VALUES (175, 68, 'C10006-6');
INSERT INTO `drom_room_bed` VALUES (176, 69, 'C10007-1');
INSERT INTO `drom_room_bed` VALUES (177, 69, 'C10007-2');
INSERT INTO `drom_room_bed` VALUES (178, 69, 'C10007-3');
INSERT INTO `drom_room_bed` VALUES (179, 69, 'C10007-4');
INSERT INTO `drom_room_bed` VALUES (180, 69, 'C10007-5');
INSERT INTO `drom_room_bed` VALUES (181, 69, 'C10007-6');
INSERT INTO `drom_room_bed` VALUES (182, 70, 'C10008-1');
INSERT INTO `drom_room_bed` VALUES (183, 70, 'C10008-2');
INSERT INTO `drom_room_bed` VALUES (184, 70, 'C10008-3');
INSERT INTO `drom_room_bed` VALUES (185, 70, 'C10008-4');
INSERT INTO `drom_room_bed` VALUES (186, 70, 'C10008-5');
INSERT INTO `drom_room_bed` VALUES (187, 70, 'C10008-6');
INSERT INTO `drom_room_bed` VALUES (188, 71, 'C10009-1');
INSERT INTO `drom_room_bed` VALUES (189, 71, 'C10009-2');
INSERT INTO `drom_room_bed` VALUES (190, 71, 'C10009-3');
INSERT INTO `drom_room_bed` VALUES (191, 71, 'C10009-4');
INSERT INTO `drom_room_bed` VALUES (192, 71, 'C10009-5');
INSERT INTO `drom_room_bed` VALUES (193, 71, 'C10009-6');
INSERT INTO `drom_room_bed` VALUES (194, 72, 'C10010-1');
INSERT INTO `drom_room_bed` VALUES (195, 72, 'C10010-2');
INSERT INTO `drom_room_bed` VALUES (196, 72, 'C10010-3');
INSERT INTO `drom_room_bed` VALUES (197, 72, 'C10010-4');
INSERT INTO `drom_room_bed` VALUES (198, 72, 'C10010-5');
INSERT INTO `drom_room_bed` VALUES (199, 72, 'C10010-6');
INSERT INTO `drom_room_bed` VALUES (200, 73, 'C10011-1');
INSERT INTO `drom_room_bed` VALUES (201, 73, 'C10011-2');
INSERT INTO `drom_room_bed` VALUES (202, 73, 'C10011-3');
INSERT INTO `drom_room_bed` VALUES (203, 73, 'C10011-4');
INSERT INTO `drom_room_bed` VALUES (204, 73, 'C10011-5');
INSERT INTO `drom_room_bed` VALUES (205, 73, 'C10011-6');
INSERT INTO `drom_room_bed` VALUES (206, 74, 'C10012-1');
INSERT INTO `drom_room_bed` VALUES (207, 74, 'C10012-2');
INSERT INTO `drom_room_bed` VALUES (208, 74, 'C10012-3');
INSERT INTO `drom_room_bed` VALUES (209, 74, 'C10012-4');
INSERT INTO `drom_room_bed` VALUES (210, 74, 'C10012-5');
INSERT INTO `drom_room_bed` VALUES (211, 74, 'C10012-6');
INSERT INTO `drom_room_bed` VALUES (212, 75, 'C10013-1');
INSERT INTO `drom_room_bed` VALUES (213, 75, 'C10013-2');
INSERT INTO `drom_room_bed` VALUES (214, 75, 'C10013-3');
INSERT INTO `drom_room_bed` VALUES (215, 75, 'C10013-4');
INSERT INTO `drom_room_bed` VALUES (216, 75, 'C10013-5');
INSERT INTO `drom_room_bed` VALUES (217, 75, 'C10013-6');
INSERT INTO `drom_room_bed` VALUES (218, 76, 'C10014-1');
INSERT INTO `drom_room_bed` VALUES (219, 76, 'C10014-2');
INSERT INTO `drom_room_bed` VALUES (220, 76, 'C10014-3');
INSERT INTO `drom_room_bed` VALUES (221, 76, 'C10014-4');
INSERT INTO `drom_room_bed` VALUES (222, 76, 'C10014-5');
INSERT INTO `drom_room_bed` VALUES (223, 76, 'C10014-6');
INSERT INTO `drom_room_bed` VALUES (224, 77, 'C10015-1');
INSERT INTO `drom_room_bed` VALUES (225, 77, 'C10015-2');
INSERT INTO `drom_room_bed` VALUES (226, 77, 'C10015-3');
INSERT INTO `drom_room_bed` VALUES (227, 77, 'C10015-4');
INSERT INTO `drom_room_bed` VALUES (228, 77, 'C10015-5');
INSERT INTO `drom_room_bed` VALUES (229, 77, 'C10015-6');
INSERT INTO `drom_room_bed` VALUES (230, 78, 'C10016-1');
INSERT INTO `drom_room_bed` VALUES (231, 78, 'C10016-2');
INSERT INTO `drom_room_bed` VALUES (232, 78, 'C10016-3');
INSERT INTO `drom_room_bed` VALUES (233, 78, 'C10016-4');
INSERT INTO `drom_room_bed` VALUES (234, 78, 'C10016-5');
INSERT INTO `drom_room_bed` VALUES (235, 78, 'C10016-6');
INSERT INTO `drom_room_bed` VALUES (236, 79, 'C10017-1');
INSERT INTO `drom_room_bed` VALUES (237, 79, 'C10017-2');
INSERT INTO `drom_room_bed` VALUES (238, 79, 'C10017-3');
INSERT INTO `drom_room_bed` VALUES (239, 79, 'C10017-4');
INSERT INTO `drom_room_bed` VALUES (240, 79, 'C10017-5');
INSERT INTO `drom_room_bed` VALUES (241, 79, 'C10017-6');
INSERT INTO `drom_room_bed` VALUES (242, 80, 'C10018-1');
INSERT INTO `drom_room_bed` VALUES (243, 80, 'C10018-2');
INSERT INTO `drom_room_bed` VALUES (244, 80, 'C10018-3');
INSERT INTO `drom_room_bed` VALUES (245, 80, 'C10018-4');
INSERT INTO `drom_room_bed` VALUES (246, 80, 'C10018-5');
INSERT INTO `drom_room_bed` VALUES (247, 80, 'C10018-6');
INSERT INTO `drom_room_bed` VALUES (248, 81, 'C10019-1');
INSERT INTO `drom_room_bed` VALUES (249, 81, 'C10019-2');
INSERT INTO `drom_room_bed` VALUES (250, 81, 'C10019-3');
INSERT INTO `drom_room_bed` VALUES (251, 81, 'C10019-4');
INSERT INTO `drom_room_bed` VALUES (252, 81, 'C10019-5');
INSERT INTO `drom_room_bed` VALUES (253, 81, 'C10019-6');
INSERT INTO `drom_room_bed` VALUES (254, 82, 'C10020-1');
INSERT INTO `drom_room_bed` VALUES (255, 82, 'C10020-2');
INSERT INTO `drom_room_bed` VALUES (256, 82, 'C10020-3');
INSERT INTO `drom_room_bed` VALUES (257, 82, 'C10020-4');
INSERT INTO `drom_room_bed` VALUES (258, 82, 'C10020-5');
INSERT INTO `drom_room_bed` VALUES (259, 82, 'C10020-6');
INSERT INTO `drom_room_bed` VALUES (260, 83, 'C10021-1');
INSERT INTO `drom_room_bed` VALUES (261, 83, 'C10021-2');
INSERT INTO `drom_room_bed` VALUES (262, 83, 'C10021-3');
INSERT INTO `drom_room_bed` VALUES (263, 83, 'C10021-4');
INSERT INTO `drom_room_bed` VALUES (264, 83, 'C10021-5');
INSERT INTO `drom_room_bed` VALUES (265, 83, 'C10021-6');
INSERT INTO `drom_room_bed` VALUES (266, 84, 'C10022-1');
INSERT INTO `drom_room_bed` VALUES (267, 84, 'C10022-2');
INSERT INTO `drom_room_bed` VALUES (268, 84, 'C10022-3');
INSERT INTO `drom_room_bed` VALUES (269, 84, 'C10022-4');
INSERT INTO `drom_room_bed` VALUES (270, 84, 'C10022-5');
INSERT INTO `drom_room_bed` VALUES (271, 84, 'C10022-6');
INSERT INTO `drom_room_bed` VALUES (272, 85, 'C10023-1');
INSERT INTO `drom_room_bed` VALUES (273, 85, 'C10023-2');
INSERT INTO `drom_room_bed` VALUES (274, 85, 'C10023-3');
INSERT INTO `drom_room_bed` VALUES (275, 85, 'C10023-4');
INSERT INTO `drom_room_bed` VALUES (276, 85, 'C10023-5');
INSERT INTO `drom_room_bed` VALUES (277, 85, 'C10023-6');
INSERT INTO `drom_room_bed` VALUES (278, 86, 'C10024-1');
INSERT INTO `drom_room_bed` VALUES (279, 86, 'C10024-2');
INSERT INTO `drom_room_bed` VALUES (280, 86, 'C10024-3');
INSERT INTO `drom_room_bed` VALUES (281, 86, 'C10024-4');
INSERT INTO `drom_room_bed` VALUES (282, 86, 'C10024-5');
INSERT INTO `drom_room_bed` VALUES (283, 86, 'C10024-6');
INSERT INTO `drom_room_bed` VALUES (284, 87, 'C10025-1');
INSERT INTO `drom_room_bed` VALUES (285, 87, 'C10025-2');
INSERT INTO `drom_room_bed` VALUES (286, 87, 'C10025-3');
INSERT INTO `drom_room_bed` VALUES (287, 87, 'C10025-4');
INSERT INTO `drom_room_bed` VALUES (288, 87, 'C10025-5');
INSERT INTO `drom_room_bed` VALUES (289, 87, 'C10025-6');
INSERT INTO `drom_room_bed` VALUES (290, 88, 'C10026-1');
INSERT INTO `drom_room_bed` VALUES (291, 88, 'C10026-2');
INSERT INTO `drom_room_bed` VALUES (292, 88, 'C10026-3');
INSERT INTO `drom_room_bed` VALUES (293, 88, 'C10026-4');
INSERT INTO `drom_room_bed` VALUES (294, 88, 'C10026-5');
INSERT INTO `drom_room_bed` VALUES (295, 88, 'C10026-6');
INSERT INTO `drom_room_bed` VALUES (296, 89, 'C10027-1');
INSERT INTO `drom_room_bed` VALUES (297, 89, 'C10027-2');
INSERT INTO `drom_room_bed` VALUES (298, 89, 'C10027-3');
INSERT INTO `drom_room_bed` VALUES (299, 89, 'C10027-4');
INSERT INTO `drom_room_bed` VALUES (300, 89, 'C10027-5');
INSERT INTO `drom_room_bed` VALUES (301, 89, 'C10027-6');
INSERT INTO `drom_room_bed` VALUES (302, 90, 'C10028-1');
INSERT INTO `drom_room_bed` VALUES (303, 90, 'C10028-2');
INSERT INTO `drom_room_bed` VALUES (304, 90, 'C10028-3');
INSERT INTO `drom_room_bed` VALUES (305, 90, 'C10028-4');
INSERT INTO `drom_room_bed` VALUES (306, 90, 'C10028-5');
INSERT INTO `drom_room_bed` VALUES (307, 90, 'C10028-6');
INSERT INTO `drom_room_bed` VALUES (308, 91, 'C10029-1');
INSERT INTO `drom_room_bed` VALUES (309, 91, 'C10029-2');
INSERT INTO `drom_room_bed` VALUES (310, 91, 'C10029-3');
INSERT INTO `drom_room_bed` VALUES (311, 91, 'C10029-4');
INSERT INTO `drom_room_bed` VALUES (312, 91, 'C10029-5');
INSERT INTO `drom_room_bed` VALUES (313, 91, 'C10029-6');
INSERT INTO `drom_room_bed` VALUES (314, 92, 'C10030-1');
INSERT INTO `drom_room_bed` VALUES (315, 92, 'C10030-2');
INSERT INTO `drom_room_bed` VALUES (316, 92, 'C10030-3');
INSERT INTO `drom_room_bed` VALUES (317, 92, 'C10030-4');
INSERT INTO `drom_room_bed` VALUES (318, 92, 'C10030-5');
INSERT INTO `drom_room_bed` VALUES (319, 92, 'C10030-6');
INSERT INTO `drom_room_bed` VALUES (320, 96, 'B200-1');
INSERT INTO `drom_room_bed` VALUES (321, 96, 'B200-2');
INSERT INTO `drom_room_bed` VALUES (322, 96, 'B200-3');
INSERT INTO `drom_room_bed` VALUES (323, 96, 'B200-4');
INSERT INTO `drom_room_bed` VALUES (324, 97, 'B201-1');
INSERT INTO `drom_room_bed` VALUES (325, 97, 'B201-2');
INSERT INTO `drom_room_bed` VALUES (326, 97, 'B201-3');
INSERT INTO `drom_room_bed` VALUES (327, 97, 'B201-4');
INSERT INTO `drom_room_bed` VALUES (328, 98, 'B202-1');
INSERT INTO `drom_room_bed` VALUES (329, 98, 'B202-2');
INSERT INTO `drom_room_bed` VALUES (330, 98, 'B202-3');
INSERT INTO `drom_room_bed` VALUES (331, 98, 'B202-4');
INSERT INTO `drom_room_bed` VALUES (332, 99, 'B203-1');
INSERT INTO `drom_room_bed` VALUES (333, 99, 'B203-2');
INSERT INTO `drom_room_bed` VALUES (334, 99, 'B203-3');
INSERT INTO `drom_room_bed` VALUES (335, 99, 'B203-4');
INSERT INTO `drom_room_bed` VALUES (336, 100, 'B204-1');
INSERT INTO `drom_room_bed` VALUES (337, 100, 'B204-2');
INSERT INTO `drom_room_bed` VALUES (338, 100, 'B204-3');
INSERT INTO `drom_room_bed` VALUES (339, 100, 'B204-4');
INSERT INTO `drom_room_bed` VALUES (340, 101, 'B205-1');
INSERT INTO `drom_room_bed` VALUES (341, 101, 'B205-2');
INSERT INTO `drom_room_bed` VALUES (342, 101, 'B205-3');
INSERT INTO `drom_room_bed` VALUES (343, 101, 'B205-4');
INSERT INTO `drom_room_bed` VALUES (344, 102, 'B206-1');
INSERT INTO `drom_room_bed` VALUES (345, 102, 'B206-2');
INSERT INTO `drom_room_bed` VALUES (346, 102, 'B206-3');
INSERT INTO `drom_room_bed` VALUES (347, 102, 'B206-4');
INSERT INTO `drom_room_bed` VALUES (348, 103, 'B207-1');
INSERT INTO `drom_room_bed` VALUES (349, 103, 'B207-2');
INSERT INTO `drom_room_bed` VALUES (350, 103, 'B207-3');
INSERT INTO `drom_room_bed` VALUES (351, 103, 'B207-4');
INSERT INTO `drom_room_bed` VALUES (352, 104, 'B208-1');
INSERT INTO `drom_room_bed` VALUES (353, 104, 'B208-2');
INSERT INTO `drom_room_bed` VALUES (354, 104, 'B208-3');
INSERT INTO `drom_room_bed` VALUES (355, 104, 'B208-4');
INSERT INTO `drom_room_bed` VALUES (356, 105, 'B209-1');
INSERT INTO `drom_room_bed` VALUES (357, 105, 'B209-2');
INSERT INTO `drom_room_bed` VALUES (358, 105, 'B209-3');
INSERT INTO `drom_room_bed` VALUES (359, 105, 'B209-4');
INSERT INTO `drom_room_bed` VALUES (360, 106, 'B210-1');
INSERT INTO `drom_room_bed` VALUES (361, 106, 'B210-2');
INSERT INTO `drom_room_bed` VALUES (362, 106, 'B210-3');
INSERT INTO `drom_room_bed` VALUES (363, 106, 'B210-4');
INSERT INTO `drom_room_bed` VALUES (364, 107, 'B211-1');
INSERT INTO `drom_room_bed` VALUES (365, 107, 'B211-2');
INSERT INTO `drom_room_bed` VALUES (366, 107, 'B211-3');
INSERT INTO `drom_room_bed` VALUES (367, 107, 'B211-4');
INSERT INTO `drom_room_bed` VALUES (368, 108, 'B212-1');
INSERT INTO `drom_room_bed` VALUES (369, 108, 'B212-2');
INSERT INTO `drom_room_bed` VALUES (370, 108, 'B212-3');
INSERT INTO `drom_room_bed` VALUES (371, 108, 'B212-4');
INSERT INTO `drom_room_bed` VALUES (372, 109, 'B213-1');
INSERT INTO `drom_room_bed` VALUES (373, 109, 'B213-2');
INSERT INTO `drom_room_bed` VALUES (374, 109, 'B213-3');
INSERT INTO `drom_room_bed` VALUES (375, 109, 'B213-4');
INSERT INTO `drom_room_bed` VALUES (376, 110, 'B214-1');
INSERT INTO `drom_room_bed` VALUES (377, 110, 'B214-2');
INSERT INTO `drom_room_bed` VALUES (378, 110, 'B214-3');
INSERT INTO `drom_room_bed` VALUES (379, 110, 'B214-4');
INSERT INTO `drom_room_bed` VALUES (380, 111, 'B215-1');
INSERT INTO `drom_room_bed` VALUES (381, 111, 'B215-2');
INSERT INTO `drom_room_bed` VALUES (382, 111, 'B215-3');
INSERT INTO `drom_room_bed` VALUES (383, 111, 'B215-4');
INSERT INTO `drom_room_bed` VALUES (384, 112, 'B216-1');
INSERT INTO `drom_room_bed` VALUES (385, 112, 'B216-2');
INSERT INTO `drom_room_bed` VALUES (386, 112, 'B216-3');
INSERT INTO `drom_room_bed` VALUES (387, 112, 'B216-4');
INSERT INTO `drom_room_bed` VALUES (388, 113, 'B217-1');
INSERT INTO `drom_room_bed` VALUES (389, 113, 'B217-2');
INSERT INTO `drom_room_bed` VALUES (390, 113, 'B217-3');
INSERT INTO `drom_room_bed` VALUES (391, 113, 'B217-4');
INSERT INTO `drom_room_bed` VALUES (392, 114, 'B218-1');
INSERT INTO `drom_room_bed` VALUES (393, 114, 'B218-2');
INSERT INTO `drom_room_bed` VALUES (394, 114, 'B218-3');
INSERT INTO `drom_room_bed` VALUES (395, 114, 'B218-4');
INSERT INTO `drom_room_bed` VALUES (396, 115, 'B219-1');
INSERT INTO `drom_room_bed` VALUES (397, 115, 'B219-2');
INSERT INTO `drom_room_bed` VALUES (398, 115, 'B219-3');
INSERT INTO `drom_room_bed` VALUES (399, 115, 'B219-4');
INSERT INTO `drom_room_bed` VALUES (400, 116, 'B220-1');
INSERT INTO `drom_room_bed` VALUES (401, 116, 'B220-2');
INSERT INTO `drom_room_bed` VALUES (402, 116, 'B220-3');
INSERT INTO `drom_room_bed` VALUES (403, 116, 'B220-4');
INSERT INTO `drom_room_bed` VALUES (404, 117, 'B221-1');
INSERT INTO `drom_room_bed` VALUES (405, 117, 'B221-2');
INSERT INTO `drom_room_bed` VALUES (406, 117, 'B221-3');
INSERT INTO `drom_room_bed` VALUES (407, 117, 'B221-4');
INSERT INTO `drom_room_bed` VALUES (408, 118, 'B222-1');
INSERT INTO `drom_room_bed` VALUES (409, 118, 'B222-2');
INSERT INTO `drom_room_bed` VALUES (410, 118, 'B222-3');
INSERT INTO `drom_room_bed` VALUES (411, 118, 'B222-4');
INSERT INTO `drom_room_bed` VALUES (412, 119, 'B223-1');
INSERT INTO `drom_room_bed` VALUES (413, 119, 'B223-2');
INSERT INTO `drom_room_bed` VALUES (414, 119, 'B223-3');
INSERT INTO `drom_room_bed` VALUES (415, 119, 'B223-4');
INSERT INTO `drom_room_bed` VALUES (416, 120, 'B224-1');
INSERT INTO `drom_room_bed` VALUES (417, 120, 'B224-2');
INSERT INTO `drom_room_bed` VALUES (418, 120, 'B224-3');
INSERT INTO `drom_room_bed` VALUES (419, 120, 'B224-4');
INSERT INTO `drom_room_bed` VALUES (420, 121, 'B225-1');
INSERT INTO `drom_room_bed` VALUES (421, 121, 'B225-2');
INSERT INTO `drom_room_bed` VALUES (422, 121, 'B225-3');
INSERT INTO `drom_room_bed` VALUES (423, 121, 'B225-4');
INSERT INTO `drom_room_bed` VALUES (424, 122, 'B226-1');
INSERT INTO `drom_room_bed` VALUES (425, 122, 'B226-2');
INSERT INTO `drom_room_bed` VALUES (426, 122, 'B226-3');
INSERT INTO `drom_room_bed` VALUES (427, 122, 'B226-4');
INSERT INTO `drom_room_bed` VALUES (428, 123, 'B227-1');
INSERT INTO `drom_room_bed` VALUES (429, 123, 'B227-2');
INSERT INTO `drom_room_bed` VALUES (430, 123, 'B227-3');
INSERT INTO `drom_room_bed` VALUES (431, 123, 'B227-4');
INSERT INTO `drom_room_bed` VALUES (432, 124, 'B228-1');
INSERT INTO `drom_room_bed` VALUES (433, 124, 'B228-2');
INSERT INTO `drom_room_bed` VALUES (434, 124, 'B228-3');
INSERT INTO `drom_room_bed` VALUES (435, 124, 'B228-4');
INSERT INTO `drom_room_bed` VALUES (436, 125, 'B229-1');
INSERT INTO `drom_room_bed` VALUES (437, 125, 'B229-2');
INSERT INTO `drom_room_bed` VALUES (438, 125, 'B229-3');
INSERT INTO `drom_room_bed` VALUES (439, 125, 'B229-4');
INSERT INTO `drom_room_bed` VALUES (440, 126, 'B230-1');
INSERT INTO `drom_room_bed` VALUES (441, 126, 'B230-2');
INSERT INTO `drom_room_bed` VALUES (442, 126, 'B230-3');
INSERT INTO `drom_room_bed` VALUES (443, 126, 'B230-4');
INSERT INTO `drom_room_bed` VALUES (444, 127, 'B231-1');
INSERT INTO `drom_room_bed` VALUES (445, 127, 'B231-2');
INSERT INTO `drom_room_bed` VALUES (446, 127, 'B231-3');
INSERT INTO `drom_room_bed` VALUES (447, 127, 'B231-4');
INSERT INTO `drom_room_bed` VALUES (448, 128, 'B232-1');
INSERT INTO `drom_room_bed` VALUES (449, 128, 'B232-2');
INSERT INTO `drom_room_bed` VALUES (450, 128, 'B232-3');
INSERT INTO `drom_room_bed` VALUES (451, 128, 'B232-4');
INSERT INTO `drom_room_bed` VALUES (452, 129, 'B233-1');
INSERT INTO `drom_room_bed` VALUES (453, 129, 'B233-2');
INSERT INTO `drom_room_bed` VALUES (454, 129, 'B233-3');
INSERT INTO `drom_room_bed` VALUES (455, 129, 'B233-4');
INSERT INTO `drom_room_bed` VALUES (456, 130, 'B234-1');
INSERT INTO `drom_room_bed` VALUES (457, 130, 'B234-2');
INSERT INTO `drom_room_bed` VALUES (458, 130, 'B234-3');
INSERT INTO `drom_room_bed` VALUES (459, 130, 'B234-4');
INSERT INTO `drom_room_bed` VALUES (460, 131, 'B235-1');
INSERT INTO `drom_room_bed` VALUES (461, 131, 'B235-2');
INSERT INTO `drom_room_bed` VALUES (462, 131, 'B235-3');
INSERT INTO `drom_room_bed` VALUES (463, 131, 'B235-4');
INSERT INTO `drom_room_bed` VALUES (464, 132, 'B236-1');
INSERT INTO `drom_room_bed` VALUES (465, 132, 'B236-2');
INSERT INTO `drom_room_bed` VALUES (466, 132, 'B236-3');
INSERT INTO `drom_room_bed` VALUES (467, 132, 'B236-4');
INSERT INTO `drom_room_bed` VALUES (468, 133, 'B237-1');
INSERT INTO `drom_room_bed` VALUES (469, 133, 'B237-2');
INSERT INTO `drom_room_bed` VALUES (470, 133, 'B237-3');
INSERT INTO `drom_room_bed` VALUES (471, 133, 'B237-4');
INSERT INTO `drom_room_bed` VALUES (472, 134, 'B238-1');
INSERT INTO `drom_room_bed` VALUES (473, 134, 'B238-2');
INSERT INTO `drom_room_bed` VALUES (474, 134, 'B238-3');
INSERT INTO `drom_room_bed` VALUES (475, 134, 'B238-4');
INSERT INTO `drom_room_bed` VALUES (476, 135, 'B239-1');
INSERT INTO `drom_room_bed` VALUES (477, 135, 'B239-2');
INSERT INTO `drom_room_bed` VALUES (478, 135, 'B239-3');
INSERT INTO `drom_room_bed` VALUES (479, 135, 'B239-4');
INSERT INTO `drom_room_bed` VALUES (480, 136, 'B240-1');
INSERT INTO `drom_room_bed` VALUES (481, 136, 'B240-2');
INSERT INTO `drom_room_bed` VALUES (482, 136, 'B240-3');
INSERT INTO `drom_room_bed` VALUES (483, 136, 'B240-4');
INSERT INTO `drom_room_bed` VALUES (484, 137, 'B241-1');
INSERT INTO `drom_room_bed` VALUES (485, 137, 'B241-2');
INSERT INTO `drom_room_bed` VALUES (486, 137, 'B241-3');
INSERT INTO `drom_room_bed` VALUES (487, 137, 'B241-4');
INSERT INTO `drom_room_bed` VALUES (488, 138, 'B242-1');
INSERT INTO `drom_room_bed` VALUES (489, 138, 'B242-2');
INSERT INTO `drom_room_bed` VALUES (490, 138, 'B242-3');
INSERT INTO `drom_room_bed` VALUES (491, 138, 'B242-4');
INSERT INTO `drom_room_bed` VALUES (492, 139, 'B243-1');
INSERT INTO `drom_room_bed` VALUES (493, 139, 'B243-2');
INSERT INTO `drom_room_bed` VALUES (494, 139, 'B243-3');
INSERT INTO `drom_room_bed` VALUES (495, 139, 'B243-4');
INSERT INTO `drom_room_bed` VALUES (496, 140, 'B244-1');
INSERT INTO `drom_room_bed` VALUES (497, 140, 'B244-2');
INSERT INTO `drom_room_bed` VALUES (498, 140, 'B244-3');
INSERT INTO `drom_room_bed` VALUES (499, 140, 'B244-4');
INSERT INTO `drom_room_bed` VALUES (500, 141, 'B245-1');
INSERT INTO `drom_room_bed` VALUES (501, 141, 'B245-2');
INSERT INTO `drom_room_bed` VALUES (502, 141, 'B245-3');
INSERT INTO `drom_room_bed` VALUES (503, 141, 'B245-4');
INSERT INTO `drom_room_bed` VALUES (504, 142, 'B246-1');
INSERT INTO `drom_room_bed` VALUES (505, 142, 'B246-2');
INSERT INTO `drom_room_bed` VALUES (506, 142, 'B246-3');
INSERT INTO `drom_room_bed` VALUES (507, 142, 'B246-4');
INSERT INTO `drom_room_bed` VALUES (508, 143, 'B247-1');
INSERT INTO `drom_room_bed` VALUES (509, 143, 'B247-2');
INSERT INTO `drom_room_bed` VALUES (510, 143, 'B247-3');
INSERT INTO `drom_room_bed` VALUES (511, 143, 'B247-4');
INSERT INTO `drom_room_bed` VALUES (512, 144, 'B248-1');
INSERT INTO `drom_room_bed` VALUES (513, 144, 'B248-2');
INSERT INTO `drom_room_bed` VALUES (514, 144, 'B248-3');
INSERT INTO `drom_room_bed` VALUES (515, 144, 'B248-4');
INSERT INTO `drom_room_bed` VALUES (516, 145, 'B249-1');
INSERT INTO `drom_room_bed` VALUES (517, 145, 'B249-2');
INSERT INTO `drom_room_bed` VALUES (518, 145, 'B249-3');
INSERT INTO `drom_room_bed` VALUES (519, 145, 'B249-4');
INSERT INTO `drom_room_bed` VALUES (520, 146, 'B250-1');
INSERT INTO `drom_room_bed` VALUES (521, 146, 'B250-2');
INSERT INTO `drom_room_bed` VALUES (522, 146, 'B250-3');
INSERT INTO `drom_room_bed` VALUES (523, 146, 'B250-4');
INSERT INTO `drom_room_bed` VALUES (524, 147, 'D101-1');
INSERT INTO `drom_room_bed` VALUES (525, 147, 'D101-2');
INSERT INTO `drom_room_bed` VALUES (526, 147, 'D101-3');
INSERT INTO `drom_room_bed` VALUES (527, 147, 'D101-4');
INSERT INTO `drom_room_bed` VALUES (528, 148, 'D102-1');
INSERT INTO `drom_room_bed` VALUES (529, 148, 'D102-2');
INSERT INTO `drom_room_bed` VALUES (530, 148, 'D102-3');
INSERT INTO `drom_room_bed` VALUES (531, 148, 'D102-4');
INSERT INTO `drom_room_bed` VALUES (532, 149, 'D103-1');
INSERT INTO `drom_room_bed` VALUES (533, 149, 'D103-2');
INSERT INTO `drom_room_bed` VALUES (534, 149, 'D103-3');
INSERT INTO `drom_room_bed` VALUES (535, 149, 'D103-4');
INSERT INTO `drom_room_bed` VALUES (536, 150, 'D104-1');
INSERT INTO `drom_room_bed` VALUES (537, 150, 'D104-2');
INSERT INTO `drom_room_bed` VALUES (538, 150, 'D104-3');
INSERT INTO `drom_room_bed` VALUES (539, 150, 'D104-4');
INSERT INTO `drom_room_bed` VALUES (540, 151, 'D105-1');
INSERT INTO `drom_room_bed` VALUES (541, 151, 'D105-2');
INSERT INTO `drom_room_bed` VALUES (542, 151, 'D105-3');
INSERT INTO `drom_room_bed` VALUES (543, 151, 'D105-4');
INSERT INTO `drom_room_bed` VALUES (544, 152, 'D106-1');
INSERT INTO `drom_room_bed` VALUES (545, 152, 'D106-2');
INSERT INTO `drom_room_bed` VALUES (546, 152, 'D106-3');
INSERT INTO `drom_room_bed` VALUES (547, 152, 'D106-4');
INSERT INTO `drom_room_bed` VALUES (548, 153, 'D107-1');
INSERT INTO `drom_room_bed` VALUES (549, 153, 'D107-2');
INSERT INTO `drom_room_bed` VALUES (550, 153, 'D107-3');
INSERT INTO `drom_room_bed` VALUES (551, 153, 'D107-4');
INSERT INTO `drom_room_bed` VALUES (552, 154, 'D108-1');
INSERT INTO `drom_room_bed` VALUES (553, 154, 'D108-2');
INSERT INTO `drom_room_bed` VALUES (554, 154, 'D108-3');
INSERT INTO `drom_room_bed` VALUES (555, 154, 'D108-4');
INSERT INTO `drom_room_bed` VALUES (556, 155, 'D109-1');
INSERT INTO `drom_room_bed` VALUES (557, 155, 'D109-2');
INSERT INTO `drom_room_bed` VALUES (558, 155, 'D109-3');
INSERT INTO `drom_room_bed` VALUES (559, 155, 'D109-4');
INSERT INTO `drom_room_bed` VALUES (560, 156, 'D110-1');
INSERT INTO `drom_room_bed` VALUES (561, 156, 'D110-2');
INSERT INTO `drom_room_bed` VALUES (562, 156, 'D110-3');
INSERT INTO `drom_room_bed` VALUES (563, 156, 'D110-4');
INSERT INTO `drom_room_bed` VALUES (564, 157, 'D111-1');
INSERT INTO `drom_room_bed` VALUES (565, 157, 'D111-2');
INSERT INTO `drom_room_bed` VALUES (566, 157, 'D111-3');
INSERT INTO `drom_room_bed` VALUES (567, 157, 'D111-4');
INSERT INTO `drom_room_bed` VALUES (568, 158, 'D112-1');
INSERT INTO `drom_room_bed` VALUES (569, 158, 'D112-2');
INSERT INTO `drom_room_bed` VALUES (570, 158, 'D112-3');
INSERT INTO `drom_room_bed` VALUES (571, 158, 'D112-4');
INSERT INTO `drom_room_bed` VALUES (572, 159, 'D113-1');
INSERT INTO `drom_room_bed` VALUES (573, 159, 'D113-2');
INSERT INTO `drom_room_bed` VALUES (574, 159, 'D113-3');
INSERT INTO `drom_room_bed` VALUES (575, 159, 'D113-4');
INSERT INTO `drom_room_bed` VALUES (576, 160, 'D114-1');
INSERT INTO `drom_room_bed` VALUES (577, 160, 'D114-2');
INSERT INTO `drom_room_bed` VALUES (578, 160, 'D114-3');
INSERT INTO `drom_room_bed` VALUES (579, 160, 'D114-4');
INSERT INTO `drom_room_bed` VALUES (580, 161, 'D115-1');
INSERT INTO `drom_room_bed` VALUES (581, 161, 'D115-2');
INSERT INTO `drom_room_bed` VALUES (582, 161, 'D115-3');
INSERT INTO `drom_room_bed` VALUES (583, 161, 'D115-4');
INSERT INTO `drom_room_bed` VALUES (584, 162, 'D116-1');
INSERT INTO `drom_room_bed` VALUES (585, 162, 'D116-2');
INSERT INTO `drom_room_bed` VALUES (586, 162, 'D116-3');
INSERT INTO `drom_room_bed` VALUES (587, 162, 'D116-4');
INSERT INTO `drom_room_bed` VALUES (588, 163, 'D117-1');
INSERT INTO `drom_room_bed` VALUES (589, 163, 'D117-2');
INSERT INTO `drom_room_bed` VALUES (590, 163, 'D117-3');
INSERT INTO `drom_room_bed` VALUES (591, 163, 'D117-4');
INSERT INTO `drom_room_bed` VALUES (592, 164, 'D118-1');
INSERT INTO `drom_room_bed` VALUES (593, 164, 'D118-2');
INSERT INTO `drom_room_bed` VALUES (594, 164, 'D118-3');
INSERT INTO `drom_room_bed` VALUES (595, 164, 'D118-4');
INSERT INTO `drom_room_bed` VALUES (596, 165, 'D119-1');
INSERT INTO `drom_room_bed` VALUES (597, 165, 'D119-2');
INSERT INTO `drom_room_bed` VALUES (598, 165, 'D119-3');
INSERT INTO `drom_room_bed` VALUES (599, 165, 'D119-4');
INSERT INTO `drom_room_bed` VALUES (600, 166, 'D120-1');
INSERT INTO `drom_room_bed` VALUES (601, 166, 'D120-2');
INSERT INTO `drom_room_bed` VALUES (602, 166, 'D120-3');
INSERT INTO `drom_room_bed` VALUES (603, 166, 'D120-4');
INSERT INTO `drom_room_bed` VALUES (604, 167, 'E301-1');
INSERT INTO `drom_room_bed` VALUES (605, 167, 'E301-2');
INSERT INTO `drom_room_bed` VALUES (606, 168, 'E302-1');
INSERT INTO `drom_room_bed` VALUES (607, 168, 'E302-2');
INSERT INTO `drom_room_bed` VALUES (608, 169, 'E303-1');
INSERT INTO `drom_room_bed` VALUES (609, 169, 'E303-2');
INSERT INTO `drom_room_bed` VALUES (610, 170, 'E304-1');
INSERT INTO `drom_room_bed` VALUES (611, 170, 'E304-2');
INSERT INTO `drom_room_bed` VALUES (612, 171, 'E305-1');
INSERT INTO `drom_room_bed` VALUES (613, 171, 'E305-2');
INSERT INTO `drom_room_bed` VALUES (614, 172, 'E306-1');
INSERT INTO `drom_room_bed` VALUES (615, 172, 'E306-2');
INSERT INTO `drom_room_bed` VALUES (616, 173, 'E307-1');
INSERT INTO `drom_room_bed` VALUES (617, 173, 'E307-2');
INSERT INTO `drom_room_bed` VALUES (618, 174, 'E308-1');
INSERT INTO `drom_room_bed` VALUES (619, 174, 'E308-2');
INSERT INTO `drom_room_bed` VALUES (620, 175, 'E309-1');
INSERT INTO `drom_room_bed` VALUES (621, 175, 'E309-2');
INSERT INTO `drom_room_bed` VALUES (622, 176, 'E310-1');
INSERT INTO `drom_room_bed` VALUES (623, 176, 'E310-2');
INSERT INTO `drom_room_bed` VALUES (624, 177, 'E311-1');
INSERT INTO `drom_room_bed` VALUES (625, 177, 'E311-2');
INSERT INTO `drom_room_bed` VALUES (626, 178, 'E312-1');
INSERT INTO `drom_room_bed` VALUES (627, 178, 'E312-2');
INSERT INTO `drom_room_bed` VALUES (628, 179, 'E313-1');
INSERT INTO `drom_room_bed` VALUES (629, 179, 'E313-2');
INSERT INTO `drom_room_bed` VALUES (630, 180, 'E314-1');
INSERT INTO `drom_room_bed` VALUES (631, 180, 'E314-2');
INSERT INTO `drom_room_bed` VALUES (632, 181, 'E315-1');
INSERT INTO `drom_room_bed` VALUES (633, 181, 'E315-2');
INSERT INTO `drom_room_bed` VALUES (634, 182, 'E316-1');
INSERT INTO `drom_room_bed` VALUES (635, 182, 'E316-2');
INSERT INTO `drom_room_bed` VALUES (636, 183, 'E317-1');
INSERT INTO `drom_room_bed` VALUES (637, 183, 'E317-2');
INSERT INTO `drom_room_bed` VALUES (638, 184, 'E318-1');
INSERT INTO `drom_room_bed` VALUES (639, 184, 'E318-2');
INSERT INTO `drom_room_bed` VALUES (640, 185, 'E319-1');
INSERT INTO `drom_room_bed` VALUES (641, 185, 'E319-2');
INSERT INTO `drom_room_bed` VALUES (642, 186, 'E320-1');
INSERT INTO `drom_room_bed` VALUES (643, 186, 'E320-2');
INSERT INTO `drom_room_bed` VALUES (644, 187, 'F601-1');
INSERT INTO `drom_room_bed` VALUES (645, 187, 'F601-2');
INSERT INTO `drom_room_bed` VALUES (646, 187, 'F601-3');
INSERT INTO `drom_room_bed` VALUES (647, 187, 'F601-4');
INSERT INTO `drom_room_bed` VALUES (648, 187, 'F601-5');
INSERT INTO `drom_room_bed` VALUES (649, 187, 'F601-6');
INSERT INTO `drom_room_bed` VALUES (650, 188, 'F602-1');
INSERT INTO `drom_room_bed` VALUES (651, 188, 'F602-2');
INSERT INTO `drom_room_bed` VALUES (652, 188, 'F602-3');
INSERT INTO `drom_room_bed` VALUES (653, 188, 'F602-4');
INSERT INTO `drom_room_bed` VALUES (654, 188, 'F602-5');
INSERT INTO `drom_room_bed` VALUES (655, 188, 'F602-6');
INSERT INTO `drom_room_bed` VALUES (656, 189, 'F603-1');
INSERT INTO `drom_room_bed` VALUES (657, 189, 'F603-2');
INSERT INTO `drom_room_bed` VALUES (658, 189, 'F603-3');
INSERT INTO `drom_room_bed` VALUES (659, 189, 'F603-4');
INSERT INTO `drom_room_bed` VALUES (660, 189, 'F603-5');
INSERT INTO `drom_room_bed` VALUES (661, 189, 'F603-6');
INSERT INTO `drom_room_bed` VALUES (662, 190, 'F604-1');
INSERT INTO `drom_room_bed` VALUES (663, 190, 'F604-2');
INSERT INTO `drom_room_bed` VALUES (664, 190, 'F604-3');
INSERT INTO `drom_room_bed` VALUES (665, 190, 'F604-4');
INSERT INTO `drom_room_bed` VALUES (666, 190, 'F604-5');
INSERT INTO `drom_room_bed` VALUES (667, 190, 'F604-6');
INSERT INTO `drom_room_bed` VALUES (668, 191, 'F605-1');
INSERT INTO `drom_room_bed` VALUES (669, 191, 'F605-2');
INSERT INTO `drom_room_bed` VALUES (670, 191, 'F605-3');
INSERT INTO `drom_room_bed` VALUES (671, 191, 'F605-4');
INSERT INTO `drom_room_bed` VALUES (672, 191, 'F605-5');
INSERT INTO `drom_room_bed` VALUES (673, 191, 'F605-6');
INSERT INTO `drom_room_bed` VALUES (674, 192, 'F606-1');
INSERT INTO `drom_room_bed` VALUES (675, 192, 'F606-2');
INSERT INTO `drom_room_bed` VALUES (676, 192, 'F606-3');
INSERT INTO `drom_room_bed` VALUES (677, 192, 'F606-4');
INSERT INTO `drom_room_bed` VALUES (678, 192, 'F606-5');
INSERT INTO `drom_room_bed` VALUES (679, 192, 'F606-6');
INSERT INTO `drom_room_bed` VALUES (680, 193, 'F607-1');
INSERT INTO `drom_room_bed` VALUES (681, 193, 'F607-2');
INSERT INTO `drom_room_bed` VALUES (682, 193, 'F607-3');
INSERT INTO `drom_room_bed` VALUES (683, 193, 'F607-4');
INSERT INTO `drom_room_bed` VALUES (684, 193, 'F607-5');
INSERT INTO `drom_room_bed` VALUES (685, 193, 'F607-6');
INSERT INTO `drom_room_bed` VALUES (686, 194, 'F608-1');
INSERT INTO `drom_room_bed` VALUES (687, 194, 'F608-2');
INSERT INTO `drom_room_bed` VALUES (688, 194, 'F608-3');
INSERT INTO `drom_room_bed` VALUES (689, 194, 'F608-4');
INSERT INTO `drom_room_bed` VALUES (690, 194, 'F608-5');
INSERT INTO `drom_room_bed` VALUES (691, 194, 'F608-6');
INSERT INTO `drom_room_bed` VALUES (692, 195, 'F609-1');
INSERT INTO `drom_room_bed` VALUES (693, 195, 'F609-2');
INSERT INTO `drom_room_bed` VALUES (694, 195, 'F609-3');
INSERT INTO `drom_room_bed` VALUES (695, 195, 'F609-4');
INSERT INTO `drom_room_bed` VALUES (696, 195, 'F609-5');
INSERT INTO `drom_room_bed` VALUES (697, 195, 'F609-6');
INSERT INTO `drom_room_bed` VALUES (698, 196, 'F610-1');
INSERT INTO `drom_room_bed` VALUES (699, 196, 'F610-2');
INSERT INTO `drom_room_bed` VALUES (700, 196, 'F610-3');
INSERT INTO `drom_room_bed` VALUES (701, 196, 'F610-4');
INSERT INTO `drom_room_bed` VALUES (702, 196, 'F610-5');
INSERT INTO `drom_room_bed` VALUES (703, 196, 'F610-6');
INSERT INTO `drom_room_bed` VALUES (704, 197, 'F611-1');
INSERT INTO `drom_room_bed` VALUES (705, 197, 'F611-2');
INSERT INTO `drom_room_bed` VALUES (706, 197, 'F611-3');
INSERT INTO `drom_room_bed` VALUES (707, 197, 'F611-4');
INSERT INTO `drom_room_bed` VALUES (708, 197, 'F611-5');
INSERT INTO `drom_room_bed` VALUES (709, 197, 'F611-6');
INSERT INTO `drom_room_bed` VALUES (710, 198, 'F612-1');
INSERT INTO `drom_room_bed` VALUES (711, 198, 'F612-2');
INSERT INTO `drom_room_bed` VALUES (712, 198, 'F612-3');
INSERT INTO `drom_room_bed` VALUES (713, 198, 'F612-4');
INSERT INTO `drom_room_bed` VALUES (714, 198, 'F612-5');
INSERT INTO `drom_room_bed` VALUES (715, 198, 'F612-6');
INSERT INTO `drom_room_bed` VALUES (716, 199, 'F613-1');
INSERT INTO `drom_room_bed` VALUES (717, 199, 'F613-2');
INSERT INTO `drom_room_bed` VALUES (718, 199, 'F613-3');
INSERT INTO `drom_room_bed` VALUES (719, 199, 'F613-4');
INSERT INTO `drom_room_bed` VALUES (720, 199, 'F613-5');
INSERT INTO `drom_room_bed` VALUES (721, 199, 'F613-6');
INSERT INTO `drom_room_bed` VALUES (722, 200, 'F614-1');
INSERT INTO `drom_room_bed` VALUES (723, 200, 'F614-2');
INSERT INTO `drom_room_bed` VALUES (724, 200, 'F614-3');
INSERT INTO `drom_room_bed` VALUES (725, 200, 'F614-4');
INSERT INTO `drom_room_bed` VALUES (726, 200, 'F614-5');
INSERT INTO `drom_room_bed` VALUES (727, 200, 'F614-6');
INSERT INTO `drom_room_bed` VALUES (728, 201, 'F615-1');
INSERT INTO `drom_room_bed` VALUES (729, 201, 'F615-2');
INSERT INTO `drom_room_bed` VALUES (730, 201, 'F615-3');
INSERT INTO `drom_room_bed` VALUES (731, 201, 'F615-4');
INSERT INTO `drom_room_bed` VALUES (732, 201, 'F615-5');
INSERT INTO `drom_room_bed` VALUES (733, 201, 'F615-6');
INSERT INTO `drom_room_bed` VALUES (734, 202, 'F616-1');
INSERT INTO `drom_room_bed` VALUES (735, 202, 'F616-2');
INSERT INTO `drom_room_bed` VALUES (736, 202, 'F616-3');
INSERT INTO `drom_room_bed` VALUES (737, 202, 'F616-4');
INSERT INTO `drom_room_bed` VALUES (738, 202, 'F616-5');
INSERT INTO `drom_room_bed` VALUES (739, 202, 'F616-6');
INSERT INTO `drom_room_bed` VALUES (740, 203, 'F617-1');
INSERT INTO `drom_room_bed` VALUES (741, 203, 'F617-2');
INSERT INTO `drom_room_bed` VALUES (742, 203, 'F617-3');
INSERT INTO `drom_room_bed` VALUES (743, 203, 'F617-4');
INSERT INTO `drom_room_bed` VALUES (744, 203, 'F617-5');
INSERT INTO `drom_room_bed` VALUES (745, 203, 'F617-6');
INSERT INTO `drom_room_bed` VALUES (746, 204, 'F618-1');
INSERT INTO `drom_room_bed` VALUES (747, 204, 'F618-2');
INSERT INTO `drom_room_bed` VALUES (748, 204, 'F618-3');
INSERT INTO `drom_room_bed` VALUES (749, 204, 'F618-4');
INSERT INTO `drom_room_bed` VALUES (750, 204, 'F618-5');
INSERT INTO `drom_room_bed` VALUES (751, 204, 'F618-6');
INSERT INTO `drom_room_bed` VALUES (752, 205, 'F619-1');
INSERT INTO `drom_room_bed` VALUES (753, 205, 'F619-2');
INSERT INTO `drom_room_bed` VALUES (754, 205, 'F619-3');
INSERT INTO `drom_room_bed` VALUES (755, 205, 'F619-4');
INSERT INTO `drom_room_bed` VALUES (756, 205, 'F619-5');
INSERT INTO `drom_room_bed` VALUES (757, 205, 'F619-6');
INSERT INTO `drom_room_bed` VALUES (758, 206, 'F620-1');
INSERT INTO `drom_room_bed` VALUES (759, 206, 'F620-2');
INSERT INTO `drom_room_bed` VALUES (760, 206, 'F620-3');
INSERT INTO `drom_room_bed` VALUES (761, 206, 'F620-4');
INSERT INTO `drom_room_bed` VALUES (762, 206, 'F620-5');
INSERT INTO `drom_room_bed` VALUES (763, 206, 'F620-6');
INSERT INTO `drom_room_bed` VALUES (764, 207, 'F621-1');
INSERT INTO `drom_room_bed` VALUES (765, 207, 'F621-2');
INSERT INTO `drom_room_bed` VALUES (766, 207, 'F621-3');
INSERT INTO `drom_room_bed` VALUES (767, 207, 'F621-4');
INSERT INTO `drom_room_bed` VALUES (768, 207, 'F621-5');
INSERT INTO `drom_room_bed` VALUES (769, 207, 'F621-6');
INSERT INTO `drom_room_bed` VALUES (770, 208, 'G701-1');
INSERT INTO `drom_room_bed` VALUES (771, 209, 'G702-1');
INSERT INTO `drom_room_bed` VALUES (772, 210, 'G703-1');
INSERT INTO `drom_room_bed` VALUES (773, 211, 'G704-1');
INSERT INTO `drom_room_bed` VALUES (774, 212, 'G705-1');
INSERT INTO `drom_room_bed` VALUES (775, 213, 'G706-1');
INSERT INTO `drom_room_bed` VALUES (776, 214, 'G707-1');
INSERT INTO `drom_room_bed` VALUES (777, 215, 'G708-1');
INSERT INTO `drom_room_bed` VALUES (778, 216, 'G709-1');
INSERT INTO `drom_room_bed` VALUES (779, 217, 'G710-1');
INSERT INTO `drom_room_bed` VALUES (780, 218, 'G711-1');
INSERT INTO `drom_room_bed` VALUES (781, 219, 'G712-1');
INSERT INTO `drom_room_bed` VALUES (782, 220, 'G713-1');
INSERT INTO `drom_room_bed` VALUES (783, 221, 'G714-1');
INSERT INTO `drom_room_bed` VALUES (784, 222, 'G715-1');
INSERT INTO `drom_room_bed` VALUES (785, 223, 'G716-1');
INSERT INTO `drom_room_bed` VALUES (786, 224, 'G717-1');
INSERT INTO `drom_room_bed` VALUES (787, 225, 'G718-1');
INSERT INTO `drom_room_bed` VALUES (788, 226, 'G719-1');
INSERT INTO `drom_room_bed` VALUES (789, 227, 'G720-1');
INSERT INTO `drom_room_bed` VALUES (790, 228, 'G721-1');
INSERT INTO `drom_room_bed` VALUES (791, 229, '9001-1');
INSERT INTO `drom_room_bed` VALUES (792, 229, '9001-2');
INSERT INTO `drom_room_bed` VALUES (793, 230, '9002-1');
INSERT INTO `drom_room_bed` VALUES (794, 230, '9002-2');
INSERT INTO `drom_room_bed` VALUES (795, 231, '9003-1');
INSERT INTO `drom_room_bed` VALUES (796, 231, '9003-2');
INSERT INTO `drom_room_bed` VALUES (797, 232, '9004-1');
INSERT INTO `drom_room_bed` VALUES (798, 232, '9004-2');
INSERT INTO `drom_room_bed` VALUES (799, 233, '9005-1');
INSERT INTO `drom_room_bed` VALUES (800, 233, '9005-2');
INSERT INTO `drom_room_bed` VALUES (801, 234, '9006-1');
INSERT INTO `drom_room_bed` VALUES (802, 234, '9006-2');
INSERT INTO `drom_room_bed` VALUES (803, 235, '9007-1');
INSERT INTO `drom_room_bed` VALUES (804, 235, '9007-2');
INSERT INTO `drom_room_bed` VALUES (805, 236, '9008-1');
INSERT INTO `drom_room_bed` VALUES (806, 236, '9008-2');
INSERT INTO `drom_room_bed` VALUES (807, 237, '9009-1');
INSERT INTO `drom_room_bed` VALUES (808, 237, '9009-2');
INSERT INTO `drom_room_bed` VALUES (809, 238, '9010-1');
INSERT INTO `drom_room_bed` VALUES (810, 238, '9010-2');
INSERT INTO `drom_room_bed` VALUES (811, 249, 'M501-1');
INSERT INTO `drom_room_bed` VALUES (812, 249, 'M501-2');
INSERT INTO `drom_room_bed` VALUES (813, 249, 'M501-3');
INSERT INTO `drom_room_bed` VALUES (814, 249, 'M501-4');
INSERT INTO `drom_room_bed` VALUES (815, 250, 'M502-1');
INSERT INTO `drom_room_bed` VALUES (816, 250, 'M502-2');
INSERT INTO `drom_room_bed` VALUES (817, 250, 'M502-3');
INSERT INTO `drom_room_bed` VALUES (818, 250, 'M502-4');
INSERT INTO `drom_room_bed` VALUES (819, 251, 'M503-1');
INSERT INTO `drom_room_bed` VALUES (820, 251, 'M503-2');
INSERT INTO `drom_room_bed` VALUES (821, 251, 'M503-3');
INSERT INTO `drom_room_bed` VALUES (822, 251, 'M503-4');
INSERT INTO `drom_room_bed` VALUES (823, 252, 'M504-1');
INSERT INTO `drom_room_bed` VALUES (824, 252, 'M504-2');
INSERT INTO `drom_room_bed` VALUES (825, 252, 'M504-3');
INSERT INTO `drom_room_bed` VALUES (826, 252, 'M504-4');
INSERT INTO `drom_room_bed` VALUES (827, 253, 'M505-1');
INSERT INTO `drom_room_bed` VALUES (828, 253, 'M505-2');
INSERT INTO `drom_room_bed` VALUES (829, 253, 'M505-3');
INSERT INTO `drom_room_bed` VALUES (830, 253, 'M505-4');
INSERT INTO `drom_room_bed` VALUES (831, 254, 'M506-1');
INSERT INTO `drom_room_bed` VALUES (832, 254, 'M506-2');
INSERT INTO `drom_room_bed` VALUES (833, 254, 'M506-3');
INSERT INTO `drom_room_bed` VALUES (834, 254, 'M506-4');
INSERT INTO `drom_room_bed` VALUES (835, 255, 'M507-1');
INSERT INTO `drom_room_bed` VALUES (836, 255, 'M507-2');
INSERT INTO `drom_room_bed` VALUES (837, 255, 'M507-3');
INSERT INTO `drom_room_bed` VALUES (838, 255, 'M507-4');
INSERT INTO `drom_room_bed` VALUES (839, 256, 'M508-1');
INSERT INTO `drom_room_bed` VALUES (840, 256, 'M508-2');
INSERT INTO `drom_room_bed` VALUES (841, 256, 'M508-3');
INSERT INTO `drom_room_bed` VALUES (842, 256, 'M508-4');
INSERT INTO `drom_room_bed` VALUES (843, 257, 'M509-1');
INSERT INTO `drom_room_bed` VALUES (844, 257, 'M509-2');
INSERT INTO `drom_room_bed` VALUES (845, 257, 'M509-3');
INSERT INTO `drom_room_bed` VALUES (846, 257, 'M509-4');
INSERT INTO `drom_room_bed` VALUES (847, 258, 'M510-1');
INSERT INTO `drom_room_bed` VALUES (848, 258, 'M510-2');
INSERT INTO `drom_room_bed` VALUES (849, 258, 'M510-3');
INSERT INTO `drom_room_bed` VALUES (850, 258, 'M510-4');

-- ----------------------------
-- Table structure for drom_storey
-- ----------------------------
DROP TABLE IF EXISTS `drom_storey`;
CREATE TABLE `drom_storey`  (
  `storey_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '层数id',
  `build_id` int(11) NULL DEFAULT NULL COMMENT '栋数id',
  `storey_name` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '层名称',
  `order_num` int(11) NULL DEFAULT NULL COMMENT '序号',
  PRIMARY KEY (`storey_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 94 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of drom_storey
-- ----------------------------
INSERT INTO `drom_storey` VALUES (17, 3, '一层', 1);
INSERT INTO `drom_storey` VALUES (18, 3, '二层', 2);
INSERT INTO `drom_storey` VALUES (19, 3, '三层', 3);
INSERT INTO `drom_storey` VALUES (20, 3, '四层', 4);
INSERT INTO `drom_storey` VALUES (21, 3, '五层', 5);
INSERT INTO `drom_storey` VALUES (22, 4, '一层', 1);
INSERT INTO `drom_storey` VALUES (23, 4, '二层', 2);
INSERT INTO `drom_storey` VALUES (24, 4, '三层', 3);
INSERT INTO `drom_storey` VALUES (25, 4, '四层', 4);
INSERT INTO `drom_storey` VALUES (26, 4, '五层', 5);
INSERT INTO `drom_storey` VALUES (27, 4, '六层', 6);
INSERT INTO `drom_storey` VALUES (28, 4, '七层', 7);
INSERT INTO `drom_storey` VALUES (29, 4, '八层', 8);
INSERT INTO `drom_storey` VALUES (30, 4, '九层', 9);
INSERT INTO `drom_storey` VALUES (32, 5, '一层', 1);
INSERT INTO `drom_storey` VALUES (33, 5, '二层', 2);
INSERT INTO `drom_storey` VALUES (34, 5, '三层', 3);
INSERT INTO `drom_storey` VALUES (35, 5, '四层', 4);
INSERT INTO `drom_storey` VALUES (36, 5, '五层', 5);
INSERT INTO `drom_storey` VALUES (37, 5, '六层', 6);
INSERT INTO `drom_storey` VALUES (38, 6, '一层', 1);
INSERT INTO `drom_storey` VALUES (39, 6, '二层', 2);
INSERT INTO `drom_storey` VALUES (40, 6, '三层', 3);
INSERT INTO `drom_storey` VALUES (41, 6, '四层', 4);
INSERT INTO `drom_storey` VALUES (44, 6, '五层', 5);
INSERT INTO `drom_storey` VALUES (45, 7, '一层', 1);
INSERT INTO `drom_storey` VALUES (46, 7, '二层', 2);
INSERT INTO `drom_storey` VALUES (47, 7, '三层', 3);
INSERT INTO `drom_storey` VALUES (48, 7, '四层', 4);
INSERT INTO `drom_storey` VALUES (49, 7, '五层', 5);
INSERT INTO `drom_storey` VALUES (50, 7, '六层', 6);
INSERT INTO `drom_storey` VALUES (51, 8, '一层', 1);
INSERT INTO `drom_storey` VALUES (52, 8, '二层', 2);
INSERT INTO `drom_storey` VALUES (53, 8, '三层', 3);
INSERT INTO `drom_storey` VALUES (54, 8, '四层', 4);
INSERT INTO `drom_storey` VALUES (55, 8, '五层', 5);
INSERT INTO `drom_storey` VALUES (56, 8, '六层', 6);
INSERT INTO `drom_storey` VALUES (57, 9, '一层', 1);
INSERT INTO `drom_storey` VALUES (58, 9, '二层', 2);
INSERT INTO `drom_storey` VALUES (59, 9, '三层', 3);
INSERT INTO `drom_storey` VALUES (60, 9, '四层', 4);
INSERT INTO `drom_storey` VALUES (61, 9, '五层', 5);
INSERT INTO `drom_storey` VALUES (62, 9, '六层', 6);
INSERT INTO `drom_storey` VALUES (63, 10, '一层', 1);
INSERT INTO `drom_storey` VALUES (64, 10, '二层', 2);
INSERT INTO `drom_storey` VALUES (65, 10, '三层', 3);
INSERT INTO `drom_storey` VALUES (66, 10, '四层', 4);
INSERT INTO `drom_storey` VALUES (67, 10, '五层', 5);
INSERT INTO `drom_storey` VALUES (68, 10, '六层', 6);
INSERT INTO `drom_storey` VALUES (69, 11, '一层', 1);
INSERT INTO `drom_storey` VALUES (70, 11, '二层', 2);
INSERT INTO `drom_storey` VALUES (71, 11, '三层', 3);
INSERT INTO `drom_storey` VALUES (72, 11, '四层', 4);
INSERT INTO `drom_storey` VALUES (73, 11, '五层', 5);
INSERT INTO `drom_storey` VALUES (74, 11, '六层', 6);
INSERT INTO `drom_storey` VALUES (75, 12, '一层', 1);
INSERT INTO `drom_storey` VALUES (76, 12, '二层', 2);
INSERT INTO `drom_storey` VALUES (77, 12, '三层', 3);
INSERT INTO `drom_storey` VALUES (78, 12, '四层', 4);
INSERT INTO `drom_storey` VALUES (79, 12, '五层', 5);
INSERT INTO `drom_storey` VALUES (80, 12, '六层', 6);
INSERT INTO `drom_storey` VALUES (82, 3, '六层', 6);
INSERT INTO `drom_storey` VALUES (83, 4, '10层', 10);
INSERT INTO `drom_storey` VALUES (84, 4, '11层', 11);
INSERT INTO `drom_storey` VALUES (85, 4, '12层', 12);
INSERT INTO `drom_storey` VALUES (86, 13, '一层', 1);
INSERT INTO `drom_storey` VALUES (87, 13, '二层', 2);
INSERT INTO `drom_storey` VALUES (88, 13, '三层', 3);
INSERT INTO `drom_storey` VALUES (89, 13, '四层', 4);
INSERT INTO `drom_storey` VALUES (90, 13, '五层', 5);
INSERT INTO `drom_storey` VALUES (91, 13, '六层', 6);
INSERT INTO `drom_storey` VALUES (92, 13, '七层', 7);
INSERT INTO `drom_storey` VALUES (93, 13, '八层', 8);

-- ----------------------------
-- Table structure for school_class
-- ----------------------------
DROP TABLE IF EXISTS `school_class`;
CREATE TABLE `school_class`  (
  `class_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '班级id',
  `major_id` int(11) NULL DEFAULT NULL COMMENT '专业id',
  `class_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '班级名称',
  `class_year` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '招生年份',
  `order_num` int(11) NULL DEFAULT NULL COMMENT '序号',
  PRIMARY KEY (`class_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of school_class
-- ----------------------------
INSERT INTO `school_class` VALUES (1, 4, '单片机技术1班', '2021', 1);
INSERT INTO `school_class` VALUES (2, 2, '人工智能专业1班', '2020', 2);
INSERT INTO `school_class` VALUES (3, 1, '软件工程1班', '2022', 3);
INSERT INTO `school_class` VALUES (4, 5, '汉语语言文学1班', '2022', 4);
INSERT INTO `school_class` VALUES (5, 6, '材料成型及其控制技术1班', '2021', 5);
INSERT INTO `school_class` VALUES (6, 6, '机械制造及其自动化1班', '2022', 6);
INSERT INTO `school_class` VALUES (7, 1, '嵌入式软件工程1班', '2022', 7);
INSERT INTO `school_class` VALUES (8, 2, '人工智能专业2班', '2021', 8);
INSERT INTO `school_class` VALUES (9, 1, '计算机科学与技术', '2022', 9);
INSERT INTO `school_class` VALUES (10, 13, '网络工程', '2022', 11);
INSERT INTO `school_class` VALUES (11, 9, '电子与计算机工程', '2022', 13);
INSERT INTO `school_class` VALUES (12, 2, '数据科学与大数据技术', '2022', 14);

-- ----------------------------
-- Table structure for school_collage
-- ----------------------------
DROP TABLE IF EXISTS `school_collage`;
CREATE TABLE `school_collage`  (
  `collage_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '学院id',
  `collage_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '学院名称',
  `order_num` int(11) NULL DEFAULT NULL COMMENT '序号',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`collage_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of school_collage
-- ----------------------------
INSERT INTO `school_collage` VALUES (1, '软件工程学院', 1, '2022-03-17 22:18:42');
INSERT INTO `school_collage` VALUES (2, '电子信息工程学院', 2, '2022-03-17 22:19:25');
INSERT INTO `school_collage` VALUES (3, '文理学院', 3, '2022-04-01 14:06:35');
INSERT INTO `school_collage` VALUES (4, '机械工程学院', 4, '2022-04-01 14:06:51');
INSERT INTO `school_collage` VALUES (5, '化学工程学院', 5, '2022-04-10 23:08:51');

-- ----------------------------
-- Table structure for school_major
-- ----------------------------
DROP TABLE IF EXISTS `school_major`;
CREATE TABLE `school_major`  (
  `major_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '专业id',
  `collage_id` int(11) NULL DEFAULT NULL COMMENT '学院id',
  `major_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '专业名称',
  `order_num` int(11) NULL DEFAULT NULL COMMENT '序号',
  PRIMARY KEY (`major_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of school_major
-- ----------------------------
INSERT INTO `school_major` VALUES (1, 1, '软件工程专业', 1);
INSERT INTO `school_major` VALUES (2, 1, '人工智能专业', 2);
INSERT INTO `school_major` VALUES (4, 2, '单片机技术', 3);
INSERT INTO `school_major` VALUES (5, 3, '汉语语言文学', 4);
INSERT INTO `school_major` VALUES (6, 4, '机械制造及其自动化', 5);
INSERT INTO `school_major` VALUES (7, 3, '应用物理学', 6);
INSERT INTO `school_major` VALUES (8, 2, '量子信息科学', 7);
INSERT INTO `school_major` VALUES (9, 2, '电子科学与技术', 8);
INSERT INTO `school_major` VALUES (10, 2, '通信工程', 9);
INSERT INTO `school_major` VALUES (11, 2, '微电子科学与工程', 10);
INSERT INTO `school_major` VALUES (12, 2, '集成电路设计与集成系统', 11);
INSERT INTO `school_major` VALUES (13, 1, '物联网工程', 12);
INSERT INTO `school_major` VALUES (14, 1, '电子与计算机工程', 13);

-- ----------------------------
-- Table structure for school_student
-- ----------------------------
DROP TABLE IF EXISTS `school_student`;
CREATE TABLE `school_student`  (
  `stu_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '学生id',
  `class_id` int(11) NULL DEFAULT NULL COMMENT '班级id',
  `stu_name` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '姓名',
  `sex` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '性别 0:男 1：女',
  `stu_num` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '学号',
  `id_card` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '身份证',
  `phone` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '手机号',
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '密码',
  PRIMARY KEY (`stu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 45 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of school_student
-- ----------------------------
INSERT INTO `school_student` VALUES (7, 1, '张三', '1', '2022001', '561231321', '134564646', 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `school_student` VALUES (8, 3, '李四', '0', '2022002', '4564112313', '5613121312', '202cb962ac59075b964b07152d234b70');
INSERT INTO `school_student` VALUES (9, 3, 'cs', '0', '20220325', '45613132', '18687116223', 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `school_student` VALUES (10, 1, 'cs11', '0', '2020001', '45613131231', '1321312323', '202cb962ac59075b964b07152d234b70');
INSERT INTO `school_student` VALUES (11, 2, '张丽', '1', '20200012', '4561321312', '18787171906', 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `school_student` VALUES (12, 4, '李华', '0', '2019001', '45613132', '1346465466', 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `school_student` VALUES (13, 1, '测试', '0', '2022009', '46513212313', '131312313', 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `school_student` VALUES (14, 3, '张明华', '0', '2022110', '45612312313', '18787171906', 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `school_student` VALUES (15, 3, '李林章', '0', '2022111', '1231456465', '461132132', 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `school_student` VALUES (21, 3, 'cs2', '0', '2022112', '13465464564', '46513123', 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `school_student` VALUES (22, 3, 'cs3', '0', '2022113', '134654641321', '1646456', 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `school_student` VALUES (23, 3, 'cs4', '0', '2022114', '13464654646', '1346546546', 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `school_student` VALUES (24, 3, 'cd5', '0', '2022115', '12345646456', '134564656', 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `school_student` VALUES (25, 10, '李一', '0', '2022221', '45431321323', '14563132132', 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `school_student` VALUES (26, 11, '李二', '0', '2022222', '456131312313', '45613213213', 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `school_student` VALUES (27, 5, '李三', '0', '20222223', '41234654613213', '156454431312', 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `school_student` VALUES (28, 12, '李五', '0', '20222224', '1654313213213', '12345646323', 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `school_student` VALUES (29, 7, '李流', '0', '2023110', '1564313213123', '164564646546', 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `school_student` VALUES (30, 6, '李琦', '0', '2030001', '4561321321323', '1564645646', 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `school_student` VALUES (31, 6, '篱笆', '1', '2030002', '45613131213', '1564631323', 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `school_student` VALUES (32, 2, '李九', '1', '2030004', '4561313123213', '14564453132', 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `school_student` VALUES (33, 9, '历时', '0', '2030110', '456461313213', '14564643132', 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `school_student` VALUES (34, 9, '了十一', '0', '2030115', '456131233', '1645646546', 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `school_student` VALUES (35, 8, '张三亿', '1', '2030118', '465413213', '1456464564', 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `school_student` VALUES (36, 10, '溧水区', '1', '2030189', '456132131232', '16546445646', 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `school_student` VALUES (37, 5, '赵明刚', '0', '2030119', '456132131232', '1464646544', 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `school_student` VALUES (38, 9, 'test010', '0', '2022990', '1564654646456', '1456464566', 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `school_student` VALUES (39, 4, 'test009', '0', '20220911', '4564613121323', '1564646456', 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `school_student` VALUES (44, 3, '张明飞', '0', '202211346464664', '52456464646464645', '1467897979879', 'f379eaf3c831b04de153469d1bec345e');

-- ----------------------------
-- Table structure for select_bed
-- ----------------------------
DROP TABLE IF EXISTS `select_bed`;
CREATE TABLE `select_bed`  (
  `select_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `bed_id` int(11) NULL DEFAULT NULL COMMENT '床位id',
  `stu_id` int(11) NULL DEFAULT NULL COMMENT '学生id',
  PRIMARY KEY (`select_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of select_bed
-- ----------------------------
INSERT INTO `select_bed` VALUES (18, 40, 7);
INSERT INTO `select_bed` VALUES (19, 791, 28);
INSERT INTO `select_bed` VALUES (20, 650, 31);
INSERT INTO `select_bed` VALUES (21, 651, 30);
INSERT INTO `select_bed` VALUES (22, 805, 27);
INSERT INTO `select_bed` VALUES (23, 773, 12);
INSERT INTO `select_bed` VALUES (24, 644, 26);
INSERT INTO `select_bed` VALUES (25, 774, 34);
INSERT INTO `select_bed` VALUES (26, 604, 11);
INSERT INTO `select_bed` VALUES (27, 606, 32);
INSERT INTO `select_bed` VALUES (28, 609, 35);
INSERT INTO `select_bed` VALUES (29, 140, 36);
INSERT INTO `select_bed` VALUES (30, 528, 37);
INSERT INTO `select_bed` VALUES (32, 777, 39);

-- ----------------------------
-- Table structure for stu_role
-- ----------------------------
DROP TABLE IF EXISTS `stu_role`;
CREATE TABLE `stu_role`  (
  `stu_role_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `stu_id` int(11) NULL DEFAULT NULL COMMENT '学生id',
  `role_id` int(11) NULL DEFAULT NULL COMMENT '角色id',
  PRIMARY KEY (`stu_role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 37 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stu_role
-- ----------------------------
INSERT INTO `stu_role` VALUES (7, 8, 4);
INSERT INTO `stu_role` VALUES (9, 9, 4);
INSERT INTO `stu_role` VALUES (10, 7, 4);
INSERT INTO `stu_role` VALUES (11, 10, 4);
INSERT INTO `stu_role` VALUES (12, 11, 4);
INSERT INTO `stu_role` VALUES (13, 12, 4);
INSERT INTO `stu_role` VALUES (14, 13, 4);
INSERT INTO `stu_role` VALUES (15, 14, 4);
INSERT INTO `stu_role` VALUES (16, 15, 4);
INSERT INTO `stu_role` VALUES (17, 21, 4);
INSERT INTO `stu_role` VALUES (18, 22, 4);
INSERT INTO `stu_role` VALUES (19, 23, 4);
INSERT INTO `stu_role` VALUES (20, 24, 4);
INSERT INTO `stu_role` VALUES (21, 25, 4);
INSERT INTO `stu_role` VALUES (22, 26, 4);
INSERT INTO `stu_role` VALUES (23, 27, 4);
INSERT INTO `stu_role` VALUES (24, 28, 4);
INSERT INTO `stu_role` VALUES (25, 29, 4);
INSERT INTO `stu_role` VALUES (26, 30, 4);
INSERT INTO `stu_role` VALUES (27, 31, 4);
INSERT INTO `stu_role` VALUES (28, 32, 4);
INSERT INTO `stu_role` VALUES (29, 33, 4);
INSERT INTO `stu_role` VALUES (30, 34, 4);
INSERT INTO `stu_role` VALUES (31, 35, 4);
INSERT INTO `stu_role` VALUES (32, 36, 4);
INSERT INTO `stu_role` VALUES (33, 37, 4);
INSERT INTO `stu_role` VALUES (34, 38, 4);
INSERT INTO `stu_role` VALUES (35, 39, 4);
INSERT INTO `stu_role` VALUES (36, 44, 4);

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '菜单id',
  `parent_id` int(11) NULL DEFAULT NULL COMMENT '父级菜单id',
  `title` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '菜单名称',
  `code` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '权限字段',
  `name` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '路由name',
  `path` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '路由path',
  `url` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '组件路径',
  `type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '类型(0 目录 1菜单，2按钮)',
  `icon` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '菜单图标',
  `parent_name` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '上级菜单名称',
  `order_num` int(11) NULL DEFAULT NULL COMMENT '序号',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 75 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, 0, '系统管理', 'sys:system:index', 'system', '/system', '', '0', 'el-icon-s-tools', '顶级菜单', 1, '2021-12-04 18:52:39', '2022-03-30 18:49:51');
INSERT INTO `sys_menu` VALUES (2, 1, '用户管理', 'sys:userList:index', 'sysUserList', '/sysUserList', '/system/sysUserList', '1', 'el-icon-s-check', '系统管理', 1, '2021-12-04 18:59:44', '2022-03-30 18:50:33');
INSERT INTO `sys_menu` VALUES (3, 2, '新增', 'sys:user:add', '', '', '', '2', '', '用户管理', 1, '2022-03-16 21:58:35', NULL);
INSERT INTO `sys_menu` VALUES (4, 2, '编辑', 'sys:user:edit', '', '', '', '2', '', '用户管理', 2, '2022-03-16 21:59:00', NULL);
INSERT INTO `sys_menu` VALUES (5, 2, '删除', 'sys:user:delete', '', '', '', '2', '', '用户管理', 3, '2022-03-30 18:53:38', NULL);
INSERT INTO `sys_menu` VALUES (6, 1, '角色管理', 'sys:sysRoleList:index', 'sysRoleList', '/sysRoleList', '/system/sysRoleList', '1', 'tree', '系统管理', 2, '2022-03-30 18:55:07', NULL);
INSERT INTO `sys_menu` VALUES (7, 6, '新增', 'sys:sysRoleList:add', '', '', '', '2', '', '角色管理', 1, '2022-03-30 18:55:32', NULL);
INSERT INTO `sys_menu` VALUES (8, 6, '编辑', 'sys:sysRoleList:edit', '', '', '', '2', '', '角色管理', 2, '2022-03-30 18:56:38', NULL);
INSERT INTO `sys_menu` VALUES (9, 6, '删除', 'sys:sysRoleList:delete', '', '', '', '2', '', '角色管理', 3, '2022-03-30 18:57:01', NULL);
INSERT INTO `sys_menu` VALUES (10, 1, '菜单管理', 'sys:sysMenuList:index', 'sysMenuList', '/sysMenuList', '/system/sysMenuList', '1', 'tree', '系统管理', 3, '2022-03-30 18:58:16', NULL);
INSERT INTO `sys_menu` VALUES (11, 10, '新增', 'sys:sysMenuList:add', '', '', '', '2', '', '菜单管理', 1, '2022-03-30 18:58:34', NULL);
INSERT INTO `sys_menu` VALUES (12, 10, '编辑', 'sys:sysMenuList:edit', '', '', '', '2', '', '菜单管理', 2, '2022-03-30 18:58:51', NULL);
INSERT INTO `sys_menu` VALUES (13, 10, '删除', 'sys:sysMenuList:delete', '', '', '', '2', '', '菜单管理', 3, '2022-03-30 18:59:08', NULL);
INSERT INTO `sys_menu` VALUES (14, 0, '学院管理', 'sys:colloge:index', 'colloge', '/colloge', '', '0', 'el-icon-s-help', '顶级菜单', 3, '2022-03-30 19:00:21', NULL);
INSERT INTO `sys_menu` VALUES (15, 14, '学院管理', 'sys:collogeList:index', 'collogeList', '/collogeList', '/colloge/collogeList', '1', 'table', '学院管理', 1, '2022-03-30 19:01:29', NULL);
INSERT INTO `sys_menu` VALUES (16, 15, '新增', 'sys:collogeList:add', '', '', '', '2', '', '学院管理', 1, '2022-03-30 19:01:52', NULL);
INSERT INTO `sys_menu` VALUES (17, 15, '编辑', 'sys:collogeList:edit', '', '', '', '2', '', '学院管理', 2, '2022-03-30 19:02:08', NULL);
INSERT INTO `sys_menu` VALUES (18, 15, '删除', 'sys:collogeList:delete', '', '', '', '2', '', '学院管理', 3, '2022-03-30 19:02:25', NULL);
INSERT INTO `sys_menu` VALUES (19, 14, '专业管理', 'sys:majorList:index', 'majorList', '/majorList', '/colloge/majorList', '1', 'tree', '学院管理', 2, '2022-03-30 19:03:21', NULL);
INSERT INTO `sys_menu` VALUES (20, 19, '新增', 'sys:majorList:add', '', '', '', '2', '', '专业管理', 1, '2022-03-30 19:03:43', NULL);
INSERT INTO `sys_menu` VALUES (21, 19, '编辑', 'sys:majorList:edit', '', '', '', '2', '', '专业管理', 2, '2022-03-30 19:03:58', NULL);
INSERT INTO `sys_menu` VALUES (22, 19, '删除', 'sys:majorList:delete', '', '', '', '2', '', '专业管理', 3, '2022-03-30 19:04:15', NULL);
INSERT INTO `sys_menu` VALUES (23, 14, '班级管理', 'sys:classList:index', 'classList', '/classList', '/colloge/classList', '1', 'tree', '学院管理', 3, '2022-03-30 19:05:11', NULL);
INSERT INTO `sys_menu` VALUES (24, 23, '新增', 'sys:classList:add', '', '', '', '2', '', '班级管理', 1, '2022-03-30 19:05:27', NULL);
INSERT INTO `sys_menu` VALUES (25, 23, '编辑', 'sys:classList:edie', '', '', '', '2', '', '班级管理', 2, '2022-03-30 19:05:46', NULL);
INSERT INTO `sys_menu` VALUES (26, 23, '删除', 'sys:classList:delete', '', '', '', '2', '', '班级管理', 3, '2022-03-30 19:06:01', NULL);
INSERT INTO `sys_menu` VALUES (27, 0, '学生管理', 'sys:stuRoot:index', 'stuRoot', '/stuRoot', '', '0', 'el-icon-s-help', '顶级菜单', 4, '2022-03-30 19:07:15', NULL);
INSERT INTO `sys_menu` VALUES (28, 27, '学生列表', 'sys:stuList:index', 'stuList', '/stuList', '/student/stuList', '1', 'table', '学生管理', 5, '2022-03-30 19:08:12', NULL);
INSERT INTO `sys_menu` VALUES (29, 28, '新增', 'sys:stuList:add', '', '', '', '2', '', '学生列表', 1, '2022-03-30 19:08:28', NULL);
INSERT INTO `sys_menu` VALUES (30, 28, '编辑', 'sys:stuList:edit', '', '', '', '2', '', '学生列表', 2, '2022-03-30 19:08:43', NULL);
INSERT INTO `sys_menu` VALUES (31, 28, '删除', 'sys:stuList:delete', '', '', '', '2', '', '学生列表', 3, '2022-03-30 19:08:57', NULL);
INSERT INTO `sys_menu` VALUES (32, 0, '宿舍管理', 'sys:buildRoot:index', 'buildRoot', '/buildRoot', '', '0', 'el-icon-s-help', '顶级菜单', 6, '2022-03-30 19:09:55', NULL);
INSERT INTO `sys_menu` VALUES (33, 32, '楼栋管理', 'sys:buildList:index', 'buildList', '/buildList', '/drom/buildList', '1', 'table', '宿舍管理', 7, '2022-03-30 19:11:01', NULL);
INSERT INTO `sys_menu` VALUES (34, 33, '新增', 'sys:buildList:add', '', '', '', '2', '', '楼栋管理', 1, '2022-03-30 19:11:16', NULL);
INSERT INTO `sys_menu` VALUES (35, 33, '编辑', 'sys:buildList:edit', '', '', '', '2', '', '楼栋管理', 2, '2022-03-30 19:11:32', NULL);
INSERT INTO `sys_menu` VALUES (36, 33, '删除', 'sys:buildList:delete', '', '', '', '2', '', '楼栋管理', 3, '2022-03-30 19:11:50', NULL);
INSERT INTO `sys_menu` VALUES (37, 32, '设置编号', 'sys:buildCode:index', 'buildCode', '/buildCode', '/drom/buildCode', '1', 'table', '宿舍管理', 8, '2022-03-30 19:12:43', NULL);
INSERT INTO `sys_menu` VALUES (38, 37, '设置编号', 'sys:buildCode:add', '', '', '', '2', '', '设置编号', 1, '2022-03-30 19:12:57', '2022-04-11 15:17:21');
INSERT INTO `sys_menu` VALUES (41, 32, '宿舍管理', 'sys:houseList:index', 'houseList', '/houseList', '/drom/houseList', '1', 'table', '宿舍管理', 10, '2022-03-30 19:14:18', '2022-03-31 18:55:48');
INSERT INTO `sys_menu` VALUES (42, 41, '新增', 'sys:houseList:add', '', '', '', '2', '', '宿舍管理', 1, '2022-03-30 19:14:30', NULL);
INSERT INTO `sys_menu` VALUES (43, 37, '初始化床位', 'sys:buildCode:initBed', '', '', '', '2', '', '设置编号', 4, '2022-03-30 19:15:51', NULL);
INSERT INTO `sys_menu` VALUES (44, 32, '选择宿舍', 'sys:selectBed:index', 'selectBed', '/selectBed', '/drom/selectBed', '1', 'table', '宿舍管理', 11, '2022-03-30 19:17:55', '2022-03-31 18:55:38');
INSERT INTO `sys_menu` VALUES (45, 44, '选择', 'sys:selectBed:select', '', '', '', '2', '', '选择宿舍', 1, '2022-03-30 19:19:25', NULL);
INSERT INTO `sys_menu` VALUES (49, 32, '分配宿舍', 'sys:assignRoom:index', 'assignRoom', '/assignRoom', '/drom/assignRoom', '1', 'table', '宿舍管理', 10, '2022-04-01 17:38:32', NULL);
INSERT INTO `sys_menu` VALUES (50, 49, '分配', 'sys:assignRoom:add', '', '', '', '2', '', '分配宿舍', 1, '2022-04-01 17:39:29', NULL);
INSERT INTO `sys_menu` VALUES (51, 32, '我的宿舍', 'sys:drom:myBed', 'myBed', '/myBed', '/drom/myBed', '1', 'table', '宿舍管理', 15, '2022-04-05 11:55:12', NULL);
INSERT INTO `sys_menu` VALUES (52, 32, '调换申请', 'sys:applyList:index', 'applyList', '/applyList', '/drom/applyList', '1', 'table', '宿舍管理', 17, '2022-04-06 18:19:03', NULL);
INSERT INTO `sys_menu` VALUES (53, 52, '同意', 'sys:applyList:apply', '', '', '', '2', '', '调换申请', 1, '2022-04-06 18:37:52', NULL);
INSERT INTO `sys_menu` VALUES (54, 52, '拒绝', 'sys:applyList:return', '', '', '', '2', '', '调换申请', 2, '2022-04-06 18:38:17', NULL);
INSERT INTO `sys_menu` VALUES (55, 0, '考勤管理', 'sys:leave:leaveRoot', 'leaveRoot', '/leaveRoot', '', '0', 'table', '顶级菜单', 7, '2022-04-08 09:01:06', '2022-04-08 09:05:46');
INSERT INTO `sys_menu` VALUES (56, 55, '缺勤管理', 'sys:dromLeave:index', 'dromLeave', '/dromLeave', '/leave/index', '1', 'table', '考勤管理', 1, '2022-04-08 09:02:20', NULL);
INSERT INTO `sys_menu` VALUES (57, 0, '报修管理', 'sys:repairRoot:index', 'repairRoot', '/repairRoot', '', '0', 'table', '顶级菜单', 8, '2022-04-08 18:56:51', NULL);
INSERT INTO `sys_menu` VALUES (58, 57, '报修列表', 'sys:repair:index', 'repair', '/repair', '/repair/index', '1', 'table', '报修管理', 1, '2022-04-08 18:57:47', NULL);
INSERT INTO `sys_menu` VALUES (59, 0, '出入登记', 'sys:rootInto:index', 'rootInto', '/rootInto', '', '0', 'table', '顶级菜单', 9, '2022-04-09 12:47:16', '2022-04-09 12:47:39');
INSERT INTO `sys_menu` VALUES (60, 59, '物品出入登记', 'sys:thingsInto:index', 'thingsInto', '/thingsInto', '/into/things', '1', 'table', '出入登记', 1, '2022-04-09 12:48:48', NULL);
INSERT INTO `sys_menu` VALUES (61, 59, '来访人员登记', 'sys:userInto:index', 'userInto', '/userInto', '/into/user', '1', 'table', '出入登记', 2, '2022-04-09 12:49:51', NULL);
INSERT INTO `sys_menu` VALUES (62, 0, '公告管理', 'sys:rootNotice', 'rootNotice', '/rootNotice', '', '0', 'table', '顶级菜单', 10, '2022-04-10 15:15:48', NULL);
INSERT INTO `sys_menu` VALUES (63, 62, '公告列表', 'sys:sysNotice:index', 'sysNotice', '/sysNotice', '/notice/index', '1', 'table', '公告管理', 1, '2022-04-10 15:16:53', NULL);
INSERT INTO `sys_menu` VALUES (64, 63, '新增', 'sys:sysNotice:add', '', '', '', '2', '', '公告列表', 1, '2022-04-11 13:22:08', NULL);
INSERT INTO `sys_menu` VALUES (65, 63, '编辑', 'sys:sysNotice:edit', '', '', '', '2', '', '公告列表', 2, '2022-04-11 13:22:27', NULL);
INSERT INTO `sys_menu` VALUES (66, 63, '删除', 'sys:sysNotice:delete', '', '', '', '2', '', '公告列表', 3, '2022-04-11 13:22:50', NULL);
INSERT INTO `sys_menu` VALUES (67, 58, '新增', 'sys:repair:add', '', '', '', '2', '', '报修列表', 1, '2022-04-11 14:52:01', NULL);
INSERT INTO `sys_menu` VALUES (68, 58, '编辑', 'sys:repair:edit', '', '', '', '2', '', '报修列表', 2, '2022-04-11 14:52:17', NULL);
INSERT INTO `sys_menu` VALUES (69, 58, '删除', 'sys:repair:delete', '', '', '', '2', '', '报修列表', 3, '2022-04-11 14:52:34', NULL);
INSERT INTO `sys_menu` VALUES (70, 58, '处理', 'sys:repair:apply', '', '', '', '2', '', '报修列表', 4, '2022-04-11 14:54:04', '2022-04-11 14:54:35');
INSERT INTO `sys_menu` VALUES (71, 63, '查看', 'sys:sysNotice:look', '', '', '', '2', '', '公告列表', 1, '2022-04-11 14:59:01', NULL);
INSERT INTO `sys_menu` VALUES (72, 6, '分配权限', 'sys:sysRoleList:assign', '', '', '', '2', '', '角色管理', 4, '2022-04-11 15:03:25', NULL);
INSERT INTO `sys_menu` VALUES (73, 33, '新增层数', 'sys:buildList:addStorey', '', '', '', '2', '', '楼栋管理', 4, '2022-04-11 15:15:01', NULL);
INSERT INTO `sys_menu` VALUES (74, 28, '重置密码', 'sys:stuList:reset', '', '', '', '2', '', '学生列表', 4, '2022-04-11 15:25:26', NULL);

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `notice_title` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '公告标题',
  `notice_text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '公告内容',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `types` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '0：普通 1：敏感',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (2, '放假通知', '放假时间为 2022-01-10放到 2022-3-03-01，大家关好门窗。', '2022-04-10 15:37:06', '0');
INSERT INTO `sys_notice` VALUES (3, '核酸检测通知', '请大家于明天中午准时参加。', '2022-04-10 15:52:45', '0');
INSERT INTO `sys_notice` VALUES (4, '丢失的饭卡', '张明芳+20220011588+在学校三食堂一楼捡到一张饭卡，请到学校后勤部领取。', '2022-09-24 10:56:50', '1');
INSERT INTO `sys_notice` VALUES (5, '国庆放假通知', '国庆节10月1日至7日放假调休，共7天，10月8日（星期六）、10月9日（星期日）上班。', '2022-09-24 12:14:48', '0');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色id',
  `role_name` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '角色名称',
  `role_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '角色类型 1：系统用户  2：学生',
  `remark` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (4, '学生角色', '2', '学生角色', '2021-12-01 17:51:43', '2022-03-23 12:25:36');
INSERT INTO `sys_role` VALUES (5, '管理员', '1', '管理员', '2022-04-04 14:52:08', NULL);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_menu_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `role_id` int(11) NULL DEFAULT NULL COMMENT '角色id',
  `menu_id` int(11) NULL DEFAULT NULL COMMENT '菜单id',
  PRIMARY KEY (`role_menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1114 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (162, 1, 1);
INSERT INTO `sys_role_menu` VALUES (163, 1, 2);
INSERT INTO `sys_role_menu` VALUES (164, 1, 3);
INSERT INTO `sys_role_menu` VALUES (165, 1, 4);
INSERT INTO `sys_role_menu` VALUES (166, 1, 5);
INSERT INTO `sys_role_menu` VALUES (167, 1, 6);
INSERT INTO `sys_role_menu` VALUES (168, 1, 7);
INSERT INTO `sys_role_menu` VALUES (169, 1, 8);
INSERT INTO `sys_role_menu` VALUES (170, 1, 9);
INSERT INTO `sys_role_menu` VALUES (171, 1, 10);
INSERT INTO `sys_role_menu` VALUES (172, 1, 11);
INSERT INTO `sys_role_menu` VALUES (173, 1, 12);
INSERT INTO `sys_role_menu` VALUES (174, 1, 13);
INSERT INTO `sys_role_menu` VALUES (175, 1, 14);
INSERT INTO `sys_role_menu` VALUES (176, 1, 15);
INSERT INTO `sys_role_menu` VALUES (177, 1, 16);
INSERT INTO `sys_role_menu` VALUES (178, 1, 17);
INSERT INTO `sys_role_menu` VALUES (179, 1, 18);
INSERT INTO `sys_role_menu` VALUES (180, 1, 19);
INSERT INTO `sys_role_menu` VALUES (181, 1, 20);
INSERT INTO `sys_role_menu` VALUES (182, 1, 21);
INSERT INTO `sys_role_menu` VALUES (183, 1, 22);
INSERT INTO `sys_role_menu` VALUES (184, 1, 23);
INSERT INTO `sys_role_menu` VALUES (185, 1, 24);
INSERT INTO `sys_role_menu` VALUES (186, 1, 25);
INSERT INTO `sys_role_menu` VALUES (187, 1, 26);
INSERT INTO `sys_role_menu` VALUES (188, 1, 27);
INSERT INTO `sys_role_menu` VALUES (189, 1, 28);
INSERT INTO `sys_role_menu` VALUES (190, 1, 29);
INSERT INTO `sys_role_menu` VALUES (191, 1, 30);
INSERT INTO `sys_role_menu` VALUES (192, 1, 31);
INSERT INTO `sys_role_menu` VALUES (193, 1, 33);
INSERT INTO `sys_role_menu` VALUES (194, 1, 34);
INSERT INTO `sys_role_menu` VALUES (195, 1, 35);
INSERT INTO `sys_role_menu` VALUES (196, 1, 36);
INSERT INTO `sys_role_menu` VALUES (197, 1, 37);
INSERT INTO `sys_role_menu` VALUES (198, 1, 38);
INSERT INTO `sys_role_menu` VALUES (199, 1, 39);
INSERT INTO `sys_role_menu` VALUES (200, 1, 40);
INSERT INTO `sys_role_menu` VALUES (201, 1, 43);
INSERT INTO `sys_role_menu` VALUES (202, 1, 41);
INSERT INTO `sys_role_menu` VALUES (203, 1, 42);
INSERT INTO `sys_role_menu` VALUES (204, 1, 49);
INSERT INTO `sys_role_menu` VALUES (205, 1, 50);
INSERT INTO `sys_role_menu` VALUES (206, 1, 32);
INSERT INTO `sys_role_menu` VALUES (909, 4, 44);
INSERT INTO `sys_role_menu` VALUES (910, 4, 45);
INSERT INTO `sys_role_menu` VALUES (911, 4, 51);
INSERT INTO `sys_role_menu` VALUES (912, 4, 67);
INSERT INTO `sys_role_menu` VALUES (913, 4, 68);
INSERT INTO `sys_role_menu` VALUES (914, 4, 69);
INSERT INTO `sys_role_menu` VALUES (915, 4, 71);
INSERT INTO `sys_role_menu` VALUES (916, 4, 32);
INSERT INTO `sys_role_menu` VALUES (917, 4, 57);
INSERT INTO `sys_role_menu` VALUES (918, 4, 58);
INSERT INTO `sys_role_menu` VALUES (919, 4, 62);
INSERT INTO `sys_role_menu` VALUES (920, 4, 63);
INSERT INTO `sys_role_menu` VALUES (1050, 5, 1);
INSERT INTO `sys_role_menu` VALUES (1051, 5, 2);
INSERT INTO `sys_role_menu` VALUES (1052, 5, 3);
INSERT INTO `sys_role_menu` VALUES (1053, 5, 4);
INSERT INTO `sys_role_menu` VALUES (1054, 5, 5);
INSERT INTO `sys_role_menu` VALUES (1055, 5, 6);
INSERT INTO `sys_role_menu` VALUES (1056, 5, 7);
INSERT INTO `sys_role_menu` VALUES (1057, 5, 8);
INSERT INTO `sys_role_menu` VALUES (1058, 5, 9);
INSERT INTO `sys_role_menu` VALUES (1059, 5, 72);
INSERT INTO `sys_role_menu` VALUES (1060, 5, 10);
INSERT INTO `sys_role_menu` VALUES (1061, 5, 11);
INSERT INTO `sys_role_menu` VALUES (1062, 5, 12);
INSERT INTO `sys_role_menu` VALUES (1063, 5, 13);
INSERT INTO `sys_role_menu` VALUES (1064, 5, 14);
INSERT INTO `sys_role_menu` VALUES (1065, 5, 15);
INSERT INTO `sys_role_menu` VALUES (1066, 5, 16);
INSERT INTO `sys_role_menu` VALUES (1067, 5, 17);
INSERT INTO `sys_role_menu` VALUES (1068, 5, 18);
INSERT INTO `sys_role_menu` VALUES (1069, 5, 19);
INSERT INTO `sys_role_menu` VALUES (1070, 5, 20);
INSERT INTO `sys_role_menu` VALUES (1071, 5, 21);
INSERT INTO `sys_role_menu` VALUES (1072, 5, 22);
INSERT INTO `sys_role_menu` VALUES (1073, 5, 23);
INSERT INTO `sys_role_menu` VALUES (1074, 5, 24);
INSERT INTO `sys_role_menu` VALUES (1075, 5, 25);
INSERT INTO `sys_role_menu` VALUES (1076, 5, 26);
INSERT INTO `sys_role_menu` VALUES (1077, 5, 27);
INSERT INTO `sys_role_menu` VALUES (1078, 5, 28);
INSERT INTO `sys_role_menu` VALUES (1079, 5, 29);
INSERT INTO `sys_role_menu` VALUES (1080, 5, 30);
INSERT INTO `sys_role_menu` VALUES (1081, 5, 31);
INSERT INTO `sys_role_menu` VALUES (1082, 5, 74);
INSERT INTO `sys_role_menu` VALUES (1083, 5, 33);
INSERT INTO `sys_role_menu` VALUES (1084, 5, 34);
INSERT INTO `sys_role_menu` VALUES (1085, 5, 35);
INSERT INTO `sys_role_menu` VALUES (1086, 5, 36);
INSERT INTO `sys_role_menu` VALUES (1087, 5, 73);
INSERT INTO `sys_role_menu` VALUES (1088, 5, 37);
INSERT INTO `sys_role_menu` VALUES (1089, 5, 38);
INSERT INTO `sys_role_menu` VALUES (1090, 5, 43);
INSERT INTO `sys_role_menu` VALUES (1091, 5, 41);
INSERT INTO `sys_role_menu` VALUES (1092, 5, 42);
INSERT INTO `sys_role_menu` VALUES (1093, 5, 49);
INSERT INTO `sys_role_menu` VALUES (1094, 5, 50);
INSERT INTO `sys_role_menu` VALUES (1095, 5, 52);
INSERT INTO `sys_role_menu` VALUES (1096, 5, 53);
INSERT INTO `sys_role_menu` VALUES (1097, 5, 54);
INSERT INTO `sys_role_menu` VALUES (1098, 5, 55);
INSERT INTO `sys_role_menu` VALUES (1099, 5, 56);
INSERT INTO `sys_role_menu` VALUES (1100, 5, 57);
INSERT INTO `sys_role_menu` VALUES (1101, 5, 58);
INSERT INTO `sys_role_menu` VALUES (1102, 5, 67);
INSERT INTO `sys_role_menu` VALUES (1103, 5, 68);
INSERT INTO `sys_role_menu` VALUES (1104, 5, 69);
INSERT INTO `sys_role_menu` VALUES (1105, 5, 70);
INSERT INTO `sys_role_menu` VALUES (1106, 5, 59);
INSERT INTO `sys_role_menu` VALUES (1107, 5, 60);
INSERT INTO `sys_role_menu` VALUES (1108, 5, 61);
INSERT INTO `sys_role_menu` VALUES (1109, 5, 64);
INSERT INTO `sys_role_menu` VALUES (1110, 5, 65);
INSERT INTO `sys_role_menu` VALUES (1111, 5, 32);
INSERT INTO `sys_role_menu` VALUES (1112, 5, 62);
INSERT INTO `sys_role_menu` VALUES (1113, 5, 63);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `username` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '登录账户',
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '密码',
  `phone` varchar(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '13',
  `email` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '邮箱',
  `sex` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '性别',
  `is_admin` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '是否是管理员',
  `is_account_non_expired` int(11) NULL DEFAULT NULL COMMENT '帐户是否过期(1 未过期，0已过期)',
  `is_account_non_locked` int(11) NULL DEFAULT NULL COMMENT '帐户是否被锁定(1 未锁定，0已锁定)',
  `is_credentials_non_expired` int(11) NULL DEFAULT NULL COMMENT '密码是否过期(1 未过期，0已过期)',
  `is_enabled` int(11) NULL DEFAULT NULL COMMENT '帐户是否可用(1 可用，0 删除用户)',
  `nick_name` varbinary(36) NULL DEFAULT NULL COMMENT '姓名',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (5, 'ls', '1234', '186871163321', '', '0', '0', 1, 1, 1, 1, 0xE5BCA0E6958F, '2021-11-30 13:05:43', '2022-03-24 12:37:09');
INSERT INTO `sys_user` VALUES (6, 'zs', '1234', '18687116223', '', '0', '0', 1, 1, 1, 1, 0xE69DA8E58D8E, '2021-11-30 13:12:34', '2022-03-24 12:37:22');
INSERT INTO `sys_user` VALUES (7, 'admin', 'e10adc3949ba59abbe56e057f20f883e', '18687116223', '3501754007@qq.com', '0', '1', 1, 1, 1, 1, 0xE8B5B5E69FB3, '2022-03-14 20:57:41', '2022-03-24 12:37:42');
INSERT INTO `sys_user` VALUES (8, 'admin1', 'e10adc3949ba59abbe56e057f20f883e', '18787171906', '3501754007@qq.com', '0', '0', 1, 1, 1, 1, 0x61646D696E31, '2022-04-04 14:53:16', '2022-04-06 21:41:34');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_role_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '用户id',
  `role_id` int(11) NULL DEFAULT NULL COMMENT '角色id',
  PRIMARY KEY (`user_role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (5, 5, 1);
INSERT INTO `sys_user_role` VALUES (6, 6, 4);
INSERT INTO `sys_user_role` VALUES (7, 7, 1);
INSERT INTO `sys_user_role` VALUES (9, 8, 5);

SET FOREIGN_KEY_CHECKS = 1;
