-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 16, 2023 at 08:53 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_tiket_kapal_pesiar_asia`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `asia_ship_touring_MetodePembayaran` (`metode` VARCHAR(50))   BEGIN
	SELECT asia_ship_touring.TransactionID, customer.CustomerName, staff.StaffName, staff.StaffPosition, asia_ship_touring.TransactionDate, asia_ship_touring.PaymentMethod, asia_ship_touring.TotalTicket, asia_ship_touring.TotalPayment
	FROM ((asia_ship_touring INNER JOIN customer ON customer.CustomerID = asia_ship_touring.CustomerID)
         INNER JOIN staff ON staff.StaffID = asia_ship_touring.StaffID)
	WHERE asia_ship_touring.PaymentMethod = metode;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cruise_ship_owner` (`owner` VARCHAR(50))   BEGIN
	SELECT cruise_ship.CruiseShipName, cruise_ship.CruiseShipOwner, cruise_ship_track.CruiseShipTrackOrigin, cruise_ship_track.CruiseShipTrackDestination
	FROM (cruise_ship INNER JOIN cruise_ship_track ON cruise_ship.CruiseShipTrackID = cruise_ship_track.CruiseShipTrackID)
	WHERE cruise_ship.CruiseShipOwner = owner;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cruise_ship_track_negara` (`negara` VARCHAR(50))   BEGIN
	SELECT *
	FROM cruise_ship_track
	WHERE CruiseShipTrackOrigin = negara OR CruiseShipTrackDestination = negara;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `customer_noHP_Email` (`nama` VARCHAR(50))   BEGIN
	SELECT CustomerName, CustomerPhone, CustomerEmail
	FROM customer
	WHERE CustomerName = nama;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `destination_seaport_negara` (`negara` VARCHAR(50))   BEGIN
	SELECT *
	FROM destination_seaport
	WHERE DestinationSeaportCountry = negara;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `detail_asia_ship_touring_kenegara` (`negara` VARCHAR(50))   BEGIN
	SELECT detail_asia_ship_touring.TransactionID, tour_packages.TourPackagesName, origin_seaport.OriginSeaportName, transit_seaport.TransitSeaportName, destination_seaport.DestinationSeaportName, cruise_ship.CruiseShipName
	FROM (((((detail_asia_ship_touring INNER JOIN tour_packages ON tour_packages.TourPackagesID = detail_asia_ship_touring.TourPackagesID)
         INNER JOIN origin_seaport ON origin_seaport.OriginSeaportID = detail_asia_ship_touring.OriginSeaportID)
       INNER JOIN transit_seaport ON transit_seaport.TransitSeaportID = detail_asia_ship_touring.TransitSeaportID)
      INNER JOIN destination_seaport ON destination_seaport.DestinationSeaportID = detail_asia_ship_touring.DestinationSeaportID)
     LEFT JOIN cruise_ship ON cruise_ship.CruiseShipID = detail_asia_ship_touring.CruiseShipID)
	WHERE destination_seaport.DestinationSeaportCountry = negara
	ORDER BY detail_asia_ship_touring.TransactionID ASC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `origin_seaport_negara` (`negara` VARCHAR(50))   BEGIN
	SELECT *
	FROM origin_seaport
	WHERE OriginSeaportCountry = negara;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `staff_alamat` (`nama` VARCHAR(50))   BEGIN
	SELECT StaffName, StaffAddress, StaffPosition
	FROM staff
	WHERE StaffName = nama;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tour_packages_price` (`nama` VARCHAR(50))   BEGIN
	SELECT DISTINCT TourPackagesName, tour_packages_type.TourPackagesTypeName, SUM(tour_packages.Price + tour_packages_type.Price) AS "Price"
	FROM (tour_packages INNER JOIN tour_packages_type ON tour_packages_type.TourPackagesTypeID = tour_packages.TourPackagesTypeID)
	WHERE tour_packages.TourPackagesName = nama
    GROUP BY tour_packages.TourPackagesID, tour_packages_type.TourPackagesTypeID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tour_packages_type_price` (`nama` VARCHAR(50))   BEGIN
	SELECT TourPackagesTypeName, Price
	FROM tour_packages_type
	WHERE TourPackagesTypeName = nama;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `transit_seaport_negara` (`negara` VARCHAR(50))   BEGIN
	SELECT *
	FROM transit_seaport
	WHERE TransitSeaportCountry = negara;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `asia_ship_touring`
--

CREATE TABLE `asia_ship_touring` (
  `TransactionID` int(9) NOT NULL,
  `CustomerID` char(6) DEFAULT NULL,
  `StaffID` char(6) DEFAULT NULL,
  `TransactionDate` date DEFAULT NULL,
  `PaymentMethod` varchar(11) DEFAULT NULL,
  `TotalTicket` int(11) DEFAULT NULL,
  `TotalPayment` int(11) DEFAULT NULL
) ;

--
-- Dumping data for table `asia_ship_touring`
--

INSERT INTO `asia_ship_touring` (`TransactionID`, `CustomerID`, `StaffID`, `TransactionDate`, `PaymentMethod`, `TotalTicket`, `TotalPayment`) VALUES
(1234500001, 'CUS001', 'STA001', '2020-03-18', 'Credit Card', 3, 495000000),
(1234500002, 'CUS002', 'STA002', '2022-09-07', 'Credit Card', 1, 165000000),
(1234500003, 'CUS003', 'STA003', '2022-08-04', 'Credit Card', 2, 300000000),
(1234500004, 'CUS004', 'STA004', '2021-11-24', 'PayPal', 1, 150000000),
(1234500005, 'CUS005', 'STA005', '2020-07-06', 'Cash', 1, 30000000),
(1234500006, 'CUS006', 'STA006', '2021-04-02', 'PayPal', 2, 60000000),
(1234500007, 'CUS007', 'STA007', '2021-05-05', 'GoPay', 1, 15000000),
(1234500008, 'CUS008', 'STA008', '2022-12-31', 'Dana', 2, 30000000),
(1234500009, 'CUS009', 'STA009', '2021-07-26', 'M-Banking', 3, 90000000),
(1234500010, 'CUS010', 'STA010', '2021-05-05', 'M-Banking', 4, 660000000);

-- --------------------------------------------------------

--
-- Stand-in structure for view `asia_ship_touring_transaksimelebihi100jt`
-- (See below for the actual view)
--
CREATE TABLE `asia_ship_touring_transaksimelebihi100jt` (
`TransactionID` int(9)
,`CustomerName` varchar(50)
,`TransactionDate` date
,`TotalTicket` int(11)
,`TotalPayment` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `cruise_ship`
--

CREATE TABLE `cruise_ship` (
  `CruiseShipID` int(7) NOT NULL,
  `CruiseShipTrackID` char(6) DEFAULT NULL,
  `CruiseShipName` varchar(20) DEFAULT NULL,
  `CruiseShipOwner` varchar(35) DEFAULT NULL
) ;

--
-- Dumping data for table `cruise_ship`
--

INSERT INTO `cruise_ship` (`CruiseShipID`, `CruiseShipTrackID`, `CruiseShipName`, `CruiseShipOwner`) VALUES
(8821046, 'CST009', 'Costa neoRomantica', 'Carnival Corporation & PLC'),
(9032147, 'CST004', 'Dobonsolo', 'PT Pelayaran Nasional Indonesia'),
(9161716, 'CST001', 'Voyager of The Seas', 'Royal Caribbean Group'),
(9210218, 'CST008', 'Azamara Quest', 'Sycamore Partners'),
(9247144, 'CST010', 'Seven Seas Voyager', 'Norwegian Cruise Line Holdings Ltd'),
(9438078, 'CST005', 'Riviera', 'Oceania Cruises'),
(9549463, 'CST007', 'Quantum Of The Seas', 'Royal Caribbean Group'),
(9733105, 'CST006', 'Genting Dream', 'Genting Group'),
(9778856, 'CST002', 'Spectrum Of The Seas', 'Royal Caribbean Group'),
(9801689, 'CST003', 'Costa Venezia', 'Carnival Corporation & PLC');

-- --------------------------------------------------------

--
-- Stand-in structure for view `cruise_ship_royalcaribbeangroup`
-- (See below for the actual view)
--
CREATE TABLE `cruise_ship_royalcaribbeangroup` (
`CruiseShipID` int(7)
,`CruiseShipTrackID` char(6)
,`CruiseShipName` varchar(20)
,`CruiseShipOwner` varchar(35)
);

-- --------------------------------------------------------

--
-- Table structure for table `cruise_ship_track`
--

CREATE TABLE `cruise_ship_track` (
  `CruiseShipTrackID` char(6) NOT NULL,
  `CruiseShipTypeName` varchar(27) DEFAULT NULL,
  `CruiseShipTrackOrigin` varchar(20) DEFAULT NULL,
  `CruiseShipTrackDestination` varchar(20) DEFAULT NULL
) ;

--
-- Dumping data for table `cruise_ship_track`
--

INSERT INTO `cruise_ship_track` (`CruiseShipTrackID`, `CruiseShipTypeName`, `CruiseShipTrackOrigin`, `CruiseShipTrackDestination`) VALUES
('CST001', 'Short Trip (Private & Umum)', 'Singapore', 'Malaysia'),
('CST002', 'Long Trip (Private & Umum)', 'Singapore', 'Thailand'),
('CST003', 'Long Trip (Private & Umum)', 'Jepang', 'Singapore'),
('CST004', 'Short Trip (Private & Umum)', 'Indonesia', 'Indonesia'),
('CST005', 'Long Trip (Private & Umum)', 'China', 'Korea Selatan'),
('CST006', 'Long Trip (Private & Umum)', 'Indonesia', 'Singapore'),
('CST007', 'Short Trip (Private & Umum)', 'Indonesia', 'Philippines'),
('CST008', 'Short Trip (Private & Umum)', 'Uni Emirates Arab', 'Qatar'),
('CST009', 'Short Trip (Private & Umum)', 'Jepang', 'Korea Selatan'),
('CST010', 'Long Trip (Private & Umum)', 'Uni Emirates Arab', 'Singapore');

-- --------------------------------------------------------

--
-- Stand-in structure for view `cruise_ship_track_indonesia`
-- (See below for the actual view)
--
CREATE TABLE `cruise_ship_track_indonesia` (
`CruiseShipTrackID` char(6)
,`CruiseShipTypeName` varchar(27)
,`CruiseShipTrackOrigin` varchar(20)
,`CruiseShipTrackDestination` varchar(20)
);

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `CustomerID` char(6) NOT NULL,
  `CustomerName` varchar(50) DEFAULT NULL,
  `CustomerBirthDate` date DEFAULT NULL,
  `CustomerGender` varchar(10) DEFAULT NULL,
  `CustomerPhone` varchar(14) DEFAULT NULL,
  `CustomerEmail` varchar(50) DEFAULT NULL,
  `CustomerAddress` varchar(100) DEFAULT NULL
) ;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`CustomerID`, `CustomerName`, `CustomerBirthDate`, `CustomerGender`, `CustomerPhone`, `CustomerEmail`, `CustomerAddress`) VALUES
('CUS001', 'Reza', '2001-01-01', 'Male', '+6281250235831', 'reza.fatur@gmail.com', 'Kost Bamboo Park Nomor 15, Perumahan Bamboo Park, Kecamatan Pakis, Kabupaten Malang, Jawa Timur'),
('CUS002', 'Daniel', '2002-02-02', 'Male', '+6285399014003', 'daniel.lee@gmail.com', 'Kost Bamboo Park Nomor 2, Perumahan Bamboo Park, Kecamatan Pakis, Kabupaten Malang, Jawa Timur'),
('CUS003', 'Joy', '2003-03-03', 'Male', '+6281238036180', 'yoseph.joy@gmail.com', 'Jl. Raya Blimbing Indah No. 77, Kecamatan Blimbing, Kota Malang, Jawa Timur'),
('CUS004', 'Sakera', '2004-04-21', 'Male', '+6281283308061', 'sakeraaa@gmail.com', 'Jl. Raden Intan No. 74, Kecamatan Blimbing, Kota Malang, Jawa Timur'),
('CUS005', 'Faturrahman', '2003-12-31', 'Male', '+6281250449966', 'faturrahman007@gmail.com', 'Jl. Maritam No. 7, Kecamatan Samarinda Ulu, Kota Samarinda, Kalimantan Timur'),
('CUS006', 'Putra', '2000-08-31', 'Male', '+6285251325678', 'putra@gmail.com', 'Jl. Pulau Bangka No. 99, Kecamatan Denpasar Selatan, Kota Denpasar, Bali'),
('CUS007', 'Putri', '2003-03-01', 'Female', '+6281332517856', 'putri@gmail.com', 'Jl. Nusa Indah No. 1, Kecamatan Cilandak, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta'),
('CUS008', 'Hayley', '1998-12-27', 'Female', '+1415638083123', 'hayley.williams@gmail.com', '926 Fair Street, Franklin, Tennessee 37064, Amerika Serikat'),
('CUS009', 'Lionel Messi', '1987-06-24', 'Male', '+5411420192321', 'lionel.messi@gmail.com', 'Passeig de la Creu, 20, 08860 Castelldefels, Barcelona, Spanyol'),
('CUS010', 'Ronaldo Jr.', '2003-03-01', 'Male', '+3512121069244', 'ronaldo.junior@gmail.com', 'Woodbrook Road, Alderley Edge SK9 7BU, United Kingdom');

-- --------------------------------------------------------

--
-- Stand-in structure for view `customer_tahunlahir2003`
-- (See below for the actual view)
--
CREATE TABLE `customer_tahunlahir2003` (
`CustomerID` char(6)
,`CustomerName` varchar(50)
,`CustomerBirthDate` date
,`CustomerGender` varchar(10)
,`CustomerPhone` varchar(14)
,`CustomerEmail` varchar(50)
,`CustomerAddress` varchar(100)
);

-- --------------------------------------------------------

--
-- Table structure for table `destination_seaport`
--

CREATE TABLE `destination_seaport` (
  `DestinationSeaportID` char(5) NOT NULL,
  `DestinationSeaportName` varchar(50) DEFAULT NULL,
  `DestinationSeaportCity` varchar(20) DEFAULT NULL,
  `DestinationSeaportCountry` varchar(20) DEFAULT NULL
) ;

--
-- Dumping data for table `destination_seaport`
--

INSERT INTO `destination_seaport` (`DestinationSeaportID`, `DestinationSeaportName`, `DestinationSeaportCity`, `DestinationSeaportCountry`) VALUES
('DE001', 'Marina Bay Cruise Center', 'Singapore', 'Singapore'),
('DE002', 'Port of Tokyo', 'Tokyo', 'Jepang'),
('DE003', 'Port of Benoa', 'Denpasar', 'Indonesia'),
('DE004', 'Victoria Harbour', 'Hong Kong', 'China'),
('DE005', 'Port of Tanjung Perak', 'Surabaya', 'Indonesia'),
('DE006', 'Port of Makassar', 'Makassar', 'Indonesia'),
('DE007', 'Port of Rashid', 'Dubai', 'Uni Emirates Arab'),
('DE008', 'Port of Penang', 'Penang', 'Malaysia'),
('DE009', 'Port of Nha Trang', 'Nha Trang', 'Vietnam'),
('DE010', 'Port of Manila', 'Manila', 'Phillipines'),
('DE011', 'Loh Liang Pier', 'Pulau Komodo', 'Indonesia'),
('DE012', 'TIPC Port of Keelung', 'Keelung', 'Taiwan'),
('DE013', 'Port of Doha', 'Doha', 'Qatar'),
('DE014', 'Port of Incheon', 'Incheon', 'South Korea'),
('DE015', 'Port of Bangkok', 'Bangkok', 'Thailand'),
('DE016', 'Fukuoka Cruise Terminal', 'Fukuoka', 'Jepang'),
('DE017', 'Busan International Cruise Terminal', 'Busan', 'Korea Selatan'),
('DE018', 'Botahtaung Harbour', 'Yangon', 'Myanmar');

-- --------------------------------------------------------

--
-- Stand-in structure for view `destination_seaport_singapore`
-- (See below for the actual view)
--
CREATE TABLE `destination_seaport_singapore` (
`DestinationSeaportID` char(5)
,`DestinationSeaportName` varchar(50)
,`DestinationSeaportCity` varchar(20)
,`DestinationSeaportCountry` varchar(20)
);

-- --------------------------------------------------------

--
-- Table structure for table `detail_asia_ship_touring`
--

CREATE TABLE `detail_asia_ship_touring` (
  `TransactionID` int(9) NOT NULL,
  `TourPackagesID` char(5) NOT NULL,
  `OriginSeaportID` char(5) NOT NULL,
  `TransitSeaportID` char(5) NOT NULL,
  `DestinationSeaportID` char(5) NOT NULL,
  `CruiseShipID` int(7) NOT NULL,
  `TanggalKeberangkatan` date DEFAULT NULL,
  `JamKeberangkatan` varchar(5) DEFAULT NULL,
  `TanggalKedatangan` date DEFAULT NULL,
  `JamKedatangan` varchar(5) DEFAULT NULL
) ;

--
-- Dumping data for table `detail_asia_ship_touring`
--

INSERT INTO `detail_asia_ship_touring` (`TransactionID`, `TourPackagesID`, `OriginSeaportID`, `TransitSeaportID`, `DestinationSeaportID`, `CruiseShipID`, `TanggalKeberangkatan`, `JamKeberangkatan`, `TanggalKedatangan`, `JamKedatangan`) VALUES
(1234500001, 'TP004', 'OR005', 'TR003', 'DE001', 9733105, '2023-01-16', '09:00', '2023-01-23', '12:00'),
(1234500002, 'TP004', 'OR004', 'TR012', 'DE014', 9438078, '2023-01-17', '08:00', '2023-01-24', '18:00'),
(1234500003, 'TP003', 'OR001', 'TR009', 'DE015', 9778856, '2022-12-15', '09:00', '2022-12-22', '13:00'),
(1234500004, 'TP003', 'OR002', 'TR010', 'DE001', 9801689, '2022-11-07', '10:00', '2022-11-14', '13:00'),
(1234500005, 'TP002', 'OR001', 'TR008', 'DE001', 9161716, '2023-01-01', '09:00', '2023-01-04', '14:00'),
(1234500006, 'TP002', 'OR003', 'TR011', 'DE003', 9032147, '2023-01-02', '08:00', '2023-01-05', '11:00'),
(1234500007, 'TP001', 'OR007', 'TR013', 'DE007', 9210218, '2022-09-05', '11:00', '2022-09-08', '11:00'),
(1234500008, 'TP001', 'OR006', 'TR010', 'DE006', 9549463, '2022-10-10', '11:00', '2022-10-13', '11:00'),
(1234500009, 'TP002', 'OR016', 'TR017', 'DE016', 8821046, '2022-11-01', '08:00', '2022-11-04', '10:00'),
(1234500010, 'TP004', 'OR007', 'TR018', 'DE001', 9247144, '2023-01-04', '10:00', '2023-01-11', '09:00');

-- --------------------------------------------------------

--
-- Stand-in structure for view `detail_asia_ship_touring_shorttrip`
-- (See below for the actual view)
--
CREATE TABLE `detail_asia_ship_touring_shorttrip` (
`TransactionID` int(9)
,`TourPackagesName` varchar(10)
,`OriginSeaportName` varchar(50)
,`TransitSeaportName` varchar(50)
,`DestinationSeaportName` varchar(50)
,`CruiseShipName` varchar(20)
);

-- --------------------------------------------------------

--
-- Table structure for table `origin_seaport`
--

CREATE TABLE `origin_seaport` (
  `OriginSeaportID` char(5) NOT NULL,
  `OriginSeaportName` varchar(50) DEFAULT NULL,
  `OriginSeaportCity` varchar(20) DEFAULT NULL,
  `OriginSeaportCountry` varchar(20) DEFAULT NULL
) ;

--
-- Dumping data for table `origin_seaport`
--

INSERT INTO `origin_seaport` (`OriginSeaportID`, `OriginSeaportName`, `OriginSeaportCity`, `OriginSeaportCountry`) VALUES
('OR001', 'Marina Bay Cruise Center', 'Singapore', 'Singapore'),
('OR002', 'Port of Tokyo', 'Tokyo', 'Jepang'),
('OR003', 'Port of Benoa', 'Denpasar', 'Indonesia'),
('OR004', 'Victoria Harbour', 'Hong Kong', 'China'),
('OR005', 'Port of Tanjung Perak', 'Surabaya', 'Indonesia'),
('OR006', 'Port of Makassar', 'Makassar', 'Indonesia'),
('OR007', 'Port of Rashid', 'Dubai', 'Uni Emirates Arab'),
('OR008', 'Port of Penang', 'Penang', 'Malaysia'),
('OR009', 'Port of Nha Trang', 'Nha Trang', 'Vietnam'),
('OR010', 'Port of Manila', 'Manila', 'Phillipines'),
('OR011', 'Loh Liang Pier', 'Pulau Komodo', 'Indonesia'),
('OR012', 'TIPC Port of Keelung', 'Keelung', 'Taiwan'),
('OR013', 'Port of Doha', 'Doha', 'Qatar'),
('OR014', 'Port of Incheon', 'Incheon', 'Korea Selatan'),
('OR015', 'Port of Bangkok', 'Bangkok', 'Thailand'),
('OR016', 'Fukuoka Cruise Terminal', 'Fukuoka', 'Jepang'),
('OR017', 'Busan International Cruise Terminal', 'Busan', 'Korea Selatan'),
('OR018', 'Botahtaung Harbour', 'Yangon', 'Myanmar');

-- --------------------------------------------------------

--
-- Stand-in structure for view `origin_seaport_indonesia`
-- (See below for the actual view)
--
CREATE TABLE `origin_seaport_indonesia` (
`OriginSeaportID` char(5)
,`OriginSeaportName` varchar(50)
,`OriginSeaportCity` varchar(20)
,`OriginSeaportCountry` varchar(20)
);

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `StaffID` char(6) NOT NULL,
  `StaffName` varchar(50) DEFAULT NULL,
  `StaffBirthDate` date DEFAULT NULL,
  `StaffGender` varchar(10) DEFAULT NULL,
  `StaffPhone` varchar(14) DEFAULT NULL,
  `StaffEmail` varchar(50) DEFAULT NULL,
  `StaffAddress` varchar(100) DEFAULT NULL,
  `StaffSalary` int(9) DEFAULT NULL,
  `StaffPosition` varchar(7) DEFAULT NULL
) ;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`StaffID`, `StaffName`, `StaffBirthDate`, `StaffGender`, `StaffPhone`, `StaffEmail`, `StaffAddress`, `StaffSalary`, `StaffPosition`) VALUES
('STA001', 'Rahman', '1972-11-10', 'Male', '+6281258315023', 'rahmaneee@gmail.com', 'Jl. Batakan Mas No. 14, Kecamatan Balikpapan Timur, Kota Balikpapan, Kalimantan Timur', 60000000, 'Captain'),
('STA002', 'Lee', '1980-05-05', 'Male', '+6282142575821', 'lee@gmail.com', 'Jl. Panjaitan No. 165, Kecamatan Teluk Segara, Kota Bengkulu, Bengkulu', 45000000, 'Captain'),
('STA003', 'Muhammad Ali', '1970-05-19', 'Male', '+9660141170766', 'muhammad.ali@gmail.com', 'Al Haram, Mecca 24231, Arab Saudi', 75000000, 'Captain'),
('STA004', 'Karim Benzema', '1987-12-19', 'Male', '+3302324798933', 'karim.benzema@gmail.com', 'Champ de Mars, 5 Av. Anatole France, 75007 Paris, Prancis', 30000000, 'Captain'),
('STA005', 'Justinus', '1967-07-28', 'Male', '+6281250235831', 'justalk@gmail.com', 'Jl. Kartika Utama No. 47, Kec. Kebayoran Lama, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta', 80000000, 'Captain'),
('STA006', 'Vinicius', '2000-07-12', 'Male', '+3464721328823', 'vinicius.jr@gmail.com', 'Av. de Concha Espina, 1, 28036 Madrid, Spanyol', 25000000, 'Captain'),
('STA007', 'Jordyn', '2001-05-08', 'Female', '+1418522151077', 'jordyn.huitema@gmail.com', '7575 Columbia Street, Vancouver, BC V5X 2Z1, Kanada', 25000000, 'Captain'),
('STA008', 'Morgan', '1989-07-02', 'Female', '+1620896381831', 'alex.morgan@gmail.com', '1245 W Cienega Ave, San Dimas, CA 91773, Amerika Serikat', 27500000, 'Captain'),
('STA009', 'Putellas', '1994-02-04', 'Female', '+3460283777715', 'alexia.puttelas@gmail.com', 'Carrer de la Constitució, 36, 08014 Barcelona, Spanyol', 27500000, 'Captain'),
('STA010', 'Alessia Russo', '1999-02-08', 'Female', '+4407757068306', 'russo99@gmail.com', '32 Clifford Way, Maidstone ME16 8GB, United Kingdom', 25000000, 'Captain');

-- --------------------------------------------------------

--
-- Stand-in structure for view `staff_perempuan`
-- (See below for the actual view)
--
CREATE TABLE `staff_perempuan` (
`StaffID` char(6)
,`StaffName` varchar(50)
,`StaffBirthDate` date
,`StaffGender` varchar(10)
,`StaffPhone` varchar(14)
,`StaffEmail` varchar(50)
,`StaffAddress` varchar(100)
,`StaffSalary` int(9)
,`StaffPosition` varchar(7)
);

-- --------------------------------------------------------

--
-- Table structure for table `tour_packages`
--

CREATE TABLE `tour_packages` (
  `TourPackagesID` char(5) NOT NULL,
  `TourPackagesTypeID` char(6) DEFAULT NULL,
  `TourPackagesName` varchar(10) DEFAULT NULL,
  `Price` int(11) DEFAULT NULL
) ;

--
-- Dumping data for table `tour_packages`
--

INSERT INTO `tour_packages` (`TourPackagesID`, `TourPackagesTypeID`, `TourPackagesName`, `Price`) VALUES
('TP001', 'TPT001', 'Short Trip', 15000000),
('TP002', 'TPT002', 'Short Trip', 30000000),
('TP003', 'TPT001', 'Long Trip', 150000000),
('TP004', 'TPT002', 'Long Trip', 165000000);

-- --------------------------------------------------------

--
-- Stand-in structure for view `tour_packages_longtrip`
-- (See below for the actual view)
--
CREATE TABLE `tour_packages_longtrip` (
`TourPackagesID` char(5)
,`TourPackagesTypeID` char(6)
,`TourPackagesName` varchar(10)
,`Price` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `tour_packages_type`
--

CREATE TABLE `tour_packages_type` (
  `TourPackagesTypeID` char(6) NOT NULL,
  `TourPackagesTypeName` varchar(7) DEFAULT NULL,
  `Price` int(11) DEFAULT NULL
) ;

--
-- Dumping data for table `tour_packages_type`
--

INSERT INTO `tour_packages_type` (`TourPackagesTypeID`, `TourPackagesTypeName`, `Price`) VALUES
('TPT001', 'Umum', 0),
('TPT002', 'Private', 15000000);

-- --------------------------------------------------------

--
-- Stand-in structure for view `tour_packages_type_tampilkandata`
-- (See below for the actual view)
--
CREATE TABLE `tour_packages_type_tampilkandata` (
`TourPackagesTypeID` char(6)
,`TourPackagesTypeName` varchar(7)
,`Price` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `transit_seaport`
--

CREATE TABLE `transit_seaport` (
  `TransitSeaportID` char(5) NOT NULL,
  `TransitSeaportName` varchar(50) DEFAULT NULL,
  `TransitSeaportCity` varchar(20) DEFAULT NULL,
  `TransitSeaportCountry` varchar(20) DEFAULT NULL
) ;

--
-- Dumping data for table `transit_seaport`
--

INSERT INTO `transit_seaport` (`TransitSeaportID`, `TransitSeaportName`, `TransitSeaportCity`, `TransitSeaportCountry`) VALUES
('TR001', 'Marina Bay Cruise Center', 'Singapore', 'Singapore'),
('TR002', 'Port of Tokyo', 'Tokyo', 'Jepang'),
('TR003', 'Port of Benoa', 'Denpasar', 'Indonesia'),
('TR004', 'Victoria Harbour', 'Hong Kong', 'China'),
('TR005', 'Port of Tanjung Perak', 'Surabaya', 'Indonesia'),
('TR006', 'Port of Makassar', 'Makassar', 'Indonesia'),
('TR007', 'Port of Rashid', 'Dubai', 'Uni Emirates Arab'),
('TR008', 'Port of Penang', 'Penang', 'Malaysia'),
('TR009', 'Port of Nha Trang', 'Nha Trang', 'Vietnam'),
('TR010', 'Port of Manila', 'Manila', 'Phillipines'),
('TR011', 'Loh Liang Pier', 'Pulau Komodo', 'Indonesia'),
('TR012', 'TIPC Port of Keelung', 'Keelung', 'Taiwan'),
('TR013', 'Port of Doha', 'Doha', 'Qatar'),
('TR014', 'Port of Incheon', 'Incheon', 'South Korea'),
('TR015', 'Port of Bangkok', 'Bangkok', 'Thailand'),
('TR016', 'Fukuoka Cruise Terminal', 'Fukuoka', 'Jepang'),
('TR017', 'Busan International Cruise Terminal', 'Busan', 'Korea Selatan'),
('TR018', 'Botahtaung Harbour', 'Yangon', 'Myanmar');

-- --------------------------------------------------------

--
-- Stand-in structure for view `transit_seaport_malaysia`
-- (See below for the actual view)
--
CREATE TABLE `transit_seaport_malaysia` (
`TransitSeaportID` char(5)
,`TransitSeaportName` varchar(50)
,`TransitSeaportCity` varchar(20)
,`TransitSeaportCountry` varchar(20)
);

-- --------------------------------------------------------

--
-- Structure for view `asia_ship_touring_transaksimelebihi100jt`
--
DROP TABLE IF EXISTS `asia_ship_touring_transaksimelebihi100jt`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `asia_ship_touring_transaksimelebihi100jt`  AS SELECT `asia_ship_touring`.`TransactionID` AS `TransactionID`, `customer`.`CustomerName` AS `CustomerName`, `asia_ship_touring`.`TransactionDate` AS `TransactionDate`, `asia_ship_touring`.`TotalTicket` AS `TotalTicket`, `asia_ship_touring`.`TotalPayment` AS `TotalPayment` FROM (`asia_ship_touring` join `customer` on(`customer`.`CustomerID` = `asia_ship_touring`.`CustomerID`)) WHERE `asia_ship_touring`.`TotalPayment` > 100000000 ORDER BY `asia_ship_touring`.`TotalPayment` ASC  ;

-- --------------------------------------------------------

--
-- Structure for view `cruise_ship_royalcaribbeangroup`
--
DROP TABLE IF EXISTS `cruise_ship_royalcaribbeangroup`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `cruise_ship_royalcaribbeangroup`  AS SELECT `cruise_ship`.`CruiseShipID` AS `CruiseShipID`, `cruise_ship`.`CruiseShipTrackID` AS `CruiseShipTrackID`, `cruise_ship`.`CruiseShipName` AS `CruiseShipName`, `cruise_ship`.`CruiseShipOwner` AS `CruiseShipOwner` FROM `cruise_ship` WHERE `cruise_ship`.`CruiseShipOwner` = 'Royal Caribbean Group''Royal Caribbean Group'  ;

-- --------------------------------------------------------

--
-- Structure for view `cruise_ship_track_indonesia`
--
DROP TABLE IF EXISTS `cruise_ship_track_indonesia`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `cruise_ship_track_indonesia`  AS SELECT `cruise_ship_track`.`CruiseShipTrackID` AS `CruiseShipTrackID`, `cruise_ship_track`.`CruiseShipTypeName` AS `CruiseShipTypeName`, `cruise_ship_track`.`CruiseShipTrackOrigin` AS `CruiseShipTrackOrigin`, `cruise_ship_track`.`CruiseShipTrackDestination` AS `CruiseShipTrackDestination` FROM `cruise_ship_track` WHERE `cruise_ship_track`.`CruiseShipTrackOrigin` = 'Indonesia' OR `cruise_ship_track`.`CruiseShipTrackDestination` = 'Indonesia''Indonesia'  ;

-- --------------------------------------------------------

--
-- Structure for view `customer_tahunlahir2003`
--
DROP TABLE IF EXISTS `customer_tahunlahir2003`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `customer_tahunlahir2003`  AS SELECT `customer`.`CustomerID` AS `CustomerID`, `customer`.`CustomerName` AS `CustomerName`, `customer`.`CustomerBirthDate` AS `CustomerBirthDate`, `customer`.`CustomerGender` AS `CustomerGender`, `customer`.`CustomerPhone` AS `CustomerPhone`, `customer`.`CustomerEmail` AS `CustomerEmail`, `customer`.`CustomerAddress` AS `CustomerAddress` FROM `customer` WHERE `customer`.`CustomerBirthDate` between '2003-01-01' and '2003-12-31' ORDER BY `customer`.`CustomerBirthDate` ASC  ;

-- --------------------------------------------------------

--
-- Structure for view `destination_seaport_singapore`
--
DROP TABLE IF EXISTS `destination_seaport_singapore`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `destination_seaport_singapore`  AS SELECT `destination_seaport`.`DestinationSeaportID` AS `DestinationSeaportID`, `destination_seaport`.`DestinationSeaportName` AS `DestinationSeaportName`, `destination_seaport`.`DestinationSeaportCity` AS `DestinationSeaportCity`, `destination_seaport`.`DestinationSeaportCountry` AS `DestinationSeaportCountry` FROM `destination_seaport` WHERE `destination_seaport`.`DestinationSeaportCountry` = 'Singapore''Singapore'  ;

-- --------------------------------------------------------

--
-- Structure for view `detail_asia_ship_touring_shorttrip`
--
DROP TABLE IF EXISTS `detail_asia_ship_touring_shorttrip`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `detail_asia_ship_touring_shorttrip`  AS SELECT `detail_asia_ship_touring`.`TransactionID` AS `TransactionID`, `tour_packages`.`TourPackagesName` AS `TourPackagesName`, `origin_seaport`.`OriginSeaportName` AS `OriginSeaportName`, `transit_seaport`.`TransitSeaportName` AS `TransitSeaportName`, `destination_seaport`.`DestinationSeaportName` AS `DestinationSeaportName`, `cruise_ship`.`CruiseShipName` AS `CruiseShipName` FROM (((((`detail_asia_ship_touring` join `tour_packages` on(`tour_packages`.`TourPackagesID` = `detail_asia_ship_touring`.`TourPackagesID`)) join `origin_seaport` on(`origin_seaport`.`OriginSeaportID` = `detail_asia_ship_touring`.`OriginSeaportID`)) join `transit_seaport` on(`transit_seaport`.`TransitSeaportID` = `detail_asia_ship_touring`.`TransitSeaportID`)) join `destination_seaport` on(`destination_seaport`.`DestinationSeaportID` = `detail_asia_ship_touring`.`DestinationSeaportID`)) left join `cruise_ship` on(`cruise_ship`.`CruiseShipID` = `detail_asia_ship_touring`.`CruiseShipID`)) WHERE `tour_packages`.`TourPackagesName` = 'Short Trip' ORDER BY `detail_asia_ship_touring`.`TransactionID` ASC  ;

-- --------------------------------------------------------

--
-- Structure for view `origin_seaport_indonesia`
--
DROP TABLE IF EXISTS `origin_seaport_indonesia`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `origin_seaport_indonesia`  AS SELECT `origin_seaport`.`OriginSeaportID` AS `OriginSeaportID`, `origin_seaport`.`OriginSeaportName` AS `OriginSeaportName`, `origin_seaport`.`OriginSeaportCity` AS `OriginSeaportCity`, `origin_seaport`.`OriginSeaportCountry` AS `OriginSeaportCountry` FROM `origin_seaport` WHERE `origin_seaport`.`OriginSeaportCountry` = 'Indonesia''Indonesia'  ;

-- --------------------------------------------------------

--
-- Structure for view `staff_perempuan`
--
DROP TABLE IF EXISTS `staff_perempuan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `staff_perempuan`  AS SELECT `staff`.`StaffID` AS `StaffID`, `staff`.`StaffName` AS `StaffName`, `staff`.`StaffBirthDate` AS `StaffBirthDate`, `staff`.`StaffGender` AS `StaffGender`, `staff`.`StaffPhone` AS `StaffPhone`, `staff`.`StaffEmail` AS `StaffEmail`, `staff`.`StaffAddress` AS `StaffAddress`, `staff`.`StaffSalary` AS `StaffSalary`, `staff`.`StaffPosition` AS `StaffPosition` FROM `staff` WHERE `staff`.`StaffGender` = 'Female' ORDER BY `staff`.`StaffName` ASC  ;

