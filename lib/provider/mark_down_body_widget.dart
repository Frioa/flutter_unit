import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MarkDownBodyWidget extends StatelessWidget {
  final String str;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const MarkDownBodyWidget(
    this.str, {
    Key? key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  }) : super(key: key);

  Widget _buildMarkDown(String str) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.sp),
      child: MarkdownBody(
        data: str,
        styleSheetTheme: MarkdownStyleSheetBaseTheme.cupertino,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> strList = str.split('<br>');

    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: strList.map(_buildMarkDown).toList(),
    );
  }
}
