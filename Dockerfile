FROM alpine:latest

ARG BUILD_DATE
ARG VERSION
LABEL build_version="RadPenguin version:- ${VERSION} Build-date:- ${BUILD_DATE}"

ENV TZ="America/Edmonton"

RUN \
 echo "**** install runtime packages ****" && \
  apk add --no-cache \
    ca-certificates \
    curl \
    fuse \
    fuse-dev \
    tzdata && \
  echo "**** install rclone ****" && \
  curl https://downloads.rclone.org/rclone-current-linux-amd64.zip -o rclone.zip && \
  unzip rclone.zip && \
  rm -f rclone.zip && \
  mv rclone-*/rclone /usr/bin/rclone && \
  rm -rf rclone-* && \
 echo "**** configure fuse ****" && \
 sed -ri 's/^#user_allow_other/user_allow_other/' /etc/fuse.conf && \
 echo "**** cleanup ****" && \
 rm -rf \
        /root/go/ \
	/tmp/*
