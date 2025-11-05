FROM eclipse-temurin:21-jdk
WORKDIR /app
LABEL maintainer = "javaguides.net"
ADD target/HelloWarFile-0.0.1-SNAPSHOT.war docker-springhtml.war
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "docker-springhtml.war"]
