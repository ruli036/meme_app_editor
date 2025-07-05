import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

Size size() {
  return MediaQuery.of(Get.context!).size;
}

Widget verticalSpace() {
  return SizedBox(height: 16);
}

Future<void> shareImage(File imageFile) async {
  final param = ShareParams(
    text: 'Check out my meme!',
    files: [XFile(imageFile.path)],
  );
  await SharePlus.instance.share(param);
}
