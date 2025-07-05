import 'package:meme_editor_app/core/network/base_api_response.dart';
import 'package:meme_editor_app/data/datasource/dto/response_meme_model.dart';

abstract class MemeImageServiceDataSource {
  Future<BaseApiResponse<MemeImage>> getMemeImages();
}