/*
SQLyog Community v13.1.5  (64 bit)
MySQL - 10.4.17-MariaDB : Database - ava
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`ava` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `ava`;

/*Table structure for table `alert_settings` */

DROP TABLE IF EXISTS `alert_settings`;

CREATE TABLE `alert_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `key` varchar(50) NOT NULL,
  `data_field` text NOT NULL,
  `enable` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=80 DEFAULT CHARSET=utf8;

/*Data for the table `alert_settings` */

insert  into `alert_settings`(`id`,`user_id`,`key`,`data_field`,`enable`) values 
(8,1,'Cancelled','{\"SendAsSMS\":true,\"LeftCharactor\":70,\"sms_template\":\"You\'ve been cancelled from the waitlist for {business}. Thanks for letting us know, {name}\",\"SendAsEmail\":true,\"email_template\":\"Hi {name}!\\n\\nYou\'ve been cancelled from the waitlist for {business}.\\n\\nThank you!\\n\\n*{business}*\"}',1),
(9,1,'NoShow','{\"SendAsSMS\":true,\"LeftCharactor\":105,\"sms_template\":\"Your place in line at {business} was marked as no-show.\",\"SendAsEmail\":true,\"email_template\":\"Hi {name}! \\n\\nYour place in line at {business} was marked as no-show. We hope to see you back soon!\"}',1),
(16,1,'BookingReminder','{\"SendAsSMS\":true,\"LeftCharactor\":85,\"sms_template\":\"Heads-up that your booking is {calendar} at {business}. Manage it on {link}\",\"SendAsEmail\":true,\"email_template\":\"Hi {name}!\\n\\nHeads-up that you have an booking coming up {calendar} at {business}. \\n\\nManage your booking on {link}.\\n\\nWe look forward to serve you soon!\\n\\n*{business}*\",\"remaining_time\":\"5 min\"}',1),
(75,1,'NextInLine','{\"SendAsSMS\":true,\"LeftCharactor\":43,\"sms_template\":\"Heads up! It\'s soon your turn at {business} so start heading back. If you can\'t make it, go to {link} or reply \'cance\",\"SendAsEmail\":true,\"email_template\":\"Hi {name}!\\n\\nIt\'s soon your turn at {business} so start heading back. If you cannot make it, please [cancel yourself]({link}).\\n\\nWe look forward to serve you soon!\\n\\n*{business}*\",\"order_line\":\"1th in line\",\"order_relation\":\"everyone in line\"}',1),
(77,1,'Alert','{\"SendAsSMS\":false,\"LeftCharactor\":47,\"sms_template\":\"Voila! It\'s your turn at {business}. Please return in 5 min. If you can\'t make it, go to {link} or reply \'cancel\'\",\"SendAsEmail\":false,\"email_template\":\"Hi {name}!\\n\\nIt\'s your turn at {business}. Please return in 5 min. If you cannot make it, please [cancel yourself]({link}).\\n\\nWe look forward to serve you soon!\\n\\n*{business}*\"}',0),
(79,1,'BookingAlert','{\"SendAsSMS\":true,\"LeftCharactor\":66,\"sms_template\":\"Voila! It\'s time for your booking at {business}. Please be ready in 5 min! Manage it on {link}\",\"SendAsEmail\":true,\"email_template\":\"Hey {name}!\\n\\nGet ready for your booking {calendar} at {business}. We look forward to see you in just a moment! \\n\\n*{business}*\"}',1),
(51,1,'Completed','{\"SendAsSMS\":false,\"LeftCharactor\":89,\"sms_template\":\"Thank you for visiting {business}, {name}! We hope to see you back soon\",\"SendAsEmail\":false,\"email_template\":\"Thank you for visiting {business}, {name}!\\n\\nWe hope to see you back soon.\"}',0),
(70,1,'Confirmation','{\"SendAsSMS\":true,\"LeftCharactor\":36,\"sms_template\":\"Hi {name}! You\'re waitlisted to {business} as #{order} in line. See live wait at {link} Reply \'cancel\' if you can\'t make it.\",\"SendAsEmail\":true,\"subject\":\"\",\"email_template\":\"Hi {name}!\\n\\nYou\'ve been waitlisted to {business} as #{order} in line. [View the waitlist]({link}) and remove yourself if you cannot make it.\\n\\nWe look forward to serve you soon!\\n\\n*{business}*\"}',1),
(78,1,'Served','{\"SendAsSMS\":false,\"LeftCharactor\":117,\"sms_template\":\"Finally! You have been served at {business}\",\"SendAsEmail\":false,\"email_template\":\"Hi {name}!\\n\\nWe\'re happy to now serve you at {business}.\"}',0);

/*Table structure for table `alert_settings_default` */

DROP TABLE IF EXISTS `alert_settings_default`;

CREATE TABLE `alert_settings_default` (
  `key` varchar(50) NOT NULL,
  `value` text DEFAULT NULL,
  `enable` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `alert_settings_default` */

insert  into `alert_settings_default`(`key`,`value`,`enable`) values 
('Alert','{\"SendAsSMS\":false,\"LeftCharactor\":47,\"sms_template\":\"Voila! It\'s your turn at {business}. Please return in 5 min. If you can\'t make it, go to {link} or reply \'cancel\'\",\"SendAsEmail\":false,\"email_template\":\"Hi {name}!\\n\\nIt\'s your turn at {business}. Please return in 5 min. If you cannot make it, please [cancel yourself]({link}).\\n\\nWe look forward to serve you soon!\\n\\n*{business}*\"}',0),
('BookingAlert','{\"SendAsSMS\":false,\"LeftCharactor\":66,\"sms_template\":\"Voila! It\'s time for your booking at {business}. Please be ready in 5 min! Manage it on {link}\",\"SendAsEmail\":false,\"email_template\":\"Hey {name}!\\n\\nGet ready for your booking {calendar} at {business}. We look forward to see you in just a moment! \\n\\n*{business}*\"}',0),
('BookingCancelled','{\"SendAsSMS\":false,\"LeftCharactor\":106,\"sms_template\":\"Your booking was cancelled on {calendar} at {business}\",\"SendAsEmail\":false,\"email_template\":\"Hi {name}!\\n\\nYour booking at {business} on {calendar} has been cancelled. \\n\\nYou can find another time on our [booking page](https://app.waitwhile.com/book/{waitlistId}).\\n\\nThank you!\\n\\n*{business}*\"}',0),
('BookingCompleted','{\"SendAsSMS\":true,\"LeftCharactor\":89,\"sms_template\":\"Thank you for visiting {business}, {name}! We hope to see you back soon\",\"SendAsEmail\":true,\"email_template\":\"Thank you for visiting {business}, {name}!\\n\\nWe hope to see you back soon.\"}',0),
('BookingConfirmation','{\"SendAsSMS\":false,\"LeftCharactor\":66,\"sms_template\":\"Hi {name}! You\'re scheduled for an booking {date} at {hour} at {business}. Manage it on {link}\",\"SendAsEmail\":false,\"email_template\":\"Hi {name}!\\n\\nYou\'ve been scheduled for an booking {calendar} at {business}. \\n\\nManage your booking on {link}. \\n\\nWe look forward to serve you soon!\\n\\n*{business}*\"}',0),
('BookingNoShow','{\"SendAsSMS\":false,\"LeftCharactor\":105,\"sms_template\":\"Your place in line at {business} was marked as no-show.\",\"SendAsEmail\":false,\"email_template\":\"Hi {name}! \\n\\nYour place in line at {business} was marked as no-show. We hope to see you back soon!\"}',0),
('BookingReminder','{\"SendAsSMS\":false,\"LeftCharactor\":85,\"sms_template\":\"Heads-up that your booking is {calendar} at {business}. Manage it on {link}\",\"SendAsEmail\":false,\"email_template\":\"Hi {name}!\\n\\nHeads-up that you have an booking coming up {calendar} at {business}. \\n\\nManage your booking on {link}.\\n\\nWe look forward to serve you soon!\\n\\n*{business}*\",\"remaining_time\":\"5 min\"}',0),
('BookingServed','{\"SendAsSMS\":false,\"LeftCharactor\":117,\"sms_template\":\"Finally! You have been served at {business}\",\"SendAsEmail\":false,\"email_template\":\"Hi {name}!\\n\\nWe\'re happy to now serve you at {business}.\"}',0),
('Cancelled','{\"SendAsSMS\":false,\"LeftCharactor\":70,\"sms_template\":\"You\'ve been cancelled from the waitlist for {business}. Thanks for letting us know, {name}\",\"SendAsEmail\":false,\"email_template\":\"Hi {name}!\\n\\nYou\'ve been cancelled from the waitlist for {business}.\\n\\nThank you!\\n\\n*{business}*\"}',0),
('Completed','{\"SendAsSMS\":false,\"LeftCharactor\":89,\"sms_template\":\"Thank you for visiting {business}, {name}! We hope to see you back soon\",\"SendAsEmail\":false,\"email_template\":\"Thank you for visiting {business}, {name}!\\n\\nWe hope to see you back soon.\"}',0),
('Confirmation','{\"SendAsSMS\":false,\"LeftCharactor\":36,\"sms_template\":\"Hi {name}! You\'re waitlisted to {business} as #{order} in line. See live wait at {link} Reply \'cancel\' if you can\'t make it.\",\"SendAsEmail\":false,\"subject\":\"\",\"email_template\":\"Hi {name}!\\n\\nYou\'ve been waitlisted to {business} as #{order} in line. [View the waitlist]({link}) and remove yourself if you cannot make it.\\n\\nWe look forward to serve you soon!\\n\\n*{business}*\"}',0),
('NextInLine','{\"SendAsSMS\":false,\"LeftCharactor\":43,\"sms_template\":\"Heads up! It\'s soon your turn at {business} so start heading back. If you can\'t make it, go to {link} or reply \'cance\",\"SendAsEmail\":false,\"email_template\":\"Hi {name}!\\n\\nIt\'s soon your turn at {business} so start heading back. If you cannot make it, please [cancel yourself]({link}).\\n\\nWe look forward to serve you soon!\\n\\n*{business}*\",\"order_line\":\"1th in line\",\"order_relation\":\"everyone in line\"}',0),
('NoShow','{\"SendAsSMS\":false,\"LeftCharactor\":105,\"sms_template\":\"Your place in line at {business} was marked as no-show.\",\"SendAsEmail\":false,\"email_template\":\"Hi {name}! \\n\\nYour place in line at {business} was marked as no-show. We hope to see you back soon!\"}',0),
('Served','{\"SendAsSMS\":false,\"LeftCharactor\":117,\"sms_template\":\"Finally! You have been served at {business}\",\"SendAsEmail\":false,\"email_template\":\"Hi {name}!\\n\\nWe\'re happy to now serve you at {business}.\"}',0);

/*Table structure for table `booking_settings` */

DROP TABLE IF EXISTS `booking_settings`;

CREATE TABLE `booking_settings` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `minDuration` varchar(10) NOT NULL,
  `maxDuration` varchar(10) NOT NULL,
  `SpotsPerTimeSlot` int(11) NOT NULL,
  `DefaultView` varchar(30) NOT NULL,
  `EndHour` varchar(30) NOT NULL,
  `StartHour` varchar(30) NOT NULL,
  `WeekStartDay` varchar(30) NOT NULL,
  `HidePast` tinyint(4) NOT NULL,
  `AllowCustomerCancelBooking` tinyint(4) NOT NULL,
  `AllowCustomerRescheduleBooking` tinyint(4) NOT NULL,
  `AllowStaffOverBookFullTimeSlot` tinyint(4) NOT NULL,
  `MaxAdvanceKind` varchar(20) NOT NULL,
  `MaxAdvanceNumber` int(11) NOT NULL,
  `MaxBooking` varchar(20) NOT NULL,
  `MinBooking` varchar(20) NOT NULL,
  `MinNoticeKind` varchar(20) NOT NULL,
  `MinNoticeNumber` int(11) NOT NULL,
  `RejectDuplicate` tinyint(4) NOT NULL,
  `RejectFlagged` tinyint(4) NOT NULL,
  `openingGeneralHours` text NOT NULL,
  `openingWaitListHours` text NOT NULL,
  `openingBookingHours` text NOT NULL,
  `CalendarData` text NOT NULL,
  `PublicBookingUrl` varchar(50) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

/*Data for the table `booking_settings` */

insert  into `booking_settings`(`ID`,`user_id`,`minDuration`,`maxDuration`,`SpotsPerTimeSlot`,`DefaultView`,`EndHour`,`StartHour`,`WeekStartDay`,`HidePast`,`AllowCustomerCancelBooking`,`AllowCustomerRescheduleBooking`,`AllowStaffOverBookFullTimeSlot`,`MaxAdvanceKind`,`MaxAdvanceNumber`,`MaxBooking`,`MinBooking`,`MinNoticeKind`,`MinNoticeNumber`,`RejectDuplicate`,`RejectFlagged`,`openingGeneralHours`,`openingWaitListHours`,`openingBookingHours`,`CalendarData`,`PublicBookingUrl`) values 
(1,0,'30','30',1,'Weekly','20','6','Sunday',0,0,0,0,'Minutes',1,'1 slot','1 slot','Minutes',1,0,0,'0','0','0','[]',''),
(11,47,'40','45',10,'Daily','18','6','Sunday',0,0,0,0,'Minutes',1,'3 slot','2 slot','Minutes',1,0,0,'[{\"name\":\"Monday\",\"isWorking\":\"Working\",\"data\":[[\"9:00 am\",\"6:00 pm\",\"none\",\"none\"],[\"6:00 pm\",\"7:00 pm\",\"none\",\"none\"],[\"7:00 pm\",\"8:00 pm\",\"none\",\"none\"]]},{\"name\":\"Tuesday\",\"isWorking\":\"Working\",\"data\":[[\"9:00 am\",\"6:00 pm\",\"none\",\"none\"]]},{\"name\":\"Wednesday\",\"isWorking\":\"Working\",\"data\":[[\"9:00 am\",\"6:00 pm\",\"none\",\"none\"]]},{\"name\":\"Thursday\",\"isWorking\":\"Working\",\"data\":[[\"9:00 am\",\"6:00 pm\",\"none\",\"none\"]]},{\"name\":\"Friday\",\"isWorking\":\"Working\",\"data\":[[\"9:00 am\",\"6:00 pm\",\"none\",\"none\"]]},{\"name\":\"Saturday\",\"isWorking\":\"Working\",\"data\":[[\"9:00 am\",\"6:00 pm\",\"none\",\"none\"]]},{\"name\":\"Sunday\",\"isWorking\":\"Working\",\"data\":[[\"9:00 am\",\"6:00 pm\",\"none\",\"none\"]]}]','0','0','[{\"Year\":2021,\"Month\":1,\"Date\":6,\"Data\":{\"GeneralHours\":{\"name\":\"Saturday\",\"isWorking\":\"Working\",\"data\":[[\"9:00 am\",\"8:00 PM\",\"none\",\"none\"]]},\"WaitListHours\":false,\"BookingHours\":false}},{\"Year\":2021,\"Month\":1,\"Date\":4,\"Data\":{\"GeneralHours\":{\"name\":\"Thursday\",\"isWorking\":\"Working\",\"data\":[[\"9:00 am\",\"3:00 PM\",\"none\",\"none\"]]},\"WaitListHours\":false,\"BookingHours\":false}},{\"Year\":2021,\"Month\":1,\"Date\":5,\"Data\":{\"GeneralHours\":{\"name\":\"Friday\",\"isWorking\":\"All Day\",\"data\":[]},\"WaitListHours\":false,\"BookingHours\":false}},{\"Year\":2021,\"Month\":1,\"Date\":3,\"Data\":{\"GeneralHours\":{\"name\":\"Wednesday\",\"isWorking\":\"Not Working\",\"data\":[]},\"WaitListHours\":false,\"BookingHours\":false}},{\"Year\":2021,\"Month\":1,\"Date\":12,\"Data\":{\"GeneralHours\":{\"name\":\"Friday\",\"isWorking\":\"Working\",\"data\":[[\"9:00 am\",\"6:00 pm\",\"none\",\"none\"],[\"6:00 pm\",\"7:00 pm\",\"none\",\"none\"],[\"7:00 pm\",\"8:00 pm\",\"none\",\"none\"]]},\"WaitListHours\":{\"name\":\"Friday\",\"isWorking\":\"Working\",\"data\":[[\"9:00 am\",\"6:00 pm\",\"none\",\"none\"],[\"6:00 pm\",\"7:00 pm\",\"none\",\"none\"],[\"7:00 pm\",\"8:00 pm\",\"none\",\"none\"]]},\"BookingHours\":false}}]',''),
(12,32,'10','30',1,'Weekly','18','8','Sunday',0,0,0,0,'Minutes',1,'1 slot','1 slot','Minutes',1,0,0,'[{\"name\":\"Monday\",\"isWorking\":\"Working\",\"data\":[[\"9:00 am\",\"6:00 pm\",\"none\",\"none\"]]},{\"name\":\"Tuesday\",\"isWorking\":\"Working\",\"data\":[[\"9:00 am\",\"6:00 pm\",\"none\",\"none\"]]},{\"name\":\"Wednesday\",\"isWorking\":\"Working\",\"data\":[[\"9:00 am\",\"6:00 pm\",\"none\",\"none\"]]},{\"name\":\"Thursday\",\"isWorking\":\"Working\",\"data\":[[\"9:00 am\",\"6:00 pm\",\"none\",\"none\"]]},{\"name\":\"Friday\",\"isWorking\":\"Working\",\"data\":[[\"9:00 am\",\"6:00 pm\",\"none\",\"none\"]]},{\"name\":\"Saturday\",\"isWorking\":\"Working\",\"data\":[[\"9:00 am\",\"6:00 pm\",\"none\",\"none\"]]},{\"name\":\"Sunday\",\"isWorking\":\"Working\",\"data\":[[\"9:00 am\",\"6:00 pm\",\"none\",\"none\"]]}]','0','0','[]',''),
(13,47,'30','30',1,'Daily','19','6','Sunday',0,0,0,0,'Minutes',1,'1 slot','1 slot','Minutes',1,0,0,'0','0','0','[]',''),
(14,47,'30','30',1,'Weekly','9','6','Sunday',0,0,0,0,'Minutes',1,'1 slot','1 slot','Minutes',1,0,0,'0','0','0','[]',''),
(15,47,'30','30',1,'Weekly','13','6','Sunday',0,0,0,0,'Minutes',1,'1 slot','1 slot','Minutes',1,0,0,'0','0','0','[]',''),
(17,47,'30','30',1,'Weekly','20','6','Sunday',0,0,0,0,'Minutes',1,'1 slot','1 slot','Minutes',1,0,0,'0','0','0','[]',''),
(18,47,'30','30',1,'Weekly','20','6','Sunday',0,0,0,0,'Minutes',1,'1 slot','1 slot','Minutes',1,0,0,'0','0','0','[]',''),
(19,1,'30','30',1,'Weekly','20','6','Sunday',0,0,0,0,'Minutes',1,'1 slot','1 slot','Minutes',1,0,0,'0','0','0','[]','stone'),
(20,50,'30','30',1,'Weekly','20','6','Sunday',0,0,0,0,'Minutes',1,'1 slot','1 slot','Minutes',1,0,0,'0','0','0','[]','computer111');

/*Table structure for table `bookings` */

DROP TABLE IF EXISTS `bookings`;

CREATE TABLE `bookings` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `resource` varchar(11) NOT NULL,
  `note` text DEFAULT NULL,
  `startDate` datetime DEFAULT NULL,
  `endDate` datetime DEFAULT NULL,
  `appointment_key` varchar(8) DEFAULT NULL,
  `appointment_type` tinyint(2) DEFAULT 1,
  `appointment_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=123 DEFAULT CHARSET=utf8;

