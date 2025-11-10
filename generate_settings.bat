@echo off
cd "TriCore Release (GCC)\"
wsl ../inav_tc375/src/utils/aurix_generate_settings.sh

REM check if "..\TriCore Debug (GCC)\" exists
if exist "..\TriCore Debug (GCC)\" (
REM copy files to other build config
copy /Y settings_generated.h "..\TriCore Debug (GCC)\"
copy /Y settings_generated.c "..\TriCore Debug (GCC)\"
)