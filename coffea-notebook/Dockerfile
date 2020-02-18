# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
FROM ssiregistry.fnal.gov:443/ecf-gco/jupyter:pyspark_notebook_c7

LABEL maintainer="Maria A. <macosta@fnal.gov>"

USER root

# R pre-requisites
RUN yum -y update && \
    yum -y install \
    fonts-dejavu \
    gfortran \
    gcc 

USER $NB_UID

# R packages
RUN conda install --quiet --yes \
    'r-base=3.6.1' \
    'r-ggplot2=3.2*' \
    'r-irkernel=1.0*' \
    'r-rcurl=1.95*' \
    'r-sparklyr=1.0*' \
    && \
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# Apache Toree kernel
RUN pip install --no-cache-dir \
    https://dist.apache.org/repos/dist/release/incubator/toree/0.3.0-incubating/toree-pip/toree-0.3.0.tar.gz \
    && \
    jupyter toree install --sys-prefix && \
    rm -rf /home/$NB_USER/.local && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# Spylon-kernel
RUN conda install --quiet --yes 'spylon-kernel=0.4*' && \
    conda clean --all -f -y && \
    python -m spylon_kernel install --sys-prefix && \
    rm -rf /home/$NB_USER/.local && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

COPY install_arrow.sh /tmp/
USER root
RUN  /bin/sh -c /tmp/install_arrow.sh && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

COPY requirements.txt /tmp/
RUN pip install --requirement /tmp/requirements.txt && \
    pip install git+git://github.com/lgray/coffea@spark_arrow_hack && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

USER root

#Installing llvm from yum
RUN yum install -y devtoolset-7 llvm-toolset-7 \
    && yum install -y llvm-toolset-7-clang-analyzer llvm-toolset-7-clang-tools-extra git

#Putting hadoop in for hdfs/xrootd
RUN wget https://archive.apache.org/dist/hadoop/core/hadoop-2.7.2/hadoop-2.7.2.tar.gz && \
    tar xvf hadoop-2.7.2.tar.gz  -C /opt/
COPY modules/hadoop/* /opt/hadoop-2.7.2/etc/hadoop/
RUN rm -rf /opt/hadoop-2.7.2.tar.gz

#Various HADOOP/SPARK environment variables
#Spark
ENV SPARK_WORKER_DIR=/scratch
ENV SPARK_WORKER_PORT=8581
ENV SPARK_DIST_CLASSPATH="$(hadoop classpath)"
ENV PATH="$SPARK_HOME/bin:$PATH"

#Hadoop
ENV PATH="/opt/hadoop-2.7.3/bin:$PATH"
ENV HADOOP_HOME="/opt/hadoop-2.7.2"
ENV HADOOP_CLASSPATH="$HADOOP_HOME/libexec"
ENV PATH="$PATH:$HADOOP_HOME/bin:$JAVA_PATH/bin:$HADOOP_HOME/sbin"
ENV HADOOP_PREFIX="/opt/hadoop-2.7.2"
ENV HADOOP_MAPRED_HOME="${HADOOP_HOME}"
ENV HADOOP_COMMON_HOME="${HADOOP_HOME}"
ENV HADOOP_HDFS_HOME="${HADOOP_HOME}"
ENV YARN_HOME="${HADOOP_HOME}"
ENV HADOOP_CONF_DIR="${HADOOP_HOME}/etc/hadoop"
ENV HADOOP_COMMON_LIB_NATIVE_DIR="${HADOOP_PREFIX}/lib/native"
ENV HADOOP_OPTS="$HADOOP_OPTS -Djava.library.path=$HADOOP_HOME/lib/native"
ENV LD_LIBRARY_PATH="$HADOOP_HOME/lib/native/:$LD_LIBRARY_PATH"

#Putting hadoop-xrootd connector in place and modifying classpath
COPY modules/hadoop-xrootd/* /opt/hadoop-xrootd/
ENV HADOOP_CLASSPATH="/opt/hadoop-xrootd/*:$(hadoop classpath)"

RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm ;\
    rpm -Uvh https://repo.opensciencegrid.org/osg/3.4/osg-3.4-el7-release-latest.rpm ;\
    /bin/sed -i '/^enabled=1/a priority=99' /etc/yum.repos.d/epel.repo

RUN yum -y install xrootd-client xrootd-client-libs xrootd-client-devel python36-xrootd \
    && yum  -y install git htop

RUN yum -y install epel-release \
                   yum-plugin-priorities && \
    yum -y install  \
                   osg-wn-client \
                   redhat-lsb-core \
    yum clean all && \
    rm -rf /var/cache/yum/*

# Package Updates
RUN pip install  --upgrade git+git://github.com/lgray/coffea@spark_arrow_hack

#Put spark config in
USER root
COPY modules/config /tmp/config 
RUN mv /tmp/config/* /usr/local/spark/conf/ && rm -rf /tmp/config

RUN fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

USER $NB_USER
