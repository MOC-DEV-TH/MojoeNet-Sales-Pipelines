import 'package:get/get.dart';
import 'package:sales_pipeline/app/modules/Contracted/controllers/contracted_controller.dart';

class ContractedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContractedController>(
      () => ContractedController(),
    );
  }
}
