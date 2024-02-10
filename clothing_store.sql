-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Feb 10, 2024 at 01:39 PM
-- Server version: 10.6.5-MariaDB
-- PHP Version: 8.2.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `clothing_store`
--
CREATE DATABASE IF NOT EXISTS `clothing_store` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `clothing_store`;

-- --------------------------------------------------------

--
-- Table structure for table `pimage`
--

DROP TABLE IF EXISTS `pimage`;
CREATE TABLE IF NOT EXISTS `pimage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL,
  `imgpath` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pimage`
--

INSERT INTO `pimage` (`id`, `pid`, `imgpath`, `date`) VALUES
(1, 2, 'c1.jpeg', '2024-01-06 14:58:55'),
(2, 3, 'd4.jpeg', '2024-01-06 15:11:10'),
(3, 7, 'relaxp2.jpeg', '2024-01-06 15:11:28'),
(4, 8, 'g1.jpeg', '2024-01-06 15:11:58'),
(5, 9, 'e2.jpeg', '2024-01-06 15:12:16'),
(7, 11, 'relaxp3.jpeg', '2024-01-06 15:31:45'),
(8, 12, 'b1.jpeg', '2024-01-06 15:31:54'),
(9, 10, 'Relax2.jpeg', '2024-01-06 20:57:22');

-- --------------------------------------------------------

--
-- Table structure for table `pmain`
--

