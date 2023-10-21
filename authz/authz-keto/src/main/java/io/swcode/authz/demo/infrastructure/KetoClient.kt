package io.swcode.authz.demo.infrastructure

import com.fasterxml.jackson.annotation.JsonProperty
import org.springframework.beans.factory.annotation.Value
import org.springframework.stereotype.Component
import org.springframework.web.reactive.function.BodyInserters
import org.springframework.web.reactive.function.client.WebClient
import org.springframework.web.reactive.function.client.bodyToMono
import reactor.core.publisher.Mono


@Component
class KetoClient(
    @Value("\${keto.read-api-url}") ketoReadApiUrl: String,
    @Value("\${keto.write-api-url}") ketoWriteApiUrl: String
) {
    private val permissionCheckUrl = "relation-tuples/check/openapi"
    private val relationWritePath = "admin/relation-tuples"
    private val readClient = WebClient.create(ketoReadApiUrl)
    private val writeClient = WebClient.create(ketoWriteApiUrl)

    fun createRelationShip(
        namespace: KetoNamespace,
        objectId: String,
        relation: KetoRelation,
        subjectId: String
    ) {
        createRelationShip(RelationShipDto(namespace.value, objectId, relation.value, subjectId))
    }

    fun createRelationShip(
        namespace: KetoNamespace,
        objectId: String,
        relation: KetoRelation,
        subjectSetNamespace: KetoNamespace,
        subjectSetObjectId: String,
        subjectSetRelation: KetoRelation? = null
    ) {
        createRelationShip(
            RelationShipDto(
                namespace.value,
                objectId,
                relation.value,
                null,
                SubjectSetDto(subjectSetNamespace.value, subjectSetObjectId, subjectSetRelation?.value)
            )
        )
    }

    private fun createRelationShip(relationShipDto: RelationShipDto) {
        writeClient.put().uri {
            it.path(relationWritePath)
                .build()
        }.body(
            BodyInserters.fromPublisher(
                Mono.just(relationShipDto),
                RelationShipDto::class.java
            )
        ).retrieve()
            .bodyToMono<Unit>()
            .block()
    }

    fun checkPermission(subjectId: String, namespace: String, objectId: String, permission: String): Boolean {
        return readClient.get().uri {
            it.path(permissionCheckUrl)
                .queryParam("subject_id", subjectId)
                .queryParam("namespace", namespace)
                .queryParam("object", objectId)
                .queryParam("relation", permission)
                .build()
        }.retrieve()
            .bodyToMono(PermissionResponse::class.java)
            .block()!!.allowed
    }

    fun deleteRelations(subjectId: String?, namespace: String?, objectId: String?, relation: String?) {
        writeClient.delete().uri {
            it.path(relationWritePath).also { uriBuilder ->
                subjectId?.apply {
                    uriBuilder.queryParam("subject_id", this)
                }
                namespace?.apply {
                    uriBuilder.queryParam("namespace", this)
                }
                objectId?.apply {
                    uriBuilder.queryParam("object", this)
                }
                relation?.apply {
                    uriBuilder.queryParam("relation", relation)
                }
            }.build()

        }.retrieve()
            .bodyToMono(Unit::class.java)
            .block()
    }
}

private data class PermissionResponse(val allowed: Boolean)

data class RelationShipDto(
    val namespace: String,
    val `object`: String,
    val relation: String,
    @JsonProperty("subject_id")
    val subjectId: String? = null,
    @JsonProperty("subject_set")
    val subjectSet: SubjectSetDto? = null
)

data class SubjectSetDto(val namespace: String, val `object`: String, val relation: String? = null)