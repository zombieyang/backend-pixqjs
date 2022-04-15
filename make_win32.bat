mkdir build32 & pushd build32
cmake -S ..\CMakeLists.txt -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON -G "Visual Studio 16 2019" -A Win32 ..
popd
cmake --build build32 --config Release
pause

mkdir qjs\pixqjs\Lib\Win32\
copy build32\Release\v8qjs.lib qjs\pixqjs\Lib\Win32\
xcopy library\Win32\ qjs\pixqjs\Lib\Win32\ /S
xcopy include qjs\pixqjs\Inc /S