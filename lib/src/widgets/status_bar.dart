import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/editor_state.dart';

class StatusBar extends StatelessWidget {
  const StatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditorState>();
    final activeFile = state.activeFile;

    return Container(
      height: 24,
      color: const Color(0xFF007ACC),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Text(activeFile?.name ?? 'No file selected'),
          const Spacer(),
          Text(activeFile?.dirty == true ? 'Unsaved changes' : 'Saved'),
        ],
      ),
    );
  }
}
