package io.swcode.authz.demo.application

import io.swcode.authz.demo.application.dto.OrganizationDto
import io.swcode.authz.demo.application.dto.OrganizationUpdateDto
import io.swcode.authz.demo.domain.Organization
import io.swcode.authz.demo.domain.OrganizationRepository
import org.springframework.http.ResponseEntity
import org.springframework.security.access.prepost.PreAuthorize
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.PutMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RestController

@RestController
class OrganizationController(private val organizationRepository: OrganizationRepository) {
    @GetMapping("/organizations")
    fun getOrganization(): ResponseEntity<List<OrganizationDto>> {
        return ResponseEntity.ok(organizationRepository.findAll().map { OrganizationDto.fromEntity(it) })
    }

    @PostMapping("/organizations")
    fun createOrganization(@RequestBody request: OrganizationDto): ResponseEntity<OrganizationDto> {
        return organizationRepository.save(Organization.of(request.id, request.name, request.parentId?.let {
            organizationRepository.getReferenceById(it)
        })).let {
            ResponseEntity.ok(OrganizationDto.fromEntity(it))
        }
    }

    @GetMapping("/organizations/{organizationId}")
    @PreAuthorize("hasPermission(#organizationId, 'Organization', 'view')")
    fun getOrganization(@PathVariable organizationId: String): ResponseEntity<OrganizationDto> {
        return organizationRepository.findById(organizationId).map { ResponseEntity.ok(OrganizationDto.fromEntity(it)) }
            .orElseGet { ResponseEntity.notFound().build() }
    }

    @PutMapping("/organizations/{organizationId}")
    @PreAuthorize("hasPermission(#organizationId, 'Organization', 'edit')")
    fun updateOrganization(
        @PathVariable organizationId: String,
        @RequestBody request: OrganizationUpdateDto
    ): ResponseEntity<OrganizationDto> {
        return organizationRepository.findById(organizationId).map { organization ->
            organization.name = request.name
            organizationRepository.save(organization)
        }.map {
            ResponseEntity.ok(OrganizationDto.fromEntity(it))
        }.orElseGet { ResponseEntity.notFound().build() }
    }
}