extension DurationExtension on Duration {
  String toSpendTimeInSec() {
    return '${(inMicroseconds / Duration.microsecondsPerSecond).toString()}s';
  }
}
