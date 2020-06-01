SELECT SUM(profit), CAST(w.actual_mean_temp AS INT), w.state, MONTH(s.[Invoice Date Key]), YEAR([Invoice Date Key])
FROM (  
   SELECT SUM(profit) AS profit, RIGHT(c.Customer,3) as [state], [Invoice Date Key] 
   FROM [WideWorldImportersDW].[Fact].[Sale] sale
   INNER JOIN [Dimension].[Customer] c ON sale.[Customer Key] = c.[Customer Key]
   GROUP BY RIGHT(c.Customer,3) , [Invoice Date Key]
) s
INNER JOIN [Data538].[weather] w ON s.[state] =  w.[state] + ')' AND w.[date] = s.[Invoice Date Key]
GROUP by CAST(w.actual_mean_temp  AS INT), w.state, MONTH(s.[Invoice Date Key]), YEAR([Invoice Date Key])
ORDER BY 1  
