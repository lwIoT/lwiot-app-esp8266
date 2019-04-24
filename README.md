# ESP8266 project skeleton

This project skeleton wraps CMake around the default build system provided by the
ESP8266 IDF. In order to use this skeleton the following applications / SDK's need to be
installed:

- ESP8266 compiler
- ESP8266 IDF
- ESP8266 lwIoT port

The skeleton expects these packages in the `/opt` directory by default:

- Compiler in `/opt/xtensa-esp32-elf`
- IDF in `/opt/esp32-idf`

The following configuration options are available:

- ESP8266_IDF_PATH > Path to ESP8266 IDF
- ESP8266_TOOLCHAIN_PATH > Path to the ESP8266 toolchain

In order to successfully build the application, the following CMake options are required to be set:

- LWIOT_INSTALL_PATH > Path to lwIoT installation
- APP_PATH > Path from build location to application directory
- CMAKE_TOOLCHAIN_FILE > Toolchain file
- CMAKE_BUILD_TYPE > CMake build configuration
- CMAKE_C_COMPILER > Should be set to xtensa-esp32-elf-gcc
- CMAKE_CXX_COMPILER > Should be set to xtensa-esp32-elf-g++

Please note that the build location should be `PROJECT_BUILD_DIR/cmake-${CMAKE_BUILD_TYPE}`.

## Setup

The setup.py script should be run before before compiling. This script copies a lwIoT compatible
configuration file into the working directory.

## Tutorial

```bash
$ python setup.py -s [lwIoT path]
$ make menuconfig
$ mkdir -p build/cmake
$ cd build/cmake
$ cmake -DLWIOT_INSTALL_PATH=/opt/lwiot/esp8266 -DESP8266_IDF_PATH=/opt/lx106-idf \
-DESP8266_TOOLCHAIN_PATH=/opt/xtensa-lx106-elf -DCMAKE_TOOLCHAIN_FILE=../../cmake/esp8266.cmake \
-DCMAKE_C_COMPILER=xtensa-lx106-elf-gcc -DCMAKE_CXX_COMPILER=xtensa-esp32-elf-g++
$ make
$ cd ../..
$ make
```
