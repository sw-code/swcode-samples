package io.swcode.authz.demo.infrastructure

import org.springframework.security.access.PermissionEvaluator
import org.springframework.security.core.Authentication
import org.springframework.stereotype.Component
import java.io.Serializable

@Component
class KetoPermissionEvaluator(private val ketoKetoClient: KetoClient) : PermissionEvaluator {
    override fun hasPermission(authentication: Authentication, targetDomainObject: Any, permission: Any): Boolean {
        throw Exception("Permission check not supported without namespace")
    }

    override fun hasPermission(
        authentication: Authentication,
        targetId: Serializable,
        targetType: String,
        permission: Any
    ): Boolean {
        return ketoKetoClient.checkPermission(authentication.name, targetType, targetId as String, permission as String)
    }
}