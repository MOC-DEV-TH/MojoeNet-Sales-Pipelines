import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContractedController extends GetxController {
  //TODO: Implement LeadListingController
  var businessNameTextController = TextEditingController();
  var contactNoTextController = TextEditingController();
  final count = 0.obs;
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
}
