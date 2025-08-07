@echo off
chcp 65001 >nul
echo === MSA Services Troubleshooting ===

echo.
echo 1. Service Status Check:
echo Port Usage Check:
netstat -ano | findstr :8080
netstat -ano | findstr :8081

echo.
echo Java Process Check:
tasklist | findstr java

echo.
echo 2. Restart PostService:
echo Stopping existing PostService processes...
taskkill /f /im java.exe 2>nul

echo Rebuilding and starting PostService...
cd PostService
gradlew.bat clean build -x test
start /B java -jar build\libs\post-service-0.0.1-SNAPSHOT.jar
cd ..

echo.
echo 3. Stop All Services:
taskkill /f /im java.exe

echo.
echo 4. Service Health Check:
echo Testing UserService:
curl -s http://localhost:8081/users/1

echo.
echo Testing PostService:
curl -s http://localhost:8080/posts/1

echo.
echo === Troubleshooting Complete ===
pause
