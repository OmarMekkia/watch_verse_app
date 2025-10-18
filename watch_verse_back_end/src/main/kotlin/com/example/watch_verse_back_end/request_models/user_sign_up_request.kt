package com.example.watch_verse_back_end.request_models

data class UserSignUpRequest(
    var username: String,
    var email: String,
    var password: String,
)
