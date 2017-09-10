
VERSION = v1.4

OPTIONS = \
	--build-arg http_proxy=${http_proxy} \
	--build-arg https_proxy=${https_proxy} \
	--build-arg ftp_proxy=${ftp_proxy} \
	--build-arg no_proxy=${no_proxy}

build: FORCE
	docker build -t jam7/narou-alpine:${VERSION} ${OPTIONS} .

FORCE:
