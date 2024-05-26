package io.swcode.authz.demo

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.data.jpa.repository.config.EnableJpaRepositories

@SpringBootApplication
@EnableJpaRepositories
class AccountServiceApplication

fun main(args: Array<String>) {

    runApplication<AccountServiceApplication>(*args)
}
