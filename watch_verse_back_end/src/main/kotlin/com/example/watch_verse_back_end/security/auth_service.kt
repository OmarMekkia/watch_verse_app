package com.example.watch_verse_back_end.security

import com.example.watch_verse_back_end.entities.RefreshTokenEntity
import com.example.watch_verse_back_end.mappers.toDto
import com.example.watch_verse_back_end.mappers.toEntity
import com.example.watch_verse_back_end.mappers.toResponse
import com.example.watch_verse_back_end.models.UserDto
import com.example.watch_verse_back_end.repos.RefreshTokenRepo
import com.example.watch_verse_back_end.repos.UserRepo
import com.example.watch_verse_back_end.response_models.UserResponse
import org.bson.types.ObjectId
import org.springframework.security.authentication.BadCredentialsException
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.time.Instant
import java.time.temporal.ChronoUnit

@Service
class AuthService(
    private val jwtService: JwtService,
    private val userRepo: UserRepo,
    private val refreshTokenRepo: RefreshTokenRepo,
    private val hashEncoder: HashEncoder,
) {

    data class TokenPair(
        val accessToken: String,
        val refreshToken: String,
    )

    @Transactional
    fun refresh(refreshToken: String): TokenPair {

        // validating the token type
        if (!jwtService.validateRefreshTokenType(refreshToken)) {
            throw IllegalArgumentException("Refresh token invalid.")
        }

        // validating the user existence with the token
        val userId = jwtService.getUserIdFromToken(refreshToken)
        val userIdObject = ObjectId(userId)
        userRepo.findById(userIdObject).orElseThrow { IllegalArgumentException("Refresh token Invalid.") }

        // validating the refresh token existence
        val hashed = hashEncoder.digestHash(refreshToken)
        refreshTokenRepo.findByUserIdAndHashedToken(userId = userIdObject, hashedToken = hashed)
            .orElseThrow { IllegalArgumentException("Refresh token is not recognized (may be used or expired).") }

        // deleting the old token
        refreshTokenRepo.deleteByUserIdAndHashedToken(userIdObject, hashed)

        // generating new tokens and storing the refresh token in the database
        val newAccessToken = jwtService.generateAccessToken(userId!!)
        val newRefreshToken = jwtService.generateRefreshToken(userId = userId!!)
        storeRefreshToken(userIdObject, newRefreshToken)

        return TokenPair(
            accessToken = newAccessToken,
            refreshToken = newRefreshToken
        )
    }

    fun signUp(username: String, email: String, password: String): UserResponse {
        // Check if user already exists
        userRepo.findByEmail(email)?.let {
            throw IllegalArgumentException("User with email $email already exists")
        }
        userRepo.findByUsername(username)?.let {
            throw IllegalArgumentException("User with username $username already exists")
        }

        val userDto = UserDto(
            username = username,
            email = email,
            hashedPassword = hashEncoder.encode(password)
        )
        val savedEntity = userRepo.save(userDto.toEntity())
        return savedEntity.toDto().toResponse()
    }

    fun login(email: String, password: String): TokenPair {
        val user = userRepo.findByEmail(email) ?: throw BadCredentialsException("Invalid Credentials")
        if (!hashEncoder.matches(password, user.hashedPassword)) {
            throw BadCredentialsException("Invalid Credentials")
        }
        val newAccessToken = jwtService.generateAccessToken(user.id!!.toHexString())
        val newRefreshToken = jwtService.generateRefreshToken(user.id.toHexString())
        storeRefreshToken(userId = user.id, rawRefreshToken = newRefreshToken)
        return TokenPair(
            accessToken = newAccessToken,
            refreshToken = newRefreshToken
        )
    }

    fun storeRefreshToken(userId: ObjectId, rawRefreshToken: String) {
        val hashed = hashEncoder.digestHash(rawRefreshToken)
        val expiredMs = jwtService.refreshTokenValidityMs
        val expiresAtMs = Instant.now().plus(expiredMs, ChronoUnit.MILLIS)
        refreshTokenRepo.save(
            RefreshTokenEntity(
                userId = userId,
                hashedToken = hashed,
                expires_at = expiresAtMs,
            )
        )
    }
}