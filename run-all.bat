@echo off
title FoodVerse Runner
echo ==========================================
echo        FoodVerse App Starter Script
echo ==========================================
echo.

:: Check if MongoDB is running (attempt to connect or just let the seeder/server notify)
echo [1/3] Seeding the database (MongoDB)...
cd backend
call node seeder.js
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [WARNING] Seeding failed or MongoDB is not running/connected.
    echo Please make sure MongoDB is running at: mongodb://127.0.0.1:27017
    echo.
    set /p proceed="Do you want to try starting the servers anyway? (y/n): "
    if /I "%proceed%" NEQ "y" exit /b
) else (
    echo [SUCCESS] Database successfully seeded!
)
echo.

echo [2/3] Starting Backend Server on port 5000...
start "FoodVerse Backend (Port 5000)" cmd /k "node server.js"
echo.

echo [3/3] Starting Frontend Server (Vite)...
cd ../frontend
start "FoodVerse Frontend (Vite)" cmd /k "npm run dev"
echo.

echo ==========================================
echo  FoodVerse is starting! 
echo  - Backend runs on http://localhost:5000
echo  - Frontend runs on Vite dev URL (typically http://localhost:5173)
echo ==========================================
echo.
pause
