import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sales_pipeline/app/models/post_lead_vo.dart';

import '../../../models/dropDownVO.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/app_constants.dart';

class NLRStepOneController extends GetxController {
  final count = 0.obs;
  dynamic isSelected = -1;
  var isSelectedValue = '';
  dynamic saleSourceData;
  final dataStorage = GetStorage();
  var postLeadData = PostLeadVO();

  @override
  void onInit() {
    super.onInit();
    saleSourceData = dropDownVoFromJson(
        json.decode(dataStorage.read(ALL_DDL_DATA).toString()));
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void increment() => count.value++;

   updateSelectedItem(int value) {
    isSelected = value;
    isSelectedValue = value.toString();
    update();
  }

  void updateSelectedValue(String value){

    update();
  }


  void updatePostLeadData(
    String source,
    String businessType,
    String businessName,
    String division,
    String location,
    String address,
    String designation,
    String contact_number,
    String contact_person,
    String email,
    String potential,
  ) {
    postLeadData = PostLeadVO(
        uid: dataStorage.read(UID),
        app_version: app_version,
        source: source,
        business_type: businessType,
        business_name: businessName,
        division: division,
        location: location,
        address: address,
        designation: designation,
        contact_number: contact_number,
        contact_person: contact_person,
        email: email,
        potential: potential);
  }

  void onPressContinue() {
    Get.offNamed(Routes.NLR_STEP_TWO);
  }

  void onPressBack() {
    Get.offNamed(Routes.TASK_SELECTION);
  }
}
