FROM aank999/xrdp-okteto-cloud:latest

ENV TTY_VER 1.6.1
#ENV USER kali
#ENV PASSWORD kali

RUN apt-get -y update && \
    apt-get install -y curl && \
    curl -sLk https://github.com/tsl0922/ttyd/releases/download/${TTY_VER}/ttyd_linux.x86_64 -o ttyd_linux && \
    chmod +x ttyd_linux && \
    cp ttyd_linux /usr/local/bin/

RUN echo 'Installing additional packages...' && \
	export DEBIAN_FRONTEND=noninteractive && \
	apt-get update && \
	apt-get install \
	sudo \
	wget \
        unzip \
	screen \
	-y --show-progress 
RUN curl https://my.webhookrelay.com/webhookrelay/downloads/install-cli.sh | bash
COPY vless.sh /vless.sh
RUN chmod 744 /vless.sh
COPY modsbots.sh /modsbots.sh
RUN chmod 744 /modsbots.sh


CMD ["/bin/bash","/modsbots.sh"]
