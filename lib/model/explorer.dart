import 'dart:io';
import 'dart:async';
import 'package:path/path.dart' as path;

import 'tree_node.dart';
import 'logger.dart';

final TreeNode root = TreeNode('./', Directory("./"));
const List<String> validAudioExtensions = [".mp3", ".wav"];

Future<List<FileSystemEntity>> getDirectoryContents(Directory directory) async {
  final files = await directory.list(recursive: false).toList();
  return files;
}

Future<void> createArborescence(
    Directory originDir, List<FileSystemEntity> files) async {
  var node = root.getChild(originDir.path);
  node ??= root;
  for (var file in files) {
    if (file.path != "./.git") {
      if (file is File) {
        node.addChild(TreeNode(file.path, file));
        await Logger.log(
            "added file ${file.path} to ${node.name} in arborescence");
      }
      if (file is Directory) {
        node.addChild(TreeNode(file.path, file));
        await Logger.log(
            "added directory ${file.path} to ${node.name} in arborescence");
        final list = await getDirectoryContents(file);
        await createArborescence(file, list);
      }
    }
  }
}

Future<List<File>> findAudioFiles(Directory dir) async {
  List<File> audioFiles = [];
  TreeNode? dirNode = root.getChild(dir.path);
  dirNode ??= root;
  for (var node in dirNode.children) {
    if (node.dataType is File &&
        (validAudioExtensions.contains(path.extension(node.name)))) {
      audioFiles.add(node.dataType as File);
    }
    if (node.dataType is Directory) {
      List<File> adf = await findAudioFiles(node.dataType as Directory);
      audioFiles = audioFiles + adf;
    }
  }
  return audioFiles;
}
