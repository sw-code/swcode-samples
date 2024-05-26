package io.swcode.authz.demo.domain

import io.swcode.authz.demo.infrastructure.FGAType
import io.swcode.authz.demo.infrastructure.FGARelation
import io.swcode.authz.demo.infrastructure.OpenFGAClient
import org.springframework.context.event.EventListener
import org.springframework.stereotype.Component

@Component
class OrganizationEventListener(val openFGAClient: OpenFGAClient) {

    @EventListener
    fun onOrganizationCreatedEvent(event: OrganizationCreatedEvent) {
        event.parentId?.also { parentOrganizationId ->
            openFGAClient.createRelation(
                FGAType.ORGANIZATION, event.id, FGARelation.PARENTS, FGAType.ORGANIZATION, parentOrganizationId
            )
        }
    }
}