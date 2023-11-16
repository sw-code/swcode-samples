package io.swcode.samples.demo.infrastructure.outbox

import com.fasterxml.jackson.databind.ObjectMapper
import com.gruelbox.transactionoutbox.DefaultPersistor
import com.gruelbox.transactionoutbox.Dialect
import com.gruelbox.transactionoutbox.Persistor
import com.gruelbox.transactionoutbox.SpringInstantiator
import com.gruelbox.transactionoutbox.SpringTransactionManager
import com.gruelbox.transactionoutbox.SpringTransactionOutboxConfiguration
import com.gruelbox.transactionoutbox.TransactionOutbox
import com.gruelbox.transactionoutbox.jackson.JacksonInvocationSerializer
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.context.annotation.Import
import java.time.Duration

@Configuration
@Import(SpringTransactionOutboxConfiguration::class)
class TransactionalOutboxConfig {

    @Bean
    fun outbox(
        springTransactionManager: SpringTransactionManager,
        springInstantiator: SpringInstantiator,
        objectMapper: ObjectMapper
    ): TransactionOutbox {
        return TransactionOutbox.builder()
            .instantiator(springInstantiator)
            .transactionManager(springTransactionManager)
            .attemptFrequency(Duration.ofSeconds(10))
            .persistor(
                DefaultPersistor.builder()
                    .migrate(false)
                    .dialect(Dialect.POSTGRESQL_9)
                    .serializer(
                        JacksonInvocationSerializer.builder()
                            .mapper(objectMapper)
                            .build()
                    ).build()
            ).build()
    }
}