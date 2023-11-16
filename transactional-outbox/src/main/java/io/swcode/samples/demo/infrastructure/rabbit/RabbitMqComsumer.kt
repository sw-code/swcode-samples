package io.swcode.samples.demo.infrastructure.rabbit

import org.slf4j.LoggerFactory
import org.springframework.stereotype.Component

@Component
class RabbitMqComsumer {

    companion object {
        val log = LoggerFactory.getLogger(RabbitMqComsumer::class.java)
    }

    fun consume(event: String) {
        log.info("Consuming event: $event")
    }
}