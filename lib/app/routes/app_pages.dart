import 'package:get/get.dart';
import 'package:meme_editor_app/app/bindings/gallery/gallery_binding.dart';
import 'package:meme_editor_app/app/routes/app_routes.dart';
import 'package:meme_editor_app/presentation/modules/imagedetail/image_detail.dart';
import 'package:meme_editor_app/presentation/modules/memegallery/meme_gallery.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.gallery,
      transition: Transition.rightToLeft,
      binding: GalleryBinding(),
      page: () => MemeGalleryPage()
    ),
    GetPage(
      name: AppRoutes.detailImage,
      transition: Transition.rightToLeft,
      binding: GalleryBinding(),
      page: () => ImageDetailPage()
    ),
  ];
}