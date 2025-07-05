import 'package:meme_editor_app/data/model/meme_image_model.dart';

abstract class MemeImageRepository {
  Future<List<MemeImageModel>> getImages();
}