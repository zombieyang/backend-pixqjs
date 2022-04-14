mkdir build64 & pushd build64
cmake -S ..\CMakeLists.txt -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON -G "Visual Studio 16 2019" -A x64 ..
popd
cmake --build build64 --config Debug
pause
