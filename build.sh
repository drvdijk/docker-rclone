#!/bin/bash

REPO_NAME=radpenguin/rclone

BUILD_DATE=$( date +"%Y-%m-%d-%H-%M-%S" )
VERSION=$( curl --silent https://rclone.org/downloads/ | grep "Rclone Download" | sed -e 's/^.*Rclone Download v//' )

echo "Building $REPO_NAME version $VERSION, build date $BUILD_DATE"
echo -n "Continue? (y/N) "
read X
if [[ "$X" != "y" ]]; then
  echo "Exiting..."
  exit 1
fi

docker build \
  --no-cache \
  --build-arg=BUILD_DATE="$BUILD_DATE" \
  --build-arg=VERSION="$VERSION" \
  --tag=$REPO_NAME \
  .

docker push $REPO_NAME
