#!/bin/bash

if [[ -z $ANDROID_SDK_ROOT ]]; then
	echo Android SDK not found!
	exit
fi

TARGET=${TARGET:-aarch64-linux-android}
TARGET_ENV=${TARGET^^}
TARGET_ENV=${TARGET_ENV//-/_}
TARGET_ENV_LOWER=${TARGET//-/_}
NDK_TARGET=${TARGET/armv7-/armv7a-}

export RUSTFLAGS="-C link-arg=-Wl,-rpath=/data/data/com.termux/files/usr/lib -C link-arg=-Wl,--enable-new-dtags"
export CC_${TARGET_ENV_LOWER}=$ANDROID_SDK_ROOT/ndk-bundle/toolchains/llvm/prebuilt/linux-x86_64/bin/${NDK_TARGET}21-clang
export AR_${TARGET_ENV_LOWER}=$ANDROID_SDK_ROOT/ndk-bundle/toolchains/llvm/prebuilt/linux-x86_64/bin/${TARGET}-ar
export CARGO_TARGET_${TARGET_ENV}_LINKER=$PWD/linker-wrapper.sh

# Build only okc-ssh-agent (okc-gpg disabled for now)
cargo build --target=$TARGET --bin okc-ssh-agent $@
