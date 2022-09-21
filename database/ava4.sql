-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 14, 2022 at 04:50 PM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 7.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ava4`
--

-- --------------------------------------------------------

--
-- Table structure for table `alert_settings`
--

CREATE TABLE `alert_settings` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `key` varchar(50) NOT NULL,
  `data_field` text NOT NULL,
  `enable` tinyint(4) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `alert_settings`
--

INSERT INTO `alert_settings` (`id`, `user_id`, `key`, `data_field`, `enable`) VALUES
(8, 1, 'Cancelled', '{\"SendAsSMS\":true,\"LeftCharactor\":70,\"sms_template\":\"You\'ve been cancelled from the waitlist for {business}. Thanks for letting us know, {name}\",\"SendAsEmail\":true,\"email_template\":\"Hi {name}!\\n\\nYou\'ve been cancelled from the waitlist for {business}.\\n\\nThank you!\\n\\n*{business}*\"}', 1),
(9, 1, 'NoShow', '{\"SendAsSMS\":true,\"LeftCharactor\":105,\"sms_template\":\"Your place in line at {business} was marked as no-show.\",\"SendAsEmail\":true,\"email_template\":\"Hi {name}! \\n\\nYour place in line at {business} was marked as no-show. We hope to see you back soon!\"}', 1),
(16, 1, 'BookingReminder', '{\"SendAsSMS\":true,\"LeftCharactor\":85,\"sms_template\":\"Heads-up that your booking is {calendar} at {business}. Manage it on {link}\",\"SendAsEmail\":true,\"email_template\":\"Hi {name}!\\n\\nHeads-up that you have an booking coming up {calendar} at {business}. \\n\\nManage your booking on {link}.\\n\\nWe look forward to serve you soon!\\n\\n*{business}*\",\"remaining_time\":\"5 min\"}', 1),
(75, 1, 'NextInLine', '{\"SendAsSMS\":true,\"LeftCharactor\":43,\"sms_template\":\"Heads up! It\'s soon your turn at {business} so start heading back. If you can\'t make it, go to {link} or reply \'cance\",\"SendAsEmail\":true,\"email_template\":\"Hi {name}!\\n\\nIt\'s soon your turn at {business} so start heading back. If you cannot make it, please [cancel yourself]({link}).\\n\\nWe look forward to serve you soon!\\n\\n*{business}*\",\"order_line\":\"1th in line\",\"order_relation\":\"everyone in line\"}', 1),
(77, 1, 'Alert', '{\"SendAsSMS\":false,\"LeftCharactor\":47,\"sms_template\":\"Voila! It\'s your turn at {business}. Please return in 5 min. If you can\'t make it, go to {link} or reply \'cancel\'\",\"SendAsEmail\":false,\"email_template\":\"Hi {name}!\\n\\nIt\'s your turn at {business}. Please return in 5 min. If you cannot make it, please [cancel yourself]({link}).\\n\\nWe look forward to serve you soon!\\n\\n*{business}*\"}', 0),
(79, 1, 'BookingAlert', '{\"SendAsSMS\":true,\"LeftCharactor\":66,\"sms_template\":\"Voila! It\'s time for your booking at {business}. Please be ready in 5 min! Manage it on {link}\",\"SendAsEmail\":true,\"email_template\":\"Hey {name}!\\n\\nGet ready for your booking {calendar} at {business}. We look forward to see you in just a moment! \\n\\n*{business}*\"}', 1),
(51, 1, 'Completed', '{\"SendAsSMS\":false,\"LeftCharactor\":89,\"sms_template\":\"Thank you for visiting {business}, {name}! We hope to see you back soon\",\"SendAsEmail\":false,\"email_template\":\"Thank you for visiting {business}, {name}!\\n\\nWe hope to see you back soon.\"}', 0),
(70, 1, 'Confirmation', '{\"SendAsSMS\":true,\"LeftCharactor\":36,\"sms_template\":\"Hi {name}! You\'re waitlisted to {business} as #{order} in line. See live wait at {link} Reply \'cancel\' if you can\'t make it.\",\"SendAsEmail\":true,\"subject\":\"\",\"email_template\":\"Hi {name}!\\n\\nYou\'ve been waitlisted to {business} as #{order} in line. [View the waitlist]({link}) and remove yourself if you cannot make it.\\n\\nWe look forward to serve you soon!\\n\\n*{business}*\"}', 1),
(78, 1, 'Served', '{\"SendAsSMS\":false,\"LeftCharactor\":117,\"sms_template\":\"Finally! You have been served at {business}\",\"SendAsEmail\":false,\"email_template\":\"Hi {name}!\\n\\nWe\'re happy to now serve you at {business}.\"}', 0),
(80, 52, 'Confirmation', '{\"SendAsSMS\":false,\"LeftCharactor\":36,\"sms_template\":\"Hi {name}! You\'re waitlisted to {business} as #{order} in line. See live wait at {link} Reply \'cancel\' if you can\'t make it.\",\"SendAsEmail\":false,\"subject\":\"\",\"email_template\":\"Hi {name}!\\n\\nYou\'ve been waitlisted to {business} as #{order} in line. [View the waitlist]({link}) and remove yourself if you cannot make it.\\n\\nWe look forward to serve you soon!\\n\\n*{business}*\"}', 0),
(81, 52, 'BookingConfirmation', '{\"SendAsSMS\":false,\"LeftCharactor\":66,\"sms_template\":\"Hi {name}! You\'re scheduled for an booking {date} at {hour} at {business}. Manage it on {link}\",\"SendAsEmail\":false,\"email_template\":\"Hi {name}!\\n\\nYou\'ve been scheduled for an booking {calendar} at {business}. \\n\\nManage your booking on {link}. \\n\\nWe look forward to serve you soon!\\n\\n*{business}*\"}', 0),
(82, 52, 'NextInLine', '{\"SendAsSMS\":false,\"LeftCharactor\":43,\"sms_template\":\"Heads up! It\'s soon your turn at {business} so start heading back. If you can\'t make it, go to {link} or reply \'cance\",\"SendAsEmail\":false,\"subject\":\"\",\"email_template\":\"Hi {name}!\\n\\nIt\'s soon your turn at {business} so start heading back. If you cannot make it, please [cancel yourself]({link}).\\n\\nWe look forward to serve you soon!\\n\\n*{business}*\",\"order_line\":\"1th in line\",\"order_relation\":\"everyone in line\"}', 0),
(83, 52, 'Alert', '{\"SendAsSMS\":false,\"LeftCharactor\":47,\"sms_template\":\"Voila! It\'s your turn at {business}. Please return in 5 min. If you can\'t make it, go to {link} or reply \'cancel\'\",\"SendAsEmail\":false,\"subject\":\"66\",\"email_template\":\"Hi {name}!\\n\\nIt\'s your turn at {business}. Please return in 5 min. If you cannot make it, please [cancel yourself]({link}).\\n\\nWe look forward to serve you soon!\\n\\n*{business}*\"}', 0),
(84, 52, 'Served', '{\"SendAsSMS\":false,\"LeftCharactor\":117,\"sms_template\":\"Finally! You have been served at {business}\",\"SendAsEmail\":false,\"subject\":\"88\",\"email_template\":\"Hi {name}!\\n\\nWe\'re happy to now serve you at {business}.\"}', 0),
(85, 52, 'Completed', '{\"SendAsSMS\":false,\"LeftCharactor\":89,\"sms_template\":\"Thank you for visiting {business}, {name}! We hope to see you back soon\",\"SendAsEmail\":false,\"subject\":\"\",\"email_template\":\"Thank you for visiting {business}, {name}!\\n\\nWe hope to see you back soon.\"}', 0),
(86, 52, 'Cancelled', '{\"SendAsSMS\":false,\"LeftCharactor\":70,\"sms_template\":\"You\'ve been cancelled from the waitlist for {business}. Thanks for letting us know, {name}\",\"SendAsEmail\":false,\"subject\":\"\",\"email_template\":\"Hi {name}!\\n\\nYou\'ve been cancelled from the waitlist for {business}.\\n\\nThank you!\\n\\n*{business}*\"}', 0),
(87, 52, 'NoShow', '{\"SendAsSMS\":false,\"LeftCharactor\":105,\"sms_template\":\"Your place in line at {business} was marked as no-show.\",\"SendAsEmail\":false,\"subject\":\"6\",\"email_template\":\"Hi {name}! \\n\\nYour place in line at {business} was marked as no-show. We hope to see you back soon!\"}', 0),
(88, 52, 'BookingCompleted', '{\"SendAsSMS\":false,\"LeftCharactor\":89,\"sms_template\":\"Thank you for visiting {business}, {name}! We hope to see you back soon\",\"SendAsEmail\":false,\"subject\":\"\",\"email_template\":\"Thank you for visiting {business}, {name}!\\n\\nWe hope to see you back soon.\"}', 0);

-- --------------------------------------------------------

--
-- Table structure for table `alert_settings_default`
--

CREATE TABLE `alert_settings_default` (
  `key` varchar(50) NOT NULL,
  `value` text DEFAULT NULL,
  `enable` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `alert_settings_default`
--

INSERT INTO `alert_settings_default` (`key`, `value`, `enable`) VALUES
('Alert', '{\"SendAsSMS\":false,\"LeftCharactor\":47,\"sms_template\":\"Voila! It\'s your turn at {business}. Please return in 5 min. If you can\'t make it, go to {link} or reply \'cancel\'\",\"SendAsEmail\":false,\"email_template\":\"Hi {name}!\\n\\nIt\'s your turn at {business}. Please return in 5 min. If you cannot make it, please [cancel yourself]({link}).\\n\\nWe look forward to serve you soon!\\n\\n*{business}*\"}', 0),
('BookingAlert', '{\"SendAsSMS\":false,\"LeftCharactor\":66,\"sms_template\":\"Voila! It\'s time for your booking at {business}. Please be ready in 5 min! Manage it on {link}\",\"SendAsEmail\":false,\"email_template\":\"Hey {name}!\\n\\nGet ready for your booking {calendar} at {business}. We look forward to see you in just a moment! \\n\\n*{business}*\"}', 0),
('BookingCancelled', '{\"SendAsSMS\":false,\"LeftCharactor\":106,\"sms_template\":\"Your booking was cancelled on {calendar} at {business}\",\"SendAsEmail\":false,\"email_template\":\"Hi {name}!\\n\\nYour booking at {business} on {calendar} has been cancelled. \\n\\nYou can find another time on our [booking page](https://app.waitwhile.com/book/{waitlistId}).\\n\\nThank you!\\n\\n*{business}*\"}', 0),
('BookingCompleted', '{\"SendAsSMS\":true,\"LeftCharactor\":89,\"sms_template\":\"Thank you for visiting {business}, {name}! We hope to see you back soon\",\"SendAsEmail\":true,\"email_template\":\"Thank you for visiting {business}, {name}!\\n\\nWe hope to see you back soon.\"}', 0),
('BookingConfirmation', '{\"SendAsSMS\":false,\"LeftCharactor\":66,\"sms_template\":\"Hi {name}! You\'re scheduled for an booking {date} at {hour} at {business}. Manage it on {link}\",\"SendAsEmail\":false,\"email_template\":\"Hi {name}!\\n\\nYou\'ve been scheduled for an booking {calendar} at {business}. \\n\\nManage your booking on {link}. \\n\\nWe look forward to serve you soon!\\n\\n*{business}*\"}', 0),
('BookingNoShow', '{\"SendAsSMS\":false,\"LeftCharactor\":105,\"sms_template\":\"Your place in line at {business} was marked as no-show.\",\"SendAsEmail\":false,\"email_template\":\"Hi {name}! \\n\\nYour place in line at {business} was marked as no-show. We hope to see you back soon!\"}', 0),
('BookingReminder', '{\"SendAsSMS\":false,\"LeftCharactor\":85,\"sms_template\":\"Heads-up that your booking is {calendar} at {business}. Manage it on {link}\",\"SendAsEmail\":false,\"email_template\":\"Hi {name}!\\n\\nHeads-up that you have an booking coming up {calendar} at {business}. \\n\\nManage your booking on {link}.\\n\\nWe look forward to serve you soon!\\n\\n*{business}*\",\"remaining_time\":\"5 min\"}', 0),
('BookingServed', '{\"SendAsSMS\":false,\"LeftCharactor\":117,\"sms_template\":\"Finally! You have been served at {business}\",\"SendAsEmail\":false,\"email_template\":\"Hi {name}!\\n\\nWe\'re happy to now serve you at {business}.\"}', 0),
('Cancelled', '{\"SendAsSMS\":false,\"LeftCharactor\":70,\"sms_template\":\"You\'ve been cancelled from the waitlist for {business}. Thanks for letting us know, {name}\",\"SendAsEmail\":false,\"email_template\":\"Hi {name}!\\n\\nYou\'ve been cancelled from the waitlist for {business}.\\n\\nThank you!\\n\\n*{business}*\"}', 0),
('Completed', '{\"SendAsSMS\":false,\"LeftCharactor\":89,\"sms_template\":\"Thank you for visiting {business}, {name}! We hope to see you back soon\",\"SendAsEmail\":false,\"email_template\":\"Thank you for visiting {business}, {name}!\\n\\nWe hope to see you back soon.\"}', 0),
('Confirmation', '{\"SendAsSMS\":false,\"LeftCharactor\":36,\"sms_template\":\"Hi {name}! You\'re waitlisted to {business} as #{order} in line. See live wait at {link} Reply \'cancel\' if you can\'t make it.\",\"SendAsEmail\":false,\"subject\":\"\",\"email_template\":\"Hi {name}!\\n\\nYou\'ve been waitlisted to {business} as #{order} in line. [View the waitlist]({link}) and remove yourself if you cannot make it.\\n\\nWe look forward to serve you soon!\\n\\n*{business}*\"}', 0),
('NextInLine', '{\"SendAsSMS\":false,\"LeftCharactor\":43,\"sms_template\":\"Heads up! It\'s soon your turn at {business} so start heading back. If you can\'t make it, go to {link} or reply \'cance\",\"SendAsEmail\":false,\"email_template\":\"Hi {name}!\\n\\nIt\'s soon your turn at {business} so start heading back. If you cannot make it, please [cancel yourself]({link}).\\n\\nWe look forward to serve you soon!\\n\\n*{business}*\",\"order_line\":\"1th in line\",\"order_relation\":\"everyone in line\"}', 0),
('NoShow', '{\"SendAsSMS\":false,\"LeftCharactor\":105,\"sms_template\":\"Your place in line at {business} was marked as no-show.\",\"SendAsEmail\":false,\"email_template\":\"Hi {name}! \\n\\nYour place in line at {business} was marked as no-show. We hope to see you back soon!\"}', 0),
('Served', '{\"SendAsSMS\":false,\"LeftCharactor\":117,\"sms_template\":\"Finally! You have been served at {business}\",\"SendAsEmail\":false,\"email_template\":\"Hi {name}!\\n\\nWe\'re happy to now serve you at {business}.\"}', 0);

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `id` bigint(20) NOT NULL,
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
  `serve_time` date DEFAULT NULL,
  `done_time` date DEFAULT NULL,
  `is_remind` tinyint(1) NOT NULL,
  `service_id` varchar(1000) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`id`, `user_id`, `customer_id`, `title`, `resource`, `note`, `startDate`, `endDate`, `appointment_key`, `appointment_type`, `appointment_time`, `serve_time`, `done_time`, `is_remind`, `service_id`) VALUES
(116, 51, 212, 'test', 'ISWB7OrxXn', 'dfsfd', '2021-02-24 18:30:00', '2021-02-24 19:00:00', 'D2Ptcj29', 1, NULL, NULL, NULL, 0, ''),
(115, 1, 211, 'error', 'ISWB7OrxXn', NULL, '2021-02-24 17:30:00', '2021-02-24 18:00:00', '6uYdLOju', 1, NULL, NULL, NULL, 0, ''),
(114, 1, 210, '?', 'ISWB7OrxXn', NULL, '2021-02-25 17:30:00', '2021-02-25 19:00:00', 'PHCccSpg', 1, NULL, NULL, NULL, 0, ''),
(113, 1, 208, 'this is my plan', 'ISWB7OrxXn', NULL, '2021-02-24 18:00:00', '2021-02-24 18:30:00', 'uuvjfdFE', 1, NULL, NULL, NULL, 0, ''),
(112, 1, 209, 'this', 'bMYsoX4e3M', NULL, '2021-02-24 20:00:00', '2021-02-24 20:30:00', 'bxXdbAJl', 1, NULL, NULL, NULL, 0, ''),
(111, 1, 208, 'test', 'ISWB7OrxXn', 'test', '2021-02-24 19:00:00', '2021-02-24 19:30:00', '431S0c5o', 1, NULL, NULL, NULL, 0, ''),
(110, 1, 203, 'tset2', 'ISWB7OrxXn', 'sfsf', '2021-02-25 18:30:00', '2021-02-25 19:00:00', 'TUgHdjBO', 1, NULL, NULL, NULL, 0, ''),
(109, 1, 199, 'test', 'bMYsoX4e3M', NULL, '2021-02-23 18:30:00', '2021-02-23 19:00:00', 'YdnBybGh', 1, NULL, NULL, NULL, 0, ''),
(117, 1, 213, '[]', 'bMYsoX4e3M', NULL, '2021-02-26 17:30:00', '2021-02-26 18:00:00', 'bFTBJQHF', 1, NULL, NULL, NULL, 0, ''),
(118, 1, 214, 'test', 'bMYsoX4e3M', NULL, '2021-02-22 18:00:00', '2021-02-22 18:30:00', '5AJYCtkU', 1, NULL, NULL, NULL, 0, ''),
(119, 1, 215, 'title', 'bMYsoX4e3M', NULL, '2021-02-26 18:00:00', '2021-02-26 19:30:00', 'n57jusQo', 1, NULL, NULL, NULL, 0, ''),
(120, 1, 216, 'hi', 'ISWB7OrxXn', NULL, '2021-02-25 19:00:00', '2021-02-25 19:30:00', 'ZgdCS551', 1, NULL, NULL, NULL, 0, ''),
(121, 1, 217, 'origin', 'vgftEu4nLN', NULL, '2021-02-23 17:30:00', '2021-02-23 19:00:00', 'UEA34B1P', 1, NULL, NULL, NULL, 0, ''),
(122, 1, 217, 'origin', 'ISWB7OrxXn', NULL, '2021-02-23 19:00:00', '2021-02-23 19:30:00', 'HevKj0Iy', 1, NULL, NULL, NULL, 0, ''),
(127, 51, 197, 'last testing', '', 'last testing', '2021-12-09 03:00:00', '2021-12-09 07:30:00', 'WYRD88Wv', 1, '2021-12-08 08:24:32', NULL, NULL, 0, NULL),
(126, 51, 197, 'testing is test', '', NULL, '2021-12-07 05:00:00', '2021-12-07 07:30:00', 'fl4PTel1', 1, '2021-12-07 08:27:28', NULL, NULL, 0, NULL),
(125, 51, 197, 'test2', '', NULL, '2021-12-08 20:00:00', '2021-12-06 04:00:00', 'VSWBbgwt', 1, '2021-12-06 15:02:05', NULL, NULL, 0, NULL),
(128, 52, 100, 'test', '', 'test', '2021-12-21 01:00:00', '2021-12-21 01:30:00', '9Rs7aBrY', 1, '2021-12-23 08:56:31', NULL, NULL, 0, NULL),
(129, 52, 100, 'asdas', '', NULL, '2021-12-21 02:30:00', '2021-12-21 03:00:00', 'GBhYAolZ', 1, '2021-12-23 12:03:24', NULL, NULL, 0, NULL),
(130, 52, 100, 'test', '', 'test', '2021-12-29 03:30:00', '2021-12-29 07:30:00', '8tqb36Bg', 1, '2021-12-30 13:36:21', NULL, NULL, 0, NULL),
(150, 52, 292, 'da', '', 'd', '2022-01-30 01:00:00', '2022-01-30 01:30:00', 'dcxtA2Ye', 1, '2022-02-03 09:59:36', NULL, NULL, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `booking_settings`
--

CREATE TABLE `booking_settings` (
  `ID` int(11) NOT NULL,
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
  `PublicBookingUrl` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `booking_settings`
--

INSERT INTO `booking_settings` (`ID`, `user_id`, `minDuration`, `maxDuration`, `SpotsPerTimeSlot`, `DefaultView`, `EndHour`, `StartHour`, `WeekStartDay`, `HidePast`, `AllowCustomerCancelBooking`, `AllowCustomerRescheduleBooking`, `AllowStaffOverBookFullTimeSlot`, `MaxAdvanceKind`, `MaxAdvanceNumber`, `MaxBooking`, `MinBooking`, `MinNoticeKind`, `MinNoticeNumber`, `RejectDuplicate`, `RejectFlagged`, `openingGeneralHours`, `openingWaitListHours`, `openingBookingHours`, `CalendarData`, `PublicBookingUrl`) VALUES
(1, 0, '30', '30', 1, 'Weekly', '20', '6', 'Sunday', 0, 0, 0, 0, 'Minutes', 1, '1 slot', '1 slot', 'Minutes', 1, 0, 0, '0', '0', '0', '[]', ''),
(11, 47, '40', '45', 10, 'Daily', '18', '6', 'Sunday', 0, 0, 0, 0, 'Minutes', 1, '3 slot', '2 slot', 'Minutes', 1, 0, 0, '[{\"name\":\"Monday\",\"isWorking\":\"Working\",\"data\":[[\"9:00 am\",\"6:00 pm\",\"none\",\"none\"],[\"6:00 pm\",\"7:00 pm\",\"none\",\"none\"],[\"7:00 pm\",\"8:00 pm\",\"none\",\"none\"]]},{\"name\":\"Tuesday\",\"isWorking\":\"Working\",\"data\":[[\"9:00 am\",\"6:00 pm\",\"none\",\"none\"]]},{\"name\":\"Wednesday\",\"isWorking\":\"Working\",\"data\":[[\"9:00 am\",\"6:00 pm\",\"none\",\"none\"]]},{\"name\":\"Thursday\",\"isWorking\":\"Working\",\"data\":[[\"9:00 am\",\"6:00 pm\",\"none\",\"none\"]]},{\"name\":\"Friday\",\"isWorking\":\"Working\",\"data\":[[\"9:00 am\",\"6:00 pm\",\"none\",\"none\"]]},{\"name\":\"Saturday\",\"isWorking\":\"Working\",\"data\":[[\"9:00 am\",\"6:00 pm\",\"none\",\"none\"]]},{\"name\":\"Sunday\",\"isWorking\":\"Working\",\"data\":[[\"9:00 am\",\"6:00 pm\",\"none\",\"none\"]]}]', '0', '0', '[{\"Year\":2021,\"Month\":1,\"Date\":6,\"Data\":{\"GeneralHours\":{\"name\":\"Saturday\",\"isWorking\":\"Working\",\"data\":[[\"9:00 am\",\"8:00 PM\",\"none\",\"none\"]]},\"WaitListHours\":false,\"BookingHours\":false}},{\"Year\":2021,\"Month\":1,\"Date\":4,\"Data\":{\"GeneralHours\":{\"name\":\"Thursday\",\"isWorking\":\"Working\",\"data\":[[\"9:00 am\",\"3:00 PM\",\"none\",\"none\"]]},\"WaitListHours\":false,\"BookingHours\":false}},{\"Year\":2021,\"Month\":1,\"Date\":5,\"Data\":{\"GeneralHours\":{\"name\":\"Friday\",\"isWorking\":\"All Day\",\"data\":[]},\"WaitListHours\":false,\"BookingHours\":false}},{\"Year\":2021,\"Month\":1,\"Date\":3,\"Data\":{\"GeneralHours\":{\"name\":\"Wednesday\",\"isWorking\":\"Not Working\",\"data\":[]},\"WaitListHours\":false,\"BookingHours\":false}},{\"Year\":2021,\"Month\":1,\"Date\":12,\"Data\":{\"GeneralHours\":{\"name\":\"Friday\",\"isWorking\":\"Working\",\"data\":[[\"9:00 am\",\"6:00 pm\",\"none\",\"none\"],[\"6:00 pm\",\"7:00 pm\",\"none\",\"none\"],[\"7:00 pm\",\"8:00 pm\",\"none\",\"none\"]]},\"WaitListHours\":{\"name\":\"Friday\",\"isWorking\":\"Working\",\"data\":[[\"9:00 am\",\"6:00 pm\",\"none\",\"none\"],[\"6:00 pm\",\"7:00 pm\",\"none\",\"none\"],[\"7:00 pm\",\"8:00 pm\",\"none\",\"none\"]]},\"BookingHours\":false}}]', ''),
(12, 32, '10', '30', 1, 'Weekly', '18', '8', 'Sunday', 0, 0, 0, 0, 'Minutes', 1, '1 slot', '1 slot', 'Minutes', 1, 0, 0, '[{\"name\":\"Monday\",\"isWorking\":\"Working\",\"data\":[[\"9:00 am\",\"6:00 pm\",\"none\",\"none\"]]},{\"name\":\"Tuesday\",\"isWorking\":\"Working\",\"data\":[[\"9:00 am\",\"6:00 pm\",\"none\",\"none\"]]},{\"name\":\"Wednesday\",\"isWorking\":\"Working\",\"data\":[[\"9:00 am\",\"6:00 pm\",\"none\",\"none\"]]},{\"name\":\"Thursday\",\"isWorking\":\"Working\",\"data\":[[\"9:00 am\",\"6:00 pm\",\"none\",\"none\"]]},{\"name\":\"Friday\",\"isWorking\":\"Working\",\"data\":[[\"9:00 am\",\"6:00 pm\",\"none\",\"none\"]]},{\"name\":\"Saturday\",\"isWorking\":\"Working\",\"data\":[[\"9:00 am\",\"6:00 pm\",\"none\",\"none\"]]},{\"name\":\"Sunday\",\"isWorking\":\"Working\",\"data\":[[\"9:00 am\",\"6:00 pm\",\"none\",\"none\"]]}]', '0', '0', '[]', ''),
(13, 47, '30', '30', 1, 'Daily', '19', '6', 'Sunday', 0, 0, 0, 0, 'Minutes', 1, '1 slot', '1 slot', 'Minutes', 1, 0, 0, '0', '0', '0', '[]', ''),
(14, 47, '30', '30', 1, 'Weekly', '9', '6', 'Sunday', 0, 0, 0, 0, 'Minutes', 1, '1 slot', '1 slot', 'Minutes', 1, 0, 0, '0', '0', '0', '[]', ''),
(15, 47, '30', '30', 1, 'Weekly', '13', '6', 'Sunday', 0, 0, 0, 0, 'Minutes', 1, '1 slot', '1 slot', 'Minutes', 1, 0, 0, '0', '0', '0', '[]', ''),
(17, 47, '30', '30', 1, 'Weekly', '20', '6', 'Sunday', 0, 0, 0, 0, 'Minutes', 1, '1 slot', '1 slot', 'Minutes', 1, 0, 0, '0', '0', '0', '[]', ''),
(18, 47, '30', '30', 1, 'Weekly', '20', '6', 'Sunday', 0, 0, 0, 0, 'Minutes', 1, '1 slot', '1 slot', 'Minutes', 1, 0, 0, '0', '0', '0', '[]', ''),
(19, 1, '30', '30', 1, 'Weekly', '20', '6', 'Sunday', 0, 0, 0, 0, 'Minutes', 1, '1 slot', '1 slot', 'Minutes', 1, 0, 0, '0', '0', '0', '[]', 'stone'),
(20, 50, '30', '30', 1, 'Weekly', '20', '6', 'Sunday', 0, 0, 0, 0, 'Minutes', 1, '1 slot', '1 slot', 'Minutes', 1, 0, 0, '0', '0', '0', '[]', 'computer111'),
(21, 52, '30', '30', 1, 'Weekly', '20', '6', 'Today', 1, 1, 1, 1, 'Minutes', 1, '1 slot', '6 slot', 'Minutes', 1, 0, 1, '0', '0', '0', '[{\"Year\":2022,\"Month\":1,\"Date\":2,\"Data\":{\"GeneralHours\":{\"name\":\"Monday\",\"isWorking\":\"Working\",\"data\":[[\"9:00 am\",\"6:00 pm\",\"none\",\"none\"]]},\"WaitListHours\":false,\"BookingHours\":false}}]', 'uBawoQEszK9jzi3qzB0R'),
(22, 53, '30', '30', 1, 'Weekly', '20', '6', 'Sunday', 0, 0, 0, 0, 'Minutes', 1, '1 slot', '1 slot', 'Minutes', 1, 0, 0, '0', '0', '0', '[]', 'cbRgvl5mUqhSk0Qlw9BX'),
(23, 61, '30', '30', 1, 'Weekly', '20', '6', 'Sunday', 0, 0, 0, 0, 'Minutes', 1, '1 slot', '1 slot', 'Minutes', 1, 0, 0, '0', '0', '0', '[]', 'Jzt7WdV125ArTxrAbQKq');

-- --------------------------------------------------------

--
-- Table structure for table `business_infos`
--

CREATE TABLE `business_infos` (
  `ID` varchar(20) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `business_name` varchar(50) DEFAULT NULL,
  `business_logo` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `business_infos`
--

INSERT INTO `business_infos` (`ID`, `user_id`, `business_name`, `business_logo`) VALUES
('1', 0, 'Business', '0'),
('3', 32, 'manggo', '0'),
('bY0nC5CvPJKAKQX8xlKY', 50, 'Marketting Business', '0'),
('cbRgvl5mUqhSk0Qlw9BX', 53, 'admin avs', ''),
('EQ4g2qcys2lH8hWIBwHn', 1, 'Magasin Vidéotron Blainville', '0'),
('Jzt7WdV125ArTxrAbQKq', 61, 'admin admin', ''),
('sAavAS7FcNP3UG4QlA4g', 39, 'dol MAx', '0'),
('uBawoQEszK9jzi3qzB0R', 52, 'Take It :)', '');

-- --------------------------------------------------------

--
-- Table structure for table `business_memberships`
--

CREATE TABLE `business_memberships` (
  `id` int(11) NOT NULL,
  `businessID` varchar(1000) NOT NULL,
  `priceID` varchar(1000) NOT NULL,
  `startDate` date NOT NULL,
  `endDate` date NOT NULL,
  `state` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `business_memberships`
--

INSERT INTO `business_memberships` (`id`, `businessID`, `priceID`, `startDate`, `endDate`, `state`) VALUES
(1, 'uBawoQEszK9jzi3qzB0R', 'price_1J4gE7IbbGL77O6KEyTotFxS', '2021-12-22', '2022-01-22', 'active'),
(2, 'cbRgvl5mUqhSk0Qlw9BX', 'price_1J4gE7IbbGL77O6KEyTotFxS', '2021-12-28', '2022-01-28', 'active'),
(3, 'Jzt7WdV125ArTxrAbQKq', 'price_1J4gE7IbbGL77O6KEyTotFxS', '2022-02-19', '2022-03-19', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `client_fields`
--

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
  `is_pre_select` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `client_fields`
--

INSERT INTO `client_fields` (`ID`, `user_id`, `enable`, `name`, `label`, `type`, `placeholder`, `options`, `defaultValue`, `ordering`, `PORV`, `for`, `is_required`, `is_multiple`, `is_add_option`, `is_pre_select`) VALUES
('HMLwm4KGJ9', 1, '1', 'sss', 'ddd', 'Text Field', '', '[]', '', NULL, 'Public', 'Both bookings and waitlist', '0', '0', '0', '0');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `customer_group_id` varchar(100) DEFAULT NULL,
  `phone` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `user_id`, `name`, `email`, `customer_group_id`, `phone`, `description`, `created_at`, `updated_at`) VALUES
(294, 52, 'servedfdsfsfsdf', 'serving@email.com', 'serving', '11111111111', 'tt', '2022-02-03 09:32:18', '2022-02-03 09:57:46'),
(256, 52, 'asadd', 'sma123@gmail.com', '52', NULL, 'yy', '2022-01-01 08:03:02', '2022-02-03 09:58:06'),
(215, 1, 'test customerl', 'testc@email.com', NULL, NULL, '69', '2021-02-24 11:02:31', '2022-02-03 06:24:44'),
(216, 1, 'hi', 'hi@email.com', NULL, '1', NULL, '2021-02-24 11:42:50', '2021-02-26 05:27:30'),
(219, 1, 'dddd', 'dddddd@email.com', NULL, 'dfsf', NULL, '2021-02-26 14:03:36', '2021-02-26 14:03:36'),
(220, 1, 'test publicv', 'test1@email.com', NULL, NULL, NULL, '2021-02-26 14:06:40', '2021-02-26 14:06:40'),
(280, 52, 'hi', 'hi@email.com', NULL, '1', NULL, '2022-02-03 06:28:29', '2022-02-03 06:28:29'),
(207, 1, 'servedfdsfsfsdf', 'serving@email.com', 'serving', '11111111111', 't', '2021-02-24 08:27:07', '2022-02-03 07:51:03'),
(222, 1, 'dol', 'dol@email.com', NULL, 'dol', NULL, '2021-02-26 14:20:22', '2021-02-26 14:20:22'),
(223, 50, 'customer', '???@email.com', NULL, '226', NULL, '2021-02-26 14:23:46', '2021-02-26 14:32:01'),
(217, 1, 'origin', 'origin@email.com', NULL, '11111111111', NULL, '2021-02-24 12:43:11', '2021-02-26 05:27:28'),
(224, 50, 'manngo', 'manngo@email.com', NULL, '202 324 1234', NULL, '2021-02-26 16:20:08', '2021-02-26 16:20:08'),
(225, 50, 'mouse', 'mouse@email.com', NULL, NULL, NULL, '2021-02-26 16:20:25', '2021-02-26 16:20:25'),
(226, 50, 'computer', 'computer@email.com', '52', NULL, NULL, '2021-02-26 16:22:51', '2021-02-26 16:22:51'),
(227, 50, 'Max', 'max@email.com', NULL, NULL, NULL, '2021-02-26 16:30:48', '2021-02-26 16:30:48'),
(228, 50, 'dold', 'dold@email.com', NULL, '226123123123123', NULL, '2021-02-26 16:34:01', '2021-02-26 16:34:01'),
(292, 52, 'hhh', 'bolo@d.jj', NULL, '1555555555', 'gfh', '2022-02-03 08:38:09', '2022-02-03 09:59:48'),
(262, 52, 'aa', 's@d.kkk', '44', NULL, 'uu', '2022-01-25 09:20:27', '2022-02-03 09:18:14'),
(230, 51, 'test teste', 'test@ti2.vo', '54', '12432423', 'test2', '2021-12-07 10:10:48', '2021-12-09 10:18:22'),
(231, 51, 'test teste', 'tstt@test.vb', '3', '1453454', 'test', '2021-12-07 10:11:10', '2021-12-07 10:11:10'),
(260, 52, 'sd', 'd@d.jjj', '52', NULL, NULL, '2022-01-25 07:10:46', '2022-01-25 07:10:46'),
(264, 52, 'fghfgh', 'q@q.lll', '65', '15555555555', 'aaaaaaaaaaaaaaaaaaaaaaaaaafsdsdaaaaawwwwwwwwwwqqqqqqqqqqqqqqq', '2022-01-26 07:04:47', '2022-01-26 07:04:47'),
(236, 52, 'd', 'dd@email.com', '22', '1234234232', NULL, '2021-12-30 07:55:34', '2021-12-30 07:55:34'),
(291, 52, 'test customerl', 'testc@email.com', NULL, NULL, '69dd', '2022-02-03 07:44:38', '2022-02-03 07:44:38'),
(259, 52, 'aa', 's@d.jjj', '43', '1423423222', NULL, '2022-01-25 07:10:22', '2022-01-25 07:10:22'),
(241, 52, 'u', 'd@j.jjj', '6', NULL, 'uu', '2021-12-30 08:40:36', '2022-02-03 09:58:54'),
(246, 52, 'd', 'd@f.ggg', '52', NULL, NULL, '2021-12-30 10:24:06', '2021-12-30 10:24:06'),
(258, 52, 'ww', 'ddd@email.com', '54', NULL, NULL, '2022-01-01 09:34:47', '2022-01-01 09:34:58'),
(263, 52, 'qq', 'a@a.jjj', '54', '13433333333', 'gg', '2022-01-26 06:17:25', '2022-02-02 07:47:52'),
(254, 52, 'ww', 'nolo@g.lll', '54', NULL, NULL, '2022-01-01 07:10:28', '2022-01-01 07:12:10'),
(265, 52, 'f', 'ss@s.kkk', '54', NULL, NULL, '2022-01-27 06:40:18', '2022-01-27 06:40:18'),
(268, 52, 'errorss', 'error@email.com', NULL, '380191223214', NULL, '2022-02-01 08:43:13', '2022-02-01 08:43:13'),
(269, 52, 'jj', 'bolo@w.ddd', '54', '12343222666', 'hy', '2022-02-01 08:44:38', '2022-02-03 07:01:23'),
(270, 52, 'ert', 'asw@g.jjj', '52', '1435352332', NULL, '2022-02-01 08:55:13', '2022-02-01 08:55:13'),
(271, 52, 'e', 'e@g.jjj', '52', '1455643333', 'gfhgf', '2022-02-01 08:55:45', '2022-02-01 09:01:20'),
(272, 52, 'ert', 'r@K.LLL', '52', '14444444444', 'SDFF', '2022-02-01 09:02:07', '2022-02-01 09:02:07'),
(273, 52, 'wy', 'ali23@d.ggg', '52', '1444443222', 'wewe', '2022-02-01 09:05:06', '2022-02-01 09:05:42'),
(274, 52, 'tt', 'ali@l.sss', '54', '14543544', 'ttrre', '2022-02-01 09:06:31', '2022-02-03 06:58:49'),
(275, 52, 'w', 'd@l.hhh', '54', '1456433777', 'r g dfgh f d', '2022-02-01 09:11:30', '2022-02-01 11:36:39'),
(276, 52, 'asad', 'abc@a.kkk', NULL, '1567555544', NULL, '2022-02-01 12:56:14', '2022-02-01 12:56:14'),
(277, 52, 'aa', 'aw@d.rrr', NULL, '1333333333', 'awa', '2022-02-02 09:00:26', '2022-02-02 09:00:26'),
(278, 52, 'asad', 'w@gh.jkjj', NULL, '1333333322', 'sdf', '2022-02-02 13:56:40', '2022-02-02 13:56:40'),
(281, 52, 'test customerl', 'testc@email.com', NULL, NULL, '55', '2022-02-03 06:28:53', '2022-02-03 06:28:53'),
(282, 52, 'test customerl', 'testc@email.com', NULL, NULL, '64', '2022-02-03 06:33:09', '2022-02-03 06:33:09'),
(283, 52, 'hi', 'hi@email.com', NULL, '1', 'gggggg', '2022-02-03 06:34:04', '2022-02-03 06:34:04'),
(284, 52, 'test customerl', 'testc@email.com', NULL, NULL, '44', '2022-02-03 06:34:38', '2022-02-03 06:34:38'),
(285, 52, 'test customerl', 'testc@email.com', NULL, NULL, '69z', '2022-02-03 06:34:59', '2022-02-03 06:34:59'),
(286, 52, 'test customerl', 'testc@email.com', NULL, NULL, 'ee', '2022-02-03 06:35:06', '2022-02-03 06:35:06'),
(287, 52, 'hi', 'hi@email.com', NULL, '1', 'ff', '2022-02-03 06:35:12', '2022-02-03 06:35:12'),
(288, 52, 'servedfdsfsfsdf', 'serving@email.com', 'serving', '11111111111', 'cc', '2022-02-03 06:41:08', '2022-02-03 06:41:08'),
(289, 52, 'servedfdsfsfsdf', 'serving@email.com', 'serving', '11111111111', 'e', '2022-02-03 06:41:37', '2022-02-03 06:41:37'),
(290, 52, 'ty', 'e@r.kkk', NULL, NULL, 'hh', '2022-02-03 07:21:51', '2022-02-03 07:21:51'),
(293, 52, 'test customerl', 'testc@email.com', NULL, NULL, 'ff', '2022-02-03 09:05:28', '2022-02-03 09:05:28'),
(295, 52, 'servedfdsfsfsdf', 'serving@email.com', 'serving', '11111111111', 't', '2022-02-03 09:32:44', '2022-02-03 09:32:44'),
(296, 52, 'servedfdsfsfsdf', 'serving@email.com', 'serving', '11111111111', 'tl', '2022-02-03 09:57:29', '2022-02-03 09:57:29');

-- --------------------------------------------------------

--
-- Table structure for table `customer_meta`
--

CREATE TABLE `customer_meta` (
  `id` bigint(20) NOT NULL,
  `customerId` int(11) DEFAULT NULL,
  `meta_key` varchar(250) DEFAULT NULL,
  `meta_value` varchar(250) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customer_meta`
