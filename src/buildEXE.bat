@echo off
pushd "%~dp0"

echo Building FHGearbox.exe ...

pyinstaller --onefile --icon="utils/car.ico" -w --add-data "utils;utils" --splash "utils/splash.png" --name="FHGearbox" FH_auto_classes.py
if errorlevel 1 (
    echo.
    echo Trying python -m PyInstaller...
    python -m PyInstaller --onefile --icon="utils/car.ico" -w --add-data "utils;utils" --splash "utils/splash.png" --name="FHGearbox" FH_auto_classes.py
)

if errorlevel 1 (
    echo.
    echo ERROR: PyInstaller build failed!
    echo Please make sure Python and PyInstaller are installed:
    echo pip install pyinstaller -r ..\requirements.txt
    echo.
    popd
    pause
    exit /b 1
)

if exist "dist\FHGearbox.exe" (
    move /y "dist\FHGearbox.exe" "..\FHGearbox.exe"
    echo.
    echo SUCCESS: Built FHGearbox.exe in project root folder!
) else (
    echo.
    echo ERROR: dist\FHGearbox.exe was not created.
)

if exist "build" rmdir /s /q "build"
if exist "dist" rmdir /s /q "dist"
if exist "FHGearbox.spec" del "FHGearbox.spec"

popd
echo.
pause