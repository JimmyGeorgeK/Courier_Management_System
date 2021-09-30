-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 27, 2021 at 02:22 PM
-- Server version: 10.1.38-MariaDB
-- PHP Version: 7.1.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `couriermanagmentsystem`
--

-- --------------------------------------------------------

--
-- Table structure for table `approval`
--

CREATE TABLE `approval` (
  `apid` int(11) NOT NULL,
  `apcustid` varchar(10000) NOT NULL,
  `courid` varchar(50) NOT NULL,
  `aprevname` varchar(50) NOT NULL,
  `aprevcity` varchar(50) NOT NULL,
  `aprevphone` varchar(20) NOT NULL,
  `apcourtype` varchar(20) NOT NULL,
  `apcourdate` varchar(50) NOT NULL,
  `branchid` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `approval`
--

INSERT INTO `approval` (`apid`, `apcustid`, `courid`, `aprevname`, `aprevcity`, `aprevphone`, `apcourtype`, `apcourdate`, `branchid`) VALUES
(10, '2', '5', 'jamesq', 'Mysore', '124242525', 'fsfa', '2021-01-31', '2');

-- --------------------------------------------------------

--
-- Table structure for table `bill`
--

CREATE TABLE `bill` (
  `billid` int(11) NOT NULL,
  `courid` varchar(20) NOT NULL,
  `custid` varchar(20) NOT NULL,
  `packtype` varchar(20) NOT NULL,
  `charge` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bill`
--

INSERT INTO `bill` (`billid`, `courid`, `custid`, `packtype`, `charge`) VALUES
(1, '1', '1', 'book', '500'),
(2, '2', '1', 'Book', '300');

-- --------------------------------------------------------

--
-- Table structure for table `company`
--

CREATE TABLE `company` (
  `id` int(11) NOT NULL,
  `branchemail` varchar(50) NOT NULL,
  `branchpassword` varchar(1000) NOT NULL,
  `service` varchar(50) NOT NULL,
  `branchcity` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `company`
--

INSERT INTO `company` (`id`, `branchemail`, `branchpassword`, `service`, `branchcity`) VALUES
(1, 'branch@gmail.com', 'pbkdf2:sha256:150000$4P3CaeQi$3a2c49bee81423648029391498f54bf7159c1c3e426e1be7a208294bf8c621c7', 'DTDC', 'manglore'),
(2, 'mysore@gmail.com', 'pbkdf2:sha256:150000$ZRKAdO95$df0c2368c42e89321fca79b665f18bdf5dbf13c5adad5a2129df1acb08cb46fc', 'DTDC', 'Mysore'),
(3, 'banglore@gmail.com', 'pbkdf2:sha256:150000$kz46euDQ$6b493f54344595f9d2ca7e6a316ac71d0f5e3039f825c3295e7c7a6a9a11fb54', 'DTDC', 'Banglore');

-- --------------------------------------------------------

--
-- Table structure for table `courierbooking`
--

CREATE TABLE `courierbooking` (
  `courid` int(11) NOT NULL,
  `custid` varchar(1000) NOT NULL,
  `receivername` varchar(50) NOT NULL,
  `receivercity` varchar(50) NOT NULL,
  `receiverphone` varchar(20) NOT NULL,
  `branchid` varchar(50) NOT NULL,
  `couriertype` varchar(20) NOT NULL,
  `courierweight` int(50) NOT NULL,
  `service` varchar(50) NOT NULL,
  `courierdate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `courierbooking`
--

INSERT INTO `courierbooking` (`courid`, `custid`, `receivername`, `receivercity`, `receiverphone`, `branchid`, `couriertype`, `courierweight`, `service`, `courierdate`) VALUES
(1, '1', 'James', 'Banglore', '7777777777', '3', 'book', 50, 'DTDC1', '2021-01-31'),
(2, '1', 'wge', 'manglore', '1111111111', '3', 'Book', 30, 'DTDC1', '2021-01-28');

--
-- Triggers `courierbooking`
--
DELIMITER $$
CREATE TRIGGER `bookdel` BEFORE DELETE ON `courierbooking` FOR EACH ROW INSERT INTO trigr VALUES
(null,OLD.courid,OLD.custid,OLD.receivername,OLD.receivercity,OLD.receiverphone,
OLD.branchid,OLD.couriertype, OLD.courierweight,'COURIER\r\nDELETED',OLD.service,NOW(),OLD.courierdate)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `bookins` AFTER INSERT ON `courierbooking` FOR EACH ROW INSERT INTO trigr VALUES
(null,NEW.courid,NEW.custid,NEW.receivername,NEW.receivercity,NEW.receiverphone,NEW.branchid,NEW.couriertype,NEW.courierweight,'COURIER\r\nBOOKED',NEW.service,NOW(),NEW.courierdate)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `bookup` AFTER UPDATE ON `courierbooking` FOR EACH ROW INSERT INTO trigr VALUES
(null,NEW.courid,NEW.custid,NEW.receivername,NEW.receivercity,NEW.receiverphone,NEW.branchid,NEW.couriertype,NEW.courierweight,'COURIER\r\nUPDATED',NEW.service,NOW(),NEW.courierdate)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `customeremail` varchar(50) NOT NULL,
  `customerpassword` varchar(1000) NOT NULL,
  `customercity` varchar(50) NOT NULL,
  `branchid` int(11) NOT NULL,
  `customerdob` date NOT NULL,
  `gender` varchar(50) NOT NULL,
  `customernumber` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`id`, `username`, `customeremail`, `customerpassword`, `customercity`, `branchid`, `customerdob`, `gender`, `customernumber`) VALUES
(1, 'Jimmy', 'jim@gmail.com', 'pbkdf2:sha256:150000$7ZQ9skNV$a76c12c0c70a070444ccfb5d09d6f4e36175078da26faa2d9ba41490299206d1', 'Manglore', 1, '2021-01-31', 'Male', '9483034670'),
(2, 'Anu', 'anu@gmail.com', 'pbkdf2:sha256:150000$gV2VtYmX$529f1b9c27776933797e5969963fb8c5c6c0c0bc41570b2dd005be64e2c31aa2', 'Manglore', 1, '2021-01-14', 'Female', '94830345670'),
(3, 'Azmin', 'azmin@gmail.com', 'pbkdf2:sha256:150000$yCpLw5AN$b25720c2f9b0f31271f63d640156f45cfcb2df7c712a76d94ecc8dbca83f1b1d', 'Banglore', 3, '1999-07-24', 'Female', '9483034671');

-- --------------------------------------------------------

--
-- Table structure for table `orderdetails`
--

CREATE TABLE `orderdetails` (
  `orderid` int(11) NOT NULL,
  `branchid` varchar(50) NOT NULL,
  `custid` varchar(50) NOT NULL,
  `revname` varchar(50) NOT NULL,
  `revcity` varchar(50) NOT NULL,
  `revphone` varchar(50) NOT NULL,
  `orderdate` date NOT NULL,
  `courtype` varchar(50) NOT NULL,
  `courid` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `orderdetails`
--

INSERT INTO `orderdetails` (`orderid`, `branchid`, `custid`, `revname`, `revcity`, `revphone`, `orderdate`, `courtype`, `courid`) VALUES
(1, '3', '1', 'James', 'Banglore', '7777777777', '2021-01-31', 'book', '1'),
(2, '3', '1', 'wge', 'manglore', '1111111111', '2021-01-28', 'Book', '2');

-- --------------------------------------------------------

--
-- Table structure for table `trigr`
--

CREATE TABLE `trigr` (
  `tid` int(11) NOT NULL,
  `courid` int(11) NOT NULL,
  `custid` varchar(10000) NOT NULL,
  `receivername` varchar(50) NOT NULL,
  `receivercity` varchar(50) NOT NULL,
  `receiverphone` varchar(20) NOT NULL,
  `branchid` varchar(50) NOT NULL,
  `couriertype` varchar(20) NOT NULL,
  `courierweight` int(11) NOT NULL,
  `action` varchar(50) NOT NULL,
  `service` varchar(50) NOT NULL,
  `datestamp` datetime NOT NULL,
  `courierdate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `trigr`
--

INSERT INTO `trigr` (`tid`, `courid`, `custid`, `receivername`, `receivercity`, `receiverphone`, `branchid`, `couriertype`, `courierweight`, `action`, `service`, `datestamp`, `courierdate`) VALUES
(1, 1, '1', 'james', 'manglore', '121111231', 'None', 'fsfa', 2, 'COURIER\r\nBOOKED', 'DTDC', '2021-01-24 00:50:30', '2021-01-30'),
(2, 1, '1', 'james', 'manglore', '121111231', '1', 'fsfa', 2, 'COURIER UPDATED', 'DTDC1', '2021-01-24 00:51:07', '2021-01-30'),
(3, 2, '1', 'james', 'manglore', '78868767', 'None', 'fsfa', 64654, 'COURIER\r\nBOOKED', 'DTDC1', '2021-01-24 00:58:09', '2021-01-31'),
(4, 2, '1', 'james', 'manglore', '78868767', '1', 'fsfa', 64654, 'COURIER UPDATED', 'DTDC12', '2021-01-24 00:58:39', '2021-01-31'),
(5, 3, '2', 'james', 'manglore', '112145356', '1', 'fsfa', 30, 'COURIER\r\nBOOKED', 'DTDC', '2021-01-24 01:38:31', '2021-01-23'),
(6, 3, '2', 'jamesq', 'manglore', '112145356', '1', 'fsfa', 30, 'COURIER UPDATED', 'DTDC', '2021-01-24 01:39:57', '2021-01-23'),
(7, 2, '1', 'james', 'manglore', '1111111111', '1', 'fsfa', 11, 'COURIER\r\nBOOKED', 'DTDC1', '2021-01-24 06:12:46', '2021-01-16'),
(8, 2, '1', 'james', 'manglore', '1111111111', '1', 'fsfa', 11, 'COURIER\r\nDELETED', 'DTDC1', '2021-01-24 06:13:05', '2021-01-16'),
(9, 3, '1', 'james', 'manglore', '44444444444', '1', 'fsfa', 43, 'COURIER\r\nBOOKED', 'DTDC', '2021-01-24 06:16:19', '2021-01-23'),
(10, 3, '1', 'james', 'manglore', '44444444444', '1', 'fsfa', 43, 'COURIER\r\nDELETED', 'DTDC', '2021-01-24 06:20:06', '2021-01-23'),
(11, 4, '1', 'james', 'manglore', '111111111111', '1', 'fsfa', 23, 'COURIER\r\nBOOKED', 'DTDC1', '2021-01-24 06:25:44', '2021-01-31'),
(12, 4, '1', 'james', 'manglore', '111111111111', '1', 'fsfa', 23, 'COURIER\r\nDELETED', 'DTDC1', '2021-01-24 06:26:10', '2021-01-31'),
(13, 5, '2', 'jamesq', 'Mysore', '124242525', '2', 'fsfa', 34, 'COURIER\r\nBOOKED', 'DTDC1', '2021-01-24 06:26:58', '2021-01-31'),
(14, 5, '2', 'jamesq', 'Mysore', '124242525', '2', 'fsfa', 34, 'COURIER\r\nDELETED', 'DTDC1', '2021-01-24 06:27:29', '2021-01-31'),
(15, 1, '3', 'Jimmy', 'Banglore', '9483034562', '3', 'Book', 25, 'COURIER\r\nBOOKED', 'DTDC', '2021-01-24 10:36:04', '2021-01-25'),
(16, 2, '3', 'James', 'Mysore', '2345678901', '2', 'Book', 34, 'COURIER\r\nBOOKED', 'DTDC', '2021-01-24 10:36:46', '2021-01-30'),
(17, 2, '3', 'James R', 'Manglore', '2345678900', '1', 'Books', 35, 'COURIER\r\nUPDATED', 'DTDC1', '2021-01-24 10:37:28', '2021-01-31'),
(18, 3, '3', 'james', 'Banglore', '456673244323432', '1', 'Books', 65, 'COURIER\r\nBOOKED', 'DTDC12', '2021-01-24 10:38:04', '2021-01-17'),
(19, 3, '3', 'james', 'Banglore', '456673244323432', '1', 'Books', 65, 'COURIER\r\nDELETED', 'DTDC12', '2021-01-24 10:38:11', '2021-01-17'),
(20, 2, '3', 'James R', 'Manglore', '2345678900', '1', 'Books', 35, 'COURIER\r\nDELETED', 'DTDC1', '2021-01-24 10:40:29', '2021-01-31'),
(21, 1, '3', 'Jimmy', 'Banglore', '9483034562', '3', 'Book', 25, 'COURIER\r\nDELETED', 'DTDC', '2021-01-24 10:41:17', '2021-01-25'),
(22, 1, '1', 'James', 'Banglore', '7777777777', '3', 'book', 50, 'COURIER\r\nBOOKED', 'DTDC1', '2021-01-27 07:09:06', '2021-01-31'),
(23, 2, '1', 'wge', 'manglore', '1111111111', '3', 'Book', 30, 'COURIER\r\nBOOKED', 'DTDC1', '2021-01-27 07:10:36', '2021-01-28');

--
-- Triggers `trigr`
--
DELIMITER $$
CREATE TRIGGER `approval` AFTER INSERT ON `trigr` FOR EACH ROW INSERT INTO approval VALUES
(null,NEW.custid,NEW.courid,NEW.receivername,NEW.receivercity,NEW.receiverphone,NEW.couriertype,NEW.courierdate,NEW.branchid)
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `approval`
--
ALTER TABLE `approval`
  ADD PRIMARY KEY (`apid`);

--
-- Indexes for table `bill`
--
ALTER TABLE `bill`
  ADD PRIMARY KEY (`billid`);

--
-- Indexes for table `company`
--
ALTER TABLE `company`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`branchemail`);

--
-- Indexes for table `courierbooking`
--
ALTER TABLE `courierbooking`
  ADD PRIMARY KEY (`courid`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`customeremail`);

--
-- Indexes for table `orderdetails`
--
ALTER TABLE `orderdetails`
  ADD PRIMARY KEY (`orderid`);

--
-- Indexes for table `trigr`
--
ALTER TABLE `trigr`
  ADD PRIMARY KEY (`tid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `approval`
--
ALTER TABLE `approval`
  MODIFY `apid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `bill`
--
ALTER TABLE `bill`
  MODIFY `billid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `company`
--
ALTER TABLE `company`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `courierbooking`
--
ALTER TABLE `courierbooking`
  MODIFY `courid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `orderdetails`
--
ALTER TABLE `orderdetails`
  MODIFY `orderid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `trigr`
--
ALTER TABLE `trigr`
  MODIFY `tid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
