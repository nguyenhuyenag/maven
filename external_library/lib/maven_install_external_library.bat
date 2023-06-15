@echo off

set "file=data.txt"
set LIB_DIR=D:\Dev\Projects\Github\maven\external_library\lib

for /f "usebackq tokens=1-4 delims=," %%a in ("%file%") do (
	echo File install: filename=%%a, groupId=%%b, artifactId=%%c, version=%%d
	echo.
	call mvn install:install-file ^
		-Dfile=%LIB_DIR%\%%a ^
		-DgroupId=%%b ^
		-DartifactId=%%c ^
		-Dversion=%%d ^
		-Dpackaging=jar ^
		-Durl=file:./lib/ ^
		-DrepositoryId=lib ^
		-DupdateReleaseInfo=true
	echo.
)

timeout /t 5 /nobreak
exit
