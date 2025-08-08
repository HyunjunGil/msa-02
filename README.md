# MSA (Microservices Architecture) Project

## 📚 프로젝트 개요

### 🤔 **왜 이 프로젝트를 만들었나요?**

현대의 대규모 웹 서비스(Netflix, Amazon, Google, 카카오톡, 배달의민족 등)는 모두 **마이크로서비스 아키텍처**를 사용합니다. 
하지만 기존의 모놀리식(단일) 애플리케이션만 경험한 개발자에게는 다음과 같은 어려움이 있습니다:

- 🤷‍♂️ "서비스를 어떻게 나누어야 하지?"
- 😰 "서비스끼리 어떻게 통신하지?"
- 😱 "하나의 서비스가 죽으면 전체가 마비되는 거 아닌가?"
- 🤯 "로그는 어떻게 추적하지? 디버깅은 어떻게 하지?"

이 프로젝트는 **실제 손으로 만져보고 실험할 수 있는 최소한의 MSA 환경**을 제공하여, 이론이 아닌 **체험을 통한 학습**을 목표로 합니다.

### 🎯 **무엇을 배울 수 있나요?**

#### **1단계: MSA의 기본 개념 체득**
- **단일 애플리케이션 vs 분산 애플리케이션**의 차이점을 몸으로 느끼기
- **독립적인 배포**가 왜 중요한지 이해하기
- **서비스 간 의존성**이 어떤 문제를 일으키는지 경험하기

#### **2단계: 실제 문제 상황 대응**
- 🚨 **"UserService가 갑자기 죽었어요!"** → PostService는 어떻게 대응해야 할까?
- 🔄 **"트래픽이 몰려서 UserService만 확장하고 싶어요"** → 어떻게 해야 할까?
- 📊 **"어느 서비스에서 에러가 발생했는지 모르겠어요"** → 어떻게 추적할까?

#### **3단계: 실무 적용 능력 배양**
- **Spring Cloud** 생태계 이해
- **Docker/Kubernetes** 환경에서의 배포 경험
- **모니터링 및 로깅** 시스템 구축 방법

## 🎯 학습 목표

### 1️⃣ **마이크로서비스 아키텍처 이해**
- **모놀리식 vs 마이크로서비스**: 전통적인 단일 애플리케이션과 마이크로서비스의 차이점 이해
- **서비스 분리**: 도메인별로 서비스를 분리하는 방법과 그 장단점 학습
- **독립적 배포**: 각 서비스가 독립적으로 개발, 배포, 확장될 수 있음을 체험

### 2️⃣ **서비스 간 통신 (Inter-Service Communication)**
- **HTTP REST API**: 서비스 간 HTTP 기반 동기 통신 구현
- **RestTemplate 사용법**: Spring Boot에서 다른 서비스 호출 방법
- **서비스 주소 관리**: 하드코딩된 URL vs 서비스 디스커버리 개념 이해

### 3️⃣ **장애 처리 및 복원력 (Resilience)**
- **Graceful Degradation**: 의존 서비스 장애 시 우아한 성능 저하 처리
- **Fallback 메커니즘**: 기본값 반환을 통한 서비스 연속성 보장
- **Circuit Breaker 패턴**: 연쇄 장애 방지를 위한 기본 개념 이해

### 4️⃣ **컨테이너화 및 오케스트레이션**
- **Docker 컨테이너**: 각 마이크로서비스를 독립적인 컨테이너로 패키징
- **Docker Compose**: 다중 컨테이너 애플리케이션 관리
- **네트워크 분리**: 컨테이너 간 내부 네트워크 통신 구성

### 5️⃣ **모니터링 및 디버깅**
- **로그 수집**: 분산 시스템에서의 로그 관리의 중요성
- **서비스 상태 확인**: Health Check 및 상태 모니터링
- **분산 추적**: 여러 서비스를 거치는 요청의 흐름 이해

## 🏗️ 아키텍처 설명

### 서비스 구성
```
┌─────────────────┐    HTTP Request    ┌──────────────────┐
│   Client        │ ─────────────────→ │   PostService    │
│ (Browser/Tool)  │                    │   (Port: 8080)   │
└─────────────────┘                    └──────────┬───────┘
                                                  │
                                                  │ HTTP Call
                                                  │ GET /users/{id}
                                                  ↓
                                       ┌──────────────────┐
                                       │   UserService    │
                                       │   (Port: 8081)   │
                                       └──────────────────┘
```

