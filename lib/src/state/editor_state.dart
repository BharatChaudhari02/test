import 'package:flutter/material.dart';

import '../models/file_node.dart';
import '../models/open_file.dart';
import '../services/workspace_service.dart';

class EditorState extends ChangeNotifier {
  final WorkspaceService _workspaceService = WorkspaceService();

  FileNode? workspaceRoot;
  final List<OpenFile> openFiles = [];
  int activeTabIndex = -1;
  bool isCommandPaletteOpen = false;

  OpenFile? get activeFile {
    if (activeTabIndex < 0 || activeTabIndex >= openFiles.length) {
      return null;
    }
    return openFiles[activeTabIndex];
  }

  Future<void> openWorkspace(String rootPath) async {
    workspaceRoot = await _workspaceService.loadWorkspace(rootPath);
    notifyListeners();
  }

  Future<void> openFile(String path) async {
    final existingIndex = openFiles.indexWhere((file) => file.path == path);
    if (existingIndex != -1) {
      activeTabIndex = existingIndex;
      notifyListeners();
      return;
    }

    final content = await _workspaceService.readFile(path);
    final file = OpenFile(
      path: path,
      name: _workspaceService.basename(path),
      content: content,
    );
    openFiles.add(file);
    activeTabIndex = openFiles.length - 1;
    notifyListeners();
  }

  void updateActiveContent(String content) {
    final file = activeFile;
    if (file == null) return;
    file.content = content;
    file.dirty = true;
    notifyListeners();
  }

  Future<void> saveActiveFile() async {
    final file = activeFile;
    if (file == null) return;
    await _workspaceService.writeFile(file.path, file.content);
    file.dirty = false;
    notifyListeners();
  }

  void closeTab(int index) {
    if (index < 0 || index >= openFiles.length) return;
    openFiles.removeAt(index);
    if (openFiles.isEmpty) {
      activeTabIndex = -1;
    } else if (activeTabIndex >= openFiles.length) {
      activeTabIndex = openFiles.length - 1;
    }
    notifyListeners();
  }

  void setActiveTab(int index) {
    activeTabIndex = index;
    notifyListeners();
  }

  void toggleCommandPalette() {
    isCommandPaletteOpen = !isCommandPaletteOpen;
    notifyListeners();
  }
}
