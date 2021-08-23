import 'package:fimber/fimber.dart';

final log = Logger._();

class Logger {
  Logger._() {
    Fimber.plantTree(CustomFormatTree(useColors: true));
  }

  /// Logs VERBOSE level [message]
  /// with optional exception and stacktrace
  void v(String message, {dynamic ex, StackTrace? stacktrace}) {
    Fimber.v(message, ex: ex, stacktrace: stacktrace);
  }

  /// Logs DEBUG level [message]
  /// with optional exception and stacktrace
  void d(String message, {dynamic ex, StackTrace? stacktrace}) {
    Fimber.d(message, ex: ex, stacktrace: stacktrace);
  }

  /// Logs INFO level [message]
  /// with optional exception and stacktrace
  void i(String message, {dynamic ex, StackTrace? stacktrace}) {
    Fimber.i(message, ex: ex, stacktrace: stacktrace);
  }

  /// Logs WARNING level [message]
  /// with optional exception and stacktrace
  void w(String message, {dynamic ex, StackTrace? stacktrace}) {
    Fimber.w(message, ex: ex, stacktrace: stacktrace);
  }

  /// Logs ERROR level [message]
  /// with optional exception and stacktrace
  void e(String message, {dynamic ex, StackTrace? stacktrace}) {
    Fimber.clearAll();
    Fimber.e(message, ex: ex, stacktrace: stacktrace);
  }
}
