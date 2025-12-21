@echo off
echo pre build process started

REM ignore changes to project setup
git update-index --assume-unchanged ..\.cproject
REM ignore changes to aurix_generate_settings.sh because compiler path may be changed
git -C ..\inav_tc375 update-index --assume-unchanged .\src\utils\aurix_generate_settings.sh

echo Generating Git Version...

REM call script
..\inav_tc375\src\utils\aurix_generate_version_strings.sh

echo pre build process finished