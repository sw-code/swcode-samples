package io.swcode.samples.vt

import org.jetbrains.exposed.dao.LongEntity
import org.jetbrains.exposed.dao.LongEntityClass
import org.jetbrains.exposed.dao.id.EntityID
import org.jetbrains.exposed.dao.id.LongIdTable

object FooTable : LongIdTable() {
    val name = text("name")
}

class FooEntity(id: EntityID<Long>) : LongEntity(id) {
    var name by FooTable.name

    companion object : LongEntityClass<FooEntity>(FooTable)
}