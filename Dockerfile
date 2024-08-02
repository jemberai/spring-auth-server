FROM eclipse-temurin:21.0.3_9-jdk as builder

WORKDIR application
ADD ./target/classes/.env ./
ADD ./target/*.jar ./

# Extracts the layers from the jar file
RUN . ./.env && java -Djarmode=layertools -jar ${JAR_FILE} extract

FROM quay.io/jember.ai/jre-21-base-image:9

WORKDIR application
COPY --from=builder application/dependencies/ ./
COPY --from=builder application/spring-boot-loader/ ./
COPY --from=builder application/snapshot-dependencies/ ./
COPY --from=builder application/application/ ./

USER javauser

# incorporating best practices from snyk.io
# see: https://snyk.io/blog/best-practices-to-build-java-containers-with-docker/
ENTRYPOINT ["dumb-init", "java", "-Djava.security.egd=file:/dev/./urandom", "org.springframework.boot.loader.launch.JarLauncher"]