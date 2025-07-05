import 'package:get/get.dart';
import 'package:meme_editor_app/presentation/modules/imagedetail/controller/image_detail_controller.dart';
import 'package:meme_editor_app/presentation/modules/memegallery/controller/meme_gallery_controller.dart';

class GalleryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MemeGalleryController(memeImageRepository: Get.find()));
    Get.lazyPut(() => ImageDetailController());
  }
}