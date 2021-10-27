# FROM registry.gitlab.com/gitlab-org/jupyterhub-user-image:latest
FROM jupyter/all-spark-notebook:ubuntu-20.04

ARG NB_USER=jovyan
ARG NB_UID=1000
ARG HOME=/home/jovyan

USER root

RUN apt-get update && apt-get install -y \
    openjdk-8-jdk \
    openjdk-8-jre \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/cloudera/parcels/CDH-6.3.2-1.cdh6.3.2.p0.1605554/lib && chown ${NB_USER} -R /opt/cloudera/

RUN conda install python=3.7 -y && conda clean -a -y

USER ${NB_USER}

RUN pip install pyspark && \
    pip install findspark

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
COPY ./src/spark /opt/cloudera/parcels/CDH-6.3.2-1.cdh6.3.2.p0.1605554/lib/spark
