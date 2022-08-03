import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sales_pipeline/app/utils/app_constants.dart';
import 'package:sales_pipeline/res/colors.dart';
import 'package:dots_indicator/dots_indicator.dart';

import '../controllers/nlr_step_two_controller.dart';

class NLRStepTwoView extends GetView<NLRStepTwoController> {
  final dataStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    checkSelectedItem();
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
                        position: 1,
                        decorator: const DotsDecorator(
                          size: Size.square(15.0),
                          activeSize: Size.square(15.0),
                          color: Colors.white, // Inactive color
                          activeColor: Colors.lightBlue,
                        ),
                      ),
                      const Text(
                        'Choose the type of business.',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )
                    ],
                  ),
                ),
                Expanded(child: Center(child: buildListView())),
                SizedBox(height: 70, child: makeButton()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onPressContinue() {
    controller.isSelectedValue != ''
        ? controller.onPressContinue()
        : dataStorage.read(BUSINESS_TYPE) != null
            ? controller.onPressContinue()
            : null;
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
        GetBuilder<NLRStepTwoController>(
          builder: (controller) => Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: controller.isSelectedValue == '' &&
                        dataStorage.read(BUSINESS_TYPE) == null
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

  Widget buildListView() {
    return Scrollbar(
      child: ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 4, bottom: 8),
          itemCount: controller.saleBusinessTypeData.saleBusinessType.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: GetBuilder<NLRStepTwoController>(
                  builder: (controller) => InkWell(
                        onTap: () {
                          if (controller.saleBusinessTypeData
                                  .saleBusinessType[index].value ==
                              'SME') {
                            dataStorage.write(BUSINESS_TYPE, 'SME');
                            controller.navigateToSME();
                          } else {
                            controller.updateSelectedItem(index);
                            dataStorage.write(
                                BUSINESS_TYPE,
                                controller.saleBusinessTypeData
                                    .saleBusinessType[index].value);
                          }
                          dataStorage.write(
                              BUSINESS_TYPE_INDEX,
                              index);
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: controller.isSelected == index
                                  ? Color(int.parse(AppColors.buttonColor))
                                  : Colors.white),
                          child: Center(
                              child: Text(
                            controller.saleBusinessTypeData
                                .saleBusinessType[index].value,
                            style: TextStyle(
                              color: controller.isSelected == index
                                  ? Colors.white
                                  : Color(int.parse(AppColors.bgColor)),
                            ),
                          )),
                        ),
                      )),
            );
          }),
    );
  }

  void checkSelectedItem() {
    dataStorage.read(BUSINESS_TYPE) != null
        ? controller.isSelected = dataStorage.read(BUSINESS_TYPE_INDEX)
        : controller.isSelected = -1;
  }
}
