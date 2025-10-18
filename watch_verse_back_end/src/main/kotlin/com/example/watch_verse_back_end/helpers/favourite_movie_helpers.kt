package com.example.watch_verse_back_end.helpers

import com.example.watch_verse_back_end.entities.FavouriteMovieEntity
import com.example.watch_verse_back_end.mappers.toDto
import com.example.watch_verse_back_end.mappers.toResponse

fun List<FavouriteMovieEntity>.mapEntitiesListToResponseList() =
    this.map{ favouriteMovieEntity -> favouriteMovieEntity.toDto().toResponse() }