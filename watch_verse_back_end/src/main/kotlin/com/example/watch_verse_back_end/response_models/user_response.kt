package com.example.watch_verse_back_end.response_models

import java.time.Instant


data class UserResponse(
    val id: String,
    val username: String,
    val email: String,
    val createdAt: Instant,
    val updatedAt: Instant,
)