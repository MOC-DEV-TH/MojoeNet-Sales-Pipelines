import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../../../models/dropDownVO.dart';
import '../../../network/RestApi.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_utils.dart';

class NLRStepSixController extends GetxController {
  var reasonTextController = TextEditingController();
  var followUpDateTextController = TextEditingController();
  var contractDateTextController = TextEditingController();
  final count = 0.obs;
  var potentialStatusValue = "1";
  var statusValue = "";
  bool checkBoxValue = false;
  final dataStorage = GetStorage();
  dynamic saleStatusData;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    saleStatusData = dropDownVoFromJson(
        json.decode(dataStorage.read(ALL_DDL_DATA).toString()));
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void increment() => count.value++;



  void onPressContinue(BuildContext context) {
    isLoading(true);
    var map = {
      'uid': dataStorage.read(UID),
      'app_version': app_version,
      'source': dataStorage.read(SOURCE).toString(),
      'business_type': dataStorage.read(BUSINESS_TYPE).toString(),
      'business_name': dataStorage.read(BUSINESS_NAME).toString(),
      'division': dataStorage.read(DIVISION).toString(),
      'township': dataStorage.read(TOWNSHIP).toString(),
      'address': dataStorage.read(ADDRESS).toString(),
      'designation': dataStorage.read(DESIGNATION).toString(),
      'contact_number': dataStorage.read(CONTACT_NUMBER).toString(),
      'contact_person': dataStorage.read(CONTACT_PERSON).toString(),
      'emiail': dataStorage.read(EMAIL).toString(),
      'potential': potentialStatusValue.toString(),
      'status': statusValue.toString(),
      'followup_date': followUpDateTextController.text.toString(),
      'isNotified': checkBoxValue == true ? '1' : '0',
      'reason': reasonTextController.text.toString(),
      'contracted_date': contractDateTextController.text.toString(),
    };
    var smeDataMap = {
      'uid': dataStorage.read(UID),
      'app_version': app_version,
      'source': dataStorage.read(SOURCE).toString(),
      'business_type': dataStorage.read(BUSINESS_TYPE).toString(),
      'sme': dataStorage.read(SME).toString(),
      'business_name': dataStorage.read(BUSINESS_NAME).toString(),
      'division': dataStorage.read(DIVISION).toString(),
      'township': dataStorage.read(TOWNSHIP).toString(),
      'address': dataStorage.read(ADDRESS).toString(),
      'designation': dataStorage.read(DESIGNATION).toString(),
      'contact_number': dataStorage.read(CONTACT_NUMBER).toString(),
      'contact_person': dataStorage.read(CONTACT_PERSON).toString(),
      'emiail': dataStorage.read(EMAIL).toString(),
      'potential': potentialStatusValue.toString(),
      'status': statusValue.toString(),
      'followup_date': followUpDateTextController.text.toString(),
      'isNotified': checkBoxValue == true ? '1' : '0',
      'reason': reasonTextController.text.toString(),
      'contracted_date': contractDateTextController.text.toString(),
    };
    RestApi.postLeadFormData(
            dataStorage.read(BUSINESS_TYPE).toString() == 'SME' ? smeDataMap : map,
            dataStorage.read(TOKEN))
        .then((value) => Future.delayed(Duration.zero, () {
              if (value.status == 'Success') {
                isLoading(false);
                AppUtils.removeLeadDataFromGetStorage();
                Get.offNamed(Routes.SUCCESS_LEAD_INFO);
              } else if (value.responseCode == "005") {
                isLoading(false);
                AppUtils.showSessionExpireDialog(
                    'Fail', 'Session Expired', context);
              } else {
                isLoading(false);
              }
            }));
  }

  void onPressBack() {
    Get.offNamed(Routes.NLR_STEP_FIVE);
  }

  selectContractDateTime() async {
    final DateTime? selected = await showDatePicker(
      initialDate: DateTime.now(),
      context: Get.context!,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selected != null) {
      String dtFormat = DateFormat('yyyy-MM-dd').format(selected);
      debugPrint("DateTimeFormat${dtFormat}");
      contractDateTextController.text = dtFormat.toString();
    }
  }
   selectDateTime() async {
    final DateTime? selected = await showDatePicker(
      initialDate: DateTime.now(),
      context: Get.context!,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selected != null) {
      String dtFormat = DateFormat('yyyy-MM-dd').format(selected);
      debugPrint("DateTimeFormat${dtFormat}");
      followUpDateTextController.text = dtFormat.toString();
    }
  }

  void updatePotential(SaleStatus value) {
    potentialStatusValue = value.key!;
    statusValue = "";
    update();
  }

  void updateStatus(String status) {
    statusValue = status;
    update();
  }

  void updateCheckBoxValue(bool cbValue) {
    debugPrint(cbValue.toString());
    checkBoxValue = cbValue;
    update();
  }
}
