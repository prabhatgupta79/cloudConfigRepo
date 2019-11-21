FROM bamboo/centosjava13:3
RUN mkdir /opt/eventAuditLoggerAPI
WORKDIR /opt/eventAuditLoggerAPI
COPY watchman-0.0.1-SNAPSHOT.jar .
ENV JAVA_HOME /opt/jdk-13
ENV PATH /opt/jdk-13/bin:$PATH
EXPOSE 9443
CMD ["java", "-jar", "watchman-0.0.1-SNAPSHOT.jar"]
