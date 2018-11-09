SHELL := /bin/bash

image_name := cuda:9.0-ubuntu18.04
user_me := $$(whoami)
user_id := $$(id -u)
cont_name := cuda-serve

build:
	docker build -t $(image_name) \
		 --build-arg USER=$(user_me) \
		 --build-arg USER_ID=$(user_id) \
		 .

# build-squash:
# 	docker build --squash -t $(image_name) .


serve:
	nvidia-docker run -ti --init \
		--name $(cont_name) \
		-p 5902:5900 -p 8888:8888 \
		-e USER=$(user_me) \
		$(image_name)

reattach:
	docker start $(cont_name)
	docker attach $(cont_name)

inspect:
	docker start $(cont_name)
	nvidia-docker exec -ti \
		-e USER=$(user_me) \
		--user $$(id -u):$$(id -g) \
		$(cont_name) bash

clean:
	docker stop $(cont_name)
	docker rm $(cont_name)
	docker rmi $$(docker images -f "dangling=true" -q)

tunnel:
	ssh -N -f \
		 -L 5901:localhost:5901 \
		 -L 5902:localhost:5902 \
		 -L 8888:localhost:8888 \
		 palau
