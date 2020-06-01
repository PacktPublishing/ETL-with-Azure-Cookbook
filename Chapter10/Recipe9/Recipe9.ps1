$resourceGroupName ="ETL"
	$ADFName = "ADFCloudETL"
	$rootPath = "C:\Users\BookAdmin\Documents\ADFCloudETL\output\DataFactories\ADFCloudETL\"
	Set-AzDataFactoryV2LinkedService -DataFactoryName $ADFName  -ResourceGroupName $resourceGroupName -Name "FileThirtyEightHTTP" -DefinitionFile ($rootPath+"LinkedServices\FileThirtyEightHTTP.json")
	Set-AzDataFactoryV2Dataset -DataFactoryName $ADFName -ResourceGroupName $resourceGroupName -Name "DSHTTPCharlotte" -DefinitionFile ($rootPath+"Datasets\DSHTTPCharlotte.json") -Force
	Set-AzDataFactoryV2Dataset -DataFactoryName $ADFName -ResourceGroupName $resourceGroupName -Name "DSDLCharlotte" -DefinitionFile ($rootPath+"Datasets\DSDLCharlotte.json") -Force
	Set-AzDataFactoryV2Dataset -DataFactoryName $ADFName -ResourceGroupName $resourceGroupName -Name "DSSQLCharlotte" -DefinitionFile ($rootPath+"Datasets\DSSQLCharlotte.json") -Force
	Set-AzDataFactoryV2Dataset -DataFactoryName $ADFName -ResourceGroupName $resourceGroupName -Name "DSHTTPLosAngeles" -DefinitionFile ($rootPath+"Datasets\DSHTTPLosAngeles.json") -Force
	Set-AzDataFactoryV2Dataset -DataFactoryName $ADFName -ResourceGroupName $resourceGroupName -Name "DSDLLosAngeles" -DefinitionFile ($rootPath+"Datasets\DSDLLosAngeles.json") -Force
	Set-AzDataFactoryV2Dataset -DataFactoryName $ADFName -ResourceGroupName $resourceGroupName -Name "DSSQLLosAngeles" -DefinitionFile ($rootPath+"Datasets\DSSQLLosAngeles.json") -Force
	Set-AzDataFactoryV2Dataset -DataFactoryName $ADFName -ResourceGroupName $resourceGroupName -Name "DSHTTPHouston" -DefinitionFile ($rootPath+"Datasets\DSHTTPHouston.json") -Force
	Set-AzDataFactoryV2Dataset -DataFactoryName $ADFName -ResourceGroupName $resourceGroupName -Name "DSDLHouston" -DefinitionFile ($rootPath+"Datasets\DSDLHouston.json") -Force
	Set-AzDataFactoryV2Dataset -DataFactoryName $ADFName -ResourceGroupName $resourceGroupName -Name "DSSQLHouston" -DefinitionFile ($rootPath+"Datasets\DSSQLHouston.json") -Force
	Set-AzDataFactoryV2Dataset -DataFactoryName $ADFName -ResourceGroupName $resourceGroupName -Name "DSHTTPIndianapolis" -DefinitionFile ($rootPath+"Datasets\DSHTTPIndianapolis.json") -Force
	Set-AzDataFactoryV2Dataset -DataFactoryName $ADFName -ResourceGroupName $resourceGroupName -Name "DSDLIndianapolis" -DefinitionFile ($rootPath+"Datasets\DSDLIndianapolis.json") -Force
	Set-AzDataFactoryV2Dataset -DataFactoryName $ADFName -ResourceGroupName $resourceGroupName -Name "DSSQLIndianapolis" -DefinitionFile ($rootPath+"Datasets\DSSQLIndianapolis.json") -Force
	Set-AzDataFactoryV2Dataset -DataFactoryName $ADFName -ResourceGroupName $resourceGroupName -Name "DSHTTPJacksonville" -DefinitionFile ($rootPath+"Datasets\DSHTTPJacksonville.json") -Force
	Set-AzDataFactoryV2Dataset -DataFactoryName $ADFName -ResourceGroupName $resourceGroupName -Name "DSDLJacksonville" -DefinitionFile ($rootPath+"Datasets\DSDLJacksonville.json") -Force
	Set-AzDataFactoryV2Dataset -DataFactoryName $ADFName -ResourceGroupName $resourceGroupName -Name "DSSQLJacksonville" -DefinitionFile ($rootPath+"Datasets\DSSQLJacksonville.json") -Force
	Set-AzDataFactoryV2Dataset -DataFactoryName $ADFName -ResourceGroupName $resourceGroupName -Name "DSHTTPChicago" -DefinitionFile ($rootPath+"Datasets\DSHTTPChicago.json") -Force
	Set-AzDataFactoryV2Dataset -DataFactoryName $ADFName -ResourceGroupName $resourceGroupName -Name "DSDLChicago" -DefinitionFile ($rootPath+"Datasets\DSDLChicago.json") -Force
	Set-AzDataFactoryV2Dataset -DataFactoryName $ADFName -ResourceGroupName $resourceGroupName -Name "DSSQLChicago" -DefinitionFile ($rootPath+"Datasets\DSSQLChicago.json") -Force
	Set-AzDataFactoryV2Dataset -DataFactoryName $ADFName -ResourceGroupName $resourceGroupName -Name "DSHTTPNewYork" -DefinitionFile ($rootPath+"Datasets\DSHTTPNewYork.json") -Force
	Set-AzDataFactoryV2Dataset -DataFactoryName $ADFName -ResourceGroupName $resourceGroupName -Name "DSDLNewYork" -DefinitionFile ($rootPath+"Datasets\DSDLNewYork.json") -Force
	Set-AzDataFactoryV2Dataset -DataFactoryName $ADFName -ResourceGroupName $resourceGroupName -Name "DSSQLNewYork" -DefinitionFile ($rootPath+"Datasets\DSSQLNewYork.json") -Force
	Set-AzDataFactoryV2Dataset -DataFactoryName $ADFName -ResourceGroupName $resourceGroupName -Name "DSHTTPPhiliadelphia" -DefinitionFile ($rootPath+"Datasets\DSHTTPPhiliadelphia.json") -Force
	Set-AzDataFactoryV2Dataset -DataFactoryName $ADFName -ResourceGroupName $resourceGroupName -Name "DSDLPhiliadelphia" -DefinitionFile ($rootPath+"Datasets\DSDLPhiliadelphia.json") -Force
	Set-AzDataFactoryV2Dataset -DataFactoryName $ADFName -ResourceGroupName $resourceGroupName -Name "DSSQLPhiliadelphia" -DefinitionFile ($rootPath+"Datasets\DSSQLPhiliadelphia.json") -Force
	Set-AzDataFactoryV2Dataset -DataFactoryName $ADFName -ResourceGroupName $resourceGroupName -Name "DSHTTPPhoenix" -DefinitionFile ($rootPath+"Datasets\DSHTTPPhoenix.json") -Force
	Set-AzDataFactoryV2Dataset -DataFactoryName $ADFName -ResourceGroupName $resourceGroupName -Name "DSDLPhoenix" -DefinitionFile ($rootPath+"Datasets\DSDLPhoenix.json") -Force
	Set-AzDataFactoryV2Dataset -DataFactoryName $ADFName -ResourceGroupName $resourceGroupName -Name "DSSQLPhoenix" -DefinitionFile ($rootPath+"Datasets\DSSQLPhoenix.json") -Force
	Set-AzDataFactoryV2Dataset -DataFactoryName $ADFName -ResourceGroupName $resourceGroupName -Name "DSHTTPSeattle" -DefinitionFile ($rootPath+"Datasets\DSHTTPSeattle.json") -Force
	Set-AzDataFactoryV2Dataset -DataFactoryName $ADFName -ResourceGroupName $resourceGroupName -Name "DSDLSeattle" -DefinitionFile ($rootPath+"Datasets\DSDLSeattle.json") -Force
	Set-AzDataFactoryV2Dataset -DataFactoryName $ADFName -ResourceGroupName $resourceGroupName -Name "DSSQLSeattle" -DefinitionFile ($rootPath+"Datasets\DSSQLSeattle.json") -Force
	Set-AzDataFactoryV2Pipeline -DataFactoryName $ADFName -ResourceGroupName $resourceGroupName -Name "CopyUSWeather" -DefinitionFile ($rootPath+"Pipelines\CopyUSWeather.json")	-Force
	Set-AzDataFactoryV2Pipeline -DataFactoryName $ADFName -ResourceGroupName $resourceGroupName -Name "CopyUSWeatherSQL" -DefinitionFile ($rootPath+"Pipelines\CopyUSWeatherSQL.json") -Force
