import 'dart:io';

class Logger {
  static const String path = "B:\\Code\\dart\\angel_koe_flutter\\lib\\logs.log";

  static Future<File> log(var log) async {
    var file = File(path);
    final timeCode = DateTime.now();
    return file.writeAsString("${timeCode.toString()} - $log\n\n", mode: FileMode.append);
  }
}
