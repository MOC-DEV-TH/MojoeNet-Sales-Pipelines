import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_pipeline/app/models/lead_status.dart';
import 'package:intl/intl.dart';
import '../../../routes/app_pages.dart';

class BusinessDetailController extends GetxController {
  var sourceTextController = TextEditingController();
  var weightTextController = TextEditingController();
  var dateTimeTextController = TextEditingController();
  var estimateFlightDateTextController = TextEditingController();
  final count = 0.obs;
  var leadStatusName = '';
  @override
  void onInit() {
    super.onInit();
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
      String dtFormat = DateFormat('dd/MM/yyyy').format(selected);
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
      String dtFormat = DateFormat('dd/MM/yyyy').format(selected);
      debugPrint("DateTimeFormat${dtFormat}");
      estimateFlightDateTextController.text = dtFormat.toString();
    }
  }

  void updateLeadStatus(LeadStatusVO data){
    leadStatusName = data.name!;
    weightTextController.text = data.weight!;
    update();
  }

  void onPressEdit() {}

  void onPressSave() {}

  void onPressBack() {
    Get.offNamed(Routes.DASHBOARD);
  }
}