/*Data for the table `bookings` */

insert  into `bookings`(`id`,`user_id`,`customer_id`,`title`,`resource`,`note`,`startDate`,`endDate`,`appointment_key`,`appointment_type`,`appointment_time`) values 
(116,1,212,'test','ISWB7OrxXn','dfsfd','2021-02-24 18:30:00','2021-02-24 19:00:00','D2Ptcj29',1,NULL),
(115,1,211,'error','ISWB7OrxXn',NULL,'2021-02-24 17:30:00','2021-02-24 18:00:00','6uYdLOju',1,NULL),
(114,1,210,'?','ISWB7OrxXn',NULL,'2021-02-25 17:30:00','2021-02-25 19:00:00','PHCccSpg',1,NULL),
(113,1,208,'this is my plan','ISWB7OrxXn',NULL,'2021-02-24 18:00:00','2021-02-24 18:30:00','uuvjfdFE',1,NULL),
(112,1,209,'this','bMYsoX4e3M',NULL,'2021-02-24 20:00:00','2021-02-24 20:30:00','bxXdbAJl',1,NULL),
(111,1,208,'test','ISWB7OrxXn','test','2021-02-24 19:00:00','2021-02-24 19:30:00','431S0c5o',1,NULL),
(110,1,203,'tset2','ISWB7OrxXn','sfsf','2021-02-25 18:30:00','2021-02-25 19:00:00','TUgHdjBO',1,NULL),
(109,1,199,'test','bMYsoX4e3M',NULL,'2021-02-23 18:30:00','2021-02-23 19:00:00','YdnBybGh',1,NULL),
(117,1,213,'[]','bMYsoX4e3M',NULL,'2021-02-26 17:30:00','2021-02-26 18:00:00','bFTBJQHF',1,NULL),
(118,1,214,'test','bMYsoX4e3M',NULL,'2021-02-22 18:00:00','2021-02-22 18:30:00','5AJYCtkU',1,NULL),
(119,1,215,'title','bMYsoX4e3M',NULL,'2021-02-26 18:00:00','2021-02-26 19:30:00','n57jusQo',1,NULL),
(120,1,216,'hi','ISWB7OrxXn',NULL,'2021-02-25 19:00:00','2021-02-25 19:30:00','ZgdCS551',1,NULL),
(121,1,217,'origin','vgftEu4nLN',NULL,'2021-02-23 17:30:00','2021-02-23 19:00:00','UEA34B1P',1,NULL),
(122,1,217,'origin','ISWB7OrxXn',NULL,'2021-02-23 19:00:00','2021-02-23 19:30:00','HevKj0Iy',1,NULL);

