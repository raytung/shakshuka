#!/bin/bash

set -euo pipefail

cd "$(dirname "$0")/../"

DIR="shk-${SHK_VERSION}-${TARGET}"

if [ -d "${DIR}" ]; then
  echo "--- Directory ${DIR} already exist. Removing before we start"
  rm --recursive --force "${DIR}"
fi

mkdir -p "${DIR}"

cargo install cross

echo "--- Running cross compilation"
cross build --release --target "${TARGET}"

if [ "${BUILD}" == 'linux' ] || [ "${BUILD}" == "macos" ]; then
  echo "--- Stripping x86 binary"
  strip "target/${TARGET}/release/shk"
fi

if [ "${BUILD}" == 'linux-arm' ]; then
    echo "--- Stripping ARM binary"

    docker run \
      --rm \
      --volume "${PWD}/target:/target:Z" \
      rustembedded/cross:arm-unknown-linux-gnueabihf \
      arm-linux-gnueabihf-strip \
      /target/arm-unknown-linux-gnueabihf/release/shk
fi

cp "target/${TARGET}/release/shk" "${DIR}"

echo "--- Creating archive"
tar --create --gzip --file "${DIR}.tar.gz" "${DIR}"

echo "::set-output name=ARTIFACT::${DIR}.tar.gz"