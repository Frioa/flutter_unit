import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unit/custom_draw/custom_draw.dart';
import 'package:flutter_unit/draw/draw.dart';
import 'package:flutter_unit/page/page.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized(); // 确定初始化
  // SystemChrome.setPreferredOrientations(// 使设备横屏显示
  //     [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  // SystemChrome.setEnabledSystemUIOverlays([]); // 全屏显示
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage(title: 'Flutter Demo Home Page'));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        // scrollDirection: Axis.horizontal,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CupertinoButton(
              child: Text('pager'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Paper()));
              },
            ),
            CupertinoButton(
              child: Text('level1'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Level1()));
              },
            ),
            CupertinoButton(
              child: Text('level2'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Level2()));
              },
            ),
            CupertinoButton(
              child: Text('level3'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Level3()));
              },
            ),
            CupertinoButton(
              child: Text('level4'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Level4()));
              },
            ),
            CupertinoButton(
              child: Text('level5'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Level5()));
              },
            ),
            CupertinoButton(
              child: Text('level6'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Level6()));
              },
            ),
            CupertinoButton(
              child: Text('rader_char'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => RadarChartPage()));
              },
            ),
            CupertinoButton(
              child: Text('CircleLoadingWidget'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Center(child: CircleLoadingWidget()),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
