#!/bin/bash

if [[ -z $ANDROID_SDK_ROOT ]]; then
	echo Android SDK not found!
	exit
fi

TARGET=${TARGET:-aarch64-linux-android}
TARGET_ENV=${TARGET^^}
TARGET_ENV=${TARGET_ENV//-/_}
NDK_TARGET=${TARGET/armv7-/armv7a-}

export CARGO_TARGET_${TARGET_ENV}_LINKER=$PWD/linker-wrapper.sh
export RUSTFLAGS="-C link-arg=-Wl,-rpath=/data/data/com.termux/files/usr/lib -C link-arg=-Wl,--enable-new-dtags"

# Build only okc-ssh-agent (okc-gpg disabled for now)
cargo build --target=$TARGET --bin okc-ssh-agent $@
