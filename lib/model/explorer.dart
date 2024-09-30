import 'dart:io';
import 'dart:async';

import 'tree_node.dart';
import 'logger.dart';

final TreeNode root = TreeNode('./', Directory("./"));

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
        Logger.log("added file ${file.path} to ${node.name} in arborescence");
      }
      if (file is Directory) {
        node.addChild(TreeNode(file.path, file));
        Logger.log("added directory ${file.path} to ${node.name} in arborescence");
        final list = await getDirectoryContents(file);
        await createArborescence(file, list);
      }
    }
  }
}
