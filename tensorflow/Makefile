SHELL := /bin/bash

image_name := tensorflow:build
cont_name := tensorflow-build

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
		--name $(cont_name) \
		-v $${PWD}:/mnt -e HOST_PERMS="$$(id -u):$$(id -g)" \
    	$(image_name) bash

copy_out:
	docker container cp $(cont_name):/tmp/tensorflow-*.whl ./tensorflow.whl
	# docker container rm -f $(cont_name)
	# docker rmi $(image_name)
