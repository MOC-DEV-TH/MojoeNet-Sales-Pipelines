import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class NLRStepThreeController extends GetxController {
  var businessNameTextController = TextEditingController();
  var addressTextController = TextEditingController();
  final count = 0.obs;
  var divisionStatus = "Yangon";
  var townshipStatus = "";
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

  void updateDivisionStatus(String status){
    divisionStatus = status;
    update();
  }
  void updateTownshipStatus(String status){
    townshipStatus = status;
    update();
  }

  void onPressContinue(){
    Get.offNamed(Routes.NLR_STEP_FOUR);
  }

  void onPressBack(){
    Get.offNamed(Routes.NLR_STEP_TWO);
  }

}


