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

# serve:
# 	nvidia-docker run --init \
# 		-p 8888:8888 -p 5902:5900 \
# 		-e USER=xwu \
# 	    $(image_name)
#
# inspect:
# 	nvidia-docker run -ti --init --rm \
# 	    -p 8888:8888 -p 5902:5900 \
# 	    -v ${PWD}:/workspace/source:ro \
# 	    -e USER=xwu \
# 	    --entrypoint "/bin/bash" \
# 	    $(image_name)
