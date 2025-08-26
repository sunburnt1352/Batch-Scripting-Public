title findDesktop
echo Author: Cam



::first set to local user
SETLOCAL
::then use powershell to get the folder path to desktop
FOR /F "usebackq" %%f IN (`PowerShell -NoProfile -Command "Write-Host([Environment]::GetFolderPath('Desktop'))"`) DO (
  SET "DESKTOP_FOLDER=%%f"
  )

@ECHO %DESKTOP_FOLDER%
cd %DESKTOP_FOLDER%


pause
