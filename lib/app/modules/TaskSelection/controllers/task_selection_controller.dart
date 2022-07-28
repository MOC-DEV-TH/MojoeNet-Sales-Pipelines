import 'package:get/get.dart';
import 'package:sales_pipeline/app/network/RestApi.dart';
import 'package:sales_pipeline/app/utils/app_utils.dart';

import '../../../routes/app_pages.dart';

class TaskSelectionController extends GetxController {

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    AppUtils.removeLeadDataFromGetStorage();
    RestApi.fetchAllDDlData();
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


