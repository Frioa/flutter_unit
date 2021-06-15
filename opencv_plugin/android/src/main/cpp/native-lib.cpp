#include <jni.h>
#include <string>

extern "C" JNIEXPORT jstring

JNICALL
Java_com_wyt_one_MainActivity_myNativeMethod(
        JNIEnv *env,
        jobject /* this */) {
    return env->NewStringUTF("myNativeMethod 执行了");
}