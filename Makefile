#
# This is a project Makefile. It is assumed the directory this Makefile resides in is a
# project subdirectory.
#

PROJECT_NAME := esp8266-app

LWIOT_INSTALL_DIR ?= /opt/lwiot/esp8266
IDF_PATH ?= $(ESP8266_IDF_PATH)
export IDF_PATH

EXTRA_CFLAGS = -I$(LWIOT_INSTALL_DIR)/include
EXTRA_CXXFLAGS = $(EXTRA_CFLAGS) -std=gnu++14

include $(IDF_PATH)/make/project.mk

