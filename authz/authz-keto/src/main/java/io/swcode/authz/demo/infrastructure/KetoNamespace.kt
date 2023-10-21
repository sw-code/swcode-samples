package io.swcode.authz.demo.infrastructure

enum class KetoNamespace(val value: String) {
    ORGANIZATION("Organization");
}

enum class KetoRelation(val value: String) {
    PARENTS("parents"),
    OWNERS("owners"),
    VIEWERS("viewers"),
    EDITORS("editors")
}