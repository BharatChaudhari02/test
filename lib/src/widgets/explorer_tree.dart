import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/file_node.dart';
import '../state/editor_state.dart';

class ExplorerTree extends StatelessWidget {
  const ExplorerTree({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditorState>();
    final root = state.workspaceRoot;

    return Container(
      color: const Color(0xFF252526),
      child: root == null
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Open a folder to get started.',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            )
          : ListView(
              children: [
                _NodeTile(node: root, depth: 0),
              ],
            ),
    );
  }
}

class _NodeTile extends StatelessWidget {
  const _NodeTile({required this.node, required this.depth});

  final FileNode node;
  final int depth;

  @override
  Widget build(BuildContext context) {
    final leftPadding = 8.0 + depth * 12;
    if (!node.isDirectory) {
      return ListTile(
        dense: true,
        contentPadding: EdgeInsets.only(left: leftPadding, right: 8),
        leading: const Icon(Icons.description, size: 16),
        title: Text(node.name, style: const TextStyle(fontSize: 13)),
        onTap: () => context.read<EditorState>().openFile(node.path),
      );
    }

    return ExpansionTile(
      tilePadding: EdgeInsets.only(left: leftPadding, right: 8),
      childrenPadding: EdgeInsets.zero,
      leading: const Icon(Icons.folder, size: 16),
      title: Text(node.name, style: const TextStyle(fontSize: 13)),
      children: node.children
          .map((child) => _NodeTile(node: child, depth: depth + 1))
          .toList(),
    );
  }
}