-- --------------------------------------------------------

--
-- Structure for view `tour_packages_longtrip`
--
DROP TABLE IF EXISTS `tour_packages_longtrip`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `tour_packages_longtrip`  AS SELECT `tour_packages`.`TourPackagesID` AS `TourPackagesID`, `tour_packages`.`TourPackagesTypeID` AS `TourPackagesTypeID`, `tour_packages`.`TourPackagesName` AS `TourPackagesName`, `tour_packages`.`Price` AS `Price` FROM `tour_packages` WHERE `tour_packages`.`TourPackagesName` = 'Long Trip''Long Trip'  ;

-- --------------------------------------------------------

--
-- Structure for view `tour_packages_type_tampilkandata`
--
DROP TABLE IF EXISTS `tour_packages_type_tampilkandata`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `tour_packages_type_tampilkandata`  AS SELECT `tour_packages_type`.`TourPackagesTypeID` AS `TourPackagesTypeID`, `tour_packages_type`.`TourPackagesTypeName` AS `TourPackagesTypeName`, `tour_packages_type`.`Price` AS `Price` FROM `tour_packages_type``tour_packages_type`  ;

-- --------------------------------------------------------

--
-- Structure for view `transit_seaport_malaysia`
--
DROP TABLE IF EXISTS `transit_seaport_malaysia`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `transit_seaport_malaysia`  AS SELECT `transit_seaport`.`TransitSeaportID` AS `TransitSeaportID`, `transit_seaport`.`TransitSeaportName` AS `TransitSeaportName`, `transit_seaport`.`TransitSeaportCity` AS `TransitSeaportCity`, `transit_seaport`.`TransitSeaportCountry` AS `TransitSeaportCountry` FROM `transit_seaport` WHERE `transit_seaport`.`TransitSeaportCountry` = 'Malaysia''Malaysia'  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `asia_ship_touring`
--
ALTER TABLE `asia_ship_touring`
  ADD PRIMARY KEY (`TransactionID`),
  ADD KEY `CustomerID` (`CustomerID`),
  ADD KEY `StaffID` (`StaffID`);

