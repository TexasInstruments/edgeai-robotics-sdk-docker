#!/bin/bash
set -e

SECONDS=0
SDK_VER=10.0.0
ROS_DISTRO=humble
DOCKER_TAG=robotics-sdk:$SDK_VER-$ROS_DISTRO-base
DOCKER_TAG2=robotics-sdk:$SDK_VER-$ROS_DISTRO-$SOC
export SDK_DIR=/home/runner/work/robotics_sdk
export ARCH=arm64
DOCKER_DIR=$SDK_DIR/docker
: "${USE_PROXY:=0}"
# modify the server and proxy URLs as requied
if [ "${USE_PROXY}" -ne "0" ]; then
    REPO_LOCATION=
    HTTP_PROXY=
else
    REPO_LOCATION=
fi
echo "USE_PROXY = $USE_PROXY"
echo "REPO_LOCATION = $REPO_LOCATION"
DST_DIR=/home/runner/j7ros_home/docker_src
EDGEAI_VER=10.0.0.7
TIVA_LIB_VER=10.0.0
RPMSG_LIB_VER=0.6.7
: "${BASE_URL:=https://software-dl.ti.com/jacinto7/esd/robotics-sdk/10_00_00/deps}"
SDK_VER_STR=10000005
bash $DOCKER_DIR/scripts/prepare_docker_build.sh $DST_DIR
ls -l $DST_DIR
cd /home/runner/j7ros_home
if [ "$(docker images -q $DOCKER_TAG 2> /dev/null)" == "" ]; then
    docker build \
        -t $DOCKER_TAG \
        --build-arg ARCH=$ARCH \
        --build-arg USE_PROXY=$USE_PROXY \
        --build-arg REPO_LOCATION=$REPO_LOCATION \
        --build-arg HTTP_PROXY=$HTTP_PROXY \
        --build-arg BASE_URL=$BASE_URL \
        -f $DOCKER_DIR/Dockerfile.arm64v8.$ROS_DISTRO ./docker_src
    echo "Docker build -t $DOCKER_TAG completed!"
else
    echo "$DOCKER_TAG already exists."
fi
docker build \
    -t $DOCKER_TAG2 \
    --build-arg ARCH=$ARCH \
    --build-arg USE_PROXY=$USE_PROXY \
    --build-arg HTTP_PROXY=$HTTP_PROXY \
    --build-arg TIVA_LIB_VER=$TIVA_LIB_VER \
    --build-arg RPMSG_LIB_VER=$RPMSG_LIB_VER \
    --build-arg SOC_NAME=$SOC \
    --build-arg ROS_DISTRO=$ROS_DISTRO \
    --build-arg SDK_VER=$SDK_VER \
    --build-arg EDGEAI_VER=$EDGEAI_VER \
    --build-arg BASE_URL=$BASE_URL \
    --build-arg SDK_VER_STR=$SDK_VER_STR \
    -f $DOCKER_DIR/Dockerfile.arm64v8.ti_libs ./docker_src
echo "Docker build -t $DOCKER_TAG2 completed!"
duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
rm -r $DST_DIR
