-- ETL with Azure Cookbook
-- Chapter 3 T-SQL Script, Cloud

-- I. Create objects
USE Staging;
GO

CREATE TABLE dbo.ExistingPeople
 (
 EmailAddress nvarchar(256) NOT NULL,
 CONSTRAINT PK_dbo_ExistingPeople
  PRIMARY KEY CLUSTERED
   (
   EmailAddress
   )
 );
GO

SELECT *
  FROM dbo.ExistingPeople;
GO

CREATE EXTERNAL TABLE dbo.UnknownPeople
 (
 FirstName nvarchar(50) NOT NULL,
 LastName nvarchar(50) NOT NULL,
 EmailAddress nvarchar(256) NOT NULL
 )
 WITH
  (
  LOCATION = N'/UnknownPeople',
  DATA_SOURCE = SqlStoragePool,
  FILE_FORMAT = FileFormat_NewPeople
  );
GO

SELECT *
  FROM dbo.UnknownPeople;
GO

-- Remove Existing Data before Loading
TRUNCATE TABLE dbo.ExistingPeople;

SELECT *
  FROM dbo.NewPeople;
GO


-- II. Clean up
-- Clean up
-- Only use the following statements if you want to remove
-- the database objects created in this chapter.
USE Staging;
DROP TABLE dbo.ExistingPeople;
DROP EXTERNAL TABLE dbo.UnknownPeople
GO
