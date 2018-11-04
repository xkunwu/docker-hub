# build using squash (this will make the resulting image much smaller)
# docker build --squash -t cuda:9.0-ubuntu18.04 .

# original build 
docker build -t cuda:9.0-ubuntu18.04 .
