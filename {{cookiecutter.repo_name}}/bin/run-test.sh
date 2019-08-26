#!/bin/bash

{% if cookiecutter.test_type == 'unittest' -%}
CMD="python3 -m unittest discover -start-directory {{cookiecutter.repo_name}} -v"
{% else -%}
CMD="pytest {{cookiecutter.repo_name}} --cov=. --verbose --pep8"
{% endif %}

source setenv.sh.sample
docker run --rm \
-e DB_HOST=$(DB_HOST) \
-e DB_USER=$(DB_USER) \
-e DB_PASSWD=$(DB_PASSWD) \
-e DB_PORT=$(DB_PORT) \
-e DBNAME=$(DBNAME) \
-e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
-e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} \
-e APP_PORT=${APP_PORT} \
-e PREDICT_TYPE=${PREDICT_TYPE} \
-e INDEX_PREFIX=${INDEX_PREFIX} \
-e ENV_TYPE=${ENV_TYPE} \
{{cookiecutter.repo_name}} \
${CMD}


