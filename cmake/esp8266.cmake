#
# ESP8266 application build file.
#

SET(CMAKE_SYSTEM_NAME Generic)

if(${CMAKE_VERSION} VERSION_GREATER_EQUAL "3.6.0")
    set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
else()
	include(CMakeForceCompiler)

	set(XTENSA_GCC_COMPILER "xtensa-lx106-elf-gcc${CMAKE_EXECUTABLE_SUFFIX}")
	set(XTENSA_GXX_COMPILER "xtensa-lx106-elf-g++${CMAKE_EXECUTABLE_SUFFIX}")
	cmake_force_c_compiler(xtensa-lx106-elf-gcc GNU)
	cmake_force_cxx_compiler(xtensa-lx106-elf-g++ GNU)
endif()

set(HAVE_BIG_ENDIAN False)

if(NOT DEFINED ESP8266_TOOLCHAIN_PATH)
    # Set default path.
    set(ESP8266_TOOLCHAIN_PATH /opt/xtensa-lx106-elf)
	SET(CMAKE_FIND_ROOT_PATH  /opt/xtensa-lx106-elf)
    message(STATUS "GCC not found, default path will be used: ${ESP8266_TOOLCHAIN_PATH}")
else()
    message(STATUS "Toolchain path: ${ESP8266_TOOLCHAIN_PATH}")
	SET(CMAKE_FIND_ROOT_PATH ${ESP8266_TOOLCHAIN_PATH})
endif()


SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

#########################
##  ESP8266 SDK setup  ##
#########################

if(NOT DEFINED ESP8266_IDF_PATH)
    set(ESP8266_IDF_PATH /opt/esp8266-idf)
    message(STATUS "Default SDK location will be used: ${ESP8266_IDF_PATH}")
else()
    message(STATUS "ESP8266 SDK path: ${ESP8266_IDF_PATH}")
endif()

set(CMAKE_OBJCOPY ${ESP8266_TOOLCHAIN_PATH}/bin/xtensa-lx106-elf-objcopy CACHE PATH "")

SET(ESP8266_INCLUDE_DIRECTORIES
	${LWIOT_INSTALL_PATH}/include
	${LWIOT_INSTALL_PATH}/config
	
	${ESP8266_IDF_PATH}/components/app_update/include
	${ESP8266_IDF_PATH}/components/esp-tls
	${ESP8266_IDF_PATH}/components/esp8266/include
	${ESP8266_IDF_PATH}/components/esp_ringbuf/include
	${ESP8266_IDF_PATH}/components/esp_ringbuf/include/freertos
	${ESP8266_IDF_PATH}/components/freertos/include
	${ESP8266_IDF_PATH}/components/freertos/include
	${ESP8266_IDF_PATH}/components/freertos/include/freertos
	${ESP8266_IDF_PATH}/components/freertos/include/freertos/private
	${ESP8266_IDF_PATH}/components/freertos/port/esp8266/include
	${ESP8266_IDF_PATH}/components/freertos/port/esp8266/include/freertos
	${ESP8266_IDF_PATH}/components/heap/include
	${ESP8266_IDF_PATH}/components/heap/port/esp8266/include
	${ESP8266_IDF_PATH}/components/log/include
	${ESP8266_IDF_PATH}/components/lwip/include
	${ESP8266_IDF_PATH}/components/lwip/include/lwip/apps
	${ESP8266_IDF_PATH}/components/lwip/include/lwip
	${ESP8266_IDF_PATH}/components/lwip/lwip/src/include
	${ESP8266_IDF_PATH}/components/lwip/lwip/src/include/posix
	${ESP8266_IDF_PATH}/components/lwip/port/esp8266/include
	${ESP8266_IDF_PATH}/components/lwip/port/esp8266/include/port

	${ESP8266_IDF_PATH}/components/newlib/newlib/port/include
	${ESP8266_IDF_PATH}/components/nvs_flash/include
	${ESP8266_IDF_PATH}/components/protobuf-c/protobuf-c
	${ESP8266_IDF_PATH}/components/pthread/include
	${ESP8266_IDF_PATH}/components/smartconfig_ack/include
	${ESP8266_IDF_PATH}/components/spi_flash/include
	${ESP8266_IDF_PATH}/components/spi_ram/include
	${ESP8266_IDF_PATH}/components/spiffs/include
	${ESP8266_IDF_PATH}/components/spiffs/include/spiffs
	${ESP8266_IDF_PATH}/components/ssl/include
	${ESP8266_IDF_PATH}/components/ssl/mbedtls/mbedtls/include
	${ESP8266_IDF_PATH}/components/ssl/mbedtls/port/esp8266/include
	${ESP8266_IDF_PATH}/components/ssl/mbedtls/port/openssl/include
	${ESP8266_IDF_PATH}/components/tcp_transport/include
	${ESP8266_IDF_PATH}/components/tcpip_adapter/include
	${ESP8266_IDF_PATH}/components/tcpip_adapter/include
	${ESP8266_IDF_PATH}/components/util/include
	${ESP8266_IDF_PATH}/components/vfs/include
	${ESP8266_IDF_PATH}/components/wpa_supplicant/include
	${ESP8266_IDF_PATH}/components/wpa_supplicant/port/include
	
	${PROJECT_SOURCE_DIR}/build/include
)

if(RTTI)
SET(PORT_CXX_FLAGS 
	"-ffunction-sections -fdata-sections -fstrict-volatile-bitfields -mlongcalls -nostdlib -fstack-protector \
	-Werror=all	-Wno-error=unused-function -Wno-error=unused-but-set-variable -Wno-error=unused-variable \
	-Wno-error=deprecated-declarations -Wextra -Wno-unused-parameter -Wno-sign-compare \
	-DWITH_POSIX -D__ESP_FILE__=__FILE__"
)

else()
SET(PORT_CXX_FLAGS 
	"-fno-rtti -ffunction-sections -fdata-sections -fstrict-volatile-bitfields -mlongcalls -nostdlib -fstack-protector \
	-Werror=all	-Wno-error=unused-function -Wno-error=unused-but-set-variable -Wno-error=unused-variable \
	-Wno-error=deprecated-declarations -Wextra -Wno-unused-parameter -Wno-sign-compare -fno-exceptions \
	-DWITH_POSIX -D__ESP_FILE__=__FILE__"
)
endif()

SET(PORT_C_FLAGS 
	"-ffunction-sections -fdata-sections -fstrict-volatile-bitfields -mlongcalls -nostdlib -fstack-protector \
	-Werror=all	-Wno-error=unused-function -Wno-error=unused-but-set-variable -Wno-error=unused-variable \
	-Wno-error=deprecated-declarations -Wextra -Wno-unused-parameter -Wno-sign-compare \
	-DWITH_POSIX -D__ESP_FILE__=__FILE__"
)

SET(RTTI False CACHE BOOL "Enable/disable runtime type identification.")
