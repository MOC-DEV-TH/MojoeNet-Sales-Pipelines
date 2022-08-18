import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../models/dropDownVO.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/app_constants.dart';

class NLRStepTwoController extends GetxController {

  var noteController = TextEditingController();
  dynamic isSelected = -1;
  var isSelectedValue = '';
  var selectedItemValue = '';
  final count = 0.obs;
  dynamic saleBusinessTypeData;
  final dataStorage = GetStorage();
  @override
  void onInit() {
    super.onInit();
    saleBusinessTypeData =
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
    selectedItemValue = saleBusinessTypeData
        .saleBusinessType[value].value;
    update();
  }

  void navigateToSME(){
    Get.offNamed(Routes.SME);
  }

  void onPressContinue(){
    dataStorage.write(BUSINESS_TYPE_OTHER, noteController.text);
    Get.offNamed(Routes.NLR_STEP_THREE);
  }

  void onPressBack(){
    Get.offNamed(Routes.NLR_STEP_ONE);
  }

}


