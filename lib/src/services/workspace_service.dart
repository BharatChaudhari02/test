import 'dart:io';

import 'package:path/path.dart' as p;

import '../models/file_node.dart';

class WorkspaceService {
  Future<FileNode> loadWorkspace(String rootPath) async {
    return FileNode.fromDirectory(Directory(rootPath));
  }

  Future<String> readFile(String filePath) async {
    return File(filePath).readAsString();
  }

  Future<void> writeFile(String filePath, String content) async {
    await File(filePath).writeAsString(content);
  }

  String basename(String filePath) => p.basename(filePath);
}
