LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
LOCAL_MODULE := diRW_test

LOCAL_CFLAGS := -fvisibility=hidden
LOCAL_CPPFLAGS := -std=c++17
LOCAL_CPPFLAGS += -fvisibility=hidden


#引入头文件到全局#
LOCAL_C_INCLUDES := $(LOCAL_PATH)/diRW

LOCAL_SRC_FILES := example.cpp
    


LOCAL_LDLIBS := -llog -landroid -lEGL -lGLESv3
include $(BUILD_EXECUTABLE) #可执行文件
