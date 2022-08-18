import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sales_pipeline/app/modules/NLRStepFour/controllers/nlr_step_four_controller.dart';
import 'package:sales_pipeline/app/utils/app_constants.dart';
import 'package:sales_pipeline/components/text_field_box_decoration_component.dart';
import 'package:sales_pipeline/res/colors.dart';
import 'package:dots_indicator/dots_indicator.dart';

class NLRStepFourView extends GetView<NLRStepFourController> {
  final dataStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    checkSelectedItem();
    if(dataStorage.read(DESIGNATION_OTHER) != null){
      controller.noteController.text = dataStorage.read(DESIGNATION_OTHER);
    }
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                        position: 3,
                        decorator: const DotsDecorator(
                          size: Size.square(15.0),
                          activeSize: Size.square(15.0),
                          color: Colors.white, // Inactive color
                          activeColor: Colors.lightBlue,
                        ),
                      ),
                      const Text(
                        'Who did you meet with.',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )
                    ],
                  ),
                ),
                Expanded(child: Scrollbar(
                  isAlwaysShown: false,
                  child: SingleChildScrollView(
                    child: Center(child: Column(
                      children: [
                        buildListView(),
                       GetBuilder<NLRStepFourController>(builder: (controller){
                        return (controller.selectedItemValue=='Other' ||dataStorage.read(DESIGNATION)=='Other')?makeNoteController():const SizedBox();
                       })
                      ],
                    )),
                  ),
                )),
                SizedBox(height: 70, child: makeButton()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onPressContinue() {
    controller.isSelectedValue != ''
        ? controller.onPressContinue()
        : dataStorage.read(DESIGNATION) != null
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
        GetBuilder<NLRStepFourController>(
          builder: (controller) => Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: controller.isSelectedValue == '' &&
                    dataStorage.read(DESIGNATION) == null
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
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 4, bottom: 8),
          itemCount: controller.saleDesignationData.saleDesignation.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: GetBuilder<NLRStepFourController>(
                  builder: (controller) => InkWell(
                        onTap: () {
                          controller.updateSelectedItem(index);
                          dataStorage.write(DESIGNATION_INDEX, index);
                            dataStorage.write(
                                DESIGNATION,
                                controller.saleDesignationData
                                    .saleDesignation[index].value);

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
                            controller.saleDesignationData
                                .saleDesignation[index].value,
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

  Widget makeNoteController(){
    return Container(
      height: 48,
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Center(
        child: TextFieldBoxDecorationComponent(
          hintText:(dataStorage.read(DESIGNATION_OTHER).toString()=="null" || dataStorage.read(DESIGNATION_OTHER).toString()=="" ) ? 'Enter type of designation...'
          :dataStorage.read(DESIGNATION_OTHER),
          errorText: '',
          controller: controller.noteController,
          onTextDataChange: (String value) {}, label: 'note',
        ),
      ),
    );
  }

  void checkSelectedItem() {
    dataStorage.read(DESIGNATION) != null
        ? controller.isSelected = dataStorage.read(DESIGNATION_INDEX)
        : controller.isSelected = -1;
  }
}
