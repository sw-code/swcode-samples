package io.swcode.authz.demo.domain

import io.swcode.authz.demo.infrastructure.KetoClient
import io.swcode.authz.demo.infrastructure.KetoNamespace
import io.swcode.authz.demo.infrastructure.KetoRelation
import org.springframework.context.event.EventListener
import org.springframework.stereotype.Component

@Component
class OrganizationEventListener(val ketoClient: KetoClient) {

    @EventListener
    fun onOrganizationCreatedEvent(event: OrganizationCreatedEvent) {
        event.parentId?.also { parentOrganizationId ->
            ketoClient.createRelationShip(
                KetoNamespace.ORGANIZATION, event.id, KetoRelation.PARENTS, KetoNamespace.ORGANIZATION, parentOrganizationId
            )
        }
    }
}