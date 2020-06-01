$resourceGroupName ="ETL"
$dataFactoryName = "ADFCloudETL"
$rootPath = "C:\Users\BookAdmin\Documents\ADFCloudETL\output\DataFactories\ADFCloudETL"
Set-AzDataFactoryV2LinkedService -DataFactoryName $dataFactoryName  -ResourceGroupName $resourceGroupName -Name "LSHTTP" -DefinitionFile ($rootPath +"\LinkedServices\LSHTTP.json")
Set-AzDataFactoryV2Dataset -DataFactoryName $dataFactoryName -ResourceGroupName $resourceGroupName -Name "DSHTTP" -DefinitionFile ($rootPath +"\Datasets\DSHTTP.json")
Set-AzDataFactoryV2Dataset -DataFactoryName $dataFactoryName -ResourceGroupName $resourceGroupName -Name "DSDL2" -DefinitionFile ($rootPath +"\Datasets\DSDL2.json")
Set-AzDataFactoryV2Pipeline -DataFactoryName $dataFactoryName -ResourceGroupName $resourceGroupName -Name "Copy Political Regions" -DefinitionFile ($rootPath+"\Pipelines\Copy Political Regions.json")
 
