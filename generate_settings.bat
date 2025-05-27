@echo off
cd "TriCore Debug (GCC)\"
wsl ../inav_tc375/src/utils/aurix_generate_settings.sh

REM copy files to other build config
copy /Y settings_generated.h "..\TriCore Release (GCC)\"
copy /Y settings_generated.c "..\TriCore Release (GCC)\"