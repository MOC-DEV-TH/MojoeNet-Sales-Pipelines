import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ndialog/ndialog.dart';
import 'package:sales_pipeline/app/modules/Dashboard/controllers/dashboard_controller.dart';
import 'package:sales_pipeline/res/colors.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/app_utils.dart';
import '../controllers/logout_controller.dart';

class LogoutView extends GetView<LogoutController> {
  @override
  Widget build(BuildContext context) {
    // DashboardController.to.tabIndex == 4 ?
    //    Future.delayed(Duration.zero,(){
    //      showBlurDialog(context);
    //    }) : null;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(int.parse(AppColors.bgColor)),
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        title: Container(
          child: const Center(
            child: Image(
                height: 70,
                fit: BoxFit.contain,
                image: AssetImage('assets/images/header_logo.png')),
          ),
        ),
      ),
      body: Container(
        color: Color(int.parse(AppColors.bgColor)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              height: 200,
              color: Color(int.parse(AppColors.navColor)),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Are You Sure You want to Logout!',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: MaterialButton(
                            minWidth: double.infinity,
                            height: 40,
                            onPressed: () {handleOnPressLogout();},
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "Yes",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Color(int.parse(AppColors.bgColor)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 60,
                        ),
                        Expanded(
                          child: MaterialButton(
                            minWidth: double.infinity,
                            height: 40,
                            onPressed: () {},
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Color(int.parse(AppColors.bgColor)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  handleOnPressLogout(){
    AppUtils.removeDataFromGetStorage()
        .then((value) => Future.delayed(const Duration(seconds: 1), () {
      Get.offAllNamed(Routes.LOGIN);
    }));
  }
  showBlurDialog(BuildContext context) {
    DialogBackground(
      dismissable: false,
      dialog: AlertDialog(
        title: Text("Are You Sure You want to Logout!"),
        content:
            Text("Wohoo.. This is ordinary AlertDialog with Blur background"),
        actions: <Widget>[
          ElevatedButton(child: Text("Yes"), onPressed: () {}),
          ElevatedButton(child: Text("Cancel"), onPressed: () {
            Get.back();
          }),
        ],
      ),
    ).show(context);
  }

  Future blurDialog(BuildContext context) {
    return showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black38,
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (ctx, anim1, anim2) => AlertDialog(
        title: const Text('blured background'),
        content:
            const Text('background should be blured and little bit darker '),
        elevation: 2,
        actions: [
          ElevatedButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
        filter:
            ImageFilter.blur(sigmaX: 4 * anim1.value, sigmaY: 4 * anim1.value),
        child: FadeTransition(
          child: child,
          opacity: anim1,
        ),
      ),
      context: context,
    );
  }
}
