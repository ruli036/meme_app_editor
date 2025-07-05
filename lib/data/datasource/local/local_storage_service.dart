import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:meme_editor_app/data/model/meme_image_model.dart';
import 'package:meme_editor_app/domain/service/meme_image_service_local.dart';

class MemeImageLocalStorageServiceImpl implements MemeImageServiceLocalDataSource{
  final GetStorage box = GetStorage();

  @override
  Future<void> saveMemeImageList(List<MemeImageModel> memes,{String key = 'meme_list'}) async {
    final jsonList = memes.map((meme) => meme.toJson()).toList();
    box.write(key, jsonEncode(jsonList));
  }

  @override
  List<MemeImageModel> getMemeImageList(String key) {
    final jsonString = box.read(key);
    if (jsonString == null) return [];

    final List decoded = jsonDecode(jsonString);
    return decoded.map((item) => MemeImageModel.fromJson(item)).toList();
  }
}
