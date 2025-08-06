package com.example.backend.controller;

import com.example.backend.dto.LoginRequest;
import com.example.backend.model.User;
import com.example.backend.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/user")
@CrossOrigin
public class UserController {

    @Autowired
    private UserService userService;

    @PostMapping("/register")
    public String register(@RequestBody User user) {
        return userService.registerUser(user);
    }

    @PostMapping("/login")
    public String login(@RequestBody LoginRequest loginRequest) {
        return userService.loginUser(loginRequest);
    }

    @PostMapping("/forgot-password")
    public String forgotPassword(@RequestBody String email) {
        return userService.forgotPassword(email.replace("\"", ""));
    }

    @GetMapping("/profile/{email}")
    public User getUser(@PathVariable String email) {
        return userService.getUserByEmail(email);
    }
}
