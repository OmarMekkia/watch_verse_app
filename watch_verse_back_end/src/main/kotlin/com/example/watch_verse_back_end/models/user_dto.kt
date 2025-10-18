package com.example.watch_verse_back_end.models

import org.bson.types.ObjectId
import java.time.Instant

data class UserDto(
    val id: ObjectId? = null,
    val username: String,
    val email: String,
    val hashedPassword: String,
    val createdAt: Instant? = null,
    val updatedAt: Instant? = null,

    )