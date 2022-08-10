import 'package:get/get.dart';
import 'package:sales_pipeline/app/modules/ContractedDetail/controllers/contracted_detail_controller.dart';


class WebViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContractedDetailController>(
      () => ContractedDetailController(),
    );
  }
}
