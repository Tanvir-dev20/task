class Note {
  String id;
  String title;
  String content;
  int color;
  bool isSynced;

  Note({
    required this.id,
    required this.title,
    required this.content,
    this.color = 0xFFFFFFFF,
    this.isSynced = false,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'content': content,
    'color': color,
    'isSynced': isSynced,
  };

  factory Note.fromJson(Map<String, dynamic> json) => Note(
    id: json['id'],
    title: json['title'],
    content: json['content'],
    color: json['color'] ?? 0xFFFFFFFF,
    isSynced: json['isSynced'] ?? false,
  );
}
