# build using squash (this will make the resulting image much smaller)
# docker build --squash -t cuda:9.0-ubuntu18.04 .

# original build
docker build --build-arg USER=${USER} -t cuda:9.0-ubuntu18.04 .
