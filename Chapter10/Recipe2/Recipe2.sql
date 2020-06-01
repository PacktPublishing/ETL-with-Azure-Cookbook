--IX_Dimension_City_WWICityID
CREATE  NONCLUSTERED INDEX [IX_Dimension_City_WWICityID] ON [Dimension].[City]
      (
      [WWI City ID] Asc,[Valid From] Asc,[Valid To] Asc
      )
      
      WITH
      (
      PAD_INDEX = OFF,
SORT_IN_TEMPDB = OFF,
DROP_EXISTING = OFF,
IGNORE_DUP_KEY = OFF,
ONLINE = OFF
      )
      ON "default"
      GO

--IX_Dimension_Customer_WWICustomerID
CREATE  NONCLUSTERED INDEX [IX_Dimension_Customer_WWICustomerID] ON [Dimension].[Customer]
      (
      [WWI Customer ID] Asc,[Valid From] Asc,[Valid To] Asc
      )
      
      WITH
      (
      PAD_INDEX = OFF,
SORT_IN_TEMPDB = OFF,
DROP_EXISTING = OFF,
IGNORE_DUP_KEY = OFF,
ONLINE = OFF
      )
      ON "default"
      GO

--IX_Dimension_Employee_WWIEmployeeID
CREATE  NONCLUSTERED INDEX [IX_Dimension_Employee_WWIEmployeeID] ON [Dimension].[Employee]
      (
      [WWI Employee ID] Asc,[Valid From] Asc,[Valid To] Asc
      )
      
      WITH
      (
      PAD_INDEX = OFF,
SORT_IN_TEMPDB = OFF,
DROP_EXISTING = OFF,
IGNORE_DUP_KEY = OFF,
ONLINE = OFF
      )
      ON "default"
      GO

--IX_Dimension_Payment_Method_WWIPaymentMethodID
CREATE  NONCLUSTERED INDEX [IX_Dimension_Payment_Method_WWIPaymentMethodID] ON [Dimension].[Payment Method]
      (
      [WWI Payment Method ID] Asc,[Valid From] Asc,[Valid To] Asc
      )
      
      WITH
      (
      PAD_INDEX = OFF,
SORT_IN_TEMPDB = OFF,
DROP_EXISTING = OFF,
IGNORE_DUP_KEY = OFF,
ONLINE = OFF
      )
      ON "default"
      GO

--IX_Dimension_Stock_Item_WWIStockItemID
CREATE  NONCLUSTERED INDEX [IX_Dimension_Stock_Item_WWIStockItemID] ON [Dimension].[Stock Item]
      (
      [WWI Stock Item ID] Asc,[Valid From] Asc,[Valid To] Asc
      )
      
      WITH
      (
      PAD_INDEX = OFF,
SORT_IN_TEMPDB = OFF,
DROP_EXISTING = OFF,
IGNORE_DUP_KEY = OFF,
ONLINE = OFF
      )
      ON "default"
      GO

--IX_Dimension_Supplier_WWISupplierID
CREATE  NONCLUSTERED INDEX [IX_Dimension_Supplier_WWISupplierID] ON [Dimension].[Supplier]
      (
      [WWI Supplier ID] Asc,[Valid From] Asc,[Valid To] Asc
      )
      
      WITH
      (
      PAD_INDEX = OFF,
SORT_IN_TEMPDB = OFF,
DROP_EXISTING = OFF,
IGNORE_DUP_KEY = OFF,
ONLINE = OFF
      )
      ON "default"
      GO

--IX_Dimension_Transaction_Type_WWITransactionTypeID
CREATE  NONCLUSTERED INDEX [IX_Dimension_Transaction_Type_WWITransactionTypeID] ON [Dimension].[Transaction Type]
      (
      [WWI Transaction Type ID] Asc,[Valid From] Asc,[Valid To] Asc
      )
      
      WITH
      (
      PAD_INDEX = OFF,
SORT_IN_TEMPDB = OFF,
DROP_EXISTING = OFF,
IGNORE_DUP_KEY = OFF,
ONLINE = OFF
      )
      ON "default"
      GO

