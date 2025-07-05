import 'dart:ui';

class EditorElementEntity {
  final int id;
  String type;
  final Offset position;
  String content;

  EditorElementEntity({
    required this.id,
    required this.type,
    required this.position,
    required this.content,
  });

  EditorElementEntity copyWith({
    Offset? position,
  }) {
    return EditorElementEntity(
      id: id,
      type: type,
      position: position ?? this.position,
      content: content,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'position': {'dx': position.dx, 'dy': position.dy},
    'content': content,
  };

  factory EditorElementEntity.fromJson(Map<String, dynamic> json) {
    return EditorElementEntity(
      id: json['id'],
      type: json['type'],
      position: Offset(json['position']['dx'], json['position']['dy']),
      content: json['content'],
    );
  }
}
