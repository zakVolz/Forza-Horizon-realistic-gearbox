@echo off
pushd "%~dp0"

echo Building FHGearbox_MS_store.exe ...

pyinstaller --onefile --icon="utils/car.ico" -w --add-data "utils;utils" --splash "utils/splash.png" --name="FHGearbox_MS_store" FH_auto_classes.py
if errorlevel 1 (
    echo.
    echo Trying python -m PyInstaller...
    python -m PyInstaller --onefile --icon="utils/car.ico" -w --add-data "utils;utils" --splash "utils/splash.png" --name="FHGearbox_MS_store" FH_auto_classes.py
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

if exist "dist\FHGearbox_MS_store.exe" (
    move /y "dist\FHGearbox_MS_store.exe" "..\FHGearbox_MS_store.exe"
    echo.
    echo SUCCESS: Built FHGearbox_MS_store.exe in project root folder!
) else (
    echo.
    echo ERROR: dist\FHGearbox_MS_store.exe was not created.
)

if exist "build" rmdir /s /q "build"
if exist "dist" rmdir /s /q "dist"
if exist "FHGearbox_MS_store.spec" del "FHGearbox_MS_store.spec"

popd
echo.
pause