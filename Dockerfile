FROM --platform=i386 i386/debian:bookworm
ARG DEBIAN_FRONTEND=noninteractive

# Configure Mirrors
# You may remove it if you can connect to the official repository

RUN rm -f /etc/apt/sources.list.d/* && \
    echo \
    "deb http://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm main contrib non-free non-free-firmware\n\
    deb http://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-updates main contrib non-free non-free-firmware\n\
    deb http://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-backports main contrib non-free non-free-firmware\n\
    deb http://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware" \
    > /etc/apt/sources.list
RUN apt-get clean && apt-get update && apt-get -y upgrade
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    apt-utils \
    ecl \
    libffi-dev \
    git \
    ca-certificates \
    build-essential \
    locales \
    vim && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# github mirror
# You may change it to "RUN git clone https://github.com/oldk1331/fricas0.git /opt/fricas0" if you can connect to github
RUN git clone https://gh-proxy.org/https://github.com/oldk1331/fricas0.git /opt/fricas0

WORKDIR /opt/fricas0/
ENTRYPOINT [ "/usr/bin/ecl", "-load", "fricas"]
