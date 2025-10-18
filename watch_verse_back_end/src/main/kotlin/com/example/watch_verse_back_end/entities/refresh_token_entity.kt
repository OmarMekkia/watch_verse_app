package com.example.watch_verse_back_end.entities

import org.bson.types.ObjectId
import org.springframework.data.mongodb.core.index.Indexed
import org.springframework.data.mongodb.core.mapping.Document
import java.time.Instant

@Document(collection = "refresh_tokens")
data class RefreshTokenEntity(
    val userId: ObjectId? = null,
    val hashedToken: String,
    @Indexed(expireAfter = "0s")
    val expires_at: Instant,
    val created_at: Instant = Instant.now(),

    )
