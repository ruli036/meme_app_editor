import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_editor_app/domain/entities/editor_element_entity.dart';
import 'package:meme_editor_app/presentation/modules/imagedetail/controller/image_detail_controller.dart';

void showComponentDialog({
  EditorElementEntity? element,
  required TextEditingController controller,
}) {
  final ImageDetailController imageController = Get.find();

  controller.text = element?.content??'';

  Get.defaultDialog(
    barrierDismissible: false,
    title: '${element == null ?'Add':'Edit'} Component',
    titleStyle: const TextStyle(color: Colors.white),
    backgroundColor: Colors.transparent,
    content: TextField(
      style: const TextStyle(color: Colors.white),
      controller: controller,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: 'Add text',
        hintStyle: TextStyle(color: Colors.white60),
        border: InputBorder.none,
      ),
    ),
    textConfirm: 'Save',
    textCancel: 'Cancel',
    cancelTextColor: Colors.red,
    buttonColor: Colors.white,
    confirmTextColor: Colors.green,
    onConfirm: () {
      final text = controller.text;
      final isEmoji = imageController.isEmojiOnly(text);

      final newItem = EditorElementEntity(
        id: element?.id??imageController.currentElements.length+1,
        type: isEmoji ? "emoji" : "text",
        content: controller.text,
        position: element?.position??Offset(100, 100),
      );
      if(element == null){
        imageController.addElement(newItem);
      }else{
        imageController.editElement(newItem);
      }

      Get.back();
    },
  );
}
