SHELL := /bin/bash

image_name := cuda:9.0-ubuntu18.04

build:
	docker build -t $(image_name) .

# build-squash:
# 	docker build --squash -t $(image_name) .

serve:
	nvidia-docker run --init \
		--name cuda-serve \
		-p 8888:8888 -p 5902:5900 \
		-e USER=xwu \
		$(image_name)

inspect:
	nvidia-docker run -ti --init --rm \
		--name cuda-inspect \
	    -p 8888:8888 -p 5902:5900 \
	    -v $${PWD}:/workspace/source:ro \
	    -e USER=xwu \
	    --entrypoint "/bin/bash" \
	    $(image_name)
