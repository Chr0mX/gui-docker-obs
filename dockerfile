FROM chr0mx/gui-docker-cuda:latest

USER root

# Install FFmpeg
RUN apt update --fix-missing
RUN apt install -y software-properties-common \
        libfreetype6-dev \
        libgnutls28-dev \
        libmp3lame-dev \
        libass-dev \
        libogg-dev \
        libtheora-dev \
        libvorbis-dev \
        libvpx-dev \
        libwebp-dev \
        libssh2-1-dev \
        libopus-dev \
        librtmp-dev \
        libx264-dev \
        libx265-dev \
        yasm
RUN apt install -y \
        build-essential \
        bzip2 \
        coreutils \
        procps \
        gnutls-bin \
        nasm \
        tar \
        x264
RUN apt install -y \
                ffmpeg \
                git \
                make \
                g++ \
                gcc \
                pkg-config \
                python3 \
                wget \
                tar \
                sudo \
                xz-utils


RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update -y \
    && apt-get install -y software-properties-common \
    && add-apt-repository ppa:obsproject/obs-studio \
    && apt-get update -y \
    && apt-get install -y obs-studio \
    && apt-get clean -y


RUN echo "?package(bash):needs=\"X11\" section=\"DockerCustom\" title=\"OBS Screencast\" command=\"obs\"" >> /usr/share/menu/custom-docker && update-menus
