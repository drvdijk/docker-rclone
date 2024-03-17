# Begin final image
FROM alpine:latest

RUN apk --no-cache add ca-certificates fuse3 tzdata && \
  echo "user_allow_other" >> /etc/fuse.conf

RUN wget https://beta.rclone.org/branch/fix-7673-dir-wrapping/v1.67.0-beta.7775.8cb7f28f8.fix-7673-dir-wrapping/rclone-v1.67.0-beta.7775.8cb7f28f8.fix-7673-dir-wrapping-linux-amd64.zip && \
    unzip rclone-v1.67.0-beta.7775.8cb7f28f8.fix-7673-dir-wrapping-linux-amd64.zip && \
    cp rclone-v1.67.0-beta.7775.8cb7f28f8.fix-7673-dir-wrapping-linux-amd64/rclone /usr/local/bin/ && \
    rm -rf rclone-v1.67.0-beta.7775.8cb7f28f8.fix-7673-dir-wrapping-linux-amd64*
#COPY --from=builder /go/src/github.com/rclone/rclone/rclone /usr/local/bin/

RUN addgroup -g 1009 rclone && adduser -u 1009 -Ds /bin/sh -G rclone rclone

ENTRYPOINT [ "rclone" ]

WORKDIR /data
ENV XDG_CONFIG_HOME=/config