mkdir build64 & pushd build64
cmake -S ..\CMakeLists.txt -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON -G "Visual Studio 16 2019" -A x64 ..
popd
cmake --build build64 --config Release
pause

mkdir qjs/pixqjs/Lib/Win64/
copy build64/Release/v8qjs.lib qjs/pixqjs/Lib/Win64/
copy library/Win64/quickjs.lib qjs/pixqjs/Lib/Win64/