--
-- Indexes for table `cruise_ship`
--
ALTER TABLE `cruise_ship`
  ADD PRIMARY KEY (`CruiseShipID`),
  ADD UNIQUE KEY `CruiseShipTrackID` (`CruiseShipTrackID`);

--
-- Indexes for table `cruise_ship_track`
--
ALTER TABLE `cruise_ship_track`
  ADD PRIMARY KEY (`CruiseShipTrackID`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`CustomerID`),
  ADD UNIQUE KEY `CustomerPhone` (`CustomerPhone`),
  ADD UNIQUE KEY `CustomerEmail` (`CustomerEmail`),
  ADD UNIQUE KEY `CustomerAddress` (`CustomerAddress`);

--
-- Indexes for table `destination_seaport`
--
ALTER TABLE `destination_seaport`
  ADD PRIMARY KEY (`DestinationSeaportID`),
  ADD UNIQUE KEY `DestinationSeaportName` (`DestinationSeaportName`);

--
-- Indexes for table `detail_asia_ship_touring`
--
ALTER TABLE `detail_asia_ship_touring`
  ADD PRIMARY KEY (`TransactionID`,`TourPackagesID`,`OriginSeaportID`,`TransitSeaportID`,`DestinationSeaportID`,`CruiseShipID`),
  ADD KEY `TourPackagesID` (`TourPackagesID`),
  ADD KEY `OriginSeaportID` (`OriginSeaportID`),
  ADD KEY `TransitSeaportID` (`TransitSeaportID`),
  ADD KEY `DestinationSeaportID` (`DestinationSeaportID`),
  ADD KEY `CruiseShipID` (`CruiseShipID`);

