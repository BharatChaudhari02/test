import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/state/editor_state.dart';
import 'src/widgets/editor_shell.dart';

void main() {
  runApp(const EditorApp());
}

class EditorApp extends StatelessWidget {
  const EditorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditorState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        theme: ThemeData.light(useMaterial3: true),
        darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
          scaffoldBackgroundColor: const Color(0xFF1E1E1E),
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFF0E639C),
            secondary: Color(0xFF3794FF),
          ),
        ),
        home: const EditorShell(),
      ),
    );
  }
}
