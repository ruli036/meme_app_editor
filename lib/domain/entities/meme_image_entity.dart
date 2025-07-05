class MemeImageEntity {
  final String id;
  final String name;
  final String url;
  final int width;
  final int height;
  final int boxCount;
  final dynamic captions;

  MemeImageEntity({
    required this.id,
    required this.name,
    required this.url,
    required this.width,
    required this.height,
    required this.boxCount,
    required this.captions,
  });
}