--
-- Indexes for table `origin_seaport`
--
ALTER TABLE `origin_seaport`
  ADD PRIMARY KEY (`OriginSeaportID`),
  ADD UNIQUE KEY `OriginSeaportName` (`OriginSeaportName`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`StaffID`),
  ADD UNIQUE KEY `StaffPhone` (`StaffPhone`),
  ADD UNIQUE KEY `StaffEmail` (`StaffEmail`),
  ADD UNIQUE KEY `StaffAddress` (`StaffAddress`);

--
-- Indexes for table `tour_packages`
--
ALTER TABLE `tour_packages`
  ADD PRIMARY KEY (`TourPackagesID`),
  ADD KEY `TourPackagesTypeID` (`TourPackagesTypeID`);

--
-- Indexes for table `tour_packages_type`
--
ALTER TABLE `tour_packages_type`
  ADD PRIMARY KEY (`TourPackagesTypeID`),
  ADD UNIQUE KEY `TourPackagesTypeName` (`TourPackagesTypeName`);

--
-- Indexes for table `transit_seaport`
--
ALTER TABLE `transit_seaport`
  ADD PRIMARY KEY (`TransitSeaportID`),
  ADD UNIQUE KEY `TransitSeaportName` (`TransitSeaportName`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `asia_ship_touring`
--
ALTER TABLE `asia_ship_touring`
  ADD CONSTRAINT `asia_ship_touring_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`),
  ADD CONSTRAINT `asia_ship_touring_ibfk_2` FOREIGN KEY (`StaffID`) REFERENCES `staff` (`StaffID`);