--CCX_Fact_Movement
CREATE  NONCLUSTERED INDEX [CCX_Fact_Movement] ON [Fact].[Movement]
      (
      
      )
      INCLUDE ([Movement Key],[Date Key],[Stock Item Key],[Customer Key],[Supplier Key],[Transaction Type Key],[WWI Stock Item Transaction ID],[WWI Invoice ID],[WWI Purchase Order ID],[Quantity],[Lineage Key])
      WITH
      (
      PAD_INDEX = OFF,
SORT_IN_TEMPDB = OFF,
DROP_EXISTING = OFF,
IGNORE_DUP_KEY = OFF,
ONLINE = OFF
      )
      ON "default"
      GO

--FK_Fact_Movement_Customer_Key
CREATE  NONCLUSTERED INDEX [FK_Fact_Movement_Customer_Key] ON [Fact].[Movement]
      (
      [Date Key] Asc,[Customer Key] Asc
      )
      
      WITH
      (
      PAD_INDEX = OFF,
SORT_IN_TEMPDB = OFF,
DROP_EXISTING = OFF,
IGNORE_DUP_KEY = OFF,
ONLINE = OFF
      )
      ON "default"
      GO

--FK_Fact_Movement_Date_Key
CREATE  NONCLUSTERED INDEX [FK_Fact_Movement_Date_Key] ON [Fact].[Movement]
      (
      [Date Key] Asc
      )
      
      WITH
      (
      PAD_INDEX = OFF,
SORT_IN_TEMPDB = OFF,
DROP_EXISTING = OFF,
IGNORE_DUP_KEY = OFF,
ONLINE = OFF
      )
      ON "default"
      GO

--FK_Fact_Movement_Stock_Item_Key
CREATE  NONCLUSTERED INDEX [FK_Fact_Movement_Stock_Item_Key] ON [Fact].[Movement]
      (
      [Date Key] Asc,[Stock Item Key] Asc
      )
      
      WITH
      (
      PAD_INDEX = OFF,
SORT_IN_TEMPDB = OFF,
DROP_EXISTING = OFF,
IGNORE_DUP_KEY = OFF,
ONLINE = OFF
      )
      ON "default"
      GO

--FK_Fact_Movement_Supplier_Key
CREATE  NONCLUSTERED INDEX [FK_Fact_Movement_Supplier_Key] ON [Fact].[Movement]
      (
      [Date Key] Asc,[Supplier Key] Asc
      )
      
      WITH
      (
      PAD_INDEX = OFF,
SORT_IN_TEMPDB = OFF,
DROP_EXISTING = OFF,
IGNORE_DUP_KEY = OFF,
ONLINE = OFF
      )
      ON "default"
      GO

--FK_Fact_Movement_Transaction_Type_Key
CREATE  NONCLUSTERED INDEX [FK_Fact_Movement_Transaction_Type_Key] ON [Fact].[Movement]
      (
      [Date Key] Asc,[Transaction Type Key] Asc
      )
      
      WITH
      (
      PAD_INDEX = OFF,
SORT_IN_TEMPDB = OFF,
DROP_EXISTING = OFF,
IGNORE_DUP_KEY = OFF,
ONLINE = OFF
      )
      ON "default"
      GO

--IX_Integration_Movement_WWI_Stock_Item_Transaction_ID
CREATE  NONCLUSTERED INDEX [IX_Integration_Movement_WWI_Stock_Item_Transaction_ID] ON [Fact].[Movement]
      (
      [Date Key] Asc,[WWI Stock Item Transaction ID] Asc
      )
      
      WITH
      (
      PAD_INDEX = OFF,
SORT_IN_TEMPDB = OFF,
DROP_EXISTING = OFF,
IGNORE_DUP_KEY = OFF,
ONLINE = OFF
      )
      ON "default"
      GO

--CCX_Fact_Order
CREATE  NONCLUSTERED INDEX [CCX_Fact_Order] ON [Fact].[Order]
      (
      
      )
      INCLUDE ([Order Key],[City Key],[Customer Key],[Stock Item Key],[Order Date Key],[Picked Date Key],[Salesperson Key],[Picker Key],[WWI Order ID],[WWI Backorder ID],[Description],[Package],[Quantity],[Unit Price],[Tax Rate],[Total Excluding Tax],[Tax Amount],[Total Including Tax],[Lineage Key])
      WITH
      (
      PAD_INDEX = OFF,
SORT_IN_TEMPDB = OFF,
DROP_EXISTING = OFF,
IGNORE_DUP_KEY = OFF,
ONLINE = OFF
      )
      ON "default"
      GO

