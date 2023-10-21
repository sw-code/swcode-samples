plugins {
	id("org.jetbrains.kotlin.jvm") version "1.9.0"
	id("org.springframework.boot") version "3.1.2"
	id("org.jetbrains.kotlin.plugin.spring") version "1.9.0"
	id("io.spring.dependency-management") version "1.1.2"
}

group = "io.swcode.authz"
version = "0.0.1-SNAPSHOT"

java {
	toolchain {
		languageVersion.set(JavaLanguageVersion.of(17))
	}
}

repositories {
	mavenCentral()
}

dependencies {
	implementation("org.springframework.boot:spring-boot-starter-oauth2-resource-server")
	implementation("org.springframework.boot:spring-boot-starter-web")
	implementation("com.fasterxml.jackson.module:jackson-module-kotlin")
	testImplementation("org.springframework.boot:spring-boot-starter-test")
}

tasks.withType<Test> {
	useJUnitPlatform()
}
