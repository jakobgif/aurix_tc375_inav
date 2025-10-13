@echo off
echo pre build process started

REM ignore changes to project setup
git update-index --assume-unchanged ..\.cproject
REM git update-index --no-assume-unchanged .\.cproject

echo Generating Git Version...

REM call script
..\inav_tc375\src\utils\aurix_generate_version_strings.sh

echo pre build process finished