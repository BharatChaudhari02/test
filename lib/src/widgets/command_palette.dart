import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/editor_state.dart';

class CommandPalette extends StatelessWidget {
  const CommandPalette({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 520,
      margin: const EdgeInsets.only(bottom: 80),
      child: Material(
        elevation: 8,
        color: const Color(0xFF252526),
        borderRadius: BorderRadius.circular(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Type a command...',
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(16),
              ),
              onSubmitted: (_) => context.read<EditorState>().toggleCommandPalette(),
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.save),
              title: const Text('File: Save'),
              onTap: () {
                context.read<EditorState>().saveActiveFile();
                context.read<EditorState>().toggleCommandPalette();
              },
            ),
            ListTile(
              leading: const Icon(Icons.close),
              title: const Text('Close command palette'),
              onTap: () => context.read<EditorState>().toggleCommandPalette(),
            ),
          ],
        ),
      ),
    );
  }
}