/*Table structure for table `business_infos` */

DROP TABLE IF EXISTS `business_infos`;

CREATE TABLE `business_infos` (
  `ID` varchar(20) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `business_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `business_infos` */

insert  into `business_infos`(`ID`,`user_id`,`business_name`) values 
('1',0,'Business'),
('3',32,'manggo'),
('bY0nC5CvPJKAKQX8xlKY',50,'Marketting Business'),
('EQ4g2qcys2lH8hWIBwHn',1,'Magasin VidÃ©otron Blainville'),
('sAavAS7FcNP3UG4QlA4g',39,'dol MAx');

/*Table structure for table `client_fields` */

DROP TABLE IF EXISTS `client_fields`;

CREATE TABLE `client_fields` (
  `ID` varchar(10) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `enable` varchar(1) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `label` varchar(100) DEFAULT NULL,
  `type` varchar(30) DEFAULT NULL,
  `placeholder` varchar(100) DEFAULT NULL,
  `options` text DEFAULT NULL,
  `defaultValue` varchar(50) DEFAULT NULL,
  `ordering` varchar(10) DEFAULT NULL,
  `PORV` varchar(20) DEFAULT NULL,
  `for` varchar(50) DEFAULT NULL,
  `is_required` varchar(1) DEFAULT NULL,
  `is_multiple` varchar(1) DEFAULT NULL,
  `is_add_option` varchar(1) DEFAULT NULL,
  `is_pre_select` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `client_fields` */

insert  into `client_fields`(`ID`,`user_id`,`enable`,`name`,`label`,`type`,`placeholder`,`options`,`defaultValue`,`ordering`,`PORV`,`for`,`is_required`,`is_multiple`,`is_add_option`,`is_pre_select`) values 
('HMLwm4KGJ9',1,'1','dfd','ddd','Text Field','','[]','',NULL,'Public','Both bookings and waitlist','0','0','0','0');

/*Table structure for table `customer_meta` */

DROP TABLE IF EXISTS `customer_meta`;

CREATE TABLE `customer_meta` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `customerId` int(11) DEFAULT NULL,
  `meta_key` varchar(250) DEFAULT NULL,
  `meta_value` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=422 DEFAULT CHARSET=utf8;

/*Data for the table `customer_meta` */

insert  into `customer_meta`(`id`,`customerId`,`meta_key`,`meta_value`) values 
(416,211,'dfd','dfdsf'),
(413,208,'dfd','ddd'),
(403,191,'test3','11'),
(402,191,'tests','[\"2\",\"4\"]'),
(412,207,'dfd','very bad man??I lost my money for nothing'),
(411,180,'dfd','kokokok'),
(417,212,'resources','vgftEu4nLN'),
(418,212,'dfd','tstd'),
(419,212,'test3','tesds'),
(420,213,'resources','uwdL8j96qI'),
(421,213,'dfd','[]');

/*Table structure for table `customers` */

DROP TABLE IF EXISTS `customers`;

CREATE TABLE `customers` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `customer_group_id` varchar(100) DEFAULT NULL,
  `phone` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`,`email`)
) ENGINE=MyISAM AUTO_INCREMENT=229 DEFAULT CHARSET=utf8;

/*Data for the table `customers` */

insert  into `customers`(`id`,`user_id`,`name`,`email`,`customer_group_id`,`phone`,`description`,`created_at`,`updated_at`) values 
(197,32,'tes','tsss@email.com','ts',NULL,NULL,'2021-02-15 07:54:18','2021-02-15 07:54:18'),
(221,1,'bolo','bolo@email.com',NULL,NULL,NULL,'2021-02-26 14:16:02','2021-02-26 14:16:02'),
(212,1,'sdff','cshe@email.com',NULL,NULL,NULL,'2021-02-24 10:48:39','2021-02-26 05:27:13'),
(213,1,'[]','ddd@email.com',NULL,NULL,NULL,'2021-02-24 10:51:24','2021-02-26 05:27:19'),
(215,1,'test customer','testc@email.com',NULL,NULL,NULL,'2021-02-24 11:02:31','2021-02-26 05:27:37'),
(216,1,'hi','hi@email.com',NULL,'1',NULL,'2021-02-24 11:42:50','2021-02-26 05:27:30'),
(211,1,'errors','error@email.com',NULL,'380191223214',NULL,'2021-02-24 09:36:33','2021-02-26 05:27:26'),
(219,1,'dddd','dddddd@email.com',NULL,'dfsf',NULL,'2021-02-26 14:03:36','2021-02-26 14:03:36'),
(220,1,'test publicv','test1@email.com',NULL,NULL,NULL,'2021-02-26 14:06:40','2021-02-26 14:06:40'),
(208,1,'this is my plan','test@email.com',NULL,'380132312141',NULL,'2021-02-24 09:14:08','2021-02-26 05:27:22'),
(180,1,'1','1@email.com',NULL,NULL,NULL,'2021-02-10 10:49:36','2021-02-24 08:19:37'),
(207,1,'servedfdsfsfsdf','serving@email.com','serving','11111111111','1','2021-02-24 08:27:07','2021-02-24 08:31:48'),
(222,1,'dol','dol@email.com',NULL,'dol',NULL,'2021-02-26 14:20:22','2021-02-26 14:20:22'),
(223,50,'customer','???@email.com',NULL,'226',NULL,'2021-02-26 14:23:46','2021-02-26 14:32:01'),
(217,1,'origin','origin@email.com',NULL,'11111111111',NULL,'2021-02-24 12:43:11','2021-02-26 05:27:28'),
(224,50,'manngo','manngo@email.com',NULL,'202 324 1234',NULL,'2021-02-26 16:20:08','2021-02-26 16:20:08'),
(225,50,'mouse','mouse@email.com',NULL,NULL,NULL,'2021-02-26 16:20:25','2021-02-26 16:20:25'),
(226,50,'computer','computer@email.com',NULL,NULL,NULL,'2021-02-26 16:22:51','2021-02-26 16:22:51'),
(227,50,'Max','max@email.com',NULL,NULL,NULL,'2021-02-26 16:30:48','2021-02-26 16:30:48'),
(228,50,'dold','dold@email.com',NULL,'226123123123123',NULL,'2021-02-26 16:34:01','2021-02-26 16:34:01');

/*Table structure for table `localizations` */

DROP TABLE IF EXISTS `localizations`;

CREATE TABLE `localizations` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `timezone` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `localizations` */

insert  into `localizations`(`ID`,`user_id`,`timezone`) values 
(1,0,'utc'),
(2,1,'America/Argentina/Tucuman'),
(3,32,'America/New_York');

/*Table structure for table `managers` */

DROP TABLE IF EXISTS `managers`;

