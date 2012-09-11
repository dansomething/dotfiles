@ECHO OFF
SETLOCAL

REM By default this script uses SQL Server integration authentication.
REM The account you run this as must have access to the server.
SET SERVER_NAME=
SET BACKUP_PATH=D:backup_sql

REM Get date in format YYYY-MM-DD (assumes the locale is the United States)
FOR /F "tokens=1,2,3,4 delims=/ " %%A IN ('Date /T') DO SET NowDate=%%D%%B%%C

REM Build a list of databases to backup
SET DBList=%SystemDrive%SQL-DB-List.txt
SqlCmd -E -S %SERVER_NAME% -h-1 -W -Q "SET NoCount ON; SELECT Name FROM master.dbo.sysDatabases WHERE [Name] NOT IN ('master','model','msdb','tempdb')" > "%DBList%"

REM Backup each database, appending the date to the filename
FOR /F "tokens=*" %%I IN (%DBList%) DO (
  ECHO Backing up database: %%I
  SqlCmd -E -S %SERVER_NAME% -Q "BACKUP DATABASE [%%I] TO Disk='%BACKUP_PATH%\%%I_%NowDate%.bak' WITH FORMAT"
  ECHO.
)

REM Clean up the temp file
IF EXIST "%DBList%" DEL /F /Q "%DBList%"

ENDLOCAL
PAUSE