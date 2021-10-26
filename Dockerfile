# FROM registry.gitlab.com/gitlab-org/jupyterhub-user-image:latest
FROM jupyter/all-spark-notebook:ubuntu-20.04

USER root
RUN apt-get update && apt-get install -y \
    openjdk-8-jdk \
    openjdk-8-jre \
    && rm -rf /var/lib/apt/lists/*


ARG NB_USER=jovyan
ARG NB_UID=1000
ARG HOME=/home/jovyan

RUN mkdir -p /opt/cloudera/parcels/CDH-6.3.2-1.cdh6.3.2.p0.1605554/lib && chown ${NB_USER} -R /opt/cloudera/

USER ${NB_USER}

RUN conda install python=3.7 -y 

RUN conda install pyspark findspark -y && \
    conda clean -a -y

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

COPY ./src/spark /opt/cloudera/parcels/CDH-6.3.2-1.cdh6.3.2.p0.1605554/lib/spark
