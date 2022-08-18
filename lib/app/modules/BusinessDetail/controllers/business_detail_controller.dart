import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:sales_pipeline/app/models/business_detail_vo.dart';
import '../../../models/dropDownVO.dart';
import '../../../network/RestApi.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_utils.dart';

class BusinessDetailController extends GetxController {
  var businessNameTextController = TextEditingController();
  var contactPersonTextController = TextEditingController();
  var primaryContactNoTextController = TextEditingController();
  var secondaryContactNoTextController = TextEditingController();
  var emailTextController = TextEditingController();
  var currentISPTextController = TextEditingController();
  var leadStatusTextController = TextEditingController();
  var remindMeDateTextController = TextEditingController();
  var weightTextController = TextEditingController();
  var dateTimeTextController = TextEditingController();
  var estimateFlightDateTextController = TextEditingController();

  var currentPlanTextController = TextEditingController();
  var currentPackageTextController = TextEditingController();
  var amountTextController = TextEditingController();
  var discountTextController = TextEditingController();

  var contractDateTextController = TextEditingController();
  var appointmentDateTextController = TextEditingController();
  var customerNoteTextController = TextEditingController();
  var latTextController = TextEditingController();
  var longTextController = TextEditingController();

  var businessTypeOtherTextController = TextEditingController();
  var designationTypeOtherTextController = TextEditingController();


  final count = 0.obs;
  var leadStatusName = '';
  var followUpViaStatusName = '';
  final dataStorage = GetStorage();
  dynamic saleStatusData;
  var activityDetailData = Details().obs;
  var isLoading = false.obs;

  var planValue = "";
  var packageValue = "";
  var discountValue = "0%";
  var townshipStatus = "";
  var leadSourceStatus = "";
  var businessTypeStatus = "";
  var divisionStatus = "";
  var designationStatus = "";

  @override
  void onInit() {
    fetchActivityBusinessDetail(Get.arguments.toString());
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

  void selectDateTime(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      initialDate: DateTime.now(),
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selected != null) {
      String dtFormat = DateFormat('yyyy-MM-dd').format(selected);
      debugPrint("DateTimeFormat${dtFormat}");
      dateTimeTextController.text = dtFormat.toString();
    }
  }

