# Use an official Maven image as a build stage
FROM maven:3.8.6-openjdk-17 AS build

# Set the working directory
WORKDIR /app

# Copy the project files to the container
COPY pom.xml .
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests

# Use a lightweight OpenJDK runtime image
FROM openjdk:17-jre-slim

# Set the working directory
WORKDIR /app

# Copy the built JAR file from the build stage
COPY --from=build /home/runner/work/payment-billing-system/payment-billing-system/target/SampleCode.jar ./SampleCode.jar

# Expose the application port (if applicable)
EXPOSE 8080

# Define the entry point for the container
CMD ["java", "-jar", "SampleCode.jar"]
