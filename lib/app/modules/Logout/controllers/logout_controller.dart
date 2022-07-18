import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:get/get.dart';

import '../../../../res/colors.dart';

class LogoutController extends GetxController {
  var businessNameTextController = TextEditingController();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