CREATE TABLE `managers` (
  `ID` varchar(10) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `is_sign_up` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `managers` */

insert  into `managers`(`ID`,`user_id`,`name`,`email`,`is_sign_up`) values 
('9DsAYxdQsO',1,'testChat2','testchat@email.com','true'),
('jTyxQfpmmp',1,'manager','manager@email.com',''),
('u9Msn2ZDXb',32,'manager1','manager1@email.com','true'),
('ysoQwIk67H',1,'testChat','testchat@hotmail.com','true');

/*Table structure for table `message_histories` */

DROP TABLE IF EXISTS `message_histories`;

CREATE TABLE `message_histories` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `customer_id` bigint(20) DEFAULT NULL,
  `business_id` varchar(20) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `send_at` datetime DEFAULT NULL,
  `is_success` tinyint(4) DEFAULT NULL,
  `sending_type` varchar(5) DEFAULT NULL,
  `message_type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;

/*Data for the table `message_histories` */

insert  into `message_histories`(`ID`,`customer_id`,`business_id`,`message`,`send_at`,`is_success`,`sending_type`,`message_type`) values 
(1,211,'1','Hi errors! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 04:51:25',0,'SMS','customerSendLink'),
(2,207,'1','Hi servedfdsfsfsdf! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 04:51:27',0,'SMS','customerSendLink'),
(3,208,'1','Hi this is my plan! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 04:51:28',1,'SMS','customerSendLink'),
(4,210,'1','Hi what happened?! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 04:51:29',0,'SMS','customerSendLink'),
(5,211,'1','Hi errors! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 04:51:16',0,'Email','customerSendLink'),
(6,210,'1','Hi what happened?! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 04:51:16',0,'Email','customerSendLink'),
(7,180,'1','Hi 1! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 04:51:19',0,'Email','customerSendLink'),
(8,208,'1','Hi this is my plan! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 04:51:20',0,'Email','customerSendLink'),
(9,207,'1','Hi servedfdsfsfsdf! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 04:51:24',0,'Email','customerSendLink'),
(10,207,'1','Hi servedfdsfsfsdf! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 04:59:25',0,'SMS','customerSendLink'),
(11,210,'1','Hi what happened?! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 04:59:28',0,'SMS','customerSendLink'),
(12,208,'1','Hi this is my plan! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 04:59:29',1,'SMS','customerSendLink'),
(13,211,'1','Hi errors! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 04:59:32',0,'SMS','customerSendLink'),
(14,208,'1','Hi this is my plan! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 04:59:33',0,'SMS','customerSendLink'),
(15,210,'1','Hi what happened?! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 04:59:34',0,'SMS','customerSendLink'),
(16,207,'1','Hi servedfdsfsfsdf! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 04:59:35',0,'SMS','customerSendLink'),
(17,211,'1','Hi errors! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 04:59:22',0,'Email','customerSendLink'),
(18,208,'1','Hi this is my plan! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 04:59:23',1,'Email','customerSendLink'),
(19,210,'1','Hi what happened?! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 04:59:23',0,'Email','customerSendLink'),
(20,180,'1','Hi 1! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 04:59:24',0,'Email','customerSendLink'),
(21,207,'1','Hi servedfdsfsfsdf! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 04:59:24',0,'Email','customerSendLink'),
(22,218,'1','Hi jcodewriter! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 05:23:11',0,'Email','customerSendLink'),
(23,211,'1','Hi errors! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 05:27:59',0,'SMS','customerSendLink'),
(24,210,'1','Hi what happened?! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 05:28:02',0,'SMS','customerSendLink'),
(25,208,'1','Hi this is my plan! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 05:28:04',1,'SMS','customerSendLink'),
(26,211,'1','Hi errors! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 05:28:03',0,'SMS','customerSendLink'),
(27,207,'1','Hi servedfdsfsfsdf! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 05:28:04',0,'SMS','customerSendLink'),
(28,210,'1','Hi what happened?! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 05:28:05',0,'SMS','customerSendLink'),
(29,211,'1','Hi errors! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 05:28:06',0,'SMS','customerSendLink'),
(30,208,'1','Hi this is my plan! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 05:28:07',0,'SMS','customerSendLink'),
(31,207,'1','Hi servedfdsfsfsdf! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 05:28:07',0,'SMS','customerSendLink'),
(32,211,'1','Hi errors! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 05:28:11',0,'SMS','customerSendLink'),
(33,208,'1','Hi this is my plan! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 05:28:11',1,'SMS','customerSendLink'),
(34,210,'1','Hi what happened?! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 05:28:12',0,'SMS','customerSendLink'),
(35,207,'1','Hi servedfdsfsfsdf! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 05:28:13',0,'SMS','customerSendLink'),
(36,211,'1','Hi errors! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 05:28:13',0,'SMS','customerSendLink'),
(37,208,'1','Hi this is my plan! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 05:28:14',0,'SMS','customerSendLink'),
(38,210,'1','Hi what happened?! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 05:28:15',0,'SMS','customerSendLink'),
(39,211,'1','Hi errors! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 05:28:16',0,'SMS','customerSendLink'),
(40,207,'1','Hi servedfdsfsfsdf! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 05:28:15',0,'SMS','customerSendLink'),
(41,208,'1','Hi this is my plan! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 05:28:16',0,'SMS','customerSendLink'),
(42,210,'1','Hi what happened?! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 05:28:17',0,'SMS','customerSendLink'),
(43,207,'1','Hi servedfdsfsfsdf! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 05:28:18',0,'SMS','customerSendLink'),
(44,211,'1','Hi errors! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 05:28:19',0,'SMS','customerSendLink'),
(45,208,'1','Hi this is my plan! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 05:28:19',1,'SMS','customerSendLink'),
(46,211,'1','Hi errors! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 06:02:53',0,'SMS','customerSendLink'),
(47,208,'1','Hi this is my plan! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers','2021-02-26 06:02:53',0,'SMS','customerSendLink'),
(48,211,'1','Hi errors! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/','2021-02-26 06:20:55',0,'SMS','customerSendLink'),
(49,211,'1','Hi errors! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/','2021-02-26 06:21:02',0,'SMS','customerSendLink'),
(50,207,'1','Hi servedfdsfsfsdf! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/','2021-02-26 06:22:29',0,'SMS','customerSendLink'),
(51,211,'1','Hi errors! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/','2021-02-26 06:23:52',0,'SMS','customerSendLink'),
(52,211,'1','Hi errors! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/','2021-02-26 06:24:36',0,'SMS','customerSendLink'),
(53,211,'1','Hi errors! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/','2021-02-26 06:25:01',0,'SMS','customerSendLink'),
(54,211,'1','Hi errors! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/stone','2021-02-26 06:26:39',0,'SMS','customerSendLink'),
(55,223,'bY0nC5CvPJKAKQX8xlKY','Hi customer! You were added on Marketting Business. For join to the waitlist, Please follow http://avamgt.com/test','2021-02-26 14:30:35',0,'SMS','customerSendLink');

/*Table structure for table `messages` */

DROP TABLE IF EXISTS `messages`;

CREATE TABLE `messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender_id` int(11) DEFAULT NULL,
  `receiver_id` int(11) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `msg_type` varchar(20) DEFAULT NULL,
  `is_read` tinyint(4) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8;

/*Data for the table `messages` */

insert  into `messages`(`id`,`sender_id`,`receiver_id`,`message`,`msg_type`,`is_read`,`created_at`,`updated_at`,`deleted_at`) values 
(1,47,1,'hi',NULL,1,'2021-02-25 14:48:04',NULL,NULL),
(2,47,1,'hi',NULL,1,'2021-02-25 14:48:14',NULL,NULL),
(3,47,1,'hi',NULL,1,'2021-02-25 14:48:24',NULL,NULL),
(4,1,47,'hi',NULL,1,'2021-02-25 14:48:55',NULL,NULL),
(5,1,47,'tet',NULL,1,'2021-02-25 14:49:27',NULL,NULL),
(6,47,1,'sdfsdf',NULL,1,'2021-02-25 14:50:03',NULL,NULL),
(7,47,1,'sdfdsf',NULL,1,'2021-02-25 14:50:11',NULL,NULL),
(8,47,1,'sdfsdf',NULL,1,'2021-02-25 17:43:20',NULL,NULL),
(9,47,1,'dsfsdf',NULL,1,'2021-02-25 17:43:40',NULL,NULL),
(10,47,1,'sdfsdfsdfd',NULL,1,'2021-02-25 17:43:42',NULL,NULL),
(11,47,1,'sdfsdf',NULL,1,'2021-02-25 17:44:44',NULL,NULL),
(12,47,1,'sdfsdf',NULL,1,'2021-02-25 17:44:45',NULL,NULL),
(13,47,1,'sfsdfsd',NULL,1,'2021-02-25 17:44:48',NULL,NULL),
(14,47,1,'sdfsdf',NULL,1,'2021-02-25 17:45:10',NULL,NULL),
(15,47,1,'sdfsdf',NULL,1,'2021-02-25 17:45:11',NULL,NULL),
(16,47,1,'sdfsd',NULL,1,'2021-02-25 17:45:19',NULL,NULL),
(17,47,1,'sdfsdf',NULL,1,'2021-02-25 17:45:21',NULL,NULL),
(18,47,1,'sdfd',NULL,1,'2021-02-25 17:46:12',NULL,NULL),
(19,1,47,'sdfsdf',NULL,1,'2021-02-25 17:46:17',NULL,NULL),
(20,1,47,'sdfds',NULL,1,'2021-02-25 17:46:35',NULL,NULL),
(21,1,47,'dfsdf',NULL,1,'2021-02-25 17:46:40',NULL,NULL),
(22,1,47,'22',NULL,1,'2021-02-25 17:46:43',NULL,NULL),
(23,47,1,'111',NULL,1,'2021-02-25 17:46:48',NULL,NULL),
(24,47,1,'llllllllllllll',NULL,1,'2021-02-25 18:11:17',NULL,NULL),
(25,47,1,'hi',NULL,1,'2021-02-25 19:21:29',NULL,NULL),
(26,47,1,'when could you possibly contact me?',NULL,1,'2021-02-25 19:21:42',NULL,NULL),
(27,47,1,'sdfdsfs',NULL,1,'2021-02-25 19:22:11',NULL,NULL),
(28,47,1,'sdfsd',NULL,1,'2021-02-25 19:22:12',NULL,NULL),
(29,47,1,'fsdfsdf',NULL,1,'2021-02-25 19:22:24',NULL,NULL),
(30,47,1,'sdfsd',NULL,1,'2021-02-25 19:22:25',NULL,NULL),
(31,47,1,'sdf',NULL,1,'2021-02-25 19:22:25',NULL,NULL),
(32,47,1,'sdfs',NULL,1,'2021-02-25 19:22:34',NULL,NULL),
(33,47,1,'sdfsd',NULL,1,'2021-02-25 19:22:35',NULL,NULL),
(34,1,47,'111',NULL,1,'2021-02-25 19:36:44',NULL,NULL),
(35,47,1,'12312',NULL,1,'2021-02-25 19:53:07',NULL,NULL),
(36,1,47,'test',NULL,1,'2021-02-25 19:58:54',NULL,NULL),
(37,47,1,'hi',NULL,1,'2021-02-25 19:59:09',NULL,NULL),
(38,1,47,'fsdf',NULL,1,'2021-02-25 19:59:29',NULL,NULL),
(39,1,47,'sdfsdf',NULL,1,'2021-02-25 19:59:33',NULL,NULL),
(40,47,1,'die',NULL,1,'2021-02-25 20:04:49',NULL,NULL),
(41,1,47,'I will kill you]',NULL,1,'2021-02-25 20:05:02',NULL,NULL),
(42,1,47,'dsfsdf',NULL,1,'2021-02-25 20:07:18',NULL,NULL),
(43,1,47,'sdfsd',NULL,1,'2021-02-25 20:07:18',NULL,NULL),
(44,1,47,'dsf',NULL,1,'2021-02-25 20:07:19',NULL,NULL),
(45,47,1,'dfasd',NULL,1,'2021-02-25 20:07:27',NULL,NULL),
(46,47,1,'asd',NULL,1,'2021-02-25 20:07:28',NULL,NULL),
(47,47,1,'hi',NULL,1,'2021-02-25 21:31:28',NULL,NULL),
(48,1,47,'sdfsdf',NULL,1,'2021-02-25 21:32:46',NULL,NULL),
(49,1,47,'sdfsdf',NULL,1,'2021-02-25 21:33:23',NULL,NULL),
(50,1,47,'qqq',NULL,1,'2021-02-25 21:33:27',NULL,NULL),
(51,1,47,'www',NULL,1,'2021-02-25 21:33:29',NULL,NULL),
(52,1,47,'ddd',NULL,1,'2021-02-25 21:33:31',NULL,NULL),
(53,47,1,'sdfsd',NULL,1,'2021-02-25 21:33:37',NULL,NULL),
(54,1,47,'sdfsd',NULL,1,'2021-02-25 21:33:41',NULL,NULL),
(55,1,47,'dfsd',NULL,1,'2021-02-25 21:33:46',NULL,NULL),
(56,47,1,'test',NULL,1,'2021-02-25 21:33:54',NULL,NULL),
(57,47,1,'dfs',NULL,1,'2021-02-25 21:33:55',NULL,NULL),
(58,47,1,'fsdf',NULL,1,'2021-02-25 21:33:56',NULL,NULL),
(59,47,1,'fsdf',NULL,1,'2021-02-25 21:34:08',NULL,NULL),
(60,47,1,'dfsdf',NULL,1,'2021-02-25 21:34:14',NULL,NULL),
(61,47,1,'fsdf',NULL,1,'2021-02-25 21:34:17',NULL,NULL),
(62,1,47,'Hello',NULL,1,'2021-02-25 21:34:59',NULL,NULL),
(63,1,47,'test',NULL,1,'2021-02-26 04:49:11',NULL,NULL),
(64,1,47,'hiw',NULL,1,'2021-02-26 04:49:17',NULL,NULL),
(65,1,47,'hi',NULL,1,'2021-02-26 04:49:22',NULL,NULL),
(66,1,47,'how are you?',NULL,1,'2021-02-26 04:49:31',NULL,NULL),
(67,1,47,'what are you doing?',NULL,1,'2021-02-26 04:49:42',NULL,NULL),
(68,1,47,'I want discuss about the job.',NULL,1,'2021-02-26 04:50:02',NULL,NULL),
(69,47,1,'yeah ',NULL,1,'2021-02-26 04:50:09',NULL,NULL),
(70,47,1,'I\'m herer',NULL,1,'2021-02-26 04:50:13',NULL,NULL),
(71,1,47,'\'???',NULL,1,'2021-02-26 04:50:35',NULL,NULL),
(72,47,1,'?',NULL,1,'2021-02-26 04:50:49',NULL,NULL),
(73,47,1,'?',NULL,1,'2021-02-26 04:50:53',NULL,NULL),
(74,47,1,'?',NULL,1,'2021-02-26 04:50:55',NULL,NULL),
(75,47,1,'?',NULL,1,'2021-02-26 04:50:56',NULL,NULL),
(76,47,1,'?',NULL,1,'2021-02-26 04:50:57',NULL,NULL),
(77,47,1,'?',NULL,1,'2021-02-26 04:51:04',NULL,NULL),
(78,47,1,'?',NULL,1,'2021-02-26 04:51:05',NULL,NULL),
(79,47,1,'?',NULL,1,'2021-02-26 04:51:06',NULL,NULL),
(80,47,1,'?',NULL,1,'2021-02-26 04:51:07',NULL,NULL),
(81,47,1,'?',NULL,1,'2021-02-26 04:51:08',NULL,NULL),
(82,47,1,'ssssss',NULL,1,'2021-02-26 05:24:53',NULL,NULL),
(83,47,1,'s',NULL,1,'2021-02-26 05:24:54',NULL,NULL),
(84,1,47,'I will die',NULL,0,'2021-02-26 05:47:43',NULL,NULL);

/*Table structure for table `reports` */

DROP TABLE IF EXISTS `reports`;

CREATE TABLE `reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description_id` bigint(20) NOT NULL,
  `resource_id` varchar(20) NOT NULL,
  `report` text DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;

/*Data for the table `reports` */

insert  into `reports`(`id`,`description_id`,`resource_id`,`report`,`created_at`,`updated_at`) values 
(27,77,'ISWB7OrxXn','111','2021-02-14 09:59:27','2021-02-14 09:59:27'),
(28,78,'ISWB7OrxXn','123','2021-02-14 10:15:01','2021-02-14 10:15:01'),
(29,79,'ISWB7OrxXn','234','2021-02-14 10:15:05','2021-02-14 10:15:05'),
(30,81,'ISWB7OrxXn','ddd','2021-02-14 11:50:29','2021-02-14 11:50:29'),
(31,85,'ISWB7OrxXn','dddd','2021-02-14 12:10:12','2021-02-14 12:10:12'),
(32,87,'ISWB7OrxXn','I finished it','2021-02-14 14:58:51','2021-02-14 14:58:51'),
(33,87,'ISWB7OrxXn','dddd','2021-02-14 15:54:46','2021-02-14 15:54:46'),
(34,81,'ISWB7OrxXn','finished!\nd\nd\nd\nd','2021-02-14 19:42:51','2021-02-14 19:42:51'),
(35,102,'ISWB7OrxXn','Waitlist 90\ncustomer 22','2021-02-14 21:54:10','2021-02-14 21:54:10'),
(36,102,'ISWB7OrxXn','Finished!','2021-02-14 21:54:21','2021-02-14 21:54:21'),
(37,103,'ISWB7OrxXn','Waitlist 12\ncustomer 22','2021-02-14 22:01:19','2021-02-14 22:01:19'),
(38,106,'ISWB7OrxXn','sdfsdfs','2021-02-14 22:10:36','2021-02-14 22:10:36'),
(39,109,'rPjXmtPP1M','meet','2021-02-15 08:06:33','2021-02-15 08:06:33'),
(40,110,'S0d8XhmNH8','res','2021-02-15 08:07:58','2021-02-15 08:07:58'),
(41,111,'S0d8XhmNH8','tes','2021-02-15 08:08:09','2021-02-15 08:08:09'),
(42,110,'rPjXmtPP1M','sdfs','2021-02-15 08:08:54','2021-02-15 08:08:54');

/*Table structure for table `resources` */

DROP TABLE IF EXISTS `resources`;

CREATE TABLE `resources` (
  `ID` varchar(10) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `display_name` varchar(50) DEFAULT NULL,
  `category_name` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `img_path` blob DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `is_sign_up` varchar(10) DEFAULT NULL,
  `working_hour` text DEFAULT NULL,
  `serviceProvide` text DEFAULT NULL,
  `working_data` text DEFAULT NULL,
  `available` varchar(30) NOT NULL DEFAULT 'Available',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `resources` */

insert  into `resources`(`ID`,`user_id`,`name`,`display_name`,`category_name`,`email`,`phone`,`img_path`,`description`,`created_at`,`updated_at`,`is_sign_up`,`working_hour`,`serviceProvide`,`working_data`,`available`) values 
('fPII7VD4YI',1,'resource','1','resource1','resource1@email.com','undefined',NULL,'resource1\n','2021-02-26 04:53:23','2021-02-26 05:25:43',NULL,'{}','[\"8mvAaC87Lk\"]','null','Available'),
('BwqtaHLglp',32,'1111','undefined','mans','1111@email.com','undefined',NULL,'undefined','2021-02-15 08:34:51','2021-02-15 08:34:51',NULL,'{}','[]','null','Available'),
('rPjXmtPP1M',32,'xcvxv','undefined','xcvxcv','xcvxcv@email.com','undefined',NULL,'this is man','2021-02-15 07:43:40','2021-02-15 08:29:56','true','{}','[]','null','Available'),
('IfyDnXSYTy',32,'man2','undefined','mans','man2@email.com','undefined',NULL,'undefined','2021-02-15 07:50:20','2021-02-15 07:50:20','true','{}','[]','null','Available'),
('S0d8XhmNH8',32,'man1','','mans','man1@email.com','undefined',NULL,'undefined','2021-02-15 07:49:39','2021-02-15 07:49:55','true','{}','[]','null','Available');

/*Table structure for table `services` */

DROP TABLE IF EXISTS `services`;

CREATE TABLE `services` (
  `ID` varchar(10) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `display_name` varchar(50) DEFAULT NULL,
  `category_name` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `img_path` blob DEFAULT NULL,
  `description` text DEFAULT NULL,
  `color` varchar(10) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `services` */

insert  into `services`(`ID`,`user_id`,`name`,`display_name`,`category_name`,`email`,`phone`,`img_path`,`description`,`color`,`created_at`,`updated_at`) values 
('8mvAaC87Lk',1,'11111111','undefined','11111111111111111111111111','1111111111111@email.com','undefined',NULL,'undefined','#f44336','2021-02-09 12:02:12','2021-02-09 12:03:30'),
('MBQ8lL0Cry',1,'2','2','2','2','12',NULL,'2','#9c27b0','2021-02-10 22:48:57','2021-02-23 14:39:05'),
('LquCOQ99hz',1,'4','4','4','4','14',NULL,'4','#795548','2021-02-10 22:49:10','2021-02-10 22:49:10'),
('9p0EVhxajU',32,'test','undefined','test','test@email.com','undefined','ÿØÿà\0JFIF\0\0`\0`\0\0ÿş\0;CREATOR: gd-jpeg v1.0 (using IJG JPEG v62), quality = 85\nÿÛ\0C\0	\Z!\Z\"$\"$ÿÛ\0CÿÂ\0\0x\0x\"\0ÿÄ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ÿÄ\0\0\0\0\0\0\0\0\0\0\0\0\0ÿÚ\0\0\0\0ÙO-±\'cA—c@v4c@v4c@vy3lcgÆ¨{#…+w™;å>œœœ\r ¯ÍLwbÅéúbgÔeRİAµ¯¿‘T}ÏÍ8ÆË‡š‘¹D\Zh/bûF/OÔŠ&Vô:¤µ+N¿á+Ôn:\\ŠÕı=[kléY³ÖWSh©ó³ÚqÊ¡b¯ bJ²\\X”E`DX6#§WæóÙAG}á*}~;õO°ó¯r(áböfÖìÂYLèı#Õ:Ge;\nJ¯kwï0µAuv1³:}têTÈİ…1+ß„h¯íI³A»4ÄšÆîh`\0\0\0\0\0\0\0\0ÿÄ\0(\0\0\0\0\0\0\0\0\05 \"06!@ÿÚ\0\0üîsZŞTlåFÎTlåFÎTlåFÎTlåFÎTlåFÎTlåFÎTlkšæŞu–«¼êÚ×9v$+¸“3‰/Åk“ğQõwXH@’¾`m£Æ;·2ÆÒÊäRsç½Ø¶•ÄÍİ<LâQ—DG$¨Râø£êï:¼Ş2WÌ\r´x§¾daK”Á?ĞŸjÓáä¼HÍ²£êï:¿{ÆJù¶É›Y0‘¦álìÓÓW¦ñ´UÂBL¤ƒ–R¥&Qõw_/tøò0h{Šáaõ“{`L1JuóGÕŞu~Yu,A-Œòã¾åúèú»´U¬Ú.m6‹›EÍ¢æÑsh¹´\\Ú.m6‹›EÍ¢å\"*V=ÍcRdE\\qF×ª¢#Ç´oa\ZÂ\røòŠò™È(™Šæ£}SÑ/:ºH1dÓéc=Yo¸bÍ*Š‹õı76,hzYQf^5òŒF±ƒ¦#G|pÜŞˆA£‹úõWyıÕÔX‚%]h°u\'ZÊ²«èh}~I§¬*ì6aÉ_¦ö³H§¦Z®HÃQtÌ[¬¤§Ç]ÖùF11­kQ­kQÄğj+Æa\0;4u\'ø?ÿÄ\04\0	\0\0\0\0\0\0\0\01Qq!a23A‘4¡á 0±²ÁÑğÿÚ\0?qÈ,\'è°Ÿ¢Â~‹	ú,\'è°Ÿ§³³¿íÖ#š0ä~í_ıÊìğÀê­+3\0q7¹û~Š™ñÓËtíâoû˜QÙÔ24=äw^îŒwá³Šû,íîJ0ô¡©y—÷ÓùÑUøïÜ®Îøİz´Û˜™Ì~‡¢¡­©ˆpÓ2ÿ\0R›ï‰´o§Ô¦YR?â%.éä¡§ğÆ.U~;÷+³¤ºãn©´ÔÍ7†‹×u\\mÕq·UÆİU_ıÊ†š#O!9İÉGeßRè\\ì¼÷É6øL„ó¹Mf„¤äÛ®ê¤¡lQ²Góès	öc¯¤’Ş™ì Â›®SG‡!fŠ\Z¦6¶ñ}ù§ÚrÉ¿Ó/E5¢Ù€ndûD<Ë{{÷|“íHÇ±ã?’}k$ª3FÅ:Ğd·‰[Ë‹‹’‘ø/>ƒÿÄ\0&\0\0\0\0\0\0\0\0\0\02!\"1a #0QqÿÚ\0?²Ñh´Z-¼:®EôÃŠ:®F,·ı%s¥$×fyŒÚ?¡Çµ¢QÕrğÃ´£±“_y3ìGäyRâ†ÛîÈqGUÈ£iQEâ‡\'¶¨y½;ú¨k¯‘dm´,Î“7ïD]«Û!a^ÄqUWÀ±SMPÔòšö¥_‡ÿÄ\0<\0\0\0\0\0\0\0!\"134r‘’#AQaq 02Rb‚¡±ÁÑ@BCctáÿÚ\0\0?÷÷œ@åms…´EÎÑ8[D\\áms…´EÎÑ8[D\\áms…´EÎÑ8[D\\áms…y¤ŞÛ¾úÕ6ê£\Z\\{€A¢	oâÙ&å[,Ü‹g›¬Xáæ=Ä;ªmÔ$‰ån‚Mı]¡˜á¤x…êöŠ	‡ocÇxèÉËiø+ŠÆÍ	û•Öz>}×[è¦ı¨³¬ÓEåUÕzEÑŸ«ÿ\0Ul¶¸\'û®¾4|ÚGD;ªmŞ†É‹^İ,”½]¥˜á§x/W´ĞL8<w„a™µiü–NLZ~üŞÎéğMß’îË|4R-.vÓET;ªmŞ–É‹^İ,”½]¥˜á¤}Ad­™²ĞÓGø„a}Ñ#OtGnE›Ø\\h³¥…œJëmgğ±^”½Ãë~\nEÿ\0[kù¢Æu÷7OˆwTÛ¾Ç®?àxŠ½ío™XÚZãÜÜWQg{¼\\h³\\ÈGÒf•òobÕ6ï°Ølí†4PQµYö¹~ÆŠ®%ÇÄ×ÜCº¦\0W«««««««««««««\"˜\"çĞ4’¨-0ó€ÇHĞã ‰U&_cÚæ÷‚¯Fö¼wƒTn=®¦šÈÖ“¢§JÏ‘­ó+_0Yò1¾e^¼)Ş«\\Aª›u¬,.us©ŠšÌó\\‘ÍRúE‡69„mûv©fn‡ÃU7ãıÙ<Á/ª¶ ÿ\0%Zm-9–bØÇî¢´Í$uÎÕ>^¾”¥U¡“„88æ9ÃÅr\r]àF5Mÿ\0ŸöPî©©ò¡¯™EsC\nµ[%iH3[Ú²FÖñV×\'w\néVË;¬m4Sş?ÑIy¿äı—¤\'-9£ùYÖÉ–œË½êÑb}jÃP­ ÷…,V‡İ–:Vâ<“™uÄ‡^c{h„n}%lw.vÕB×Š:î„tš4c§\r*hÁQ­É\Z5¢ºpè$4tš#qmtĞiW¤†7‘Úæ×£(lñ_ù®\nÿ\0CÿÄ\0(\0\0\0\0\0\0\0\0!1A¡Qañq‘ 0±ğÁÑ@ÿÚ\0\0?!ûì†õJ¼a†a†a†a%½Æsß{œô÷ñÉ…BÅ´-kSÌâ¦Ğ:‡¿ùNnÒYÖèóõqÓŠp.+JïšOÇúË£ÁúÍ½gè€~uí”fÁ~·&+_Üµz€pÍÅ¶Ûğ%Z[<\\Ît{òœtç½\n^¸†O]õÄµ!ìOÔnm6îGuÔï;\\şöúPHU<Kn­!}J\\ÁŠ®–úœtç½]\n^¸a„Ó×Iúâf‹§pû›M3j‘]EÑ•KïiÜÚiµîõ_`?2º–­*Z„l<’šß\næwÿ\0œtç¾†§EyØôª7©Ôé|A“£ˆÿ\0rôéK_–_uİ~:sßEØæ\\ªñŠÿ\0ri§×ÇF0!<Öy¬óYæ³ÍgšÏ5k<Öy¬óYæ³ÍcF”€­ĞK´Ë4š=O`Œ„«´ìğ2|Ì°\Z¤#%wD›wš_¶cìƒn•—é¡{¥eË`zÎ •†—wˆÑ\'=T×=cİ#–Ãxâ\rªçÑı¿3WÃÑÀÈGJ\"\'h#Ú\r_nŞ_Ã1;I¯3+Me)iØ:Ugj•X0š2Ş\'!ùú0B¶m™…qš©¥ÇÖ÷`×êË£®³n«dqós\ZF$F8ÁNÉ—Æ>›rRUõoÒ¡€ü<Æ$È/0]7äEu‚Ne¹Ct­\"?!kR%”À›öˆ%%˜érNÉ˜Q+Kè*{K\r^š}¨É‹4Ğ-Ş\ZĞQóKdŞí‘ïÿ\0ÿÚ\0\0\0\0\0\0ËqÇq¨`ˆÓ¼®Ö»Í¿ÿ\0ÉÀ!c÷ÿ\0ßÿ\0ÿ\0ş<Y;è3pQy¥óÏ<óÏ<ÿÄ\0&\0\0\0\0\0\0\0\0\0!1aAQ‘¡ğqÁá0±ÑÿÚ\0?&Ñôœ¿åøg/Ã9~ËğÎ_†\"4Ä\nüQâz“@¾¤)Ô¯¯Ìwa9cøĞíú©êw]OÍ-H¦şİ½aĞ3ré‡Î#•†ÎãŞ{Ç5‚í¨f¨9]²Üùìùœ%ŒÍ]]±gÄãeÆMF‹îUW3­G“üC+Çı¼­Ç—o¬ùì´šı	Àó\\³t-ıÛeESÌàyœ3ægò2Å —y˜&)TÛJW7ìÌEµß~#Ìí‹5¾8¸õS\0 ScĞj .Õ¥ô¼û\rË=¤ªV7{sÇ¼ÉWd¿³*†ÑU§s&‡JmæTo®éôêæ5`J¯B´×_h.‘‰@Xx3Œg2ğÅ% FÆ LÙ\\#fû¸á2—Ïğÿ\0ÿÄ\0&\0\0\0\0\0\0\0\0\01a¡!AQqÑğ á0±ÁÿÚ\0?A–kMi­5¦´ÖøÃÚZ[¤¿ÃhL=¢:oÜ6*O´Å¬ã,È>¶O…=Âéµÿ\0:Í¡0vø \\ì×ÜOƒ|ã©õâa3v;e³h@£´´T¥eºKKKM¤=C( Ï.Ùa.fvCiŒkÊ! Ş0wf”]Q–+…b½ÄIpTAW›x1¼ï\n+å\\eGGğÿ\0ÿÄ\0\'\0\0\0\0\0\0\0!1QğAaÁq‘¡ ±Ñ0@ÿÚ\0\0?ÿ\0¹©Û,×âŞgó8·™Å¼Î-æqo3‹yœ[ÌâŞgó8·™Å¼Î-æ\Z²ÁÙ0ÎSinì·v[»-İ–îËwe»²İÙnì·v[»-İ–îÎSiÊm09nÕf­Ôr4\0½@™®»~&\\hµ¶iCUÙÆ‰öDu\'® WèÁ€º~¼¦Ó”ÚZz	‘ÙÜtG	Ñ}9èİw\rõ9zF›Eûôê­ÄVé¦™lçÕD«÷A“fÁşÍ]uµîÀ«KÄØ\'Ôcİÿ\0’ª<Pö-«ú\"aò³{@¦ }Ğ{ÔÔÑ\')´å6ü	eµKäÜÑ&$Æ„xé¾Z£cÓ§ÑñÛ}Õ¸Š^ƒaƒèış\"CV´ş_¸Çé—vehdî÷¡£á—k@¿HoœS×Öº\ZXbîr›NSoÈv[•åš3wN\nôß¹®•š\r;¹[”Â¡Öpô ££â!I½Ÿí­·#£ÔEÀs^[Ñ?)Š‰’ş1ì[ŞlÒñ¶Ä€Ë²è\0\n\06\')´å6ı5y9Fºô»¯oÇjn_•‰€Úş O¸àÊrCĞµKÒ¸ÑşïĞNü,ß>¡@\0 tüò›NSoÉŞı 2*ªéVÕ®²´ZÆö*?qre®Kîa…`vÇïÊm•A\nãbqïxœ{ÄãŞ\'ñ8÷‰Ç¼N=âqïxœ{ÄãŞ\'ñ	•Ecf);Õ\\-¡¡s÷\0Qb8gİ–ğßh‡•\0Õ^„×/ô/\\\Z™ÑŒ˜5,jå¥…bÌN·J&”:šBk6­Ìç^b\ršVå¹€^ÁQÓ:Aˆ´†÷´ Eh±;3”Ú\"„ô ‡8Ägú%v;\r«¼o €ğ]GjüÂåƒ›.g³g´á$ÒÅ¥x™^üî©â&¨mT&–$»@;ËÁø2ûÛ*ä\ZRJ”]tSúUu^‡È®3ÙLúoäXª€[¤Gô0²Åa½eÌšÁvÓĞ™v]=`¦Îu‡pÊ;¼÷ğ&œƒèi¾b]YÔïp‚À(¢µ\0?V7“©2†$È@»>Ø»lI¡\"İY“LÃ.Î}Ù\n\ru¸ué©\0\ZëY Ñk:˜’XhĞp‰¬‘\r‘“Q,ü\ZOV@ÿ\0MzÍO.MpDÌmÑ½B#°E÷k_Æ‰QÕzËZãwr†_YAêÆFÈR\0\0\0 :N¥	ö}ÿ\0ğÿ\0ÿÙ','this is a test','#f44336','2021-02-15 08:29:36','2021-02-15 08:29:36');

/*Table structure for table `task_descriptions` */

DROP TABLE IF EXISTS `task_descriptions`;

CREATE TABLE `task_descriptions` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `task_id` bigint(20) DEFAULT NULL,
  `title` text DEFAULT NULL,
  `resources` varchar(255) DEFAULT '[]',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `is_done` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8;

/*Data for the table `task_descriptions` */

insert  into `task_descriptions`(`id`,`task_id`,`title`,`resources`,`created_at`,`updated_at`,`is_done`) values 
(101,75,'shopping\nsketing','[\"fPII7VD4YI\"]','2021-02-14 21:39:14','2021-02-26 05:26:58',0),
(102,76,'waitlist 100\ncustomer 30','[\"fPII7VD4YI\"]','2021-02-14 21:44:09','2021-02-26 05:26:42',1),
(103,76,'waitlist 10\ncustomer 100','[\"fPII7VD4YI\"]','2021-02-14 21:44:09','2021-02-26 05:26:42',1),
(104,77,'classmates 10\nneighborhood 20','[\"fPII7VD4YI\"]','2021-02-14 21:52:11','2021-02-26 05:26:09',0),
(105,77,'shopping 2\n','[\"fPII7VD4YI\"]','2021-02-14 21:52:11','2021-02-26 05:26:09',1),
(108,79,'friend 10','[\"rPjXmtPP1M\"]','2021-02-15 07:48:25','2021-02-15 08:21:44',1),
(109,80,'1','[\"IfyDnXSYTy\",\"S0d8XhmNH8\"]','2021-02-15 08:06:03','2021-02-15 08:24:31',1),
(110,80,'2','[\"rPjXmtPP1M\",\"S0d8XhmNH8\",\"IfyDnXSYTy\"]','2021-02-15 08:06:03','2021-02-15 08:24:31',1),
(111,80,'3','[\"IfyDnXSYTy\",\"S0d8XhmNH8\"]','2021-02-15 08:06:03','2021-02-15 08:24:31',1),
(112,81,'1.1','[\"IfyDnXSYTy\",\"rPjXmtPP1M\"]','2021-02-15 08:11:09','2021-02-15 08:21:50',1),
(118,87,'sdfs','[\"ISWB7OrxXn\"]','2021-02-15 14:38:23','2021-02-15 14:38:23',0),
(120,85,'fdgdf','[\"fPII7VD4YI\"]','2021-02-23 14:29:26','2021-02-26 05:26:23',0);

/*Table structure for table `tasks` */

DROP TABLE IF EXISTS `tasks`;

CREATE TABLE `tasks` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `task_period` varchar(255) NOT NULL,
  `progress` varchar(20) NOT NULL DEFAULT 'todo',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=88 DEFAULT CHARSET=utf8;

/*Data for the table `tasks` */

insert  into `tasks`(`id`,`user_id`,`title`,`created_at`,`updated_at`,`task_period`,`progress`) values 
(81,32,'holiday','2021-02-15 08:11:09','2021-02-15 08:11:09','[\"2021-02-09\",\"2021-03-16\"]','doing'),
(80,32,'meetting','2021-02-15 08:06:03','2021-02-15 08:24:31','[\"2021-02-16\",\"2021-03-16\"]','todo'),
(79,32,'party','2021-02-15 07:48:25','2021-02-15 07:48:25','[\"2021-02-03\",\"2021-03-16\"]','done'),
(75,1,'meeting','2021-02-14 21:39:14','2021-02-26 05:26:58','[\"2021-02-10\",\"2021-03-18\"]','doing'),
(77,1,'birthday','2021-02-14 21:52:11','2021-02-26 05:26:09','[\"2021-02-01\",\"2021-02-02\"]','todo'),
(76,1,'party','2021-02-14 21:44:09','2021-02-26 05:26:42','[\"2021-03-02\",\"2021-04-20\"]','doing'),
(85,1,'ddd','2021-02-15 14:26:02','2021-02-26 05:26:23','[\"2021-02-05\",\"2021-03-10\"]','todo'),
(87,1,'Bill\' birthday','2021-02-15 14:38:23','2021-02-15 14:38:23','[\"2021-02-06\",\"2021-03-09\"]','done');

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `businessID` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `firstname` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lastname` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatarUrl` blob DEFAULT NULL,
  `role` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_login` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `businessID` (`businessID`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `users` */

insert  into `users`(`id`,`businessID`,`username`,`firstname`,`lastname`,`email`,`email_verified_at`,`password`,`avatarUrl`,`role`,`remember_token`,`last_login`,`created_at`,`updated_at`) values 
(1,'EQ4g2qcys2lH8hWIBwHn','anton kosiak1','anton','kosiak','antonk@hotmail.com',NULL,'$2a$10$GtbV2HL/zvrCMTt.SXK0seuRkQup8JdtRAWkMgc61C8q05ryjpctC','ÿØÿá\0Exif\0\0II*\0\0\0\0\0\0\0\0\0\0\0\0ÿì\0Ducky\0\0\0\0\0<\0\0ÿá3http://ns.adobe.com/xap/1.0/\0<?xpacket begin=\"ï»¿\" id=\"W5M0MpCehiHzreSzNTczkc9d\"?> <x:xmpmeta xmlns:x=\"adobe:ns:meta/\" x:xmptk=\"Adobe XMP Core 5.6-c132 79.159284, 2016/04/19-13:13:40        \"> <rdf:RDF xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\"> <rdf:Description rdf:about=\"\" xmlns:xmp=\"http://ns.adobe.com/xap/1.0/\" xmlns:xmpMM=\"http://ns.adobe.com/xap/1.0/mm/\" xmlns:stRef=\"http://ns.adobe.com/xap/1.0/sType/ResourceRef#\" xmp:CreatorTool=\"Adobe Photoshop CC 2015.5 (Macintosh)\" xmpMM:InstanceID=\"xmp.iid:1CDF777C5A8C11E68564A2D3E33A09B0\" xmpMM:DocumentID=\"xmp.did:C9ED3BDC5A9811E68564A2D3E33A09B0\"> <xmpMM:DerivedFrom stRef:instanceID=\"xmp.iid:1CDF777A5A8C11E68564A2D3E33A09B0\" stRef:documentID=\"xmp.did:1CDF777B5A8C11E68564A2D3E33A09B0\"/> </rdf:Description> </rdf:RDF> </x:xmpmeta> <?xpacket end=\"r\"?>ÿî\0Adobe\0dÀ\0\0\0ÿÛ\0„\0		\n\n\n\n\r\r\Z\ZÿÀ\0,,\0ÿÄ\0†\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0!1AQa¡\"2q‘±BRrÁ‚¢²Â#3csƒ5áb’ÒS4DÑñCT$\0\0\0\0\0\0\0\0\0\0\0\0\0\0ÿÚ\0\0\0?\0ÿ\0D*\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0z\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ô\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0è\0 \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Ğ\0@\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0 \0€\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0/@\0\0\0\0\0\0\0\0\0\0\0œ™1â§¯–õÇO­yŠÇ¤üŞ#ìøøFiË?º¬Ú>YÒMy§Å»åƒ5¼şÌ~Ã_ªx³¶ÌûXóR<ºE¾i0×³oŞûNyŠÓsZÚyS&´ŸÊà˜kİÒ\'¤ò’*\0\0\0\0\0\0\0\0\0\0\0/@\0\0\0\0\0\0\0\0\0ùË—,vË–ñ#[^Ó¤@3½ÃÅW´Î>ß_R¿ı#ÚŸ³Iåñ®3®l¹³äœ™ò[.IúWŸZ}*À\01\ZO zv}Ë}²vÙ¦•ë}ªOÃYà+IÛ<IµİMqnb6Û‰áY×õvŸ5§İŸ4¦.»¤óE@\0\0\0\0\0\0\0\0\0^€\0\0\0\0\0\0\0\0\0øî÷{}ŞÛÅ½\\uáíiåZÇ–Aî}ÓsÜ2úÙ}œUŸÕ`‰ökçóÛÎÓ/€\0\0\0\0LDÆ“È¾Éâmæ»mí¦ÛnXóOcóO–¿2X²µ?÷‰„h\0\0\0\0\0\0\0\0z\0\0\0\0\0\0\0\0\0–½)K^öŠÒ‘6½§”Dq™\'»wLÃu÷œk‚šÆßô¯ÖŸï[ª³^%@\0\0\0\0\0\0\Z÷i‰¯nÏnşÖóÒyıßù~D«\Z4h\0\0\0\0\0\0\0\0^€\0\0\0\0\0\0\0\03ş*îZÓ·ã7ˆÉ¸û?B¿5‰Yµd\0\0\0\0\0\0\0Y‰‰‰˜´Nµ´s‰10\rÇjßÆÿ\0cq?µ÷3Dt½yü¼Ùj=b€\0\0\0\0\0\0ô\0\0\0\0\0\0\0\0&Õ¬M¯:R±6´ù¢5`7[›î·Yw7÷³ZmğGÑŠ\Zaò\0\0\0\0\0\0\0\0Úğ®îqo¯¶´ûšû1ûÊq–5„«\Z¤h\0\0\0\0\0\0\0 \0€\0\0\0\0\0\0Ÿâÿ\0sÚ3ÌN–ËêâÇ>ˆ\"V-¦@\0\0\0\0\0\0\0\0M¶{`ÜáÏ^Šõ¿É<}\0şƒ:k¬r1ğO&[@\0\0\0\0\0\0z\0\0\0\0\0\0\0\08~.¾›=¶?¯–f¿Ú±+.¬€\0\0\0\0\0\0\0\0k1å€ov\'.Ãm’yÛ\'òbm÷\0\0\0\0\0\0\0 \0€\0\0\0\0\0\0=âÿ\0sgö²|Ğ±+8¬€\0\0\0\0\0\0\0\0\0Üöé/áWğ²ÔzÅ\0\0\0\0\0\0z\0\0\0\0\0\0\0\08^.¦»=µş¦Y‰üjÿ\0bÄ¬Â²\0\0\0\0\0\0\0\0\0Zt¬Ï’½Øcœ[\r¶9ú8©“«-¾à\0\0\0\0\0\0ô\0\0\0\0\0\0\0\0süAƒï»>}#[bõrÇâOD‘+Ó \0\0\0\0\0\0\0\0¦ß³îpà¯ËzÓå>€A5Ò9Gø#“- \0\0\0\0\0\0\0½\0\0\0\0\0\0\0\0	­mY­ãZZ&¶4Æ’ëm}®ç.ÚşöM~SñÃL>@\0\0\0\0\0\0\0\0;^ÚN]ı÷3ÆÚ¼>İøGÉ\ZÊUR4\0\0\0\0\0\0\0Ğ\0@\0\0\0\0\0\0\0Å]¾f´îãİˆÇ¸ø>…¾.K³jÈ\0\0\0\0\0\0\0/˜ˆ‰™™Ò\"9ÌÏ€n;NÃÿ\0CcşÖ}¼óå½¹ÇÅÉ–£Ö(\0\0\0\0\0\0\0/@\0\0\0\0\0\0\0\0ô¥éjd¬[âkzÏ)‰á0Oví™;~ëîç[`¾³·É=käŸïW«L×ˆ@\0\0\0\0\0\0\Zö™›W¸ç¯³íi=g—Ş•*ÈÑ£@\0\0\0\0\0\0\0ô\0\0\0\0\0\0\0\0\0Çy³Ûï6öÛî+®;q‰z¶V¬ù`ŞåÚ÷=¿/©–=lVı–x÷mÿ\0Ky•—P\0\0\0\0	#Yäßdğı·3]Îò³]·:bÉğù)ó¦¬O¢#„DpˆˆF€\0\0\0\0\0\0\0\0 \0€\0\0\0\0\0\0\0\0\0üåÅ‹6+bËHÉŠü-KF± Î÷\nä¬ÎM…½zÿ\0óä-fÓÂ~5ÖqÂÍ‹.“5-‹$}Ç«>•Gà\0\0åÆyÓ³íÛİí´Ûa›×®Iöi\r§€­lğŞÛm5Ë¹˜Üç5®Ÿ«¬ù¢}éøSW™™™Öy¢ \0\0\0\0\0\0\0\0\0/@\0\0\0\0\0\0\0\0\0\0ŠÌòAóÏL§©¸Œv§ÕËêéù@äî;O†m3­é‚wš\">Ml©»7‡zwOWÍëR©Ş>ÍáÍx÷¼ó}å+ó@c¡´íƒÅ°×KG+_$dŸLéèEtâ&b\"±­c”W”|\Z\n€\0\0\0\0\0\0\0\0\0\0Ğ\0@\0\0\0\0\0\0b&xG0y·}Ça´ÿ\0q”·Ô×Ö¿øcYÉÜx·o]cm·¶Iél“êWäep×?7‰û¶OrÔÁ_%+¬ÿ\0ŠÚ˜šğæîüßµÜå¿šo1yæ\"Ş÷µ>Yãóˆ‘ZÇ(€P4€ORŸV>@~é|”i{RcêÚcæzğ÷®í‡Üİ^cêßKÇåj˜º÷àñföºF|8òÇ[WZ[ğÁ†º{oö¼¼2M¶Öıäk_ñWS]LwÇ–ŸyŠõÉIút˜´zT\0\0\0\0\0\0\0z\0\0\0\0\0\0ÄLò+â>ßµ™¦9ÿ\0ÙÍ&¸çÙ‰şõù|‹‰®÷¿÷=ÖµœŸqŠñböxyíïI‰®v‘ñÏ9T\0\0\0\0\0\0\0\0\0~ğfÍƒ\'Ş`ÉlWúÔ>_(;[/î)¥w¸ã5Õ¦•¿ÇìúZ\rûg½§¯¶Ë4÷©ÊõûU0>à\0\0\0\0\0\0½\0\0\0\0\0\0y{‡rÚl1Å÷ö­û<5ã{|Ò<ò#+Ü»æ÷}­&~çoÓ\'ŸÛ·;|Ë‰®.ÉP\0\0\0\0\0\0\0\0\0\0\0ú¥ï%rc´Ó%}ÛÖt˜øà\ZÛâX»Œy£sXüúÇÏ	kC[VÕ­éhµ-\ZÖÕbcËª\0\0\0\0\0½\0\0\0\0\0óß±ì¦vû}2o>–¼kíymæùWÖS.\\¹rÛ.[ÎL·ã{Úu™V_€\0\0\0\0\0\0\0\0\0\0\0\0\0\0î×Ş7=¾úSõ›{N¹6ó<>\ZÏÑ².¶Mæßy‚3íïëãÒÕŸ«hé(Óì\0\0\0\0/@\0\0\0Æïİîv‘;]­¿ıvÖ_ı(ŸÓŸBÈ–²™33ÎfU\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0z»pÜl7}†u‰á—û·¯’|şI´Ùîğo6ÔÜ`qß†“Î¶u·iö\0\0\0è\0 \0\0yî‘Ûö½tÎ]k‚³åëyóTJÅÌÚÖ›ZfÖ´ÌÚÓÆfgœËL \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0gî–íû¯ZÚÎÛ&‘¸§›¥ãÏTXÚÄÖb-Y‹VÑ[G)‰ãĞ\0\0ô\0\0\0™¬DÚÓêÖ±3kO(ˆã2/sßÛ½¾âxSİÃ_&8åòó–™¯(€\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\04Şî|VØdŸkzø5ëM}ªş,úµäP\0z\0\0\0äxŸy8;wÜVt¾ê}Iûão—„,JÉ+ \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ûl÷WÚn±niÏ¢ÓZò´|p\rôZ¶ˆµ\'ZZ\"ÕŸ,Lk¶\0\0/@\0\0/n\'/uœq>ÎŞ•¤}©ö­ó¬f¹\n€\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0gáíÄæíum†mŠxz%šÔtE\0è\0 \0±\ZÌG”.ã—ï{ë$ı,·ôNŸ¦^}D5P5P5P5P5P5P5P5P5P5P5P5P5P5—Â5Á»ÇõoKÇÇYÀ•¨ï¢€ô\0\0„î_Ôw_ÆÉùÒÓ/0€\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0EáùËı$­F‰\0 \0€\0\'rş£ºş6OÎ–™y„\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\Z/ÿ\0Ëş_é%j4H \0½\0\0\0a;—õ×ñ²~t´ËÌ \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ÑxGş_òÿ\0I+Q¢E\0è\08À\0Á÷/ê;¯ãdüéi—˜@\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0£ğü¿åş’V£EÁà\08hÿÙ',NULL,NULL,'2021-02-26 00:30:59','2021-02-26 00:30:59','2021-01-05 13:37:27'),
(47,'EQ4g2qcys2lH8hWIBwHn','testChat2','','','testchat@email.com',NULL,'$2a$10$/IThmkEVfLSWLTVGdVH.kODR32uokKeFP8O0Vl.vFYXYCqLFz8Ypu',NULL,'manager',NULL,'2021-02-25 06:04:13','2021-02-25 06:04:13','2021-02-22 09:24:01'),
(50,'bY0nC5CvPJKAKQX8xlKY','t s','t','s','testing@email.com',NULL,'$2a$10$U5aL1Sl/Pxx5.XJYDNzRoOimElBRMo26ylLducDrxDCuUSPUHx7rm',NULL,NULL,NULL,'2021-02-26 08:15:17','2021-02-26 08:15:17','2021-02-25 06:44:01');

