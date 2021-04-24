# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
FROM ssiregistry.fnal.gov:443/ecf-gco/jupyter:base-notebook

LABEL maintainer="Maria A. <macosta@fnal.gov>"

ENV PYTHONPATH /usr/local/lib:$PYTHONPATH
#RUN conda create --name MLtutorial2 python=3.7.0 && \
#    conda activate MLtutorial2 && \
 #   fix-permissions $CONDA_DIR && \
  #  fix-permissions /home/$NB_USER
RUN conda install --quiet --yes \
    'keras' \
    'tensorflow' \
    && \
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# Install Tensorflow and friends
RUN pip install --upgrade scipy==1.4.1 numpy && \
    pip install  \
    'jupyter'  \
    'uproot'  \
    'h5py'  \
    'pandas' \
    'matplotlib'  \
    'sklearn'  \
    'scikit-optimize'  \
    'torch' && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# Copy the repo with notebooks and data tarball
RUN  cd /home/$NB_USER && \
     git clone https://github.com/FNAL-AI-Project/machine-learning-tutorial.git && \
     wget https://www.dropbox.com/s/q4qtgms6a3zw1lb/MLTutorialData.tar.gz &&  \
     fix-permissions $CONDA_DIR && \
     fix-permissions /home/$NB_USER

USER $NB_USER
