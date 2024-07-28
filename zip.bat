@REM @echo off
set SOURCE_DIR=.
set DESTINATION_FILE=AdGuardHomeForMagisk-arm64.zip
set DESTINATION_FILE2=AdGuardHomeForMagisk-armv7.zip

set path="C:\Program Files\7-Zip";%path%

@REM Delete existing archive
del "%DESTINATION_FILE%"
del "%DESTINATION_FILE2%"

@REM Create new archive for arm64
7z a -tzip "%DESTINATION_FILE%" "%SOURCE_DIR%\*.sh"
7z a -tzip "%DESTINATION_FILE%" "%SOURCE_DIR%\module.prop"
7z a -tzip "%DESTINATION_FILE%" "%SOURCE_DIR%\META-INF"
7z a -tzip "%DESTINATION_FILE%" "%SOURCE_DIR%\bin\data"
7z rn "%DESTINATION_FILE%" "data" "bin\data"
7z a -tzip "%DESTINATION_FILE%" "%SOURCE_DIR%\bin\AdGuardHome.yaml"
7z rn "%DESTINATION_FILE%" "AdGuardHome.yaml" "bin\AdGuardHome.yaml"
7z a -tzip "%DESTINATION_FILE%" "%SOURCE_DIR%\bin\AdGuardHome_arm64"
7z rn "%DESTINATION_FILE%" "AdGuardHome_arm64" "bin\AdGuardHome"

@REM Create new archive for armv7
7z a -tzip "%DESTINATION_FILE2%" "%SOURCE_DIR%\*.sh"
7z a -tzip "%DESTINATION_FILE2%" "%SOURCE_DIR%\module.prop"
7z a -tzip "%DESTINATION_FILE2%" "%SOURCE_DIR%\META-INF"
7z a -tzip "%DESTINATION_FILE2%" "%SOURCE_DIR%\bin\AdGuardHome.yaml"
7z rn "%DESTINATION_FILE2%" "AdGuardHome.yaml" "bin\AdGuardHome.yaml"
7z a -tzip "%DESTINATION_FILE2%" "%SOURCE_DIR%\bin\data"
7z rn "%DESTINATION_FILE2%" "data" "bin\data"
7z a -tzip "%DESTINATION_FILE2%" "%SOURCE_DIR%\bin\AdGuardHome_armv7"
7z rn "%DESTINATION_FILE2%" "AdGuardHome_armv7" "bin\AdGuardHome"
