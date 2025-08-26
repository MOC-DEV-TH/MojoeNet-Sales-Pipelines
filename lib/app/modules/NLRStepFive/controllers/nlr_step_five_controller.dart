import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sales_pipeline/app/utils/app_utils.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/app_constants.dart';

class NLRStepFiveController extends GetxController {
  var nameController = TextEditingController();
  var contactNoController = TextEditingController();
  var secondaryContactNoController = TextEditingController();
  var emailController = TextEditingController();
  final dataStorage = GetStorage();
  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();

    if(dataStorage.read(CONTACT_PERSON)!=null){
      nameController.text = dataStorage.read(CONTACT_PERSON);
    }
     if(dataStorage.read(CONTACT_NUMBER)!=null){
      contactNoController.text = dataStorage.read(CONTACT_NUMBER);
    }
     if(dataStorage.read(EMAIL)!=null){
      emailController.text = dataStorage.read(EMAIL);
    }
    if(dataStorage.read(SECONDARY_CONTACT_NUMBER)!=null){
      secondaryContactNoController.text = dataStorage.read(SECONDARY_CONTACT_NUMBER);
    }

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void increment() => count.value++;

  bool checkEmptyData() {
    if (nameController.text == '' || contactNoController.text == '') {
      return false;
    } else {
      return true;
    }
  }

  onChangedName(String value){
    nameController.text = value;
    update();
  }

  onChangedPrimaryContactNumber(String value){
    contactNoController.text = value;
    update();
  }

  onChangedEmail(String value){
    emailController.text = value;
    update();
  }

  void onPressContinue() {
    dataStorage.write(CONTACT_PERSON, nameController.text.toString());
    dataStorage.write(CONTACT_NUMBER, contactNoController.text.toString());
    dataStorage.write(SECONDARY_CONTACT_NUMBER, secondaryContactNoController.text.toString());
    dataStorage.write(EMAIL, emailController.text.toString());
    if(emailController.text !=""){
      if(EmailValidator.validate(emailController.text)==true){
        Get.offNamed(Routes.NLR_STEP_SIX);
      }
      else {
        AppUtils.showErrorSnackBar("Fail", 'Invalid Email Format');
      }
    }
    else {
      Get.offNamed(Routes.NLR_STEP_SIX);
    }
  }

  void onPressBack() {
    Get.offNamed(Routes.NLR_STEP_FOUR);
  }
}
