SHELL := /bin/bash

image_name := cuda:9.0-ubuntu18.04
user_me := $$(whoami)
user_id := $$(id -u)

build:
	docker build -t $(image_name) \
		 --build-arg USER=$(user_me) \
		 --build-arg USER_ID=$(user_id) \
		 .

# build-squash:
# 	docker build --squash -t $(image_name) .


serve:
	nvidia-docker run -ti --init \
		--name cuda-serve \
		-p 5902:5900 -p 8888:8888 \
		-e USER=$(user_me) \
		$(image_name)

# # --user $$(id -u):$$(id -g) \

inspect:
	nvidia-docker run -ti --init --rm \
		--name cuda-inspect \
	    -p 5902:5900 -p 8888:8888 \
	    -v $${PWD}:/workspace/source:ro \
		-e USER=$(user_me) \
		--entrypoint "/bin/bash" \
	    $(image_name)
