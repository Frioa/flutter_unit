extension DurationExtension on Duration {
  String toSpendTimeInSec() {
    return 'Spend time ${(inMicroseconds / Duration.microsecondsPerSecond).toString()}s';
  }
}
