# Karate Docker Project

This project demonstrates how to run Karate tests in a Docker container.

## Prerequisites

- Docker installed on your machine
- Maven (optional, for local development)

## Running Tests

### Using Docker

1. Build the Docker image:
```bash
docker build -t karate-tests .
```

2. Run the tests:
```bash
docker run karate-tests
```

### Local Development

1. Run tests locally:
```bash
mvn test
```

## Project Structure

- `src/test/java/examples/` - Contains test runners and feature files
- `pom.xml` - Maven configuration with Karate dependencies
- `Dockerfile` - Docker configuration for running tests in a container
- `target/karate-reports` - karate reports output
## Features
- .env sample for secrets storage
- run tests script
- Dockerized test environment
