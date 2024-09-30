import 'dart:io';

class Logger {
  static const String path = "/home/raskiel/Code/Perso/angelo_koe/logs.log";

  static Future<File> log(var log) async {
    var file = File(path);
    final timeCode = DateTime.now();
    return file.writeAsString("${timeCode.toString()}\n$log\n\n", mode: FileMode.append);
  }
}
