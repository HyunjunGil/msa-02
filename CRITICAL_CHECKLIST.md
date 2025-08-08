# 🚨 중요한 실수 방지 체크리스트

## ✅ 필수 확인 사항

- [ ] **UserClient.java에서 USER_SERVICE_URL이 `http://localhost:8081/users/` 인지 확인**
- [ ] **UserService application.yml에서 `port: 8081` 설정 확인**
- [ ] **PostService application.yml에서 `port: 8080` 설정 확인**
- [ ] **코드 변경 후 반드시 `./gradlew build` 재실행**
- [ ] **PostService 재시작 시 기존 프로세스 `pkill`로 종료**
- [ ] **JAR 파일명: `user-service-0.0.1-SNAPSHOT.jar`, `post-service-0.0.1-SNAPSHOT.jar`**

## 🔍 성공 확인 방법

### UserService 건강 상태 확인
```bash
curl -s http://localhost:8081/users/1
```
**예상 결과:** `{"id":1,"name":"User 1"}`

### 통합 상태 확인
```bash
curl -s http://localhost:8080/posts/1
```
**예상 결과:** `authorName`이 `User 1`, `User 2`로 나와야 함 (Unknown User가 아님)

### 포트 확인
```bash
lsof -i :8080 -i :8081
```
**예상 결과:** 두 포트 모두 java 프로세스가 LISTEN 상태

## 🚨 주의사항

- **UserClient URL이 `8080`이면 자기 자신을 호출해서 'Unknown User' 반환됨!**
- **코드 변경 후 반드시 재빌드 필요**
- **서비스 재시작 시 기존 프로세스 완전 종료 필수**
