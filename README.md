[![Docker pulls](https://img.shields.io/docker/pulls/dlanguage/dmd.svg)](https://hub.docker.com/r/dlanguage/dmd/)
[![Docker Build](https://img.shields.io/docker/automated/dlanguage/dmd.svg)](https://hub.docker.com/r/dlanguage/dmd/)

# docker-dmd

Docker Image for DMD

## Usage

Place a `test.d` in your current directory.
Then execute
```
docker run --rm -ti \
  -e USER -e HOME -e LOCAL_USER_ID=`id -u $USER` -e LOCAL_GROUP_ID=`id -g $USER`
  -w $(pwd) \
  -v /home/$USER:/home/$USER \
  dlanguage/dmd dmd test.d
```
