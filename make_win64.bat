mkdir build64 & pushd build64
cmake -S ..\CMakeLists.txt -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON -G "Visual Studio 16 2019" -A x64 ..
popd
cmake --build build64 --config Release
pause

mkdir qjs\pixqjs\Lib\Win64\
mkdir qjs\pixqjs\Inc
copy build64\Release\v8qjs.lib qjs\pixqjs\Lib\Win64\
xcopy library\Win64\ qjs\pixqjs\Lib\Win64\ /S
xcopy include qjs\pixqjs\Inc /S