FROM ubuntu
RUN apt update -y
RUN apt install default-jdk -y
RUN apt install wget -y
RUN apt install vim -y
RUN wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.97/bin/apache-tomcat-9.0.97.tar.gz
RUN tar -xvf apache-tomcat-9.0.97.tar.gz
RUN mv apache-tomcat-9.0.97 /opt/
RUN cd /opt
RUN mkdir warfile/
RUN wget https://github.com/thisismanikandan/java-apm-jpetstore/blob/main/jpetstore.war
COPY jpetstore.war /opt/warfile/
RUN mv /opt/warfile/jpetstore.war /opt/apache-tomcat-9.0.97/webapps/
RUN /opt/apache-tomcat-9.0.97/bin/shutdown.sh run
RUN cd /opt
RUN mkdir java-apm
ADD apminsight-javaagent.jar apminsight-javaagent-api.jar apminsight.conf background_transaction.conf custom_instrumentation.conf sample.txt /opt/java-apm/
ENV JAVA_OPTS="$JAVA_OPTS -javaagent:/opt/java-apm/apminsight-javaagent.jar"
ENTRYPOINT [ "/opt/apache-tomcat-9.0.76/bin/catalina.sh", "run" ]
