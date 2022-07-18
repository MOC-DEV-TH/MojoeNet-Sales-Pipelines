import 'package:get/get.dart';
import 'package:sales_pipeline/app/modules/SuccessLeadInfo/controllers/success_lead_info_controller.dart';


class SuccessLeadInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SuccessLeadInfoController>(
      () => SuccessLeadInfoController(),
    );
  }
}
