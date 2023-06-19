@echo off

set "INPUT_FILE=input.txt"
set "OUTPUT_FILE=%CD%\output.txt"

if exist %OUTPUT_FILE% (
    del %OUTPUT_FILE%
	echo [INFO]: File deleted successfully
)

for %%I in ("%CD%") do set "LIB_DIR=%%~dpI"

for /f "usebackq tokens=1-4 delims=," %%a in ("%INPUT_FILE%") do (
	echo.
	REM File info
	echo [INFO]: filename=%%a, groupId=%%b, artifactId=%%c, version=%%d
	echo.
	REM Install jar
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
	REM Create dependency
	(
        echo ^<dependency^>
        echo     ^<groupId^>%%b^</groupId^>
        echo     ^<artifactId^>%%c^</artifactId^>
        echo     ^<version^>%%d^</version^>
        echo ^</dependency^>
    ) >> %OUTPUT_FILE%
	echo Content appended successfully.
)

timeout /t 5 /nobreak
exit
