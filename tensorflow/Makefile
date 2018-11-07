SHELL := /bin/bash

image_name := tensorflow:build

test:
	{ \
	set -e ;\
	echo $${PWD} ;\
	echo "$$(id -u):$$(id -g)" ;\
	}

build:
	docker build -t $(image_name) .

packing:
	nvidia-docker run -ti -w /opt/tensorflow \
		--name build-tf \
		-v $${PWD}:/mnt -e HOST_PERMS="$$(id -u):$$(id -g)" \
		--entrypoint "/bin/bash" \
    	$(image_name)
