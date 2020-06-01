CREATE SCHEMA Data538
AUTHORIZATION dbo
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Data538].[Charlotte](
	[city] [nvarchar](256) NULL DEFAULT('Charlotte'),
	[weatherstationcode] [nvarchar](6) NULL DEFAULT('KCLT'),
	[state] [nvarchar](2) NULL DEFAULT('NC'),
	[date] [nvarchar](60) NULL,
	[actual_mean_temp] [nvarchar](60) NULL,
	[actual_min_temp] [nvarchar](60) NULL,
	[actual_max_temp] [nvarchar](60) NULL,
	[average_min_temp] [nvarchar](60) NULL,
	[average_max_temp] [nvarchar](60) NULL,
	[record_min_temp] [nvarchar](60) NULL,
	[record_max_temp] [nvarchar](60) NULL,
	[record_min_temp_year] [nvarchar](60) NULL,
	[record_max_temp_year] [nvarchar](60) NULL,
	[actual_precipitation] [nvarchar](60) NULL,
	[average_precipitation] [nvarchar](60) NULL,
	[record_precipitation] [nvarchar](60) NULL
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Data538].[LosAngeles](
	[city] [nvarchar](256) NULL DEFAULT('LosAngeles'),
	[weatherstationcode] [nvarchar](6) NULL DEFAULT('KCQT'),
	[state] [nvarchar](2) NULL DEFAULT('CA'),
	[date] [nvarchar](60) NULL,
	[actual_mean_temp] [nvarchar](60) NULL,
	[actual_min_temp] [nvarchar](60) NULL,
	[actual_max_temp] [nvarchar](60) NULL,
	[average_min_temp] [nvarchar](60) NULL,
	[average_max_temp] [nvarchar](60) NULL,
	[record_min_temp] [nvarchar](60) NULL,
	[record_max_temp] [nvarchar](60) NULL,
	[record_min_temp_year] [nvarchar](60) NULL,
	[record_max_temp_year] [nvarchar](60) NULL,
	[actual_precipitation] [nvarchar](60) NULL,
	[average_precipitation] [nvarchar](60) NULL,
	[record_precipitation] [nvarchar](60) NULL
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Data538].[Houston](
	[city] [nvarchar](256) NULL DEFAULT('Houston'),
	[weatherstationcode] [nvarchar](6) NULL DEFAULT('KHOU'),
	[state] [nvarchar](2) NULL DEFAULT('TX'),
	[date] [nvarchar](60) NULL,
	[actual_mean_temp] [nvarchar](60) NULL,
	[actual_min_temp] [nvarchar](60) NULL,
	[actual_max_temp] [nvarchar](60) NULL,
	[average_min_temp] [nvarchar](60) NULL,
	[average_max_temp] [nvarchar](60) NULL,
	[record_min_temp] [nvarchar](60) NULL,
	[record_max_temp] [nvarchar](60) NULL,
	[record_min_temp_year] [nvarchar](60) NULL,
	[record_max_temp_year] [nvarchar](60) NULL,
	[actual_precipitation] [nvarchar](60) NULL,
	[average_precipitation] [nvarchar](60) NULL,
	[record_precipitation] [nvarchar](60) NULL
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Data538].[Indianapolis](
	[city] [nvarchar](256) NULL DEFAULT('Indianapolis'),
	[weatherstationcode] [nvarchar](6) NULL DEFAULT('KIND'),
	[state] [nvarchar](2) NULL DEFAULT('IN'),
	[date] [nvarchar](60) NULL,
	[actual_mean_temp] [nvarchar](60) NULL,
	[actual_min_temp] [nvarchar](60) NULL,
	[actual_max_temp] [nvarchar](60) NULL,
	[average_min_temp] [nvarchar](60) NULL,
	[average_max_temp] [nvarchar](60) NULL,
	[record_min_temp] [nvarchar](60) NULL,
	[record_max_temp] [nvarchar](60) NULL,
	[record_min_temp_year] [nvarchar](60) NULL,
	[record_max_temp_year] [nvarchar](60) NULL,
	[actual_precipitation] [nvarchar](60) NULL,
	[average_precipitation] [nvarchar](60) NULL,
	[record_precipitation] [nvarchar](60) NULL
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Data538].[Jacksonville](
	[city] [nvarchar](256) NULL DEFAULT('Jacksonville'),
	[weatherstationcode] [nvarchar](6) NULL DEFAULT('KJAX'),
	[state] [nvarchar](2) NULL DEFAULT('FL'),
	[date] [nvarchar](60) NULL,
	[actual_mean_temp] [nvarchar](60) NULL,
	[actual_min_temp] [nvarchar](60) NULL,
	[actual_max_temp] [nvarchar](60) NULL,
	[average_min_temp] [nvarchar](60) NULL,
	[average_max_temp] [nvarchar](60) NULL,
	[record_min_temp] [nvarchar](60) NULL,
	[record_max_temp] [nvarchar](60) NULL,
	[record_min_temp_year] [nvarchar](60) NULL,
	[record_max_temp_year] [nvarchar](60) NULL,
	[actual_precipitation] [nvarchar](60) NULL,
	[average_precipitation] [nvarchar](60) NULL,
	[record_precipitation] [nvarchar](60) NULL
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Data538].[Chicago](
	[city] [nvarchar](256) NULL DEFAULT('Chicago'),
	[weatherstationcode] [nvarchar](6) NULL DEFAULT('KMDW'),
	[state] [nvarchar](2) NULL DEFAULT('IL'),
	[date] [nvarchar](60) NULL,
	[actual_mean_temp] [nvarchar](60) NULL,
	[actual_min_temp] [nvarchar](60) NULL,
	[actual_max_temp] [nvarchar](60) NULL,
	[average_min_temp] [nvarchar](60) NULL,
	[average_max_temp] [nvarchar](60) NULL,
	[record_min_temp] [nvarchar](60) NULL,
	[record_max_temp] [nvarchar](60) NULL,
	[record_min_temp_year] [nvarchar](60) NULL,
	[record_max_temp_year] [nvarchar](60) NULL,
	[actual_precipitation] [nvarchar](60) NULL,
	[average_precipitation] [nvarchar](60) NULL,
	[record_precipitation] [nvarchar](60) NULL
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Data538].[NewYork](
	[city] [nvarchar](256) NULL DEFAULT('NewYork'),
	[weatherstationcode] [nvarchar](6) NULL DEFAULT('KNYC'),
	[state] [nvarchar](2) NULL DEFAULT('NY'),
	[date] [nvarchar](60) NULL,
	[actual_mean_temp] [nvarchar](60) NULL,
	[actual_min_temp] [nvarchar](60) NULL,
	[actual_max_temp] [nvarchar](60) NULL,
	[average_min_temp] [nvarchar](60) NULL,
	[average_max_temp] [nvarchar](60) NULL,
	[record_min_temp] [nvarchar](60) NULL,
	[record_max_temp] [nvarchar](60) NULL,
	[record_min_temp_year] [nvarchar](60) NULL,
	[record_max_temp_year] [nvarchar](60) NULL,
	[actual_precipitation] [nvarchar](60) NULL,
	[average_precipitation] [nvarchar](60) NULL,
	[record_precipitation] [nvarchar](60) NULL
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Data538].[Philiadelphia](
	[city] [nvarchar](256) NULL DEFAULT('Philiadelphia'),
	[weatherstationcode] [nvarchar](6) NULL DEFAULT('KPHL'),
	[state] [nvarchar](2) NULL DEFAULT('PA'),
	[date] [nvarchar](60) NULL,
	[actual_mean_temp] [nvarchar](60) NULL,
	[actual_min_temp] [nvarchar](60) NULL,
	[actual_max_temp] [nvarchar](60) NULL,
	[average_min_temp] [nvarchar](60) NULL,
	[average_max_temp] [nvarchar](60) NULL,
	[record_min_temp] [nvarchar](60) NULL,
	[record_max_temp] [nvarchar](60) NULL,
	[record_min_temp_year] [nvarchar](60) NULL,
	[record_max_temp_year] [nvarchar](60) NULL,
	[actual_precipitation] [nvarchar](60) NULL,
	[average_precipitation] [nvarchar](60) NULL,
	[record_precipitation] [nvarchar](60) NULL
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Data538].[Phoenix](
	[city] [nvarchar](256) NULL DEFAULT('Phoenix'),
	[weatherstationcode] [nvarchar](6) NULL DEFAULT('KPHX'),
	[state] [nvarchar](2) NULL DEFAULT('AZ'),
	[date] [nvarchar](60) NULL,
	[actual_mean_temp] [nvarchar](60) NULL,
	[actual_min_temp] [nvarchar](60) NULL,
	[actual_max_temp] [nvarchar](60) NULL,
	[average_min_temp] [nvarchar](60) NULL,
	[average_max_temp] [nvarchar](60) NULL,
	[record_min_temp] [nvarchar](60) NULL,
	[record_max_temp] [nvarchar](60) NULL,
	[record_min_temp_year] [nvarchar](60) NULL,
	[record_max_temp_year] [nvarchar](60) NULL,
	[actual_precipitation] [nvarchar](60) NULL,
	[average_precipitation] [nvarchar](60) NULL,
	[record_precipitation] [nvarchar](60) NULL
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Data538].[Seattle](
	[city] [nvarchar](256) NULL DEFAULT('Seattle'),
	[weatherstationcode] [nvarchar](6) NULL DEFAULT('KSEA'),
	[state] [nvarchar](2) NULL DEFAULT('WA'),
	[date] [nvarchar](60) NULL,
	[actual_mean_temp] [nvarchar](60) NULL,
	[actual_min_temp] [nvarchar](60) NULL,
	[actual_max_temp] [nvarchar](60) NULL,
	[average_min_temp] [nvarchar](60) NULL,
	[average_max_temp] [nvarchar](60) NULL,
	[record_min_temp] [nvarchar](60) NULL,
	[record_max_temp] [nvarchar](60) NULL,
	[record_min_temp_year] [nvarchar](60) NULL,
	[record_max_temp_year] [nvarchar](60) NULL,
	[actual_precipitation] [nvarchar](60) NULL,
	[average_precipitation] [nvarchar](60) NULL,
	[record_precipitation] [nvarchar](60) NULL
) ON [PRIMARY]
GO

    
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [Data538].[weather] AS
SELECT * FROM 
[Data538].[Charlotte]
UNION
SELECT * FROM 
[Data538].[LosAngeles]
UNION
SELECT * FROM 
[Data538].[Houston]
UNION
SELECT * FROM 
[Data538].[Indianapolis]
UNION
SELECT * FROM 
[Data538].[Jacksonville]
UNION
SELECT * FROM 
[Data538].[Chicago]
UNION
SELECT * FROM 
[Data538].[NewYork]
UNION
SELECT * FROM 
[Data538].[Philiadelphia]
UNION
SELECT * FROM 
[Data538].[Phoenix]
UNION
SELECT * FROM 
[Data538].[Seattle]
