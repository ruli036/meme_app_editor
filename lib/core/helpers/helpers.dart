import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meme_editor_app/core/constant.dart';
import 'package:meme_editor_app/data/datasource/local/local_key.dart';
import 'package:share_plus/share_plus.dart';

Size size() {
  return MediaQuery.of(Get.context!).size;
}

Widget verticalSpace({double? height}) {
  return SizedBox(height: height ?? 16);
}

Future<void> shareImage(File imageFile) async {
  final param = ShareParams(
    text: 'Check out my meme!',
    files: [XFile(imageFile.path)],
  );
  await SharePlus.instance.share(param);
}

void toggleTheme(bool value) {
  AppSetting.isDarkMode.value = value;
  Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
  GetStorage().write(LocalKeys.darkMode, value);
}
