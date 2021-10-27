ARG OWNER=integal79
ARG BASE_CONTAINER=$OWNER/all-spark-notebook
FROM $BASE_CONTAINER

LABEL maintainer="Evgeny Sorokin <e.sorokin@southbridge.com>"

USER root

# RSpark config
ENV R_LIBS_USER "${SPARK_HOME}/R/lib"
RUN fix-permissions "${R_LIBS_USER}"

RUN apt-get update && apt-get install -y \
    openjdk-8-jdk \
    openjdk-8-jre \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/cloudera/parcels/CDH-6.3.2-1.cdh6.3.2.p0.1605554/lib && chown ${NB_USER} -R /opt/cloudera/

USER ${NB_USER}

RUN pip install pyspark && \
    pip install findspark

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
COPY ./src/spark /opt/cloudera/parcels/CDH-6.3.2-1.cdh6.3.2.p0.1605554/lib/spark
