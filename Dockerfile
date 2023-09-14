FROM chr0mx/gui-docker-cuda:latest

USER root

RUN echo headless | sudo -S -k apt-get update  -y \
	&& echo headless | sudo -S -k install -y --fix-broken software-properties-common ffmpeg curl wget \
# Download the Nvidia driver	
	&& echo headless | sudo -S -k apt-get install -y nvidia-driver-515 \
	&& echo headless | sudo -S -k add-apt-repository ppa:obsproject/obs-studio \
	&& echo headless | sudo -S -k mkdir -p /config/obs-studio /root/.config/ \
	&& echo headless | sudo -S -k ln -s /config/obs-studio/ /root/.config/obs-studio \
	&& echo headless | sudo -S -k apt-get install -y obs-studio \
	&& echo headless | sudo -S -k apt-get clean -y \
# Downloading libNDI and obs-NDI
	&& echo headless | sudo -S -k wget -q -O /tmp/libndi5_5.5.3-1_amd64.deb https://github.com/obs-ndi/obs-ndi/releases/download/4.11.1/libndi5_5.5.3-1_amd64.deb \
	&& echo headless | sudo -S -k wget -q -O /tmp/obs-ndi-4.11.1-linux-x86_64.deb https://github.com/obs-ndi/obs-ndi/releases/download/4.11.1/obs-ndi-4.11.1-linux-x86_64.deb \
# Install the NDI plugins to obs	
	&& echo headless | sudo -S -k dpkg -i /tmp/*.deb \
	&& echo headless | sudo -S -k rm -rf /tmp/*.deb \
	&& echo headless | sudo -S -k rm -rf /var/lib/apt/lists/* \

RUN echo "?package(bash):needs=\"X11\" section=\"DockerCustom\" title=\"OBS Screencast\" command=\"obs\"" >> /usr/share/menu/custom-docker && update-menus 

VOLUME ["/config"]