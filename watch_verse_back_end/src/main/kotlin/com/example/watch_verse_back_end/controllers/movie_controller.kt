package com.example.watch_verse_back_end.controllers

import com.example.watch_verse_back_end.request_models.FavouriteMovieRequest
import com.example.watch_verse_back_end.response_models.FavouriteMovieResponse
import com.example.watch_verse_back_end.services.FavouriteMovieService
import org.bson.types.ObjectId
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.web.bind.annotation.DeleteMapping
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.PutMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestHeader
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/favourites/movies")
class FavouriteMovieController(


    val favouriteMovieService: FavouriteMovieService
) {
    @GetMapping
    fun getFavouriteMovies(): List<FavouriteMovieResponse> {
        val ownerId = SecurityContextHolder.getContext().authentication.principal as String
        return favouriteMovieService.getFavouriteMovies(ownerId = ObjectId(ownerId))
    }

    @PostMapping
    fun addFavouriteMovie(
        @RequestBody requestBody: FavouriteMovieRequest
    ): FavouriteMovieResponse {
        val ownerId = SecurityContextHolder.getContext().authentication.principal as String
        return favouriteMovieService.addFavouriteMovie(requestBody = requestBody, ownerId = ObjectId(ownerId))
    }

    @PutMapping
    fun updateFavouriteMovie(
        @RequestBody requestBody: FavouriteMovieRequest
    ): FavouriteMovieResponse {
        val ownerId = SecurityContextHolder.getContext().authentication.principal as String
        return favouriteMovieService.updateFavouriteMovie(requestBody = requestBody, ownerId = ObjectId(ownerId))
    }

    @DeleteMapping("/{id}")
    fun deleteFavouriteMovie(@PathVariable id: String) {
        val ownerId = SecurityContextHolder.getContext().authentication.principal as String
        favouriteMovieService.deleteFavouriteMovie(id = ObjectId(id), ownerId = ObjectId(ownerId))
    }

    @DeleteMapping
    fun deleteAllFavouriteMovies() {
        val ownerId = SecurityContextHolder.getContext().authentication.principal as String
        favouriteMovieService.deleteAllFavouriteMovies(ownerId = ObjectId(ownerId))
    }
}