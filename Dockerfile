# Centos based container with Java and Tomcat
FROM centos:centos7
MAINTAINER bingqiao <bqiaodev@gmail.com>

# Install prepare infrastructure
RUN yum -y update && \
 yum -y install wget && \
 yum -y install tar && \
 yum -y install java-1.8.0-openjdk

# Create group and users
RUN groupadd -r tomcat && \
 useradd -g tomcat -c "user1" user1 && \
 echo 'user1:letmein' | chpasswd && \
 useradd -g tomcat -c "user2" user2 && \
 echo 'user2:letmein' | chpasswd

# Install Tomcat servers
ARG TOMCAT_MAJOR=8
ARG TOMCAT_VERSION=8.5.34

RUN wget http://mirror.linux-ia64.org/apache/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
 tar -xvf apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
 rm apache-tomcat*.tar.gz && \
 cp -R apache-tomcat* /home/user1/tomcat && \
 mv apache-tomcat* /home/user2/tomcat && \
 sed -i 's/="8080"/="18080"/g;s/="8005"/="18005"/g;s/="8443"/="18443"/g;s/="8009"/="18009"/g' /home/user2/tomcat/conf/server.xml && \
 echo 'CATALINA_OPTS="-d64 -Xmx1024M $CATALINA_OPTS"' > /home/user2/tomcat/bin/setenv.sh && \
 chown -R user1:tomcat /home/user1/tomcat && \
 chmod +x /home/user1/tomcat/bin/*sh && \
 chown -R user2:tomcat /home/user2/tomcat && \
 chmod +x /home/user2/tomcat/bin/*sh

USER user1
RUN echo 'export CATALINA_HOME=$HOME/tomcat' >>~/.bash_profile && \
 echo "export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:/bin/java::")" >>~/.bash_profile && \
 echo 'export PATH=$PATH:$JAVA_HOME/bin:$CATALINA_HOME/bin' >>~/.bash_profile

USER user2
RUN echo 'export CATALINA_HOME=$HOME/tomcat' >>~/.bash_profile && \
 echo "export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:/bin/java::")" >>~/.bash_profile && \
 echo 'export PATH=$PATH:$JAVA_HOME/bin:$CATALINA_HOME/bin' >>~/.bash_profile

USER root

EXPOSE 8080
EXPOSE 18080

ADD init.sh /scripts/init.sh
# fix windows carriage return
RUN sed -i -e 's/\r$//' /scripts/init.sh

CMD ["./scripts/init.sh"]
