import 'package:meme_editor_app/domain/entities/meme_image_entity.dart';

class MemeImageModel extends MemeImageEntity {
  MemeImageModel({
    required super.id,
    required super.name,
    required super.url,
    required super.width,
    required super.height,
    required super.boxCount,
    required super.captions,
  });

  factory MemeImageModel.fromJson(Map<String, dynamic> json) => MemeImageModel(
    id: json['id'],
    name: json['name'],
    url: json['url'],
    width: json['width'],
    height: json['height'],
    boxCount: json['box_count'],
    captions: json['captions'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'url': url,
    'width': width,
    'height': height,
    'box_count': boxCount,
    'captions': captions,
  };
}
