package io.swcode.authz.demo.application

import io.swcode.authz.demo.application.dto.Pet
import org.springframework.security.access.prepost.PreAuthorize
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class PetsController {
    private val pets = mutableListOf(Pet("dog"))

    @GetMapping("/pets")
    fun getPets(): List<Pet> {
        return pets
    }

    @PostMapping("/pets")
    @PreAuthorize("hasAnyRole('admin')")
    fun addPet(pet: Pet): Pet {
        pets.add(pet)
        return pet
    }
}