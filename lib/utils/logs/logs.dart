import 'package:fimber/fimber.dart';

final log = Logger._();

class Logger {
  static final String _defaultFormat = '${CustomFormatTree.levelToken}: '
      '[flutter_unit] '
      '${CustomFormatTree.timeStampToken}\t'
      '${CustomFormatTree.messageToken}';

  static String get _methodName =>'${LogTree.getTag(stackIndex: 3)}()';

  Logger._() {
    Fimber.plantTree(CustomFormatTree(useColors: true, logFormat: _defaultFormat));
  }

  /// Logs VERBOSE level [message]
  /// with optional exception and stacktrace
  void v(String message, {dynamic ex, StackTrace? stacktrace}) {
    Fimber.v('$_methodName $message', ex: ex, stacktrace: stacktrace);
  }

  /// Logs DEBUG level [message]
  /// with optional exception and stacktrace
  void d(String message, {dynamic ex, StackTrace? stacktrace}) {
    Fimber.d('$_methodName $message', ex: ex, stacktrace: stacktrace);
  }

  /// Logs INFO level [message]
  /// with optional exception and stacktrace
  void i(String message, {dynamic ex, StackTrace? stacktrace}) {
    Fimber.i('$_methodName $message', ex: ex, stacktrace: stacktrace);
  }

  /// Logs WARNING level [message]
  /// with optional exception and stacktrace
  void w(String message, {dynamic ex, StackTrace? stacktrace}) {
    Fimber.w('$_methodName $message', ex: ex, stacktrace: stacktrace);
  }

  /// Logs ERROR level [message]
  /// with optional exception and stacktrace
  void e(String message, {dynamic ex, StackTrace? stacktrace}) {
    Fimber.clearAll();
    Fimber.e('$_methodName $message', ex: ex, stacktrace: stacktrace);
  }
}
