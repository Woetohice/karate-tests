FROM maven:3.8.6-openjdk-11-slim

WORKDIR /app

# Copy the pom.xml file
COPY pom.xml .

# Copy the source code
COPY src/ ./src/

# Create target directory for reports
RUN mkdir -p target/karate-reports

# Build the project
RUN mvn clean package -DskipTests

# Set environment variable for Karate reports
ENV KARATE_REPORT_DIR=/app/target/karate-reports

# Set the entry point to run the tests with report configuration
ENTRYPOINT ["mvn", "test", "-Dkarate.options=--output=/app/target/karate-reports"] 