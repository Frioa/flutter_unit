import 'dart:async';
import 'dart:ffi'; // For FFI
import 'dart:io'; // For Platform.isX

import 'package:flutter/services.dart';

final DynamicLibrary _nativeAddLib =
    Platform.isAndroid ? DynamicLibrary.open('native-lib.so') : DynamicLibrary.process();

final int Function(int x, int y) _nativeAdd =
    _nativeAddLib.lookup<NativeFunction<Int32 Function(Int32, Int32)>>('native_add').asFunction();

class NativeAdd {
  static const MethodChannel _channel = MethodChannel('native_add');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static int nativeAdd(int a, int b) {
    return _nativeAdd(a, b);
  }
}
