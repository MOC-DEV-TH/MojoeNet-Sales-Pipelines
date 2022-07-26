import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class TaskSelectionController extends GetxController {

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

  void onPressViewDashboard(){
    Get.toNamed(Routes.DASHBOARD);
  }

  void onPressNewLeadForm(){
    Get.offNamed(Routes.NLR_STEP_ONE);
  }


}


