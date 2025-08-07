package com.example.userservice;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class UserController {

    @GetMapping("/users/{id}")
    public UserDto getUser(@PathVariable Long id) {
        // 간단한 사용자 정보 반환 (실제로는 데이터베이스에서 조회)
        UserDto user = new UserDto();
        user.setId(id);
        user.setName("User " + id);
        return user;
    }
}
