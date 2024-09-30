import 'dart:io';
import 'logger.dart';

class TreeNode {
  final String name;
  final FileSystemEntity dataType;
  final List<TreeNode> children = [];

  TreeNode(this.name, this.dataType);

  void addChild(TreeNode t) {
    children.add(t);
  }

  bool removeChild(TreeNode t) {
    return children.remove(t);
  }

  TreeNode? getChild(String name) {
    TreeNode? result;
    List<TreeNode> dirs = [];
    for (TreeNode child in children) {
      if (child.name == name) return child;
      if (child.dataType is Directory) dirs.add(child);
    }
    for (TreeNode dir in dirs) {
      result = dir.getChild(name);
    }
    return result;
  }

  Future logArborescence([int n = 0]) async {
    if (n == 0) {
      await Logger.log("-> $name");
    }
    for (var node in children) {
      await Logger.log(
          "${"\t" * n}${node.dataType is Directory ? "->" : "--"} ${node.name}");
      if (node.dataType is Directory) {
        await node.logArborescence(n + 1);
      }
    }
  }
}
