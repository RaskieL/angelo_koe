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

  Future<String> displayArborescence([int n = 0, StringBuffer? s]) async {
    s ??= StringBuffer();
    if (n == 0) {
      s.write("-> $name\n");
    }
    for (var node in children) {
      s.write(
          "${"\t" * n}${node.dataType is Directory ? "->" : "- "} ${node.name}\n");
      if (node.dataType is Directory) {
        node.displayArborescence(n + 1);
      }
    }
    await Logger.log(s.toString());
    return s.toString();
  }
}
