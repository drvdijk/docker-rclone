FROM alpine:latest

ARG BUILD_DATE
ARG VERSION
LABEL build_version="RadPenguin version:- ${VERSION} Build-date:- ${BUILD_DATE}"

ENV TZ="America/Edmonton"

RUN \
 echo "**** install runtime packages ****" && \
  apk add --no-cache \
    alpine-sdk \
    ca-certificates \
    curl \
    git \
    go \
    fuse \
    fuse-dev \
    tzdata && \
  echo "**** install rclone ****" && \
  go get -u -v github.com/ncw/rclone && \
  cp /root/go/bin/rclone /usr/bin/rclone && \
 echo "**** configure fuse ****" && \
 sed -ri 's/^#user_allow_other/user_allow_other/' /etc/fuse.conf && \
 echo "**** cleanup ****" && \
 rm -rf \
        /root/go/ \
	/tmp/*
