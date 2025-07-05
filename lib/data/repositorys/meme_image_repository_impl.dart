import 'package:meme_editor_app/core/constant.dart';
import 'package:meme_editor_app/data/datasource/local/local_key.dart';
import 'package:meme_editor_app/data/model/meme_image_model.dart';
import 'package:meme_editor_app/domain/repository/meme_image_repository.dart';
import 'package:meme_editor_app/domain/service/meme_image_service.dart';
import 'package:meme_editor_app/domain/service/meme_image_service_local.dart';

class MemeImageRepositoryImpl implements MemeImageRepository {
  final MemeImageServiceLocalDataSource localDb;
  final MemeImageServiceDataSource dataSource;

  MemeImageRepositoryImpl(this.dataSource,this.localDb);

  @override
  Future<List<MemeImageModel>> getImages() async {
    if (AppSetting.online) {
      try {
        return await _getImagesOnline();
      } catch (e) {
        final localData = await _getImagesOffline();
        if (localData.isNotEmpty) return localData;
        rethrow;
      }
    } else {
      final localData = await _getImagesOffline();
      if (localData.isNotEmpty) return localData;
      try {
        return await _getImagesOnline();
      } catch (e) {
        rethrow;
      }
    }

  }

  Future<List<MemeImageModel>> _getImagesOnline() async {
    List<MemeImageModel> result = [];
    final response = await dataSource.getMemeImages();
    final data = response.data.data;
    for (var item in data?.memes ?? []) {
      final data = MemeImageModel(
          id: item.id,
          name:  item.name,
          url:  item.url,
          width:  item.width,
          height:  item.height,
          boxCount:  item.boxCount,
          captions:  item.captions
      );
      result.addAll({data});
    }
    localDb.saveMemeImageList(result,key: LocalKeys.memeImageList);
    return result;
  }

  Future<List<MemeImageModel>> _getImagesOffline() async {
    final localData = localDb.getMemeImageList(LocalKeys.memeImageList);
    return localData;
  }
}
