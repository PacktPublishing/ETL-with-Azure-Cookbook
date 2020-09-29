# ETL with Azure Cookbook

<a href="https://www.packtpub.com/product/etl-with-azure-cookbook/9781800203310?utm_source=github&utm_medium=repository&utm_campaign=9781800203310"><img src="https://static.packt-cdn.com/products/9781800203310/cover/smaller" alt="ETL with Azure Cookbook" height="256px" align="right"></a>

This is the code repository for [ETL with Azure Cookbook](https://www.packtpub.com/product/etl-with-azure-cookbook/9781800203310?utm_source=github&utm_medium=repository&utm_campaign=9781800203310), published by Packt.

**Practical recipes for building modern ETL solutions to load and transform data from any source**

## What is this book about?
ETL is one of the most common and tedious procedures for moving and processing data from one database to another. With the help of this book, you will be able to speed up the process by designing effective ETL solutions using the Azure services available for handling and transforming any data to suit your requirements.

With this cookbook, you’ll become well versed in all the features of SQL Server Integration Services (SSIS) to perform data migration and ETL tasks that integrate with Azure. You’ll learn how to transform data in Azure and understand how legacy systems perform ETL on-premises using SSIS. Later chapters will get you up to speed with connecting and retrieving data from SQL Server 2019 Big Data Clusters, and even show you how to extend and customize the SSIS toolbox using custom-developed tasks and transforms. This ETL book also contains practical recipes for moving and transforming data with Azure services, such as Data Factory and Azure Databricks, and lets you explore various options for migrating SSIS packages to Azure. Toward the end, you’ll find out how to profile data in the cloud and automate service creation with Business Intelligence Markup Language (BIML).

By the end of this book, you’ll have developed the skills you need to create and automate ETL solutions on-premises as well as in Azure.

In this repo, you will find the code examples used in the book. I also include here parts of the code omitted in the book, such as the data visualization styling, additional formatting, etc.

This book covers the following exciting features: 
* Explore ETL and how it is different from ELT
* Move and transform various data sources with Azure ETL and ELT services
* Use SSIS 2019 with Azure HDInsight clusters
* Discover how to query SQL Server 2019 Big Data Clusters hosted in Azure
* Migrate SSIS solutions to Azure and solve key challenges associated with it
* Understand why data profiling is crucial and how to implement it in Azure Databricks
* Get to grips with BIML and learn how it applies to SSIS and Azure Data Factory solutions

If you feel this book is for you, get your [copy](https://www.amazon.com/dp/1800203314) today!

<a href="https://www.packtpub.com/?utm_source=github&utm_medium=banner&utm_campaign=GitHubBanner"><img src="https://raw.githubusercontent.com/PacktPublishing/GitHub/master/GitHub.png" alt="https://www.packtpub.com/" border="5" /></a>

## Instructions and Navigations
All of the code is organized into folders.

The code will look like the following:
```
INSERT OVERWRITE TABLE ETLInAzure.SalesAgg
SELECT storename , zipcode , SUM(unitcost) AS unitcost,
AVG(unitprice) AS unitprice, SUM(salesamount) AS salesamount,
SUM(salesquantity) AS salesquantity, CalendarMonth
FROM etlinazure.salesource
GROUP BY storename, zipcode, CalendarMonth;
```

**Following is what you need for this book:**
This book is for data warehouse architects, ETL developers, or anyone who wants to build scalable ETL applications in Azure. Those looking to extend their existing on-premise ETL applications to use big data and a variety of Azure services or others interested in migrating existing on-premise solutions to the Azure cloud platform will also find the book useful. Familiarity with SQL Server services is necessary to get the most out of this book.

With the following software and hardware list you can run all code files present in the book (Chapter 1-10).

### Software and Hardware List

| Chapter  | Software required                                                                    | OS required                        |
| -------- | -------------------------------------------------------------------------------------| -----------------------------------|
| 1 - 10   |   Azure, SQL Server 2019, Visual Studio 2019, Azure Data Explorer                    | Windows, Mac OS X, and Linux (Any) |
|          |   SQL Server Management Server, Azure Data Studio                                    |                                    |


We also provide a PDF file that has color images of the screenshots/diagrams used in this book. [Click here to download it](https://static.packt-cdn.com/downloads/9781800203310_ColorImages.pdf).


### Related products <Other books you may enjoy>
* SQL Server 2019 Administrator's Guide - Second Edition [[Packt]](https://www.packtpub.com/product/sql-server-2019-administrator-s-guide-second-edition/9781789954326) [[Amazon]](https://www.amazon.com/dp/B08D9CDC9L)

* Mastering Azure Machine Learning [[Packt]](https://www.packtpub.com/product/mastering-azure-machine-learning/9781789807554) [[Amazon]](https://www.amazon.com/dp/1789807557)

## Get to Know the Author
**Christian Cote** 
is an IT professional with more than 15 years of experience working on data warehouse, big data, and business intelligence projects. Christian has developed expertise in data warehousing and data lakes over the years and has designed many ETL/BI processes using a range of tools on multiple platforms. He's presented at several conferences and code camps. He currently co-leads the SQL Server PASS chapter. He is also a Microsoft Data Platform Most Valuable Professional (MVP).

**Matija Lah** 
has more than 18 years of experience working with Microsoft SQL Server, mostly from architecting data-centric solutions in the legal domain. His contributions to the SQL Server community have led to him being awarded the Microsoft MVP award (Data Platform) between 2007 and 2017/2018. He spends most of his time on projects involving advanced information management and natural language processing, but often finds time to speak at events related to Microsoft SQL Server where he loves to share his experience with the SQL Server platform.

**Madina Saitakhmetova** 
is a developer specializing in BI. She has been in IT for 15 years, working with Microsoft SQL, .NET, Microsoft BI, Azure, and building BI solutions for medical, educational, and engineering companies. Her adventure with Microsoft BI began with Analysis Services and SSIS, and in later years she has been building her expertise in ETL/ELT, both on-premises and in the cloud. Finding patterns, automating processes, and making BI teams work more efficiently are challenges that drive her. During the past few years, BIML has become an important part of her work, increasing its efficiency and quality.

