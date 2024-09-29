import 'package:flutter/material.dart';
import 'explorer.dart';
import 'dart:io';
void main() async{
  var rootDir = Directory('C:\\Users\\RaSyst\\Music');
  var rootFiles = await getDirectoryContents(rootDir);
  await createArborescence(rootDir, rootFiles);
  
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(root.displayArborescence()),
        ),
      ),
    );
  }
}
