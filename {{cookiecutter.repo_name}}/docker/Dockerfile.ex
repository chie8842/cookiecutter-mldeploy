FROM {{cookiecutter.repo_name}}
MAINTAINER {{cookiecutter.author_name}} <{{cookiecutter.author_email}}>

RUN sudo apt-get install -y \
  libpq-dev

COPY requirements_ex.txt requirements_ex.txt
RUN sudo pip install -r requirements_ex.txt
CMD ["/bin/bash"]
