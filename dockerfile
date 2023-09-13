FROM chr0mx/gui-docker-cuda:latest

USER root




RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update -y \
    && apt-get install -y software-properties-common \
    && add-apt-repository ppa:obsproject/obs-studio \
    && apt-get update -y \
    && apt-get install -y ffmpeg \
    && apt-get install -y nvidia-driver-515 \
    && apt-get install -y obs-studio \
    && apt-get clean -y


RUN echo "?package(bash):needs=\"X11\" section=\"DockerCustom\" title=\"OBS Screencast\" command=\"obs\"" >> /usr/share/menu/custom-docker && update-menus
