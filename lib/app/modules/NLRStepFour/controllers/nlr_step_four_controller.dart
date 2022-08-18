import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../models/dropDownVO.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/app_constants.dart';

class NLRStepFourController extends GetxController {
  var noteController = TextEditingController();
  final count = 0.obs;
  dynamic isSelected = -1;
  var isSelectedValue = '';
  dynamic saleDesignationData;
  final dataStorage = GetStorage();

  var selectedItemValue = "";

  @override
  void onInit() {
    super.onInit();
    saleDesignationData =
        dropDownVoFromJson(json.decode(dataStorage.read(ALL_DDL_DATA).toString()));
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
    isSelectedValue = value.toString();
    selectedItemValue = saleDesignationData
        .saleDesignation[value].value;
    update();
  }

  void onPressContinue(){
    dataStorage.write(DESIGNATION_OTHER, noteController.text);
    Get.offNamed(Routes.NLR_STEP_FIVE);
  }

  void onPressBack(){
    Get.offNamed(Routes.NLR_STEP_THREE);
  }

}


