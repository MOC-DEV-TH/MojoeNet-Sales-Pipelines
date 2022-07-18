import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales_pipeline/res/colors.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
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
                const Center(
                  child: Image(
                      height: 100,
                      fit: BoxFit.contain,
                      image: AssetImage('assets/images/header_logo.png')),
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
                      label: "Email",
                    ),
                    makeInput(
                      label: "Password",
                      obsureText: true,
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    makeButton(),
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
    return MaterialButton(
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
    );
  }

  Widget makeInput({
    label,
    obsureText = false,
  }) {
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
          controller: controller.emailController,
          obscureText: obsureText,
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
