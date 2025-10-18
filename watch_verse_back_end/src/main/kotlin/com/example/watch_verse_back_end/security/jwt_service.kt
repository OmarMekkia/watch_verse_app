package com.example.watch_verse_back_end.security

import com.example.watch_verse_back_end.enums.JwtType
import io.jsonwebtoken.Claims
import io.jsonwebtoken.Jwts
import io.jsonwebtoken.SignatureAlgorithm
import io.jsonwebtoken.security.Keys
import org.springframework.beans.factory.annotation.Value
import org.springframework.stereotype.Service
import java.util.Base64
import java.util.Date


@Service
class JwtService(
    @Value("\${JWT_SECRET_KEY_BASE64}") val jwtSecret: String
) {

    private val secretKey = Keys.hmacShaKeyFor(Base64.getDecoder().decode(jwtSecret))
    private val accessTokenValidityMs = 15L * 60 * 1000
    val refreshTokenValidityMs = 30L * 24 * 60 * 60 * 1000


    private fun generateToken(userId: String, type: String, expiry: Long): String {
        val now: Date = Date()
        val expiryDate: Date = Date(now.time + expiry)
        return Jwts.builder()
            .setSubject(userId)
            .claim("type", type)
            .setIssuedAt(now)
            .setExpiration(expiryDate)
            .signWith(secretKey, SignatureAlgorithm.HS256)
            .compact()
    }

    fun generateAccessToken(userId: String): String {
        return generateToken(userId = userId, type = "access", expiry = accessTokenValidityMs)
    }

    fun generateRefreshToken(userId: String): String {
        return generateToken(userId = userId, type = "refresh", expiry = refreshTokenValidityMs)
    }

    fun parseAllClaims(token: String): Claims? {
        val rawToken = if (token.contains("Bearer ")) {
            token.removePrefix("Bearer ")
        } else token
        return try {
            Jwts.parserBuilder()
                .setSigningKey(secretKey)
                .build()
                .parseClaimsJws(rawToken)
                .body

        } catch (ex: Exception) {
            null
        }
    }

    fun validateAccessTokenType(token: String): Boolean {
        val claims = parseAllClaims(token) ?: return false
        val tokenType = claims["type"] as? String ?: return false
        return tokenType == JwtType.ACCESS.value
    }

    fun validateRefreshTokenType(token: String): Boolean {
        val claims = parseAllClaims(token) ?: return false
        val tokenType = claims["type"] as? String ?: return false
        return tokenType == JwtType.REFRESH.value
    }

    fun getUserIdFromToken(token: String): String? {
        val claims = parseAllClaims(token) ?: return null
        return claims.subject
    }


}