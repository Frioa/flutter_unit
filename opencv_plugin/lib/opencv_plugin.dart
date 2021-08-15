import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:flutter/services.dart';

final DynamicLibrary _opencvLib =
    Platform.isAndroid ? DynamicLibrary.open('libnative-lib.so') : DynamicLibrary.process();

class OpencvPlugin {
  static const MethodChannel _channel = MethodChannel('opencv_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Uint8List? blur(Uint8List list) {
    //The Uint8List lives in the Dart heap, which is garbage collected, and the objects might be moved around by the garbage collector.
    // So, you'll have to convert it into a pointer into the C heap.
    final Pointer<Uint8> bytes = malloc.allocate<Uint8>(list.length);
    for (int i = 0; i < list.length; i++) {
      bytes.elementAt(i).value = list[i];
    }
    final imgLengthBytes = malloc.allocate<Int32>(1)..value = list.length;

    final Pointer<Uint8> Function(
            Pointer<Uint8> bytes, Pointer<Int32> imgLengthBytes, int kernelSize) blur =
        _opencvLib
            .lookup<
                NativeFunction<
                    Pointer<Uint8> Function(Pointer<Uint8> bytes, Pointer<Int32> imgLengthBytes,
                        Int32 kernelSize)>>('opencv_blur')
            .asFunction();

    final newBytes = blur(bytes, imgLengthBytes, 15);
    if (newBytes == nullptr) {
      print('高斯模糊失败');
      return null;
    }

    final newList = newBytes.asTypedList(imgLengthBytes.value);

    malloc.free(bytes);
    malloc.free(imgLengthBytes);
    return newList;
  }

  static int add(int a, int b) {
    final int Function(int x, int y) _nativeAdd =
        _opencvLib.lookup<NativeFunction<Int32 Function(Int32, Int32)>>('native_add').asFunction();

    return _nativeAdd(a, b);
  }

  static void helloWorld() {
    final DynamicLibrary _opencvLib =
        Platform.isAndroid ? DynamicLibrary.open('libnative-lib.so') : DynamicLibrary.process();

    final void Function() hello =
        _opencvLib.lookup<NativeFunction<Void Function()>>('hello').asFunction();

    hello();
  }

  static int multiply(int a, int b) {
    final DynamicLibrary _opencvLib =
    Platform.isAndroid ? DynamicLibrary.open('libnative-lib.so') : DynamicLibrary.process();

    final Pointer<Int32> Function(Pointer<Int32> a, int b) multiply =
    _opencvLib.lookup<NativeFunction<Pointer<Int32> Function(Pointer<Int32> a, Int32 b)>>('multiply').asFunction();

    final Pointer<Int32> pa = malloc.allocate<Int32>(1);
    pa.value = a;

    final result = multiply(pa, b);
    print('dart --> multiply() result: value=${result.value}');

    return result.value;
  }
}
