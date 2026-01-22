# FROM openjdk:11-jdk AS BUILD_IMAGE
# RUN apt update && apt install maven -y
# COPY ./ vprofile-project
# RUN cd vprofile-project &&  mvn install 

# FROM tomcat:9.0-jdk11
# LABEL "Project"="Vprofile"
# LABEL "Author"="Imran"
# RUN rm -rf /usr/local/tomcat/webapps/*
# COPY --from=BUILD_IMAGE vprofile-project/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

# EXPOSE 8080
# CMD ["catalina.sh", "run"]

FROM maven:3.9.9-eclipse-temurin-21-jammy AS BUILD_IMAGE
COPY . / vprofile-project
#WORKDIR /app
RUN cd vprofile-project && mvn install

FROM tomcat:10-jdk21

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=BUILD_IMAGE vprofile-project/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]


