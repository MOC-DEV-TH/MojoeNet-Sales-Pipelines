import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales_pipeline/res/colors.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(int.parse(AppColors.bgColor)),
        body: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: const EdgeInsets.only(top: 100, left: 24, right: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    const Text(
                      'Welcome to Mojoenet',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    makeInput(
                        label: "Email", controller: controller.emailController),
                    makeInput(
                        label: "Password",
                        obsureText: true,
                        controller: controller.passwordController),
                    const SizedBox(
                      height: 18,
                    ),
                    makeButton(),
                    Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery
                                .of(context)
                                .viewInsets
                                .bottom))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleOnPressLogin() {
    controller.onPressLogin();
  }

  Widget makeButton() {
    return Obx(() =>
    controller.isLoading.value ? const Center(
      child: CircularProgressIndicator(),)
        : MaterialButton(
      minWidth: double.infinity,
      height: 50,
      onPressed: () {
        _handleOnPressLogin();
      },
      color: Color(int.parse(AppColors.buttonColor)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: const Text(
        "Login",
        style: TextStyle(
            fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white),
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
}
