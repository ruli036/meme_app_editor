import 'package:meme_editor_app/data/model/meme_image_model.dart';

abstract class MemeImageServiceLocalDataSource {
  Future<void> saveMemeImageList(List<MemeImageModel> memes, {String key});
  List<MemeImageModel> getMemeImageList(String key);
}