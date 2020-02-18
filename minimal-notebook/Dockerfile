# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
FROM ssiregistry.fnal.gov:443/ecf-gco/jupyter:base_notebook_c7

LABEL maintainer="Maria A. <macosta@fnal.gov>"

USER root

# Install all OS dependencies for fully functional notebook server
RUN yum -y update && yum -y install \
    build-essential \
    emacs \
    git \
    inkscape \
    jed \
    libsm6 \
    libxext-dev \
    libxrender1 \
    lmodern \
    netcat \
    pandoc \
    python-dev \
    texlive-fonts-extra \
    texlive-fonts-recommended \
    texlive-generic-recommended \
    texlive-latex-base \
    texlive-latex-extra \
    texlive-xetex \
    tzdata \
    unzip \
    nano \
    vim \
    && yum clean all && rm -rf /var/cache/yum

# Switch back to jupyter to avoid accidental container runs as root
USER $NB_UID
