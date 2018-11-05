image_name := tensorflow:build

build:
	docker build -t $(image_name) .

serve:
	nvidia-docker run --init \
		-p 8888:8888 -p 5902:5900 \
		-e USER=xwu \
	    $(image_name)

inspect:
	nvidia-docker run -ti --init --rm \
	    -p 8888:8888 -p 5902:5900 \
	    -v ${PWD}:/workspace/source:ro \
	    -e USER=xwu \
	    --entrypoint "/bin/bash" \
	    $(image_name)
