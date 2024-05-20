package io.swcode.samples.vt

import com.zaxxer.hikari.HikariConfig
import com.zaxxer.hikari.HikariDataSource
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.asCoroutineDispatcher
import kotlinx.coroutines.async
import kotlinx.coroutines.delay
import kotlinx.coroutines.joinAll
import kotlinx.coroutines.runBlocking
import org.jetbrains.exposed.sql.Database
import org.jetbrains.exposed.sql.SchemaUtils
import org.jetbrains.exposed.sql.transactions.experimental.newSuspendedTransaction
import org.jetbrains.exposed.sql.transactions.transaction
import java.util.concurrent.Executors

val VIRTUAL_THREAD_DISPATCHER = Executors.newVirtualThreadPerTaskExecutor().asCoroutineDispatcher()

val config = HikariConfig().apply {
    jdbcUrl = "jdbc:h2:mem:sample;DB_CLOSE_DELAY=-1"
    schema = "PUBLIC"
}

val testDatabase = Database.connect( HikariDataSource(config))

fun main(args: Array<String>) {

    transaction(db = testDatabase) {
        SchemaUtils.create(FooTable)
    }

    // use either Dispatchers.IO to force deadlock, or VIRTUAL_THREAD_DISPATCHER to make it nob-blocking
    runRequests(VIRTUAL_THREAD_DISPATCHER)
}

fun runRequests(transactionDispatcher: CoroutineDispatcher) {
    val scope = CoroutineScope(SupervisorJob())

    val requests = 1000

    val jobs = (1..requests).map {
        scope.async(context = Dispatchers.Default) {
            makeDbRequest(transactionDispatcher, it)
        }
    }

    runBlocking {
        jobs.joinAll()
    }
}

private suspend fun makeDbRequest(dispatcher: CoroutineDispatcher, request: Int) {
    println("Start request execution $request")
    newSuspendedTransaction(dispatcher, testDatabase) {
        // FooEntity.count() will force grabbing of connection
        println("Entities count  ${FooEntity.count()}")

        // force suspension
        delay(1)
        println("Finishing transaction for $request")
    }
    println("Finished request execution $request")
}