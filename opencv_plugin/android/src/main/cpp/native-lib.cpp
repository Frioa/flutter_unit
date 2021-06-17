#include <jni.h>
#include <string>
#include<opencv2/opencv.hpp>
#include <stdint.h>
// #include <android/log.h>

#define ATTRIBUTES extern "C" __attribute__((visibility("default"))) __attribute__((used))

#define DEBUG_NATIVE true

using namespace cv;

struct MyMat {
    int flags;
    //! the matrix dimensionality, >= 2
    int dims;
    //! the number of rows and columns or (-1, -1) when the matrix has more than 2 dimensions
    int rows, cols;
    //! pointer to the data
    uchar *data;
};

extern "C" __attribute__((visibility("default"))) __attribute__((used))
int32_t native_add(int32_t x, int32_t y) {
    return x + y;
}

ATTRIBUTES
MyMat mat() {
    cv::Mat mat = cv::Mat();
    MyMat myMat = MyMat();
    myMat.flags = mat.flags;
    myMat.rows = mat.rows;
    myMat.cols = mat.cols;
    myMat.data = mat.data;
    return myMat;
}


ATTRIBUTES void opencv_blur(
        int8_t *imgMat,
        int32_t *imgLengthBytes,
        int32_t kernelSize) {

    Mat *src = (Mat *) imgMat;
//    __android_log_print(ANDROID_LOG_VERBOSE, "NATIVE",
//                        "opencv_blur()  kernelSize:%d", kernelSize);

    for (int i = 0 ; i < 100 ; i++) {
//        __android_log_print(ANDROID_LOG_VERBOSE, "NATIVE",
//                            "opencv_blur()  imgMat:%d", imgMat[i]);
    }

    if (src == nullptr || src->data == nullptr)
        return ;

   //  if (DEBUG_NATIVE)
//        __android_log_print(ANDROID_LOG_VERBOSE, "NATIVE",
//                            "opencv_blur() ---  len:%d  width:%d   height:%d",
//                            src->step[0] * src->rows, src->cols, src->rows);

    Mat dst1 = cv::Mat();

    blur(*src, dst1, Size(kernelSize, kernelSize), Point(-1, -1));

    std::vector<uchar> buf(1); // imencode() will resize it
//    Encoding with b       mp : 20-40ms
//    Encoding with jpg : 50-70 ms
//    Encoding with png: 200-250ms
    cv::imencode(".bmp", dst1, buf);
    if (DEBUG_NATIVE)
//        __android_log_print(ANDROID_LOG_VERBOSE, "NATIVE",
//                            "opencv_blur()  resulting image  length:%d   %d x %d", buf.size(),
//                            dst.cols, dst.rows);

    *imgLengthBytes = buf.size();

    // the return value may be freed by GC before dart receive it??
    // Sometimes in Dart, ImgProc.computeSync() receives all zeros while here buf.data() is filled correctly
    // Returning a new allocated memory.
    // Note: remember to free() the Pointer<> in Dart!
    unsigned char *ret = (unsigned char *) malloc(buf.size());
    memcpy(ret, buf.data(), buf.size());
    return ;
//    return buf.data();
}