CREATE DATABASE [BIMLmetadata]
GO

USE [BIMLmetadata]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TableConfig](
	[TableType] [nvarchar](50) NULL,
	[SchemaName] [nvarchar](256) NULL,
	[TableName] [nvarchar](256) NULL,
	[StagingTableName] [nvarchar](256) NULL,
	[GetStoredProc] [nvarchar](256) NULL,
	[MigrateStoredProc] [nvarchar](256) NULL,
	[TableOrder] [int] NULL
) ON [PRIMARY]
GO

INSERT [dbo].[TableConfig] ([TableType], [SchemaName], [TableName], [StagingTableName], [GetStoredProc], [MigrateStoredProc], [TableOrder]) VALUES (N'Dimension', N'Dimension', N'City', N'City_Staging', N'GetCityUpdates', N'MigrateStagedCityData', 1)
INSERT [dbo].[TableConfig] ([TableType], [SchemaName], [TableName], [StagingTableName], [GetStoredProc], [MigrateStoredProc], [TableOrder]) VALUES (N'Dimension', N'Dimension', N'Customer', N'Customer_Staging', N'GetCustomerUpdates', N'MigrateStagedCustomerData', 2)
INSERT [dbo].[TableConfig] ([TableType], [SchemaName], [TableName], [StagingTableName], [GetStoredProc], [MigrateStoredProc], [TableOrder]) VALUES (N'Dimension', N'Dimension', N'Employee', N'Employee_Staging', N'GetEmployeeUpdates', N'MigrateStagedEmployeeData', 3)
INSERT [dbo].[TableConfig] ([TableType], [SchemaName], [TableName], [StagingTableName], [GetStoredProc], [MigrateStoredProc], [TableOrder]) VALUES (N'Dimension', N'Dimension', N'Payment Method', N'PaymentMethod_Staging', N'GetPaymentMethodUpdates', N'MigrateStagedPaymentMethodData', 4)
INSERT [dbo].[TableConfig] ([TableType], [SchemaName], [TableName], [StagingTableName], [GetStoredProc], [MigrateStoredProc], [TableOrder]) VALUES (N'Dimension', N'Dimension', N'Stock Item', N'StockItem_Staging', N'GetStockItemUpdates', N'MigrateStagedStockHoldingData', 5)
INSERT [dbo].[TableConfig] ([TableType], [SchemaName], [TableName], [StagingTableName], [GetStoredProc], [MigrateStoredProc], [TableOrder]) VALUES (N'Dimension', N'Dimension', N'Supplier', N'Supplier_Staging', N'GetSupplierUpdates', N'MigrateStagedSupplierData', 6)
INSERT [dbo].[TableConfig] ([TableType], [SchemaName], [TableName], [StagingTableName], [GetStoredProc], [MigrateStoredProc], [TableOrder]) VALUES (N'Dimension', N'Dimension', N'Transaction Type', N'TransactionType_Staging', N'GetTransactionTypeUpdates', N'MigrateStagedTransactionTypeData', 7)
INSERT [dbo].[TableConfig] ([TableType], [SchemaName], [TableName], [StagingTableName], [GetStoredProc], [MigrateStoredProc], [TableOrder]) VALUES (N'Fact', N'Fact', N'Movement', N'Movement_Staging', N'GetMovementUpdates', N'MigrateStagedMovementData', 8)
INSERT [dbo].[TableConfig] ([TableType], [SchemaName], [TableName], [StagingTableName], [GetStoredProc], [MigrateStoredProc], [TableOrder]) VALUES (N'Fact', N'Fact', N'Order', N'Order_Staging', N'GetOrderUpdates', N'MigrateStagedOrderData', 9)
INSERT [dbo].[TableConfig] ([TableType], [SchemaName], [TableName], [StagingTableName], [GetStoredProc], [MigrateStoredProc], [TableOrder]) VALUES (N'Fact', N'Fact', N'Purchase', N'Purchase_Staging', N'GetPurchaseUpdates', N'MigrateStagedPurchaseData', 10)
INSERT [dbo].[TableConfig] ([TableType], [SchemaName], [TableName], [StagingTableName], [GetStoredProc], [MigrateStoredProc], [TableOrder]) VALUES (N'Fact', N'Fact', N'Sale', N'Sale_Staging', N'GetSaleUpdates', N'MigrateStagedSaleData', 11)
INSERT [dbo].[TableConfig] ([TableType], [SchemaName], [TableName], [StagingTableName], [GetStoredProc], [MigrateStoredProc], [TableOrder]) VALUES (N'Fact', N'Fact', N'Stock Holding', N'StockHolding_Staging', N'GetStockHoldingUpdates', N'MigrateStagedStockHoldingData', 12)
INSERT [dbo].[TableConfig] ([TableType], [SchemaName], [TableName], [StagingTableName], [GetStoredProc], [MigrateStoredProc], [TableOrder]) VALUES (N'Fact', N'Fact', N'Transaction', N'Transaction_Staging', N'GetTransactionUpdates', N'MigrateStagedTransactionData', 13)
