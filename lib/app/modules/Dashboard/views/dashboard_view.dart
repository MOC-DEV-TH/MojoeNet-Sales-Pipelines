import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';

import 'package:get/get.dart';
import 'package:sales_pipeline/app/modules/Contracted/controllers/contracted_controller.dart';
import 'package:sales_pipeline/app/modules/Contracted/views/contracted_view.dart';
import 'package:sales_pipeline/app/modules/Home/views/home_view.dart';
import 'package:sales_pipeline/app/modules/LeadListing/views/lead_listing_view.dart';
import 'package:sales_pipeline/app/modules/Logout/views/logout_view.dart';
import 'package:sales_pipeline/app/modules/NewLead/controllers/new_lead_controller.dart';
import 'package:sales_pipeline/app/modules/Target/controllers/target_controller.dart';
import 'package:sales_pipeline/app/modules/Target/views/target_view.dart';
import 'package:sales_pipeline/res/colors.dart';

import '../../LeadListing/controllers/lead_listing_controller.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(NewLeadController());
    Get.put(LeadListingController());
    Get.put(TargetController());
    Get.put(ContractedController());

    return GetBuilder<DashboardController>(builder: (controller) {
      return Scaffold(
        body: IndexedStack(
          index: controller.tabIndex,
          children: [
            HomeView(),
            LeadListingView(),
            ContractedView(),
            TargetView(),
            LogoutView()
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(int.parse(AppColors.navColor)),
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.white,
          showSelectedLabels: true,
          currentIndex: controller.tabIndex,
          onTap: controller.changeTabIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            _bottomNavigationItem(icon: CupertinoIcons.home, label: 'Dashboard'),
            _bottomNavigationItem(icon: CupertinoIcons.bag, label: 'Lead List'),
            _bottomNavigationItem(
                icon: CupertinoIcons.bag_badge_minus, label: 'Contracted'),
            _bottomNavigationItem(
                icon: CupertinoIcons.bag_badge_minus, label: 'Target'),
            _bottomNavigationItem(
                icon: CupertinoIcons.arrow_right_square, label: 'Logout'),
          ],
        ),
      );
    });
  }
}

_bottomNavigationItem({required IconData icon, required String label}) {
  return BottomNavigationBarItem(icon: Icon(icon), label: label);
}

_focusMenu() {
  return FocusedMenuHolder(
    menuWidth: Get.width,
    blurBackgroundColor: Color(int.parse(AppColors.bgColor)).withOpacity(0.5),
    openWithTap: true,
    menuItems: [
      FocusedMenuItem(
          title: Center(child: Text('Are You Sure You want to Logout')),
          onPressed: () {})
    ],
    onPressed: () {},
    child: const Icon(CupertinoIcons.arrow_right_square),
  );
}
