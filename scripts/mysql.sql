CREATE DATABASE SalesDB;

USE SalesDB;

-- for example only, please use a good password in production!!
SET GLOBAL validate_password.policy=LOW;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;

CREATE USER 'salesuser'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
GRANT ALL ON `SalesDB`.* TO 'salesuser'@'localhost';

CREATE TABLE `Roles` (
    `ID` INT PRIMARY KEY AUTO_INCREMENT,
    `RoleName` MEDIUMTEXT NOT NULL
);

CREATE TABLE `Users` (
    `ID` INT PRIMARY KEY AUTO_INCREMENT,
    `Username` MEDIUMTEXT NOT NULL, 
    `Email` MEDIUMTEXT NOT NULL, 
    `GivenName` MEDIUMTEXT NOT NULL, 
    `Surname` MEDIUMTEXT NOT NULL
);

CREATE TABLE `UserRoles` (
    `ID` INT PRIMARY KEY AUTO_INCREMENT,
    `UserID` INT NOT NULL,
    `RoleID` INT NOT NULL,
    FOREIGN KEY (`UserID`) REFERENCES `Users`(`ID`),
    FOREIGN KEY (`RoleID`) REFERENCES `Roles`(`ID`)
);

CREATE TABLE `InventoryCategories` (
    `ID` INT PRIMARY KEY AUTO_INCREMENT,
    `CategoryName` MEDIUMTEXT NOT NULL,
    `CategoryDescription` MEDIUMTEXT
);

CREATE TABLE `Inventory` (
    `ID` INT PRIMARY KEY AUTO_INCREMENT,
    `ItemCategory` INT NOT NULL, 
    `ItemName` MEDIUMTEXT NOT NULL, 
    `ItemDescription` MEDIUMTEXT,
    `ItemPrice` FLOAT NOT NULL,
    `StockLevel` INT NOT NULL,
    FOREIGN KEY (`ItemCategory`) REFERENCES `InventoryCategories`(`ID`)
);

CREATE TABLE `Sales` (
    `ID` INT PRIMARY KEY AUTO_INCREMENT,
    `CashierID` INT NOT NULL, 
    `DatetimeOfPurchase` DATETIME NOT NULL, 
    `Voided` BIT NOT NULL DEFAULT 0, 
    FOREIGN KEY (`CashierID`) REFERENCES `Users`(`ID`)
);

CREATE TABLE `SalesItems` (
    `ID` INT PRIMARY KEY AUTO_INCREMENT,
    `SaleID` INT NOT NULL, 
    `InventoryID` INT NOT NULL, 
    `ItemQuantity` INT NOT NULL, 
    `TimeOfSalePrice` FLOAT, 
    FOREIGN KEY (`SaleID`) REFERENCES `Sales`(`ID`), 
    FOREIGN KEY (`InventoryID`) REFERENCES `Inventory`(`ID`)
);
