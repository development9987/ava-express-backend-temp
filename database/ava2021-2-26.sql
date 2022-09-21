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
('EQ4g2qcys2lH8hWIBwHn',1,'Magasin Vidéotron Blainville'),
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
('9p0EVhxajU',32,'test','undefined','test','test@email.com','undefined','����\0JFIF\0\0`\0`\0\0��\0;CREATOR: gd-jpeg v1.0 (using IJG JPEG v62), quality = 85\n��\0C\0	\Z!\Z\"$\"$��\0C��\0\0x\0x\"\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\0\0\0\0\0\0\0\0\0\0\0\0\0��\0\0\0\0�O-�\'cA�c@v4c@v4c@vy3lcgƨ{#�+w��;�>���\r���Lwb����bg�eR�A�����T}���8�ˇ�����D\Zh/b�F/OԊ&V�:��+N��+�n:\\���=[kl�Y��WSh���qʞ�b����bJ�\\X��E�`DX6#�W���AG}�*}~;�O��r(�b�f���YL��#�:Ge;\nJ�kw�0�Auv1�:}t�T���1+߄h��I�A��4Ě��h`\0\0\0\0\0\0\0\0��\0(\0\0\0\0\0\0\0\0\05 \"06!@��\0\0��sZ�Tl�F�Tl�F�Tl�F�Tl�F�Tl�F�Tl�F�Tlk���u�������9v$+��3�/�k��Q�w�XH@��`m��;�2�����Rs�ض����<L�Q�DG$�R�����:��2W�\r�x��daK��?Пj���HͲ���:�{�J����ɛY0���l���W��U�BL���R�&Q�w�_�/t��0h{��a��{`L1Ju�G��u~Yu,A-���������U��.m6��E͢��sh��\\�.m6��E͢�\"*V=�cRdE\\qFת�#Ǵoa\Z�\r���ȏ�(���}S�/:�H1d��c=Yo�b�*����76,hzYQf^5�F���#G��|p�ވA����Wy���X�%]h��u\'Zʲ��h}~I��*�6a�_���H��Z��H�Qt�[����]���F11�kQ�kQ���j+�a\0;4u\'�?��\04\0	\0\0\0\0\0\0\0\01Qq!a23A�4�� 0��������\0?q�,\'谟��~�	�,\'谟������#�0�~�_��������+3\0q7��~�����t��o��Q��24=��w^�w᳊�,��J0���y�����U��ܮ���z�����~������p�2�\0R�o�ԦYR?�%.�䡧���.U~;�+����n����7���u\\m�q�U��U_��ʆ�#O�!9��Ge�R�\\���6��L���Mf���ۮꤡlQ�G��s	�c����ޙ� ���SG�!f�\Z�6��}���rɿ�/E5���nd�D<�{{�|��HǱ�?�}k$�3�F�:�d��[ˋ�����/>���\0&\0\0\0\0\0\0\0\0\0\02!\"1a #0Qq��\0?��h�Z-�:�E�Ê:�F,��%s���$�fy��?�ǵ�Q�r�ô���_y3�G�yR����qGUȣiQE�\'��y�;���k��dm�,Γ7�D]��!a^�qUW��SMP����_���\0<\0\0\0\0\0\0\0!\"134r��#AQaq 02Rb������@BCct���\0\0?���@�ms��E��8[D\\�ms��E��8[D\\�ms��E��8[D\\�ms�y��۾��6�\Z\\{�A�	o��&�[,܋g���X��=�;�m�$��n�M�]���x����	�oc�x���i�+���	���z>}�[������E�U�zEџ��\0Ul��\'���4|�GD;�mކ��^�,��]���x/W��L8<w�a��i��NLZ~�����Mߒ��|4R-.v�ET;�mޖ��^�,��]���}Ad�����G��a}��#OtGnE��\\h����J�mg�^����~\n�E��\0[k���u�7O�wT۾Ǯ?��x����o�X�Z���WQg{�\\h�\\�G�f��ob�6��l�4PQ�Y��~Ɗ�%����C��\0W�������������\"�\"��4��-0��H���U&�_c�����F��w�Tn=����֓��Jϑ��+_0Y�1�e^�)ޫ\\A��u�,.us�����\\��R�E�69�m�v�fn��U7���<��/����\0%Zm-9�b���$u��>^���U����88�9���r\r]�F5M�\0��P���EsC\n�[%iH3[ڲF��V�\'w\n�V�;��m4S�?�Iy�����\'-9��Y����˽��b}j�P� ��,V�ݖ:�V�<��uć^c{h�n}%lw.v�B׊:�t�4c�\r*�h�Q��\Z5��p�$4t�#q�mt�iW��7���ף(l�_��\n�\0C��\0(\0\0\0\0\0\0\0\0!1A�Qa�q� 0�����@��\0\0?!���J�a�a�a�a%��s�{�����ɅBŴ-kS����:���Nn�Y����qӞ�p.+J�O��ˣ���ͽg�~u��f�~�&+_܎�z�p�Ŷ��%Z[<\\�t{�t�\n^��O]�ĵ!�O�nm6�Gu��;\\�����PHU<Kn�!}J\\������t�]\n^�a���I��f��p��M3j�]EѕK�i��i���_`?2���*Z�l<���\n�w�\0�t羆�Ey���7���|A����\0r��K_�_u�~�:s�E��\\����\0ri���F0�!<�y��Y��g��5�k<�y��Y��cF����K��4�=O`������2|̰\Z�#%wD�w�_�c썃n����{�e�`z� ���w��\'=T��=c�#��x�\r�����3W����GJ\"\'h#�\r_n�_�1;I�3+Me)i�:Ugj�X0�2�\'!��0B��m��q������`��ˣ��n�dq�s\Z�F$F8�Nɗ�>�rRU�o����<�$�/0]7�Eu��Ne�Ct�\"?!kR%�����%%���rNɘQ+K�*{K\r^�}�ɋ4�-�\ZАQ�Kd����\0��\0\0\0\0\0\0�q�q�`����ֻͿ�\0��!c��\0��\0�\0�<Y;�3pQy����<��<��\0&\0\0\0\0\0\0\0\0\0!1aAQ����q��0����\0?&������g/�9~���_�\"4�\n�Q�z�@��)ԯ��wa9c������w]O�-H����a�3r���#�����{�5��f�9]�������%��]]�g��e�MF��UW3�G��C+������o���촚�	��\\�t-��eES��y�3��g�2���y�&)T�JW7��E��~#���5�8��S\0�Sc��j��.ե���\r�=��V7{sǼ�Wd��*��U�s&�J�m��To�����5`J�B��_h.��@Xx3�g2��% FƠL�\\#f����2����\0��\0&\0\0\0\0\0\0\0\0\01a�!AQq��� �0����\0?A�kMi�5������Z[���hL=�:o�6*O�Ŭ�,�>�O�=���\0:͡0v��\\���O�|���a3v;e�h@���T�e�KKKM�=C( �.ُa.fvCi�k�!��0wf�]Q�+�b��IpTAW�x1��\n+�\\eGG��\0��\0\'\0\0\0\0\0\0\0!1Q�Aa�q��� ��0@��\0\0?�\0���,���g�8��ż�-�qo3�y�[���g�8��ż�-�\Z����0�Sin�v[�-ݖ��we����n�v[�-ݖ��Si�m09n�f��r4\0�@���~&\\h���iCU�Ɖ��Du\'� W����~��Ӕ�Zz	���tG	�}9��w\r�9zF�E����V香l��D��A�f���]u�����K��\'�c��\0��<P�-��\"a�{@��� }�{���\')��6�	e�K���&$Ƅx�Z�cӧ���}ո�^�a����\"CV��_���vehd�����k@�Ho�S�ֺ\ZXb�r�NSo�v[���3wN\n�߹�����\r;�[�¡�p� ���!I���#��E�s^[�?)����1�[�l���Ā˲��\0\n\06\')��6�5y9F����o�jn_����� O���rCеKҸ����N�,ߍ>�@\0�t��NSo����2*���Vծ��Z��*?qre�K�a�`v���m�A\n�bq��x�{���\'�8��ǼN=�q��x�{���\'�	�Ecf);�\\-��s�\0Qb8gݖ��h��\0�^��/�/\\\Z�ь�5,j奅b��N�J&�:�Bk6���^b\r�V幀^�Q�:A����� Eh�;3��\"�� �8�g�%v;\r��o���]Gj��僛.g�g��$�ťx�^���&�mT&�$�@;���2��*�\ZRJ�]tS�Uu^�Ȯ3���L�o�X��[�G�0��ŝa�e�̚�v�Йv]=`��u�p�;���&���i�b]Y��p��(���\0?V7��2�$�@�>��lI�\"�Y�L��.�}�\n\ru�u�\0\Z�Y �k:���Xh��p���\r���Q,�\ZOV@�\0Mz�O.MpD�m��B#�E�k_ƉQ�z�Z�wr�_YA��F�R\0\0\0�:N�	��}�\0��\0��','this is a test','#f44336','2021-02-15 08:29:36','2021-02-15 08:29:36');

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
(1,'EQ4g2qcys2lH8hWIBwHn','anton kosiak1','anton','kosiak','antonk@hotmail.com',NULL,'$2a$10$GtbV2HL/zvrCMTt.SXK0seuRkQup8JdtRAWkMgc61C8q05ryjpctC','����\0Exif\0\0II*\0\0\0\0\0\0\0\0\0\0\0\0��\0Ducky\0\0\0\0\0<\0\0��3http://ns.adobe.com/xap/1.0/\0<?xpacket begin=\"﻿\" id=\"W5M0MpCehiHzreSzNTczkc9d\"?> <x:xmpmeta xmlns:x=\"adobe:ns:meta/\" x:xmptk=\"Adobe XMP Core 5.6-c132 79.159284, 2016/04/19-13:13:40        \"> <rdf:RDF xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\"> <rdf:Description rdf:about=\"\" xmlns:xmp=\"http://ns.adobe.com/xap/1.0/\" xmlns:xmpMM=\"http://ns.adobe.com/xap/1.0/mm/\" xmlns:stRef=\"http://ns.adobe.com/xap/1.0/sType/ResourceRef#\" xmp:CreatorTool=\"Adobe Photoshop CC 2015.5 (Macintosh)\" xmpMM:InstanceID=\"xmp.iid:1CDF777C5A8C11E68564A2D3E33A09B0\" xmpMM:DocumentID=\"xmp.did:C9ED3BDC5A9811E68564A2D3E33A09B0\"> <xmpMM:DerivedFrom stRef:instanceID=\"xmp.iid:1CDF777A5A8C11E68564A2D3E33A09B0\" stRef:documentID=\"xmp.did:1CDF777B5A8C11E68564A2D3E33A09B0\"/> </rdf:Description> </rdf:RDF> </x:xmpmeta> <?xpacket end=\"r\"?>��\0Adobe\0d�\0\0\0��\0�\0		\n\n\n\n\r\r\Z\Z��\0,,\0��\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0!1AQa�\"2q���BRr�����#3cs�5�b��S4D��CT$\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\0\0\0?\0�\0D*\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0z\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0 \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0@\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0/@\0\0\0\0\0\0\0\0\0\0\0��1⧯���O�y�Ǥ��#���Fi�?���>Y�My�Ż�5���~�_�x����X�R<�E�i0׳o��Ny��sZ�yS&�����k��\'��*\0\0\0\0\0\0\0\0\0\0\0/@\0\0\0\0\0\0\0\0\0�˗,v˖�#[^Ӥ@3���W��>�_R��#ڟ�I��3�l��䜙�[.I�W�Z}*��\01\ZO zv}�}��v٦��}�O�Y�+I�<I��Mqnb6ۉ�Y��v�5�ݟ4�.���E@\0\0\0\0\0\0\0\0\0^�\0\0\0\0\0\0\0\0\0���{}��ۍŽ\\u��i�ZǖA��}�s�2��}�U��`��k�����/�\0\0\0\0LDƓ����m�m��nX�Oc�O��2X��?���h\0\0\0\0\0\0\0\0z\0\0\0\0\0\0\0\0\0��)K^��ґ6���Dq�\'�wL��u��k������֟�[��^%@\0\0\0\0\0\0\Z�i��n�n����y���~D�\Z4h\0\0\0\0\0\0\0\0^�\0\0\0\0\0\0\0\03�*�Zӷ�7�ɸ�?B�5�Y�d\0\0\0\0\0\0\0Y�����N��s��10\r�j���\0c�q?��3Dt�y���j=b�\0\0\0\0\0\0�\0\0\0\0\0\0\0\0&լM�:R�6���5�`7[��Yw7��Zm�Gя�\Za�\0\0\0\0\0\0\0\0���qo������1��q��5��\Z�h\0\0\0\0\0\0\0�\0�\0\0\0\0\0\0���\0s�3�N����Ǟ>�\"V-�@\0\0\0\0\0\0\0\0M�{`���^����<}\0��:k�r�1�O&[@\0\0\0\0\0\0z\0\0\0\0\0\0\0\08~.��=�?��f�ڱ+.��\0\0\0\0\0\0\0\0�k1�ov\'.�m�y�\'�bm�\0\0\0\0\0\0\0�\0�\0\0\0\0\0\0=��\0sg��|б+8��\0\0\0\0\0\0\0\0\0���/�W��z�\0\0\0\0\0\0z\0\0\0\0\0\0\0\08^.��=���Y��j�\0bĬ²\0\0\0\0\0\0\0\0\0Zt�ϒ��c�[\r�9�8���-��\0\0\0\0\0\0�\0\0\0\0\0\0\0\0s�A��>}#[b�r��OD�+� \0\0\0\0\0\0\0\0����p��z��>�A�5�9G�#�-�\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0	�mY��ZZ&��4ƒ�m}��.���M~�S��L>@\0\0\0\0\0\0\0\0;^�N]��3�ڼ>��G�\Z�U�R4\0\0\0\0\0\0\0�\0@\0\0\0\0\0\0\0�]�f���݈Ǹ�>��.K�j�\0\0\0\0\0\0\0/������\"9���n;N��\0Cc���}��役��ɖ��(\0\0\0\0\0\0\0/@\0\0\0\0\0\0\0\0���jd�[�kz�)��0Ov�;~���[`����=k��W�L׈@\0\0\0\0\0\0\Z���W�篳�i=g���*�ѣ@\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0�y���6���+�;q��z��V��`����=�/��=lV��x�m�\0Ky���P\0\0\0\0	�#Y��d���3]��]�:b����)󦬍O�#�Dp��F�\0\0\0\0\0\0\0\0�\0�\0\0\0\0\0\0\0\0\0��ŋ6+b�HɊ�-KF� ��\n��M��z�\0��-f��~5�q�͋.��5-�$}ǫ>�G�\0\0��yӳ�����a�׮I�i\r���l���m5˹���5������}��SW����y��\0\0\0\0\0\0\0\0\0/@\0\0\0\0\0\0\0\0\0\0���A��L����v������@��;O�m3��w�\">Ml���7�zwOW��R���>���x���}�+�@c��흃Ű�KG+_$d�L��Et�&b\"��c�W�|\Z\n�\0\0\0\0\0\0\0\0\0\0�\0@\0\0\0\0\0\0b&xG0y�}�a��\0q�����ֿ�cY��x�o]cm��I�l��W�ep�?7���Or��_%+��\0�ژ�����ߵ�忚o1�y�\"���>Y��Z�(�P4�OR�V>@~�|��i{Rc��c�z������^c��K��j�����f��F|8��[WZ[����{o���2M����k_�WS]Lwǖ�y���I�t��zT\0\0\0\0\0\0\0z\0\0\0\0\0\0�L�+�>ߵ��9�\0��&��ى���|������=ֵ��q��b�xy��I��v���9T\0\0\0\0\0\0\0\0\0~�f̓\'�`�lW�ԝ>_(;[/�)�w��5զ�����Z\r��g�����4�����U�0�>�\0\0\0\0\0\0�\0\0\0\0\0\0y{�r�l1�����<5�{|�<�#+ܻ��}�&~�o�\'�۷;|ˉ�.�P\0\0\0\0\0\0\0\0\0\0\0���%rc��%}��t���\Z��X��y�sX����	�kC[Vխ�h�-\Z�՝bc��\0\0\0\0\0�\0\0\0\0\0��߱�v�}2o>��k��ym��W�S.\\�r�.[�L��{�u�V_�\0\0\0\0\0\0\0\0\0\0\0\0\0\0���7=��S��{N�6�<>\Z�Ѳ.�M��y�3�����՟�h�(��\0\0\0\0/@\0\0\0����v�;]���v��_�(�ӟBȖ����33�fU�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0z�p�l7}�u������|�I����o6��`�q߆�ζ�u��i�\0\0\0�\0 \0\0y�����t��]k����y�TJ���֛Zfִ����fg��L�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0g����Z���&�������TX���b-Y�V�[G)���\0\0�\0\0\0��D���ֱ3kO(��2/s�����xS��_&8��󖙯(�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\04��|V�d�kz�5�M}��,���P\0z\0\0\0�x�y8;w�Vt��}I��o��,J�+ \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�l�W�n�ni���Z�|p\r�Z���\'ZZ\"՟,Lk�\0\0/@\0\0/n\'/u�q>�ޕ�}����f�\n�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0g�����u�m�m�xz%��tE\0�\0 \0�\Z�G�.��{��$�,��N���^}D5P5P5P5P5P5P5P5P5P5P5P5P5P5��5����oK��Y�����\0\0��_�w_�����/0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0E����$�F�\0�\0�\0\'r����6OΖ�y�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\Z/�\0��_�%j4H�\0�\0\0\0a;����~t��� \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�xG�_��\0I+Q�E\0�\08�\0��/�;��d��i��@\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��������V�E��\08h��',NULL,NULL,'2021-02-26 00:30:59','2021-02-26 00:30:59','2021-01-05 13:37:27'),
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
