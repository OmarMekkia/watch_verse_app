package com.example.watch_verse_back_end.repos
import com.example.watch_verse_back_end.entities.FavouriteMovieEntity
import org.bson.types.ObjectId
import org.springframework.data.mongodb.repository.MongoRepository
import java.util.Optional

interface FavouriteMovieRepo : MongoRepository<FavouriteMovieEntity, ObjectId>{
    fun findByOwnerId(ownerId: ObjectId): List<FavouriteMovieEntity>
    fun findByOwnerIdAndId(ownerId: ObjectId, id: ObjectId): Optional<FavouriteMovieEntity>
    fun deleteByOwnerIdAndId(ownerId: ObjectId, id: ObjectId)
    fun deleteAllByOwnerId(ownerId: ObjectId)
}
