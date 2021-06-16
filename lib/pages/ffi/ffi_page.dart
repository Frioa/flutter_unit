import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:native_add/native_add.dart'
    if (dart.library.html) 'package:native_add/native_add_web.dart';
import 'package:opencv_plugin/opencv_plugin.dart';

class FfiPage extends StatefulWidget {
  const FfiPage({Key? key}) : super(key: key);

  @override
  _FfiPageState createState() => _FfiPageState();
}

class _FfiPageState extends State<FfiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(('ffi'))),
      body: Column(
        children: [
          CupertinoButton(
            child: Text('a+b'),
            onPressed: () {

              final ret = OpencvPlugin.add(1, 1);
              print('object $ret');
            },
          ),
          CupertinoButton(
            child: Text('111'),
            onPressed: () {
              final ret = OpencvPlugin.rectangle();
            },
          ),
        ],
      ),
    );
  }
}
