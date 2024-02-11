-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Feb 11, 2024 at 07:19 AM
-- Server version: 11.2.2-MariaDB
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
  `imgpath` varchar(60) NOT NULL,
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
  `pname` varchar(70) NOT NULL,
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
  `pname` varchar(50) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `colour` varchar(50) DEFAULT NULL,
  `size` varchar(50) DEFAULT NULL,
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
-- Table structure for table `tbl_cart`
--

DROP TABLE IF EXISTS `tbl_cart`;
CREATE TABLE IF NOT EXISTS `tbl_cart` (
  `product_info` text NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tbl_cart`
--

INSERT INTO `tbl_cart` (`product_info`, `user_id`, `date`) VALUES
('[{\"spec\": 1, \"qnt\": 2},{\"spec\": 3, \"qnt\": 1}]', 1, '2024-02-11 06:35:55');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_categories`
--

DROP TABLE IF EXISTS `tbl_categories`;
CREATE TABLE IF NOT EXISTS `tbl_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` tinytext NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tbl_categories`
--

INSERT INTO `tbl_categories` (`id`, `title`, `date`) VALUES
(1, 'T-shirt', '2024-02-11 04:19:55'),
(2, 'Shirt', '2024-02-11 04:19:55'),
(3, 'Joggers', '2024-02-11 04:19:55'),
(4, 'Trousers', '2024-02-11 04:19:55'),
(5, 'Jeans', '2024-02-11 04:19:55'),
(6, 'Hoodie', '2024-02-11 04:19:55'),
(7, 'Sweatshirt', '2024-02-11 04:19:55');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_products`
--

DROP TABLE IF EXISTS `tbl_products`;
CREATE TABLE IF NOT EXISTS `tbl_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `thumbnail` tinytext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tbl_products`
--

INSERT INTO `tbl_products` (`id`, `name`, `description`, `thumbnail`) VALUES
(1, 'Relaxed Fit Jersey top T-shirt', 'Top in soft cotton jersey with a Relaxed fit with long sleeves.', 'images/Relax1.jpeg'),
(2, 'Regular Fit Jersey top T-shirt', 'Regular-fit top in soft cotton jersey with round neckline and long sleeves.', 'images/relaxp1.jpeg'),
(3, 'Relaxed Fit Full sleeve T-shirt', 'Slim-fit polo shirt in soft cotton jersey,', 'images/a1.jpeg'),
(4, 'Regular Fit Full sleeve T-shirt', 'Polo shirt in soft, fine-knit cotton.', 'images/e1.jpeg'),
(5, 'Oxford T-Shirt', 'Regular-fit shirt in Oxford cotton with a button-down collar.', 'images/regfit-casual-shirt.jpeg'),
(6, 'Relaxed Fit Corduroy shirt', 'Relaxed-fit shirt in soft cotton corduroy.', 'images/relfit-casual-shirt.jpeg'),
(7, 'Loose Fit Short-sleeved shirt', 'Short-sleeved shirt in a printed cotton weave.', 'images/loosefit-short-shirt.jpeg'),
(8, 'Relaxed Fit Short-sleeved shirt', 'Relaxed-fit shirt in a cotton weave with a turn-down collar.', 'images/relfit-short-shirt.jpeg'),
(9, 'Regular Fit Ripstop joggers', 'Regular-fit joggers in a hard-wearing ripstop weave.', 'images/regfit-joggers-trousers.jpeg'),
(10, 'Skinny Fit Nylon cargo joggers', 'Joggers in stretch nylon. Skinny fit with covered elastication. ', 'images/skinfit-joggers-trousers.jpeg'),
(11, 'Baggy Fit Cargo trousers', 'Baggy-fit cargo trousers in rigid denim cotton.', 'images/baggyfit-cargo-trousers.jpeg'),
(12, 'Relaxed Fit Cargo trousers', 'Relaxed-fit cargo trousers in a cotton weave.', 'images/regfit-cargo-trousers.jpeg'),
(13, 'Relaxed Jeans', '5-pocket jeans in rigid cotton denim with a relaxed fit from the seat to the hem.', 'images/relfit-relaxed-jeans.jpeg'),
(14, 'Straight Relaxed Jeans', '5-pocket jeans in rigid denim with a straight leg from the seat to the hem.', 'images/straight-relaxed-jeans.jpeg'),
(16, 'Retro Slim Jeans', '5-pocket jeans in cotton denim with a slight stretch for good comfort.', 'images/retro-slim-jeans.jpeg'),
(17, 'Relaxed Fit Hoodie', 'Relaxed fit Hoodie in sweatshirt fabric made from a cotton blend.', 'images/c1.jpeg'),
(18, 'Oversized Fit hoodie', 'Oversized hoodie in sweatshirt fabric made from a cotton blend.', 'images/d1.jpeg'),
(19, 'Regular Fit Hoodie', 'Relaxed fit Sweatshirt with dropped shoulders.', 'images/g1.jpeg'),
(20, 'Loose Fit Sweatshirt', 'Loose fit Sweatshirt with dropped shoulders.', 'images/loosefit-sweatshirt.jpeg');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_specifications`
--

DROP TABLE IF EXISTS `tbl_specifications`;
CREATE TABLE IF NOT EXISTS `tbl_specifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `size` varchar(30) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tbl_specifications`
--

INSERT INTO `tbl_specifications` (`id`, `size`, `quantity`, `price`, `pid`, `date`) VALUES
(1, 'S', 10, 899, 1, '2023-12-30 07:43:42'),
(2, 'M', 10, 999, 1, '2023-12-31 09:46:31'),
(3, 'L', 10, 1199, 1, '2023-12-31 09:46:53'),
(4, 'XL', 10, 1299, 1, '2023-12-31 09:47:19'),
(5, 'XXL', 10, 1599, 1, '2023-12-31 09:47:36'),
(6, 'S', 10, 1499, 17, '2023-12-31 09:47:50'),
(7, 'M', 10, 1499, 17, '2024-01-03 06:57:31'),
(8, 'L', 10, 1599, 17, '2024-01-11 11:45:34'),
(9, 'XL', 10, 1699, 17, '2024-01-11 23:02:05'),
(10, 'XXL', 10, 1999, 17, '2024-01-11 23:02:15'),
(11, 'S', 10, 999, 2, '2024-01-11 23:02:47'),
(12, 'M', 10, 699, 2, '2024-01-24 08:37:53'),
(13, 'L', 10, 699, 2, '2024-01-24 08:39:09'),
(14, 'XL', 10, 699, 2, '2024-01-24 08:39:17'),
(15, 'XXL', 10, 699, 2, '2024-01-24 08:39:25'),
(16, 'S', 10, 1500, 3, '2024-01-24 08:39:49'),
(17, 'M', 10, 1500, 3, '2024-01-24 08:39:59'),
(18, 'XXL', 10, 1500, 3, '2024-01-24 08:40:16'),
(19, 'S', 10, 899, 4, '2024-01-24 08:40:45'),
(20, 'M', 10, 899, 4, '2024-01-24 08:40:57'),
(21, 'XL', 10, 899, 4, '2024-01-24 08:41:08'),
(22, 'XXL', 10, 899, 4, '2024-01-24 08:41:23'),
(23, 'S', 10, 1299, 19, '2024-01-24 08:41:37'),
(24, 'L', 10, 1299, 19, '2024-01-24 08:41:50'),
(25, 'XL', 10, 1299, 19, '2024-01-24 08:42:05'),
(38, 'XXL', 10, 1299, 19, '2024-01-24 08:42:18'),
(39, 'S', 10, 1199, 18, '2024-01-24 08:42:40'),
(40, 'M', 10, 1199, 18, '2024-01-24 08:42:52'),
(41, 'L', 10, 1199, 18, '2024-01-24 08:43:06');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_users`
--

DROP TABLE IF EXISTS `tbl_users`;
CREATE TABLE IF NOT EXISTS `tbl_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fname` varchar(50) NOT NULL,
  `lname` varchar(50) NOT NULL,
  `email` tinytext NOT NULL,
  `secret` tinytext NOT NULL,
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
-- Constraints for table `tbl_cart`
--
ALTER TABLE `tbl_cart`
  ADD CONSTRAINT `tbl_cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `tbl_users` (`id`);

--
-- Constraints for table `tbl_specifications`
--
ALTER TABLE `tbl_specifications`
  ADD CONSTRAINT `tbl_specifications_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `tbl_products` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
