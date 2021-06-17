import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:flutter/services.dart';
import 'package:opencv_plugin/model.dart';

final DynamicLibrary _opencvLib =
    Platform.isAndroid ? DynamicLibrary.open("libnative-lib.so") : DynamicLibrary.process();

class OpencvPlugin {
  static const MethodChannel _channel = const MethodChannel('opencv_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static void blur(Uint8List list) {
    //The Uint8List lives in the Dart heap, which is garbage collected, and the objects might be moved around by the garbage collector.
    // So, you'll have to convert it into a pointer into the C heap.
    Pointer<Uint8> bytes = malloc.allocate<Uint8>(list.length);
    for (int i = 0; i < list.length; i++) {
      bytes.elementAt(i).value = list[i];
    }
    final imgLengthBytes = malloc.allocate<Int32>(1);
    print('object ${list.sublist(0, 100)}');

    final Mat Function(Pointer<Uint8> bytes, Pointer<Int32> imgLengthBytes, int kernelSize) blur =
        _opencvLib
            .lookup<
                NativeFunction<
                    Mat Function(Pointer<Uint8> bytes, Pointer<Int32> imgLengthBytes,
                        Int32 kernelSize)>>("opencv_blur")
            .asFunction();

    blur(bytes, imgLengthBytes, 10);
  }

  static int add(int a, int b) {
    final int Function(int x, int y) _nativeAdd =
        _opencvLib.lookup<NativeFunction<Int32 Function(Int32, Int32)>>("native_add").asFunction();

    return _nativeAdd(a, b);
  }
}
