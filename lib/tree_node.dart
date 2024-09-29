import 'dart:io';

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

  String displayArborescence([int n = 0, StringBuffer? s]) {
    s ??= StringBuffer();
    if (n == 0) {
      s.write("-> ${name}");
    }
    for (var node in children) {
      s.write(
          "${"\t" * n}${node.dataType is Directory ? "->" : "- "} ${node.name}");
      if (node.dataType is Directory) {
        node.displayArborescence(n + 1);
      }
    }
    return s.toString();
  }
}
