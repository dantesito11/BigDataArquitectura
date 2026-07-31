FROM python:3.7

RUN pip install --no-cache-dir \
    jupyterlab \
    pyspark==2.4.0 \
    mysql-connector-python \
    psycopg2-binary \
    pymongo

# Install OpenJDK-8
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

#RUN apt-get -y install default-jre

WORKDIR /user/app

# Crear carpeta para jars
RUN mkdir -p /opt/spark/jars

# Copiar conector JDBC MySQL
COPY jars/mysql-connector-j-8.4.0.jar /opt/spark/jars/

WORKDIR /user/app

