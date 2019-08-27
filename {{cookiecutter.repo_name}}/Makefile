include env.sh

IMAGE_NAME := {{cookiecutter.repo_name}}
DOCKER_OPTS := -it \
	--rm \
	-e DB_HOST=$(DB_HOST) \
	-e DB_USER=$(DB_USER) \
	-e DB_PASSWD=$(DB_PASSWD) \
	-e DB_PORT=$(DB_PORT) \
	-e DBNAME=$(DBNAME) \
	-e AWS_ACCESS_KEY_ID=$(AWS_ACCESS_KEY_ID) \
	-e AWS_SECRET_ACCESS_KEY=$(AWS_SECRET_ACCESS_KEY) \
	-e ENV_TYPE=$(ENV_TYPE)

build-docker-no-cache:
	docker build --no-cache -t $(IMAGE_NAME) -f docker/Dockerfile .
build-docker:
	docker build -t $(IMAGE_NAME) -f docker/Dockerfile .
build-exp-docker:
	@if test `docker image ls| grep $(IMAGE_NAME)|wc -l` != 1; then make build-docker; fi
	docker build -t $(IMAGE_NAME)_ex -f docker/Dockerfile.ex .
run-train:
	docker run \
	$(DOCKER_OPTS) \
	$(IMAGE_NAME) \
	python3 IMAGE_NAME/train.py

run-app:
	docker run \
	$(DOCKER_OPTS) \
	-p $(APP_PORT):$(APP_PORT) \
	-e APP_PORT=$(APP_PORT) \
	$(IMAGE_NAME) \
	python3 -m app

run-test: build-docker
	docker run \
	$(DOCKER_OPTS) \
	-e APP_PORT=$(APP_PORT) \
	$(IMAGE_NAME) \
	bin/run-test.sh

run-exp:
	docker run \
	$(DOCKER_OPTS) \
	-p JUPYTER_PORT=$(JUPYTER_PORT) \
	-e JUPYTER_PORT=$(JUPYTER_PORT) \
	-e JUPYTER_PORT=$(JUPYTER_PORT) \
	-e APP_PORT=$(APP_PORT) \
	$(IMAGE_NAME)_ex \
	/bin/bash
