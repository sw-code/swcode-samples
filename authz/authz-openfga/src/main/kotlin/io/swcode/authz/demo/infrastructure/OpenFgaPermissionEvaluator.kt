package io.swcode.authz.demo.infrastructure

import org.springframework.security.access.PermissionEvaluator
import org.springframework.security.core.Authentication
import org.springframework.stereotype.Component
import java.io.Serializable

@Component
class OpenFgaPermissionEvaluator(private val openFGAClient: OpenFGAClient) : PermissionEvaluator {
    override fun hasPermission(authentication: Authentication, targetDomainObject: Any, permission: Any): Boolean {
        throw Exception("Permission check not supported without type")
    }

    override fun hasPermission(
        authentication: Authentication,
        targetId: Serializable,
        targetType: String,
        permission: Any
    ): Boolean {
        return openFGAClient.checkPermission(
            FGAType.valueOf(targetType.uppercase()),
            targetId as String,
            FGARelation.valueOf((permission as String).uppercase()),
            FGAType.USER,
            authentication.name
        )
    }
}