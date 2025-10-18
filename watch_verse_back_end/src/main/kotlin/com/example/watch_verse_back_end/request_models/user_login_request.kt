package com.example.watch_verse_back_end.request_models

data class UserLoginRequest(
    val email: String,
    val password: String
)