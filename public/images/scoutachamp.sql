-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: May 02, 2018 at 05:03 PM
-- Server version: 10.1.10-MariaDB
-- PHP Version: 7.0.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `scoutachamp`
--

-- --------------------------------------------------------

--
-- Table structure for table `agent_details`
--

CREATE TABLE `agent_details` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `f_name` varchar(255) NOT NULL,
  `l_name` varchar(255) NOT NULL,
  `bio` varchar(255) NOT NULL,
  `registered` tinyint(1) NOT NULL,
  `dp` varchar(255) DEFAULT NULL,
  `agency_name` varchar(255) DEFAULT NULL,
  `natonality` varchar(50) NOT NULL,
  `region` varchar(50) NOT NULL,
  `country` varchar(50) NOT NULL,
  `skype` varchar(50) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `address` varchar(255) NOT NULL,
  `website` varchar(50) NOT NULL,
  `access` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `intermediaries`
--

CREATE TABLE `intermediaries` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `f_name` varchar(200) NOT NULL,
  `l_name` varchar(200) NOT NULL,
  `bio` text NOT NULL,
  `registered` tinyint(1) NOT NULL DEFAULT '0',
  `phone` varchar(25) NOT NULL,
  `skype` varchar(200) NOT NULL,
  `website` varchar(150) NOT NULL,
  `address` text NOT NULL,
  `region` varchar(100) NOT NULL,
  `country` varchar(100) NOT NULL,
  `nationality` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `reciever_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `status` tinyint(2) NOT NULL DEFAULT '0',
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `ntype` tinyint(2) NOT NULL,
  `msg` text NOT NULL,
  `status` tinyint(12) NOT NULL DEFAULT '0',
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `player_details`
--

CREATE TABLE `player_details` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `f_name` varchar(255) NOT NULL,
  `l_name` varchar(255) NOT NULL,
  `dp` varchar(255) DEFAULT NULL,
  `phone` varchar(25) NOT NULL,
  `gender` tinyint(1) NOT NULL,
  `country` varchar(50) NOT NULL,
  `height` varchar(50) NOT NULL,
  `weight` varchar(50) NOT NULL,
  `foot` tinyint(1) NOT NULL,
  `position` int(11) NOT NULL,
  `promo_video` varchar(255) NOT NULL,
  `press` varchar(255) NOT NULL,
  `salary` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `player_photos`
--

CREATE TABLE `player_photos` (
  `id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `photo` varchar(255) NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `skills`
--

CREATE TABLE `skills` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `skills`
--

INSERT INTO `skills` (`id`, `name`, `date_added`) VALUES
(1, 'Aggression', '2018-05-01 16:05:09'),
(2, 'Anticipation', '2018-05-01 16:05:09'),
(3, 'Command of Area', '2018-05-01 16:05:09'),
(4, 'Leadership', '2018-05-01 16:05:09'),
(5, 'Creativity', '2018-05-01 16:05:09'),
(6, 'Crossing', '2018-05-01 16:05:09'),
(7, 'Dribbling', '2018-05-01 16:05:09'),
(8, 'Finishing', '2018-05-01 16:05:09'),
(9, 'Free Kick Taking', '2018-05-01 16:05:09'),
(10, 'Heading', '2018-05-01 16:05:09'),
(11, 'Long Balls', '2018-05-01 16:05:09'),
(12, 'Marking', '2018-05-01 16:05:09'),
(13, 'Natural Fitness', '2018-05-01 16:05:09'),
(14, 'Pace/Speed', '2018-05-01 16:05:09'),
(15, 'Passing', '2018-05-01 16:05:09'),
(16, 'Reflexes', '2018-05-01 16:05:09'),
(17, 'Tackling', '2018-05-01 16:05:09'),
(18, 'Teamwork', '2018-05-01 16:05:09'),
(19, 'Technique', '2018-05-01 16:05:09');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `u_type` tinyint(1) NOT NULL,
  `date_registered` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_login` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_logout` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `access` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user_verify`
--

CREATE TABLE `user_verify` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `token` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `agent_details`
--
ALTER TABLE `agent_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `intermediaries`
--
ALTER TABLE `intermediaries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `player_details`
--
ALTER TABLE `player_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `player_photos`
--
ALTER TABLE `player_photos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `skills`
--
ALTER TABLE `skills`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_verify`
--
ALTER TABLE `user_verify`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `agent_details`
--
ALTER TABLE `agent_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `intermediaries`
--
ALTER TABLE `intermediaries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `player_details`
--
ALTER TABLE `player_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `player_photos`
--
ALTER TABLE `player_photos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `skills`
--
ALTER TABLE `skills`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `user_verify`
--
ALTER TABLE `user_verify`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
