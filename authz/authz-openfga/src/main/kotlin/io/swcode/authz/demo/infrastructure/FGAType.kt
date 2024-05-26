package io.swcode.authz.demo.infrastructure

enum class FGAType(val value: String) {
    ORGANIZATION("organization"),
    USER("user"),
}

enum class FGARelation(val value: String) {
    PARENTS("parent"),
    OWNERS("owner"),
    VIEWERS("viewer"),
    EDITORS("editor"),
    CAN_VIEW("can_view"),
    CAN_EDIT("can_edit")
}