# MSA (Microservices Architecture) Project

This is a Spring Boot microservices application that demonstrates a simple microservices architecture with user and post services.

## Project Structure

- **User Service**: Handles user-related operations (`/users/{id}`)
- **Post Service**: Handles post-related operations (`/posts`) with user information integration

## Features

- RESTful API endpoints
- Service-to-service communication using RestTemplate
- JSON response format
- Spring Boot 3.1.2 with Java 17

## API Endpoints

### User Service
- `GET /users/{id}` - Get user information by ID

### Post Service
- `GET /posts` - Get list of posts with author information

## Running the Application

1. Make sure you have Java 17 installed
2. Run the application:
   ```bash
   ./gradlew bootRun
   ```
3. The application will start on `http://localhost:8080`

## Testing

Use the provided HTTP request file (`src/test/request.http`) to test the endpoints:

- Test user service: `GET http://localhost:8080/users/1`
- Test post service: `GET http://localhost:8080/posts`

## Build

To build the project:
```bash
./gradlew build
```

## Dependencies

- Spring Boot Starter Web
- Spring Boot Starter Test (for testing)
