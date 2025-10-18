package com.example.watch_verse_back_end.response_models

import java.time.Instant

data class FavouriteMovieResponse(
    val id: String,
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
    val createdAt: Instant,
    var updatedAt: Instant,
)