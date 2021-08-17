import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:native_add/native_add.dart'
    if (dart.library.html) 'package:native_add/native_add_web.dart';
import 'package:opencv_plugin/opencv_plugin.dart';

class FfiPage extends StatefulWidget {
  const FfiPage({Key? key}) : super(key: key);

  @override
  _FfiPageState createState() => _FfiPageState();
}

class _FfiPageState extends State<FfiPage> {
  static const String imageUrl = 'assets/image_lonely.jpeg';
  Uint8List? uint8list;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final bytes = await rootBundle.load(imageUrl);
      uint8list = bytes.buffer.asUint8List();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ffi')),
      body: Column(
        children: [
          CupertinoButton(
            child: const Text('hello world'),
            onPressed: () async {
              OpencvPlugin.helloWorld();
            },
          ),
          CupertinoButton(
            child: const Text('a*b'),
            onPressed: () async {
              OpencvPlugin.multiply(10, 100);
            },
          ),
          CupertinoButton(
            child: const Text('高斯模糊'),
            onPressed: () {
              if (uint8list != null) {
                uint8list = OpencvPlugin.blur(uint8list!);
                setState(() {});
              }
            },
          ),
          if (uint8list != null) Image.memory(uint8list!),
        ],
      ),
    );
  }
}
