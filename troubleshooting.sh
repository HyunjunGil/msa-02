#!/bin/bash

echo "=== MSA Services Troubleshooting ==="

echo -e "\n1. 실행 중인 서비스 확인:"
echo "포트 사용 확인:"
lsof -i :8080 -i :8081

echo -e "\nJava 프로세스 확인:"
ps aux | grep java

echo -e "\n2. 서비스 재시작 (PostService):"
echo "기존 PostService 프로세스 종료..."
pkill -f 'post-service' && sleep 2

echo "PostService 재빌드 및 시작..."
cd PostService && ./gradlew build -x test
java -jar build/libs/post-service-0.0.1-SNAPSHOT.jar &

echo -e "\n3. 모든 서비스 중지:"
echo "UserService 중지:"
pkill -f 'user-service'
echo "PostService 중지:"
pkill -f 'post-service'

echo -e "\n4. 서비스 상태 확인:"
echo "UserService 테스트:"
curl -s http://localhost:8081/users/1

echo -e "\nPostService 테스트:"
curl -s http://localhost:8080/posts/1

echo -e "\n=== Troubleshooting 완료 ==="
