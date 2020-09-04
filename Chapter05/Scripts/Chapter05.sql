-- ETL with Azure Cookbook
-- Chapter 5 T-SQL Script

-- I. Monitor active connections
USE master
GO

SELECT dm_exec_sessions.session_id,
       dm_exec_sessions.login_time,
       dm_exec_sessions.[program_name]
  FROM sys.dm_exec_sessions
 WHERE (dm_exec_sessions.session_id != @@spid)
       AND (dm_exec_sessions.[program_name] = N'ApplicationNameTaskTest')

SELECT dm_exec_sessions.session_id,
       dm_exec_sessions.login_time,
       dm_exec_sessions.[program_name]
  FROM sys.dm_exec_sessions
 WHERE (dm_exec_sessions.session_id != @@spid)
       AND (dm_exec_sessions.[program_name] like N'Some%Client')
GO


-- II. Create objects
USE master;
GO

-- Create a new database
CREATE DATABASE	WideWorldAnalysis;
GO

-- Connect to the new database
USE WideWorldAnalysis;
GO

-- Create new schemas
CREATE SCHEMA DW
 AUTHORIZATION dbo;
GO
CREATE SCHEMA ETL
 AUTHORIZATION dbo;
GO

-- Create destination table
CREATE TABLE DW.PurchaseOrders
 (
 PurchaseOrderID int NOT NULL,
 SupplierID int NOT NULL,
 OrderDate date NOT NULL,
 DeliveryMethodID int NOT NULL,
 ContactPersonID int NOT NULL,
 ExpectedDeliveryDate date NULL,
 SupplierReference nvarchar(20) NULL,
 IsOrderFinalized bit NOT NULL,
 Comments nvarchar(max) NULL,
 InternalComments nvarchar(max) NULL,
 LastEditedBy int NOT NULL,
 LastEditedWhen datetime2(7) NOT NULL,
 RowHash varbinary(20) NOT NULL,
 CONSTRAINT PK_DW_PurchaseOrders
  PRIMARY KEY CLUSTERED 
  (
  PurchaseOrderID ASC
  )
 );
GO

-- Create two staging tables
-- ... one for new rows
CREATE TABLE ETL.PurchaseOrders_New
 (
 PurchaseOrderID int NOT NULL,
 SupplierID int NOT NULL,
 OrderDate date NOT NULL,
 DeliveryMethodID int NOT NULL,
 ContactPersonID int NOT NULL,
 ExpectedDeliveryDate date NULL,
 SupplierReference nvarchar(20) NULL,
 IsOrderFinalized bit NOT NULL,
 Comments nvarchar(max) NULL,
 InternalComments nvarchar(max) NULL,
 LastEditedBy int NOT NULL,
 LastEditedWhen datetime2(7) NOT NULL,
 RowHash varbinary(20) NOT NULL,
 CONSTRAINT PK_DW_PurchaseOrders_New
  PRIMARY KEY CLUSTERED 
  (
  PurchaseOrderID ASC
  )
 );
GO

-- ... one for modified rows
CREATE TABLE ETL.PurchaseOrders_Modified
 (
 PurchaseOrderID int NOT NULL,
 SupplierID int NOT NULL,
 OrderDate date NOT NULL,
 DeliveryMethodID int NOT NULL,
 ContactPersonID int NOT NULL,
 ExpectedDeliveryDate date NULL,
 SupplierReference nvarchar(20) NULL,
 IsOrderFinalized bit NOT NULL,
 Comments nvarchar(max) NULL,
 InternalComments nvarchar(max) NULL,
 LastEditedBy int NOT NULL,
 LastEditedWhen datetime2(7) NOT NULL,
 RowHash varbinary(20) NOT NULL,
 CONSTRAINT PK_DW_PurchaseOrders_Modified
  PRIMARY KEY CLUSTERED 
  (
  PurchaseOrderID ASC
  )
 );
GO


-- III. Data check
USE WideWorldAnalysis;
GO

SELECT *
  FROM ETL.PurchaseOrders_New;

SELECT *
  FROM ETL.PurchaseOrders_Modified;

SELECT *
  FROM DW.PurchaseOrders;
GO


-- IV. Data maintenance
-- Execute these statements after the initial run of the RowHashTest.dtsx SSIS Package.
USE WideWorldImporters;
GO

UPDATE Purchasing.PurchaseOrders
   SET PurchaseOrders.ExpectedDeliveryDate = CAST('2013-03-12' AS DATE)
 WHERE (PurchaseOrders.PurchaseOrderID IN (14, 15, 16));

UPDATE Purchasing.PurchaseOrders
   SET PurchaseOrders.SupplierReference = N'290392'
 WHERE (PurchaseOrders.PurchaseOrderID = 301);

UPDATE Purchasing.PurchaseOrders
   SET PurchaseOrders.ExpectedDeliveryDate = CAST('2014-06-15' AS DATE),
       PurchaseOrders.SupplierReference = N'BC0289082',
       PurchaseOrders.Comments = N'Delivery delayed'
 WHERE (PurchaseOrders.PurchaseOrderID = 802);
GO


-- V. Revert data modifications
-- Execute these statements if you want to return the WideWorldImporters data to its original state.
USE WideWorldImporters;
GO

UPDATE Purchasing.PurchaseOrders
   SET PurchaseOrders.ExpectedDeliveryDate = CAST('2013-01-23' AS DATE)
 WHERE (PurchaseOrders.PurchaseOrderID IN (14, 15, 16));

UPDATE Purchasing.PurchaseOrders
   SET PurchaseOrders.SupplierReference = N'293092'
 WHERE (PurchaseOrders.PurchaseOrderID = 301);

UPDATE Purchasing.PurchaseOrders
   SET PurchaseOrders.ExpectedDeliveryDate = CAST('2014-05-19' AS DATE),
       PurchaseOrders.SupplierReference = N'BC0280982',
       PurchaseOrders.Comments = NULL
 WHERE (PurchaseOrders.PurchaseOrderID = 802);
GO


-- VI. Cleanup
-- Only use the following statements if you want to remove
-- the database created in this chapter.
USE master;
GO
DROP DATABASE	WideWorldAnalysis;
GO
