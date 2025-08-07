@echo off
chcp 65001 >nul
echo MSA Services Setup for Windows...

REM 1. Setup Gradle Wrappers
echo Setting up Gradle Wrappers...
copy gradlew.bat UserService\ >nul
copy gradlew.bat PostService\ >nul
xcopy /E /I gradle UserService\gradle >nul
xcopy /E /I gradle PostService\gradle >nul

REM 2. Build Services
echo Building UserService...
cd UserService
gradlew.bat clean build -x test
if %ERRORLEVEL% neq 0 (
    echo UserService build failed!
    pause
    exit /b 1
)

echo Building PostService...
cd ..\PostService
gradlew.bat clean build -x test
if %ERRORLEVEL% neq 0 (
    echo PostService build failed!
    pause
    exit /b 1
)

REM 3. Start Services
echo Starting UserService on port 8081...
cd ..\UserService
start /B java -jar build\libs\user-service-0.0.1-SNAPSHOT.jar

echo Starting PostService on port 8080...
cd ..\PostService
start /B java -jar build\libs\post-service-0.0.1-SNAPSHOT.jar

REM 4. Wait for services to start
echo Waiting for services to start...
timeout /t 5 /nobreak >nul

REM 5. Test Services
echo Testing UserService...
curl -s http://localhost:8081/users/1

echo.
echo Testing PostService integration...
curl -s http://localhost:8080/posts/1

echo.
echo Services started successfully!
echo UserService: http://localhost:8081
echo PostService: http://localhost:8080
echo.
echo To stop services, use: taskkill /f /im java.exe
pause
