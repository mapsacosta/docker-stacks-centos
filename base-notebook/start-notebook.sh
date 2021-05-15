#!/bin/bash
# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.

set -e

wrapper=""

#source /usr/bin/bootstrap.sh

if [[ "${RESTARTABLE}" == "yes" ]]; then
    wrapper="run-one-constantly"
fi

if [[ ! -z "${JUPYTERHUB_API_TOKEN}" ]]; then
    # launched by JupyterHub, use single-user entrypoint
    exec /usr/local/bin/start-singleuser.sh  --SingleUserNotebookApp.default_url=/lab --SingleUserNotebookApp.disable_user_config=True --SingleUserNotebookApp.notebook_dir="/home/$NB_USER" "$@"
elif [[ ! -z "${JUPYTER_ENABLE_LAB}" ]]; then
    . /usr/local/bin/start.sh $wrapper jupyter lab "$@"
else
    echo "WARN: Jupyter Notebook deprecation notice https://github.com/jupyter/docker-stacks#jupyter-notebook-deprecation-notice."
    . /usr/local/bin/start.sh $wrapper jupyter notebook "$@"
fi
