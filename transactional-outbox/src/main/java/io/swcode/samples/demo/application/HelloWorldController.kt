package io.swcode.samples.demo.application

import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class HelloWorldController {
    @RequestMapping("/hello")
    fun getHello(): String {
        return "Hello!"
    }
}