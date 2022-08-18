import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales_pipeline/app/modules/ForgotPassword/controllers/forgot_password_controller.dart';
import 'package:sales_pipeline/res/colors.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(Icons.arrow_back_sharp)),
          backgroundColor: Color(int.parse(AppColors.bgColor)),
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(int.parse(AppColors.bgColor)),
        body: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Image(
                    height: 100,
                    fit: BoxFit.contain,
                    image: AssetImage('assets/images/header_logo.png')),
              ),
              const SizedBox(
                height: 60,
              ),
              Column(
                children: [
                  makeInput(
                      label: "Enter your email",
                      controller: controller.emailTextController),
                  Container(
                      alignment: Alignment.centerRight, child: makeButton()),
                  Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget makeButton() {
    return Obx(() => controller.isLoading.value
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : MaterialButton(
            minWidth: 150,
            height: 50,
            onPressed: () {
              _handleOnPressSubmit();
            },
            color: Color(int.parse(AppColors.buttonColor)),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: const Text(
              "Submit",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white),
            ),
          ));
  }

  Widget makeInput({label, obsureText = false, controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.white),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: controller,
          obscureText: obsureText,
          scrollPadding: const EdgeInsets.only(bottom: 150),
          decoration: const InputDecoration(
            fillColor: Colors.white,
            filled: true,
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          ),
        ),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }

  void _handleOnPressSubmit() {
    controller.onPressSubmit();
  }
}
