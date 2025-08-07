package com.example.postservice;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class PostController {

    private final UserClient userClient;

    public PostController(UserClient userClient) {
        this.userClient = userClient;
    }

    @GetMapping("/posts/{id}")
    public PostDto getPost(@PathVariable Long id) {
        PostDto post = new PostDto();
        post.setId(id);
        post.setTitle("Post " + id);
        post.setContent("This is the content of post " + id);
        
        // UserService에서 사용자 정보 가져오기
        String userName = userClient.getUserName(id);
        post.setAuthor(userName);
        
        return post;
    }
}
