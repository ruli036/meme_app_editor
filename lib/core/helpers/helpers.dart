import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

Size size() {
  return MediaQuery.of(Get.context!).size;
}

Widget verticalSpace() {
  return SizedBox(height: 16);
}
