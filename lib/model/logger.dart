import 'dart:io';

class Logger {
  static final String path = "/home/raskiel/Code/Perso/angelo_koe/logs/logs-${DateTime.now().toString()}.log";

  static Future<File> log(var log) async {
    var file = File(path);
    final timeCode = DateTime.now();
    return file.writeAsString("${timeCode.toString()} - $log\n\n", mode: FileMode.append);
  }
}
