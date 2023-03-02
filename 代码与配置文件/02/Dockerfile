FROM centos
MAINTAINER zhaoyuqiang collen7788@126.com
RUN mkdir /root/training
RUN mkdir /root/tools
COPY jdk-8u144-linux-x64.tar.gz /root/tools
RUN tar zxvf /root/tools/jdk-8u144-linux-x64.tar.gz -C /root/training/
ENV JAVA_HOME /root/training/jdk1.8.0_144
ENV PATH $JAVA_HOME/bin:$PATH 
ADD https://dlcdn.apache.org/tomcat/tomcat-8/v8.5.73/bin/apache-tomcat-8.5.73.tar.gz  /root/tools
RUN tar zxvf /root/tools/apache-tomcat-8.5.73.tar.gz -C /root/training/
COPY MyDemoWeb.war /root/training/apache-tomcat-8.5.73/webapps
ENTRYPOINT ["/root/training/apache-tomcat-8.5.73/bin/catalina.sh","run"]