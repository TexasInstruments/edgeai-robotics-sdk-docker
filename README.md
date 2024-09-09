# Robotics SDK Docker

This repository hosts the Robotics SDK Docker images that run on Texas Instruments Edge AI Processors, including AM62A, TDA4VM, AM67A, AM68A, and AM69A. Additionally, the Docker image for the visualization PC is also available here.

Pre-built ROS packages for the Robotics SDK are installed under `/opt/ros/robotics_sdk_install` in the SDK container filesystem.

## Usage

### On the Target

#### Docker Pull
```bash
docker pull ghcr.io/texasinstruments/robotics-sdk:10.0.0-humble-$SOC
docker tag ghcr.io/texasinstruments/robotics-sdk:10.0.0-humble-$SOC robotics-sdk:10.0.0-humble-$SOC
```

#### SDK Setup
```bash
source /opt/edgeai-gst-apps/scripts/install_robotics_sdk.sh
cd ~/j7ros_home
make scripts
./docker_run.sh
```
For more details, please see the Robotics SDK documentation.

### On the Visualization PC

#### Docker Pull
```bash
docker pull ghcr.io/texasinstruments/robotics-sdk:10.0.0-humble-viz
docker tag ghcr.io/texasinstruments/robotics-sdk:10.0.0-humble-viz robotics-sdk:10.0.0-humble-viz
```

#### SDK Setup
```bash
wget -O init_setup.sh https://git.ti.com/cgit/processor-sdk-vision/jacinto_ros_perception/plain/init_setup.sh
source ./init_setup.sh
cd ~/j7ros_home
make scripts [GPUS=y]
./docker_run.sh
```
For more details, please see the Robotics SDK documentation.

## Robotics SDK Documentation

| Platform   | Link to Documentation                                                                                         |
| ---------- | ------------------------------------------------------------------------------------------------------------- |
| **AM62A**  | [Robotics SDK for AM62A](https://software-dl.ti.com/jacinto7/esd/robotics-sdk/latest/AM62A/docs/index.html)   |
| **TDA4VM** | [Robotics SDK for TDA4VM](https://software-dl.ti.com/jacinto7/esd/robotics-sdk/latest/TDA4VM/docs/index.html) |
| **AM67A**  | [Robotics SDK for AM67A](https://software-dl.ti.com/jacinto7/esd/robotics-sdk/latest/AM67A/docs/index.html)   |
| **AM68A**  | [Robotics SDK for AM68A](https://software-dl.ti.com/jacinto7/esd/robotics-sdk/latest/AM68A/docs/index.html)   |
| **AM69A**  | [Robotics SDK for AM69A](https://software-dl.ti.com/jacinto7/esd/robotics-sdk/latest/AM69A/docs/index.html)   |
