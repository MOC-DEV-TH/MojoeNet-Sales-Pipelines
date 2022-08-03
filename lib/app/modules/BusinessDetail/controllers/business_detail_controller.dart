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
  var sourceTextController = TextEditingController();
  var businessTypeTextController = TextEditingController();
  var locationAndDivisionTextController = TextEditingController();
  var businessNameTextController = TextEditingController();
  var contactPersonTextController = TextEditingController();
  var designationTextController = TextEditingController();
  var contactNoAndEmailTextController = TextEditingController();
  var currentISPTextController = TextEditingController();
  var leadStatusTextController = TextEditingController();
  var remindMeDateTextController = TextEditingController();
  var weightTextController = TextEditingController();
  var dateTimeTextController = TextEditingController();
  var estimateFlightDateTextController = TextEditingController();

  var planTextController = TextEditingController();
  var packageTextController = TextEditingController();
  var amountTextController = TextEditingController();
  var discountTextController = TextEditingController();

  final count = 0.obs;
  var leadStatusName = '';
  var followUpViaStatusName = '';
  final dataStorage = GetStorage();
  dynamic saleStatusData;
  var activityDetailData = Details().obs;
  var isLoading = false.obs;

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

  void updateLeadStatus(SaleStatus data) {
    leadStatusName = data.value!;
    weightTextController.text = data.weight!;
    update();
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
    sourceTextController.text = data.leadSource.toString();
    businessTypeTextController.text = data.businessType.toString();
    designationTextController.text = data.designation.toString();
    contactPersonTextController.text = data.firstname.toString();
    dateTimeTextController.text = data.followupDate.toString();
    weightTextController.text = data.weighted.toString();
    leadStatusName = data.status.toString();
    followUpViaStatusName = data.followupVia.toString();

    data.estimateFlightdate.toString() == 'null'
        ? estimateFlightDateTextController.text = ''
        : estimateFlightDateTextController.text =
            data.estimateFlightdate.toString();

    (data.currentIsp.toString() == 'null')
        ? currentISPTextController.text = ''
        : currentISPTextController.text = data.currentIsp.toString();

    data.followupDate.toString() == 'null'
        ? dateTimeTextController.text = ''
        : dateTimeTextController.text = data.followupDate.toString();

    data.plan.toString() == 'null'
        ? planTextController.text = ''
        : planTextController.text = data.plan.toString();

    data.package.toString() == 'null'
        ? packageTextController.text = ''
        : packageTextController.text = data.package.toString();

    data.packageTotal.toString() == 'null'
        ? amountTextController.text = ''
        : amountTextController.text = data.packageTotal.toString();

    data.discount.toString() == 'null'
        ? discountTextController.text = ''
        : discountTextController.text = data.discount.toString();

    (data.businessName.toString() == 'null')
        ? businessNameTextController.text = ''
        : businessNameTextController.text = data.businessName.toString();
  }

  void onPressSave() {
    isLoading(true);
    var map = {
      'lid': Get.arguments.toString(),
      'uid': dataStorage.read(UID),
      'app_version': app_version,
      'source': sourceTextController.text.toString(),
      'business_type': businessTypeTextController.text.toString(),
      'business_name': businessNameTextController.text.toString() == ''
          ? ""
          : businessNameTextController.text.toString(),
      'designation': designationTextController.text.toString(),
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
      'plan': planTextController.text,
      'package': packageTextController.text,
      'discount': discountTextController.text == '' ? '0%' : discountTextController.text
          ,
    };
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
