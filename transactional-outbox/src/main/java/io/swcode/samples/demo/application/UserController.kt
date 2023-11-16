package io.swcode.samples.demo.application

import io.swcode.samples.demo.domain.User
import io.swcode.samples.demo.domain.UserService
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RestController

@RestController
class UserController(private val userService: UserService) {

    @GetMapping("/users")
    fun getUsers(): List<User> {
        return userService.findAll()
    }

    @PostMapping("/users")
    fun createUser(@RequestBody request: UserCreateRequestDto): User {
        return userService.createUser(request.name)
    }
}

data class UserCreateRequestDto(val name: String)