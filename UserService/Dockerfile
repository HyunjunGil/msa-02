FROM openjdk:17-jdk-slim

WORKDIR /app

COPY build.gradle .
COPY src ./src

RUN apt-get update && apt-get install -y gradle

RUN gradle build -x test

EXPOSE 8081

CMD ["java", "-jar", "build/libs/user-service-0.0.1-SNAPSHOT.jar"]
