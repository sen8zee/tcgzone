-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 20, 2026 at 01:39 PM
-- Server version: 8.0.43
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tcgzone`
--

-- --------------------------------------------------------

--
-- Table structure for table `cancel_requests`
--

CREATE TABLE `cancel_requests` (
  `cancel_request_id` int NOT NULL,
  `order_id` int NOT NULL,
  `reason` enum('Better Price Elsewhere','Unforeseen Financial Circumstances','Emergency/Unexpected Changes') NOT NULL,
  `status` enum('Pending','Approved','Rejected') NOT NULL DEFAULT 'Pending',
  `requested_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cancel_requests`
--

INSERT INTO `cancel_requests` (`cancel_request_id`, `order_id`, `reason`, `status`, `requested_at`) VALUES
(3, 1010, 'Unforeseen Financial Circumstances', 'Approved', '2026-07-19 18:15:27');

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `cart_id` int NOT NULL,
  `user_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`cart_id`, `user_id`, `created_at`, `updated_at`) VALUES
(5000, 4, '2026-07-18 09:26:42', '2026-07-18 10:58:24'),
(5001, 1, '2026-07-18 12:49:48', '2026-07-19 14:29:25'),
(5002, 5, '2026-07-19 09:06:10', '2026-07-19 10:14:52');

-- --------------------------------------------------------

--
-- Table structure for table `cart_items`
--

CREATE TABLE `cart_items` (
  `cart_item_id` int NOT NULL,
  `cart_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `order_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `payment_method` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `order_status` enum('Pending','Processing','In Transit','Delivered','Cancelled') COLLATE utf8mb4_general_ci DEFAULT NULL,
  `total_amount` decimal(15,2) DEFAULT NULL,
  `house_no_street` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `city` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `province` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `zip_code` varchar(20) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `user_id`, `order_date`, `payment_method`, `order_status`, `total_amount`, `house_no_street`, `city`, `province`, `zip_code`) VALUES
(1005, 1, '2026-07-19 08:37:03', 'cod', 'Delivered', 2203.06, 'Lapidario', 'Trece Martires City', 'Cavite', '4109'),
(1006, 1, '2026-07-19 08:48:15', 'cod', 'Delivered', 73600.25, 'Brgy. Lapidario', 'Trece Martires City', 'Cavite', '4109'),
(1010, 5, '2026-07-19 10:14:40', 'cod', 'Cancelled', 638.00, 'Trece Martires City', 'Cavite', 'Manila', '4109'),
(1011, 5, '2026-07-19 10:15:10', 'cod', 'Delivered', 95.00, 'Trece Martires City', 'Cavite', 'Manila', '4109'),
(1012, 1, '2026-07-19 14:29:38', 'cod', 'Delivered', 63.72, 'Trece Martires City', 'Trece Martires City', 'Cavite', '4109');

-- --------------------------------------------------------

--
-- Table structure for table `orders_admin`
--

CREATE TABLE `orders_admin` (
  `id` int NOT NULL,
  `customer_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `order_date` date DEFAULT NULL,
  `status` enum('Pending','Processing','In Transit','Delivered','Cancelled') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Pending',
  `user_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders_admin`
--

INSERT INTO `orders_admin` (`id`, `customer_name`, `product_id`, `quantity`, `total`, `order_date`, `status`, `user_id`) VALUES
(68, 'Online Customer', 1, 2, 330.00, '2026-07-01', 'Delivered', 1),
(69, 'Online Customer', 3, 1, 155.00, '2026-07-02', 'Delivered', 1),
(70, 'Online Customer', 6, 2, 380.00, '2026-07-03', 'Delivered', 1),
(71, 'Online Customer', 5, 1, 180.00, '2026-07-04', 'Delivered', 1),
(72, 'Online Customer', 8, 2, 170.00, '2026-07-05', 'Delivered', 1);

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `order_item_id` int NOT NULL,
  `order_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `unit_price` decimal(15,2) DEFAULT NULL,
  `subtotal` decimal(15,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`order_item_id`, `order_id`, `product_id`, `quantity`, `unit_price`, `subtotal`) VALUES
(1409, 1005, 1, 1, 2203.06, 2203.06),
(1410, 1006, 2, 1, 73600.25, 73600.25),
(1414, 1010, 3, 1, 179.00, 179.00),
(1415, 1010, 7, 1, 459.00, 459.00),
(1416, 1011, 8, 1, 95.00, 95.00),
(1417, 1012, 13, 1, 63.72, 63.72);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int NOT NULL,
  `category` enum('Pokémon','Magic: The Gathering','One Piece') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `card_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `product_type` enum('Cards','Sealed','Collections','Character','Leader','Artifact','Legendary Creature','Legendary Artifact','Enchantment','Instant','Creature') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `set_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `rarity` enum('','Common','Uncommon','Rare','Ultra Rare','Secret Rare','C','UC','R','SR','SEC','L','P','SP','AA','TR','MR','M','S','U') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `condition` enum('','Mint','Near Mint','Lightly Played','Damaged') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `selling_price` decimal(15,2) NOT NULL,
  `market_price` decimal(15,2) DEFAULT NULL,
  `product_cost` decimal(15,2) DEFAULT NULL,
  `stock_quantity` int NOT NULL DEFAULT '0',
  `image` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `category`, `card_name`, `product_type`, `set_name`, `rarity`, `condition`, `selling_price`, `market_price`, `product_cost`, `stock_quantity`, `image`, `created_at`) VALUES
