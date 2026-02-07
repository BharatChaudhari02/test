import 'dart:io';

class FileNode {
  const FileNode({
    required this.path,
    required this.name,
    required this.isDirectory,
    this.children = const [],
  });

  final String path;
  final String name;
  final bool isDirectory;
  final List<FileNode> children;

  static Future<FileNode> fromDirectory(Directory directory) async {
    final entities = await directory.list().toList();
    entities.sort((a, b) => a.path.compareTo(b.path));

    final children = <FileNode>[];
    for (final entity in entities) {
      if (entity is Directory) {
        children.add(await fromDirectory(entity));
      } else if (entity is File) {
        children.add(
          FileNode(
            path: entity.path,
            name: entity.uri.pathSegments.last,
            isDirectory: false,
          ),
        );
      }
    }

    return FileNode(
      path: directory.path,
      name: directory.uri.pathSegments
          .where((segment) => segment.isNotEmpty)
          .last,
      isDirectory: true,
      children: children,
    );
  }
}
