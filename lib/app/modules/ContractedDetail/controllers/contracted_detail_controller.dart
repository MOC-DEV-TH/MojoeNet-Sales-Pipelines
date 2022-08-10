import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../models/contracted_detail_vo.dart';
import '../../../models/dropDownVO.dart';
import '../../../network/RestApi.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_utils.dart';

class ContractedDetailController extends GetxController {
  var nameTextController = TextEditingController();
  var addressTextController = TextEditingController();
  var contactNoTextController = TextEditingController();
  var emailTextController = TextEditingController();
  var divisionTextController = TextEditingController();
  var currentPlanTextController = TextEditingController();
  var currentPackageTextController = TextEditingController();

  var contractedDetail = Details().obs;
  var isLoading = false.obs;
  final dataStorage = GetStorage();
  var planValue = "";
  var packageValue = "";
  var townshipStatus="";
  dynamic saleStatusData;
  @override
  void onInit() {
    fetchContractedDetail(Get.arguments.toString());
    saleStatusData = dropDownVoFromJson(
        json.decode(dataStorage.read(ALL_DDL_DATA).toString()));
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}


  void onPressBack() {
    Get.back();
  }
  void selectPlan(Plan valueData) {
    planValue = valueData.value.toString();
    packageValue = saleStatusData.package
        .firstWhere((package) => package.plan == valueData.value)
        .key;
    update();
  }

  void selectPackage(Package data) {
    packageValue = data.key.toString();
    update();
  }

  void updateTownshipStatus(String status) {
    townshipStatus = status;
    update();
  }

  void fetchContractedDetail(String leadID, {BuildContext? context}) {
    isLoading(true);
    RestApi.fetchContractedDetailById(
            dataStorage.read(TOKEN), dataStorage.read(UID), leadID)
        .then((value) => {
              if (value.status == 'Success')
                {
                  contractedDetail.value = value.details!,
                  setDataToController(value.details!),
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

  void setDataToController(Details data){
    addressTextController.text = data.address;
    emailTextController.text = data.email!;
    nameTextController.text = data.firstname!;
    contactNoTextController.text = data.phone1;
    divisionTextController.text = data.division;
    townshipStatus = data.township!;
    currentPackageTextController.text = data.package.toString();
    currentPlanTextController.text = data.plan.toString();
  }

  void onPressSave() {
    isLoading(true);
    var map = {
      'uid': dataStorage.read(UID),
      'app_version': app_version,
      'address': addressTextController.text.toString(),
      'email': emailTextController.text.toString(),
      'package': packageValue.toString()=="" ? currentPackageTextController.text : packageValue.toString(),
      'plan': planValue.toString()=="" ? currentPlanTextController.text : planValue.toString(),
      'name': nameTextController.text.toString(),
      'contact_no': contactNoTextController.text.toString(),
      'division': divisionTextController.text.toString(),
      'township': townshipStatus.toString(),
      'profile_id': Get.arguments.toString(),
    };
    RestApi.postContractedDetail(map, dataStorage.read(TOKEN))
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