/*Table structure for table `waitlist_settings` */

DROP TABLE IF EXISTS `waitlist_settings`;

CREATE TABLE `waitlist_settings` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `location_name` varchar(255) NOT NULL,
  `limit_max_waiting` tinyint(4) NOT NULL,
  `limit_max_wait_number` varchar(20) NOT NULL,
  `reject_duplicates` tinyint(4) NOT NULL,
  `reject_flagged` tinyint(4) NOT NULL,
  `waiting` varchar(20) NOT NULL,
  `serving` varchar(20) NOT NULL,
  `default_serve_duration` int(11) NOT NULL,
  `default_serve_duration_type` varchar(10) NOT NULL,
  `number_of_serve_people` int(11) NOT NULL,
  `service_duration` tinyint(4) NOT NULL,
  `status_indicator` varchar(30) NOT NULL,
  `hide_cancel` tinyint(4) NOT NULL,
  `call_business` tinyint(4) NOT NULL,
  `PublicWaitlistUrl` varchar(50) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `waitlist_settings` */

insert  into `waitlist_settings`(`ID`,`user_id`,`location_name`,`limit_max_waiting`,`limit_max_wait_number`,`reject_duplicates`,`reject_flagged`,`waiting`,`serving`,`default_serve_duration`,`default_serve_duration_type`,`number_of_serve_people`,`service_duration`,`status_indicator`,`hide_cancel`,`call_business`,`PublicWaitlistUrl`) values 
(1,0,'vangel',0,'',0,0,'never','never',0,'seconds',0,0,'Estimated wait and order in li',0,0,''),
(4,1,'vangel',1,'',1,1,'2hours','2hours',13123,'hours',13123,1,'Only estimated wait',1,1,''),
(5,32,'vangel',0,'',0,0,'1hours','never',0,'seconds',0,0,'Estimated wait and order in li',0,0,''),
(6,50,'vangel',0,'',0,0,'never','never',0,'seconds',0,0,'Estimated wait and order in li',0,0,'stone1');

