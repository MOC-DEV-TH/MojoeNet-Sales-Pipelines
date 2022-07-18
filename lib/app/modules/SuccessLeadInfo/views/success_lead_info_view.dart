import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales_pipeline/app/modules/SuccessLeadInfo/controllers/success_lead_info_controller.dart';
import 'package:sales_pipeline/res/colors.dart';

class SuccessLeadInfoView extends GetView<SuccessLeadInfoController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(int.parse(AppColors.bgColor)),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: double.infinity,
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          margin: const EdgeInsets.only(top: 40),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 60,
                  child: Column(
                    children: [
                      DotsIndicator(
                        dotsCount: 6,
                        position: 5,
                        decorator: const DotsDecorator(
                          size: Size.square(15.0),
                          activeSize: Size.square(15.0),
                          color: Colors.white, // Inactive color
                          activeColor: Colors.lightBlue,
                        ),
                      ),
                    ],
                  ),
                ),
                const Expanded(
                    child: Center(
                        child: Text(
                  'Success!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32,color: Colors.white),
                ))),
                SizedBox(height: 70, child: makeButton()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onPressDone() {
    controller.onPressDone();
  }

  Widget makeButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: MaterialButton(
              minWidth: double.infinity,
              height: 50,
              onPressed: onPressDone,
              color: Color(int.parse(AppColors.buttonColor)),
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: const Text(
                "Done",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
