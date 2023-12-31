FROM chr0mx/gui-docker-cuda:latest

USER root

RUN export DEBIAN_FRONTEND=noninteractive \
	&& apt-get update -y \
	&& apt-get install -y --fix-broken software-properties-common mesa-utils ffmpeg wget libqt5core5a libqt5gui5 libqt5widgets5 \
# Download the Nvidia driver	
	&& apt-get install -y nvidia-driver-515 \
# Add repository and create config for obs dir	
	&& add-apt-repository ppa:obsproject/obs-studio \
	&& mkdir -p /config/obs-studio /root/.config/ \
	&& ln -s /config/obs-studio/ /root/.config/obs-studio \
	&& apt-get install -y obs-studio \
	&& apt-get clean -y \
# Downloading libNDI and obs-NDI
	&& wget -q -O /tmp/libndi5_5.5.3-1_amd64.deb https://github.com/obs-ndi/obs-ndi/releases/download/4.11.1/libndi5_5.5.3-1_amd64.deb \
	&& wget -q -O /tmp/obs-ndi-4.11.1-linux-x86_64.deb https://github.com/obs-ndi/obs-ndi/releases/download/4.11.1/obs-ndi-4.11.1-linux-x86_64.deb \
# Install the NDI plugins to obs	
	&& dpkg -i /tmp/*.deb \
	&& rm -rf /tmp/*.deb \
	&& rm -rf /var/lib/apt/lists/* \
# Update menu	
	&& echo "?package(bash):needs=\"X11\" section=\"DockerCustom\" title=\"OBS Screencast\" command=\"obs\"" >> /usr/share/menu/custom-docker && update-menus \

VOLUME ["/config"]