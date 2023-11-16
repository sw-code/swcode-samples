plugins {
	id("org.jetbrains.kotlin.jvm") version "1.9.0"
	id("org.springframework.boot") version "3.1.5"
	id("org.jetbrains.kotlin.plugin.spring") version "1.9.0"
	id("org.jetbrains.kotlin.plugin.jpa") version "1.9.0"
	id("io.spring.dependency-management") version "1.1.2"
}

group = "io.swcode.samples.outbox"
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
	implementation("org.springframework.boot:spring-boot-starter-web")
	implementation("org.springframework.boot:spring-boot-starter-data-jpa")
	implementation("org.springframework.boot:spring-boot-starter-amqp")
	implementation("com.gruelbox:transactionoutbox-spring:5.3.370")
	implementation("com.gruelbox:transactionoutbox-jackson:5.3.370")
	implementation("org.postgresql:postgresql")

	implementation("com.fasterxml.jackson.module:jackson-module-kotlin")
	testImplementation("org.springframework.boot:spring-boot-starter-test")
}

tasks.withType<Test> {
	useJUnitPlatform()
}
