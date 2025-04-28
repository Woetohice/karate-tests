FROM maven:3.8.6-openjdk-11-slim

WORKDIR /app

# Copy the pom.xml file
COPY pom.xml .

# Copy the source code
COPY src/ ./src/

# Build the project
RUN mvn clean package -DskipTests

# Set the entry point to run the tests
ENTRYPOINT ["mvn", "test"] 