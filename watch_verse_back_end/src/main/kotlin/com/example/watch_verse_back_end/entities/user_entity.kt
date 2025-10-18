package com.example.watch_verse_back_end.entities

import org.bson.types.ObjectId
import org.springframework.data.annotation.CreatedDate
import org.springframework.data.annotation.Id
import org.springframework.data.annotation.LastModifiedDate
import org.springframework.data.mongodb.core.mapping.Document
import java.time.Instant

@Document(collection = "users")
data class UserEntity(
    @Id val id: ObjectId? = null,
    var username: String,
    var email: String,
    var hashedPassword: String,
    @CreatedDate val createdAt: Instant? = null,
    @LastModifiedDate var updatedAt: Instant? = null,
)