import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_editor_app/domain/entities/editor_element_entity.dart';
import 'package:meme_editor_app/presentation/modules/imagedetail/controller/image_detail_controller.dart';
import 'package:meme_editor_app/presentation/modules/imagedetail/widget/component_dialog.dart';

class ItemComponent extends StatelessWidget {
  final EditorElementEntity element;
  final TextEditingController textComponent;
  const ItemComponent({super.key,required this.element,required this.textComponent});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ImageDetailController>();

    return Positioned(
      left: element.position.dx,
      top: element.position.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          const speedFactor = 1.0;
          final delta = details.delta * speedFactor;
          controller.updateElementPosition(element.id, element.position + delta);
        },
        onTapDown: (_) {
          textComponent.text = element.content;
          showComponentDialog(element: element, controller: textComponent);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            element.content,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