(1, 'Pokémon', 'Clefairy — 094/088', 'Cards', 'ME03: Perfect Order\r\n', 'Rare', 'Near Mint', 2203.06, 2050.70, 2060.50, 5, '/tcgzone/assets/images/landing page/image 3.png', '2026-07-17 09:00:52'),
(2, 'Pokémon', 'Rayquaza VMAX (Alternate Art Secret)', 'Cards', 'SWSH07: Evolving Skies', 'Secret Rare', 'Mint', 73600.25, 70167.70, 72700.32, 1, '../../assets/images/landing page/image 4.png', '2026-07-17 09:48:15'),
(3, 'One Piece', 'Monkey.D.Luffy', 'Character', 'Romance Dawn (OP-01)', 'SR', 'Damaged', 179.00, 205.00, 155.65, 6, '/tcgzone/assets/images/landing page/luffy-secret.jpg', '2026-07-18 16:16:04'),
(4, 'Magic: The Gathering', 'Ragavan, Nimble Pilferer', 'Legendary Creature', 'Modern Horizons 2', 'M', 'Mint', 2299.00, 2499.00, 1839.20, 3, '/tcgzone/assets/images/landing page/ragavan.jpg', '2026-07-18 16:30:18'),
(5, 'Pokémon', 'Gengar', 'Cards', 'Fossil', 'Rare', 'Mint', 26.68, 15.60, 24.25, 1, '/tcgzone/assets/images/landing page/gengar-rare.jpg', '2026-07-18 16:30:18'),
(6, 'Pokémon', 'Mega Lopunny & Jigglypuff GX (Secret)', 'Cards', 'Cosmic Eclipse', 'Secret Rare', 'Lightly Played', 79.39, 67.98, 72.17, 1, '/tcgzone/assets/images/landing page/image 10.png', '2026-07-18 16:30:18'),
(7, 'One Piece', 'Trafalgar Law', 'Character', 'Premium Booster PRB 02', 'SR', 'Damaged', 459.00, 499.00, 399.13, 2, '/tcgzone/assets/images/landing page/traf1.jpg', '2026-07-18 16:30:18'),
(8, 'Magic: The Gathering', 'Sol Ring', 'Artifact', 'Commander Masters', 'U', 'Lightly Played', 95.00, 110.00, 86.36, 9, '/tcgzone/assets/images/landing page/solring.jpg', '2026-07-18 16:30:18'),
(9, 'Pokémon', 'Mega Charizard X ex', 'Cards', 'Phantasmal Flames', 'Ultra Rare', 'Mint', 1299.99, 850.31, 1039.99, 2, '/tcgzone/assets/images/landing page/image 6.png', '2026-07-18 16:30:18'),
(10, 'Pokémon', 'Mega Greninja ex', 'Cards', 'Chaos Rising', 'Ultra Rare', 'Lightly Played', 353.76, 246.83, 307.62, 2, '/tcgzone/assets/images/landing page/image 11.png', '2026-07-18 16:30:18'),
(11, 'Magic: The Gathering', 'Birds of Paradise', 'Creature', 'Ravnica Remastered', 'R', 'Damaged', 799.00, 849.00, 665.83, 4, '/tcgzone/assets/images/landing page/birds.jpg', '2026-07-18 16:45:42'),
(12, 'Magic: The Gathering', 'Sheoldred, the Apocalypse', 'Legendary Creature', 'Dominaria United', 'M', 'Damaged', 4599.00, 4899.00, 3679.20, 2, '/tcgzone/assets/images/landing page/sheoldred.jpg', '2026-07-18 16:46:09'),
(13, 'Pokémon', 'Gengar VMAX', 'Cards', 'Fusion Strike', 'Ultra Rare', 'Mint', 63.72, 34.30, 57.93, 13, '/tcgzone/assets/images/landing page/image 9.png', '2026-07-18 16:46:09'),
(14, 'Pokémon', 'Mew ex', 'Cards', 'Paldean Fates', 'Ultra Rare', 'Mint', 1015.00, 1064.41, 812.00, 0, '/tcgzone/assets/images/landing page/image 12.png', '2026-07-18 16:46:09'),
(15, 'Pokémon', 'Mimikyu (Secret)', 'Cards', 'Cosmic Eclipse', 'Secret Rare', 'Damaged', 63.03, 60.73, 57.30, 3, '/tcgzone/assets/images/landing page/mimikyu-secret.jpg', '2026-07-18 16:46:09'),
(16, 'One Piece', 'Otama', 'Character', 'Romance Dawn (OP 01)', 'UC', 'Near Mint', 39.00, 45.00, 35.45, 12, '/tcgzone/assets/images/landing page/otama1.jpg', '2026-07-18 16:46:09'),
(17, 'Pokémon', '151 Booster Pack', 'Sealed', 'Scarlet & Violet 151', '', '', 50.00, 29.34, 45.45, 10, '/tcgzone/assets/images/landing page/151-boost.jpg', '2026-07-18 16:47:53'),
(18, 'One Piece', 'Portgas.D.Ace', 'Character', 'The Time of Battle (OP16)', 'SR', 'Mint', 395.00, 430.00, 343.48, 2, '/tcgzone/assets/images/landing page/ace1.jpg', '2026-07-18 16:48:08'),
(19, 'One Piece', 'Nico Robin', 'Character', 'Romance Dawn (OP 01)', 'C', 'Mint', 35.00, 40.00, 31.82, 15, '/tcgzone/assets/images/landing page/nico1.jpg', '2026-07-18 16:48:08'),
(20, 'Magic: The Gathering', 'Doubling Season', 'Enchantment', 'Wilds of Eldraine: Enchanting Tales', 'M', 'Near Mint', 3699.00, 3899.00, 2959.20, 2, '/tcgzone/assets/images/landing page/doubling.jpg', '2026-07-18 16:48:08'),
(21, 'Pokémon', 'Ditto', 'Cards', 'Skyridge', 'Common', 'Near Mint', 110.00, 78.66, 95.65, 3, '/tcgzone/assets/images/landing page/ditto.jpg', '2026-07-18 16:48:08'),
(22, 'Pokémon', 'White Flare Booster Pack', 'Sealed', 'White Flare', '', '', 17.99, 15.63, 16.35, 13, '/tcgzone/assets/images/landing page/white-boost.jpg', '2026-07-18 16:48:08'),
(23, 'One Piece', 'Sanji', 'Character', 'Romance Dawn (OP 01)', 'UC', 'Mint', 65.00, 79.00, 59.09, 8, '/tcgzone/assets/images/landing page/sanji1.jpg', '2026-07-18 16:48:08'),
(24, 'Pokémon', 'Psyduck', 'Cards', 'Ascended Heroes', 'Common', 'Lightly Played', 3.00, 0.30, 2.73, 20, '/tcgzone/assets/images/landing page/psyduck-com.jpg', '2026-07-18 16:48:08'),
(25, 'Pokémon', 'Snorlax', 'Cards', 'Scarlet & Violet 151', 'Uncommon', 'Damaged', 1.95, 0.25, 1.77, 15, '/tcgzone/assets/images/landing page/snorlax-un.jpg', '2026-07-18 16:48:08'),
(26, 'Magic: The Gathering', 'Black Lotus', 'Artifact', 'Limited Edition Alpha', 'R', 'Near Mint', 2500000.00, 3000000.00, 1785714.29, 1, '/tcgzone/assets/images/landing page/blacklotus.jpg', '2026-07-18 16:48:08'),
(27, 'Magic: The Gathering', 'Serra Angel', 'Creature', 'Foundations', 'U', 'Mint', 59.00, 70.00, 53.64, 8, '/tcgzone/assets/images/landing page/serra.jpg', '2026-07-18 16:48:08'),
(28, 'Pokémon', 'Black Bolt Booster Pack', 'Sealed', 'Black Bolt', '', '', 19.99, 15.58, 18.17, 18, '/tcgzone/assets/images/landing page/black-boost.jpg', '2026-07-18 16:48:08'),
(29, 'Magic: The Gathering', 'Lightning Bolt', 'Instant', 'Magic 2010', 'C', 'Near Mint', 120.00, 140.00, 104.35, 12, '/tcgzone/assets/images/landing page/bolt.jpg', '2026-07-18 16:48:08'),
(30, 'Magic: The Gathering', 'The One Ring', 'Legendary Artifact', 'The Lord of the Rings: Tales of Middle earth', 'M', 'Mint', 4199.00, 4499.00, 3359.20, 2, '/tcgzone/assets/images/landing page/ring.jpg', '2026-07-18 16:48:08'),
(31, 'Pokémon', 'Zekrom ex', 'Cards', 'Black Bolt', 'Ultra Rare', 'Near Mint', 380.00, 543.00, 330.43, 5, '/tcgzone/assets/images/landing page/image 2.png', '2026-07-18 16:48:08'),
(32, 'Pokémon', 'Magikarp', 'Cards', 'Base Set', 'Uncommon', 'Damaged', 49.99, 23.81, 45.45, 5, '/tcgzone/assets/images/landing page/magikarp-un.jpg', '2026-07-18 16:48:08'),
(33, 'Magic: The Gathering', 'Omniscience', 'Enchantment', 'Core Set 2021', 'M', 'Mint', 1699.00, 1799.00, 1359.20, 2, '/tcgzone/assets/images/landing page/omni.jpg', '2026-07-18 16:48:08'),
(34, 'One Piece', 'Monkey.D.Luffy', 'Character', 'Paramount War (OP 02)', 'R', 'Lightly Played', 119.00, 138.00, 103.48, 5, '/tcgzone/assets/images/landing page/luffy2.jpg', '2026-07-18 16:48:08'),
(35, 'Pokémon', 'Umbreon ex', 'Cards', 'Prismatic Evolutions', 'Ultra Rare', 'Near Mint', 1099.01, 1503.91, 879.21, 1, '/tcgzone/assets/images/landing page/image 7.png', '2026-07-18 16:48:08'),
(36, 'Pokémon', 'Kabuto', 'Cards', 'Fossil', 'Common', 'Damaged', 34.32, 22.58, 31.20, 14, '/tcgzone/assets/images/landing page/kabuto-com.jpg', '2026-07-18 16:48:08'),
(37, 'One Piece', 'Nami', 'Character', 'Paramount War (OP 02)', 'SR', 'Near Mint', 289.00, 325.00, 251.30, 3, '/tcgzone/assets/images/landing page/nami2.jpg', '2026-07-18 16:48:08'),
(38, 'One Piece', 'Nami', 'Character', 'Romance Dawn (OP 01)', 'R', 'Mint', 89.00, 99.00, 80.91, 10, '/tcgzone/assets/images/landing page/nami1.jpg', '2026-07-18 16:48:08'),
(39, 'Pokémon', 'Pikachu ex', 'Cards', 'Ascended Heroes', 'Rare', 'Lightly Played', 1599.99, 1231.86, 1279.99, 7, '/tcgzone/assets/images/landing page/image 8.png', '2026-07-18 16:48:08'),
(40, 'One Piece', 'Roronoa Zoro', 'Leader', 'Romance Dawn (OP 01)', 'L', 'Near Mint', 249.00, 279.00, 216.52, 5, '/tcgzone/assets/images/landing page/zoro1.jpg', '2026-07-18 16:50:53'),
(41, 'Pokémon', 'Mega Zygarde ex Premium Collection', 'Collections', '', '', '', 4023.00, 3880.30, 3890.20, 8, '/tcgzone/assets/images/landing page/image 18.png', '2026-07-18 18:22:12'),
(42, 'Pokémon', 'Greninja ex Special Illustration Collection', 'Collections', 'SV: Shrouded Fable', '', '', 15039.15, 11650.00, 12300.60, 3, '/tcgzone/assets/images/landing page/image  19.png', '2026-07-18 18:22:18'),
(43, 'Pokémon', '2 Pack Blister Pack [Team Rocket\'s Articuno, Zapdos & Tyranitar]', 'Collections', '', '', '', 2500.25, 2300.50, 2350.75, 10, '/tcgzone/assets/images/landing page/image 20.jpg', '2026-07-18 18:22:18'),
(44, 'Pokémon', 'Espeon GX Premium Collection', 'Collections', 'SM   Guardians Rising', '', '', 75650.80, 74000.23, 74200.50, 1, '/tcgzone/assets/images/landing page/image 21.png', '2026-07-18 18:22:18'),
(45, 'Pokémon', 'Paldean Fates Great Tusk ex & Iron Treads ex Premium Collection', 'Collections', 'SV: Paldean Fates', '', '', 67850.30, 65000.70, 62000.80, 3, '/tcgzone/assets/images/landing page/image 22.png', '2026-07-18 18:22:18');

