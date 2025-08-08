@echo off
echo ===============================================
echo    EkLabs Website Asset Optimization
echo ===============================================
echo.

echo [1/2] Installing Python dependencies...
pip install Pillow pillow-heif

echo.
echo [2/3] Optimizing images...
python optimize_images.py

echo.
echo [3/3] Optimizing videos...
powershell -ExecutionPolicy Bypass -File optimize_videos.ps1

echo.
echo ===============================================
echo    Optimization Complete!
echo ===============================================
echo.
echo Next steps:
echo 1. Check the assets/images/optimized folder
echo 2. Check the assets/videos/optimized folder
echo 3. Test the website performance
echo.
pause
