package com.example.watch_verse_back_end.mappers

import com.example.watch_verse_back_end.entities.UserEntity
import com.example.watch_verse_back_end.models.UserDto
import com.example.watch_verse_back_end.response_models.UserResponse
import java.time.Instant


fun UserDto.toEntity(): UserEntity = UserEntity(
    id = this.id,
    username = this.username,
    email = this.email,
    hashedPassword = this.hashedPassword,
    createdAt = this.createdAt,
    updatedAt = this.updatedAt
)

fun UserEntity.toDto(): UserDto = UserDto(
    id = this.id,
    username = this.username,
    email = this.email,
    hashedPassword = this.hashedPassword,
    createdAt = this.createdAt,
    updatedAt = this.updatedAt,
)

fun UserDto.toResponse(): UserResponse = UserResponse(
    id = this.id?.toHexString() ?: "",
    username = this.username,
    email = this.email,
    createdAt = this.createdAt ?: Instant.EPOCH,
    updatedAt = this.updatedAt ?: Instant.EPOCH,


    )