import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:native_add/native_add.dart';

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
      body: Container(
        child: CupertinoButton(
          child: Text('a+b'),
          onPressed: () {
            print('NativeAdd  ${NativeAdd.nativeAdd(2, 5)}');
          },
        ),
      ),
    );
  }
}
