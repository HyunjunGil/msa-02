package com.example.userservice;

import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/users")
public class UserController {

    @GetMapping("/{id}")
    public UserDto getUser(@PathVariable Long id) {
        return new UserDto(id, "User" + id);
    }
}
