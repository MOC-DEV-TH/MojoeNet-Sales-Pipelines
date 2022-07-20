import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class NLRStepSixController extends GetxController {
  var reasonTextController = TextEditingController();
  final count = 0.obs;
  var potentialStatus = "Yes";
  var potentialYesStatus = "";
  bool checkBoxValue = false;
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
    Get.offNamed(Routes.SUCCESS_LEAD_INFO);
  }

  void onPressBack(){
    Get.offNamed(Routes.NLR_STEP_FIVE);
  }

  void updatePotentialStatus(String status){
    potentialStatus = status;
    update();
  }

  void updatePotentialYesStatus(String status){
    potentialYesStatus = status;
    update();
  }

  void updateCheckBoxValue(bool cbValue) {
    debugPrint(cbValue.toString());
    checkBoxValue = cbValue;
    update();
  }

}


