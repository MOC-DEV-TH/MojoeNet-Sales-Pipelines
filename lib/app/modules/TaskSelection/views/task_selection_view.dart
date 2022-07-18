import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales_pipeline/res/colors.dart';

import '../controllers/task_selection_controller.dart';

class TaskSelectionView extends GetView<TaskSelectionController> {
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
          margin: const EdgeInsets.only(top: 40),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Welcome to Mojoenet',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      color: Colors.white),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Choose your task.',
                      style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    MaterialButton(
                      minWidth: double.infinity,
                      height: 50,
                      onPressed: () {
                        onPressViewDashboard();
                      },
                      color: Color(int.parse(AppColors.buttonColor)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text(
                        "View My Dashboard",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    MaterialButton(
                      minWidth: double.infinity,
                      height: 50,
                      onPressed: () {
                        onPressNewLoadForm();
                      },
                      color: Color(int.parse(AppColors.buttonColor)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text(
                        "New Lead Form",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onPressViewDashboard() {
    controller.onPressViewDashboard();
  }

  void onPressNewLoadForm() {
    controller.onPressNewLeadForm();
  }
}
