#!/bin/bash

# Remove -lunwind from arguments
args=()
skip_next=false
for arg in "$@"; do
    if [ "$skip_next" = true ]; then
        skip_next=false
        continue
    fi
    if [ "$arg" = "-lunwind" ]; then
        continue
    fi
    args+=("$arg")
done

TARGET=${TARGET:-aarch64-linux-android}
NDK_TARGET=${TARGET/armv7-/armv7a-}

# Call the real linker and provide unwind through compiler-rt
exec $ANDROID_SDK_ROOT/ndk-bundle/toolchains/llvm/prebuilt/linux-x86_64/bin/${NDK_TARGET}21-clang "${args[@]}" -lgcc
