import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

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

  static void rectangle() {
    final Mat Function() _mat =
        _opencvLib.lookup<NativeFunction<Mat Function()>>("mat").asFunction();
    print('object ${_mat()}');
  }

  static int add(int a, int b) {
    final int Function(int x, int y) _nativeAdd =
        _opencvLib.lookup<NativeFunction<Int32 Function(Int32, Int32)>>("native_add").asFunction();

    return _nativeAdd(a, b);
  }


}
