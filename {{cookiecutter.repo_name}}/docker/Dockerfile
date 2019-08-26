FROM ubuntu:18.04
MAINTAINER Chie HAYASHIDA <chie-hayashida@cookpad.com>

# apt-get
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
  git \
  vim \
  wget \
  curl \
  python3.6-minimal \
  python3-pip \
  libpq-dev \
  sudo \
  mecab-ipadic-utf8 \
  libboost-all-dev libgsl0-dev libeigen3-dev

RUN python3.6 -m pip install --upgrade pip
COPY requirements.txt /requirements.txt

{% if cookiecutter.use_mecab == 'y' %}
RUN apt-get install -y \
  swig cmake mecab libmecab-dev mecab-ipadic mecab-ipadic-utf8

pip3.6 install mecab-python3
{% endif %}

# settings
ARG user_name=ubuntu
ARG user_id=1000
ARG group_name=ubuntu
ARG group_id=1000

# create user
RUN groupadd -g ${group_id} ${group_name} \
  && \
    useradd -u ${user_id} -g ${group_id} -d /home/${user_name} --create-home --shell /bin/bash ${user_name} \
  && \
    echo "${user_name} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
  && \
    chown -R ${user_name}:${group_name} /home/${user_name}

# user settings
USER ubuntu
WORKDIR /home/${user_name}
ENV HOME /home/${user_name}
ENV LANG="C"

# Set alias for python3.5
RUN echo "alias python=python3.6" >> /home/${user_name}/.bashrc && \
    echo "alias pip=pip3.6" >> /home/${user_name}/.bashrc

COPY --chown=ubuntu:ubuntu . . 

CMD ["python3.6", "-m", "app"]
