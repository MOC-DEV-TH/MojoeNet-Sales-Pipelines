import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../network/RestApi.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_utils.dart';
import '../../NLRStepSix/controllers/nlr_step_six_controller.dart';

class NLRStepSevenController extends GetxController {
  var meetingNoteController = TextEditingController();
  var nextStepController = TextEditingController();

  final s6 = Get.find<NLRStepSixController>();

  final count = 0.obs;
  var isLoading = false.obs;
  final dataStorage = GetStorage();


  @override
  void onInit() {
    meetingNoteController.addListener(() => update(['continue_btn']));
    nextStepController.addListener(() => update(['continue_btn']));
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  bool checkEmptyData() =>
      meetingNoteController.text.isNotEmpty &&
          nextStepController.text.isNotEmpty;

  void onPressContinue(BuildContext context){
    isLoading(true);

    Map<String, dynamic> map = {
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
      'email': dataStorage.read(EMAIL).toString(),
      'designation': dataStorage.read(DESIGNATION).toString(),
      'designation_other': dataStorage.read(DESIGNATION_OTHER).toString(),
      'business_type_other': dataStorage.read(BUSINESS_TYPE_OTHER).toString(),

      'potential': s6.potentialStatusValue,
      'status': s6.statusValue,
      'followup_date': s6.followUpDateTextController.text,
      'isNotified': s6.checkBoxValue ? '1' : '0',
      'isReferral': s6.referalCheckBoxValue ? '1' : '0',
      'reason': s6.reasonTextController.text,
      'contracted_date':
      s6.contractDateTextController.text.isEmpty ? null : s6.contractDateTextController.text,
      'installation_appointment_date':
      s6.appointmentDateTextController.text.isEmpty ? null : s6.appointmentDateTextController.text,
      'customer_note': s6.customerNoteTextController.text,
      'lat': s6.latTextController.text,
      'long': s6.longTextController.text,
      'amount': s6.potentialStatusValue == '0' ? "" : s6.amountTextController.text,
      'plan': s6.potentialStatusValue == '0' ? "" : s6.planValue,
      'package': s6.potentialStatusValue == '0' ? "" : s6.packageValue,
      'discount': s6.potentialStatusValue == '0' ? "" : s6.discountValue,

      ///new field
      'meeting_notes': meetingNoteController.text,
      'next_step': nextStepController.text,
    };

    Map<String, dynamic> cleanedMap = removeEmptyOrNullFields(map);

    RestApi.postLeadFormData(
      cleanedMap,
      dataStorage.read(TOKEN),
    ).then((value) => Future.delayed(Duration.zero, () {
      if (value.status == 'Success') {
        isLoading(false);
        AppUtils.removeLeadDataFromGetStorage();
        Get.offNamed(Routes.SUCCESS_LEAD_INFO);
      } else if (value.responseCode == "005") {
        isLoading(false);
        AppUtils.showSessionExpireDialog('Fail', 'Session Expired', context);
      } else {
        isLoading(false);
      }
    }));
  }

Map<String, dynamic> removeEmptyOrNullFields(Map<String, dynamic> inputMap) {
  final result = <String, dynamic>{};
  inputMap.forEach((key, value) {
    if (value != null && value!= 'null' && value.toString().trim().isNotEmpty) {
      result[key] = value;
    }
  });
  return result;
}

  void onPressBack() {
    Get.offNamed(Routes.NLR_STEP_SIX);
  }

  void increment() => count.value++;
}
