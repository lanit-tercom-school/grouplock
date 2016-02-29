#include <jni.h>
#include "Pair.h"
#include "Poly.h"

JNIEXPORT jstring JNICALL
Java_com_example_sonya_grouplockapplication_ChooseToDoActivity_firstJNI(JNIEnv *env,
                                                                        jobject instance) {

    // TODO
    Pair<int,int> t (3,4);

    return env->NewStringUTF("Hello From Jni");
}