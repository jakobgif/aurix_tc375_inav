@echo off
echo post build process started

REM changes to these files where ignored for building.
git update-index --no-assume-unchanged ..\.cproject

REM remove version strings file
del version_strings.h

echo post build process finished