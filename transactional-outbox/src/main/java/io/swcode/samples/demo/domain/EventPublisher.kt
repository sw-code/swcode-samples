package io.swcode.samples.demo.domain

interface EventPublisher {
    fun publish(event: DomainEvent)
}