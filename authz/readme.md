# Sample Project: Scaling AuthZ

This project provides the implementations used in our blog, [blog.swcode.io](https://blog.swcode.io). It includes a Spring Boot project incorporating Spring Security and a Docker directory with preconfigured Keycloak and Postgres setups.

## Getting Started
To get the project up and running, you first need to start the services defined in the docker-compose.yml file. Navigate to the docker directory and execute the following command:

```bash
docker-compose up
```

This will start Keycloak and Postgres, and these will be ready to use with the Spring Boot application located in the app directory.

## Postman 

There is an export of a postman collection `AuthZ Samples.postman_collection.json` that may be used to make API calls against the service, with prepared authentication.

The pre-configured users:

| User  | Password | Roles |
|-------|----------|-------|
| fred  | fred     |       |
| admin | admin    | admin |