--FK_Fact_Order_City_Key
CREATE  NONCLUSTERED INDEX [FK_Fact_Order_City_Key] ON [Fact].[Order]
      (
      [Order Date Key] Asc,[City Key] Asc
      )
      
      WITH
      (
      PAD_INDEX = OFF,
SORT_IN_TEMPDB = OFF,
DROP_EXISTING = OFF,
IGNORE_DUP_KEY = OFF,
ONLINE = OFF
      )
      ON "default"
      GO

--FK_Fact_Order_Customer_Key
CREATE  NONCLUSTERED INDEX [FK_Fact_Order_Customer_Key] ON [Fact].[Order]
      (
      [Order Date Key] Asc,[Customer Key] Asc
      )
      
      WITH
      (
      PAD_INDEX = OFF,
SORT_IN_TEMPDB = OFF,
DROP_EXISTING = OFF,
IGNORE_DUP_KEY = OFF,
ONLINE = OFF
      )
      ON "default"
      GO

--FK_Fact_Order_Order_Date_Key
CREATE  NONCLUSTERED INDEX [FK_Fact_Order_Order_Date_Key] ON [Fact].[Order]
      (
      [Order Date Key] Asc
      )
      
      WITH
      (
      PAD_INDEX = OFF,
SORT_IN_TEMPDB = OFF,
DROP_EXISTING = OFF,
IGNORE_DUP_KEY = OFF,
ONLINE = OFF
      )
      ON "default"
      GO

--FK_Fact_Order_Picked_Date_Key
CREATE  NONCLUSTERED INDEX [FK_Fact_Order_Picked_Date_Key] ON [Fact].[Order]
      (
      [Order Date Key] Asc,[Picked Date Key] Asc
      )
      
      WITH
      (
      PAD_INDEX = OFF,
SORT_IN_TEMPDB = OFF,
DROP_EXISTING = OFF,
IGNORE_DUP_KEY = OFF,
ONLINE = OFF
      )
      ON "default"
      GO

--FK_Fact_Order_Picker_Key
CREATE  NONCLUSTERED INDEX [FK_Fact_Order_Picker_Key] ON [Fact].[Order]
      (
      [Order Date Key] Asc,[Picker Key] Asc
      )
      
      WITH
      (
      PAD_INDEX = OFF,
SORT_IN_TEMPDB = OFF,
DROP_EXISTING = OFF,
IGNORE_DUP_KEY = OFF,
ONLINE = OFF
      )
      ON "default"
      GO

--FK_Fact_Order_Salesperson_Key
CREATE  NONCLUSTERED INDEX [FK_Fact_Order_Salesperson_Key] ON [Fact].[Order]
      (
      [Order Date Key] Asc,[Salesperson Key] Asc
      )
      
      WITH
      (
      PAD_INDEX = OFF,
SORT_IN_TEMPDB = OFF,
DROP_EXISTING = OFF,
IGNORE_DUP_KEY = OFF,
ONLINE = OFF
      )
      ON "default"
      GO

--FK_Fact_Order_Stock_Item_Key
CREATE  NONCLUSTERED INDEX [FK_Fact_Order_Stock_Item_Key] ON [Fact].[Order]
      (
      [Order Date Key] Asc,[Stock Item Key] Asc
      )
      
      WITH
      (
      PAD_INDEX = OFF,
SORT_IN_TEMPDB = OFF,
DROP_EXISTING = OFF,
IGNORE_DUP_KEY = OFF,
ONLINE = OFF
      )
      ON "default"
      GO

--IX_Integration_Order_WWI_Order_ID
CREATE  NONCLUSTERED INDEX [IX_Integration_Order_WWI_Order_ID] ON [Fact].[Order]
      (
      [Order Date Key] Asc,[WWI Order ID] Asc
      )
      
      WITH
      (
      PAD_INDEX = OFF,
SORT_IN_TEMPDB = OFF,
DROP_EXISTING = OFF,
IGNORE_DUP_KEY = OFF,
ONLINE = OFF
      )
      ON "default"
      GO

