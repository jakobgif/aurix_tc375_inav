@echo off
echo pre build process started

echo Generating Git Version...
REM remove old file
del version_strings.h

REM call script
..\inav_tc375\src\utils\aurix_generate_version_strings.sh

echo pre build process finished