DROP TABLE IF EXISTS `pmain`;
CREATE TABLE IF NOT EXISTS `pmain` (
  `pid` int(11) NOT NULL AUTO_INCREMENT,
  `pname` varchar(70) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pmain`
--

INSERT INTO `pmain` (`pid`, `pname`, `date`) VALUES
(2, 'Regular fit hoodie', '2023-12-30 12:27:53'),
(3, 'Relax fit t-shirt', '2023-12-30 13:04:12'),
(7, 'Relaxed Fit Printed Hoodie', '2023-12-31 15:14:04'),
(8, 'Oversized Sweatshirt', '2023-12-31 15:14:27'),
(9, 'Oversized Fit Sweatshirt', '2023-12-31 15:14:43'),
(10, 'Relaxed Hoodie', '2023-12-31 15:15:09'),
(11, 'Zipped Hoodie', '2023-12-31 15:15:35'),
(12, 'Oversized t-shirt', '2024-01-03 12:27:06');

-- --------------------------------------------------------

--
-- Table structure for table `product1`
--

DROP TABLE IF EXISTS `product1`;
CREATE TABLE IF NOT EXISTS `product1` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pname` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `colour` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `cdate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product1`
--

INSERT INTO `product1` (`id`, `pname`, `price`, `colour`, `size`, `quantity`, `cdate`) VALUES
(5, 'Relax fit sweatshirt', 999, 'Black', 'large', 6, NULL),
(7, 'tshirt', 855, 'Brown', 'large', 10, NULL),
(8, 'xyz', 255, 'Black', 'XXL', 20, NULL),
(9, 'abc', 255, 'Black', 'small', 20, '2023-12-29 14:42:38'),
(10, 'hoodie', 899, 'White', 'large', 20, '2023-12-29 15:59:26'),
(11, 'hoodie2', 522, 'Brown', 'medium', 10, '2023-12-29 15:59:55');

-- --------------------------------------------------------

--
-- Table structure for table `pspecification`
--

DROP TABLE IF EXISTS `pspecification`;
CREATE TABLE IF NOT EXISTS `pspecification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL,
  `colour` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pspecification`
--

INSERT INTO `pspecification` (`id`, `pid`, `colour`, `date`) VALUES
(1, 2, 'black', '2024-01-03 12:27:51'),
(2, 3, 'brown', '2024-01-03 12:27:58'),
(3, 7, 'white', '2024-01-03 12:28:06'),
(4, 8, 'brown', '2024-01-03 12:28:34'),
(5, 9, 'black', '2024-01-03 12:28:47'),
(6, 11, 'blue', '2024-01-03 12:29:06'),
(8, 12, 'red', '2024-01-03 12:29:29'),
(9, 2, 'black', '2024-01-12 05:08:54'),
(10, 2, 'brown', '2024-01-12 05:08:58'),
(11, 2, 'blue', '2024-01-12 05:09:01'),
(12, 2, 'red', '2024-01-12 05:09:06');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_cart`
--

DROP TABLE IF EXISTS `tbl_cart`;
CREATE TABLE IF NOT EXISTS `tbl_cart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `spec_id` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `spec_id` (`spec_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_products`
--

DROP TABLE IF EXISTS `tbl_products`;
CREATE TABLE IF NOT EXISTS `tbl_products` (
  `id` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tbl_products`
--

INSERT INTO `tbl_products` (`id`, `name`, `description`, `image_url`) VALUES
(1, 'Relaxed Fit Jersey top T-shirt', 'Top in soft cotton jersey with a Relaxed fit with long sleeves.', 'images/relfit-longsleeve-tshirt.jpeg'),
(2, 'Regular Fit Jersey top T-shirt', 'Regular-fit top in soft cotton jersey with round neckline and long sleeves.', 'images/regfit-longsleeve-tshirt.jpeg'),
(3, 'Slim Fit Polo T-shirt', 'Slim-fit polo shirt in soft cotton jersey,', 'images/slimfit-polo-tshirt.jpeg'),
(4, 'Regular Fit Polo T-shirt', 'Polo shirt in soft, fine-knit cotton.', 'images/regfit-polo-tshirt.jpeg'),
(5, 'Regular Fit Oxford shirt', 'Regular-fit shirt in Oxford cotton with a button-down collar.', 'images/regfit-casual-shirt.jpeg'),
(6, 'Relaxed Fit Corduroy shirt', 'Relaxed-fit shirt in soft cotton corduroy.', 'images/relfit-casual-shirt.jpeg'),
(7, 'Loose Fit Short-sleeved shirt', 'Short-sleeved shirt in a printed cotton weave.', 'images/loosefit-short-shirt.jpeg'),
(8, 'Relaxed Fit Short-sleeved shirt', 'Relaxed-fit shirt in a cotton weave with a turn-down collar.', 'images/relfit-short-shirt.jpeg'),
(9, 'Regular Fit Ripstop joggers', 'Regular-fit joggers in a hard-wearing ripstop weave.', 'images/regfit-joggers-trousers.jpeg'),
(10, 'Skinny Fit Nylon cargo joggers', 'Joggers in stretch nylon. Skinny fit with covered elastication. ', 'images/skinfit-joggers-trousers.jpeg'),
(11, 'Baggy Fit Cargo trousers', 'Baggy-fit cargo trousers in rigid denim cotton.', 'images/baggyfit-cargo-trousers.jpeg'),
(12, 'Relaxed Fit Cargo trousers', 'Relaxed-fit cargo trousers in a cotton weave.', 'images/regfit-cargo-trousers.jpeg'),
(13, 'Relaxed Jeans', '5-pocket jeans in rigid cotton denim with a relaxed fit from the seat to the hem.', 'images/relfit-relaxed-jeans.jpeg'),
(14, 'Straight Relaxed Jeans', '5-pocket jeans in rigid denim with a straight leg from the seat to the hem.', 'images/straight-relaxed-jeans.jpeg'),
(15, 'Slim Jeans', '5-pocket jeans in cotton denim with a slight stretch for good comfort.', 'images/slimfit1-slim-jeans.jpeg'),
(16, 'Retro Slim Jeans', '5-pocket jeans in cotton denim with a slight stretch for good comfort.', 'images/retro-slim-jeans.jpeg'),
(17, 'Relaxed Fit Hoodie', 'Relaxed fit Hoodie in sweatshirt fabric made from a cotton blend.', 'images/relfit-hoodie.jpeg'),
(18, 'Oversized Fit hoodie', 'Oversized hoodie in sweatshirt fabric made from a cotton blend.', 'images/oversized-hoodie.jpeg'),
(19, 'Relaxed Fit Sweatshirt', 'Relaxed fit Sweatshirt with dropped shoulders.', 'images/relfit-sweatshirt.jpeg'),
(20, 'Loose Fit Sweatshirt', 'Loose fit Sweatshirt with dropped shoulders.', 'images/loosefit-sweatshirt.jpeg');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_specifications`
--

DROP TABLE IF EXISTS `tbl_specifications`;
CREATE TABLE IF NOT EXISTS `tbl_specifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `size` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tbl_specifications`
--

INSERT INTO `tbl_specifications` (`id`, `size`, `quantity`, `price`, `pid`, `date`) VALUES
(1, 'L', 10, 699, 3, '2023-12-30 13:13:42'),
(2, 'XL', 50, 1500, 7, '2023-12-31 15:16:31'),
(3, 'L', 60, 899, 8, '2023-12-31 15:16:53'),
(4, 'M', 80, 1299, 9, '2023-12-31 15:17:19'),
(5, 'XXL', 50, 1199, 10, '2023-12-31 15:17:36'),
(6, 'S', 50, 1499, 11, '2023-12-31 15:17:50'),
(7, 'S', 50, 899, 12, '2024-01-03 12:27:31'),
(8, 'M', 10, 999, 2, '2024-01-11 17:15:34'),
(9, 'L', 10, 999, 2, '2024-01-12 04:32:05'),
(10, 'XL', 10, 999, 2, '2024-01-12 04:32:15'),
(11, 'S', 10, 999, 2, '2024-01-12 04:32:47'),
(12, 'S', 10, 699, 3, '2024-01-24 14:07:53'),
(13, 'M', 10, 699, 3, '2024-01-24 14:09:09'),
(14, 'XL', 10, 699, 3, '2024-01-24 14:09:17'),
(15, 'XXL', 10, 699, 3, '2024-01-24 14:09:25'),
(16, 'S', 50, 1500, 7, '2024-01-24 14:09:49'),
(17, 'M', 50, 1500, 7, '2024-01-24 14:09:59'),
(18, 'XXL', 50, 1500, 7, '2024-01-24 14:10:16'),
(19, 'S', 10, 899, 8, '2024-01-24 14:10:45'),
(20, 'M', 10, 899, 8, '2024-01-24 14:10:57'),
(21, 'XL', 10, 899, 8, '2024-01-24 14:11:08'),
(22, 'XXL', 10, 899, 8, '2024-01-24 14:11:23'),
(23, 'S', 10, 1299, 9, '2024-01-24 14:11:37'),
(24, 'L', 10, 1299, 9, '2024-01-24 14:11:50'),
(25, 'XL', 10, 1299, 9, '2024-01-24 14:12:05'),
(38, 'XXL', 10, 1299, 9, '2024-01-24 14:12:18'),
(39, 'S', 10, 1199, 10, '2024-01-24 14:12:40'),
(40, 'M', 10, 1199, 10, '2024-01-24 14:12:52'),
(41, 'M', 10, 1199, 10, '2024-01-24 14:13:06');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_users`
--

DROP TABLE IF EXISTS `tbl_users`;
CREATE TABLE IF NOT EXISTS `tbl_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fname` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lname` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tbl_users`
--

INSERT INTO `tbl_users` (`id`, `fname`, `lname`, `email`, `secret`) VALUES
(1, 'john', 'patil', 'john@gmail.com', '$2b$12$.3e9yMxmMO4ECtzsOetx2OSEhuI2lVdy7bfZ4pe/ZnWzCJNWFFGh.'),
(2, 'onkar', 'savaratkar', 'onkar@gmail.com', '$2b$12$YvMzUvm2YoQcQuHSgLkfVuryEcPDrirgjk8na5nIBOdWCpni1.xAK'),
(3, 'rajdeep', 'jadhav', 'rajdeep@gmail.com', '$2b$12$TcN6.WgJDe4lJbiZSIYsSuCscb4cqNN3W9GchiDTLupu9Rx5qZjG.'),
(4, 'Sam', 'patil', 'sam@gmail.com', '$2b$12$XHnY74Trow7NjmPCNupgGuUkP02x3akfUYyREQ16MHAWXhQMCSWwK');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `pimage`
--
ALTER TABLE `pimage`
  ADD CONSTRAINT `pimage_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `pmain` (`pid`);

--
-- Constraints for table `pspecification`
--
ALTER TABLE `pspecification`
  ADD CONSTRAINT `pspecification_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `pmain` (`pid`);

--
-- Constraints for table `tbl_cart`
--
ALTER TABLE `tbl_cart`
  ADD CONSTRAINT `tbl_cart_ibfk_1` FOREIGN KEY (`spec_id`) REFERENCES `tbl_specifications` (`id`);

--
-- Constraints for table `tbl_specifications`
--
ALTER TABLE `tbl_specifications`
  ADD CONSTRAINT `tbl_specifications_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `pmain` (`pid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
