package com.example.watch_verse_back_end.services

import com.example.watch_verse_back_end.helpers.mapEntitiesListToResponseList
import com.example.watch_verse_back_end.mappers.toDto
import com.example.watch_verse_back_end.mappers.toEntity
import com.example.watch_verse_back_end.mappers.toResponse
import com.example.watch_verse_back_end.request_models.FavouriteMovieRequest
import com.example.watch_verse_back_end.repos.FavouriteMovieRepo
import com.example.watch_verse_back_end.response_models.FavouriteMovieResponse
import org.bson.types.ObjectId
import org.springframework.stereotype.Service

@Service
class FavouriteMovieService(
    private val favouriteMovieRepo: FavouriteMovieRepo
) {
    fun getFavouriteMovies(ownerId: ObjectId): List<FavouriteMovieResponse> =
        favouriteMovieRepo.findByOwnerId(ownerId = ownerId).mapEntitiesListToResponseList()

    fun addFavouriteMovie(ownerId: ObjectId,requestBody: FavouriteMovieRequest): FavouriteMovieResponse =
        favouriteMovieRepo.save(requestBody.toDto(ownerId = ownerId).toEntity()).toDto().toResponse()

    fun updateFavouriteMovie(ownerId: ObjectId,requestBody: FavouriteMovieRequest): FavouriteMovieResponse {
        val dto = requestBody.toDto(ownerId = ownerId)
        val id = dto.id ?: throw RuntimeException("ID is required for updating a favourite movie")
        val existingEntity = favouriteMovieRepo.findByOwnerIdAndId(ownerId = ownerId, id = id)
            .orElseThrow{throw RuntimeException("There is no favourite movie with id $id")}

        val updatedEntity = existingEntity.copy(
            ownerId = ownerId,
            adult = dto.adult,
            backdropPath = dto.backdropPath,
            genreIds = dto.genreIds,
            originalLanguage = dto.originalLanguage,
            originalTitle = dto.originalTitle,
            overview = dto.overview,
            popularity = dto.popularity,
            posterPath = dto.posterPath,
            releaseDate = dto.releaseDate,
            title = dto.title,
            video = dto.video,
            voteAverage = dto.voteAverage,
            voteCount = dto.voteCount
        )
        
        return favouriteMovieRepo.save(updatedEntity).toDto().toResponse()
    }

    fun deleteFavouriteMovie(ownerId: ObjectId, id: ObjectId): List<FavouriteMovieResponse> {
        favouriteMovieRepo.deleteByOwnerIdAndId(ownerId = ownerId, id = id)
        return favouriteMovieRepo.findByOwnerId(ownerId = ownerId).mapEntitiesListToResponseList()
    }

    fun deleteAllFavouriteMovies(ownerId: ObjectId): List<FavouriteMovieResponse> {

        favouriteMovieRepo.deleteAllByOwnerId(ownerId = ownerId)
        return favouriteMovieRepo.findByOwnerId(ownerId = ownerId).mapEntitiesListToResponseList()
    }

}