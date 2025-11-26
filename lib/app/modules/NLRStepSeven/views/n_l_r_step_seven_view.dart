import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../res/colors.dart';
import '../controllers/n_l_r_step_seven_controller.dart';

class NLRStepSevenView extends GetView<NLRStepSevenController> {
  const NLRStepSevenView({super.key});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(int.parse(AppColors.bgColor)),
        body: Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: double.infinity,
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          margin: const EdgeInsets.only(top: 40),
          child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 60,
                        child: Column(
                          children: [
                            DotsIndicator(
                              dotsCount: 7,
                              position: 6,
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


                      MeetingNotesField(
                        meetingNotesController: controller.meetingNoteController,
                        nextStepController: controller.nextStepController,
                      ),

                      SizedBox(height: 70, child: makeButton(context)),

                    ],
                  );
                }
              })),
        ),
      ),
    );
  }

  onPressContinue(BuildContext context) {
    controller.onPressContinue(context);
  }

  Widget makeButton(BuildContext context) {
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
        GetBuilder<NLRStepSevenController>(
          id: 'continue_btn',
          builder: (controller) {
            final enabled = controller.checkEmptyData();
            return Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: enabled
                      ? Color(int.parse(AppColors.buttonColor))
                      : Colors.grey,
                  borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                ),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 50,
                  onPressed: enabled ? () => controller.onPressContinue(context) : null,
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
            );
          }
        )
      ],
    );
  }

  void onPressBack() {
    controller.onPressBack();
  }
}


class MeetingNotesField extends StatelessWidget {
  const MeetingNotesField({
    super.key,
    required this.meetingNotesController,
    required this.nextStepController,
    this.backgroundColor = const Color(0xFF175C75),
  });

  final TextEditingController meetingNotesController;
  final TextEditingController nextStepController;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(6);

    Widget labeledBox(String title, TextEditingController c) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF2F2F2),
              borderRadius: borderRadius,
              border: Border.all(color: Colors.black87, width: 2),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: TextField(
              controller: c,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              maxLines: 5,
              onSubmitted: (_) => FocusScope.of(context).unfocus(),
              style: const TextStyle(fontSize: 16, color: Colors.black87),
              decoration: const InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: 'Type here...',
              ),
            ),
          ),
        ],
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          labeledBox('Meeting Notes', meetingNotesController),
          const SizedBox(height: 32),
          labeledBox('Next Step', nextStepController),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

