# Fat Docker #3 
FROM maven:3.6.3-openjdk-8
WORKDIR /app
COPY . .
RUN mvn package
EXPOSE 8080
#ENTRYPOINT [ "java","-jar","target/lavagna-jetty-console.war" ] # Original command only for WEB
ENTRYPOINT ["java", "-Ddatasource.dialect=MYSQL", "-Ddatasource.url=jdbc:mysql://sql-db:3306/lavagna?autoReconnect=true&useSSL=false", "-Ddatasource.username=root", "-Ddatasource.password=secretpass", "-Dspring.profile.active=dev", "-jar", "target/lavagna-jetty-console.war"]

