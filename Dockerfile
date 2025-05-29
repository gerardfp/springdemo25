# Etapa 1: Compila la app con Gradle
FROM eclipse-temurin:17-jdk AS builder

WORKDIR /app

# Copia lo necesario para ejecutar Gradle
COPY gradlew .
COPY gradle/ gradle/
COPY build.gradle .
COPY settings.gradle .
# Si usas Kotlin DSL en vez de Groovy:
# COPY build.gradle.kts .
# COPY settings.gradle.kts .

# Copia el código fuente
COPY src/ src/

# Da permisos al wrapper
RUN chmod +x ./gradlew

# Construye el proyecto (usa --no-daemon para entornos CI/Docker)
RUN ./gradlew build --no-daemon

# Etapa 2: Imagen final minimalista para ejecutar el JAR
FROM eclipse-temurin:24.0.1_9-jre-ubi9-minimal

WORKDIR /app

# Copia el JAR desde la etapa anterior
COPY --from=builder /app/build/libs/*.jar app.jar

# Puerto por defecto (opcional)
EXPOSE 8080

# Ejecuta el JAR
ENTRYPOINT ["java", "-jar", "app.jar"]
r"]