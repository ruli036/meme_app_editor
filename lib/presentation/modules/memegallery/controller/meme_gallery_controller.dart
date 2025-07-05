import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:meme_editor_app/data/model/meme_image_model.dart';
import 'package:meme_editor_app/domain/repository/meme_image_repository.dart';

class MemeGalleryController extends GetxController {
  final MemeImageRepository memeImageRepository;

  MemeGalleryController({required this.memeImageRepository});

  final RxList<MemeImageModel> images = <MemeImageModel>[].obs;
  final TextEditingController searchController = TextEditingController();
  RxBool loading = true.obs;
  List<MemeImageModel> imagesTemp = [];

  @override
  void onInit() {
    // TODO: implement onInit
    getImages();
    searchController.addListener(_onSearchChanged);
    super.onInit();
  }

  Future<void> getImages() async {
    loading.value = true;
    images.value = await memeImageRepository.getImages();
    imagesTemp = images.toList();
    loading.value = false;
  }

  void _onSearchChanged() {
    final query = searchController.text.toLowerCase();
    if (query.isEmpty) {
      images.value = List.from(imagesTemp);
    } else {
      images.value = imagesTemp
          .where((item) => item.name.toLowerCase().contains(query))
          .toList();
    }
    update();
  }
}
