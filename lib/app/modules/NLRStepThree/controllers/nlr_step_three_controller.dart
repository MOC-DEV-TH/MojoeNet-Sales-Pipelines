import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../models/dropDownVO.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/app_constants.dart';

class NLRStepThreeController extends GetxController {
  var businessNameTextController = TextEditingController();
  var addressTextController = TextEditingController();
  final count = 0.obs;
  var divisionStatus = "";
  var townshipStatus = "";
  dynamic townShipAndDivisionStatusData;
  final dataStorage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    townShipAndDivisionStatusData = dropDownVoFromJson(
        json.decode(dataStorage.read(ALL_DDL_DATA).toString()));

    if (dataStorage.read(BUSINESS_NAME) != null) {
      businessNameTextController.text = dataStorage.read(BUSINESS_NAME);
    }
    if (dataStorage.read(ADDRESS) != null) {
      addressTextController.text = dataStorage.read(ADDRESS);
    }
    if (dataStorage.read(DIVISION) != null) {
      divisionStatus = dataStorage.read(DIVISION);
    }

    if (dataStorage.read(TOWNSHIP) != null) {
      townshipStatus = dataStorage.read(TOWNSHIP);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void increment() => count.value++;

  void updateDivisionStatus(String status) {
    divisionStatus = status;
    update();
  }

  void updateTownshipStatus(String status) {
    townshipStatus = status;
    update();
  }

  bool checkEmptyData() {
    if (addressTextController.text == '' ||
        divisionStatus == '' ||
        townshipStatus == '') {
      return false;
    } else {
      return true;
    }
  }

  void onPressContinue() {
    dataStorage.write(BUSINESS_NAME, businessNameTextController.text);
    dataStorage.write(ADDRESS, addressTextController.text);
    dataStorage.write(DIVISION, divisionStatus);
    dataStorage.write(TOWNSHIP, townshipStatus);
    Get.offNamed(Routes.NLR_STEP_FOUR);
  }

  void onPressBack() {
    Get.offNamed(Routes.NLR_STEP_TWO);
  }
}
