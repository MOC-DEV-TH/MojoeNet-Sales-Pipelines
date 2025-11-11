import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sales_pipeline/app/modules/NLRStepFive/controllers/nlr_step_five_controller.dart';
import 'package:sales_pipeline/app/utils/app_constants.dart';
import 'package:sales_pipeline/res/colors.dart';
import 'package:dots_indicator/dots_indicator.dart';

import '../../../../components/label_text_component.dart';
import '../../../../components/text_field_box_decoration_component.dart';
import '../../../routes/app_pages.dart';

class NLRStepFiveView extends GetView<NLRStepFiveController> {
  final dataStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    debugPrint(dataStorage.read(CONTACT_PERSON));
    debugPrint(dataStorage.read(CONTACT_NUMBER));
    debugPrint(dataStorage.read(EMAIL));

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
                        dotsCount: 7,
                        position: 4,
                        decorator: const DotsDecorator(
                          size: Size.square(15.0),
                          activeSize: Size.square(15.0),
                          color: Colors.white, // Inactive color
                          activeColor: Colors.lightBlue,
                        ),
                      ),
                      const Text(
                        'Enter the contact information.',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )
                    ],
                  ),
                ),
                Expanded(child: Center(child: makeTextFormFields())),
                SizedBox(height: 70, child: makeButton()),

                ///Skip button
                TextButton(
                    onPressed: () {
                      Get.offNamed(Routes.NLR_STEP_SIX);
                    },
                    child: Text(
                      'Skip for now',
                      style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                          fontWeight: FontWeight.w700),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onPressContinue() {
    if(controller.nameController.text != '' &&
        controller.contactNoController.text != '' &&
        controller.emailController.text != ''){
      controller.onPressContinue();
    }
  }

  void onPressBack() {
    controller.onPressBack();
  }

  Widget makeButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: MaterialButton(
            minWidth: double.infinity,
            height: 50,
            onPressed: onPressBack,
            color: Color(int.parse(AppColors.buttonColor)),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: const Text(
              "Back",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        GetBuilder<NLRStepFiveController>(
          builder: (controller) => Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: controller.nameController.text == '' ||
                        controller.contactNoController.text == '' ||
                        controller.emailController.text == ''
                    ? Colors.grey
                    : Color(int.parse(AppColors.buttonColor)),
                borderRadius: const BorderRadius.all(Radius.circular(12.0)),
              ),
              child: MaterialButton(
                minWidth: double.infinity,
                height: 50,
                onPressed: onPressContinue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: const Text(
                  "Continue",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget makeTextFormFields() {
    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Row(
              children: [
                LabelTextComponent(
                    text: 'Name', color: Colors.white, padding: 0.0),
                const SizedBox(
                  width: 5,
                ),
                const Text(
                  '',
                  style: TextStyle(color: Colors.red),
                )
              ],
            )),
            Flexible(
              flex: 2,
              child: TextFieldBoxDecorationComponent(
                controller: controller.nameController,
                errorText: '',
                hintText: 'Text',
                label: '',
                onTextDataChange: (String value) {
                    controller.onChangedName(value);
                },
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Row(
              children: [
                LabelTextComponent(
                    text: 'Contact No', color: Colors.white, padding: 0.0),
                const SizedBox(
                  width: 5,
                ),
                const Text(
                  '',
                  style: TextStyle(color: Colors.red),
                )
              ],
            )),
            Flexible(
              flex: 2,
              child: TextFieldBoxDecorationComponent(
                controller: controller.contactNoController,
                errorText: '',
                hintText: 'Primary',
                label: 'primary',
                onTextDataChange: (String value) {
                    controller.onChangedPrimaryContactNumber(value);
                },
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Row(
              children: [
                LabelTextComponent(text: '', color: Colors.white, padding: 0.0),
                const SizedBox(
                  width: 5,
                ),
                const Text(
                  '',
                  style: TextStyle(color: Colors.red),
                )
              ],
            )),
            Flexible(
              flex: 2,
              child: TextFieldBoxDecorationComponent(
                controller: controller.secondaryContactNoController,
                errorText: '',
                hintText: 'Secondary',
                label: 'secondary',
                onTextDataChange: (String value) {},
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: LabelTextComponent(
                    text: 'Email', color: Colors.white, padding: 0.0)),
            Flexible(
              flex: 2,
              child: TextFieldBoxDecorationComponent(
                controller: controller.emailController,
                errorText: '',
                hintText: 'Text',
                label: '',
                onTextDataChange: (String value) {
                    controller.onChangedEmail(value);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
