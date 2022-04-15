rm -rf build_ios
mkdir -p build_ios && cd build_ios
cd build_ios
cmake -DCMAKE_TOOLCHAIN_FILE=../cmake/ios.toolchain.cmake -DPLATFORM=OS64 -GXcode ..
cmake --build . --config Release

mkdir -p qjs/pixqjs/Lib/iOS/arm64/
cp build_ios/Release-iphoneos/libv8qjs.a qjs/pixqjs/Lib/iOS/arm64