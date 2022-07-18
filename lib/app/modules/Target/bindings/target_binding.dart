import 'package:get/get.dart';
import 'package:sales_pipeline/app/modules/Target/controllers/target_controller.dart';

class TargetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TargetController>(
      () => TargetController(),
    );
  }
}
