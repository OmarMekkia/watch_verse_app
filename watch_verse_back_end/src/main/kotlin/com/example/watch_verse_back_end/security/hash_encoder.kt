package com.example.watch_verse_back_end.security

import org.bson.types.ObjectId
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder
import org.springframework.stereotype.Component
import java.security.MessageDigest
import java.util.Base64

@Component
class HashEncoder {
    private val bCryptPasswordEncoder = BCryptPasswordEncoder()


    fun encode(raw: String): String = bCryptPasswordEncoder.encode(raw)


    fun matches(raw: String, hashedPassword: String): Boolean =
        bCryptPasswordEncoder.matches(raw, hashedPassword)

    fun digestHash(hashedPassword: String): String {
        val digestObject = MessageDigest.getInstance("SHA-256")
        val hashBytes = digestObject.digest(hashedPassword.encodeToByteArray())
        return Base64.getEncoder().encodeToString(hashBytes)

    }

}