if [ -n "$ANDROID_NDK" ]; then
    export NDK=${ANDROID_NDK}
elif [ -n "$ANDROID_NDK_HOME" ]; then
    export NDK=${ANDROID_NDK_HOME}
else
    export NDK=~/android-ndk-r21b
fi

if [ ! -d "$NDK" ]; then
    echo "Please set ANDROID_NDK environment to the root of NDK."
    exit 1
fi

function build() {
    API=$1
    ABI=$2
    TOOLCHAIN_ANME=$3
    BUILD_PATH=build.Android.${ABI}
    cmake -H. -B${BUILD_PATH} -DANDROID_ABI=${ABI} -DCMAKE_TOOLCHAIN_FILE=${NDK}/build/cmake/android.toolchain.cmake -DANDROID_NATIVE_API_LEVEL=${API} -DANDROID_TOOLCHAIN=clang -DANDROID_TOOLCHAIN_NAME=${TOOLCHAIN_ANME}
    cmake --build ${BUILD_PATH} --config Release
    # mkdir -p ~/qjs/quickjs/Lib/Android/${ABI}/
    # cp ${BUILD_PATH}/libquickjs.a ~/qjs/quickjs/Lib/Android/${ABI}/libquickjs.a
}

build android-18 armeabi-v7a arm-linux-androideabi-4.9
build android-18 arm64-v8a  arm-linux-androideabi-clang
build android-18 x86 x86-4.9

mkdir -p qjs/pixqjs/Lib/Android/arm64-v8a/
mkdir -p qjs/pixqjs/Lib/Android/armeabi-v7a/
mkdir -p qjs/pixqjs/Lib/Android/x86/
cp build.Android.arm64-v8a/libv8qjs.a qjs/pixqjs/Lib/Android/arm64-v8a/
cp library/Android/arm64-v8a/*.so qjs/pixqjs/Lib/Android/arm64-v8a/
cp build.Android.armeabi-v7a/libv8qjs.a qjs/pixqjs/Lib/Android/armeabi-v7a/
cp library/Android/armeabi-v7a/*.so qjs/pixqjs/Lib/Android/armeabi-v7a/
cp build.Android.x86/libv8qjs.a qjs/pixqjs/Lib/Android/x86/