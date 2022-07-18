import 'package:get/get.dart';
import 'package:sales_pipeline/app/modules/NLRStepSix/controllers/nlr_step_six_controller.dart';


class NLRStepSixBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NLRStepSixController>(
      () => NLRStepSixController(),
    );
  }
}
