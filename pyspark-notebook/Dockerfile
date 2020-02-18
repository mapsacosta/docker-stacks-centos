# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
FROM ssiregistry.fnal.gov:443/ecf-gco/jupyter:scipy_notebook_c7

LABEL maintainer="Maria A. <macosta@fnal.gov>"

USER root

# Spark dependencies
ENV APACHE_SPARK_VERSION 2.4.4
ENV HADOOP_VERSION 2.7
ENV SPARK_HACK_BINARY spark-2.4.4-bin-x509-arrow-hack

#Python
ENV PYSPARK_PYTHON="python3.6"
ENV PYSPARK_MAJOR_PYTHON_VERSION="3"

RUN yum -y update && \
    yum -y install java-1.8.0-openjdk wget which ca-certificates-java && \
    rm -rf /var/cache/yum

RUN cd /tmp && \
    wget -q http://home.fnal.gov/~lagray/spark-2.4.4-bin-x509-arrow-hack.tgz && \
    tar xzf ${SPARK_HACK_BINARY}.tgz -C /usr/local --owner root --group root --no-same-owner && \
    rm ${SPARK_HACK_BINARY}.tgz
RUN cd /usr/local && ln -s ${SPARK_HACK_BINARY} spark

# Mesos dependencies
# Install from the Xenial Mesosphere repository since there does not (yet)
# exist a Bionic repository and the dependencies seem to be compatible for now.
RUN yum -y update && \
    rpm -Uvh http://repos.mesosphere.io/el/7/noarch/RPMS/mesosphere-el-repo-7-1.noarch.rpm  && \
    yum -y install mesos 

# Spark and Mesos config
ENV SPARK_HOME /usr/local/spark
ENV PYTHONPATH $SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.7-src.zip
ENV MESOS_NATIVE_LIBRARY /usr/local/lib/libmesos.so
ENV SPARK_OPTS --driver-java-options=-Xms1024M --driver-java-options=-Xmx4096M --driver-java-options=-Dlog4j.logLevel=info

USER $NB_UID

# Install pyarrow
RUN conda install --quiet -y 'pyarrow' && \
    conda clean --all -f -y

USER root
RUN fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

USER $NB_UID