  void selectEstimateFlightDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      initialDate: DateTime.now(),
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selected != null) {
      String dtFormat = DateFormat('yyyy-MM-dd').format(selected);
      debugPrint("DateTimeFormat${dtFormat}");
      estimateFlightDateTextController.text = dtFormat.toString();
    }
  }

  void updateTownshipStatus(String status) {
    townshipStatus = status;
    update();
  }

  void selectPlan(Plan valueData) {
    planValue = valueData.value.toString();
    packageValue = saleStatusData.package
        .firstWhere((package) => package.plan == valueData.value)
        .key;
    amountTextController.text = saleStatusData.package
        .firstWhere((package) => package.plan == valueData.value)
        .value;
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

  void updateLeadStatus(SaleStatus data) {
    leadStatusName = data.value!;
    weightTextController.text = data.weight!;
    update();
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

  void updateFollowUpViaStatus(FollowUpVia status) {
    followUpViaStatusName = status.value!;
    update();
  }

  void onPressEdit() {}

  void onPressBack() {
    Get.back();
  }

  void fetchActivityBusinessDetail(String leadID, {BuildContext? context}) {
    isLoading(true);
    RestApi.fetchActivityBusinessDetailById(
            dataStorage.read(TOKEN), dataStorage.read(UID), leadID)
        .then((value) => {
              if (value.status == 'Success')
                {
                  activityDetailData.value = value.details!,
                  setDataToTextController(value.details!),
                  isLoading(false)
                }
              else if (value.responseCode == '005')
                {
                  isLoading(false),
                  AppUtils.showSessionExpireDialog(
                      'Fail', 'Session Expired', Get.context!)
                }
              else
                {isLoading(false)}
            });
  }

  void setDataToTextController(Details data) {
    contactPersonTextController.text = data.firstname.toString();
    dateTimeTextController.text = data.followupDate.toString();
    weightTextController.text = data.weighted.toString();
    leadStatusName = data.status.toString();
    followUpViaStatusName = data.followupVia.toString();

    (data.leadSource.toString() == 'null')
        ? leadSourceStatus = ''
        : leadSourceStatus = data.leadSource.toString();

    (data.businessType.toString() == 'null')
        ? businessTypeStatus = ''
        : businessTypeStatus = data.businessType.toString();

    (data.businessTypeOther.toString() == 'null')
        ? businessTypeOtherTextController.text = ''
        : businessTypeOtherTextController.text = data.businessTypeOther.toString();

    (data.designationTypeOther.toString() == 'null')
        ? designationTypeOtherTextController.text = ''
        : designationTypeOtherTextController.text = data.designationTypeOther.toString();

    (data.designation.toString() == 'null')
        ? designationStatus = ''
        : designationStatus = data.designation.toString();

    (data.division.toString() == 'null')
        ? divisionStatus = ''
        : divisionStatus = data.division.toString();

    (data.township.toString() == 'null')
        ? townshipStatus = ''
        : townshipStatus = data.township.toString();

    data.estimateFlightdate.toString() == 'null'
        ? estimateFlightDateTextController.text = ''
        : estimateFlightDateTextController.text =
            data.estimateFlightdate.toString();

    data.contactno.toString() == 'null'
        ? primaryContactNoTextController.text = ''
        : primaryContactNoTextController.text = data.contactno.toString();

    data.secondaryContactNumber.toString() == 'null'
        ? secondaryContactNoTextController.text = ''
        : secondaryContactNoTextController.text = data.secondaryContactNumber.toString();

    data.email.toString() == 'null'
        ? emailTextController.text = ''
        : emailTextController.text = data.email.toString();

    (data.currentIsp.toString() == 'null')
        ? currentISPTextController.text = ''
        : currentISPTextController.text = data.currentIsp.toString();

    data.followupDate.toString() == 'null'
        ? dateTimeTextController.text = ''
        : dateTimeTextController.text = data.followupDate.toString();

    data.plan.toString() == 'null'
        ? currentPlanTextController.text = ''
        : currentPlanTextController.text = data.plan.toString();

    data.package.toString() == 'null'
        ? currentPackageTextController.text = ''
        : currentPackageTextController.text = data.package.toString();

    data.packageTotal.toString() == 'null'
        ? amountTextController.text = ''
        : amountTextController.text = data.packageTotal.toString();

    data.discount.toString() == 'null'
        ? discountTextController.text = ''
        : discountTextController.text = data.discount.toString();

    (data.businessName.toString() == 'null')
        ? businessNameTextController.text = ''
        : businessNameTextController.text = data.businessName.toString();

    (data.latitude.toString() == 'null')
        ? latTextController.text = ''
        : latTextController.text = data.latitude.toString();

    (data.longitude.toString() == 'null')
        ? longTextController.text = ''
        : longTextController.text = data.longitude.toString();

    (data.installationAppointmentDate.toString() == 'null')
        ? appointmentDateTextController.text = ''
        : appointmentDateTextController.text =
            data.installationAppointmentDate.toString();

    (data.contractDate.toString() == 'null')
        ? contractDateTextController.text = ''
        : contractDateTextController.text = data.contractDate.toString();

    (data.customerNote.toString() == 'null')
        ? customerNoteTextController.text = ''
        : customerNoteTextController.text = data.customerNote.toString();
    // currentPlanTextController.text = data.plan.toString();
    // currentPackageTextController.text = data.package.toString();
  }

  void onPressSave() {
    isLoading(true);
    var map = {
      'lid': Get.arguments.toString(),
      'uid': dataStorage.read(UID),
      'app_version': app_version,
      'source': leadSourceStatus,
      'business_type': businessTypeStatus,
      'business_name': businessNameTextController.text.toString() == ''
          ? ""
          : businessNameTextController.text.toString(),
      'designation': designationStatus,
      'contact_person': contactPersonTextController.text.toString() == 'null'
          ? ""
          : contactPersonTextController.text.toString(),
      'potential': activityDetailData.value.potential,
      'status': leadStatusName.toString(),
      "followup_via": followUpViaStatusName.toString() == 'null'
          ? ""
          : followUpViaStatusName.toString(),
      "estimate_flightdate":
          estimateFlightDateTextController.text.toString() == ''
              ? ""
              : estimateFlightDateTextController.text.toString(),
      "current_isp": currentISPTextController.text.toString() == ''
          ? ""
          : currentISPTextController.text.toString(),
      "followup_date": dateTimeTextController.text.toString(),
      "weight": weightTextController.text.toString(),
      'amount': amountTextController.text,
      'division': divisionStatus,
      'township': townshipStatus,
      'package': packageValue == ""
          ? currentPackageTextController.text
          : packageValue.toString(),
      'plan': planValue == ""
          ? currentPlanTextController.text
          : planValue.toString(),
      'discount': discountValue,
      'contracted_date': contractDateTextController.text.toString() == ""
          ? " "
          : contractDateTextController.text.toString(),
      'installation_appointment_date':
          appointmentDateTextController.text.toString() == ""
              ? " "
              : appointmentDateTextController.text.toString(),
      'customer_note': customerNoteTextController.text.toString(),
      'lat': latTextController.text,
      'long': longTextController.text,
      'contact_number': primaryContactNoTextController.text.toString(),
      'secondary_contact_number': secondaryContactNoTextController.text.toString(),
      'email' : emailTextController.text.toString(),
    };
    if (leadStatusName == "Contracted") {
      if (checkEmptyData() == false) {
        isLoading(false);
        AppUtils.showErrorSnackBar('Fail', 'Contracted Data must not empty!!!');
      } else if (checkLatLongLength(latTextController.text.toString()) == false) {
        isLoading(false);
        AppUtils.showErrorSnackBar(
            'Fail', 'Latitude field must be filled with format(00.000000)');
      }
      else if (checkLatLongLength(longTextController.text.toString()) == false) {
        isLoading(false);
        AppUtils.showErrorSnackBar(
            'Fail', 'Longitude field must be filled with format(00.000000)');
      }
      else {
        RestApi.postLeadFormData(map, dataStorage.read(TOKEN))
            .then((value) => Future.delayed(const Duration(seconds: 1), () {
                  if (value.status == 'Success') {
                    isLoading(false);
                    Get.back();
                  } else if (value.responseCode == "005") {
                    isLoading(false);
                    AppUtils.showSessionExpireDialog(
                        'Fail', 'Session Expired', Get.context!);
                  } else {
                    isLoading(false);
                  }
                }));
      }
    } else {
      RestApi.postLeadFormData(map, dataStorage.read(TOKEN))
          .then((value) => Future.delayed(const Duration(seconds: 1), () {
                if (value.status == 'Success') {
                  isLoading(false);
                  Get.back();
                } else if (value.responseCode == "005") {
                  isLoading(false);
                  AppUtils.showSessionExpireDialog(
                      'Fail', 'Session Expired', Get.context!);
                } else {
                  isLoading(false);
                }
              }));
    }
  }

  bool checkEmptyData() {
    if (appointmentDateTextController.text == '' ||
        customerNoteTextController.text == '' ||
        contractDateTextController.text == '' ||
        latTextController.text == '' ||
        longTextController.text == '') {
      return false;
    } else {
      return true;
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


  void updateLeadSource(String value) {
    leadSourceStatus = value;
    update();
  }

  void updateBusinessType(String value) {
    businessTypeStatus = value;
    update();
  }

  void updateDivision(String value) {
    divisionStatus = value;
    update();
  }

  void updateDesignation(String value) {
    designationStatus = value;
    update();
  }
}
