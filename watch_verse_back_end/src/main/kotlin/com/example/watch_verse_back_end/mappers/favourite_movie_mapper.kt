package com.example.watch_verse_back_end.mappers

import com.example.watch_verse_back_end.entities.FavouriteMovieEntity
import com.example.watch_verse_back_end.models.FavouriteMovieDto
import com.example.watch_verse_back_end.request_models.FavouriteMovieRequest
import com.example.watch_verse_back_end.response_models.FavouriteMovieResponse
import org.bson.types.ObjectId
import java.time.Instant


fun FavouriteMovieRequest.toDto(ownerId: ObjectId): FavouriteMovieDto = FavouriteMovieDto(
    id = if (this.id != null && ObjectId.isValid(this.id)) ObjectId(this.id) else null,
    ownerId = ownerId,
    title = this.title,
    adult = this.adult,
    backdropPath = this.backdropPath,
    popularity = this.popularity,
    voteAverage = this.voteAverage,
    voteCount = this.voteCount,
    posterPath = this.posterPath,
    originalTitle = this.originalTitle,
    releaseDate = this.releaseDate,
    overview = this.overview,
    video = this.video,
    genreIds = this.genreIds,
    originalLanguage = this.originalLanguage,
    createdAt = null,
    updatedAt = null,
)

fun FavouriteMovieDto.toEntity(): FavouriteMovieEntity = FavouriteMovieEntity(
    id = this.id,
    ownerId = this.ownerId,
    title = this.title,
    adult = this.adult,
    backdropPath = this.backdropPath,
    popularity = this.popularity,
    voteAverage = this.voteAverage,
    voteCount = this.voteCount,
    posterPath = this.posterPath,
    originalTitle = this.originalTitle,
    releaseDate = this.releaseDate,
    overview = this.overview,
    video = this.video,
    genreIds = this.genreIds,
    originalLanguage = this.originalLanguage,
    createdAt = this.createdAt,
    updatedAt = this.updatedAt
)

fun FavouriteMovieEntity.toDto(): FavouriteMovieDto = FavouriteMovieDto(
    id = this.id,
    ownerId = this.ownerId,
    title = this.title,
    adult = this.adult,
    backdropPath = this.backdropPath,
    popularity = this.popularity,
    voteAverage = this.voteAverage,
    voteCount = this.voteCount,
    posterPath = this.posterPath,
    originalTitle = this.originalTitle,
    releaseDate = this.releaseDate,
    overview = this.overview,
    video = this.video,
    genreIds = this.genreIds,
    originalLanguage = this.originalLanguage,
    createdAt = this.createdAt,
    updatedAt = this.updatedAt,

)

fun FavouriteMovieDto.toResponse(): FavouriteMovieResponse = FavouriteMovieResponse(

    id = this.id?.toHexString() ?: "",
    title = this.title,
    adult = this.adult,
    backdropPath = this.backdropPath,
    popularity = this.popularity,
    voteAverage = this.voteAverage,
    voteCount = this.voteCount,
    posterPath = this.posterPath,
    originalTitle = this.originalTitle,
    releaseDate = this.releaseDate,
    overview = this.overview,
    video = this.video,
    genreIds = this.genreIds,
    originalLanguage = this.originalLanguage,
    createdAt = this.createdAt ?: Instant.EPOCH,
    updatedAt = this.updatedAt ?: Instant.EPOCH
)
