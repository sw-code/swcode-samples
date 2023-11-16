package io.swcode.samples.demo.infrastructure.rabbit

import com.fasterxml.jackson.databind.ObjectMapper
import io.swcode.samples.demo.application.FailingEvent
import io.swcode.samples.demo.domain.DomainEvent
import org.springframework.amqp.rabbit.core.RabbitTemplate
import org.springframework.stereotype.Component
import java.util.UUID
import java.util.concurrent.ConcurrentHashMap

@Component
class RabbitMqSender(private val rabbitTemplate: RabbitTemplate, private val objectMapper: ObjectMapper) {
    private val failedEvents: ConcurrentHashMap<UUID, FailingEvent> = ConcurrentHashMap<UUID, FailingEvent>()

    fun send(domainEvent: DomainEvent) {
        // emulate error during sending of the event to rabbit
        if (domainEvent is FailingEvent && !failedEvents.containsKey(domainEvent.id)) {
            failedEvents[domainEvent.id] = domainEvent
            throw Exception("failed to send event $domainEvent")
        }

        rabbitTemplate.convertAndSend(
            RabbitMqConfig.topicExchangeName,
            "foo.bar.#",
            objectMapper.writeValueAsString(domainEvent)
        )
    }
}