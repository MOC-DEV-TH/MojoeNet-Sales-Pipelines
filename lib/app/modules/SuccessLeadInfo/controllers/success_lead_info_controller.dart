import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class SuccessLeadInfoController extends GetxController {

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

  void onPressDone(){
    Get.offNamed(Routes.TASK_SELECTION);
  }




}


