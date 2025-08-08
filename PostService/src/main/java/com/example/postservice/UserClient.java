package com.example.postservice;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

@Component
public class UserClient {

    private final RestTemplate restTemplate;

    public UserClient(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    // For local
    public String getUserName(Long userId) {
        try {
            // 로컬 개발 환경에서는 localhost 사용
            String url = "http://localhost:8081/users/" + userId;
            ResponseEntity<UserResponse> response = restTemplate.getForEntity(url, UserResponse.class);
            return response.getBody() != null ? response.getBody().getName() : "Unknown User";
        } catch (Exception e) {
            return "Unknown User";
        }
    }

    // For Docker
    // public String getUserName(Long userId) {
    //     try {
    //         // Docker 환경에서는 서비스 이름 사용, 로컬에서는 localhost 사용
    //         String userServiceUrl = System.getenv("USER_SERVICE_URL");
    //         if (userServiceUrl == null) {
    //             // 환경변수가 없으면 Docker 서비스 이름을 기본값으로 사용
    //             userServiceUrl = "http://userservice:8081";
    //         }
            
    //         String url = userServiceUrl + "/users/" + userId;
    //         ResponseEntity<UserResponse> response = restTemplate.getForEntity(url, UserResponse.class);
    //         return response.getBody() != null ? response.getBody().getName() : "Unknown User";
    //     } catch (Exception e) {
    //         System.err.println("Failed to fetch user from UserService: " + e.getMessage());
    //         return "Unknown User";
    //     }
    // }

    static class UserResponse {
        private Long id;
        private String name;

        public Long getId() {
            return id;
        }

        public void setId(Long id) {
            this.id = id;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }
    }
}
