-- SQL script for datatables creation / ETNA
-- 16 Nov 2022

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema dataetna
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dataetna` DEFAULT CHARACTER SET utf8;
USE `dataetna`;

-- -----------------------------------------------------
-- Table `dataetna`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dataetna`.`customer` (
  `customerID` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `customerName` VARCHAR(255) NOT NULL,
  `IDCard` INT NOT NULL,
  `drivingLicenceID` INT NOT NULL,
  `customerAdress` VARCHAR(255) NOT NULL,
  `code` VARCHAR(255) NOT NULL,
  `city` VARCHAR(255) NOT NULL,
  `lat` FLOAT NOT NULL,
  `longi` FLOAT NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `created_at` DATETIME NOT NULL,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  UNIQUE INDEX `DrivingLicenceID_UNIQUE` (`DrivingLicenceID` ASC),
  UNIQUE INDEX `IDCard_UNIQUE` (`IDCard` ASC))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `dataetna`.`parking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dataetna`.`parking` (
  `parkingID` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `parkingName` VARCHAR(255) NOT NULL,
  `lotNumberTotal` INT NOT NULL,
  `lotNumberFree` INT NOT NULL,
  `lat` FLOAT NOT NULL,
  `longi` FLOAT NOT NULL,
  `city` VARCHAR(255) NOT NULL,
  UNIQUE INDEX `parkingName_UNIQUE` (`parkingName` ASC))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `dataetna`.`truck`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dataetna`.`truck` (
  `truckID` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `lat` FLOAT NOT NULL,
  `longi` FLOAT NOT NULL,
  `carCapacity` INT NOT NULL,
  `carAvailability` INT NOT NULL)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `dataetna`.`car`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dataetna`.`car` (
  `carID` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `carModel` VARCHAR(255) NOT NULL,
  `seatsNumber` INT NOT NULL,
  `trunkSize` INT NOT NULL,
  `engineType` VARCHAR(255) NOT NULL,
  `energyLevelPerc` INT NOT NULL,
  `pricePerDay` INT NOT NULL,
  `lat` FLOAT NOT NULL,
  `longi` FLOAT NOT NULL,
  `parkingID` INT,
  INDEX `fk_car_parking_idx1` (`parkingID` ASC),
  CONSTRAINT `fk_car_parking1`
    FOREIGN KEY (`parkingID`)
    REFERENCES `dataetna`.`parking` (`parkingID`)
    ON DELETE Set NULL
    ON UPDATE Cascade)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `dataetna`.`trip`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dataetna`.`trip` (
  `tripID` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `customerID` INT,
  `carID` INT,
  `startingParkingID` INT,
  `endingParkingID` INT,
  `startingDate` DATETIME NOT NULL,
  `endingDate` DATETIME NOT NULL,
  INDEX `fk_trip_customer_idx1` (`customerID` ASC),
  CONSTRAINT `fk_trip_customer1`
    FOREIGN KEY (`customerID`)
    REFERENCES `dataetna`.`customer` (`customerID`)
    ON DELETE Set NULL
    ON UPDATE Cascade,
  INDEX `fk_trip_car_idx1` (`carID` ASC),
  CONSTRAINT `fk_trip_car1`
    FOREIGN KEY (`carID`)
    REFERENCES `dataetna`.`car` (`carID`)
    ON DELETE Set NULL
    ON UPDATE Cascade,
  INDEX `fk_trip_parking_idx1` (`startingParkingID` ASC),
  CONSTRAINT `fk_trip_parking1`
    FOREIGN KEY (`startingParkingID`)
    REFERENCES `dataetna`.`parking` (`parkingID`)
    ON DELETE Set NULL
    ON UPDATE Cascade,
  INDEX `fk_trip_parking_idx2` (`endingParkingID` ASC),
  CONSTRAINT `fk_trip_parking2`
    FOREIGN KEY (`endingParkingID`)
    REFERENCES `dataetna`.`parking` (`parkingID`)
    ON DELETE Set NULL
    ON UPDATE Cascade)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `dataetna`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dataetna`.`payment` (
  `paymentID` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `price` INT NOT NULL,
  `paymentOption` VARCHAR(255) NOT NULL,
  `tripID` INT,
  INDEX `fk_payment_trip_idx1` (`tripID` ASC),
  CONSTRAINT `fk_payment_trip1`
    FOREIGN KEY (`tripID`)
    REFERENCES `dataetna`.`trip` (`tripID`)
    ON DELETE Set NULL
    ON UPDATE Cascade)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dataetna`.`restock`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dataetna`.`restock` (
  `restockID` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `restockDate` DATETIME NOT NULL,
  `pickUpParkingID` INT,
  `depositParkingID` INT,
  `truckID` INT,
  `tripID` INT,
  INDEX `fk_restock_truck_idx1` (`truckID` ASC),
  CONSTRAINT `fk_restock_truck1`
    FOREIGN KEY (`truckID`)
    REFERENCES `dataetna`.`truck` (`truckID`)
    ON DELETE Set NULL
    ON UPDATE Cascade,
  INDEX `fk_restock_trip_idx1` (`tripID` ASC),
  CONSTRAINT `fk_restock_trip1`
    FOREIGN KEY (`tripID`)
    REFERENCES `dataetna`.`trip` (`tripID`)
    ON DELETE Set NULL
    ON UPDATE Cascade,
  INDEX `fk_restock_parking_idx1` (`pickUpParkingID` ASC),
  CONSTRAINT `fk_restock_parking1`
    FOREIGN KEY (`pickUpParkingID`)
    REFERENCES `dataetna`.`parking` (`parkingID`)
    ON DELETE Set NULL
    ON UPDATE Cascade,
  INDEX `fk_restock_parking_idx2` (`DepositParkingID` ASC),
  CONSTRAINT `fk_restock_parking2`
    FOREIGN KEY (`DepositParkingID`)
    REFERENCES `dataetna`.`parking` (`parkingID`)
    ON DELETE Set NULL
    ON UPDATE Cascade)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;