### 통신 흐름
1. **클라이언트** → PostService에 게시글 정보 요청
2. **PostService** → UserService에 작성자 정보 요청
3. **UserService** → 사용자 데이터 반환
4. **PostService** → 게시글 + 작성자 정보 조합하여 최종 응답

### 장애 시나리오
```
❌ UserService 장애 발생
   ↓
✅ PostService는 "Unknown User"로 대체하여 서비스 계속 제공
   (Graceful Degradation)
```

## 💼 실무 연결점

### **🏢 실제 기업에서는 어떻게 사용되고 있을까?**

#### **🎬 Netflix의 경우**
- **700개 이상의 마이크로서비스** 운영
- **하루에 수십억 건의 API 호출** 처리
- **장애 복구 시간**: 전체 서비스 중단 없이 개별 서비스만 복구
- **개발팀**: 각 서비스별로 독립적인 팀 구성 (2-Pizza Team)

#### **🛒 쿠팡의 경우**
- **주문, 결제, 배송, 상품** 등 도메인별 서비스 분리
- **블랙프라이데이 같은 대용량 트래픽** 시 필요한 서비스만 확장
- **A/B 테스트**: 특정 서비스만 새 버전으로 배포하여 실험

#### **💬 카카오톡의 경우**
- **메시지, 친구, 프로필, 게임** 등 기능별 서비스 분리
- **실시간 메시징**: 각 서비스 간 비동기 통신으로 빠른 응답
- **글로벌 서비스**: 지역별로 독립적인 서비스 배포

### **🔧 이 프로젝트 → 실무 연결 로드맵**

#### **현재 프로젝트에서 경험하는 것**
```
UserService (사용자 관리) ←→ PostService (게시글 관리)
```

#### **실무에서 확장되는 모습**
```
🔐 AuthService     ←→  🛒 OrderService
      ↕                    ↕
👤 UserService     ←→  💳 PaymentService  
      ↕                    ↕
📝 PostService     ←→  📦 DeliveryService
      ↕                    ↕
📊 AnalyticsService ←→  📧 NotificationService
```

#### **이 프로젝트 완료 후 다음 단계**
1. **중급 과정** (3-6개월)
   - 데이터베이스 분리 (각 서비스별 독립 DB)
   - 메시지 큐 도입 (RabbitMQ, Kafka)
   - API Gateway 구현
   
2. **고급 과정** (6-12개월)
   - Kubernetes 클러스터 구축
   - Service Mesh 도입
   - 분산 추적 시스템 구축
   
3. **실무 적용** (1년+)
   - 대용량 트래픽 처리
   - 멀티 리전 배포
   - DevOps 파이프라인 구축

### **💰 커리어 관점에서의 가치**

#### **Junior → Mid-level Developer**
- ✅ "MSA 환경에서 개발 경험 있음"
- ✅ "서비스 간 통신 설계 가능"
- ✅ "Docker/Kubernetes 기초 이해"

#### **Mid-level → Senior Developer**  
- ✅ "대규모 분산 시스템 설계 경험"
- ✅ "장애 대응 및 복구 전략 수립"
- ✅ "팀 간 협업을 위한 API 설계"

#### **실제 면접에서 나오는 질문들**
- **"서비스 간 데이터 일관성은 어떻게 보장하나요?"** → 이 프로젝트에서 경험한 Fallback 메커니즘이 기초
- **"하나의 서비스 장애가 전체에 영향을 주지 않으려면?"** → Circuit Breaker 패턴의 필요성 이해
- **"서비스 배포 시 무중단 배포는 어떻게 하나요?"** → 독립적 배포의 중요성 체험

## 🔬 실습을 통해 체험할 수 있는 것

### ✅ **정상 상황**
- 모든 서비스가 정상 작동할 때의 요청 흐름
- 서비스 간 데이터 조합 및 응답 생성

### ⚠️ **장애 상황**
- UserService 중단 시 PostService의 동작
- Fallback 메커니즘을 통한 서비스 연속성

### 🔄 **복구 상황**
- 장애 서비스 복구 후 정상 동작 재개
- 시스템의 자가 복구 능력

