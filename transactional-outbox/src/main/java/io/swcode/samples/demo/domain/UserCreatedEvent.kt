package io.swcode.samples.demo.domain

import java.util.UUID

data class UserCreatedEvent(val id: UUID, val name: String): DomainEvent