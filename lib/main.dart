import 'package:flutter/material.dart';
import 'model/explorer.dart';
import 'dart:io';

void main() async {
  var rootDir = Directory('/home/raskiel/Musique/');
  var rootFiles = await getDirectoryContents(rootDir);
  await createArborescence(rootDir, rootFiles);
  await root.logArborescence();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text("Hello World"),
        ),
      ),
    );
  }
}
