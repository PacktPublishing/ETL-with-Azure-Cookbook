-- ETL with Azure Cookbook
-- Chapter 3 T-SQL Script, On premises

-- I. Create objects
USE WideWorldImporters;
GO

-- Create Application.NewPeople_List procedure
CREATE OR ALTER PROC Application.NewPeople_List
AS
BEGIN
 CREATE TABLE #CompletePeople
   (
   CompletePeopleId INT IDENTITY(1, 1) NOT NULL,
   FirstName NVARCHAR(50) COLLATE DATABASE_DEFAULT NOT NULL,
   LastName NVARCHAR(50) COLLATE DATABASE_DEFAULT NOT NULL,
   EmailAddress NVARCHAR(256) COLLATE DATABASE_DEFAULT NOT NULL,
   PRIMARY KEY CLUSTERED
    (
    CompletePeopleId
    ),
   UNIQUE NONCLUSTERED
    (
    EmailAddress,
    CompletePeopleId
    )
   );

 BEGIN
  WITH People
  AS
  (
  SELECT TRIM(REPLACE(People.FullName, People.PreferredName, N'')) AS LastName,
         TRIM(People.PreferredName) AS FirstName,
         SUBSTRING(People.EmailAddress, CHARINDEX(N'@', People.EmailAddress), LEN(People.EmailAddress)) AS EmailDomain
    FROM Application.People
   WHERE (People.EmailAddress IS NOT NULL)
  ),
  NewPeople
  AS
  (
  SELECT This.FirstName AS FirstName,
         That.LastName AS LastName,
         This.EmailDomain AS EmailDomain
    FROM People This
         CROSS JOIN People That
  )
  INSERT #CompletePeople
   (
   FirstName,
   LastName,
   EmailAddress
   )
   SELECT CAST(NewPeople.FirstName AS NVARCHAR(50)) AS FirstName,
          CAST(NewPeople.LastName AS NVARCHAR(50)) AS LastName,
          CAST(REPLACE(LOWER(NewPeople.FirstName + NewPeople.LastName) + NewPeople.EmailDomain, N' ', N'') AS NVARCHAR(256)) AS EmailAddress
     FROM NewPeople
    WHERE (NewPeople.FirstName IS NOT NULL)
          AND (NewPeople.FirstName <> N'')
          AND (NewPeople.LastName IS NOT NULL)
          AND (NewPeople.LastName <> N'')
   UNION
   SELECT TRIM(REPLACE(People.FullName, People.PreferredName, N'')),
          TRIM(People.PreferredName),
          People.EmailAddress
     FROM Application.People
     WHERE (TRIM(REPLACE(People.FullName, People.PreferredName, N'')) <> N'')
           AND (People.EmailAddress IS NOT NULL)
    OPTION (
           FORCE ORDER
           );
 END

 BEGIN
  WITH DuplicateEmail
  AS
  (
  SELECT CompletePeople.FirstName,
         CompletePeople.LastName,
         CompletePeople.EmailAddress,
         PeopleGroup
          = ROW_NUMBER()
           OVER
            (
            PARTITION BY CompletePeople.EmailAddress
            ORDER BY CompletePeople.LastName, CompletePeople.FirstName
            )
    FROM #CompletePeople CompletePeople
  )
  SELECT DuplicateEmail.FirstName,
         DuplicateEmail.LastName,
         DuplicateEmail.EmailAddress
    FROM DuplicateEmail
   WHERE (DuplicateEmail.PeopleGroup = 1);
 END

 DROP TABLE #CompletePeople;

 RETURN 0;
END
GO

-- Execute Application.NewPeople_List procedure
EXEC Application.NewPeople_List
 WITH RESULT SETS
  (
   (
   FirstName NVARCHAR(50) COLLATE DATABASE_DEFAULT NOT NULL,
   LastName NVARCHAR(50) COLLATE DATABASE_DEFAULT NOT NULL,
   EmailAddress NVARCHAR(256) COLLATE DATABASE_DEFAULT NOT NULL
   )
  );
GO

-- Create Application.UnknownPeople Table
CREATE TABLE Application.UnknownPeople
 (
 FullName nvarchar(50) NOT NULL,
 EmailAddress nvarchar(256) NOT NULL,
 CONSTRAINT PK_Application_UnknownPeople
  PRIMARY KEY CLUSTERED
   (
   EmailAddress
   )
 );
GO

-- Check Application.UnknownPeople data
SELECT *
  FROM Application.UnknownPeople;
GO


-- II. Clean up
-- Only use the following statements if you want to remove
-- the database objects created in this chapter.
USE WideWorldImporters;
DROP TABLE Application.UnknownPeople;
DROP PROC Application.NewPeople_List;
GO
