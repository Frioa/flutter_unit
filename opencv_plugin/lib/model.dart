import 'dart:ffi';


// class UMatData extends Struct {
//
// }

class Mat extends Struct {
  @Int32()
  external int flags;

  @Int32()
  external int dims;

  @Int32()
  external int rows;

  @Int32()
  external int cols;

  external Pointer<Uint8> data;

  @override
  String toString() {
    return 'Mat{flags: $flags, dims: $dims, rows: $rows, cols: $cols}';
  }
//

  //
  // external Pointer<Uint8> datastart;
  // external Pointer<Uint8> dataend;
  // external Pointer<Uint8> datalimit;


}


// /*! includes several bit-fields:
//          - the magic signature
//          - continuity flag
//          - depth
//          - number of channels
//      */
// int flags;
// //! the matrix dimensionality, >= 2
// int dims;
// //! the number of rows and columns or (-1, -1) when the matrix has more than 2 dimensions
// int rows, cols;
// //! pointer to the data
// uchar* data;
//
// //! helper fields used in locateROI and adjustROI
// const uchar* datastart;
// const uchar* dataend;
// const uchar* datalimit;
//
// //! custom allocator
// MatAllocator* allocator;
// //! and the standard allocator
// static MatAllocator* getStdAllocator();
// static MatAllocator* getDefaultAllocator();
// static void setDefaultAllocator(MatAllocator* allocator);
//
// //! internal use method: updates the continuity flag
// void updateContinuityFlag();
//
// //! interaction with UMat
// UMatData* u;
//
// MatSize size;
// MatStep step;
