#include <jni.h>
#include <string>
#include<opencv2/opencv.hpp>
#include <stdint.h>

using namespace cv;

struct MyMat {
    int flags;
    //! the matrix dimensionality, >= 2
    int dims;
    //! the number of rows and columns or (-1, -1) when the matrix has more than 2 dimensions
    int rows, cols;
    //! pointer to the data
    uchar* data;
};

extern "C" __attribute__((visibility("default"))) __attribute__((used))
int32_t native_add(int32_t x, int32_t y) {
    return x + y;
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
MyMat mat() {
    cv::Mat mat = cv::imread();
    MyMat myMat = MyMat();
    myMat.flags = mat.flags;
    myMat.rows = mat.rows;
    myMat.cols = mat.cols;
    myMat.data = mat.data;
    return myMat;
}
