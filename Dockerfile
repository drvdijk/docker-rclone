FROM alpine:3.8

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
    tzdata && \
  echo "**** install rclone ****" && \
  curl --silent --output /tmp/rclone.zip -L "https://downloads.rclone.org/rclone-current-linux-amd64.zip" && \
  unzip /tmp/rclone.zip -d /tmp && \
  mv /tmp/rclone-*linux*/rclone /usr/bin/ && \
 echo "**** configure fuse ****" && \
 sed -ri 's/^#user_allow_other/user_allow_other/' /etc/fuse.conf
 echo "**** cleanup ****" && \
 rm -rf \
	/tmp/*
