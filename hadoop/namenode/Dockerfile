FROM eclipse-temurin:11-jdk

ENV HADOOP_VERSION=3.3.4
ENV HADOOP_HOME=/opt/hadoop
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

RUN apt-get update && \
    apt-get install -y wget openssh-server rsync procps && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz && \
    tar -xzf hadoop-${HADOOP_VERSION}.tar.gz -C /opt && \
    mv /opt/hadoop-${HADOOP_VERSION} ${HADOOP_HOME} && \
    rm hadoop-${HADOOP_VERSION}.tar.gz

ENV JAVA_HOME=/opt/java/openjdk

RUN mkdir -p /data/name

COPY core-site.xml $HADOOP_HOME/etc/hadoop/
COPY hdfs-site.xml $HADOOP_HOME/etc/hadoop/

EXPOSE 9870 8020

CMD ["/bin/bash","-c","\
if [ ! -d /data/name/current ]; then \
hdfs namenode -format -force; \
fi && \
hdfs namenode"]