# Use an official Maven image as a build stage
FROM maven:3.8.6-openjdk-11 AS build

# Set the working directory
WORKDIR /app

# Copy the project files to the container
COPY pom.xml .
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests

# Use a lightweight OpenJDK runtime image
FROM openjdk:11-jre-slim

# Set the working directory
WORKDIR /app

# Copy the built JAR file from the build stage
COPY --from=build /app/target/SampleCode.jar ./SampleCode.jar

# Expose the application port (if applicable)
EXPOSE 8080

# Define the entry point for the container
CMD ["java", "-jar", "SampleCode.jar"]
