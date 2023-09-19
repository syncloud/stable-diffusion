#!/bin/sh -ex

DIR=$( cd "$( dirname "$0" )" && pwd )
cd ${DIR}
VERSION=$1
BUILD_DIR=${DIR}/../build/snap/stable-diffusion
while ! docker create --name=stable-diffusion stable-diffusion/stable-diffusion:$VERSION ; do
  sleep 1
  echo "retry docker"
done
mkdir -p ${BUILD_DIR}
cd ${BUILD_DIR}
docker export stable-diffusion -o app.tar
tar xf app.tar
rm -rf app.tar
cp ${DIR}/stable-diffusion-develop/stable-diffusion ${BUILD_DIR}/opt/stable-diffusion/bin/stable-diffusion
cp ${DIR}/stable-diffusion.sh ${BUILD_DIR}/bin/
