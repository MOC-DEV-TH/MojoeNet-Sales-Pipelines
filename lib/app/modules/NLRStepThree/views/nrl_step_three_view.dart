import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sales_pipeline/app/models/dropDownVO.dart';
import 'package:sales_pipeline/app/modules/NLRStepThree/controllers/nlr_step_three_controller.dart';
import 'package:sales_pipeline/app/utils/app_constants.dart';
import 'package:sales_pipeline/res/colors.dart';
import 'package:dots_indicator/dots_indicator.dart';

import '../../../../components/drop_down_button_component.dart';
import '../../../../components/label_text_component.dart';
import '../../../../components/text_field_box_decoration_component.dart';

class NLRStepThreeView extends GetView<NLRStepThreeController> {
  String currentUserId = "SME";
  final dataStorage = GetStorage();
  @override
  Widget build(BuildContext context) {
    debugPrint(dataStorage.read(BUSINESS_NAME));
    debugPrint(dataStorage.read(ADDRESS));
    debugPrint(controller.divisionStatus);
    debugPrint(controller.townshipStatus);
    debugPrint(dataStorage.read(BUSINESS_TYPE_OTHER));

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
                        position: 2,
                        decorator: const DotsDecorator(
                          color: Colors.white, // Inactive color
                          activeColor: Colors.lightBlue,
                        ),
                      ),
                      const Text(
                        'Enter the business information.',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )
                    ],
                  ),
                ),
                Expanded(child: Center(child: makeTextFormFields())),
                SizedBox(height: 70, child: makeButton()),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void onPressContinue() {
    controller.checkEmptyData()==false ? null :
    controller.onPressContinue();
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
        GetBuilder<NLRStepThreeController>(
          builder: (controller) => Expanded(
            child: Container(
              decoration: BoxDecoration(
                color:controller.checkEmptyData()!=false ? Color(int.parse(AppColors.buttonColor)) : Colors.grey,
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

  Widget makeDropDownContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Row(
                  children: [
                    LabelTextComponent(
                        text: 'Division', color: Colors.white, padding: 0.0),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      '*',
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                )),
            Flexible(
              flex: 2,
              child: DropDownButtonComponent(
                itemsList: controller.townShipAndDivisionStatusData.division,
                onChangedData: (Sale data) {
                  debugPrint('DivisionValue${data.value}');
                  controller.updateDivisionStatus(data.value.toString());
                },
                hintText: (dataStorage.read(DIVISION).toString()=="null" || dataStorage.read(DIVISION).toString()=="")? 'Yangon(Default)'
                :dataStorage.read(DIVISION),
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
                child: Row(
              children: [
                LabelTextComponent(
                    text: 'Township', color: Colors.white, padding: 0.0),
                const SizedBox(
                  width: 5,
                ),
                const Text(
                  '*',
                  style: TextStyle(color: Colors.red),
                )
              ],
            )),
            Flexible(
              flex: 2,
              child: DropDownButtonComponent(
                itemsList: controller.townShipAndDivisionStatusData.township,
                onChangedData: (Sale data) {
                  debugPrint('TownshipValue${data.value}');
                  controller.updateTownshipStatus(data.value.toString());
                },
                hintText:(dataStorage.read(TOWNSHIP).toString()=="null" || dataStorage.read(TOWNSHIP).toString()=="") ? 'Select Township'
                :dataStorage.read(TOWNSHIP),
                hintColor: Colors.grey,
                color: Colors.white,
                selectedItemColor: Colors.grey,
                iconColor: Color(int.parse(AppColors.bgColor)),
              ),
            ),
          ],
        ),
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
                child: LabelTextComponent(
                    text: 'Business Name', color: Colors.white, padding: 0.0)),
            Flexible(
              flex: 2,
              child: TextFieldBoxDecorationComponent(
                controller: controller.businessNameTextController,
                errorText: '',
                hintText:'Text',
                label: '',
                onTextDataChange: (String value){},
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
                    text: 'Address', color: Colors.white, padding: 0.0),
                const SizedBox(
                  width: 5,
                ),
                const Text(
                  '*',
                  style: TextStyle(color: Colors.red),
                )
              ],
            )),
            Flexible(
              flex: 2,
              child: TextFieldBoxDecorationComponent(
                controller: controller.addressTextController,
                errorText: '',
                hintText: 'Text',
                label: '',
                onTextDataChange: (String value){
                  if(value==""){
                    controller.checkEmptyData();
                  }
                },
              ),
            ),
          ],
        ),
        makeDropDownContainer()
      ],
    );
  }
}
