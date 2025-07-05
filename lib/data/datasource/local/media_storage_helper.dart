import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:media_store_plus/media_store_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Future<Uint8List?> renderToImage(GlobalKey key) async {
  try {
    final boundary = key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    if (boundary == null) return null;

    final image = await boundary.toImage(pixelRatio: 3.0);
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    return byteData?.buffer.asUint8List();
  } catch (e) {
    print("Error rendering image: $e");
    return null;
  }
}

Future<bool> saveImageToGallery(Uint8List imageBytes) async {
  Get.defaultDialog(backgroundColor: Colors.transparent, content: CircularProgressIndicator());
  MediaStore.appFolder = "Meme Editor";
  final permissionStatus = await Permission.storage.request();
  final status = await Permission.manageExternalStorage.status;
  if (!permissionStatus.isGranted && !status.isGranted) {
    Get.back();
    Get.snackbar('Permission Denied', 'Fail to save image',backgroundColor: Colors.grey,colorText: Colors.white);
    requestPermission();
    return false;
  }

  try {
    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/meme_${DateTime.now().millisecondsSinceEpoch}.png';
    final file = await File(filePath).writeAsBytes(imageBytes);

    final mediaStore = MediaStore();

    final result = await mediaStore.saveFile(
      tempFilePath: file.path,
      dirType: DirType.photo,
      dirName: DirName.pictures,
    );
    return result != null && result.saveStatus == SaveStatus.created;
  } catch (e) {
    Get.back();
    Get.snackbar('Fail', 'something was wrong :$e',backgroundColor: Colors.grey,colorText: Colors.white);
    return false;
  }
}

Future<bool> requestPermission() async {
  final status = await Permission.manageExternalStorage.status;

  if (status.isGranted) {
    return true;
  } else if (status.isPermanentlyDenied) {
    // Arahkan ke settings karena user sudah memilih "Don't ask again"
    await openAppSettings();
    return false;
  } else {
    final result = await Permission.manageExternalStorage.request();
    return result.isGranted;
  }
}