--CCX_Fact_Purchase
CREATE  NONCLUSTERED INDEX [CCX_Fact_Purchase] ON [Fact].[Purchase]
      (
      
      )
      INCLUDE ([Purchase Key],[Date Key],[Supplier Key],[Stock Item Key],[WWI Purchase Order ID],[Ordered Outers],[Ordered Quantity],[Received Outers],[Package],[Is Order Finalized],[Lineage Key])
      WITH
      (
      PAD_INDEX = OFF,
SORT_IN_TEMPDB = OFF,
DROP_EXISTING = OFF,
IGNORE_DUP_KEY = OFF,
ONLINE = OFF
      )
      ON "default"
      GO

--FK_Fact_Purchase_Date_Key
CREATE  NONCLUSTERED INDEX [FK_Fact_Purchase_Date_Key] ON [Fact].[Purchase]
      (
      [Date Key] Asc
      )
      
      WITH
      (
      PAD_INDEX = OFF,
SORT_IN_TEMPDB = OFF,
DROP_EXISTING = OFF,
IGNORE_DUP_KEY = OFF,
ONLINE = OFF
      )
      ON "default"
      GO

--FK_Fact_Purchase_Stock_Item_Key
CREATE  NONCLUSTERED INDEX [FK_Fact_Purchase_Stock_Item_Key] ON [Fact].[Purchase]
      (
      [Date Key] Asc,[Stock Item Key] Asc
      )
      
      WITH
      (
      PAD_INDEX = OFF,
SORT_IN_TEMPDB = OFF,
DROP_EXISTING = OFF,
IGNORE_DUP_KEY = OFF,
ONLINE = OFF
      )
      ON "default"
      GO

--FK_Fact_Purchase_Supplier_Key
CREATE  NONCLUSTERED INDEX [FK_Fact_Purchase_Supplier_Key] ON [Fact].[Purchase]
      (
      [Date Key] Asc,[Supplier Key] Asc
      )
      
      WITH
      (
      PAD_INDEX = OFF,
SORT_IN_TEMPDB = OFF,
DROP_EXISTING = OFF,
IGNORE_DUP_KEY = OFF,
ONLINE = OFF
      )
      ON "default"
      GO

--CCX_Fact_Sale
CREATE  NONCLUSTERED INDEX [CCX_Fact_Sale] ON [Fact].[Sale]
      (
      
      )
      INCLUDE ([Sale Key],[City Key],[Customer Key],[Bill To Customer Key],[Stock Item Key],[Invoice Date Key],[Delivery Date Key],[Salesperson Key],[WWI Invoice ID],[Description],[Package],[Quantity],[Unit Price],[Tax Rate],[Total Excluding Tax],[Tax Amount],[Profit],[Total Including Tax],[Total Dry Items],[Total Chiller Items],[Lineage Key])
      WITH
      (
      PAD_INDEX = OFF,
SORT_IN_TEMPDB = OFF,
DROP_EXISTING = OFF,
IGNORE_DUP_KEY = OFF,
ONLINE = OFF
      )
      ON "default"
      GO

--FK_Fact_Sale_Bill_To_Customer_Key
CREATE  NONCLUSTERED INDEX [FK_Fact_Sale_Bill_To_Customer_Key] ON [Fact].[Sale]
      (
      [Invoice Date Key] Asc,[Bill To Customer Key] Asc
      )
      
      WITH
      (
      PAD_INDEX = OFF,
SORT_IN_TEMPDB = OFF,
DROP_EXISTING = OFF,
IGNORE_DUP_KEY = OFF,
ONLINE = OFF
      )
      ON "default"
      GO

--FK_Fact_Sale_City_Key
CREATE  NONCLUSTERED INDEX [FK_Fact_Sale_City_Key] ON [Fact].[Sale]
      (
      [Invoice Date Key] Asc,[City Key] Asc
      )
      
      WITH
      (
      PAD_INDEX = OFF,
SORT_IN_TEMPDB = OFF,
DROP_EXISTING = OFF,
IGNORE_DUP_KEY = OFF,
ONLINE = OFF
      )
      ON "default"
      GO

