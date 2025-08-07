@echo off
chcp 65001 >nul
echo Building MSA Services...

echo.
echo 1. Building UserService...
cd UserService
gradlew.bat clean build -x test
if %ERRORLEVEL% neq 0 (
    echo UserService build failed!
    pause
    exit /b 1
)
cd ..

echo.
echo 2. Building PostService...
cd PostService
gradlew.bat clean build -x test
if %ERRORLEVEL% neq 0 (
    echo PostService build failed!
    pause
    exit /b 1
)
cd ..

echo.
echo Build completed successfully!
echo.
echo To run services manually:
echo 1. cd UserService && java -jar build\libs\user-service-0.0.1-SNAPSHOT.jar
echo 2. cd PostService && java -jar build\libs\post-service-0.0.1-SNAPSHOT.jar
echo.
pause
