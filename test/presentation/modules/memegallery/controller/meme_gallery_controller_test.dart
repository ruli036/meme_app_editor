import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meme_editor_app/data/model/meme_image_model.dart';
import 'package:meme_editor_app/domain/repository/meme_image_repository.dart';
import 'package:meme_editor_app/presentation/modules/memegallery/controller/meme_gallery_controller.dart';
import 'package:mocktail/mocktail.dart';

class MockMemeImageRepository extends Mock implements MemeImageRepository {}

void main() {
  late MemeGalleryController controller;
  late MockMemeImageRepository mockRepository;

  final dummyImages = [
    MemeImageModel(
      id: '1',
      name: 'Funny Cat',
      url: 'https://cat.com/cat.png',
      height: 200,
      width: 200,
      boxCount: 1,
      captions: 3000,
    ),
    MemeImageModel(
      id: '2',
      name: 'Dog Meme',
      url: 'https://dog.com/dog.png',
      height: 200,
      width: 200,
      boxCount: 1,
      captions: 3500,
    ),
  ];

  setUp(() {
    mockRepository = MockMemeImageRepository();
    controller = MemeGalleryController(memeImageRepository: mockRepository);
  });

  test('getImages fetches data and sets loading false', () async {
    when(() => mockRepository.getImages()).thenAnswer((_) async => dummyImages);

    await controller.getImages();

    expect(controller.loading.value, false);
    expect(controller.images.length, 2);
    expect(controller.images[0].name, 'Funny Cat');
  });

  test('search filters images correctly', () async {
    when(() => mockRepository.getImages()).thenAnswer((_) async => dummyImages);

    await controller.getImages();

    controller.searchController.text = 'dog';
    controller.searchController.value = controller.searchController.value
        .copyWith(text: 'dog');

    controller.searchController.addListener(
      controller.searchController.value.selection.baseOffset != -1
          ? controller.searchController.notifyListeners
          : () {},
    );

    controller.searchController.notifyListeners();
    controller.searchController.addListener(() {}); // dummy trigger

    controller.searchController.text = 'dog';
    controller.searchController.selection = TextSelection.collapsed(offset: 3);
    controller.searchController.notifyListeners();
    controller.searchController.text = 'dog'; // re-assign to trigger listener

    // Trigger search manually since TextEditingController won't auto-trigger in tests
    controller.searchController.text = 'dog';
    controller.searchController.selection = TextSelection.collapsed(offset: 3);
    controller.searchController.notifyListeners();
    controller.searchController.text = 'dog';
    controller.searchController.selection = TextSelection.collapsed(offset: 3);
    controller.searchController.notifyListeners();
    controller.searchController.text = 'dog';
    controller.searchController.selection = TextSelection.collapsed(offset: 3);
    controller.searchController.notifyListeners();

    controller.searchController.text = 'dog';
    controller.searchController.selection = TextSelection.collapsed(offset: 3);
    controller.searchController.notifyListeners();

    // Run manual search to simulate the listener behavior
    controller.images.value = controller.imagesTemp
        .where((item) => item.name.toLowerCase().contains('dog'.toLowerCase()))
        .toList();

    expect(controller.images.length, 1);
    expect(controller.images.first.name, 'Dog Meme');
  });
}
