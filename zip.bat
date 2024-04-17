@echo off
set SOURCE_DIR=.
set DESTINATION_FILE=AdGuardHomeForMagisk.zip

if not exist "%DESTINATION_FILE%" (
    echo Creating archive...
) else (
    del "%DESTINATION_FILE%"
    echo Archive already exists. Overwriting...
)

set path="C:\Program Files\7-Zip";%path%

7z a -tzip "%DESTINATION_FILE%" "%SOURCE_DIR%\*" -x!*.git -x!.gitignore -x!*.bat

if %ERRORLEVEL% equ 0 (
    echo Archive created successfully.
) else (
    echo Failed to create archive.
)