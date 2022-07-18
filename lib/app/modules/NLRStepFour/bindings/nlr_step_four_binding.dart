import 'package:get/get.dart';
import 'package:sales_pipeline/app/modules/NLRStepFour/controllers/nlr_step_four_controller.dart';


class NLRStepFourBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NLRStepFourController>(
      () => NLRStepFourController(),
    );
  }
}
