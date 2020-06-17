@echo off

echo Unregistering Custom Control Flow Task . . .
"C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.8 Tools\gacutil.exe" /u ApplicationName.dll
"C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.8 Tools\x64\gacutil.exe" /u ApplicationName.dll

echo.

echo Unregistering Custom Data Flow Component . . .
"C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.8 Tools\gacutil.exe" /u RowHash.dll
"C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.8 Tools\x64\gacutil.exe" /u RowHash.dll

echo.

echo Copying Custom Control Flow Task . . .
xcopy "C:\ETL-with-Azure\Chapter05\Files\ApplicationName.dll" "C:\Program Files (x86)\Microsoft SQL Server\150\DTS\Tasks" /y
xcopy "C:\ETL-with-Azure\Chapter05\Files\ApplicationName.dll" "C:\Program Files\Microsoft SQL Server\150\DTS\Tasks" /y

echo.

echo Copying Custom Data Flow Component . . .
xcopy "C:\ETL-with-Azure\Chapter05\Files\RowHash.dll" "C:\Program Files (x86)\Microsoft SQL Server\150\DTS\PipelineComponents" /y
xcopy "C:\ETL-with-Azure\Chapter05\Files\RowHash.dll" "C:\Program Files\Microsoft SQL Server\150\DTS\PipelineComponents" /y

echo.

echo Registering Custom Control Flow Task . . .
"C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.8 Tools\gacutil.exe" /i "C:\Program Files (x86)\Microsoft SQL Server\150\DTS\Tasks\ApplicationName.dll"
"C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.8 Tools\x64\gacutil.exe" /i "C:\Program Files\Microsoft SQL Server\150\DTS\Tasks\ApplicationName.dll"

echo.

echo Registering Custom Data Flow Component . . .
"C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.8 Tools\gacutil.exe" /i "C:\Program Files (x86)\Microsoft SQL Server\150\DTS\PipelineComponents\RowHash.dll"
"C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.8 Tools\x64\gacutil.exe" /i "C:\Program Files\Microsoft SQL Server\150\DTS\PipelineComponents\RowHash.dll"

echo.

pause
