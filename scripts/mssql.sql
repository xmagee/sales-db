USE master;

CREATE DATABASE [SalesDB];

USE [SalesDB];

CREATE LOGIN [SalesDBSQLLogin] WITH PASSWORD = 'Password123';

CREATE USER [SalesDBSQLUser] FOR LOGIN [SalesDBSQLLogin];
EXEC sp_addrolemember N'db_datareader', N'SalesDBSQLUser';
EXEC sp_addrolemember N'db_datawriter', N'SalesDBSQLUser';

CREATE TABLE [Roles] (
    [ID] INT IDENTITY(1,1) PRIMARY KEY,
    [RoleName] NVARCHAR(MAX) NOT NULL
);

CREATE TABLE [Users] (
    [ID] INT IDENTITY(1,1) PRIMARY KEY,
    [Username] NVARCHAR(MAX) NOT NULL, 
    [Email] NVARCHAR(MAX) NOT NULL, 
    [GivenName] NVARCHAR(MAX) NOT NULL, 
    [Surname] NVARCHAR(MAX) NOT NULL
);

CREATE TABLE [UserRoles] (
    [ID] INT IDENTITY(1,1) PRIMARY KEY,
    [UserID] INT NOT NULL,
    [RoleID] INT NOT NULL,
    FOREIGN KEY ([UserID]) REFERENCES [Users]([ID]),
    FOREIGN KEY ([RoleID]) REFERENCES [Roles]([ID])
);

CREATE TABLE [InventoryCategories] (
    [ID] INT IDENTITY(1,1) PRIMARY KEY,
    [CategoryName] NVARCHAR(MAX) NOT NULL,
    [CategoryDescription] NVARCHAR(MAX)
);

CREATE TABLE [Inventory] (
    [ID] INT IDENTITY(1,1) PRIMARY KEY,
    [ItemCategory] INT NOT NULL, 
    [ItemName] NVARCHAR(MAX) NOT NULL, 
    [ItemDescription] NVARCHAR(MAX),
    [ItemPrice] FLOAT NOT NULL,
    [StockLevel] INT NOT NULL,
    FOREIGN KEY ([ItemCategory]) REFERENCES [InventoryCategories]([ID])
);

CREATE TABLE [Sales] (
    [ID] INT IDENTITY(1,1) PRIMARY KEY,
    [CashierID] INT NOT NULL, 
    [DatetimeOfPurchase] DATETIME NOT NULL, 
    [Voided] BIT NOT NULL DEFAULT 0, 
    FOREIGN KEY ([CashierID]) REFERENCES [Users]([ID])
);

CREATE TABLE [SalesItems] (
    [ID] INT IDENTITY(1,1) PRIMARY KEY,
    SaleID INT NOT NULL, 
    InventoryID INT NOT NULL, 
    ItemQuantity INT NOT NULL, 
    TimeOfSalePrice FLOAT, 
    FOREIGN KEY ([SaleID]) REFERENCES [Sales]([ID]), 
    FOREIGN KEY ([InventoryID]) REFERENCES [Inventory]([ID])
);
