SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CSVConfig](
	[CSVName] [nvarchar](50) NULL,
	[CityName] [nvarchar](256) NULL,
  [State] [nvarchar](256) NULL
) ON [PRIMARY]

GO

INSERT INTO [dbo].[CSVConfig] ([CSVName],[CityName],[State])
VALUES
( 'KCLT.csv','Charlotte','NC'),
( 'KCQT.csv','LosAngeles','CA'),
( 'KHOU.csv','Houston','TX'),
( 'KIND.csv','Indianapolis','IN'),
( 'KJAX.csv','Jacksonville','FL'),
( 'KMDW.csv','Chicago','IL'),
( 'KNYC.csv','NewYork','NY'),
( 'KPHL.csv','Philiadelphia','PA'),
( 'KPHX.csv','Phoenix','AZ'),
( 'KSEA.csv','Seattle','WA')
