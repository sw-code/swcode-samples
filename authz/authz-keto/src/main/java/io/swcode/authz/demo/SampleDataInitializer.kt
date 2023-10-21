package io.swcode.authz.demo

import io.swcode.authz.demo.domain.Organization
import io.swcode.authz.demo.domain.OrganizationRepository
import io.swcode.authz.demo.infrastructure.KetoClient
import io.swcode.authz.demo.infrastructure.KetoNamespace
import io.swcode.authz.demo.infrastructure.KetoRelation
import org.springframework.boot.context.event.ApplicationReadyEvent
import org.springframework.context.event.EventListener
import org.springframework.stereotype.Component
import org.springframework.transaction.annotation.Transactional

@Component
@Transactional
class SampleDataInitializer(
    private val organizationRepository: OrganizationRepository,
    val ketoClient: KetoClient
) {
    @EventListener(ApplicationReadyEvent::class)
    fun onApplicationReady() {
        if (organizationRepository.count() == 0L) {
            KetoNamespace.entries.forEach {
                ketoClient.deleteRelations(null, it.value, null, null)
            }

            val globalCorp = organizationRepository.save(Organization.of("1", "GlobalCorp", null))
            organizationRepository.save(Organization.of("2", "TechNovelties ", globalCorp))
            val ecoLife = organizationRepository.save(Organization.of("3", "EcoLife ", globalCorp))
            organizationRepository.save(Organization.of("4", "GreenLife ", ecoLife))

            // admin is owner of GlobalCrop and has full access
            ketoClient.createRelationShip(KetoNamespace.ORGANIZATION, globalCorp.id, KetoRelation.OWNERS, "admin")

            // jane can view GlobalCorp its sub resources
            ketoClient.createRelationShip(KetoNamespace.ORGANIZATION, globalCorp.id, KetoRelation.VIEWERS, "jane")
            // jane can edit EcoLife and its sub resources
            ketoClient.createRelationShip(KetoNamespace.ORGANIZATION, ecoLife.id, KetoRelation.EDITORS, "jane")
        }
    }
}