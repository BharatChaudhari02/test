class OpenFile {
  OpenFile({
    required this.path,
    required this.name,
    required this.content,
  });

  final String path;
  final String name;
  String content;
  bool dirty = false;
}