--
-- Constraints for table `cruise_ship`
--
ALTER TABLE `cruise_ship`
  ADD CONSTRAINT `cruise_ship_ibfk_1` FOREIGN KEY (`CruiseShipTrackID`) REFERENCES `cruise_ship_track` (`CruiseShipTrackID`);

--
-- Constraints for table `detail_asia_ship_touring`
--
ALTER TABLE `detail_asia_ship_touring`
  ADD CONSTRAINT `detail_asia_ship_touring_ibfk_1` FOREIGN KEY (`TransactionID`) REFERENCES `asia_ship_touring` (`TransactionID`),
  ADD CONSTRAINT `detail_asia_ship_touring_ibfk_2` FOREIGN KEY (`TourPackagesID`) REFERENCES `tour_packages` (`TourPackagesID`),
  ADD CONSTRAINT `detail_asia_ship_touring_ibfk_3` FOREIGN KEY (`OriginSeaportID`) REFERENCES `origin_seaport` (`OriginSeaportID`),
  ADD CONSTRAINT `detail_asia_ship_touring_ibfk_4` FOREIGN KEY (`TransitSeaportID`) REFERENCES `transit_seaport` (`TransitSeaportID`),
  ADD CONSTRAINT `detail_asia_ship_touring_ibfk_5` FOREIGN KEY (`DestinationSeaportID`) REFERENCES `destination_seaport` (`DestinationSeaportID`),
  ADD CONSTRAINT `detail_asia_ship_touring_ibfk_6` FOREIGN KEY (`CruiseShipID`) REFERENCES `cruise_ship` (`CruiseShipID`);

--
-- Constraints for table `tour_packages`
--
ALTER TABLE `tour_packages`
  ADD CONSTRAINT `tour_packages_ibfk_1` FOREIGN KEY (`TourPackagesTypeID`) REFERENCES `tour_packages_type` (`TourPackagesTypeID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
