FROM maven:3.8.5-openjdk-17 AS build

WORKDIR /app

COPY pom.xml /app/

COPY src /app/src/

RUN mvn clean package

FROM openjdk:17-jdk-slim

WORKDIR /app

COPY --from=build /app/target/*.jar /app/docker_calc-1.0-SNAPSHOT.jar

# Command to run the application
CMD ["java", "-jar", "docker_calc-1.0-SNAPSHOT.jar"]
