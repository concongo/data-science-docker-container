#!/usr/bin/env bash

FROM ubuntu:16.04

# Export env settings
ENV TERM=xterm
ENV LANG en_US.UTF-8

RUN apt-get update -y && apt-get install build-essential -y

ADD apt-packages.txt /tmp/apt-packages.txt
RUN xargs -a /tmp/apt-packages.txt apt-get install -y

RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  

RUN pip install pip -U && pip install virtualenv && /usr/local/bin/virtualenv /opt/ds --distribute

ADD /requirements/ /tmp/requirements
ADD python2/requirements.txt /tmp/requirements/additional-reqs.txt

RUN /opt/ds/bin/pip install -r /tmp/requirements/pre-requirements.txt
RUN /opt/ds/bin/pip install -r /tmp/requirements/requirements.txt
RUN /opt/ds/bin/pip install -r /tmp/requirements/additional-reqs.txt

RUN /opt/ds/bin/pip install -U jupyter

RUN useradd --create-home --home-dir /home/ds --shell /bin/bash ds
RUN chown -R ds /opt/ds
RUN adduser ds sudo

ADD run_ipython.sh /home/ds
RUN chmod +x /home/ds/run_ipython.sh && chown ds /home/ds/run_ipython.sh

ADD .bashrc.template /home/ds/.bashrc

EXPOSE 8888
RUN usermod -a -G sudo ds && echo "ds ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER ds
RUN mkdir -p /home/ds/notebooks
ENV HOME=/home/ds
ENV SHELL=/bin/bash
ENV USER=ds
VOLUME /home/ds/notebooks
WORKDIR /home/ds/notebooks
RUN jupyter notebook --generate-config

CMD ["/home/ds/run_ipython.sh"]