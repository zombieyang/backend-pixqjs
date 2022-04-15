rm -rf build_osx
mkdir -p build_osx
cd build_osx
cmake ..
cmake --build . --config Release

cd ..
mkdir -p qjs/pixqjs/Lib/macOS/
cp build_osx/libv8qjs.a qjs/pixqjs/Lib/macOS
cp library/macOS/*.dylib qjs/pixqjs/Lib/macOS/
mkdir -p qjs/pixqjs/Inc/
cp -r include/* qjs/pixqjs/Inc/