import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ForgotPasswordController extends GetxController {
  var emailTextController = TextEditingController();
  final count = 0.obs;
  var isLoading = false.obs;
  final writeData = GetStorage();

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

  void onPressSubmit(){

  }

}
