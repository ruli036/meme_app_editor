import 'package:flutter_test/flutter_test.dart';
import 'package:meme_editor_app/presentation/modules/imagedetail/controller/image_detail_controller.dart';
import 'package:meme_editor_app/domain/entities/editor_element_entity.dart';


void main() {
  late ImageDetailController controller;

  setUp(() {
    controller = ImageDetailController();
  });

  test('addElement adds element and pushes to undoStack', () {
    final element = EditorElementEntity(
      id: 1,
      type: 'text',
      content: 'Hello',
      position: Offset(50, 50),
    );

    controller.addElement(element);

    expect(controller.currentElements.length, 1);
    expect(controller.currentElements.first.id, 1);
    expect(controller.undoStack.isNotEmpty, true);
  });

  test('undo restores previous state', () {
    final element2 = EditorElementEntity(id: 2, type: 'text', content: 'B', position: Offset(20, 20));
    final element1 = EditorElementEntity(id: 1, type: 'text', content: 'A', position: Offset(10, 10));

    controller.addElement(element1);
    controller.addElement(element2);

    expect(controller.currentElements.length, 2);
    controller.undo();
    expect(controller.currentElements.length, 1);
    expect(controller.currentElements.first.id, 1);
  });

  test('redo restores state after undo', () {
    final element1 = EditorElementEntity(id: 1, type: 'text', content: 'A', position: Offset(10, 10));
    final element2 = EditorElementEntity(id: 2, type: 'text', content: 'B', position: Offset(20, 20));

    controller.addElement(element1);
    controller.addElement(element2);

    controller.undo();
    controller.redo();

    expect(controller.currentElements.length, 2);
    expect(controller.currentElements[1].id, 2);
  });

  test('isEmojiOnly correctly detects emoji', () {
    expect(controller.isEmojiOnly("😀😂👍"), true);
    expect(controller.isEmojiOnly("Hello 😀"), false);
  });

  test('updateElementPosition updates the position', () {
    final element = EditorElementEntity(id: 1, type: 'text', content: 'Move me', position: Offset(0, 0));
    controller.addElement(element);

    controller.updateElementPosition(1, Offset(100, 200));

    expect(controller.currentElements.first.position, Offset(100, 200));
  });

  test('remove removes element by id', () {
    final element = EditorElementEntity(id: 1, type: 'text', content: 'To remove', position: Offset(0, 0));
    controller.addElement(element);

    controller.remove(1);

    expect(controller.currentElements.length, 0);
  });
}
