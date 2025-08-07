#!/bin/bash

# 1. Gradle Wrapper 설정
echo "Setting up Gradle Wrappers..."
cp gradlew UserService/ && cp gradlew.bat UserService/ && cp -r gradle UserService/
cp gradlew PostService/ && cp gradlew.bat PostService/ && cp -r gradle PostService/

# 2. 권한 설정 및 빌드
echo "Building UserService..."
cd UserService && chmod +x gradlew && ./gradlew clean build -x test

echo "Building PostService..."
cd ../PostService && chmod +x gradlew && ./gradlew clean build -x test

# 3. 서비스 시작
echo "Starting UserService on port 8081..."
cd ../UserService && java -jar build/libs/user-service-0.0.1-SNAPSHOT.jar &
USER_PID=$!

echo "Starting PostService on port 8080..."
cd ../PostService && java -jar build/libs/post-service-0.0.1-SNAPSHOT.jar &
POST_PID=$!

# 4. 서비스 시작 대기
echo "Waiting for services to start..."
sleep 5

# 5. 테스트
echo "Testing UserService..."
curl -s http://localhost:8081/users/1

echo -e "\nTesting PostService integration..."
curl -s http://localhost:8080/posts/1

echo -e "\nServices started successfully!"
echo "UserService PID: $USER_PID (port 8081)"
echo "PostService PID: $POST_PID (port 8080)"
