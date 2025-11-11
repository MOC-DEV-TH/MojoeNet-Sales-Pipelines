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

  var estContractDateTextController = TextEditingController();
  var estStartDateTextController = TextEditingController();
  var estFollowUpDateTextController = TextEditingController();

  var appointmentDateTextController = TextEditingController();
  var customerNoteTextController = TextEditingController();
  var amountTextController = TextEditingController();
  var latTextController = TextEditingController();
  var longTextController = TextEditingController();
  final count = 0.obs;
  var potentialStatusValue = "1";
  var statusValue = "";
  bool checkBoxValue = false;
  bool referalCheckBoxValue = false;
  final dataStorage = GetStorage();
  dynamic saleStatusData;
  var planValue = "";
  var isLoading = false.obs;
  var packageValue = "";
  var discountValue = "0%";

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

  bool checkEmptyData() {
    if (potentialStatusValue=="1") {
      if(statusValue != "" && planValue != "" && amountTextController.text != "" && packageValue != "") {
        return true;
      } else
      {
        return false;
      }
    } else {
      if(statusValue!=""){
        return true;
      }
      else {
        return false;
      }
    }
  }

  void selectPlan(Plan valueData) {
    planValue = valueData.value.toString();
    amountTextController.text = saleStatusData.package
        .firstWhere((package) => package.plan == valueData.value)
        .value;
    packageValue = saleStatusData.package
        .firstWhere((package) => package.plan == valueData.value)
        .key;
    update();
  }

  void selectPackage(Package data) {
    packageValue = data.key.toString();
    amountTextController.text = data.value.toString();
    update();
  }

  void selectDiscount(Discount data) {
    discountValue = data.value.toString();
    update();
  }

  // void onPressContinue(BuildContext context) {
  //   isLoading(true);
  //   var map = {
  //     'uid': dataStorage.read(UID),
  //     'app_version': app_version,
  //     'source': dataStorage.read(SOURCE).toString(),
  //     'business_type': dataStorage.read(BUSINESS_TYPE).toString(),
  //     'business_name': dataStorage.read(BUSINESS_NAME).toString(),
  //     'division': dataStorage.read(DIVISION).toString(),
  //     'township': dataStorage.read(TOWNSHIP).toString(),
  //     'address': dataStorage.read(ADDRESS).toString(),
  //     'contact_number': dataStorage.read(CONTACT_NUMBER).toString(),
  //     'secondary_contact_number': dataStorage.read(SECONDARY_CONTACT_NUMBER).toString(),
  //     'contact_person': dataStorage.read(CONTACT_PERSON).toString(),
  //     'email': dataStorage.read(EMAIL).toString(),
  //
  //     'designation': dataStorage.read(DESIGNATION).toString(),
  //     'potential': potentialStatusValue.toString(),
  //     'designation_other': dataStorage.read(DESIGNATION_OTHER).toString(),
  //     'business_type_other': dataStorage.read(BUSINESS_TYPE_OTHER).toString(),
  //     'status': statusValue.toString(),
  //     'followup_date': followUpDateTextController.text.toString(),
  //     'isNotified': checkBoxValue == true ? '1' : '0',
  //     'isReferral': referalCheckBoxValue == true ? '1' : '0',
  //     'reason': reasonTextController.text.toString(),
  //     'contracted_date': contractDateTextController.text.toString()==""?null: contractDateTextController.text.toString(),
  //     'installation_appointment_date': appointmentDateTextController.text.toString()==""?null:appointmentDateTextController.text.toString(),
  //     'customer_note': customerNoteTextController.text.toString(),
  //     'lat': latTextController.text.toString(),
  //     'long': longTextController.text.toString(),
  //     'amount': potentialStatusValue == '0'
  //         ? ""
  //         : amountTextController.text.toString(),
  //     'plan': potentialStatusValue == '0' ? "" : planValue.toString(),
  //     'package': potentialStatusValue == '0' ? "" : packageValue.toString(),
  //     'discount': potentialStatusValue == '0' ? "" : discountValue.toString(),
  //   };
  //   var smeDataMap = {
  //     'uid': dataStorage.read(UID),
  //     'app_version': app_version,
  //     'source': dataStorage.read(SOURCE).toString(),
  //     'business_type': dataStorage.read(BUSINESS_TYPE).toString(),
  //     'sme': dataStorage.read(SME).toString(),
  //     'business_name': dataStorage.read(BUSINESS_NAME).toString(),
  //     'division': dataStorage.read(DIVISION).toString(),
  //     'township': dataStorage.read(TOWNSHIP).toString(),
  //     'address': dataStorage.read(ADDRESS).toString(),
  //
  //     'contact_number': dataStorage.read(CONTACT_NUMBER).toString(),
  //     'secondary_contact_number': dataStorage.read(SECONDARY_CONTACT_NUMBER).toString(),
  //     'contact_person': dataStorage.read(CONTACT_PERSON).toString(),
  //     'designation_other': dataStorage.read(DESIGNATION_OTHER).toString(),
  //     'business_type_other': dataStorage.read(BUSINESS_TYPE_OTHER).toString(),
  //     'email': dataStorage.read(EMAIL).toString(),
  //
  //     'designation': dataStorage.read(DESIGNATION).toString(),
  //     'potential': potentialStatusValue.toString(),
  //     'status': statusValue.toString(),
  //     'followup_date': followUpDateTextController.text.toString(),
  //     'isNotified': checkBoxValue == true ? '1' : '0',
  //     'isReferral': referalCheckBoxValue == true ? '1' : '0',
  //     'reason': reasonTextController.text.toString(),
  //     'contracted_date': contractDateTextController.text.toString()==""?null: contractDateTextController.text.toString(),
  //     'installation_appointment_date': appointmentDateTextController.text.toString()==""?null:appointmentDateTextController.text.toString(),
  //     'customer_note': customerNoteTextController.text.toString(),
  //     'lat': latTextController.text.toString(),
  //     'long': longTextController.text.toString(),
  //     'amount': potentialStatusValue == '0'
  //         ? ""
  //         : amountTextController.text.toString(),
  //     'plan': potentialStatusValue == '0' ? "" : planValue.toString(),
  //     'package': potentialStatusValue == '0' ? "" : packageValue.toString(),
  //     'discount': potentialStatusValue == '0' ? "" : discountValue.toString(),
  //   };
  //
  //   if(statusValue=="Contracted"){
  //     if (checkLatLongLength(latTextController.text.toString()) == false) {
  //       isLoading(false);
  //       AppUtils.showErrorSnackBar(
  //           'Fail', 'Latitude field must be filled with format(00.000000)');
  //     }
  //    else if (checkLatLongLength(longTextController.text.toString()) == false) {
  //       isLoading(false);
  //       AppUtils.showErrorSnackBar(
  //           'Fail', 'Longitude field must be filled with format(00.000000)');
  //     }
  //    else {
  //       RestApi.postLeadFormData(
  //           dataStorage.read(BUSINESS_TYPE).toString() == 'SME'
  //               ? smeDataMap
  //               : map,
  //           dataStorage.read(TOKEN))
  //           .then((value) =>
  //           Future.delayed(Duration.zero, () {
  //             if (value.status == 'Success') {
  //               isLoading(false);
  //               AppUtils.removeLeadDataFromGetStorage();
  //               Get.offNamed(Routes.SUCCESS_LEAD_INFO);
  //             } else if (value.responseCode == "005") {
  //               isLoading(false);
  //               AppUtils.showSessionExpireDialog(
  //                   'Fail', 'Session Expired', context);
  //             } else {
  //               isLoading(false);
  //             }
  //           }));
  //     }
  //   }
  //   else {
  //     RestApi.postLeadFormData(
  //         dataStorage.read(BUSINESS_TYPE).toString() == 'SME'
  //             ? smeDataMap
  //             : map,
  //         dataStorage.read(TOKEN))
  //         .then((value) =>
  //         Future.delayed(Duration.zero, () {
  //           if (value.status == 'Success') {
  //             isLoading(false);
  //             AppUtils.removeLeadDataFromGetStorage();
  //             Get.offNamed(Routes.SUCCESS_LEAD_INFO);
  //           } else if (value.responseCode == "005") {
  //             isLoading(false);
  //             AppUtils.showSessionExpireDialog(
  //                 'Fail', 'Session Expired', context);
  //           } else {
  //             isLoading(false);
  //           }
  //         }));
  //   }
  // }


  void onPressContinue(BuildContext context) {
    isLoading(true);

    Map<String, dynamic> map = {
      'uid': dataStorage.read(UID),
      'app_version': app_version,
      'source': dataStorage.read(SOURCE).toString(),
      'business_type': dataStorage.read(BUSINESS_TYPE).toString(),
      'business_name': dataStorage.read(BUSINESS_NAME).toString(),
      'division': dataStorage.read(DIVISION).toString(),
      'township': dataStorage.read(TOWNSHIP).toString(),
      'address': dataStorage.read(ADDRESS).toString(),
      'contact_number': dataStorage.read(CONTACT_NUMBER).toString(),
      'secondary_contact_number': dataStorage.read(SECONDARY_CONTACT_NUMBER).toString(),
      'contact_person': dataStorage.read(CONTACT_PERSON).toString(),
      'email': dataStorage.read(EMAIL).toString(),
      'designation': dataStorage.read(DESIGNATION).toString(),
      'designation_other': dataStorage.read(DESIGNATION_OTHER).toString(),
      'business_type_other': dataStorage.read(BUSINESS_TYPE_OTHER).toString(),

      'potential': potentialStatusValue.toString(),
      'status': statusValue.toString(),
      'followup_date': followUpDateTextController.text.toString(),
      'isNotified': checkBoxValue == true ? '1' : '0',
      'isReferral': referalCheckBoxValue == true ? '1' : '0',
      'reason': reasonTextController.text.toString(),
      'contracted_date': contractDateTextController.text.toString().isEmpty ? null : contractDateTextController.text.toString(),
      'installation_appointment_date': appointmentDateTextController.text.toString().isEmpty ? null : appointmentDateTextController.text.toString(),
      'customer_note': customerNoteTextController.text.toString(),
      'lat': latTextController.text.toString(),
      'long': longTextController.text.toString(),
      'amount': potentialStatusValue == '0' ? "" : amountTextController.text.toString(),
      'plan': potentialStatusValue == '0' ? "" : planValue.toString(),
      'package': potentialStatusValue == '0' ? "" : packageValue.toString(),
      'discount': potentialStatusValue == '0' ? "" : discountValue.toString(),
    };

    Map<String, dynamic> smeDataMap = {
      'uid': dataStorage.read(UID),
      'app_version': app_version,
      'source': dataStorage.read(SOURCE).toString(),
      'business_type': dataStorage.read(BUSINESS_TYPE).toString(),
      'sme': dataStorage.read(SME).toString(),
      'business_name': dataStorage.read(BUSINESS_NAME).toString(),
      'division': dataStorage.read(DIVISION).toString(),
      'township': dataStorage.read(TOWNSHIP).toString(),
      'address': dataStorage.read(ADDRESS).toString(),
      'contact_number': dataStorage.read(CONTACT_NUMBER).toString(),
      'secondary_contact_number': dataStorage.read(SECONDARY_CONTACT_NUMBER).toString(),
      'contact_person': dataStorage.read(CONTACT_PERSON).toString(),
      'designation_other': dataStorage.read(DESIGNATION_OTHER).toString(),
      'business_type_other': dataStorage.read(BUSINESS_TYPE_OTHER).toString(),
      'email': dataStorage.read(EMAIL).toString(),
      'designation': dataStorage.read(DESIGNATION).toString(),


      'potential': potentialStatusValue.toString(),
      'status': statusValue.toString(),
      'followup_date': followUpDateTextController.text.toString(),
      'isNotified': checkBoxValue == true ? '1' : '0',
      'isReferral': referalCheckBoxValue == true ? '1' : '0',
      'reason': reasonTextController.text.toString(),
      'contracted_date': contractDateTextController.text.toString().isEmpty ? null : contractDateTextController.text.toString(),
      'installation_appointment_date': appointmentDateTextController.text.toString().isEmpty ? null : appointmentDateTextController.text.toString(),
      'customer_note': customerNoteTextController.text.toString(),
      'lat': latTextController.text.toString(),
      'long': longTextController.text.toString(),
      'amount': potentialStatusValue == '0' ? "" : amountTextController.text.toString(),
      'plan': potentialStatusValue == '0' ? "" : planValue.toString(),
      'package': potentialStatusValue == '0' ? "" : packageValue.toString(),
      'discount': potentialStatusValue == '0' ? "" : discountValue.toString(),
    };

    /// Remove null or empty values
    Map<String, dynamic> cleanedMap = removeEmptyOrNullFields(map);
    Map<String, dynamic> cleanedSmeDataMap = removeEmptyOrNullFields(smeDataMap);

    if (statusValue == "Contracted") {
      if (!checkLatLongLength(latTextController.text.toString())) {
        isLoading(false);
        AppUtils.showErrorSnackBar('Fail', 'Latitude field must be filled with format(00.000000)');
      } else if (!checkLatLongLength(longTextController.text.toString())) {
        isLoading(false);
        AppUtils.showErrorSnackBar('Fail', 'Longitude field must be filled with format(00.000000)');
      } else {
        Get.offNamed(Routes.SUCCESS_LEAD_INFO);
        // RestApi.postLeadFormData(
        //   dataStorage.read(BUSINESS_TYPE).toString() == 'SME' ? cleanedSmeDataMap : cleanedMap,
        //   dataStorage.read(TOKEN),
        // ).then((value) => Future.delayed(Duration.zero, () {
        //   if (value.status == 'Success') {
        //     isLoading(false);
        //     AppUtils.removeLeadDataFromGetStorage();
        //     Get.offNamed(Routes.SUCCESS_LEAD_INFO);
        //   } else if (value.responseCode == "005") {
        //     isLoading(false);
        //     AppUtils.showSessionExpireDialog('Fail', 'Session Expired', context);
        //   } else {
        //     isLoading(false);
        //   }
        // }));
      }
    } else {
      Get.offNamed(Routes.N_L_R_STEP_SEVEN);
    }
    //   RestApi.postLeadFormData(
    //     dataStorage.read(BUSINESS_TYPE).toString() == 'SME' ? cleanedSmeDataMap : cleanedMap,
    //     dataStorage.read(TOKEN),
    //   ).then((value) => Future.delayed(Duration.zero, () {
    //     if (value.status == 'Success') {
    //       isLoading(false);
    //       AppUtils.removeLeadDataFromGetStorage();
    //       Get.offNamed(Routes.SUCCESS_LEAD_INFO);
    //     } else if (value.responseCode == "005") {
    //       isLoading(false);
    //       AppUtils.showSessionExpireDialog('Fail', 'Session Expired', context);
    //     } else {
    //       isLoading(false);
    //     }
    //   }));
    // }
  }



  Map<String, dynamic> removeEmptyOrNullFields(Map<String, dynamic> inputMap) {
    final result = <String, dynamic>{};
    inputMap.forEach((key, value) {
      if (value != null && value.toString().trim().isNotEmpty) {
        result[key] = value;
      }
    });
    return result;
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

  selectAppointmentDateTime() async {
    final DateTime? selected = await showDatePicker(
      initialDate: DateTime.now(),
      context: Get.context!,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selected != null) {
      String dtFormat = DateFormat('yyyy-MM-dd').format(selected);
      debugPrint("DateTimeFormat${dtFormat}");
      appointmentDateTextController.text = dtFormat.toString();
    }
  }

  selectDate(TextEditingController controller) async {
    final DateTime? selected = await showDatePicker(
      initialDate: DateTime.now(),
      context: Get.context!,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selected != null) {
      String dtFormat = DateFormat('yyyy-MM-dd').format(selected);
      debugPrint("DateTimeFormat${dtFormat}");
      controller.text = dtFormat.toString();
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
    planValue="";
    amountTextController.text="xxxxxxxx";
    packageValue="";
    discountValue="";
    checkBoxValue = false;
    referalCheckBoxValue = false;
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

  void updateReferalCheckBoxValue(bool cbValue) {
    debugPrint(cbValue.toString());
    referalCheckBoxValue = cbValue;
    update();
  }
}
bool checkLatLongLength(String str) {
  final lat = str.split('.');
  List latList = [];
  for (int i = 0; i < lat.length; i++) {
    latList.add(lat[i]);
  }
  debugPrint(latList.length.toString());

  if (latList.length >= 2) {
    debugPrint(latList[0].toString().length.toString());
    debugPrint(latList[1].toString().length.toString());
    if (latList[0].toString().length != 2) {
      return false;
    } else if (latList[1].toString().length != 6) {
      return false;
    } else {
      return true;
    }
  } else {
    return false;
  }
}
