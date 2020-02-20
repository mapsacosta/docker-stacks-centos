[![docker pulls](https://img.shields.io/docker/pulls/jupyter/all-spark-notebook.svg)](https://hub.docker.com/r/jupyter/all-spark-notebook/) [![docker stars](https://img.shields.io/docker/stars/jupyter/all-spark-notebook.svg)](https://hub.docker.com/r/jupyter/all-spark-notebook/) [![image metadata](https://images.microbadger.com/badges/image/jupyter/all-spark-notebook.svg)](https://microbadger.com/images/jupyter/all-spark-notebook "jupyter/all-spark-notebook image metadata")

# Jupyter Notebook Python, Scala, R, Spark, Mesos Stack + CMS COFFEA tools

The image includes OSG grid tools, Hadoop-Xrootd[https://github.com/cerndb/hadoop-xrootd] connector and VOMS utils

This notebook can be run as standalone, it has been built an published at DockerHub:

```
docker run -p 127.0.0.1:8889:8888 mapsacosta/spark-scala-py36:notebook
```

It is also deployed at FNAL OKD cluster for CMS/LPC users.

Please visit the documentation site for help using and contributing to this image and others.

* [Jupyter Docker Stacks on ReadTheDocs](http://jupyter-docker-stacks.readthedocs.io/en/latest/index.html)
* [Selecting an Image :: Core Stacks :: jupyter/all-spark-notebook](http://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html#jupyter-all-spark-notebook)
* [Image Specifics :: Apache Spark](http://jupyter-docker-stacks.readthedocs.io/en/latest/using/specifics.html#apache-spark)
