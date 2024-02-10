-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 09, 2024 at 03:16 PM
-- Server version: 8.0.28
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `project`
--

-- --------------------------------------------------------

--
-- Table structure for table `addtocart`
--

CREATE TABLE `addtocart` (
  `id` int NOT NULL,
  `pid` int DEFAULT NULL,
  `pname` varchar(40) DEFAULT NULL,
  `price` int DEFAULT NULL,
  `size` varchar(10) DEFAULT NULL,
  `colour` varchar(10) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `addtocart`
--

INSERT INTO `addtocart` (`id`, `pid`, `pname`, `price`, `size`, `colour`, `date`, `email`) VALUES
(102, 3, 'Relax fit t-shirt', 699, 'M', 'brown', '2024-02-08 07:55:41', 'sam@gmail.com'),
(103, 3, 'Relax fit t-shirt', 699, 'S', 'brown', '2024-02-08 07:56:57', 'sam@gmail.com'),
(105, 8, 'Oversized Sweatshirt', 899, 'S', 'brown', '2024-02-08 17:50:33', 'onkar@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `pdetail`
--

CREATE TABLE `pdetail` (
  `id` int NOT NULL,
  `pid` int NOT NULL,
  `size` varchar(30) NOT NULL,
  `quantity` int NOT NULL,
  `price` int NOT NULL,
  `date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pdetail`
--

INSERT INTO `pdetail` (`id`, `pid`, `size`, `quantity`, `price`, `date`) VALUES
(2, 3, 'L', 10, 699, '2023-12-30 13:13:42'),
(3, 7, 'XL', 50, 1500, '2023-12-31 15:16:31'),
(4, 8, 'L', 60, 899, '2023-12-31 15:16:53'),
(5, 9, 'M', 80, 1299, '2023-12-31 15:17:19'),
(6, 10, 'XXL', 50, 1199, '2023-12-31 15:17:36'),
(7, 11, 'S', 50, 1499, '2023-12-31 15:17:50'),
(8, 12, 'S', 50, 899, '2024-01-03 12:27:31'),
(15, 2, 'M', 10, 999, '2024-01-11 17:15:34'),
(17, 2, 'L', 10, 999, '2024-01-12 04:32:05'),
(18, 2, 'XL', 10, 999, '2024-01-12 04:32:15'),
(19, 2, 'S', 10, 999, '2024-01-12 04:32:47'),
(21, 3, 'S', 10, 699, '2024-01-24 14:07:53'),
(24, 3, 'M', 10, 699, '2024-01-24 14:09:09'),
(25, 3, 'XL', 10, 699, '2024-01-24 14:09:17'),
(26, 3, 'XXL', 10, 699, '2024-01-24 14:09:25'),
(27, 7, 'S', 50, 1500, '2024-01-24 14:09:49'),
(28, 7, 'M', 50, 1500, '2024-01-24 14:09:59'),
(30, 7, 'XXL', 50, 1500, '2024-01-24 14:10:16'),
(31, 8, 'S', 10, 899, '2024-01-24 14:10:45'),
(32, 8, 'M', 10, 899, '2024-01-24 14:10:57'),
(33, 8, 'XL', 10, 899, '2024-01-24 14:11:08'),
(34, 8, 'XXL', 10, 899, '2024-01-24 14:11:23'),
(35, 9, 'S', 10, 1299, '2024-01-24 14:11:37'),
(36, 9, 'L', 10, 1299, '2024-01-24 14:11:50'),
(37, 9, 'XL', 10, 1299, '2024-01-24 14:12:05'),
(38, 9, 'XXL', 10, 1299, '2024-01-24 14:12:18'),
(39, 10, 'S', 10, 1199, '2024-01-24 14:12:40'),
(40, 10, 'M', 10, 1199, '2024-01-24 14:12:52'),
(41, 10, 'M', 10, 1199, '2024-01-24 14:13:06');

-- --------------------------------------------------------

--
-- Table structure for table `pimage`
--

CREATE TABLE `pimage` (
  `id` int NOT NULL,
  `pid` int NOT NULL,
  `imgpath` varchar(60) NOT NULL,
  `date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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

CREATE TABLE `pmain` (
  `pid` int NOT NULL,
  `pname` varchar(70) NOT NULL,
  `date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` int NOT NULL,
  `subcat_id` int DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` text,
  `price` decimal(10,2) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `subcat_id`, `name`, `description`, `price`, `image_url`) VALUES
(1, 1, 'Relaxed Fit Jersey top T-shirt', 'Top in soft cotton jersey with a Relaxed fit with long sleeves.', 1299.00, 'images/relfit-longsleeve-tshirt.jpeg'),
(2, 1, 'Regular Fit Jersey top T-shirt', 'Regular-fit top in soft cotton jersey with round neckline and long sleeves.', 999.00, 'images/regfit-longsleeve-tshirt.jpeg'),
(3, 2, 'Slim Fit Polo T-shirt', 'Slim-fit polo shirt in soft cotton jersey,', 899.00, 'images/slimfit-polo-tshirt.jpeg'),
(4, 2, 'Regular Fit Polo T-shirt', 'Polo shirt in soft, fine-knit cotton.', 1499.00, 'images/regfit-polo-tshirt.jpeg'),
(5, 3, 'Regular Fit Oxford shirt', 'Regular-fit shirt in Oxford cotton with a button-down collar.', 1399.00, 'images/regfit-casual-shirt.jpeg'),
(6, 3, 'Relaxed Fit Corduroy shirt', 'Relaxed-fit shirt in soft cotton corduroy.', 1499.00, 'images/relfit-casual-shirt.jpeg'),
(7, 4, 'Loose Fit Short-sleeved shirt', 'Short-sleeved shirt in a printed cotton weave.', 1199.00, 'images/loosefit-short-shirt.jpeg'),
(8, 4, 'Relaxed Fit Short-sleeved shirt', 'Relaxed-fit shirt in a cotton weave with a turn-down collar.', 999.00, 'images/relfit-short-shirt.jpeg'),
(9, 5, 'Regular Fit Ripstop joggers', 'Regular-fit joggers in a hard-wearing ripstop weave.', 1999.00, 'images/regfit-joggers-trousers.jpeg'),
(10, 5, 'Skinny Fit Nylon cargo joggers', 'Joggers in stretch nylon. Skinny fit with covered elastication. ', 1799.00, 'images/skinfit-joggers-trousers.jpeg'),
(11, 6, 'Baggy Fit Cargo trousers', 'Baggy-fit cargo trousers in rigid denim cotton.', 1899.00, 'images/baggyfit-cargo-trousers.jpeg'),
(12, 6, 'Relaxed Fit Cargo trousers', 'Relaxed-fit cargo trousers in a cotton weave.', 1999.00, 'images/regfit-cargo-trousers.jpeg'),
(13, 7, 'Relaxed Jeans', '5-pocket jeans in rigid cotton denim with a relaxed fit from the seat to the hem.', 1899.00, 'images/relfit-relaxed-jeans.jpeg'),
(14, 7, 'Straight Relaxed Jeans', '5-pocket jeans in rigid denim with a straight leg from the seat to the hem.', 1699.00, 'images/straight-relaxed-jeans.jpeg'),
(15, 8, 'Slim Jeans', '5-pocket jeans in cotton denim with a slight stretch for good comfort.', 1799.00, 'images/slimfit1-slim-jeans.jpeg'),
(16, 8, 'Retro Slim Jeans', '5-pocket jeans in cotton denim with a slight stretch for good comfort.', 1899.00, 'images/retro-slim-jeans.jpeg'),
(17, 9, 'Relaxed Fit Hoodie', 'Relaxed fit Hoodie in sweatshirt fabric made from a cotton blend.', 1499.00, 'images/relfit-hoodie.jpeg'),
(18, 9, 'Oversized Fit hoodie', 'Oversized hoodie in sweatshirt fabric made from a cotton blend.', 1799.00, 'images/oversized-hoodie.jpeg'),
(19, 10, 'Relaxed Fit Sweatshirt', 'Relaxed fit Sweatshirt with dropped shoulders.', 1199.00, 'images/relfit-sweatshirt.jpeg'),
(20, 10, 'Loose Fit Sweatshirt', 'Loose fit Sweatshirt with dropped shoulders.', 1699.00, 'images/loosefit-sweatshirt.jpeg');

-- --------------------------------------------------------

--
-- Table structure for table `product1`
--

CREATE TABLE `product1` (
  `id` int NOT NULL,
  `pname` varchar(50) DEFAULT NULL,
  `price` int DEFAULT NULL,
  `colour` varchar(50) DEFAULT NULL,
  `size` varchar(50) DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `cdate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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

CREATE TABLE `pspecification` (
  `id` int NOT NULL,
  `pid` int NOT NULL,
  `colour` varchar(60) NOT NULL,
  `date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
-- Table structure for table `signup`
--

CREATE TABLE `signup` (
  `fname` varchar(50) DEFAULT NULL,
  `lname` varchar(50) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `pass1` varchar(50) DEFAULT NULL,
  `pass2` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `signup`
--

INSERT INTO `signup` (`fname`, `lname`, `email`, `pass1`, `pass2`) VALUES
('john', 'patil', 'john@gmail.com', '1234', '1234'),
('onkar', 'savaratkar', 'onkar@gmail.com', '1234', '1234'),
('rajdeep', 'jadhav', 'rajdeep@gmail.com', '1234', '1234'),
('Sam', 'patil', 'sam@gmail.com', '1234', '1234');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addtocart`
--
ALTER TABLE `addtocart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pid` (`pid`),
  ADD KEY `email` (`email`);

--
-- Indexes for table `pdetail`
--
ALTER TABLE `pdetail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pid` (`pid`);

--
-- Indexes for table `pimage`
--
ALTER TABLE `pimage`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pid` (`pid`);

--
-- Indexes for table `pmain`
--
ALTER TABLE `pmain`
  ADD PRIMARY KEY (`pid`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subcat_id` (`subcat_id`);

--
-- Indexes for table `product1`
--
ALTER TABLE `product1`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pspecification`
--
ALTER TABLE `pspecification`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pid` (`pid`);

--
-- Indexes for table `signup`
--
ALTER TABLE `signup`
  ADD PRIMARY KEY (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `addtocart`
--
ALTER TABLE `addtocart`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=113;

--
-- AUTO_INCREMENT for table `pdetail`
--
ALTER TABLE `pdetail`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `pimage`
--
ALTER TABLE `pimage`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `pmain`
--
ALTER TABLE `pmain`
  MODIFY `pid` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `product1`
--
ALTER TABLE `product1`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `pspecification`
--
ALTER TABLE `pspecification`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `addtocart`
--
ALTER TABLE `addtocart`
  ADD CONSTRAINT `addtocart_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `pmain` (`pid`),
  ADD CONSTRAINT `addtocart_ibfk_2` FOREIGN KEY (`email`) REFERENCES `signup` (`email`);

--
-- Constraints for table `pdetail`
--
ALTER TABLE `pdetail`
  ADD CONSTRAINT `pdetail_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `pmain` (`pid`);

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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
