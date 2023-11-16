package io.swcode.samples.demo.application

import io.swcode.samples.demo.domain.DomainEvent
import io.swcode.samples.demo.domain.EventPublisher
import org.springframework.transaction.annotation.Transactional
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RestController
import java.util.UUID

@RestController
class FailingEventController(private val eventPublisher: EventPublisher) {
    @PostMapping("failing-events")
    @Transactional
    fun publishFailingEvent(): FailingEvent {
        return FailingEvent().also {
            eventPublisher.publish(it)
        }
    }
}

data class FailingEvent(val id: UUID = UUID.randomUUID()): DomainEvent