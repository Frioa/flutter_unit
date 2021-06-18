#include <string>
#include <opencv2/opencv.hpp>
#include <android/log.h>

#define ATTRIBUTES extern "C" __attribute__((visibility("default"))) __attribute__((used))

#define DEBUG_NATIVE true

using namespace cv;

ATTRIBUTES
void hello() {
    __android_log_print(ANDROID_LOG_VERBOSE, "NATIVE",
                        "hello world ");
}

ATTRIBUTES
int32_t *multiply(int32_t *a, int32_t b)
{
    // Allocates native memory in C.
    int *mult = (int *)malloc(sizeof(int));
    *mult = *a * b;

    __android_log_print(ANDROID_LOG_VERBOSE, "NATIVE",
                        "multiply() ---mult:  mult:%d  *mult:%d   &mult:%d",
                        mult, *mult, &mult);
    return mult;
}

ATTRIBUTES
int32_t native_add(int32_t x, int32_t y) {
    return x + y;
}

ATTRIBUTES Mat *opencv_decodeImage(
        unsigned char *img,
        int32_t *imgLengthBytes) {

    Mat *src = new Mat();
    std::vector<unsigned char> m;

    __android_log_print(ANDROID_LOG_VERBOSE, "NATIVE",
                        "opencv_decodeImage() ---  start imgLengthBytes:%d ",
                        *imgLengthBytes);

    for (int32_t a = *imgLengthBytes; a >= 0; a--) m.push_back(*(img++));

    *src = imdecode(m, cv::IMREAD_COLOR);
    if (src->data == nullptr)
        return nullptr;

    if (DEBUG_NATIVE)
        __android_log_print(ANDROID_LOG_VERBOSE, "NATIVE",
                            "opencv_decodeImage() ---  len before:%d  len after:%d  width:%d  height:%d",
                            *imgLengthBytes, src->step[0] * src->rows,
                            src->cols, src->rows);

    *imgLengthBytes = src->step[0] * src->rows;
    return src;
}

ATTRIBUTES
unsigned char *opencv_blur(
        uint8_t *imgMat,
        int32_t *imgLengthBytes,
        int32_t kernelSize) {

    Mat *src = opencv_decodeImage(imgMat, imgLengthBytes);

    if (src == nullptr || src->data == nullptr)
        return nullptr;

    if (DEBUG_NATIVE) {
        __android_log_print(ANDROID_LOG_VERBOSE, "NATIVE",
                            "opencv_blur() ---  width:%d   height:%d",
                            src->cols, src->rows);

        __android_log_print(ANDROID_LOG_VERBOSE, "NATIVE",
                            "opencv_blur() ---  len:%d ",
                            src->step[0] * src->rows);
    }


    GaussianBlur(*src, *src, Size(kernelSize, kernelSize), 15, 0, 4);
    std::vector<uchar> buf(1); // imencode() will resize it
//    Encoding with b       mp : 20-40ms
//    Encoding with jpg : 50-70 ms
//    Encoding with png: 200-250ms
    imencode(".png", *src, buf);

    if (DEBUG_NATIVE) {
        __android_log_print(ANDROID_LOG_VERBOSE, "NATIVE",
                            "opencv_blur()  resulting image  length:%d   %d x %d", buf.size(),
                            src->cols, src->rows);
    }

    *imgLengthBytes = buf.size();

    // the return value may be freed by GC before dart receive it??
    // Sometimes in Dart, ImgProc.computeSync() receives all zeros while here buf.data() is filled correctly
    // Returning a new allocated memory.
    // Note: remember to free() the Pointer<> in Dart!

//    unsigned char *ret = (unsigned char *) malloc(buf.size());
//    memcpy(ret, buf.data(), buf.size());
    return buf.data();
}


