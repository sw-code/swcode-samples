package io.swcode.authz.demo.application

import io.swcode.authz.demo.application.dto.Pet
import org.springframework.security.access.prepost.PreAuthorize
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class PetsController {
    @GetMapping("/pets")
    fun getPets(): List<Pet> {
        return listOf(Pet("dog"))
    }

    @GetMapping("/pets2")
    @PreAuthorize("hasAnyRole('admin')")
    fun getPets2(): List<Pet> {
        return listOf(Pet("dog"))
    }
}