import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/app_constants.dart';

class NLRStepFiveController extends GetxController {
  var nameController = TextEditingController();
  var contactNoController = TextEditingController();
  var emailController = TextEditingController();
  final dataStorage = GetStorage();
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

  bool checkEmptyData() {
    if (nameController.text == '' ||
        contactNoController.text == '' ||
        emailController.text == '') {
      return false;
    } else {
      return true;
    }
  }

  void onPressContinue() {
    dataStorage.write(CONTACT_PERSON, nameController.text);
    dataStorage.write(CONTACT_NUMBER, contactNoController.text);
    dataStorage.write(EMAIL, emailController.text);
    Get.offNamed(Routes.NLR_STEP_SIX);
  }

  void onPressBack() {
    Get.offNamed(Routes.NLR_STEP_FOUR);
  }
}
