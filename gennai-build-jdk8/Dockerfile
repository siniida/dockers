FROM centos:6
MAINTAINER siniida <sinpukyu@gmail.com>

RUN yum update -y
RUN yum install -y tar

# JDK
RUN curl -O -L -b "oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jdk-8u60-linux-x64.rpm
RUN rpm -ivh jdk-8u60-linux-x64.rpm && rm jdk-8u60-linux-x64.rpm

# Maven
RUN curl http://ftp.meisei-u.ac.jp/mirror/apache/dist/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.tar.gz | tar zx -C /opt
RUN ln -s /opt/apache-maven-3.3.3/bin/mvn /usr/bin/mvn

# clean
RUN yum clean all
