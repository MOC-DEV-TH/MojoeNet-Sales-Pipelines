import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales_pipeline/app/models/dropDownVO.dart';
import 'package:sales_pipeline/app/modules/NLRStepSix/controllers/nlr_step_six_controller.dart';
import 'package:sales_pipeline/components/package_drop_down_button_component.dart';
import 'package:sales_pipeline/res/colors.dart';
import 'package:dots_indicator/dots_indicator.dart';

import '../../../../components/drop_down_button_component.dart';
import '../../../../components/label_text_component.dart';
import '../../../../components/text_field_box_decoration_component.dart';
import '../../../../components/text_field_component.dart';
import '../../../routes/app_pages.dart';

class NLRStepSixView extends GetView<NLRStepSixController> {
  List<SaleStatus> potentialList = [
    SaleStatus(key: '1', value: 'Yes'),
    SaleStatus(key: '0', value: 'No'),
  ];
  List<SaleStatus> potentialListNoStatus = [
    SaleStatus(key: '2001', value: 'Dead Lead'),
  ];

  @override
  Widget build(BuildContext context) {
    debugPrint(controller.potentialStatusValue);
    debugPrint(controller.statusValue);

    debugPrint(controller.saleStatusData.package[0].key.toString());

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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Expanded(
                        child: RawScrollbar(
                          thumbVisibility: true,
                          thumbColor: Colors.grey,
                          trackColor: Colors.blue.shade50,
                          trackBorderColor: Colors.blue.shade100,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: LabelTextComponent(
                                            text: 'Potential',
                                            color: Colors.white,
                                            padding: 0.0)),
                                    Flexible(
                                      flex: 2,
                                      child: DropDownButtonComponent(
                                        itemsList: potentialList,
                                        onChangedData: (SaleStatus value) {
                                          debugPrint(
                                              'DropdownValue${value.value}');
                                          controller.updatePotential(value);
                                        },
                                        hintText: 'Yes(Default)',
                                        hintColor: Colors.grey,
                                        color: Colors.white,
                                        selectedItemColor: Colors.grey,
                                        iconColor:
                                            Color(int.parse(AppColors.bgColor)),
                                      ),
                                    ),
                                  ],
                                ),
                                GetBuilder<NLRStepSixController>(
                                  builder: (controller) =>
                                      controller.potentialStatusValue == '0'
                                          ? makeFooterContainer()
                                          : Column(
                                              children: [
                                                makeDropDownContainer(),
                                                makePackageDropDownContainer(),
                                              ],
                                            ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 70, child: makeButton(context)),

                      ///Skip button
                      TextButton(
                          onPressed: () {
                            Get.offNamed(Routes.N_L_R_STEP_SEVEN);
                            //controller.onPressContinue(context);
                          },
                          child: Text(
                            'Skip for now',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white,),
                          ))
                    ],
                  );
                }
              })),
        ),
      ),
    );
  }

  onPressContinue(BuildContext context) {
    controller.checkEmptyData() != false  ? controller.onPressContinue(context) : null;
  }

  void onPressBack() {
    controller.onPressBack();
  }

  Widget makeDropDownContainer() {
    return GetBuilder<NLRStepSixController>(
        builder: (controller) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                      child: DropDownButtonComponent(
                        itemsList: controller.saleStatusData.saleStatus
                            .where((data) => (data.value != 'Dead Lead'))
                            .toList(),
                        onChangedData: (SaleStatus value) {
                          debugPrint('StatusValue${value.value}');
                          controller.updateStatus(value.value.toString());
                        },
                        hintText: 'Select status',
                        hintColor: Colors.grey,
                        color: Colors.white,
                        selectedItemColor: Colors.grey,
                        iconColor: Color(int.parse(AppColors.bgColor)),
                      ),
                    ),
                  ],
                ),
                controller.statusValue == 'Contracted'
                    ? const SizedBox(
                        height: 30,
                      )
                    : const SizedBox(),
                controller.statusValue == 'Contracted'
                    ? makeContractedContainer()
                    : const SizedBox(),
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
                            text: 'Plan', color: Colors.white, padding: 0.0),
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
                        itemsList: controller.saleStatusData.plan,
                        onChangedData: (Plan value) {
                          debugPrint('StatusValue${value.value}');
                          controller.selectPlan(value);
                        },
                        hintText: 'Select plan',
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
              ],
            ));
  }

  Widget makePackageDropDownContainer() {
    return GetBuilder<NLRStepSixController>(
        builder: (controller) => Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Row(
                      children: [
                        LabelTextComponent(
                            text: 'Package', color: Colors.white, padding: 0.0),
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
                      child: PackageDropDownButtonComponent(
                        value: controller.planValue != ""
                            ? controller.saleStatusData.package
                                .where((data) =>
                                    (data.plan == controller.planValue))
                                .toList()[0]
                            : null,
                        itemsList: controller.saleStatusData.package
                            .where(
                                (data) => (data.plan == controller.planValue))
                            .toList(),
                        onChangedData: (Package value) {
                          debugPrint('StatusValue${value.value}');
                          controller.selectPackage(value);
                        },
                        hintText: 'Select package',
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
                            text: 'Amount', color: Colors.white, padding: 0.0),
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
                        controller: controller.amountTextController,
                        errorText: '',
                        hintText: 'xxxxxxxx',
                        label: 'amount',
                        enable: false,
                        onTextDataChange: (String value) {
                          if (value == "") {}
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
                            text: 'Discount',
                            color: Colors.white,
                            padding: 0.0),
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
                        itemsList: controller.saleStatusData.discount,
                        onChangedData: (Discount value) {
                          debugPrint('DiscountValue${value.value}');
                          controller.selectDiscount(value);
                        },
                        hintText: '0%',
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
                ///est contract date
                Row(
                  children: [
                    Expanded(
                        child: LabelTextComponent(
                            text: 'Est.Contract Date', color: Colors.white, padding: 0.0)),
                    Flexible(
                        flex: 2,
                        child: InkWell(
                            onTap: () {
                              controller.selectDate(controller.estContractDateTextController);
                            },
                            child:
                            makeTextFormField(controller.estContractDateTextController))),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                ///est start date
                Row(
                  children: [
                    Expanded(
                        child: LabelTextComponent(
                            text: 'Est.Start Date', color: Colors.white, padding: 0.0)),
                    Flexible(
                        flex: 2,
                        child: InkWell(
                            onTap: () {
                              controller.selectDate(controller.estStartDateTextController);
                            },
                            child:
                            makeTextFormField(controller.estStartDateTextController))),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                ///est follow up date
                Row(
                  children: [
                    Expanded(
                        child: LabelTextComponent(
                            text: 'Est.Follow Up Date', color: Colors.white, padding: 0.0)),
                    Flexible(
                        flex: 2,
                        child: InkWell(
                            onTap: () {
                              controller.selectDate(controller.estFollowUpDateTextController);
                            },
                            child:
                            makeTextFormField(controller.estFollowUpDateTextController))),
                  ],
                ),

                const SizedBox(
                  height: 30,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GetBuilder<NLRStepSixController>(
                      builder: (controller) => Container(
                        height: 50,
                        width: 20,
                        child: Checkbox(
                          side: const BorderSide(color: Colors.white),
                          checkColor: Colors.grey,
                          value: controller.referalCheckBoxValue,
                          activeColor: Colors.white,
                          onChanged: (value) => controller.updateReferalCheckBoxValue(
                              value!), //  <-- leading Checkbox
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'Is Referral',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ),

                  ],
                ),
              ],
            ));
  }

  Widget makeContractedContainer() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: LabelTextComponent(
                    text: 'Lat', color: Colors.white, padding: 0.0)),
            Flexible(
              flex: 2,
              child: TextFieldBoxDecorationComponent(
                controller: controller.latTextController,
                errorText: '',
                hintText: 'Enter latitude',
                label: 'lat',
                enable: true,
                onTextDataChange: (String value) {
                  if (value == "") {}
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
                child: LabelTextComponent(
                    text: 'Long', color: Colors.white, padding: 0.0)),
            Flexible(
              flex: 2,
              child: TextFieldBoxDecorationComponent(
                controller: controller.longTextController,
                errorText: '',
                hintText: 'Enter longitude',
                label: 'long',
                enable: true,
                onTextDataChange: (String value) {
                  if (value == "") {}
                },
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
                    text: 'Contract Date', color: Colors.white, padding: 0.0)),
            Flexible(
                flex: 2,
                child: InkWell(
                    onTap: () {
                      controller.selectContractDateTime();
                    },
                    child:
                        makeTextFormField(controller.contractDateTextController))),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          children: [
            Expanded(
                child: LabelTextComponent(
                    text: 'Installation Appointment Date', color: Colors.white, padding: 0.0)),
            Flexible(
                flex: 2,
                child: InkWell(
                    onTap: () {
                      controller.selectAppointmentDateTime();
                    },
                    child:
                    makeTextFormField(controller.appointmentDateTextController))),
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
                    text: 'Customer Note', color: Colors.white, padding: 0.0)),
            Flexible(
              flex: 2,
              child: TextFieldBoxDecorationComponent(
                controller: controller.customerNoteTextController,
                errorText: '',
                hintText: 'Enter Note...',
                label: 'amount',
                enable: true,
                onTextDataChange: (String value) {
                  if (value == "") {}
                },
              ),
            ),
          ],
        ),
      ],
    );
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
        GetBuilder<NLRStepSixController>(
          builder: (controller) => Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: controller.checkEmptyData() == false
                    ? Colors.grey
                    : Color(int.parse(AppColors.buttonColor)),
                borderRadius: const BorderRadius.all(Radius.circular(12.0)),
              ),
              child: MaterialButton(
                minWidth: double.infinity,
                height: 50,
                onPressed: () {
                  onPressContinue(context);
                },
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

  Widget makeFooterContainer() {
    return GetBuilder<NLRStepSixController>(
        builder: (controller) => Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: LabelTextComponent(
                                text: 'Status',
                                color: Colors.white,
                                padding: 0.0)),
                        Flexible(
                          flex: 2,
                          child: DropDownButtonComponent(
                            itemsList: potentialListNoStatus,
                            onChangedData: (SaleStatus value) {
                              debugPrint('StatusValue${value.value}');
                              controller.updateStatus(value.value.toString());
                            },
                            hintText: 'Select status',
                            hintColor: Colors.grey,
                            color: Colors.white,
                            selectedItemColor: Colors.grey,
                            iconColor: Color(int.parse(AppColors.bgColor)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
                        onTextDataChange: (String value){},
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
                            text: 'Follow Up',
                            color: Colors.white,
                            padding: 0.0)),
                    Flexible(
                        flex: 2,
                        child: InkWell(
                          onTap: () {
                            controller.selectDateTime();
                          },
                          child: makeTextFormField(
                              controller.followUpDateTextController),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GetBuilder<NLRStepSixController>(
                      builder: (controller) => Container(
                        height: 50,
                        width: 20,
                        child: Checkbox(
                          side: const BorderSide(color: Colors.white),
                          checkColor: Colors.grey,
                          value: controller.checkBoxValue,
                          activeColor: Colors.white,
                          onChanged: (value) => controller.updateCheckBoxValue(
                              value!), //  <-- leading Checkbox
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'Notify me after 6 months',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ],
            ));
  }

  Widget makeTextFormField(TextEditingController textEditingController) {
    return Container(
      height: 47,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(4))),
      width: Get.width,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: TextFieldComponent(
            hintText: '.....Select Date.....',
            enable: false,
            errorText: '',
            controller: textEditingController,
            onTextDataChange: (String value) {},
          ),
        ),
      ),
    );
  }
}


