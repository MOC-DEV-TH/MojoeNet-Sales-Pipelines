import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class NLRStepFiveController extends GetxController {
  var nameController = TextEditingController();
  var contactNoController = TextEditingController();
  var emailController = TextEditingController();
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

  void onPressContinue(){
    Get.offNamed(Routes.NLR_STEP_SIX);
  }

  void onPressBack(){
    Get.offNamed(Routes.NLR_STEP_FOUR);
  }

}


