import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_editor_app/presentation/modules/memegallery/controller/meme_gallery_controller.dart';
import 'package:meme_editor_app/presentation/modules/memegallery/widget/item_image.dart';
import 'package:meme_editor_app/presentation/widgets/state_handler.dart';

class GridviewData extends StatelessWidget {
  const GridviewData({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MemeGalleryController>();
    return Obx(
      () => Expanded(
        child: RefreshIndicator(
          onRefresh: () => controller.getImages(),
          child: StateHandler(
            isEmpty: controller.images.isEmpty,
            isLoading: controller.loading.value,
            child: GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 3 / 2,
              ),
              itemCount: controller.images.length,
              itemBuilder: (context, index) {
                final item = controller.images;
                return ItemImage(item: item[index]);
              },
            ),
          ),
        ),
      ),
    );
  }
}
