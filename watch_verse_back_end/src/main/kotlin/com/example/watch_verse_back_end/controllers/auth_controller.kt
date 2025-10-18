package com.example.watch_verse_back_end.controllers

import com.example.watch_verse_back_end.request_models.RefreshTokenRequest
import com.example.watch_verse_back_end.request_models.UserLoginRequest
import com.example.watch_verse_back_end.request_models.UserSignUpRequest
import com.example.watch_verse_back_end.response_models.UserResponse
import com.example.watch_verse_back_end.security.AuthService
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/auth")
class AuthController(
    private val authService: AuthService,
) {
    @PostMapping("/signup")
    fun signUp(@RequestBody userSignUpRequest: UserSignUpRequest): UserResponse =
        authService.signUp(userSignUpRequest.username, userSignUpRequest.email, userSignUpRequest.password)

    @PostMapping("/login")
    fun login(@RequestBody userLoginRequest: UserLoginRequest): AuthService.TokenPair =
        authService.login(userLoginRequest.email, userLoginRequest.password)

    @PostMapping("/refresh")
    fun refreshToken(@RequestBody refreshTokenRequest: RefreshTokenRequest): AuthService.TokenPair =
        authService.refresh(refreshTokenRequest.refreshToken)
}