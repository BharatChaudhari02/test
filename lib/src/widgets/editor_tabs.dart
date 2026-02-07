import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:highlight/languages/dart.dart';
import 'package:provider/provider.dart';

import '../state/editor_state.dart';

class EditorTabs extends StatefulWidget {
  const EditorTabs({super.key});

  @override
  State<EditorTabs> createState() => _EditorTabsState();
}

class _EditorTabsState extends State<EditorTabs> {
  final CodeController _codeController = CodeController(language: dart);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditorState>();
    final activeFile = state.activeFile;

    if (activeFile != null && _codeController.text != activeFile.content) {
      _codeController.text = activeFile.content;
      _codeController.selection = TextSelection.collapsed(
        offset: _codeController.text.length,
      );
    }

    return Column(
      children: [
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.openFiles.length,
            itemBuilder: (context, index) {
              final file = state.openFiles[index];
              final isActive = index == state.activeTabIndex;
              return InkWell(
                onTap: () => state.setActiveTab(index),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: isActive ? Colors.blue : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    color: isActive ? const Color(0xFF1E1E1E) : const Color(0xFF2D2D2D),
                  ),
                  child: Row(
                    children: [
                      Text(file.name),
                      if (file.dirty)
                        const Padding(
                          padding: EdgeInsets.only(left: 6),
                          child: Text('●', style: TextStyle(color: Colors.orange)),
                        ),
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        iconSize: 14,
                        icon: const Icon(Icons.close),
                        onPressed: () => state.closeTab(index),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: activeFile == null
              ? const Center(
                  child: Text('Open a file from the Explorer.'),
                )
              : CodeTheme(
                  data: const CodeThemeData(styles: {}),
                  child: CodeField(
                    controller: _codeController,
                    textStyle: const TextStyle(fontFamily: 'monospace', fontSize: 14),
                    onChanged: state.updateActiveContent,
                  ),
                ),
        ),
      ],
    );
  }
}
