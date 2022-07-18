import 'package:get/get.dart';
import '../controllers/sme_controller.dart';


class SMEBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SMEController>(
      () => SMEController(),
    );
  }
}
