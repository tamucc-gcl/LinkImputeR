FROM maven:3.9.13-eclipse-temurin-8 AS build

WORKDIR /build

COPY pom.xml .
COPY src ./src

RUN mvn -B clean package


FROM eclipse-temurin:8-jre

LABEL org.opencontainers.image.title="LinkImputeR"
LABEL org.opencontainers.image.version="1.2.4"
LABEL org.opencontainers.image.source="https://github.com/danielmoney/LinkImputeR"

WORKDIR /opt/linkimputer

COPY --from=build /build/target/LinkImputeR.jar /opt/linkimputer/LinkImputeR.jar

ENTRYPOINT ["java", "-jar", "/opt/linkimputer/LinkImputeR.jar"]