import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../models/contracted_detail_vo.dart';
import '../../../models/dropDownVO.dart';
import '../../../network/RestApi.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_utils.dart';
import 'package:intl/intl.dart';

class ContractedDetailController extends GetxController {
  var nameTextController = TextEditingController();
  var businessNameTextController = TextEditingController();
  var addressTextController = TextEditingController();
  var contactNoTextController = TextEditingController();
  var emailTextController = TextEditingController();
  var currentPlanTextController = TextEditingController();
  var currentPackageTextController = TextEditingController();

  var contractDateTextController = TextEditingController();
  var appointmentDateTextController = TextEditingController();
  var latTextController = TextEditingController();
  var longTextController = TextEditingController();
  var noteTextController = TextEditingController();

  var secondaryContactNoTextController = TextEditingController();

  var contractedDetail = Details().obs;
  var isLoading = false.obs;
  final dataStorage = GetStorage();
  var planValue = "";
  var packageValue = "";
  var townshipStatus = "";
  var divisionStatus = "";
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

  void setDataToController(Details data) {
    data.address.toString() == "null"
        ? addressTextController.text = ""
        : addressTextController.text = data.address.toString();

    data.email.toString() == "null"
        ? emailTextController.text = ""
        : emailTextController.text = data.email.toString();

    (data.firstname.toString() == "null" || data.firstname.toString() == "")
        ? nameTextController.text = ""
        : nameTextController.text = data.firstname.toString();

    (data.businessName.toString() == "null" ||
            data.businessName.toString() == "")
        ? businessNameTextController.text = ""
        : businessNameTextController.text = data.businessName.toString();

    data.phone1.toString() == "null"
        ? contactNoTextController.text = ""
        : contactNoTextController.text = data.phone1.toString();

    data.phone2.toString() == "null"
        ? secondaryContactNoTextController.text = ""
        : secondaryContactNoTextController.text = data.phone2.toString();

    data.latitude.toString() == "null"
        ? latTextController.text = ""
        : latTextController.text = data.latitude.toString();

    data.longitude.toString() == "null"
        ? longTextController.text = ""
        : longTextController.text = data.longitude.toString();

    data.installationAppointmentDate.toString() == "null"
        ? appointmentDateTextController.text = ""
        : appointmentDateTextController.text =
            data.installationAppointmentDate.toString();

    data.contractedDate.toString() == "null"
        ? contractDateTextController.text = ""
        : contractDateTextController.text = data.contractedDate.toString();

    data.notes.toString() == "null"
        ? noteTextController.text = ""
        : noteTextController.text = data.notes.toString();

    divisionStatus = data.division.toString();
    townshipStatus = data.township!.toString();
    currentPackageTextController.text = data.package.toString();
    currentPlanTextController.text = data.plan.toString();
  }

  void onPressSave() {
    isLoading(true);
    var map = {
      'uid': dataStorage.read(UID),
      'app_version': app_version,
      'address': addressTextController.text.toString(),
      'package': packageValue.toString() == ""
          ? currentPackageTextController.text
          : packageValue.toString(),
      'plan': planValue.toString() == ""
          ? currentPlanTextController.text
          : planValue.toString(),
      'name': nameTextController.text.toString(),
      'business_name': businessNameTextController.text.toString(),
      'contact_number': contactNoTextController.text.toString(),
      'secondary_contact_number':
          secondaryContactNoTextController.text.toString(),
      'email': emailTextController.text.toString(),
      'division': divisionStatus.toString()=="null" ? "" :divisionStatus.toString(),
      'township': townshipStatus.toString(),
      'profile_id': Get.arguments.toString(),
      'contracted_date': contractDateTextController.text.toString(),
      'installation_appointment_date':
          appointmentDateTextController.text.toString(),
      'customer_note': noteTextController.text.toString(),
      'lat': latTextController.text.toString(),
      'long': longTextController.text.toString(),
    };

    if (checkLatLongLength(latTextController.text.toString()) == false) {
      isLoading(false);
      AppUtils.showErrorSnackBar(
          'Fail', 'Latitude field must be filled with format(00.000000)');
    } else if (checkLatLongLength(longTextController.text.toString()) ==
        false) {
      isLoading(false);
      AppUtils.showErrorSnackBar(
          'Fail', 'Longitude field must be filled with format(00.000000)');
    } else if(emailTextController.text.toString()!="null" || emailTextController.text.toString()!=""){
      if(EmailValidator.validate(emailTextController.text)==false){
        isLoading(false);
        AppUtils.showErrorSnackBar("Fail", 'Invalid Email Format');
      }
      else {
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
    } else {
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

  void updateDivision(String value) {
    divisionStatus = value;
    update();
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
}
