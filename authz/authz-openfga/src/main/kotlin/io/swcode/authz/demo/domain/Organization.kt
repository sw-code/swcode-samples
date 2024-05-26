package io.swcode.authz.demo.domain

import jakarta.persistence.CascadeType
import jakarta.persistence.Column
import jakarta.persistence.Entity
import jakarta.persistence.Id
import jakarta.persistence.ManyToOne
import org.springframework.data.domain.AbstractAggregateRoot

@Entity
class Organization private constructor(
    @Id
    @Column(nullable = false)
    var id: String,
    @Column(nullable = false)
    var name: String,
    @ManyToOne(cascade = [CascadeType.REMOVE])
    var parent: Organization?
): AbstractAggregateRoot<Organization>() {
    companion object {
        fun of(id: String, name: String, parent: Organization?): Organization {
            return Organization(id, name, parent).also {
                it.registerEvent(OrganizationCreatedEvent(id, parent?.id))
            }
        }
    }
}