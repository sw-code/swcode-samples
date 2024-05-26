package io.swcode.authz.demo.infrastructure

import dev.openfga.sdk.api.client.ClientCheckRequest
import dev.openfga.sdk.api.client.ClientReadAuthorizationModelsResponse
import dev.openfga.sdk.api.client.ClientTupleKey
import dev.openfga.sdk.api.client.ClientWriteRequest
import dev.openfga.sdk.api.client.OpenFgaClient
import dev.openfga.sdk.api.configuration.ClientConfiguration
import dev.openfga.sdk.api.model.CreateStoreRequest
import org.slf4j.LoggerFactory
import org.springframework.stereotype.Component


@Component
class OpenFGAClient {
    companion object {
        val STORE_NAME = "demo"
    }

    val config = ClientConfiguration()
        .apiUrl("http://localhost:8080")

    val fgaClient by lazy { val client = OpenFgaClient(config)
        val storeId: String = client.listStores().get().stores?.firstOrNull { it.name == STORE_NAME }?.id
            ?: client.createStore(CreateStoreRequest().name(STORE_NAME)).get().id!!
        client.setStoreId(storeId)
        return@lazy client
    }

    fun getAuthorizationModels(): ClientReadAuthorizationModelsResponse {
        return fgaClient.readAuthorizationModels().get()
    }

    fun createRelation(type: FGAType,
                       objectId: String,
                       relation: FGARelation,
                       userType: FGAType,
                       userId: String) {
        val tuple = ClientTupleKey()
            ._object("${type.value}:$objectId")
            .relation(relation.value)
            .user("${userType.value}:$userId")
        fgaClient.write(ClientWriteRequest().writes(listOf(tuple))).get()
    }

    fun checkPermission(type: FGAType,
                        objectId: String,
                        relation: FGARelation,
                        userType: FGAType,
                        userId: String): Boolean {
        val request = ClientCheckRequest()
            ._object("${type.value}:$objectId")
            .relation(relation.value)
            .user("${userType.value}:$userId")

        return fgaClient.check(request).get().allowed ?: false
    }
}