--FK_Fact_Sale_Customer_Key
CREATE  NONCLUSTERED INDEX [FK_Fact_Sale_Customer_Key] ON [Fact].[Sale]
      (
      [Invoice Date Key] Asc,[Customer Key] Asc
      )
      
      WITH
      (
      PAD_INDEX = OFF,
SORT_IN_TEMPDB = OFF,
DROP_EXISTING = OFF,
IGNORE_DUP_KEY = OFF,
ONLINE = OFF
      )
      ON "default"
      GO

--FK_Fact_Sale_Delivery_Date_Key
CREATE  NONCLUSTERED INDEX [FK_Fact_Sale_Delivery_Date_Key] ON [Fact].[Sale]
      (
      [Invoice Date Key] Asc,[Delivery Date Key] Asc
      )
      
      WITH
      (
      PAD_INDEX = OFF,
SORT_IN_TEMPDB = OFF,
DROP_EXISTING = OFF,
IGNORE_DUP_KEY = OFF,
ONLINE = OFF
      )
      ON "default"
      GO

--FK_Fact_Sale_Invoice_Date_Key
CREATE  NONCLUSTERED INDEX [FK_Fact_Sale_Invoice_Date_Key] ON [Fact].[Sale]
      (
      [Invoice Date Key] Asc
      )
      
      WITH
      (
      PAD_INDEX = OFF,
SORT_IN_TEMPDB = OFF,
DROP_EXISTING = OFF,
IGNORE_DUP_KEY = OFF,
ONLINE = OFF
      )
      ON "default"
      GO

--FK_Fact_Sale_Salesperson_Key
CREATE  NONCLUSTERED INDEX [FK_Fact_Sale_Salesperson_Key] ON [Fact].[Sale]
      (
      [Invoice Date Key] Asc,[Salesperson Key] Asc
      )
      
      WITH
      (
      PAD_INDEX = OFF,
SORT_IN_TEMPDB = OFF,
DROP_EXISTING = OFF,
IGNORE_DUP_KEY = OFF,
ONLINE = OFF
      )
      ON "default"
      GO

--FK_Fact_Sale_Stock_Item_Key
CREATE  NONCLUSTERED INDEX [FK_Fact_Sale_Stock_Item_Key] ON [Fact].[Sale]
      (
      [Invoice Date Key] Asc,[Stock Item Key] Asc
      )
      
      WITH
      (
      PAD_INDEX = OFF,
SORT_IN_TEMPDB = OFF,
DROP_EXISTING = OFF,
IGNORE_DUP_KEY = OFF,
ONLINE = OFF
      )
      ON "default"
      GO

--CCX_Fact_Stock_Holding
CREATE  NONCLUSTERED INDEX [CCX_Fact_Stock_Holding] ON [Fact].[Stock Holding]
      (
      
      )
      INCLUDE ([Stock Holding Key],[Stock Item Key],[Quantity On Hand],[Bin Location],[Last Stocktake Quantity],[Last Cost Price],[Reorder Level],[Target Stock Level],[Lineage Key])
      WITH
      (
      PAD_INDEX = OFF,
SORT_IN_TEMPDB = OFF,
DROP_EXISTING = OFF,
IGNORE_DUP_KEY = OFF,
ONLINE = OFF
      )
      ON "default"
      GO

--FK_Fact_Stock_Holding_Stock_Item_Key
CREATE  NONCLUSTERED INDEX [FK_Fact_Stock_Holding_Stock_Item_Key] ON [Fact].[Stock Holding]
      (
      [Stock Item Key] Asc
      )
      
      WITH
      (
      PAD_INDEX = OFF,
SORT_IN_TEMPDB = OFF,
DROP_EXISTING = OFF,
IGNORE_DUP_KEY = OFF,
ONLINE = OFF
      )
      ON "default"
      GO

