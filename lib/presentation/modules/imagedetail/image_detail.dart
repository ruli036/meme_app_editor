import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_editor_app/core/helpers/helpers.dart';
import 'package:meme_editor_app/data/datasource/local/media_storage_helper.dart';
import 'package:meme_editor_app/data/model/meme_image_model.dart';
import 'package:meme_editor_app/domain/entities/editor_element_entity.dart';
import 'package:meme_editor_app/presentation/modules/imagedetail/controller/image_detail_controller.dart';
import 'package:meme_editor_app/presentation/modules/imagedetail/widget/component_dialog.dart';
import 'package:meme_editor_app/presentation/modules/imagedetail/widget/floating_button.dart';
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
                final file = await saveTempImage(bytes);
                await shareImage(file);
              }
            },
            icon: Icon(Icons.share, color: Colors.white, size: 25),
          ),
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
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
                }
              }
            },
            icon: Icon(
              Icons.cloud_download_sharp,
              color: Colors.white,
              size: 25,
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
      floatingActionButton: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingButton<List<List<EditorElementEntity>>>(
              heroTag: "UndoBtn",
              element: controller.undoStack,
              onPressed: controller.undo,
              icon: Icons.undo,
            ),
            verticalSpace(height: 8),
            FloatingButton<List<List<EditorElementEntity>>>(
              heroTag: "RedoBtn",
              element: controller.redoStack,
              onPressed: controller.redo,
              icon: Icons.redo,
            ),
            verticalSpace(height: 8),
            FloatingButton<List<EditorElementEntity>>(
              heroTag: "ClearBtn",
              element: controller.currentElements,
              onPressed: controller.removeAll,
              icon: Icons.delete,
            ),
            verticalSpace(height: 8),
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
      ),
    );
  }
}
