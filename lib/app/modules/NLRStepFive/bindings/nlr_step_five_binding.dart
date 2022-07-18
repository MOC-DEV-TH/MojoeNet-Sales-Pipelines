import 'package:get/get.dart';
import 'package:sales_pipeline/app/modules/NLRStepFive/controllers/nlr_step_five_controller.dart';



class NLRStepFiveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NLRStepFiveController>(
      () => NLRStepFiveController(),
    );
  }
}