### 📊 **확장성 실험**
- 각 서비스의 독립적인 스케일링
- 로드밸런싱 및 부하 분산

## 🎓 학습 단계별 접근

### **Phase 1: 기본 이해** (현재 구현된 내용)
- [x] 서비스 분리 및 독립 실행
- [x] HTTP 기반 서비스 간 통신
- [x] 기본적인 장애 처리 (Fallback)
- [x] Docker 컨테이너화

### **Phase 2: 중급 확장** (추후 학습 권장)
- [ ] Service Discovery 구현 (Eureka)
- [ ] API Gateway 추가 (Spring Cloud Gateway)
- [ ] Circuit Breaker 패턴 (Resilience4j)
- [ ] 분산 설정 관리 (Spring Cloud Config)

### **Phase 3: 고급 운영** (실무 적용)
- [ ] Kubernetes 오케스트레이션
- [ ] Service Mesh 도입
- [ ] 분산 추적 시스템
- [ ] 중앙화된 로깅 (ELK Stack)

## 📖 참고 자료

### **마이크로서비스 아키텍처 관련 도서**
- "마이크로서비스 패턴" - Chris Richardson
- "Building Microservices" - Sam Newman
- "Microservices AntiPatterns and Pitfalls" - Mark Richards

### **Spring Cloud 공식 문서**
- [Spring Cloud Documentation](https://spring.io/projects/spring-cloud)
- [Spring Boot Reference Guide](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/)

### **실습 환경 확장 아이디어**
- 데이터베이스 분리 (각 서비스별 독립 DB)
- 비동기 메시징 (RabbitMQ, Apache Kafka)
- 보안 및 인증 (OAuth2, JWT)
- 모니터링 대시보드 (Prometheus + Grafana)

## 🛠️ 기술 스택

### **Backend Framework**
- **Spring Boot 3.1.2** - 마이크로서비스 기본 프레임워크
- **Java 17** - 최신 LTS 버전으로 향상된 성능과 보안
- **RestTemplate** - 서비스 간 HTTP 통신

### **Containerization & Orchestration**
- **Docker** - 각 서비스의 독립적인 컨테이너화
- **Docker Compose** - 다중 컨테이너 환경 관리
- **Gradle Wrapper** - 빌드 도구 및 의존성 관리

### **Testing & Monitoring**
- **Spring Boot Test** - 단위 테스트 및 통합 테스트
- **HTTP Client** - API 엔드포인트 테스트
- **Docker Logs** - 컨테이너 수준 로깅

## 📡 API 명세서

### **UserService** (Port: 8081)
| Method | Endpoint | Description | Response |
|--------|----------|-------------|----------|
| GET | `/users/{id}` | 사용자 정보 조회 | `{"id": 1, "name": "User 1"}` |

### **PostService** (Port: 8080)
| Method | Endpoint | Description | Response |
|--------|----------|-------------|----------|
| GET | `/posts/{id}` | 게시글 정보 조회<br/>(작성자 정보 포함) | `{"id": 1, "title": "Post 1", "content": "...", "author": "User 1"}` |

### **서비스 간 내부 통신**
```
PostService → UserService
GET http://userservice:8081/users/{id}  # Docker 내부 네트워크
GET http://localhost:8081/users/{id}    # 로컬 개발 환경
```

## 🏛️ 프로젝트 구조

```
msa/
├── UserService/                 # 사용자 서비스
│   ├── src/main/java/
│   │   └── com/example/userservice/
│   │       ├── UserServiceApplication.java
│   │       ├── UserController.java
│   │       └── UserDto.java
│   ├── Dockerfile              # 컨테이너 빌드 설정
│   └── build.gradle            # 의존성 관리
│
├── PostService/                # 게시글 서비스
│   ├── src/main/java/
│   │   └── com/example/postservice/
│   │       ├── PostServiceApplication.java
│   │       ├── PostController.java
│   │       ├── PostDto.java
│   │       ├── UserClient.java     # UserService 호출 클라이언트
│   │       └── RestTemplateConfig.java
│   ├── Dockerfile
│   └── build.gradle
│
├── src/test/                   # 테스트 파일
│   ├── request.http            # API 테스트용 HTTP 파일
│   └── post-check.http         # 통합 테스트용 HTTP 파일
│
├── docker-compose.yml          # 다중 컨테이너 설정
├── docker-setup.sh             # 자동 환경 설정 스크립트
├── test-msa.sh                 # 통합 테스트 스크립트
└── README.md                   # 프로젝트 문서
```

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

## 🧪 Testing Guide

### 테스트 준비

1. **서비스 실행 확인**
   ```bash
   # Docker 컨테이너 상태 확인
   docker ps
   
   # 또는 로컬 실행 시 프로세스 확인
   curl http://localhost:8081/users/1
   curl http://localhost:8080/posts/1
   ```

### HTTP 테스트 파일 사용

프로젝트에 포함된 `.http` 파일을 VS Code 또는 IntelliJ에서 실행:

#### 📁 `src/test/request.http`
- UserService 단독 테스트
- PostService 정상 호출 테스트  
- PostService 장애 상황 테스트

#### 📁 `src/test/post-check.http`
- PostService와 UserService 간의 통신 테스트
- 장애 복구 시나리오 테스트

### 테스트 시나리오

#### 1️⃣ **정상 통신 테스트**
```bash
# UserService 테스트
curl -X GET http://localhost:8081/users/1 \
  -H "Accept: application/json"

# PostService 테스트 (UserService 호출 포함)
curl -X GET http://localhost:8080/posts/1 \
  -H "Accept: application/json"
```

**예상 결과:**
```json
// UserService 응답
{"id":1,"name":"User 1"}

// PostService 응답 (UserService 호출 성공)
{"id":1,"title":"Post 1","content":"This is the content of post 1","author":"User 1"}
```

#### 2️⃣ **장애 상황 테스트**
```bash
# UserService 중단
docker stop userservice

# PostService 호출 (장애 상황)
curl -X GET http://localhost:8080/posts/1 \
  -H "Accept: application/json"
```

**예상 결과:**
```json
// UserService 호출 실패 시
{"id":1,"title":"Post 1","content":"This is the content of post 1","author":"Unknown User"}
```

#### 3️⃣ **서비스 복구 테스트**
```bash
# UserService 재시작
docker start userservice

# 잠시 대기 후 다시 테스트
sleep 10
curl -X GET http://localhost:8080/posts/1 \
  -H "Accept: application/json"
```

### 자동화된 테스트

#### Docker 환경 전체 테스트
```bash
# 전체 환경 설정 및 테스트
./docker-setup.sh

# 또는 Windows에서
docker-setup.bat
```

#### 🎯 원클릭 통합 테스트 (추천!)
```bash
# 자동화된 MSA 테스트 실행
./test-msa.sh
```

이 스크립트는 다음을 자동으로 수행합니다:
- ✅ Docker 컨테이너 상태 확인
- ✅ UserService 연결 테스트
- ✅ PostService 정상 호출 테스트
- ✅ 장애 시나리오 테스트 (UserService 중단)
- ✅ 서비스 복구 테스트
- ✅ 최종 상태 확인

#### 연속 테스트 스크립트
```bash
#!/bin/bash
echo "=== MSA 서비스 테스트 시작 ==="

echo "1. UserService 테스트..."
curl -s http://localhost:8081/users/1 | jq .

echo "2. PostService 정상 테스트..."
curl -s http://localhost:8080/posts/1 | jq .

echo "3. UserService 중단..."
docker stop userservice

echo "4. PostService 장애 테스트..."
curl -s http://localhost:8080/posts/1 | jq .

echo "5. UserService 복구..."
docker start userservice
sleep 5

echo "6. PostService 복구 테스트..."
curl -s http://localhost:8080/posts/1 | jq .

echo "=== 테스트 완료 ==="
```

### 로그 모니터링

실시간 로그 확인:
```bash
# 모든 서비스 로그 실시간 확인
docker-compose logs -f

# 개별 서비스 로그 확인
docker logs -f userservice
docker logs -f postservice
```

### 성능 테스트

간단한 부하 테스트:
```bash
# Apache Bench 사용 (설치 필요)
ab -n 100 -c 10 http://localhost:8080/posts/1

# curl을 이용한 반복 테스트
for i in {1..10}; do
  echo "Test $i:"
  time curl -s http://localhost:8080/posts/1
  echo
done
```

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
