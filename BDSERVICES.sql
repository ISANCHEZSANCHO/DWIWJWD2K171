-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, 

FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, 

SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema bdservices
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bdservices
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bdservices` DEFAULT CHARACTER SET utf8 ;
USE `bdservices` ;

-- -----------------------------------------------------
-- Table `bdservices`.`administrator`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdservices`.`administrator` (
  `id_administrator` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_administrator`),
  UNIQUE INDEX `idadministrator_UNIQUE` (`id_administrator` ASC),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdservices`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdservices`.`customer` (
  `id_customer` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `category` VARCHAR(45) NOT NULL,
  `phone` INT NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `email` NVARCHAR(45) NOT NULL,
  `age` INT(2) NOT NULL,
  `district` VARCHAR(45) NOT NULL,
  `card_info` VARCHAR(45) NOT NULL,
  `id_administrator` INT NOT NULL,
  PRIMARY KEY (`id_customer`),
  UNIQUE INDEX `idcustomer_UNIQUE` (`id_customer` ASC),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  INDEX `administrator_idx` (`id_administrator` ASC),
  CONSTRAINT `administrator`
    FOREIGN KEY (`id_administrator`)
    REFERENCES `bdservices`.`administrator` (`id_administrator`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdservices`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdservices`.`orders` (
  `id_order` INT NOT NULL AUTO_INCREMENT,
  `date_created` DATETIME NOT NULL,
  `date_service` DATETIME NOT NULL,
  `status` VARCHAR(60) NOT NULL,
  `id_customer` INT NOT NULL,
  PRIMARY KEY (`id_order`),
  UNIQUE INDEX `id_order_UNIQUE` (`id_order` ASC),
  INDEX `customer_idx` (`id_customer` ASC),
  CONSTRAINT `customer`
    FOREIGN KEY (`id_customer`)
    REFERENCES `bdservices`.`customer` (`id_customer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdservices`.`order_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdservices`.`order_details` (
  `id_order_details` INT NOT NULL,
  `service_name` VARCHAR(45) NOT NULL,
  `price` FLOAT NOT NULL,
  `id_order` INT NOT NULL,
  PRIMARY KEY (`id_order_details`),
  UNIQUE INDEX `id_order_details_UNIQUE` (`id_order_details` ASC),
  INDEX `orders_idx` (`id_order` ASC),
  CONSTRAINT `orders`
    FOREIGN KEY (`id_order`)
    REFERENCES `bdservices`.`orders` (`id_order`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdservices`.`payment_method`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdservices`.`payment_method` (
  `id_payment_method` INT NOT NULL,
  `type_payment` VARCHAR(45) NOT NULL,
  `id_order_details` INT NOT NULL,
  PRIMARY KEY (`id_payment_method`),
  UNIQUE INDEX `id_payment_method_UNIQUE` (`id_payment_method` ASC),
  INDEX `order_details_idx` (`id_order_details` ASC),
  CONSTRAINT `order_details`
    FOREIGN KEY (`id_order_details`)
    REFERENCES `bdservices`.`order_details` (`id_order_details`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
