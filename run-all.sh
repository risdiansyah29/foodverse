#!/bin/bash
echo "=========================================="
echo "       FoodVerse App Starter Script"
echo "=========================================="
echo ""

# Go to backend and seed
echo "[1/3] Seeding the database (MongoDB)..."
cd backend
node seeder.js
if [ $? -ne 0 ]; then
    echo ""
    echo "[WARNING] Seeding failed or MongoDB is not running/connected."
    echo "Please make sure MongoDB is running at: mongodb://127.0.0.1:27017"
    echo ""
    read -p "Do you want to try starting the servers anyway? (y/n): " proceed
    if [[ ! "$proceed" =~ ^[Yy]$ ]]; then
        exit 1
    fi
else
    echo "[SUCCESS] Database successfully seeded!"
fi
echo ""

echo "[2/3] Starting Backend Server on port 5000..."
# Start backend in a background job or new window depending on OS
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
    start "FoodVerse Backend (Port 5000)" node server.js &
else
    node server.js &
fi
echo ""

echo "[3/3] Starting Frontend Server (Vite)..."
cd ../frontend
npm run dev
