package io.swcode.samples.demo.infrastructure.outbox

import com.gruelbox.transactionoutbox.TransactionOutbox
import io.swcode.samples.demo.domain.DomainEvent
import io.swcode.samples.demo.domain.EventPublisher
import io.swcode.samples.demo.infrastructure.rabbit.RabbitMqSender
import org.springframework.stereotype.Component

@Component
class OutboxPublisher(private val outbox: TransactionOutbox): EventPublisher {
    override fun publish(event: DomainEvent) {
        outbox.schedule(RabbitMqSender::class.java).send(event)
    }
}