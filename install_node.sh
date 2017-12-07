#!/bin/bash
#sudo su -
##sudo ln -s /usr/local/bin/node /usr/bin/node
set -ex; \
export ARCH= && dpkgArch="$(dpkg --print-architecture)" \
  && case "${dpkgArch##*-}" in \
    amd64) ARCH='x64';; \
    ppc64el) ARCH='ppc64le';; \
    armhf) ARCH='armv7l';; \
    *) echo "unsupported architecture"; exit 1 ;; \
  esac
	sudo apt-get update; \
	sudo apt-get install -y --no-install-recommends \
		autoconf \
		automake \
		bzip2 \
		file \
		g++ \
		gcc \
    git \
    curl \
    unzip \
    build-essential \
    python \
    ca-certificates \
		imagemagick \
		libbz2-dev \
		libc6-dev \
		libcurl4-openssl-dev \
		libdb-dev \
		libevent-dev \
		libffi-dev \
		libgdbm-dev \
		libgeoip-dev \
		libglib2.0-dev \
		libjpeg-dev \
		libkrb5-dev \
		liblzma-dev \
		libmagickcore-dev \
		libmagickwand-dev \
		libncurses-dev \
		libpng-dev \
		libpq-dev \
		libreadline-dev \
		libsqlite3-dev \
		libssl-dev \
		libtool \
		libwebp-dev \
		libxml2-dev \
		libxslt-dev \
		libyaml-dev \
		make \
		patch \
		xz-utils \
		zlib1g-dev \
    chromium-browser \
    npm \
    x11vnc \
    libusb-dev libnfc-dev
     && sudo rm -rf /var/lib/apt/lists/*

# https://lists.debian.org/debian-devel-announce/2016/09/msg00000.html
# if we use just "apt-cache show" here, it returns zero because "Can't select versions from package 'libmysqlclient-dev' as it is purely virtual", hence the pipe to grep
#	$(if apt-cache show 'default-libmysqlclient-dev' 2>/dev/null | grep -q '^Version:'; then
			#	echo 'default-libmysqlclient-dev';
		#	else
			#	echo 'libmysqlclient-dev';
		#	fi
	#	);

sudo npm install -g yarn n npm
sudo n latest
