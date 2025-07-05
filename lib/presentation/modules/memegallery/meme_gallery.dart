import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_editor_app/core/constant.dart';
import 'package:meme_editor_app/presentation/modules/memegallery/controller/meme_gallery_controller.dart';
import 'package:meme_editor_app/presentation/modules/memegallery/widget/item_image.dart';
import 'package:meme_editor_app/presentation/modules/memegallery/widget/search_form.dart';
import 'package:meme_editor_app/presentation/widgets/state_handler.dart';
import 'package:meme_editor_app/presentation/widgets/switch_button.dart';

class MemeGalleryPage extends StatelessWidget {
  const MemeGalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MemeGalleryController>();
    return Scaffold(
      appBar: AppBar(title: Text('Gallery')),
      body: Obx(() {
        return Column(
          children: [
            SearchForm(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => controller.getImages(),
                child: StateHandler(
                  isEmpty: controller.images.isEmpty,
                  isLoading: controller.loading.value,
                  child: GridView.builder(
                    padding: EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
          ],
        );
      }),
      drawer: Drawer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Setting",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  title: Text("Theme Mode", style: TextStyle(fontSize: 14)),
                  trailing: SwitchButton(
                    status: AppSetting.dartMode,
                    onToggle: (value) {
                      AppSetting.dartMode = value;
                    },
                  ),
                ),
                ListTile(
                  title: Text(
                    "Online/Offline Mode",
                    style: TextStyle(fontSize: 14),
                  ),
                  trailing: SwitchButton(
                    status: AppSetting.online,
                    icon1: Icons.wifi_off,
                    icon2: Icons.wifi,
                    onToggle: (value) {
                      AppSetting.online = value;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
