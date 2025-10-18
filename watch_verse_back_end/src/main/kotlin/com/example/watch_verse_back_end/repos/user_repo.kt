package com.example.watch_verse_back_end.repos

import com.example.watch_verse_back_end.entities.UserEntity
import org.bson.types.ObjectId
import org.springframework.data.mongodb.repository.MongoRepository

interface UserRepo : MongoRepository<UserEntity, ObjectId> {
    fun findByUsername(username: String): UserEntity?
    fun findByEmail(email: String): UserEntity?
}