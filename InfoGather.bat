@echo off
title InfoGather
echo Author: Cam



::first it takes the path to the starting directory as the homebase
for /f %%i in ('cd') do set homeBaseTemp=%%i


::this takes in an input when starting the file,
set homeBase= %1

::this command tests if user has admin privilliges

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
ipconfig >> Info\basics.txt

driverquery > %homeBase%\Info\drivers.txt
tasklist > %homeBase%\Info\tasks.txt
subst > %homeBase%\Info\subst.txt

net users > %homeBase%\Info\Net\users.txt
net accounts > %homeBase%\Info\Net\accounts.txt
net config > %homeBase%\Info\Net\config.txt
net session > %homeBase%\Info\Net\session.txt




::this is a loop where it goes through each directory from the intial to the farthest back and grabs the contents

:start
for /f %%i in ('cd') do set tempBase=%%i

dir > %homeBase%\Info\directories\Contents\%tempBase%.txt
dir /ah > %homeBase%\Info\directories\Contents\%tempBase%.txt
attrib > %homeBase%\Info\directories\Attributes\%tempBase%Attribute.txt




goto :EOF
