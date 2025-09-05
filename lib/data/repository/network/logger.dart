import 'package:flutter/foundation.dart';

class Logger {
  ///Singleton Impl
  static final Logger _instance = Logger._internal();
  Logger._internal();
  static Logger get instance => _instance;

  bool showLog = kDebugMode;
  void call(String data) {
    // ignore: avoid_print
    if (showLog) print(data);
  }
}

/// For printing text longer than 800 xters
///
/// By default dart print function can only print 800 xters, but this will print
/// the text on a new line till the text is exhausted.
void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  // ignore: avoid_print
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

/// A top level function to print dio logs
void printDioLogs(Object object) {
  printWrapped(object.toString());
}