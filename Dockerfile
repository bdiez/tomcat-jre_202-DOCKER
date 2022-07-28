FROM ubuntu:latest

RUN apt-get update -y 
RUN apt-get upgrade -y
RUN apt install zip unzip -y

#Install jre 1.8_202
RUN mkdir /temp
WORKDIR /temp
COPY jre-8u202-linux-x64.tar.gz .
RUN tar xzvf jre-8u202-linux-x64.tar.gz
RUN mv jre1.8.0_202 /opt/
ENV JAVA_HOME=/opt/jre1.8.0_202
ENV PATH=${JAVA_HOME}/bin:${PATH}

#Install tomcat 8.5
COPY apache-tomcat-8.5.78.zip .
RUN unzip apache-tomcat-8.5.78.zip
RUN mv apache-tomcat-8.5.78 /opt
ENV CATALINA_HOME=/opt/apache-tomcat-8.5.78
WORKDIR /opt/apache-tomcat-8.5.78
RUN rm -rf /temp
RUN chmod +x bin/catalina.sh

EXPOSE 8080
EXPOSE 8005

ENTRYPOINT [ "bin/catalina.sh", "run" ]