--CCX_Fact_Transaction
CREATE  NONCLUSTERED INDEX [CCX_Fact_Transaction] ON [Fact].[Transaction]
      (
      
      )
      INCLUDE ([Transaction Key],[Date Key],[Customer Key],[Bill To Customer Key],[Supplier Key],[Transaction Type Key],[Payment Method Key],[WWI Customer Transaction ID],[WWI Supplier Transaction ID],[WWI Invoice ID],[WWI Purchase Order ID],[Supplier Invoice Number],[Total Excluding Tax],[Tax Amount],[Total Including Tax],[Outstanding Balance],[Is Finalized],[Lineage Key])
      WITH
      (
      PAD_INDEX = OFF,
SORT_IN_TEMPDB = OFF,
DROP_EXISTING = OFF,
IGNORE_DUP_KEY = OFF,
ONLINE = OFF
      )
      ON "default"
      GO

--FK_Fact_Transaction_Bill_To_Customer_Key
CREATE  NONCLUSTERED INDEX [FK_Fact_Transaction_Bill_To_Customer_Key] ON [Fact].[Transaction]
      (
      [Date Key] Asc,[Bill To Customer Key] Asc
      )
      
      WITH
      (
      PAD_INDEX = OFF,
SORT_IN_TEMPDB = OFF,
DROP_EXISTING = OFF,
IGNORE_DUP_KEY = OFF,
ONLINE = OFF
      )
      ON "default"
      GO

--FK_Fact_Transaction_Customer_Key
CREATE  NONCLUSTERED INDEX [FK_Fact_Transaction_Customer_Key] ON [Fact].[Transaction]
      (
      [Date Key] Asc,[Customer Key] Asc
      )
      
      WITH
      (
      PAD_INDEX = OFF,
SORT_IN_TEMPDB = OFF,
DROP_EXISTING = OFF,
IGNORE_DUP_KEY = OFF,
ONLINE = OFF
      )
      ON "default"
      GO

--FK_Fact_Transaction_Date_Key
CREATE  NONCLUSTERED INDEX [FK_Fact_Transaction_Date_Key] ON [Fact].[Transaction]
      (
      [Date Key] Asc
      )
      
      WITH
      (
      PAD_INDEX = OFF,
SORT_IN_TEMPDB = OFF,
DROP_EXISTING = OFF,
IGNORE_DUP_KEY = OFF,
ONLINE = OFF
      )
      ON "default"
      GO

--FK_Fact_Transaction_Payment_Method_Key
CREATE  NONCLUSTERED INDEX [FK_Fact_Transaction_Payment_Method_Key] ON [Fact].[Transaction]
      (
      [Date Key] Asc,[Payment Method Key] Asc
      )
      
      WITH
      (
      PAD_INDEX = OFF,
SORT_IN_TEMPDB = OFF,
DROP_EXISTING = OFF,
IGNORE_DUP_KEY = OFF,
ONLINE = OFF
      )
      ON "default"
      GO

--FK_Fact_Transaction_Supplier_Key
CREATE  NONCLUSTERED INDEX [FK_Fact_Transaction_Supplier_Key] ON [Fact].[Transaction]
      (
      [Date Key] Asc,[Supplier Key] Asc
      )
      
      WITH
      (
      PAD_INDEX = OFF,
SORT_IN_TEMPDB = OFF,
DROP_EXISTING = OFF,
IGNORE_DUP_KEY = OFF,
ONLINE = OFF
      )
      ON "default"
      GO

--FK_Fact_Transaction_Transaction_Type_Key
CREATE  NONCLUSTERED INDEX [FK_Fact_Transaction_Transaction_Type_Key] ON [Fact].[Transaction]
      (
      [Date Key] Asc,[Transaction Type Key] Asc
      )
      
      WITH
      (
      PAD_INDEX = OFF,
SORT_IN_TEMPDB = OFF,
DROP_EXISTING = OFF,
IGNORE_DUP_KEY = OFF,
ONLINE = OFF
      )
      ON "default"
      GO

--IX_Integration_City_Staging_WWI_City_ID
CREATE  NONCLUSTERED INDEX [IX_Integration_City_Staging_WWI_City_ID] ON [Integration].[City_Staging]
      (
      [WWI City ID] Asc
      )
      
      WITH
      (
      PAD_INDEX = OFF,
SORT_IN_TEMPDB = OFF,
DROP_EXISTING = OFF,
IGNORE_DUP_KEY = OFF,
ONLINE = OFF
      )
      ON "default"
      GO


