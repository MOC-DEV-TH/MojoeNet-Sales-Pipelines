import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../models/dropDownVO.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/app_constants.dart';

class NLRStepTwoController extends GetxController {

  var isSelected = -1;
  var isSelectedValue = '';
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
    update();
  }

  void navigateToSME(){
    Get.offNamed(Routes.SME);
  }

  void onPressContinue(){
    Get.offNamed(Routes.NLR_STEP_THREE);
  }

  void onPressBack(){
    Get.offNamed(Routes.NLR_STEP_ONE);
  }

}


