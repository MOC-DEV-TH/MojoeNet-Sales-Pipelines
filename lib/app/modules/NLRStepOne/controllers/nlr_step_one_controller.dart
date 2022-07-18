import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class NLRStepOneController extends GetxController {

  final count = 0.obs;
  var isSelected = -1;
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

  void updateSelectedItem(int value){
    isSelected = value;
    update();
  }

  void onPressContinue(){
    Get.offNamed(Routes.NLR_STEP_TWO);
  }

  void onPressBack(){
    Get.offNamed(Routes.TASK_SELECTION);
  }
}


