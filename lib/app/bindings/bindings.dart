import 'package:get/get.dart';
import 'package:meme_editor_app/data/datasource/local/local_storage_service.dart';
import 'package:meme_editor_app/data/datasource/remote/api/service/meme_image_service.dart';
import 'package:meme_editor_app/data/repositorys/meme_image_repository_impl.dart';
import 'package:meme_editor_app/domain/repository/meme_image_repository.dart';
import 'package:meme_editor_app/domain/service/meme_image_service.dart';
import 'package:meme_editor_app/domain/service/meme_image_service_local.dart';

class AllBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MemeImageRepository>(() => MemeImageRepositoryImpl(Get.find(),Get.find()));
    Get.lazyPut<MemeImageServiceDataSource>(() => MemeImageServiceDataSourceImpl());
    Get.lazyPut<MemeImageServiceLocalDataSource>(() => MemeImageLocalStorageServiceImpl());
  }
}