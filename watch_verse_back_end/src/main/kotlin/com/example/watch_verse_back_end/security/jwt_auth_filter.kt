package com.example.watch_verse_back_end.security

import jakarta.servlet.FilterChain
import jakarta.servlet.http.HttpServletRequest
import jakarta.servlet.http.HttpServletResponse
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.stereotype.Component
import org.springframework.web.filter.OncePerRequestFilter

@Component
class JwtAuthFilter(
    private val jwtService: JwtService,
) : OncePerRequestFilter() {

    override fun doFilterInternal(
        request: HttpServletRequest,
        response: HttpServletResponse,
        filterChain: FilterChain
    ) {
        // Skip JWT processing for auth endpoints
        val requestPath = request.requestURI
        val isAuthEndpoint = requestPath.endsWith("/auth/signup") || 
                           requestPath.endsWith("/auth/login") || 
                           requestPath.endsWith("/auth/refresh") ||
                           requestPath.contains("/auth/")
        
        if (isAuthEndpoint) {
            filterChain.doFilter(request, response)
            return
        }

        val authHeader = request.getHeader("Authorization")
        if (authHeader != null && authHeader.startsWith("Bearer ")) {
            try {
                if (jwtService.validateAccessTokenType(authHeader)) {
                    val userId = jwtService.getUserIdFromToken(authHeader)
                    if (userId != null) {
                        val auth = UsernamePasswordAuthenticationToken(userId, null, emptyList())
                        SecurityContextHolder.getContext().authentication = auth
                        filterChain.doFilter(request, response)
                        return
                    } else {
                        // Invalid token - reject the request
                        response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Invalid token")
                        return
                    }
                } else {
                    // Invalid token type - reject the request
                    response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Invalid token type")
                    return
                }
            } catch (e: Exception) {
                // Token parsing failed - reject the request
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Token validation failed")
                return
            }
        } else {
            // No Authorization header for protected endpoint - reject the request
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Authorization header required")
            return
        }
    }
}
