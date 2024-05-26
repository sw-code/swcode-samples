package io.swcode.authz.demo.infrastructure

import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.core.convert.converter.Converter
import org.springframework.security.access.expression.method.DefaultMethodSecurityExpressionHandler
import org.springframework.security.access.expression.method.MethodSecurityExpressionHandler
import org.springframework.security.authentication.AbstractAuthenticationToken
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity
import org.springframework.security.config.annotation.web.builders.HttpSecurity
import org.springframework.security.core.GrantedAuthority
import org.springframework.security.core.authority.SimpleGrantedAuthority
import org.springframework.security.oauth2.jwt.Jwt
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken
import org.springframework.security.web.SecurityFilterChain


@Configuration
@EnableMethodSecurity(prePostEnabled = true, jsr250Enabled = true)
class SecurityConfiguration {

    @Bean
    fun securityFilterChain(httpSecurity: HttpSecurity): SecurityFilterChain {
        return httpSecurity.authorizeHttpRequests { auth ->
            auth.requestMatchers("/hello").permitAll()
            auth.anyRequest().authenticated()
        }.oauth2ResourceServer { configurer ->
            configurer.jwt {
                it.jwtAuthenticationConverter(KeycloakTokenConverter())
            }
        }.build()
    }

    @Bean
    fun expressionHandler(ketoPermissionEvaluator: OpenFgaPermissionEvaluator): MethodSecurityExpressionHandler {
        val expressionHandler = DefaultMethodSecurityExpressionHandler()
        expressionHandler.setPermissionEvaluator(ketoPermissionEvaluator)
        return expressionHandler
    }

//    @Bean
//    @Role(BeanDefinition.ROLE_INFRASTRUCTURE)
//    fun preAuthorizeAuthorizationMethodInterceptor(ketoPermissionEvaluator: KetoPermissionEvaluator): Advisor {
//        val expressionHandler = DefaultMethodSecurityExpressionHandler()
//        expressionHandler.setPermissionEvaluator(ketoPermissionEvaluator)
//        val authorizationManager = PreAuthorizeAuthorizationManager()
//        authorizationManager.setExpressionHandler(expressionHandler)
//        return AuthorizationManagerBeforeMethodInterceptor.preAuthorize(authorizationManager)
//    }

//    @Bean
//    fun preAuthorizeAuthorizationMethodInterceptor(ketoPermissionEvaluator: KetoPermissionEvaluator): Advisor {
//        val expressionHandler = DefaultMethodSecurityExpressionHandler()
//        expressionHandler.setPermissionEvaluator(ketoPermissionEvaluator)
//        val authorizationManager = PreAuthorizeAuthorizationManager()
//        authorizationManager.setExpressionHandler(expressionHandler)
//        return AuthorizationManagerBeforeMethodInterceptor.preAuthorize(authorizationManager)
//    }
}

private class KeycloakTokenConverter : Converter<Jwt, AbstractAuthenticationToken> {
    override fun convert(source: Jwt): AbstractAuthenticationToken {
        return KeycloakAuthenticationToken(source)
    }
}

private class KeycloakAuthenticationToken(jwt: Jwt) : JwtAuthenticationToken(jwt, extractAuthorities(jwt), getUserName(jwt)) {
    companion object {
        private const val CLAIM_USER_NAME = "preferred_username"
        private const val CLAIM_REALM_ACCESS = "realm_access"
        private const val CLAIM_ROLES = "roles"

        private fun getRealmRoles(jwt: Jwt): Collection<String> {
            val claimRealmAccess = jwt.getClaimAsMap(CLAIM_REALM_ACCESS)
                ?: return emptyList()
            return getRoles(claimRealmAccess)
        }

        private fun getRoles(claim: Map<*, *>): Collection<String> {
            val rolesArray = claim[CLAIM_ROLES]
            if (rolesArray !is List<*>) return emptyList()

            return rolesArray.mapNotNull { it.toString() }
        }

        private fun extractAuthorities(jwt: Jwt): Collection<GrantedAuthority> {
            return getRealmRoles(jwt).map { role -> SimpleGrantedAuthority("ROLE_$role") }
        }

        private fun getUserName(jwt: Jwt): String? = jwt.getClaimAsString(CLAIM_USER_NAME)
    }
}




