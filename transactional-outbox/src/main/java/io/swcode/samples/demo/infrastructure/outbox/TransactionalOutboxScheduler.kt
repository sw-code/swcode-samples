package io.swcode.samples.demo.infrastructure.outbox

import com.gruelbox.transactionoutbox.TransactionOutbox
import org.springframework.scheduling.annotation.Scheduled
import org.springframework.stereotype.Component

@Component
class TransactionalOutboxScheduler(private val transactionOutbox: TransactionOutbox) {

    @Scheduled(fixedDelay = 2000)
    fun run() {
        while (transactionOutbox.flush()) {
            // NOP
        }
    }
}