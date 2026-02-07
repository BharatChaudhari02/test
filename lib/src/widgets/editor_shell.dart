import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/editor_state.dart';
import 'command_palette.dart';
import 'editor_tabs.dart';
import 'explorer_tree.dart';
import 'status_bar.dart';

class EditorShell extends StatelessWidget {
  const EditorShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EditorState>(
      builder: (context, state, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Flutter VS Code Clone (Starter)'),
            actions: [
              IconButton(
                icon: const Icon(Icons.folder_open),
                tooltip: 'Open Folder',
                onPressed: () async {
                  final folder = await FilePicker.platform.getDirectoryPath();
                  if (folder != null && context.mounted) {
                    await context.read<EditorState>().openWorkspace(folder);
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.save),
                tooltip: 'Save (Ctrl+S)',
                onPressed: () => context.read<EditorState>().saveActiveFile(),
              ),
              IconButton(
                icon: const Icon(Icons.keyboard_command_key),
                tooltip: 'Command Palette',
                onPressed: () => context.read<EditorState>().toggleCommandPalette(),
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: Row(
                  children: const [
                    SizedBox(width: 280, child: ExplorerTree()),
                    VerticalDivider(width: 1),
                    Expanded(child: EditorTabs()),
                  ],
                ),
              ),
              const StatusBar(),
            ],
          ),
          floatingActionButton: state.isCommandPaletteOpen
              ? const CommandPalette()
              : null,
        );
      },
    );
  }
}
