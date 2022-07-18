import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales_pipeline/app/modules/NLRStepSix/controllers/nlr_step_six_controller.dart';
import 'package:sales_pipeline/res/colors.dart';
import 'package:dots_indicator/dots_indicator.dart';

import '../../../../components/drop_down_button_component.dart';
import '../../../../components/label_text_component.dart';
import '../../../../components/text_field_box_decoration_component.dart';

class NLRStepSixView extends GetView<NLRStepSixController> {
  final List<String> potentialList = <String>['Yes', 'No'];
  final List<String> potentialListNoStatus = <String>['Dead Lead'];
  final List<String> potentialListYesStatus = <String>[
    'Keep Follow Up',
    'Appointment',
    'Send Proposal',
    'Contracted'
  ];

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
                      const Text(
                        'Select Potential %.',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )
                    ],
                  ),
                ),
                Expanded(child: makeDropDownContainer()),
                SizedBox(height: 70, child: makeButton()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onPressContinue() {
    controller.onPressContinue();
  }

  void onPressBack() {
    controller.onPressBack();
  }

  Widget makeDropDownContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: LabelTextComponent(
                    text: 'Potential', color: Colors.white, padding: 0.0)),
            Flexible(
              flex: 2,
              child: DropDownButtonComponent(
                itemsList: potentialList,
                onChangedData: (String value) {
                  debugPrint('DropdownValue$value');
                  controller.updatePotentialStatus(value.toString());
                },
                hintText: 'Yes(Default)',
                hintColor: Colors.grey,
                color: Colors.white,
                selectedItemColor: Colors.grey,
                iconColor: Color(int.parse(AppColors.bgColor)),
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
                    text: 'Status', color: Colors.white, padding: 0.0)),
            Flexible(
              flex: 2,
              child: GetBuilder<NLRStepSixController>(
                builder: (controller) => DropDownButtonComponent(
                  itemsList: controller.potentialStatus == 'Yes'
                      ? potentialListYesStatus
                      : potentialListNoStatus,
                  onChangedData: (String value) {
                    debugPrint('DropdownValue$value');
                    controller.updatePotentialYesStatus(value.toString());
                  },
                  hintText: 'Select status',
                  hintColor: Colors.grey,
                  color: Colors.white,
                  selectedItemColor: Colors.grey,
                  iconColor: Color(int.parse(AppColors.bgColor)),
                ),
              ),
            ),
          ],
        ),
        GetBuilder<NLRStepSixController>(
            builder: (controller) => Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: controller.potentialStatus == 'No'
                          ? makeFooterContainer()
                          : const SizedBox()),
                )),
      ],
    );
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
        Expanded(
          child: MaterialButton(
            minWidth: double.infinity,
            height: 50,
            onPressed: onPressContinue,
            color: Color(int.parse(AppColors.buttonColor)),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: const Text(
              "Continue",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget makeFooterContainer() {
    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: LabelTextComponent(
                    text: 'Reason', color: Colors.white, padding: 0.0)),
            Flexible(
              flex: 2,
              child: TextFieldBoxDecorationComponent(
                controller: controller.reasonTextController,
                errorText: '',
                hintText: 'Enter Reason',
                label: '',
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          children: [
            Expanded(
                child: LabelTextComponent(
                    text: 'Follow Up', color: Colors.white, padding: 0.0)),
            const Flexible(
                flex: 2,
                child: Icon(
                  size: 60,
                  Icons.calendar_month,
                  color: Colors.white,
                )),
          ],
        ),
      ],
    );
  }
}