--

INSERT INTO `customer_meta` (`id`, `customerId`, `meta_key`, `meta_value`) VALUES
(403, 191, 'test3', '11'),
(402, 191, 'tests', '[\"2\",\"4\"]'),
(412, 207, 'sss', 'very bad man??I lost my money for nothing');

-- --------------------------------------------------------

--
-- Table structure for table `description_resources`
--

CREATE TABLE `description_resources` (
  `id` int(11) NOT NULL,
  `description_id` int(11) NOT NULL,
  `resource_id` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `description_resources`
--

INSERT INTO `description_resources` (`id`, `description_id`, `resource_id`) VALUES
(1, 112, 'vtua7d4dEa'),
(3, 121, 'Tx2vjvVOt7'),
(4, 122, 'Tx2vjvVOt7'),
(5, 123, 'Tx2vjvVOt7'),
(6, 124, 'Tx2vjvVOt7'),
(7, 125, 'Tx2vjvVOt7'),
(8, 126, 'Tx2vjvVOt7'),
(9, 127, '9PKUI2ZxYn'),
(10, 128, '9PKUI2ZxYn'),
(11, 129, 'i3zitWyMqC'),
(12, 130, 'wIyVK0soD1'),
(13, 130, 'OgnBl1CebT'),
(14, 131, 'OgnBl1CebT'),
(17, 132, 'OgnBl1CebT'),
(18, 133, 'wIyVK0soD1'),
(19, 134, 'wIyVK0soD1');

-- --------------------------------------------------------

--
-- Table structure for table `localizations`
--

CREATE TABLE `localizations` (
  `ID` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `timezone` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `localizations`
--

INSERT INTO `localizations` (`ID`, `user_id`, `timezone`) VALUES
(1, 0, 'utc'),
(2, 1, 'America/Argentina/Tucuman'),
(3, 32, 'America/New_York'),
(4, 52, 'Pacific/Port_Moresby');

-- --------------------------------------------------------

--
-- Table structure for table `managers`
--

CREATE TABLE `managers` (
  `ID` varchar(10) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `is_sign_up` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `managers`
--

INSERT INTO `managers` (`ID`, `user_id`, `name`, `email`, `is_sign_up`) VALUES
('36xLjTh0M1', 52, 'Tahir', 'www@d.kkk', ''),
('jTyxQfpmmp', 1, 'manager', 'manager@email.com', ''),
('u9Msn2ZDXb', 32, 'manager1', 'manager1@email.com', 'true'),
('ysoQwIk67H', 1, 'testChat', 'testchat@hotmail.com', 'true');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `sender_id` int(11) DEFAULT NULL,
  `receiver_id` int(11) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `msg_type` varchar(20) DEFAULT NULL,
  `is_read` tinyint(4) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`id`, `sender_id`, `receiver_id`, `message`, `msg_type`, `is_read`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 52, 263, 'hi', NULL, 1, '2021-02-25 14:48:04', NULL, NULL),
(2, 52, 254, 'hi', NULL, 1, '2021-02-25 14:48:14', NULL, NULL),
(3, 52, 255, 'hi', NULL, 1, '2021-02-25 14:48:24', NULL, NULL),
(4, 1, 265, 'hi', NULL, 1, '2021-02-25 14:48:55', NULL, NULL),
(5, 1, 47, 'tet', NULL, 1, '2021-02-25 14:49:27', NULL, NULL),
(6, 52, 1, 'sdfsdf', NULL, 1, '2021-02-25 14:50:03', NULL, NULL),
(7, 47, 1, 'sdfdsf', NULL, 1, '2021-02-25 14:50:11', NULL, NULL),
(8, 47, 1, 'sdfsdf', NULL, 1, '2021-02-25 17:43:20', NULL, NULL),
(9, 47, 1, 'dsfsdf', NULL, 1, '2021-02-25 17:43:40', NULL, NULL),
(10, 47, 1, 'sdfsdfsdfd', NULL, 1, '2021-02-25 17:43:42', NULL, NULL),
(11, 47, 1, 'sdfsdf', NULL, 1, '2021-02-25 17:44:44', NULL, NULL),
(12, 47, 1, 'sdfsdf', NULL, 1, '2021-02-25 17:44:45', NULL, NULL),
(13, 47, 1, 'sfsdfsd', NULL, 1, '2021-02-25 17:44:48', NULL, NULL),
(14, 47, 1, 'sdfsdf', NULL, 1, '2021-02-25 17:45:10', NULL, NULL),
(15, 47, 1, 'sdfsdf', NULL, 1, '2021-02-25 17:45:11', NULL, NULL),
(16, 47, 1, 'sdfsd', NULL, 1, '2021-02-25 17:45:19', NULL, NULL),
(17, 47, 1, 'sdfsdf', NULL, 1, '2021-02-25 17:45:21', NULL, NULL),
(18, 47, 1, 'sdfd', NULL, 1, '2021-02-25 17:46:12', NULL, NULL),
(19, 1, 47, 'sdfsdf', NULL, 1, '2021-02-25 17:46:17', NULL, NULL),
(20, 1, 47, 'sdfds', NULL, 1, '2021-02-25 17:46:35', NULL, NULL),
(21, 1, 47, 'dfsdf', NULL, 1, '2021-02-25 17:46:40', NULL, NULL),
(22, 1, 47, '22', NULL, 1, '2021-02-25 17:46:43', NULL, NULL),
(23, 47, 1, '111', NULL, 1, '2021-02-25 17:46:48', NULL, NULL),
(24, 47, 1, 'llllllllllllll', NULL, 1, '2021-02-25 18:11:17', NULL, NULL),
(25, 47, 1, 'hi', NULL, 1, '2021-02-25 19:21:29', NULL, NULL),
(26, 47, 1, 'when could you possibly contact me?', NULL, 1, '2021-02-25 19:21:42', NULL, NULL),
(27, 47, 1, 'sdfdsfs', NULL, 1, '2021-02-25 19:22:11', NULL, NULL),
(28, 47, 1, 'sdfsd', NULL, 1, '2021-02-25 19:22:12', NULL, NULL),
(29, 47, 1, 'fsdfsdf', NULL, 1, '2021-02-25 19:22:24', NULL, NULL),
(30, 47, 1, 'sdfsd', NULL, 1, '2021-02-25 19:22:25', NULL, NULL),
(31, 47, 1, 'sdf', NULL, 1, '2021-02-25 19:22:25', NULL, NULL),
(32, 47, 1, 'sdfs', NULL, 1, '2021-02-25 19:22:34', NULL, NULL),
(33, 47, 1, 'sdfsd', NULL, 1, '2021-02-25 19:22:35', NULL, NULL),
(34, 1, 47, '111', NULL, 1, '2021-02-25 19:36:44', NULL, NULL),
(35, 47, 1, '12312', NULL, 1, '2021-02-25 19:53:07', NULL, NULL),
(36, 1, 47, 'test', NULL, 1, '2021-02-25 19:58:54', NULL, NULL),
(37, 47, 1, 'hi', NULL, 1, '2021-02-25 19:59:09', NULL, NULL),
(38, 1, 47, 'fsdf', NULL, 1, '2021-02-25 19:59:29', NULL, NULL),
(39, 1, 47, 'sdfsdf', NULL, 1, '2021-02-25 19:59:33', NULL, NULL),
(40, 47, 1, 'die', NULL, 1, '2021-02-25 20:04:49', NULL, NULL),
(41, 1, 47, 'I will kill you]', NULL, 1, '2021-02-25 20:05:02', NULL, NULL),
(42, 1, 47, 'dsfsdf', NULL, 1, '2021-02-25 20:07:18', NULL, NULL),
(43, 1, 47, 'sdfsd', NULL, 1, '2021-02-25 20:07:18', NULL, NULL),
(44, 1, 47, 'dsf', NULL, 1, '2021-02-25 20:07:19', NULL, NULL),
(45, 47, 1, 'dfasd', NULL, 1, '2021-02-25 20:07:27', NULL, NULL),
(46, 47, 1, 'asd', NULL, 1, '2021-02-25 20:07:28', NULL, NULL),
(47, 47, 1, 'hi', NULL, 1, '2021-02-25 21:31:28', NULL, NULL),
(48, 1, 47, 'sdfsdf', NULL, 1, '2021-02-25 21:32:46', NULL, NULL),
(49, 1, 47, 'sdfsdf', NULL, 1, '2021-02-25 21:33:23', NULL, NULL),
(50, 1, 47, 'qqq', NULL, 1, '2021-02-25 21:33:27', NULL, NULL),
(51, 1, 47, 'www', NULL, 1, '2021-02-25 21:33:29', NULL, NULL),
(52, 1, 47, 'ddd', NULL, 1, '2021-02-25 21:33:31', NULL, NULL),
(53, 47, 1, 'sdfsd', NULL, 1, '2021-02-25 21:33:37', NULL, NULL),
(54, 1, 47, 'sdfsd', NULL, 1, '2021-02-25 21:33:41', NULL, NULL),
(55, 1, 47, 'dfsd', NULL, 1, '2021-02-25 21:33:46', NULL, NULL),
(56, 47, 1, 'test', NULL, 1, '2021-02-25 21:33:54', NULL, NULL),
(57, 47, 1, 'dfs', NULL, 1, '2021-02-25 21:33:55', NULL, NULL),
(58, 47, 1, 'fsdf', NULL, 1, '2021-02-25 21:33:56', NULL, NULL),
(59, 47, 1, 'fsdf', NULL, 1, '2021-02-25 21:34:08', NULL, NULL),
(60, 47, 1, 'dfsdf', NULL, 1, '2021-02-25 21:34:14', NULL, NULL),
(61, 47, 1, 'fsdf', NULL, 1, '2021-02-25 21:34:17', NULL, NULL),
(62, 1, 47, 'Hello', NULL, 1, '2021-02-25 21:34:59', NULL, NULL),
(63, 1, 47, 'test', NULL, 1, '2021-02-26 04:49:11', NULL, NULL),
(64, 1, 47, 'hiw', NULL, 1, '2021-02-26 04:49:17', NULL, NULL),
(65, 1, 47, 'hi', NULL, 1, '2021-02-26 04:49:22', NULL, NULL),
(66, 1, 47, 'how are you?', NULL, 1, '2021-02-26 04:49:31', NULL, NULL),
(67, 1, 47, 'what are you doing?', NULL, 1, '2021-02-26 04:49:42', NULL, NULL),
(68, 1, 47, 'I want discuss about the job.', NULL, 1, '2021-02-26 04:50:02', NULL, NULL),
(69, 47, 1, 'yeah ', NULL, 1, '2021-02-26 04:50:09', NULL, NULL),
(70, 47, 1, 'I\'m herer', NULL, 1, '2021-02-26 04:50:13', NULL, NULL),
(71, 1, 47, '\'???', NULL, 1, '2021-02-26 04:50:35', NULL, NULL),
(72, 47, 1, '?', NULL, 1, '2021-02-26 04:50:49', NULL, NULL),
(73, 47, 1, '?', NULL, 1, '2021-02-26 04:50:53', NULL, NULL),
(74, 47, 1, '?', NULL, 1, '2021-02-26 04:50:55', NULL, NULL),
(75, 47, 1, '?', NULL, 1, '2021-02-26 04:50:56', NULL, NULL),
(76, 47, 1, '?', NULL, 1, '2021-02-26 04:50:57', NULL, NULL),
(77, 47, 1, '?', NULL, 1, '2021-02-26 04:51:04', NULL, NULL),
(78, 47, 1, '?', NULL, 1, '2021-02-26 04:51:05', NULL, NULL),
(79, 47, 1, '?', NULL, 1, '2021-02-26 04:51:06', NULL, NULL),
(80, 47, 1, '?', NULL, 1, '2021-02-26 04:51:07', NULL, NULL),
(81, 47, 1, '?', NULL, 1, '2021-02-26 04:51:08', NULL, NULL),
(82, 47, 1, 'ssssss', NULL, 1, '2021-02-26 05:24:53', NULL, NULL),
(83, 47, 1, 's', NULL, 1, '2021-02-26 05:24:54', NULL, NULL),
(84, 1, 47, 'I will die', NULL, 0, '2021-02-26 05:47:43', NULL, NULL),
(85, 52, 52, 'tyu', NULL, 1, '2021-12-23 07:28:24', NULL, NULL),
(86, 52, 52, 'uu', NULL, 1, '2021-12-23 07:28:32', NULL, NULL),
(87, 52, 52, 'tt', NULL, 1, '2021-12-23 07:28:35', NULL, NULL),
(88, 52, 52, 'sdf', NULL, 1, '2021-12-23 07:30:35', NULL, NULL),
(89, 52, 52, 'dsf', NULL, 1, '2021-12-23 07:30:37', NULL, NULL),
(90, 52, 52, '', NULL, 1, '2021-12-23 07:30:38', NULL, NULL),
(91, 52, 52, 'asd', NULL, 1, '2021-12-23 07:45:55', NULL, NULL),
(92, 52, 52, 'test', NULL, 0, '2021-12-23 08:27:35', NULL, NULL),
(93, 52, NULL, 'test', NULL, 0, '2021-12-23 08:30:45', NULL, NULL),
(94, 52, 213, 'asdasd', NULL, 1, '2021-12-23 08:52:06', NULL, NULL),
(95, 52, 212, 'wer', NULL, 1, '2021-12-23 08:53:06', NULL, NULL),
(96, 52, 100, 'rr', NULL, 1, '2021-12-23 08:53:10', NULL, NULL),
(97, 52, 100, 'sdfsd', NULL, 1, '2021-12-23 08:54:37', NULL, NULL),
(98, 52, 213, 'eetuj', NULL, 1, '2021-12-23 08:54:41', NULL, NULL),
(99, 52, 100, 'tyuty', NULL, 1, '2021-12-23 08:54:45', NULL, NULL),
(100, 52, 100, 'tyhtyh', NULL, 1, '2021-12-23 08:54:47', NULL, NULL),
(101, NULL, 100, 'u', NULL, 0, '2021-12-28 12:01:21', NULL, NULL),
(102, NULL, 100, 'tt', NULL, 0, '2021-12-28 12:01:28', NULL, NULL),
(103, NULL, 100, 'tyutyu', NULL, 0, '2021-12-28 12:01:32', NULL, NULL),
(104, NULL, 100, 'ry', NULL, 0, '2021-12-28 12:01:38', NULL, NULL),
(105, 52, 213, 'sd', NULL, 1, '2021-12-28 12:04:29', NULL, NULL),
(106, 52, 100, 'ss', NULL, 1, '2021-12-28 12:05:35', NULL, NULL),
(107, 52, 212, 'aa', NULL, 1, '2021-12-28 12:05:39', NULL, NULL),
(108, NULL, 100, 'aa', NULL, 0, '2021-12-28 12:08:58', NULL, NULL),
(109, NULL, 212, 'ss', NULL, 0, '2021-12-28 12:09:03', NULL, NULL),
(110, NULL, 213, 'test', NULL, 0, '2021-12-28 12:11:28', NULL, NULL),
(111, NULL, 100, 'test', NULL, 0, '2021-12-28 12:16:14', NULL, NULL),
(112, NULL, 212, 'test', NULL, 0, '2021-12-28 12:16:21', NULL, NULL),
(113, NULL, 213, 'test eeee', NULL, 0, '2021-12-28 12:16:48', NULL, NULL),
(114, NULL, 100, 'tetsdt', NULL, 0, '2021-12-28 12:19:24', NULL, NULL),
(115, NULL, 100, 'asd', NULL, 0, '2021-12-28 12:29:50', NULL, NULL),
(116, NULL, 100, 'dd', NULL, 0, '2021-12-28 12:29:52', NULL, NULL),
(117, NULL, 212, 'ww', NULL, 0, '2021-12-28 12:29:55', NULL, NULL),
(118, NULL, 212, 'ee', NULL, 0, '2021-12-28 12:29:57', NULL, NULL),
(119, NULL, 213, 'ff', NULL, 0, '2021-12-28 12:30:00', NULL, NULL),
(120, NULL, 213, 'rr', NULL, 0, '2021-12-28 12:30:01', NULL, NULL),
(121, NULL, 100, 'asdas', NULL, 0, '2021-12-28 12:44:03', NULL, NULL),
(122, NULL, 213, 'asdas', NULL, 0, '2021-12-28 12:44:06', NULL, NULL),
(123, NULL, 242, 'kk', NULL, 0, '2021-12-31 07:46:07', NULL, NULL),
(124, NULL, 257, '6', NULL, 0, '2022-01-01 13:48:16', NULL, NULL),
(125, NULL, 261, 'fsd', NULL, 0, '2022-01-25 11:02:52', NULL, NULL),
(126, NULL, 261, 'fdsf', NULL, 0, '2022-02-01 08:41:50', NULL, NULL),
(127, NULL, 263, 'sdfsfdd', NULL, 0, '2022-02-01 09:41:03', NULL, NULL),
(128, NULL, 263, 'sdasd', NULL, 0, '2022-02-01 09:52:18', NULL, NULL),
(129, NULL, 258, 'sdfsdf', NULL, 0, '2022-02-01 10:28:57', NULL, NULL),
(130, NULL, 263, 'ads', NULL, 0, '2022-02-01 10:35:23', NULL, NULL),
(131, NULL, 263, 'ewe', NULL, 0, '2022-02-01 10:35:25', NULL, NULL),
(132, NULL, 274, 'asdsd', NULL, 0, '2022-02-01 10:36:20', NULL, NULL),
(133, NULL, 274, 'dsd', NULL, 0, '2022-02-01 10:36:22', NULL, NULL),
(134, NULL, 258, 'sa', NULL, 0, '2022-02-01 10:36:36', NULL, NULL),
(135, NULL, 261, 'dsdw', NULL, 0, '2022-02-01 10:36:47', NULL, NULL),
(136, NULL, 265, 'ff', NULL, 0, '2022-02-01 10:41:02', NULL, NULL),
(137, NULL, 263, 'sdsad', NULL, 0, '2022-02-01 10:47:11', NULL, NULL),
(138, NULL, 263, 'ddd', NULL, 0, '2022-02-01 10:47:14', NULL, NULL),
(139, NULL, 273, 'gg', NULL, 0, '2022-02-01 10:47:51', NULL, NULL),
(140, NULL, 263, 'gg', NULL, 0, '2022-02-01 10:48:09', NULL, NULL),
(141, NULL, 263, 'test', NULL, 0, '2022-02-01 11:01:27', NULL, NULL),
(142, NULL, 263, 'test', NULL, 0, '2022-02-01 11:03:46', NULL, NULL),
(143, 52, 273, 'test', NULL, 1, '2022-02-01 11:04:34', NULL, NULL),
(144, 52, 263, 'testchat', NULL, 1, '2022-02-01 11:05:23', NULL, NULL),
(145, NULL, 276, 'asd', NULL, 0, '2022-02-02 07:53:11', NULL, NULL),
(146, NULL, 276, 'aa', NULL, 0, '2022-02-02 07:53:14', NULL, NULL),
(147, NULL, 264, 'aaaw', NULL, 0, '2022-02-02 07:54:11', NULL, NULL),
(148, NULL, 265, 'fsdfsd', NULL, 0, '2022-02-02 07:57:07', NULL, NULL),
(149, NULL, 276, 'dd', NULL, 0, '2022-02-02 08:23:56', NULL, NULL),
(150, NULL, 276, 'ss', NULL, 0, '2022-02-02 08:26:00', NULL, NULL),
(151, NULL, 276, 'fff', NULL, 0, '2022-02-02 08:29:29', NULL, NULL),
(152, NULL, 263, 'mmh', NULL, 0, '2022-02-02 08:32:49', NULL, NULL),
(153, NULL, 276, 'uu', NULL, 0, '2022-02-02 08:34:29', NULL, NULL),
(154, NULL, 276, 'yy', NULL, 0, '2022-02-02 08:36:44', NULL, NULL),
(155, 52, 276, 'uu', NULL, 1, '2022-02-02 08:37:55', NULL, NULL),
(156, 52, 274, 'gg', NULL, 1, '2022-02-02 08:38:10', NULL, NULL),
(157, 52, 273, 'test', NULL, 1, '2022-02-02 13:36:42', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `message_histories`
--

CREATE TABLE `message_histories` (
  `ID` int(10) NOT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `business_id` varchar(20) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `send_at` datetime DEFAULT NULL,
  `is_success` tinyint(4) DEFAULT NULL,
  `sending_type` varchar(5) DEFAULT NULL,
  `message_type` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `message_histories`
--

INSERT INTO `message_histories` (`ID`, `customer_id`, `business_id`, `message`, `send_at`, `is_success`, `sending_type`, `message_type`) VALUES
(1, 211, '1', 'Hi errors! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 04:51:25', 0, 'SMS', 'customerSendLink'),
(2, 207, '1', 'Hi servedfdsfsfsdf! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 04:51:27', 0, 'SMS', 'customerSendLink'),
(3, 208, '1', 'Hi this is my plan! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 04:51:28', 1, 'SMS', 'customerSendLink'),
(4, 210, '1', 'Hi what happened?! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 04:51:29', 0, 'SMS', 'customerSendLink'),
(5, 211, '1', 'Hi errors! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 04:51:16', 0, 'Email', 'customerSendLink'),
(6, 210, '1', 'Hi what happened?! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 04:51:16', 0, 'Email', 'customerSendLink'),
(7, 180, '1', 'Hi 1! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 04:51:19', 0, 'Email', 'customerSendLink'),
(8, 208, '1', 'Hi this is my plan! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 04:51:20', 0, 'Email', 'customerSendLink'),
(9, 207, '1', 'Hi servedfdsfsfsdf! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 04:51:24', 0, 'Email', 'customerSendLink'),
(10, 207, '1', 'Hi servedfdsfsfsdf! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 04:59:25', 0, 'SMS', 'customerSendLink'),
(11, 210, '1', 'Hi what happened?! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 04:59:28', 0, 'SMS', 'customerSendLink'),
(12, 208, '1', 'Hi this is my plan! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 04:59:29', 1, 'SMS', 'customerSendLink'),
(13, 211, '1', 'Hi errors! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 04:59:32', 0, 'SMS', 'customerSendLink'),
(14, 208, '1', 'Hi this is my plan! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 04:59:33', 0, 'SMS', 'customerSendLink'),
(15, 210, '1', 'Hi what happened?! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 04:59:34', 0, 'SMS', 'customerSendLink'),
(16, 207, '1', 'Hi servedfdsfsfsdf! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 04:59:35', 0, 'SMS', 'customerSendLink'),
(17, 211, '1', 'Hi errors! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 04:59:22', 0, 'Email', 'customerSendLink'),
(18, 208, '1', 'Hi this is my plan! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 04:59:23', 1, 'Email', 'customerSendLink'),
(19, 210, '1', 'Hi what happened?! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 04:59:23', 0, 'Email', 'customerSendLink'),
(20, 180, '1', 'Hi 1! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 04:59:24', 0, 'Email', 'customerSendLink'),
(21, 207, '1', 'Hi servedfdsfsfsdf! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 04:59:24', 0, 'Email', 'customerSendLink'),
(22, 218, '1', 'Hi jcodewriter! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 05:23:11', 0, 'Email', 'customerSendLink'),
(23, 211, '1', 'Hi errors! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 05:27:59', 0, 'SMS', 'customerSendLink'),
(24, 210, '1', 'Hi what happened?! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 05:28:02', 0, 'SMS', 'customerSendLink'),
(25, 208, '1', 'Hi this is my plan! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 05:28:04', 1, 'SMS', 'customerSendLink'),
(26, 211, '1', 'Hi errors! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 05:28:03', 0, 'SMS', 'customerSendLink'),
(27, 207, '1', 'Hi servedfdsfsfsdf! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 05:28:04', 0, 'SMS', 'customerSendLink'),
(28, 210, '1', 'Hi what happened?! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 05:28:05', 0, 'SMS', 'customerSendLink'),
(29, 211, '1', 'Hi errors! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 05:28:06', 0, 'SMS', 'customerSendLink'),
(30, 208, '1', 'Hi this is my plan! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 05:28:07', 0, 'SMS', 'customerSendLink'),
(31, 207, '1', 'Hi servedfdsfsfsdf! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 05:28:07', 0, 'SMS', 'customerSendLink'),
(32, 211, '1', 'Hi errors! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 05:28:11', 0, 'SMS', 'customerSendLink'),
(33, 208, '1', 'Hi this is my plan! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 05:28:11', 1, 'SMS', 'customerSendLink'),
(34, 210, '1', 'Hi what happened?! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 05:28:12', 0, 'SMS', 'customerSendLink'),
(35, 207, '1', 'Hi servedfdsfsfsdf! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 05:28:13', 0, 'SMS', 'customerSendLink'),
(36, 211, '1', 'Hi errors! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 05:28:13', 0, 'SMS', 'customerSendLink'),
(37, 208, '1', 'Hi this is my plan! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 05:28:14', 0, 'SMS', 'customerSendLink'),
(38, 210, '1', 'Hi what happened?! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 05:28:15', 0, 'SMS', 'customerSendLink'),
(39, 211, '1', 'Hi errors! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 05:28:16', 0, 'SMS', 'customerSendLink'),
(40, 207, '1', 'Hi servedfdsfsfsdf! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 05:28:15', 0, 'SMS', 'customerSendLink'),
(41, 208, '1', 'Hi this is my plan! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 05:28:16', 0, 'SMS', 'customerSendLink'),
(42, 210, '1', 'Hi what happened?! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 05:28:17', 0, 'SMS', 'customerSendLink'),
(43, 207, '1', 'Hi servedfdsfsfsdf! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 05:28:18', 0, 'SMS', 'customerSendLink'),
(44, 211, '1', 'Hi errors! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 05:28:19', 0, 'SMS', 'customerSendLink'),
(45, 208, '1', 'Hi this is my plan! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 05:28:19', 1, 'SMS', 'customerSendLink'),
(46, 211, '1', 'Hi errors! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 06:02:53', 0, 'SMS', 'customerSendLink'),
(47, 208, '1', 'Hi this is my plan! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/customers', '2021-02-26 06:02:53', 0, 'SMS', 'customerSendLink'),
(48, 211, '1', 'Hi errors! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/', '2021-02-26 06:20:55', 0, 'SMS', 'customerSendLink'),
(49, 211, '1', 'Hi errors! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/', '2021-02-26 06:21:02', 0, 'SMS', 'customerSendLink'),
(50, 207, '1', 'Hi servedfdsfsfsdf! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/', '2021-02-26 06:22:29', 0, 'SMS', 'customerSendLink'),
(51, 211, '1', 'Hi errors! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/', '2021-02-26 06:23:52', 0, 'SMS', 'customerSendLink'),
(52, 211, '1', 'Hi errors! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/', '2021-02-26 06:24:36', 0, 'SMS', 'customerSendLink'),
(53, 211, '1', 'Hi errors! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/', '2021-02-26 06:25:01', 0, 'SMS', 'customerSendLink'),
(54, 211, '1', 'Hi errors! You were added on Business. For join to the waitlist, Please follow http://avamgt.com/stone', '2021-02-26 06:26:39', 0, 'SMS', 'customerSendLink'),
(55, 223, 'bY0nC5CvPJKAKQX8xlKY', 'Hi customer! You were added on Marketting Business. For join to the waitlist, Please follow http://avamgt.com/test', '2021-02-26 14:30:35', 0, 'SMS', 'customerSendLink');

-- --------------------------------------------------------

--
-- Table structure for table `packages`
--

CREATE TABLE `packages` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `price` varchar(255) DEFAULT NULL,
  `created_at` date DEFAULT NULL,
  `updated_at` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `price_infos`
--

CREATE TABLE `price_infos` (
  `id` int(11) NOT NULL,
  `title` varchar(1000) NOT NULL,
  `priceID` varchar(1000) NOT NULL,
  `type` varchar(1000) NOT NULL,
  `limitedNums` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `reports`
--

CREATE TABLE `reports` (
  `id` int(11) NOT NULL,
  `description_id` bigint(20) NOT NULL,
  `resource_id` varchar(20) NOT NULL,
  `report` text DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `reports`
--

INSERT INTO `reports` (`id`, `description_id`, `resource_id`, `report`, `created_at`, `updated_at`) VALUES
(27, 77, 'ISWB7OrxXn', '111', '2021-02-14 09:59:27', '2021-02-14 09:59:27'),
(28, 78, 'ISWB7OrxXn', '123', '2021-02-14 10:15:01', '2021-02-14 10:15:01'),
(29, 79, 'ISWB7OrxXn', '234', '2021-02-14 10:15:05', '2021-02-14 10:15:05'),
(30, 81, 'ISWB7OrxXn', 'ddd', '2021-02-14 11:50:29', '2021-02-14 11:50:29'),
(31, 85, 'ISWB7OrxXn', 'dddd', '2021-02-14 12:10:12', '2021-02-14 12:10:12'),
(32, 87, 'ISWB7OrxXn', 'I finished it', '2021-02-14 14:58:51', '2021-02-14 14:58:51'),
(33, 87, 'ISWB7OrxXn', 'dddd', '2021-02-14 15:54:46', '2021-02-14 15:54:46'),
(34, 81, 'ISWB7OrxXn', 'finished!\nd\nd\nd\nd', '2021-02-14 19:42:51', '2021-02-14 19:42:51'),
(35, 102, 'ISWB7OrxXn', 'Waitlist 90\ncustomer 22', '2021-02-14 21:54:10', '2021-02-14 21:54:10'),
(36, 102, 'ISWB7OrxXn', 'Finished!', '2021-02-14 21:54:21', '2021-02-14 21:54:21'),
(37, 103, 'ISWB7OrxXn', 'Waitlist 12\ncustomer 22', '2021-02-14 22:01:19', '2021-02-14 22:01:19'),
(38, 106, 'ISWB7OrxXn', 'sdfsdfs', '2021-02-14 22:10:36', '2021-02-14 22:10:36'),
(39, 109, 'rPjXmtPP1M', 'meet', '2021-02-15 08:06:33', '2021-02-15 08:06:33'),
(40, 110, 'S0d8XhmNH8', 'res', '2021-02-15 08:07:58', '2021-02-15 08:07:58'),
(41, 111, 'S0d8XhmNH8', 'tes', '2021-02-15 08:08:09', '2021-02-15 08:08:09'),
(42, 110, 'rPjXmtPP1M', 'sdfs', '2021-02-15 08:08:54', '2021-02-15 08:08:54');

-- --------------------------------------------------------

--
-- Table structure for table `resources`
--

CREATE TABLE `resources` (
  `ID` varchar(10) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `manager_id` int(11) NOT NULL,
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
  `available` varchar(30) NOT NULL DEFAULT 'Available'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `resources`
--

INSERT INTO `resources` (`ID`, `user_id`, `manager_id`, `name`, `display_name`, `category_name`, `email`, `phone`, `img_path`, `description`, `created_at`, `updated_at`, `is_sign_up`, `working_hour`, `serviceProvide`, `working_data`, `available`) VALUES
('fPII7VD4YI', 1, 0, 'resource', '1', 'resource1', 'resource1@email.com', 'undefined', NULL, 'resource1\n', '2021-02-26 04:53:23', '2021-02-26 05:25:43', NULL, '{}', '[\"8mvAaC87Lk\"]', 'null', 'Available'),
('BwqtaHLglp', 32, 0, '1111', 'undefined', 'mans', '1111@email.com', 'undefined', NULL, 'undefined', '2021-02-15 08:34:51', '2021-02-15 08:34:51', NULL, '{}', '[]', 'null', 'Available'),
('rPjXmtPP1M', 32, 0, 'xcvxv', 'undefined', 'xcvxcv', 'xcvxcv@email.com', 'undefined', NULL, 'this is man', '2021-02-15 07:43:40', '2021-02-15 08:29:56', 'true', '{}', '[]', 'null', 'Available'),
('IfyDnXSYTy', 32, 0, 'man2', 'undefined', 'mans', 'man2@email.com', 'undefined', NULL, 'undefined', '2021-02-15 07:50:20', '2021-02-15 07:50:20', 'true', '{}', '[]', 'null', 'Available'),
('S0d8XhmNH8', 32, 0, 'man1', '', 'mans', 'man1@email.com', 'undefined', NULL, 'undefined', '2021-02-15 07:49:39', '2021-02-15 07:49:55', 'true', '{}', '[]', 'null', 'Available'),
('nEZ86VwCxy', 52, 0, 'asad', 'sss', 'sdf', 'syedalisma2468@gmail.com', '14333333333', 0x75706c6f6164735c696d616765735c3138386463636230306564353138353766633831353231376661623834383335, 'ffffffff', '2022-02-04 10:06:30', '2022-02-04 10:06:30', NULL, '{}', '[]', 'null', 'Available'),
('wIyVK0soD1', 52, 0, 'tt', 'tets', 'tets', 'testrr@r.rff', '14344234234', 0x75706c6f6164735c696d616765735c3565643431303662346439346633303465626531636238633633373430623734, 'qwwwwwwwww', '2022-02-01 11:13:06', '2022-02-04 06:34:36', NULL, '{}', '[]', 'null', 'Available'),
('snsPBcLwZR', 52, 0, 'test', 'test', 'texst', 'testres@res.ddg', '14234234234', '', 'testres', '2022-02-01 11:13:06', '2022-02-01 11:13:06', NULL, '{}', '[]', 'null', 'Available');

-- --------------------------------------------------------

--
-- Table structure for table `sequelizemeta`
--

CREATE TABLE `sequelizemeta` (
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `sequelizemeta`
--

INSERT INTO `sequelizemeta` (`name`) VALUES
('20200814052654-create-user.js');

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `ID` int(10) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `display_name` varchar(50) DEFAULT NULL,
  `category_name` varchar(50) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `img_path` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `color` varchar(10) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`ID`, `user_id`, `name`, `display_name`, `category_name`, `email`, `phone`, `img_path`, `description`, `color`, `created_at`, `updated_at`) VALUES
(28, 52, 'asadDASDAS', 'undefined', 'dd', 'syedalisma1234@gmail.com', '534534634645645', '', '', '#ff5722', '2022-02-04 10:20:50', '2022-02-04 11:04:37'),
(2, 1, '4', '4', '4', '4', '14', NULL, '4', '#795548', '2021-02-10 22:49:10', '2021-02-10 22:49:10'),
(3, 32, 'test', 'undefined', 'test', 'test@email.com', 'undefined', '????\0JFIF\0\0`\0`\0\0??\0;CREATOR: gd-jpeg v1.0 (using IJG JPEG v62), quality = 85\n??\0C\0	\Z!\Z\"$\"$??\0C??\0\0x\0x\"\0??\0\0\0\0\0\0\0\0\0\0', 'this is a test', '#f44336', '2021-02-15 08:29:36', '2021-02-15 08:29:36'),
(27, 52, 'yehloo', 'undefined', 'dd', NULL, NULL, '', 'yehloo', '#673ab7', '2022-02-04 10:20:50', '2022-02-04 10:20:50'),
(26, 52, 'teste', 'teste', 'dd', NULL, NULL, '', 'sac asad asdas d', '#4caf50', '2022-02-04 10:20:50', '2022-02-04 10:20:50'),
(25, 52, 'test Service', 'test Service', 'dd', NULL, NULL, '', 'test Service', '#673ab7', '2022-02-04 10:14:54', '2022-02-04 10:14:54'),
(24, 52, 'aa', 'aa', 'dd', NULL, NULL, '', 'aa', '#ffc107', '2022-02-04 09:51:28', '2022-02-04 10:19:47'),
(19, 52, 'aa', '', 'dd', NULL, NULL, '', '', '#8bc34a', '2022-02-04 08:05:16', '2022-02-04 10:20:50'),
(20, 52, 'aa', '', 'dd', NULL, NULL, '', '', '#795548', '2022-02-04 08:07:28', '2022-02-04 10:20:50'),
(29, 52, 'asfasfasfasfasfasfasfasfas', '', 'dd', NULL, NULL, '', '', '#ff5722', '2022-02-04 10:20:50', '2022-02-04 10:20:50'),
(30, 52, 'ali ka new', 'ali ka new', 'dd', NULL, NULL, '', 'ali ka new', '#4caf50', '2022-02-04 10:49:44', '2022-02-04 10:49:44');

-- --------------------------------------------------------

--
-- Table structure for table `staffs`
--

CREATE TABLE `staffs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` bigint(20) NOT NULL,
  `description` varchar(255) NOT NULL,
  `created_at` date DEFAULT NULL,
  `updated_at` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `staffs`
--

INSERT INTO `staffs` (`id`, `user_id`, `name`, `email`, `phone`, `description`, `created_at`, `updated_at`) VALUES
(1, 51, 'test', 'test@test.com', 322442424212, 'rtewfds dsrfds fdsf ds f', NULL, NULL),
(3, 51, 'test teste', 'test@test55.fd', 13534534634, 'etds dfds fds fds ', '2021-12-07', '2021-12-07'),
(17, 52, 'hhh', 'bolo@d.jj', 1555555555, 'gfh', '2022-02-04', '2022-02-04');

-- --------------------------------------------------------

--
-- Table structure for table `staff_meta`
--

CREATE TABLE `staff_meta` (
  `id` int(11) NOT NULL,
  `staffId` int(11) DEFAULT NULL,
  `meta_key` varchar(225) DEFAULT NULL,
  `meta_value` varchar(225) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `staff_meta`
--

INSERT INTO `staff_meta` (`id`, `staffId`, `meta_key`, `meta_value`) VALUES
(2, 32, 'sss', 'sss');

-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

CREATE TABLE `tasks` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `task_period` varchar(255) NOT NULL,
  `progress` varchar(20) NOT NULL DEFAULT 'todo'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tasks`
--

INSERT INTO `tasks` (`id`, `user_id`, `title`, `created_at`, `updated_at`, `task_period`, `progress`) VALUES
(81, 51, 'holiday', '2021-02-15 08:11:09', '2021-12-07 13:16:00', '[\"2021-12-08\",\"2022-10-07\"]', 'doing'),
(79, 51, 'party', '2021-02-15 07:48:25', '2021-02-15 07:48:25', '[\"2021-02-03\",\"2021-03-16\"]', 'done'),
(75, 1, 'meeting', '2021-02-14 21:39:14', '2021-02-26 05:26:58', '[\"2021-02-10\",\"2021-03-18\"]', 'doing'),
(77, 51, 'birthday', '2021-02-14 21:52:11', '2021-02-26 05:26:09', '[\"2021-02-01\",\"2021-02-02\"]', 'todo'),
(76, 1, 'party', '2021-02-14 21:44:09', '2021-02-26 05:26:42', '[\"2021-03-02\",\"2021-04-20\"]', 'doing'),
(85, 1, 'ddd', '2021-02-15 14:26:02', '2021-02-26 05:26:23', '[\"2021-02-05\",\"2021-03-10\"]', 'todo'),
(87, 1, 'Bill\' birthday', '2021-02-15 14:38:23', '2021-02-15 14:38:23', '[\"2021-02-06\",\"2021-03-09\"]', 'done'),
(100, 52, 'asd', '2022-02-04 09:38:30', '2022-02-04 09:38:30', '[\"2022-02-15\",\"2022-02-16\"]', 'todo'),
(99, 52, 'ww', '2022-02-04 09:34:20', '2022-02-04 09:34:20', '[\"2022-02-04\",\"2022-02-10\"]', 'done');

-- --------------------------------------------------------

--
-- Table structure for table `task_descriptions`
--

CREATE TABLE `task_descriptions` (
  `id` int(10) NOT NULL,
  `task_id` bigint(20) DEFAULT NULL,
  `title` text DEFAULT NULL,
  `resources` varchar(255) DEFAULT '[]',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `is_done` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `task_descriptions`
--

INSERT INTO `task_descriptions` (`id`, `task_id`, `title`, `resources`, `created_at`, `updated_at`, `is_done`) VALUES
(101, 75, 'shopping\nsketing', '[\"fPII7VD4YI\"]', '2021-02-14 21:39:14', '2021-02-26 05:26:58', 0),
(102, 76, 'waitlist 100\ncustomer 30', '[\"fPII7VD4YI\"]', '2021-02-14 21:44:09', '2021-02-26 05:26:42', 1),
(103, 76, 'waitlist 10\ncustomer 100', '[\"fPII7VD4YI\"]', '2021-02-14 21:44:09', '2021-02-26 05:26:42', 1),
(104, 77, 'classmates 10\nneighborhood 20', '[\"fPII7VD4YI\"]', '2021-02-14 21:52:11', '2021-02-26 05:26:09', 0),
(105, 77, 'shopping 2\n', '[\"fPII7VD4YI\"]', '2021-02-14 21:52:11', '2021-02-26 05:26:09', 1),
(108, 79, 'friend 10', '[\"rPjXmtPP1M\"]', '2021-02-15 07:48:25', '2021-02-15 08:21:44', 1),
(112, 81, '1.1 test', '[\"IfyDnXSYTy\",\"rPjXmtPP1M\"]', '2021-02-15 08:11:09', '2021-12-07 13:16:00', 1),
(118, 87, 'sdfs', '[\"ISWB7OrxXn\"]', '2021-02-15 14:38:23', '2021-02-15 14:38:23', 0),
(120, 85, 'fdgdf', '[\"fPII7VD4YI\"]', '2021-02-23 14:29:26', '2021-02-26 05:26:23', 0),
(133, 99, 'dd', '[]', '2022-02-04 09:34:20', '2022-02-04 09:34:20', 0),
(134, 100, 'ss', '[]', '2022-02-04 09:38:30', '2022-02-04 09:38:30', 0);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
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
  `user_group_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `phone` int(11) NOT NULL,
  `description` varchar(225) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `businessID`, `username`, `firstname`, `lastname`, `email`, `email_verified_at`, `password`, `avatarUrl`, `role`, `remember_token`, `last_login`, `created_at`, `updated_at`, `user_group_id`, `user_id`, `phone`, `description`) VALUES
(1, NULL, 'a', 'a', 'a', 'a@a.ddd', NULL, NULL, NULL, NULL, NULL, '', '2022-01-27 09:55:12', '2022-01-27 07:14:37', 0, 0, 0, ''),
(50, 'bY0nC5CvPJKAKQX8xlKY', 't q', 'k', 's', 'testing@email.com', NULL, '$2a$10$U5aL1Sl/Pxx5.XJYDNzRoOimElBRMo26ylLducDrxDCuUSPUHx7rm', NULL, NULL, NULL, '2021-02-26 08:15:17', '2022-01-27 07:47:23', '2022-01-27 06:21:29', 52, 4, 9244444, 'ewwwwwwwwwwwwwwe'),
(52, 'uBawoQEszK9jzi3qzB0R', 'ali ali', 'ali', 'ali', 'ali123@gmail.com', NULL, '$2a$10$nB2ZY7rdKZez6TGhj0oPn.hCyuEIYiLsA4SyAbhhKcG22wJ4RjBKa', NULL, 'admin', NULL, '2021-12-28 17:28:46', '2022-02-04 06:31:23', '2022-02-03 10:32:39', 3, 30, 924444, 'k'),
(53, 'cbRgvl5mUqhSk0Qlw9BX', 'admin avsw', 'admin', 'avs', 'admin123@admin.com', NULL, '$2a$10$JzpzsKPhrOIHFDFbvLRX5OEhVmLImIJQnqqcXR74wGhhuaJ3IDmZm', NULL, 'admin', NULL, '', '2022-02-26 09:56:34', '2022-01-26 13:59:58', 56, 33, 924444, 'ewwwwwwwwwwwwwwe'),
(54, NULL, 'w', 'w', 'w', 'w@w.www', NULL, NULL, NULL, NULL, NULL, '', '2022-01-27 07:07:30', '2022-01-27 07:07:30', 0, 0, 0, ''),
(55, NULL, 'qq', 'e', 'ww', 'e@e.eee', NULL, NULL, NULL, NULL, NULL, '', '2022-01-27 07:08:47', '2022-01-27 07:08:47', 0, 0, 0, ''),
(57, NULL, 'aw', 'qw', 'ww', 's@s.sss', NULL, NULL, NULL, NULL, NULL, '', '2022-01-27 07:15:36', '2022-01-27 07:15:36', 0, 0, 0, ''),
(58, NULL, 'w', 'w', 'w', 'w@w.www', NULL, NULL, NULL, NULL, NULL, '', '2022-01-27 07:19:56', '2022-01-27 07:19:56', 0, 0, 0, ''),
(59, NULL, 'a', 'w', 'e', 'r@r.kk', NULL, NULL, NULL, NULL, NULL, '', '2022-01-27 07:20:22', '2022-01-27 07:20:22', 0, 0, 0, ''),
(60, NULL, 'e', 'e', 'e', 'e@e.kkk', NULL, NULL, NULL, NULL, NULL, '', '2022-01-27 08:07:19', '2022-01-27 08:07:19', 0, 0, 1444444444, 'ttt'),
(61, 'Jzt7WdV125ArTxrAbQKq', 'admin admin', 'admin', 'admin', 'admin@admin.com', NULL, '$2a$10$BeQ/2mkNA8siy9J.NrjKzO0IvLMcm/NuGy/WaV7xQ4iH9xXLQcwq6', NULL, NULL, NULL, '', '2022-02-19 13:57:11', '2022-02-19 13:57:11', 0, 0, 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `user_meta`
--

CREATE TABLE `user_meta` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `meta_key` varchar(225) NOT NULL,
  `meta_value` varchar(225) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_meta`
--

INSERT INTO `user_meta` (`id`, `userId`, `meta_key`, `meta_value`) VALUES
(1, 52, 'sas', 'asds'),
(1, 52, 'sas', 'asds');

-- --------------------------------------------------------

--
-- Table structure for table `waitlists`
--

CREATE TABLE `waitlists` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `wait_time` datetime DEFAULT NULL,
  `serve_time` datetime DEFAULT NULL,
  `priority` bigint(20) DEFAULT NULL,
  `is_show` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1: show, 0: hidden',
  `order_num` int(11) DEFAULT NULL,
  `resource_id` varchar(20) DEFAULT NULL,
  `booking_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `waitlists`
--

INSERT INTO `waitlists` (`id`, `user_id`, `customer_id`, `wait_time`, `serve_time`, `priority`, `is_show`, `order_num`, `resource_id`, `booking_id`) VALUES
(147, 1, 188, '2021-02-10 12:16:22', '2021-02-10 12:17:08', 0, 1, 1, 'uwdL8j96qI', 144),
(208, 51, 197, '2021-12-09 11:02:05', '2021-12-09 12:12:47', NULL, 1, 1, 'vtua7d4dEa', 0),
(156, 1, 196, '2021-02-10 12:26:07', '2021-02-10 12:28:23', 0, 1, 1, 'ISWB7OrxXn', 0),
(165, 1, 200, '2021-02-24 07:27:19', '2021-02-24 08:31:39', 0, 0, 1, 'vgftEu4nLN', 0),
(161, 1, 189, '2021-02-23 14:25:58', NULL, 0, 1, 1, NULL, 0),
(162, 1, 201, NULL, '2021-02-23 14:26:25', 0, 1, NULL, NULL, 0),
(163, 1, 202, '2021-02-23 14:27:08', NULL, 0, 1, 1, 'uwdL8j96qI', 0),
(151, 1, 192, NULL, '2021-02-10 12:03:28', 0, 1, NULL, 'vgftEu4nLN', 0),
(139, 1, 182, NULL, '2021-02-10 11:04:26', 0, 1, NULL, 'WJKtIvm3tX', 0),
(143, 1, 185, '2021-02-10 12:16:24', '2021-02-10 12:17:09', 0, 1, 1, 'vgftEu4nLN', 0),
(141, 1, 183, '2021-02-10 12:16:25', '2021-02-10 12:28:22', 0, 0, 1, 'ISWB7OrxXn', 0),
(142, 1, 184, NULL, '2021-02-10 11:15:28', 0, 1, NULL, 'WJKtIvm3tX', 0),
(150, 1, 191, NULL, '2021-02-10 12:03:05', 0, 1, NULL, 'vgftEu4nLN', 0),
(145, 1, 186, '2021-02-10 12:17:00', '2021-02-10 12:23:41', 0, 1, 1, 'ISWB7OrxXn', 0),
(148, 1, 189, '2021-02-10 11:53:32', '2021-02-10 11:53:40', 0, 0, 1, 'vgftEu4nLN', 0),
(166, 1, 200, NULL, '2021-02-24 07:27:51', 0, 0, NULL, 'vgftEu4nLN', 0),
(137, 1, 180, '2021-02-10 12:16:39', '2021-02-23 14:09:14', 0, 0, 1, 'vgftEu4nLN', 0),
(167, 1, 200, '2021-02-24 07:28:30', '2021-02-24 14:26:19', 0, 0, 1, 'ISWB7OrxXn', 0),
(168, 1, 207, NULL, '2021-02-24 08:27:07', 0, 0, NULL, 'vgftEu4nLN', 0),
(169, 1, 207, NULL, '2021-02-24 08:28:16', 0, 0, NULL, 'ISWB7OrxXn', 0),
(170, 1, 207, '2021-02-24 08:29:20', '2021-02-24 08:29:42', 0, 0, 1, 'uwdL8j96qI', 0),
(171, 1, 211, '2021-02-24 14:26:35', '2021-02-24 14:27:04', 0, 0, 1, 'MxFurJcx1v', 0),
(196, 1, 222, '2021-02-26 14:20:22', NULL, 0, 1, NULL, NULL, 0),
(173, 1, 210, '2021-02-24 14:26:36', NULL, 0, 1, 1, NULL, 0),
(174, 1, 209, '2021-02-24 14:26:37', NULL, 0, 1, 1, NULL, 0),
(193, 1, 220, '2021-02-26 14:06:40', NULL, 0, 1, NULL, NULL, 0),
(176, 1, 211, '2021-02-24 19:51:25', '2021-02-25 11:39:09', 0, 0, 1, 'ISWB7OrxXn', 0),
(202, 50, 228, '2021-02-26 16:34:01', NULL, 0, 1, NULL, NULL, 0),
(194, 1, 216, '2021-02-26 14:07:22', NULL, 0, 1, NULL, NULL, 0),
(182, 1, 210, '2021-02-25 01:52:41', NULL, 0, 1, 1, NULL, 0),
(201, 50, 227, '2021-02-26 16:30:48', NULL, 0, 1, NULL, NULL, 0),
(200, 50, 226, '2021-02-26 16:22:51', NULL, 0, 1, NULL, NULL, 0),
(199, 50, 225, '2021-02-26 16:20:25', NULL, 0, 1, NULL, NULL, 0),
(198, 50, 224, '2021-02-26 16:20:08', NULL, 0, 1, NULL, NULL, 0),
(195, 1, 221, '2021-02-26 14:16:02', NULL, 0, 1, NULL, NULL, 0),
(188, 1, 210, '2021-02-25 15:30:19', NULL, 0, 1, 1, NULL, 0),
(189, 1, 211, '2021-02-26 10:48:54', NULL, 0, 1, 1, NULL, 0),
(190, 1, 208, '2021-02-26 10:48:55', NULL, 0, 1, 1, NULL, 0),
(191, 1, 207, '2021-02-26 10:48:55', NULL, 0, 1, 1, NULL, 0),
(192, 1, 219, '2021-02-26 14:03:36', NULL, 0, 1, NULL, NULL, 0),
(204, 51, 229, '2021-12-09 15:06:04', NULL, NULL, 0, NULL, 'vtua7d4dEa', 0),
(205, 51, 229, '2021-12-06 13:04:09', '2021-12-09 10:08:24', NULL, 1, 1, 'vtua7d4dEa', 0),
(206, 51, 230, '2021-12-07 10:10:48', NULL, 1, 1, 1, '8JNxyRABNw', 0),
(207, 51, 231, '2021-12-07 10:11:09', NULL, 3, 1, 1, '8JNxyRABNw', 0),
(212, 52, 213, NULL, '2021-12-29 06:36:20', NULL, 1, NULL, NULL, 0),
(211, 52, 234, '2021-12-28 13:55:43', NULL, NULL, 1, 37, NULL, 0),
(213, 52, 213, NULL, '2021-12-29 06:41:19', NULL, 1, NULL, NULL, 0),
(214, 52, 213, NULL, '2021-12-29 06:46:00', NULL, 1, NULL, NULL, 0),
(215, 52, 213, NULL, '2021-12-29 06:48:02', NULL, 1, NULL, NULL, 0),
(216, 52, 213, NULL, '2021-12-29 06:49:00', NULL, 1, NULL, NULL, 0),
(217, 52, 213, NULL, '2021-12-29 06:50:48', NULL, 1, NULL, NULL, 0),
(218, 52, 213, NULL, '2021-12-29 06:51:27', NULL, 1, NULL, NULL, 0),
(219, 52, 213, NULL, '2021-12-29 07:04:54', NULL, 1, NULL, NULL, 0),
(220, 52, 213, NULL, '2021-12-29 07:05:27', NULL, 1, NULL, NULL, 0),
(221, 52, 213, NULL, '2021-12-29 07:06:02', NULL, 1, NULL, NULL, 0),
(222, 52, 213, NULL, '2021-12-29 07:13:37', NULL, 1, NULL, NULL, 0),
(223, 52, 213, NULL, '2021-12-29 07:14:32', NULL, 1, NULL, NULL, 0),
(224, 52, 213, NULL, '2021-12-29 07:28:39', NULL, 1, NULL, NULL, 0),
(225, 52, 213, NULL, '2021-12-29 07:35:22', NULL, 1, NULL, NULL, 0),
(226, 52, 213, NULL, '2021-12-29 07:35:58', NULL, 1, NULL, NULL, 0),
(227, 52, 213, NULL, '2021-12-29 07:38:58', NULL, 1, NULL, NULL, 0),
(228, 52, 213, NULL, '2021-12-29 07:40:00', NULL, 1, NULL, NULL, 0),
(229, 52, 213, NULL, '2021-12-29 07:50:15', NULL, 1, NULL, NULL, 0),
(230, 52, 213, NULL, '2021-12-29 07:51:07', NULL, 1, NULL, NULL, 0),
(231, 52, 213, NULL, '2021-12-29 07:58:37', NULL, 1, NULL, NULL, 0),
(232, 52, 213, NULL, '2021-12-29 09:39:43', NULL, 1, NULL, NULL, 0),
(233, 52, 213, NULL, '2021-12-29 09:41:26', NULL, 1, NULL, NULL, 0),
(234, 52, 213, NULL, '2021-12-29 09:45:57', NULL, 1, NULL, NULL, 0),
(235, 52, 213, NULL, '2021-12-29 09:47:25', NULL, 1, NULL, NULL, 0),
(236, 52, 213, NULL, '2021-12-29 09:50:29', NULL, 1, NULL, NULL, 0),
(298, 52, 251, '2022-01-01 06:53:00', NULL, NULL, 1, 37, '5H76rs7qim', 0),
(297, 52, 249, '2022-01-01 06:51:47', NULL, NULL, 1, 37, '5H76rs7qim', 0),
(296, 52, 100, '2022-01-01 06:48:21', NULL, NULL, 1, 36, '5H76rs7qim', 0),
(295, 52, 100, '2022-01-01 06:30:03', '2022-01-01 06:30:05', NULL, 0, 1, '5H76rs7qim', 0),
(293, 52, 100, '2022-01-01 06:27:21', '2022-01-01 06:27:27', NULL, 0, 1, '5H76rs7qim', 0),
(292, 52, 248, '2022-01-01 06:18:00', NULL, 1, 1, 37, NULL, 0),
(283, 52, 242, '2021-12-31 08:08:19', NULL, NULL, 1, 36, NULL, 0),
(294, 52, 100, '2022-01-01 06:29:28', '2022-01-01 06:29:35', NULL, 0, 1, '5H76rs7qim', 0),
(300, 52, 253, '2022-01-01 07:09:55', NULL, NULL, 0, 36, '5H76rs7qim', 0),
(301, 52, 254, '2022-01-01 07:10:31', '2022-01-01 07:12:04', NULL, 0, 1, '5H76rs7qim', 0),
(312, 52, 253, '2022-01-01 09:30:45', '2022-01-01 09:30:49', NULL, 0, 1, '5H76rs7qim', 0),
(303, 52, 253, NULL, '2022-01-01 07:16:49', NULL, 0, NULL, '5H76rs7qim', 0),
(304, 52, 253, NULL, '2022-01-01 07:17:50', NULL, 0, NULL, '5H76rs7qim', 0),
(305, 52, 253, '2022-01-01 07:21:34', '2022-01-01 07:21:36', NULL, 0, 1, '5H76rs7qim', 0),
(306, 52, 255, NULL, '2022-01-01 07:35:50', NULL, 0, NULL, '5H76rs7qim', 0),
(308, 52, 256, '2022-01-01 08:41:19', '2022-01-01 08:43:27', NULL, 0, 1, '5H76rs7qim', 0),
(309, 52, 253, '2022-01-01 09:20:36', '2022-01-01 09:24:43', NULL, 0, 1, '5H76rs7qim', 0),
(310, 52, 257, '2022-01-01 08:42:57', '2022-01-01 09:28:22', NULL, 0, 1, '5H76rs7qim', 0),
(311, 52, 256, '2022-01-01 09:27:22', '2022-01-01 09:27:27', NULL, 0, 1, '5H76rs7qim', 0),
(318, 52, 257, '2022-01-01 10:38:49', '2022-01-01 10:39:24', NULL, 0, 1, '5H76rs7qim', 0),
(315, 52, 258, '2022-01-01 11:15:47', '2022-01-01 11:16:02', NULL, 0, 1, '5H76rs7qim', 0),
(319, 52, 253, '2022-01-01 10:38:58', '2022-01-01 11:09:18', NULL, 0, 1, '5H76rs7qim', 0),
(320, 52, 253, NULL, '2022-01-01 13:29:38', NULL, 0, NULL, '5H76rs7qim', 0),
(321, 52, 257, NULL, '2022-01-01 13:30:33', NULL, 0, NULL, '5H76rs7qim', 0),
(322, 52, 257, NULL, '2022-01-01 13:31:20', NULL, 0, NULL, '5H76rs7qim', 0),
(323, 52, 253, NULL, '2022-01-01 13:31:47', NULL, 0, NULL, '5H76rs7qim', 0),
(324, 52, 253, '2022-01-01 13:41:33', NULL, NULL, 0, 33, '5H76rs7qim', 0),
(325, 52, 257, '2022-01-01 13:42:12', NULL, NULL, 1, 33, '5H76rs7qim', 0),
(326, 52, 253, '2022-01-01 14:00:17', NULL, NULL, 1, 33, '5H76rs7qim', 0),
(352, 52, 269, '2022-02-02 11:13:33', '2022-02-02 11:13:36', NULL, 0, 1, 'OgnBl1CebT', 0),
(350, 52, 269, '2022-02-02 11:11:31', NULL, NULL, 0, 32, 'snsPBcLwZR', 0),
(345, 52, 274, '2022-02-02 12:31:24', NULL, 0, 1, 12, 'OgnBl1CebT', 0),
(351, 52, 269, '2022-02-02 11:13:01', NULL, NULL, 0, 31, 'wIyVK0soD1', 0),
(353, 52, 269, '2022-02-02 11:14:03', NULL, NULL, 0, 30, 'OgnBl1CebT', 0),
(354, 52, 269, '2022-02-02 11:14:53', NULL, NULL, 0, 29, 'OgnBl1CebT', 0),
(355, 52, 269, '2022-02-02 11:15:07', NULL, NULL, 0, 28, 'OgnBl1CebT', 0),
(356, 52, 269, NULL, '2022-02-02 11:16:02', NULL, 0, NULL, 'OgnBl1CebT', 0),
(360, 52, 269, '2022-02-02 11:20:56', NULL, NULL, 0, 27, 'OgnBl1CebT', 0),
(361, 52, 269, '2022-02-02 11:24:00', NULL, NULL, 0, 23, 'wIyVK0soD1', 0),
(365, 52, 269, '2022-02-02 12:26:43', NULL, 0, 1, 16, 'wIyVK0soD1', 0),
(364, 52, 269, '2022-02-02 12:30:24', NULL, 0, 1, 13, 'wIyVK0soD1', 0),
(366, 52, 222, '2022-02-02 13:53:26', NULL, NULL, 1, 11, NULL, 0),
(367, 52, 223, '2022-02-02 13:53:33', NULL, NULL, 1, 10, NULL, 0),
(368, 52, 224, '2022-02-02 13:53:35', NULL, NULL, 1, 9, NULL, 0),
(369, 52, 207, '2022-02-02 13:53:38', NULL, NULL, 1, 8, NULL, 0),
(371, 52, 263, '2022-02-03 06:21:23', NULL, NULL, 1, 8, NULL, 0),
(387, 52, 274, '2022-02-03 06:44:23', NULL, NULL, 1, 36, 'wIyVK0soD1', 0),
(374, 52, 180, '2022-02-03 06:21:33', NULL, NULL, 1, 7, NULL, 0),
(375, 52, 180, '2022-02-03 06:22:42', NULL, NULL, 1, 7, NULL, 0),
(386, 52, 269, '2022-02-03 06:42:56', NULL, NULL, 1, 35, 'snsPBcLwZR', 0),
(377, 52, 255, '2022-02-03 06:22:45', NULL, NULL, 1, 7, NULL, 0),
(388, 52, 269, '2022-02-03 06:46:32', NULL, NULL, 1, 37, NULL, 0),
(379, 52, 52, '2022-02-03 06:23:55', NULL, NULL, 1, 6, NULL, 0),
(380, 52, 255, '2022-02-03 06:24:00', NULL, NULL, 1, 5, 'OgnBl1CebT', 0),
(385, 52, 269, '2022-02-03 06:42:09', NULL, NULL, 1, 31, 'snsPBcLwZR', 0),
(400, 52, 256, '2022-02-03 09:59:52', NULL, NULL, 1, 1, NULL, 0),
(389, 52, 274, '2022-02-03 06:48:37', NULL, NULL, 1, 38, NULL, 0),
(390, 52, 274, '2022-02-03 06:58:49', NULL, NULL, 1, 39, 'wIyVK0soD1', 0),
(392, 52, 255, '2022-02-03 07:50:53', NULL, NULL, 1, 3, NULL, 0),
(393, 52, 255, '2022-02-03 07:53:04', NULL, NULL, 1, 3, NULL, 0),
(398, 52, 255, '2022-02-03 09:18:37', NULL, NULL, 1, 2, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `waitlist_settings`
--

CREATE TABLE `waitlist_settings` (
  `ID` int(11) NOT NULL,
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
  `PublicWaitlistUrl` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `waitlist_settings`
--

INSERT INTO `waitlist_settings` (`ID`, `user_id`, `location_name`, `limit_max_waiting`, `limit_max_wait_number`, `reject_duplicates`, `reject_flagged`, `waiting`, `serving`, `default_serve_duration`, `default_serve_duration_type`, `number_of_serve_people`, `service_duration`, `status_indicator`, `hide_cancel`, `call_business`, `PublicWaitlistUrl`) VALUES
(1, 0, 'vangel', 0, '', 0, 0, 'never', 'never', 0, 'seconds', 0, 0, 'Estimated wait and order in li', 0, 0, ''),
(4, 1, 'vangel', 1, '', 1, 1, '2hours', '2hours', 13123, 'hours', 13123, 1, 'Only estimated wait', 1, 1, ''),
(5, 32, 'vangel', 0, '', 0, 0, '1hours', 'never', 0, 'seconds', 0, 0, 'Estimated wait and order in li', 0, 0, ''),
(6, 50, 'vangel', 0, '', 0, 0, 'never', 'never', 0, 'seconds', 0, 0, 'Estimated wait and order in li', 0, 0, 'stone1'),
(7, 52, 'vangel', 0, '1', 0, 0, '1hours', 'never', 32, 'minutes', 3, 0, 'Estimated wait and order in li', 1, 1, 'uBawoQEszK9jzi3qzB0R'),
(8, 53, 'vangel', 0, '', 0, 0, 'never', 'never', 0, 'seconds', 0, 0, 'Estimated wait and order in li', 0, 0, 'cbRgvl5mUqhSk0Qlw9BX'),
(9, 61, 'vangel', 0, '', 0, 0, 'never', 'never', 0, 'seconds', 0, 0, 'Estimated wait and order in li', 0, 0, 'Jzt7WdV125ArTxrAbQKq');

-- --------------------------------------------------------

--
-- Table structure for table `website_settings`
--

CREATE TABLE `website_settings` (
  `id` int(11) NOT NULL,
  `name` varchar(225) NOT NULL,
  `logo` varchar(1000) NOT NULL,
  `email` varchar(225) NOT NULL,
  `address` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `website_settings`
--

INSERT INTO `website_settings` (`id`, `name`, `logo`, `email`, `address`) VALUES
(1, 'dd1', '', 'asq@d.kkkffaa', 'http://localhost:3000/admin/website-settings-admin');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `alert_settings`
--
ALTER TABLE `alert_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `alert_settings_default`
--
ALTER TABLE `alert_settings_default`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `booking_settings`
--
ALTER TABLE `booking_settings`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `business_infos`
--
ALTER TABLE `business_infos`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `business_memberships`
--
ALTER TABLE `business_memberships`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `client_fields`
--
ALTER TABLE `client_fields`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`,`email`);

--
-- Indexes for table `customer_meta`
--
ALTER TABLE `customer_meta`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `description_resources`
--
ALTER TABLE `description_resources`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `localizations`
--
ALTER TABLE `localizations`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `managers`
--
ALTER TABLE `managers`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `message_histories`
--
ALTER TABLE `message_histories`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `packages`
--
ALTER TABLE `packages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `price_infos`
--
ALTER TABLE `price_infos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `resources`
--
ALTER TABLE `resources`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `sequelizemeta`
--
ALTER TABLE `sequelizemeta`
  ADD PRIMARY KEY (`name`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `staffs`
--
ALTER TABLE `staffs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `staff_meta`
--
ALTER TABLE `staff_meta`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `task_descriptions`
--
ALTER TABLE `task_descriptions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `businessID` (`businessID`);

--
-- Indexes for table `waitlists`
--
ALTER TABLE `waitlists`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `waitlist_settings`
--
ALTER TABLE `waitlist_settings`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `alert_settings`
--
ALTER TABLE `alert_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=89;

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=151;

--
-- AUTO_INCREMENT for table `booking_settings`
--
ALTER TABLE `booking_settings`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `business_memberships`
--
ALTER TABLE `business_memberships`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=297;

--
-- AUTO_INCREMENT for table `customer_meta`
--
ALTER TABLE `customer_meta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=422;

--
-- AUTO_INCREMENT for table `description_resources`
--
ALTER TABLE `description_resources`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `localizations`
--
ALTER TABLE `localizations`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=158;

--
-- AUTO_INCREMENT for table `message_histories`
--
ALTER TABLE `message_histories`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `packages`
--
ALTER TABLE `packages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `price_infos`
--
ALTER TABLE `price_infos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reports`
--
ALTER TABLE `reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `staffs`
--
ALTER TABLE `staffs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `staff_meta`
--
ALTER TABLE `staff_meta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tasks`
--
ALTER TABLE `tasks`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT for table `task_descriptions`
--
ALTER TABLE `task_descriptions`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=135;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT for table `waitlists`
--
ALTER TABLE `waitlists`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=401;

--
-- AUTO_INCREMENT for table `waitlist_settings`
--
ALTER TABLE `waitlist_settings`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
