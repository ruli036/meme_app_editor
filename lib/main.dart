import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:media_store_plus/media_store_plus.dart';
import 'package:meme_editor_app/app/bindings/bindings.dart';
import 'package:meme_editor_app/app/routes/app_pages.dart';
import 'package:meme_editor_app/app/routes/app_routes.dart';
import 'package:meme_editor_app/core/themes/app_themes.dart';
import 'package:meme_editor_app/data/datasource/local/local_key.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MediaStore.ensureInitialized();
  await GetStorage.init();

  final storage = GetStorage();
  final isDarkMode = storage.read(LocalKeys.darkMode) ?? false;
  runApp(MyApp(isDarkMode: isDarkMode,));
}

class MyApp extends StatelessWidget {
  final bool isDarkMode;
  const MyApp({super.key,required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppRoutes.gallery,
      getPages: AppPages.pages,
      initialBinding: AllBindings(),
      theme: AppThemes.light,
      darkTheme: AppThemes.dark,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
    );
  }
}
