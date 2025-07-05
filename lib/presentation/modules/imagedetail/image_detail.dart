import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_editor_app/data/datasource/local/media_storage_helper.dart';
import 'package:meme_editor_app/data/model/meme_image_model.dart';
import 'package:meme_editor_app/presentation/modules/imagedetail/controller/image_detail_controller.dart';
import 'package:meme_editor_app/presentation/modules/imagedetail/widget/component_dialog.dart';
import 'package:meme_editor_app/presentation/modules/imagedetail/widget/item_component.dart';

class ImageDetailPage extends StatelessWidget {
  final controller = Get.find<ImageDetailController>();
  final MemeImageModel item = Get.arguments;
  final TextEditingController textComponent = TextEditingController();
  final GlobalKey editorKey = GlobalKey();

  ImageDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text("Edit Meme", style: TextStyle(color: Colors.white)),
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final bytes = await renderToImage(editorKey);
              if (bytes != null) {
                final image = await saveImageToGallery(bytes);
                if (image) {
                  Get.back();
                  Get.snackbar(
                    duration: Duration(seconds: 2),
                    'Seuccess',
                    'Image was success to download ',
                    backgroundColor: Colors.grey,
                    colorText: Colors.white,
                  );
                }
              }
            },
            icon: Icon(
              Icons.cloud_download_sharp,
              color: Colors.white,
              size: 35,
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
      ),
      body: RepaintBoundary(
        key: editorKey,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image(
                image: CachedNetworkImageProvider(item.url, cacheKey: item.id),
              ),
            ),
            Obx(
              () => Stack(
                children: controller.currentElements
                    .map(
                      (e) => ItemComponent(
                        element: e,
                        textComponent: textComponent,
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: "Clear",
            onPressed: controller.removeAll,
            child: Icon(Icons.delete),
          ),
          SizedBox(height: 8),
          FloatingActionButton(
            heroTag: "undo",
            onPressed: controller.undo,
            child: Icon(Icons.undo),
          ),
          SizedBox(height: 8),
          FloatingActionButton(
            heroTag: "redo",
            onPressed: controller.redo,
            child: Icon(Icons.redo),
          ),
          SizedBox(height: 8),
          FloatingActionButton(
            heroTag: "add",
            onPressed: () {
              textComponent.clear();
              showComponentDialog(controller: textComponent);
            },
            child: Icon(Icons.text_fields),
          ),
        ],
      ),
    );
  }
}
