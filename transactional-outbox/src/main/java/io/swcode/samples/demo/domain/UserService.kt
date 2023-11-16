package io.swcode.samples.demo.domain

import org.springframework.stereotype.Component
import org.springframework.transaction.annotation.Transactional
import java.util.UUID

@Component
@Transactional
class UserService(private val userRepository: UserRepository, private val eventPublisher: EventPublisher) {

    fun findAll(): List<User> = userRepository.findAll()

    fun createUser(name: String): User {
        return userRepository.save(User(UUID.randomUUID(), name)).also {
            eventPublisher.publish(UserCreatedEvent(it.id, it.name))
        }
    }
}