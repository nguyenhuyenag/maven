@echo off

set "INPUT_FILE=input.txt"
set "OUTPUT_FILE=%CD%\output.txt"

if exist %OUTPUT_FILE% (
    del %OUTPUT_FILE%
	echo [INFO] Delete 'output.txt'
)

REM Get jar library
for %%I in ("%CD%") do set "LIB_DIR=%%~dpI"

for /f "usebackq tokens=1-4 delims=," %%a in ("%INPUT_FILE%") do (
	echo.
	REM Install jar
	if not exist %LIB_DIR%\%%a (
		echo [INFO] File '%%a' doesn't exist!
	) else (
		REM File infomation
		echo [INFO] Install jar for 'filename=%%a, groupId=%%b, artifactId=%%c, version=%%d'
		
		call mvn install:install-file ^
			-Dfile=%LIB_DIR%\%%a ^
			-DgroupId=%%b ^
			-DartifactId=%%c ^
			-Dversion=%%d ^
			-Dpackaging=jar ^
			-Durl=file:./lib/ ^
			-DrepositoryId=lib ^
			-DupdateReleaseInfo=true
			
		REM Create POM dependency
		echo [INFO] Create dependency
		(
			echo ^<dependency^>
			echo     ^<groupId^>%%b^</groupId^>
			echo     ^<artifactId^>%%c^</artifactId^>
			echo     ^<version^>%%d^</version^>
			echo ^</dependency^>
		) >> %OUTPUT_FILE%
	)
)

timeout /t 5 /nobreak
exit
