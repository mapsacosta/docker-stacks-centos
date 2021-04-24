FROM ssiregistry.fnal.gov:443/ecf-gco/jupyter:base-notebook
LABEL maintainer="Maria A. <macosta@fnal.gov>"

USER root

# Install all OS dependencies for fully functional notebook server
RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm ;\
    rpm -Uvh https://repo.opensciencegrid.org/osg/3.5/osg-3.5-el7-release-latest.rpm ;\
    /bin/sed -i '/^enabled=1/a priority=99' /etc/yum.repos.d/epel.repo

RUN yum -y update && \
    yum -y install epel-release \
                   yum-plugin-priorities \
                   osg-wn-client \
                   redhat-lsb-core 

RUN yum -y install xrootd-client \
                   xrootd-client-libs \
                   python36-xrootd 

#Install HTCondor (development)
RUN yum install -y wget sed ;\
    /usr/bin/wget https://research.cs.wisc.edu/htcondor/yum/repo.d/htcondor-stable-rhel7.repo -O /etc/yum.repos.d/condor.repo ;\
    /usr/bin/wget http://research.cs.wisc.edu/htcondor/yum/RPM-GPG-KEY-HTCondor -O /etc/pki/rpm-gpg/RPM-GPG-KEY-HTCondor ;\
    echo "priority=90" >> /etc/yum.repos.d/condor.repo ;\
    echo "gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-HTCondor" >> /etc/yum.repos.d/condor.repo

RUN yum install -y condor
RUN yum clean all && rm -rf /var/cache/yum/*

COPY config.d/* /etc/condor/config.d/
COPY cmslpc-local-conf.py /usr/local/bin/cmslpc-local-conf.py 

RUN chmod a+x /usr/local/bin/cmslpc-local-conf.py

# Switch back to jupyter to avoid accidental container runs as root
USER $NB_UID
