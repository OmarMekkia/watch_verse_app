package com.example.watch_verse_back_end.models

import org.bson.types.ObjectId
import java.time.Instant


data class FavouriteMovieDto(
    val id: ObjectId? = null,
    val ownerId: ObjectId,
    val adult: Boolean?,
    val backdropPath: String?,
    val genreIds: List<Int>?,
    val originalLanguage: String?,
    val originalTitle: String?,
    val overview: String?,
    val popularity: Double?,
    val posterPath: String?,
    val releaseDate: String?,
    val title: String?,
    val video: Boolean?,
    val voteAverage: Double?,
    val voteCount: Int?,
    val createdAt: Instant? = null,
    var updatedAt: Instant? = null,
)

