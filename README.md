# Flutter VS Code-Style Editor (Starter)

This repo now contains a **starter architecture** for a VS Code-like editor in Flutter.

## What is implemented

- Workspace folder picker.
- Recursive file explorer (left sidebar).
- Multi-tab editor.
- Syntax-highlighted code editor (Dart currently).
- Dirty-state tracking (`●` on tab).
- Save active file.
- Basic command palette UI.
- VS Code-inspired dark layout and status bar.

## Run

```bash
flutter pub get
flutter run -d chrome
```

## Important reality check

Building "all VS Code functionality" is a very large product effort. This starter gives you the core shell, and you can extend with:

- Language Server Protocol (LSP) integration.
- Git integration.
- Extension system.
- Debug adapter protocol.
- Terminal process embedding.
- Global search, refactor tools, and settings sync.

## Suggested next milestones

1. Add keyboard shortcuts (`Shortcuts`/`Actions`) for save, open, find.
2. Add file watcher for auto-refresh explorer.
3. Add split editor groups.
4. Add Monaco embedding on web for full IntelliSense.
5. Add LSP bridge (Dart analysis server first).

6. insta it tech
