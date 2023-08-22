# Build Stage - JDK
FROM maven:3.6.3-openjdk-8 as build
WORKDIR /app
COPY . .
RUN mvn package

# Runtime stage - JRE
FROM openjdk:8-jre-alpine
WORKDIR /app
# Copy ONLY the app
COPY --from=build /app/target/ /app
ENTRYPOINT ["java", "-Ddatasource.dialect=MYSQL", "-Ddatasource.url=jdbc:mysql://sql-db:3306/lavagna?autoReconnect=true&useSSL=false", "-Ddatasource.username=root", "-Ddatasource.password=secretpass", "-Dspring.profile.active=dev", "-jar", "/app/lavagna-jetty-console.war"]