package com.example.watch_verse_back_end.repos

import com.example.watch_verse_back_end.entities.RefreshTokenEntity
import org.bson.types.ObjectId
import org.springframework.data.mongodb.repository.MongoRepository
import java.util.Optional

interface RefreshTokenRepo : MongoRepository<RefreshTokenEntity, ObjectId> {
    fun findByUserIdAndHashedToken(
        userId: ObjectId,
        hashedToken: String
    ): Optional<RefreshTokenEntity>

    fun deleteByUserIdAndHashedToken(
        userId: ObjectId,
        hashedToken: String
    )
}