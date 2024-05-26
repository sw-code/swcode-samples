package io.swcode.authz.demo

import io.swcode.authz.demo.domain.Organization
import io.swcode.authz.demo.domain.OrganizationRepository
import io.swcode.authz.demo.infrastructure.FGARelation
import io.swcode.authz.demo.infrastructure.FGAType
import io.swcode.authz.demo.infrastructure.OpenFGAClient
import org.springframework.boot.context.event.ApplicationReadyEvent
import org.springframework.context.event.EventListener
import org.springframework.stereotype.Component
import org.springframework.transaction.annotation.Transactional

@Component
@Transactional
class SampleDataInitializer(
    private val organizationRepository: OrganizationRepository,
    val openFgaClient: OpenFGAClient
) {
    @EventListener(ApplicationReadyEvent::class)
    fun onApplicationReady() {
        if (organizationRepository.count() == 0L) {

            val globalCorp = organizationRepository.save(Organization.of("1", "GlobalCorp", null))
            organizationRepository.save(Organization.of("2", "TechNovelties ", globalCorp))
            val ecoLife = organizationRepository.save(Organization.of("3", "EcoLife ", globalCorp))
            organizationRepository.save(Organization.of("4", "GreenLife ", ecoLife))

            // admin is owner of GlobalCrop and has full access
            openFgaClient.createRelation(FGAType.ORGANIZATION, globalCorp.id, FGARelation.OWNERS, FGAType.USER, "admin")

            // jane can view GlobalCorp its sub resources
            openFgaClient.createRelation(FGAType.ORGANIZATION, globalCorp.id, FGARelation.VIEWERS, FGAType.USER,"jane")
            // jane can edit EcoLife and its sub resources
            openFgaClient.createRelation(FGAType.ORGANIZATION, ecoLife.id, FGARelation.EDITORS, FGAType.USER, "jane")
        }
    }
}