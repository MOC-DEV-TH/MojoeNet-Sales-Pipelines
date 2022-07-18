import 'package:get/get.dart';

class DashboardController extends SuperController {
  //TODO: Implement DashboardController
  static DashboardController get to => Get.find();

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

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
  }

  @override
  void onResumed() {
  }

  var tabIndex = 0;

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }


}
