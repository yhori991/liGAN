SHELL=/bin/bash

lab-image: docker/lab/*
	DOCKER_BUILDKIT=1 docker build --ssh default -t ligan_lab docker/lab
