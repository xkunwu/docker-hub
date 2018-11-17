SHELL := /bin/bash

image_name := exp:cuda
user_me := $$(whoami)
user_uid := $$(id -u)
user_gid := $$(id -g)
cont_name := exp-serve

build:
	docker build -t $(image_name) \
	--build-arg USER_ME=$(user_me) \
	--build-arg USER_UID=$(user_uid) \
	--build-arg USER_GID=$(user_gid) \
		.
	docker image prune --force

# build-squash:
# 	docker build --squash -t $(image_name) .


serve:
	nvidia-docker run -ti --init \
		--name=$(cont_name) \
		--hostname="palau-docker" \
		--network="host" \
	    -v ${HOME}/projects/extern:/workspace/code-ext \
		-p 5902:5902 -p 8888:8888 \
		-e USER=$(user_me) \
		$(image_name) bash

debug:
	nvidia-docker run -ti --rm --init \
		--name=$(cont_name)-debug \
		--hostname="palau-docker" \
		--network="host" \
	    -v ${HOME}/projects/extern:/workspace/code-ext \
		-p 5902:5902 -p 8888:8888 \
		-e USER=$(user_me) \
		--privileged \
		$(image_name) bash

reattach:
	docker start $(cont_name)
	docker attach $(cont_name)

# inspect:
# 	docker start $(cont_name)
# 	nvidia-docker exec -ti \
# 		-e USER=$(user_me) \
# 		--user $$(id -u):$$(id -g) \
# 		$(cont_name) bash

inspect:
	docker start $(cont_name)
	nvidia-docker exec -ti \
		-e USER="root" \
		-e HOME="/root" \
		--user 0 \
		$(cont_name) bash

clean:
	docker stop $(cont_name)
	docker rm $(cont_name)
