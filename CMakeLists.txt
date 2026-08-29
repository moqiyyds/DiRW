# diRW — CMake 构建（与同目录 Android.mk 等价）
#
# 命令行构建（NDK r19+，在项目根目录执行）：
#   cmake -B build jni \
#     -DCMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake \
#     -DANDROID_ABI=arm64-v8a \
#     -DANDROID_PLATFORM=android-26 \
#     -DCMAKE_BUILD_TYPE=Release
#   cmake --build build
#
# Android Studio 的 build.gradle 里也可以直接引用：
#   externalNativeBuild { cmake { path "jni/CMakeLists.txt" } }
#   defaultConfig { externalNativeBuild { cmake { arguments "-DANDROID_STL=c++_static" } } }

cmake_minimum_required(VERSION 3.22.1)
project(diRW LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# header-only 库：业务代码链接它即可使用全部后端
add_library(diRW INTERFACE)
target_include_directories(diRW INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}/diRW)
target_compile_features(diRW INTERFACE cxx_std_17)

# 演示程序（对应 Android.mk 的 diRW_test）
add_executable(diRW_test example.cpp)
target_link_libraries(diRW_test PRIVATE diRW)
target_compile_options(diRW_test PRIVATE -fvisibility=hidden)

if(ANDROID)
    # 对应 LOCAL_LDLIBS
    # STL: c++_static 是 NDK CMake 的默认值（对应 Application.mk 的 APP_STL），
    # 如需显式指定请在命令行加 -DANDROID_STL=c++_static（toolchain 加载时读取，此处 set 无效）
    target_link_libraries(diRW_test PRIVATE log android EGL GLESv3)
endif()
