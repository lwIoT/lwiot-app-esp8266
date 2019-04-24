#
# "main" pseudo-component makefile.
#
# (Uses default behaviour of compiling all source files in directory, adding 'include' to include path.)

LWIOT_INSTALL_DIR ?= /opt/lwiot/esp8266
CMAKE_DIR = $(COMPONENT_PATH)/../build/cmake

COMPONENT_ADD_LDFLAGS += -L$(CMAKE_DIR) -L$(LWIOT_INSTALL_DIR)/lib -lapp -llwiot -llwiot-platform
#COMPONENT_ADD_LDFLAGS += -L$(CMAKE_DIR) -L$(LWIOT_INSTALL_DIR)/lib -llwiot -llwiot-platform -fstack-protector
