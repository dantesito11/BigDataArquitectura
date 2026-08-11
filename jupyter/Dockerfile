FROM python:3.8-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    default-jdk \
    && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/usr/lib/jvm/default-java
ENV PATH=$JAVA_HOME/bin:$PATH

RUN pip install --no-cache-dir \
    jupyterlab \
    pyspark==3.5.1 \
    mysql-connector-python \
    psycopg2-binary \
    pymongo

WORKDIR /home/jovyan/work

EXPOSE 8888

CMD ["jupyter", "lab", \
     "--ip=0.0.0.0", \
     "--port=8888", \
     "--no-browser", \
     "--allow-root", \
     "--NotebookApp.token=''"]

RUN mkdir -p /opt/spark/jars

COPY jars/*.jar /opt/spark/jars/
