import 'package:flutter/cupertino.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_unit/blocs/bloc.dart';
import 'package:flutter_unit/utils/utils.dart';

class WrapMarkdownWidget extends StatelessWidget {
  final String? text;

  const WrapMarkdownWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (text == null) return const SizedBox();

    return Markdown(
      data: text!,
      styleSheetTheme: context.read<AppBloc>().state.markdownTheme,
      selectable: true,
      onTapLink: (String text, String? href, String title) {
        log.d('text: $text, href: $href, title: $title');
      },
    );
  }
}