-- --------------------------------------------------------

--
-- Table structure for table `products_admin`
--

CREATE TABLE `products_admin` (
  `id` int NOT NULL,
  `product_name` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `category` varchar(80) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `stock` int DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products_admin`
--

INSERT INTO `products_admin` (`id`, `product_name`, `category`, `price`, `stock`) VALUES
(1, 'Pokemon Booster Box', 'Pokemon', 6500.00, 25),
(2, 'One Piece OP-05', 'One Piece', 5500.00, 10),
(3, 'YuGiOh Tin', 'YuGiOh', 2200.00, 0),
(4, 'MTG Commander Deck', 'Magic', 2800.00, 4),
(5, 'Pokemon ETB', 'Pokemon', 3200.00, 0),
(6, 'OP-06 Booster Box', 'One Piece', 6200.00, 20),
(7, 'MTG Booster Pack', 'Magic', 450.00, 100),
(8, 'YuGiOh Structure Deck', 'YuGiOh', 700.00, 35),
(9, 'Scarlet & Violet Booster Box', 'Pokemon', 165.00, 20),
(10, 'Paldea Evolved Booster Box', 'Pokemon', 170.00, 18),
(11, 'Obsidian Flames Booster Box', 'Pokemon', 155.00, 25),
(12, 'Paradox Rift Booster Box', 'Pokemon', 175.00, 20),
(13, 'Temporal Forces Booster Box', 'Pokemon', 180.00, 22),
(14, 'Twilight Masquerade Booster Box', 'Pokemon', 190.00, 18),
(15, 'Surging Sparks Booster Box', 'Pokemon', 200.00, 15),
(16, 'Pokemon 151 Elite Trainer Box', 'Pokemon', 85.00, 40),
(17, 'Crown Zenith Elite Trainer Box', 'Pokemon', 70.00, 35),
(18, 'Shining Fates Elite Trainer Box', 'Pokemon', 65.00, 30),
(19, 'Charizard ex Premium Collection', 'Pokemon', 120.00, 25),
(20, 'Arceus VSTAR Ultra Premium Collection', 'Pokemon', 130.00, 18),
(21, 'Celebrations Ultra Premium Collection', 'Pokemon', 400.00, 12),
(22, 'Pokemon GO Elite Trainer Box', 'Pokemon', 55.00, 25),
(23, 'Brilliant Stars Booster Box', 'Pokemon', 185.00, 20),
(24, 'Fusion Strike Booster Box', 'Pokemon', 220.00, 16),
(25, 'Lost Origin Booster Box', 'Pokemon', 210.00, 15),
(26, 'Silver Tempest Booster Box', 'Pokemon', 175.00, 18),
(27, 'Astral Radiance Booster Box', 'Pokemon', 185.00, 16),
(28, 'Evolving Skies Booster Box', 'Pokemon', 900.00, 10),
(29, 'Hidden Fates Elite Trainer Box', 'Pokemon', 180.00, 15),
(30, 'Champion\'s Path Elite Trainer Box', 'Pokemon', 140.00, 18),
(31, 'Charizard UPC', 'Pokemon', 150.00, 20),
(32, 'Pokemon TCG Classic', 'Pokemon', 400.00, 8),
(33, 'Trainer\'s Toolkit 2024', 'Pokemon', 45.00, 30);

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT 'Anonymous',
  `rating` tinyint UNSIGNED NOT NULL,
  `review_text` text COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`id`, `user_id`, `name`, `rating`, `review_text`, `created_at`) VALUES
(1, 1, 'Zackori', 4, 'test test', '2026-07-12 13:13:58'),
(2, 1, 'Anonymous', 2, 'test test test', '2026-07-12 13:14:38');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `username` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `first_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '',
  `last_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '',
  `email` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_general_ci DEFAULT '',
  `dob` date DEFAULT NULL,
  `gender` enum('Male','Female','Other') COLLATE utf8mb4_general_ci DEFAULT 'Male',
  `address_details` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '',
  `address_city` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '',
  `address_province` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '',
  `address_zip` varchar(10) COLLATE utf8mb4_general_ci DEFAULT '',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `first_name`, `last_name`, `email`, `password_hash`, `phone`, `dob`, `gender`, `address_details`, `address_city`, `address_province`, `address_zip`, `created_at`) VALUES
(1, 'minnnjuuu', 'Zack Gregori', 'Ogena', 'mizu11th@gmail.com', '$2y$10$LKeOedvMinjEfBisqIoUGeUGCB/8j5cKNS7XimdzS5yVquyeTB3Ee', '09914846214', '2004-12-23', 'Male', 'Trece Martires City', 'Trece Martires City', 'Cavite', '4109', '2026-07-10 10:29:14'),
(2, 'lleve', '', '', 'zack3.ogena@gmail.com', '$2y$10$0c0jVFtRZAfbaxtZcCGVq.D/nkKNnFlW91T5HIgcewrjlEZxKxc96', '09914846214', NULL, 'Male', '', '', '', '', '2026-07-11 09:48:00'),
(3, 'clark', 'Clark Christopher', 'Rustique', 'clark@gmail.com', '$2y$10$MnHYcMlwEA0HOuADpHF9RuLmi2SsfH9aoEpsnqaWiwvsS77gxk9De', '09111111111', NULL, 'Male', '', '', '', '', '2026-07-11 10:17:54'),
(4, 'kjustindt', 'Kurt Justin', 'Dela Torre', 'kurt@gmail.com', '$2y$10$p/URpe7xDXMYcvFrmMB4ienHdzyK/VVltHKA8bt.RS3sM1YaStZDq', '09123456789', '2005-09-17', 'Male', '123 Pick Street', 'Denver', 'Colorado', '80216', '2026-07-17 22:01:15'),
(5, 'fias', 'Gregori', 'Ogena', 'fiasco@gmail.com', '$2y$10$UipzgJYpy9.GgOp1nwyOPelCnlaGqzFv.qHPzFZVeP6FXC22wJ1lG', '09914846214', NULL, 'Male', 'Trece Martires City', 'Cavite', 'Manila', '4109', '2026-07-19 09:05:59');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cancel_requests`
--
ALTER TABLE `cancel_requests`
  ADD PRIMARY KEY (`cancel_request_id`),
  ADD UNIQUE KEY `order_id` (`order_id`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`cart_id`),
  ADD KEY `fk_cart_users` (`user_id`);

--
-- Indexes for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD PRIMARY KEY (`cart_item_id`),
  ADD UNIQUE KEY `unique_cart_product` (`cart_id`,`product_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`order_item_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reviews_ibfk_1` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cancel_requests`
--
ALTER TABLE `cancel_requests`
  MODIFY `cancel_request_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `cart_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5003;

--
-- AUTO_INCREMENT for table `cart_items`
--
ALTER TABLE `cart_items`
  MODIFY `cart_item_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=522;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1013;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `order_item_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1418;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cancel_requests`
--
ALTER TABLE `cancel_requests`
  ADD CONSTRAINT `fk_cancel_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `fk_cart_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD CONSTRAINT `cart_items_ibfk_1` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`),
  ADD CONSTRAINT `cart_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
