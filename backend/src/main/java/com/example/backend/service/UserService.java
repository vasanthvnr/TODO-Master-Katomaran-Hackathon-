package com.example.backend.service;

import com.example.backend.dto.LoginRequest;
import com.example.backend.model.User;
import com.example.backend.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    public String registerUser(User user) {
        Optional<User> existingUser = userRepository.findByEmail(user.getEmail());
        if (existingUser.isPresent()) {
            return "Email already registered";
        }
        userRepository.save(user);
        return "User registered successfully";
    }

    public String loginUser(LoginRequest loginRequest) {
        Optional<User> user = userRepository.findByEmail(loginRequest.getEmail());
        if (user.isPresent() && user.get().getPassword().equals(loginRequest.getPassword())) {
            return "Login successful";
        }
        return "Invalid email or password";
    }

    public String forgotPassword(String email) {
        Optional<User> user = userRepository.findByEmail(email);
        if (user.isPresent()) {
            return "Reset link sent to your email";
        }
        return "Email not found";
    }

    public User getUserByEmail(String email) {
        return userRepository.findByEmail(email).orElse(null);
    }
}
