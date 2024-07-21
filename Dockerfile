# Stage 1: Build
FROM maven:3.8.6-openjdk-11 AS build

# Set the working directory
WORKDIR /app

# Copy the pom.xml and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the source code
COPY src /app/src

# Build the application
RUN mvn package

# Stage 2: Create runtime image
FROM openjdk:11-jre-slim

# Set the working directory
WORKDIR /app

# Copy the built JAR from the build stage
COPY --from=build /app/target/simple-java-app-1.0-SNAPSHOT.jar /app/simple-java-app.jar

# Run the application
ENTRYPOINT ["java", "-jar", "simple-java-app.jar"]
