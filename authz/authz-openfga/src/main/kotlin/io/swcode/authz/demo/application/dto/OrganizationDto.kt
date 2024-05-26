package io.swcode.authz.demo.application.dto

import io.swcode.authz.demo.domain.Organization

data class OrganizationDto(val id: String, val name: String, val parentId: String?) {
    companion object {
        fun fromEntity(organization: Organization): OrganizationDto {
            return OrganizationDto(organization.id, organization.name, organization.parent?.id)
        }
    }
}

data class OrganizationUpdateDto(val name: String)