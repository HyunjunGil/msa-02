FROM openjdk:17-jdk-slim

WORKDIR /app

COPY build.gradle .
COPY settings.gradle .
COPY gradlew .
COPY gradle ./gradle
COPY src ./src

RUN chmod +x gradlew

RUN ./gradlew build -x test

EXPOSE 8081

CMD ["java", "-jar", "build/libs/user-service-0.0.1-SNAPSHOT.jar"]
