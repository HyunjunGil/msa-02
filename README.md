# MSA (Microservices Architecture) Project

This is a Spring Boot microservices application that demonstrates a simple microservices architecture with user and post services.

## Project Structure

- **User Service**: Handles user-related operations (`/users/{id}`)
- **Post Service**: Handles post-related operations (`/posts`) with user information integration

## Features

- RESTful API endpoints
- Service-to-service communication using RestTemplate
- JSON response format
- Spring Boot 3.1.2 with Java 17

## API Endpoints

### User Service
- `GET /users/{id}` - Get user information by ID

### Post Service
- `GET /posts` - Get list of posts with author information

## 🚀 How to Run Now

### **Option 1: Use the Windows Script (Recommended)**
```cmd
run-services.bat
```
This script will automatically:
- Set up Gradle wrappers for both services
- Build UserService and PostService
- Start both services on their respective ports
- Test the services

### **Option 2: Manual Build and Run**
```cmd
# Step 1: Build both services
build-services.bat

# Step 2: Run UserService (in one terminal)
cd UserService
java -jar build\libs\user-service-0.0.1-SNAPSHOT.jar

# Step 3: Run PostService (in another terminal)
cd PostService
java -jar build\libs\post-service-0.0.1-SNAPSHOT.jar
```

### **Option 3: Troubleshooting**
```cmd
troubleshooting.bat
```
Use this script to:
- Check service status
- Restart services
- Diagnose connection issues
- Test service communication

### **Service URLs**
- **UserService**: http://localhost:8081
- **PostService**: http://localhost:8080
- **Test Endpoints**:
  - UserService: `GET http://localhost:8081/users/1`
  - PostService: `GET http://localhost:8080/posts/1`

## Testing

Use the provided HTTP request file (`src/test/request.http`) to test the endpoints:

- Test user service: `GET http://localhost:8080/users/1`
- Test post service: `GET http://localhost:8080/posts`

## Build

To build the project:
```bash
./gradlew build
```

## Dependencies

- Spring Boot Starter Web
- Spring Boot Starter Test (for testing)

# Block 2: Docker 환경 전환 실습 안내

## 1. 포트 설정 확인
- `UserService`는 **8081**
- `PostService`는 **8080**에서 실행되어야 합니다

## 2. Dockerfile 작성
- 각 서비스 디렉토리에 `Dockerfile`을 직접 작성하세요

## 3. Docker 네트워크 생성

```bash
docker network create msa-network
```

## 4. 컨테이너 실행

### 방법 1: Docker Compose 사용 (권장)
```bash
# 전체 서비스 한 번에 실행
docker-compose up -d --build

# 서비스 중지
docker-compose down
```

### 방법 2: 개별 컨테이너 실행
```bash
# UserService 빌드 및 실행
cd UserService
docker build -t userservice .
docker run -d --name userservice --network msa-network -p 8081:8081 userservice

# PostService 빌드 및 실행
cd PostService
docker build -t postservice .
docker run -d --name postservice --network msa-network -p 8080:8080 postservice
```

### 방법 3: 자동화 스크립트 사용
```bash
# Linux/Mac
./docker-setup.sh

# Windows
docker-setup.bat
```

## 5. PostService → UserService 호출 주소
- 내부 DNS 이름을 사용해야 하므로 `http://userservice:8081`로 호출해야 합니다

## 6. 통신 확인 테스트

- `.http` 파일을 사용해 `PostService`의 동작을 확인해보세요
- 실패 실험을 위해 `UserService`를 중단한 상태에서도 호출해보세요

## 7. 문제 해결

### 컨테이너 로그 확인
```bash
# UserService 로그
docker logs userservice

# PostService 로그
docker logs postservice
```

### 네트워크 연결 확인
```bash
# 네트워크 목록 확인
docker network ls

# 네트워크 상세 정보 확인
docker network inspect msa-network
```

### 컨테이너 재시작
```bash
# 개별 컨테이너 재시작
docker restart userservice
docker restart postservice

# 또는 Docker Compose 사용
docker-compose restart
```
