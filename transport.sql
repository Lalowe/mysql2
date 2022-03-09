-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hostiteľ: localhost
-- Čas generovania: St 09.Mar 2022, 14:46
-- Verzia serveru: 10.4.21-MariaDB
-- Verzia PHP: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Databáza: `transport`
--
CREATE DATABASE IF NOT EXISTS `transport` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `transport`;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `dispo`
--

CREATE TABLE `dispo` (
  `fk_route_id` int(11) DEFAULT NULL,
  `fk_unload_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Sťahujem dáta pre tabuľku `dispo`
--

INSERT INTO `dispo` (`fk_route_id`, `fk_unload_id`) VALUES
(1, NULL),
(2, 2),
(3, 3),
(3, 4),
(4, 4),
(5, 4),
(6, 9),
(7, NULL),
(2, 2);

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `route`
--

CREATE TABLE `route` (
  `route_id` int(11) NOT NULL,
  `destination` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Sťahujem dáta pre tabuľku `route`
--

INSERT INTO `route` (`route_id`, `destination`) VALUES
(1, 'Prague'),
(2, 'Vienna'),
(3, 'Helsinki'),
(4, 'Turku'),
(5, 'Zilina'),
(6, 'Bratislava'),
(7, 'Martin'),
(8, 'Banska Bystrica'),
(9, 'Moskva'),
(10, 'Marseille');

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `truck`
--

CREATE TABLE `truck` (
  `fk_route_id` int(11) DEFAULT NULL,
  `truck_id` int(11) NOT NULL,
  `driver_name` varchar(50) DEFAULT 'not null',
  `load_capacity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Sťahujem dáta pre tabuľku `truck`
--

INSERT INTO `truck` (`fk_route_id`, `truck_id`, `driver_name`, `load_capacity`) VALUES
(1, 1, 'Vladimir', 24000),
(2, 2, 'Sergei', 22000),
(3, 3, 'Stanislav', 24000),
(4, 4, 'Marcel', 24000),
(5, 5, 'Karol', 12000),
(6, 6, 'Mistro', 24500),
(7, 7, 'Klado', 45000),
(8, 8, 'Karambo', 25000),
(9, 9, 'Marcelino', 30000),
(10, 10, 'Bob', 23700);

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `unload`
--

CREATE TABLE `unload` (
  `unload_id` int(11) NOT NULL,
  `weight` int(11) DEFAULT NULL,
  `fk_zip` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Sťahujem dáta pre tabuľku `unload`
--

INSERT INTO `unload` (`unload_id`, `weight`, `fk_zip`) VALUES
(2, 34, 1020),
(3, 24000, 1023),
(4, 20000, 1394),
(5, 21000, 1423),
(6, 21000, 1623),
(7, 9000, 2540),
(8, 29000, 14045),
(9, 22000, 15404),
(10, 10000, 15405);

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `zip`
--

CREATE TABLE `zip` (
  `zip_id` int(11) NOT NULL,
  `country` varchar(55) DEFAULT NULL,
  `city` varchar(55) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Sťahujem dáta pre tabuľku `zip`
--

INSERT INTO `zip` (`zip_id`, `country`, `city`) VALUES
(1020, 'Austria', 'Salzburg'),
(1023, 'Finland', 'Main Street'),
(1394, 'Slovakia', 'Main Street'),
(1423, 'Finland', 'Main Street'),
(1623, 'Finland', 'Main Street'),
(2540, 'Russia', 'Main Street'),
(14045, 'Slovakia', 'Main Street'),
(15404, 'Slovakia', 'Main Street'),
(15405, 'Slovakia', 'Main Street');

--
-- Kľúče pre exportované tabuľky
--

--
-- Indexy pre tabuľku `dispo`
--
ALTER TABLE `dispo`
  ADD KEY `dispo_ibfk_1` (`fk_route_id`),
  ADD KEY `dispo_ibfk_2` (`fk_unload_id`);

--
-- Indexy pre tabuľku `route`
--
ALTER TABLE `route`
  ADD PRIMARY KEY (`route_id`);

--
-- Indexy pre tabuľku `truck`
--
ALTER TABLE `truck`
  ADD PRIMARY KEY (`truck_id`),
  ADD KEY `truck_ibfk_1` (`fk_route_id`);

--
-- Indexy pre tabuľku `unload`
--
ALTER TABLE `unload`
  ADD PRIMARY KEY (`unload_id`),
  ADD KEY `fk_zip` (`fk_zip`);

--
-- Indexy pre tabuľku `zip`
--
ALTER TABLE `zip`
  ADD PRIMARY KEY (`zip_id`);

--
-- Obmedzenie pre exportované tabuľky
--

--
-- Obmedzenie pre tabuľku `dispo`
--
ALTER TABLE `dispo`
  ADD CONSTRAINT `dispo_ibfk_1` FOREIGN KEY (`fk_route_id`) REFERENCES `route` (`route_id`) ON DELETE SET NULL ON UPDATE SET NULL,
  ADD CONSTRAINT `dispo_ibfk_2` FOREIGN KEY (`fk_unload_id`) REFERENCES `unload` (`unload_id`) ON DELETE SET NULL ON UPDATE SET NULL;

--
-- Obmedzenie pre tabuľku `truck`
--
ALTER TABLE `truck`
  ADD CONSTRAINT `truck_ibfk_1` FOREIGN KEY (`fk_route_id`) REFERENCES `route` (`route_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Obmedzenie pre tabuľku `unload`
--
ALTER TABLE `unload`
  ADD CONSTRAINT `unload_ibfk_1` FOREIGN KEY (`fk_zip`) REFERENCES `zip` (`zip_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
