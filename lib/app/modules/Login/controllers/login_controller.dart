import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_pipeline/app/routes/app_pages.dart';

class LoginController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

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

  void onPressLogin() {
    Get.offNamed(Routes.TASK_SELECTION);
  }
}
