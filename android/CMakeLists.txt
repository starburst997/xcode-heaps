# For more information about using CMake with Android Studio, read the
# documentation: https://d.android.com/studio/projects/add-native-code.html

# Sets the minimum version of CMake required to build the native library.

cmake_minimum_required(VERSION 3.4.1)

find_package(Threads)

set(CMAKE_ANDROID_STL_TYPE c++_shared)
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fPIC -Wno-tentative-definition-incomplete-type")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC -Wall -Wno-long-long -pedantic -pthread -Wno-tentative-definition-incomplete-type")
set(CMAKE_LD_FLAGS "${CMAKE_LD_FLAGS} -fPIC -std=c++11 -Wl --no-warn-shared-textrel -pthread")
set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -Wall -v -Wl,--no-warn-shared-textrel")

# Set all the folder where we can find each of the needed sources and headers

set(BASE_NATIVE_PATH src/main/cpp)
set(LIBS_INCLUDE_PATH ${BASE_NATIVE_PATH}/include)
set(LIBS_LIBRARY_PATH ${BASE_NATIVE_PATH}/libs)
set(LIBS_SOURCE_PATH ${BASE_NATIVE_PATH}/src)
set(FULL_LIBS_LIBRARY_PATH ${CMAKE_CURRENT_LIST_DIR}/${LIBS_LIBRARY_PATH})

# PCRE options
set(PCRE_BUILD_PCRE8 OFF CACHE BOOL "")
set(PCRE_BUILD_PCRE16 ON CACHE BOOL "")
set(PCRE_BUILD_PCRE32 OFF CACHE BOOL "")
set(PCRE_BUILD_PCREGREP OFF CACHE BOOL "")
set(PCRE_BUILD_TESTS OFF CACHE BOOL "")
# end PCRE options

add_subdirectory(${LIBS_LIBRARY_PATH}/libogg)
add_subdirectory(${LIBS_LIBRARY_PATH}/libvorbis)
add_subdirectory(${LIBS_LIBRARY_PATH}/OpenAlSoft)
add_subdirectory(${LIBS_LIBRARY_PATH}/pcre)

# required modules for our task
include(CheckIncludeFile)
include(CheckIncludeFileCXX)
include(CheckIncludeFiles)
include(ExternalProject)

if(EXISTS ${FULL_LIBS_LIBRARY_PATH}/SDL2)
add_library(libSDL2 SHARED IMPORTED)
set_target_properties(libSDL2 PROPERTIES IMPORTED_LOCATION ${FULL_LIBS_LIBRARY_PATH}/SDL2/${ANDROID_ABI}/libSDL2.so)
add_library(libmain SHARED IMPORTED)
set_target_properties(libmain PROPERTIES IMPORTED_LOCATION ${FULL_LIBS_LIBRARY_PATH}/SDL2/${ANDROID_ABI}/libSDL2main.so)
else (EXISTS ${FULL_LIBS_LIBRARY_PATH}/SDL2)
message(WARNING "libSDL2 has no library, add them in " ${FULL_LIBS_LIBRARY_PATH}/SDL2 " and retry")
endif (EXISTS ${FULL_LIBS_LIBRARY_PATH}/SDL2)

if(EXISTS ${FULL_LIBS_LIBRARY_PATH}/turbojpeg)
add_library(turbojpeg STATIC IMPORTED)
set_target_properties(turbojpeg PROPERTIES IMPORTED_LOCATION ${FULL_LIBS_LIBRARY_PATH}/turbojpeg/${ANDROID_ABI}/libjpeg-turbo.a)
else (EXISTS ${FULL_LIBS_LIBRARY_PATH}/turbojpeg)
message(WARNING "turbojpeg has no library, add it in " ${FULL_LIBS_LIBRARY_PATH}/turbojpeg " and retry")
endif (EXISTS ${FULL_LIBS_LIBRARY_PATH}/turbojpeg)

if(EXISTS ${FULL_LIBS_LIBRARY_PATH}/libpng/obj)
add_library(libpng STATIC IMPORTED)
set_target_properties(libpng PROPERTIES IMPORTED_LOCATION ${FULL_LIBS_LIBRARY_PATH}/libpng/obj/local/${ANDROID_ABI}/libpng.a)
else (EXISTS ${FULL_LIBS_LIBRARY_PATH}/libpng/obj)
message(WARNING "libpng has no library, execute build.sh in " ${FULL_LIBS_LIBRARY_PATH}/libpng " and retry")
endif (EXISTS ${FULL_LIBS_LIBRARY_PATH}/libpng/obj)

# Add all the headers in the include
set(H_SOURCES ${LIBS_SOURCE_PATH})
set(H_LIBRARY ${LIBS_LIBRARY_PATH})
set(H_INCLUDE
  # Includes from embedded projects
  ${LIBS_LIBRARY_PATH}/libogg/include
  ${LIBS_LIBRARY_PATH}/libvorbis/include
  ${LIBS_LIBRARY_PATH}/OpenAlSoft/include
  ${LIBS_LIBRARY_PATH}/pcre
  
  # Need to copy SDL2 headers there
  ${LIBS_INCLUDE_PATH}/SDL2
  )

include_directories(
  ${H_INCLUDE}
  ${H_SOURCES}
  ${H_LIBRARY}
  )

# Find all the sources and headers in src
FILE(GLOB_RECURSE C_SOURCES ${LIBS_SOURCE_PATH}/*.c)

# List all the sources and headers in libs

set(
  C_LIBRARY 
  ${LIBS_LIBRARY_PATH}/fmt/fmt.c
  ${LIBS_LIBRARY_PATH}/fmt/sha1.c
  ${LIBS_LIBRARY_PATH}/openal/openal.c
  ${LIBS_LIBRARY_PATH}/sdl/sdl.c
  ${LIBS_LIBRARY_PATH}/sdl/gl.c
  )

set(C_LIST 
  ${C_SOURCES}
  ${C_LIBRARY}
  )

FILE(GLOB_RECURSE 
  H_LIST 
  ${BASE_NATIVE_PATH}/*.h
  )

# Add all the sources and headers in the native library

add_library( # Sets the name of the library.
             native-lib

             # Sets the library as a shared library.
             SHARED

             # Provides a relative path to your source file(s).
             ${BASE_NATIVE_PATH}/native-lib.c
             ${C_LIST}

)

# Specifies libraries CMake should link to your target library. You
# can link multiple libraries, such as libraries you define in this
# build script, prebuilt third-party libraries, or system libraries.

target_link_libraries(
                        native-lib
                        android
                        c
                        log
                        Threads::Threads
                        OpenSLES
                        z
                        GLESv1_CM
                        GLESv2
                        EGL
                        dl
                        pcre16
                        turbojpeg
                        ogg
                        vorbis
                        vorbisfile
                        OpenAL
                        libSDL2
                        libpng

)