/*Table structure for table `waitlists` */

DROP TABLE IF EXISTS `waitlists`;

CREATE TABLE `waitlists` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `wait_time` datetime DEFAULT NULL,
  `serve_time` datetime DEFAULT NULL,
  `is_show` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1: show, 0: hidden',
  `order_num` int(11) DEFAULT NULL,
  `resource_id` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=203 DEFAULT CHARSET=utf8;

/*Data for the table `waitlists` */

insert  into `waitlists`(`id`,`user_id`,`customer_id`,`wait_time`,`serve_time`,`is_show`,`order_num`,`resource_id`) values 
(147,1,188,'2021-02-10 12:16:22','2021-02-10 12:17:08',1,1,'uwdL8j96qI'),
(160,32,197,'2021-02-15 07:54:18',NULL,1,1,'rPjXmtPP1M'),
(156,1,196,'2021-02-10 12:26:07','2021-02-10 12:28:23',1,1,'ISWB7OrxXn'),
(165,1,200,'2021-02-24 07:27:19','2021-02-24 08:31:39',0,1,'vgftEu4nLN'),
(161,1,189,'2021-02-23 14:25:58',NULL,1,1,NULL),
(162,1,201,NULL,'2021-02-23 14:26:25',1,NULL,NULL),
(163,1,202,'2021-02-23 14:27:08',NULL,1,1,'uwdL8j96qI'),
(151,1,192,NULL,'2021-02-10 12:03:28',1,NULL,'vgftEu4nLN'),
(139,1,182,NULL,'2021-02-10 11:04:26',1,NULL,'WJKtIvm3tX'),
(143,1,185,'2021-02-10 12:16:24','2021-02-10 12:17:09',1,1,'vgftEu4nLN'),
(141,1,183,'2021-02-10 12:16:25','2021-02-10 12:28:22',0,1,'ISWB7OrxXn'),
(142,1,184,NULL,'2021-02-10 11:15:28',1,NULL,'WJKtIvm3tX'),
(150,1,191,NULL,'2021-02-10 12:03:05',1,NULL,'vgftEu4nLN'),
(145,1,186,'2021-02-10 12:17:00','2021-02-10 12:23:41',1,1,'ISWB7OrxXn'),
(148,1,189,'2021-02-10 11:53:32','2021-02-10 11:53:40',0,1,'vgftEu4nLN'),
(166,1,200,NULL,'2021-02-24 07:27:51',0,NULL,'vgftEu4nLN'),
(137,1,180,'2021-02-10 12:16:39','2021-02-23 14:09:14',0,1,'vgftEu4nLN'),
(167,1,200,'2021-02-24 07:28:30','2021-02-24 14:26:19',0,1,'ISWB7OrxXn'),
(168,1,207,NULL,'2021-02-24 08:27:07',0,NULL,'vgftEu4nLN'),
(169,1,207,NULL,'2021-02-24 08:28:16',0,NULL,'ISWB7OrxXn'),
(170,1,207,'2021-02-24 08:29:20','2021-02-24 08:29:42',0,1,'uwdL8j96qI'),
(171,1,211,'2021-02-24 14:26:35','2021-02-24 14:27:04',0,1,'MxFurJcx1v'),
(196,1,222,'2021-02-26 14:20:22',NULL,1,NULL,NULL),
(173,1,210,'2021-02-24 14:26:36',NULL,1,1,NULL),
(174,1,209,'2021-02-24 14:26:37',NULL,1,1,NULL),
(193,1,220,'2021-02-26 14:06:40',NULL,1,NULL,NULL),
(176,1,211,'2021-02-24 19:51:25','2021-02-25 11:39:09',0,1,'ISWB7OrxXn'),
(202,50,228,'2021-02-26 16:34:01',NULL,1,NULL,NULL),
(194,1,216,'2021-02-26 14:07:22',NULL,1,NULL,NULL),
(182,1,210,'2021-02-25 01:52:41',NULL,1,1,NULL),
(201,50,227,'2021-02-26 16:30:48',NULL,1,NULL,NULL),
(200,50,226,'2021-02-26 16:22:51',NULL,1,NULL,NULL),
(199,50,225,'2021-02-26 16:20:25',NULL,1,NULL,NULL),
(198,50,224,'2021-02-26 16:20:08',NULL,1,NULL,NULL),
(195,1,221,'2021-02-26 14:16:02',NULL,1,NULL,NULL),
(188,1,210,'2021-02-25 15:30:19',NULL,1,1,NULL),
(189,1,211,'2021-02-26 10:48:54',NULL,1,1,NULL),
(190,1,208,'2021-02-26 10:48:55',NULL,1,1,NULL),
(191,1,207,'2021-02-26 10:48:55',NULL,1,1,NULL),
(192,1,219,'2021-02-26 14:03:36',NULL,1,NULL,NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
