#!/bin/bash

# MSA 서비스 통합 테스트 스크립트
# 사용법: ./test-msa.sh

set -e

echo "🚀 === MSA 서비스 테스트 시작 ==="
echo

# 색상 정의
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 함수 정의
print_step() {
    echo -e "${BLUE}$1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

test_endpoint() {
    local url=$1
    local description=$2
    
    print_step "🔍 $description"
    response=$(curl -s -w "\n%{http_code}" "$url" 2>/dev/null)
    
    if [ $? -eq 0 ]; then
        http_code=$(echo "$response" | tail -n1)
        body=$(echo "$response" | head -n -1)
        
        if [ "$http_code" = "200" ]; then
            print_success "응답 성공 (HTTP $http_code)"
            echo "   📝 응답: $body"
        else
            print_warning "HTTP $http_code 응답"
            echo "   📝 응답: $body"
        fi
    else
        print_error "연결 실패 - 서비스가 실행되지 않았을 수 있습니다"
    fi
    echo
}

# 1. 서비스 상태 확인
print_step "1️⃣ Docker 컨테이너 상태 확인"
if docker ps | grep -q "userservice\|postservice"; then
    docker ps --filter "name=userservice" --filter "name=postservice" --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
    print_success "Docker 컨테이너 실행 중"
else
    print_warning "Docker 컨테이너가 실행되지 않음. 먼저 docker-compose up -d 를 실행하세요."
fi
echo

# 2. UserService 테스트
test_endpoint "http://localhost:8081/users/1" "UserService 테스트"

# 3. PostService 정상 테스트
test_endpoint "http://localhost:8080/posts/1" "PostService 정상 호출 테스트 (UserService 연동)"

# 4. 장애 시나리오 테스트
print_step "4️⃣ 장애 시나리오 테스트"
if docker ps | grep -q "userservice"; then
    print_step "🛑 UserService 중단 중..."
    docker stop userservice > /dev/null 2>&1
    print_warning "UserService 중단됨"
    
    # 잠시 대기
    sleep 3
    
    # PostService 장애 상황 테스트
    test_endpoint "http://localhost:8080/posts/1" "PostService 장애 상황 테스트 (UserService 중단 시)"
    
    # UserService 복구
    print_step "🔄 UserService 복구 중..."
    docker start userservice > /dev/null 2>&1
    print_success "UserService 재시작됨"
    
    # 서비스 시작 대기
    print_step "⏳ 서비스 시작 대기 중... (10초)"
    sleep 10
    
    # 복구 테스트
    test_endpoint "http://localhost:8080/posts/1" "PostService 복구 테스트 (UserService 복구 후)"
else
    print_warning "UserService 컨테이너를 찾을 수 없어 장애 테스트를 건너뜁니다"
fi

# 5. 최종 상태 확인
print_step "5️⃣ 최종 서비스 상태 확인"
if docker ps | grep -q "userservice\|postservice"; then
    docker ps --filter "name=userservice" --filter "name=postservice" --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
    print_success "모든 서비스가 정상 실행 중"
else
    print_error "일부 서비스가 실행되지 않고 있습니다"
fi

echo
print_success "🎉 MSA 서비스 테스트 완료!"
echo
echo "📌 추가 테스트 방법:"
echo "   - VS Code에서 src/test/*.http 파일 실행"
echo "   - 브라우저에서 http://localhost:8081/users/1 접속"
echo "   - 브라우저에서 http://localhost:8080/posts/1 접속"
echo
