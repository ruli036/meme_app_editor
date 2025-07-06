import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:meme_editor_app/domain/entities/editor_element_entity.dart';

class ImageDetailController extends GetxController{
  final RxList<EditorElementEntity> currentElements = <EditorElementEntity>[].obs;
  final RxList<List<EditorElementEntity>> undoStack = <List<EditorElementEntity>>[].obs;
  final RxList<List<EditorElementEntity>> redoStack = <List<EditorElementEntity>>[].obs;
  final RegExp onlyEmojiRegex = RegExp(
    r'^(\p{Emoji_Presentation}|\p{Emoji}\uFE0F|\p{Emoji_Modifier_Base}|\p{Emoji_Component})+$',
    unicode: true,
  );

  bool isEmojiOnly(String text) {
    return onlyEmojiRegex.hasMatch(text.trim());
  }

  void addElement(EditorElementEntity element) {
    undoStack.add(List.from(currentElements));
    currentElements.add(element);
    redoStack.clear();
  }

  void editElement(EditorElementEntity element) {
    final index = currentElements.indexWhere((e) => e.id == element.id);
    if (index != -1) {
      undoStack.add(List.from(currentElements));
      currentElements[index] = element;
    }
  }

  void removeAll() {
      currentElements.clear();
      undoStack.clear();
      redoStack.clear();
  }
  void undo() {
    if (undoStack.isNotEmpty) {
      redoStack.add(List.from(currentElements));
      currentElements.assignAll(undoStack.removeLast());
    }
  }

  void redo() {
    if (redoStack.isNotEmpty) {
      undoStack.add(List.from(currentElements));
      currentElements.assignAll(redoStack.removeLast());
    }
  }

  void remove(int id) {
    currentElements.removeWhere((e)=>e.id == id);
  }

  void updateElementPosition(int id, Offset newPos) {
    final index = currentElements.indexWhere((e) => e.id == id);
    if (index != -1) {
      currentElements[index] = currentElements[index].copyWith(position: newPos);
    }
  }
}