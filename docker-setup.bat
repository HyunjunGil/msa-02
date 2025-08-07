@echo off
echo MSA Docker 환경 설정 시작...

REM Docker 네트워크 생성
echo 1. Docker 네트워크 생성 중...
docker network create msa-network 2>nul || echo 네트워크가 이미 존재합니다.

REM 기존 컨테이너 정리
echo 2. 기존 컨테이너 정리 중...
docker stop userservice postservice 2>nul
docker rm userservice postservice 2>nul

REM Docker Compose로 서비스 실행
echo 3. Docker Compose로 서비스 실행 중...
docker-compose up -d --build

echo 4. 서비스 상태 확인 중...
timeout /t 10 /nobreak >nul
docker ps

echo 5. 테스트 준비 완료!
echo UserService: http://localhost:8081/users/1
echo PostService: http://localhost:8080/posts/1
echo.
echo 테스트 방법:
echo - 정상 호출: PostService가 UserService를 호출할 수 있는 경우
echo - 실패 실험: docker stop userservice 후 PostService 호출
pause
