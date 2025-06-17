import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_pipeline/app/modules/ContractedDetail/controllers/contracted_detail_controller.dart';
import 'package:sales_pipeline/components/contracted_detail_package_drop_down_button_component.dart';
import 'package:sales_pipeline/components/text_field_component.dart';
import 'package:sales_pipeline/res/colors.dart';

import '../../../../components/drop_down_button_component.dart';
import '../../../models/dropDownVO.dart';

class ContractedDetailView extends GetView<ContractedDetailController> {
  @override
  Widget build(BuildContext context) {
    debugPrint('Widget Build');
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Color(int.parse(AppColors.bgColor)),
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Container(
              width: Get.width,
              height: double.infinity,
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Center(
                            child: Image(
                                height: 70,
                                fit: BoxFit.contain,
                                image: AssetImage(
                                    'assets/images/header_logo.png'))),
                        Expanded(
                            child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller.contractedDetail.value.businessName
                                              .toString() ==
                                          "null"
                                      ? ""
                                      : controller
                                          .contractedDetail.value.businessName
                                          .toString(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                InkWell(
                                  onTap: () {
                                    onPressBack();
                                  },
                                  child: const Text(
                                    '<< Back',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                                child: Scrollbar(
                                    thumbVisibility: false,
                                    child: SingleChildScrollView(
                                        child: buildBusinessInfo(context)))),
                          ],
                        )),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                            child: Container(
                                alignment: Alignment.centerRight,
                                child: makeButton())),
                      ],
                    ),
                  );
                }
              })),
        ),
      ),
    );
  }

  Widget makeButton() {
    return MaterialButton(
      height: 45,
      minWidth: 150,
      onPressed: onPressSave,
      color: Color(int.parse(AppColors.buttonColor)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: const Text(
        "Save",
        style: TextStyle(
            fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white),
      ),
    );
  }

  Widget makeTextFormField(
      TextEditingController textEditingController, label, hintText) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
        InkWell(
          child: Container(
            color: Colors.white,
            height: 35,
            width: Get.width,
            child: Center(
              child: TextFieldComponent(
                hintText: hintText.toString(),
                enable: (label == 'Installation Appointment Date' ||
                        label == 'Contracted Date' ||
                        label == 'Division' ||
                        label == 'Amount' ||
                        label == 'Current Plan' ||
                        label == 'Current Package')
                    ? false
                    : true,
                errorText: '',
                label: label,
                controller: textEditingController,
                onTextDataChange: (String value) {},
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buildBusinessInfo(BuildContext context) {
    return GetBuilder<ContractedDetailController>(
        builder: (controller) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                makeTextFormField(
                    controller.nameTextController,
                    'Name',
                    controller.contractedDetail.value.firstname.toString() ==
                                "null" ||
                            controller.contractedDetail.value.firstname
                                    .toString() ==
                                ""
                        ? 'xxxxxxxxxx'
                        : controller.contractedDetail.value.firstname
                            .toString()),
                makeTextFormField(
                    controller.businessNameTextController,
                    'Business Name',
                    controller.contractedDetail.value.businessName.toString() ==
                                "null" ||
                            controller.contractedDetail.value.businessName
                                    .toString() ==
                                ""
                        ? 'xxxxxxxxxx'
                        : controller.contractedDetail.value.businessName
                            .toString()),
                makeTextFormField(
                    controller.addressTextController,
                    'Address',
                    controller.contractedDetail.value.address.toString() == ""
                        ? 'xxxxxxxxxx'
                        : controller.contractedDetail.value.address),
                makeTextFormField(
                    controller.contactNoTextController,
                    'Primary Contact Number',
                    (controller.contractedDetail.value.phone1.toString() ==
                                "" ||
                            controller.contractedDetail.value.phone1
                                    .toString() ==
                                "null")
                        ? 'xxxxxxxxxx'
                        : controller.contractedDetail.value.phone1),
                makeTextFormField(
                    controller.secondaryContactNoTextController,
                    'Secondary Contact Number',
                    (controller.contractedDetail.value.phone2.toString() ==
                                "" ||
                            controller.contractedDetail.value.phone2
                                    .toString() ==
                                "null")
                        ? 'xxxxxxxxxx'
                        : controller.contractedDetail.value.phone2),
                makeTextFormField(
                    controller.emailTextController,
                    'Email',
                    (controller.contractedDetail.value.email.toString() == "" ||
                            controller.contractedDetail.value.email
                                    .toString() ==
                                "null")
                        ? 'xxxxxxxxxx'
                        : controller.contractedDetail.value.email.toString()),
                makeTextFormField(controller.latTextController, 'Lat',
                    controller.contractedDetail.value.latitude ?? 'xxxxxxxxxx'),
                makeTextFormField(
                    controller.longTextController,
                    'Long',
                    controller.contractedDetail.value.longitude ??
                        'xxxxxxxxxx'),
                InkWell(
                  onTap: () {
                    controller.selectAppointmentDateTime();
                  },
                  child: makeTextFormField(
                      controller.appointmentDateTextController,
                      'Installation Appointment Date',
                      (controller.contractedDetail.value
                                      .installationAppointmentDate ==
                                  "" ||
                              controller.contractedDetail.value
                                      .installationAppointmentDate
                                      .toString() ==
                                  "null")
                          ? 'xxxxxxxxxx'
                          : controller.contractedDetail.value
                              .installationAppointmentDate),
                ),
                InkWell(
                  onTap: () {
                    controller.selectContractDateTime();
                  },
                  child: makeTextFormField(
                      controller.contractDateTextController,
                      'Contracted Date',
                      (controller.contractedDetail.value.contractedDate == "" ||
                              controller.contractedDetail.value.contractedDate
                                      .toString() ==
                                  "null")
                          ? 'xxxxxxxxxx'
                          : controller.contractedDetail.value.contractedDate),
                ),
                makeTextFormField(controller.noteTextController, 'Note',
                    controller.contractedDetail.value.notes ?? 'xxxxxxxxxx'),
                makeDivisionDropDownContainer(),
                makeTownshipDropDownContainer(),
                makeTextFormField(
                    controller.currentPlanTextController,
                    'Current Plan',
                    controller.contractedDetail.value.plan ?? 'xxxxxxxxxx'),
                makeNewPlanContainer(),
                makeTextFormField(
                    controller.currentPackageTextController,
                    'Current Package',
                    controller.contractedDetail.value.package ?? 'xxxxxxxxxx'),
                makePackageDropDownContainer(),
                makeTextFormField(
                    controller.amountTextController,
                    'Amount',
                    controller.contractedDetail.value.packageTotal ??
                        'xxxxxxxxxx'),
              ],
            ));
  }

  Widget makeTownshipDropDownContainer() {
    return GetBuilder<ContractedDetailController>(
        builder: (controller) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Township",
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Container(
                      color: Colors.white,
                      height: 38,
                      width: Get.width,
                      child: Center(
                        child: DropDownButtonComponent(
                          itemsList: controller.saleStatusData.township,
                          onChangedData: (Sale value) {
                            controller
                                .updateTownshipStatus(value.value.toString());
                            debugPrint(
                                'TownshipDropDownDropdownValue${value.value}');
                          },
                          hintText:
                              controller.contractedDetail.value.township == ""
                                  ? 'Select Township'
                                  : controller.contractedDetail.value.township,
                          hintColor: Colors.grey,
                          color: Colors.white,
                          selectedItemColor: Colors.grey,
                          iconColor: Color(int.parse(AppColors.bgColor)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ));
  }

  Widget makeNewPlanContainer() {
    return GetBuilder<ContractedDetailController>(
        builder: (controller) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "New Plan",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Container(
                      color: Colors.white,
                      height: 38,
                      width: Get.width,
                      child: Center(
                        child: DropDownButtonComponent(
                          itemsList: controller.saleStatusData.plan,
                          onChangedData: (Plan value) {
                            debugPrint(
                                'PlanDropDownDropdownValue${value.value}');
                            controller.selectPlan(value);
                          },
                          hintText: 'Select New Plan',
                          hintColor: Colors.grey,
                          color: Colors.white,
                          selectedItemColor: Colors.grey,
                          iconColor: Color(int.parse(AppColors.bgColor)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ));
  }

  Widget makePackageDropDownContainer() {
    return GetBuilder<ContractedDetailController>(
        builder: (controller) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "New Package",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                Container(
                  color: Colors.white,
                  height: 38,
                  width: Get.width,
                  child: Center(
                    child: ContractedDetailPackageDropDownButtonComponent(
                      value: controller.planValue != ""
                          ? controller.saleStatusData.package
                              .where(
                                  (data) => (data.plan == controller.planValue))
                              .toList()[0]
                          : null,
                      itemsList: controller.saleStatusData.package
                          .where((data) => (data.plan == controller.planValue))
                          .toList(),
                      onChangedData: (Package value) {
                        debugPrint(
                            'PackageDropDownDropdownValue${value.value}');
                        controller.selectPackage(value);
                      },
                      hintText: 'Select New Package',
                      hintColor: Colors.grey,
                      color: Colors.white,
                      selectedItemColor: Colors.grey,
                      iconColor: Color(int.parse(AppColors.bgColor)),
                    ),
                  ),
                ),
              ],
            ));
  }

  Widget makeDivisionDropDownContainer() {
    return GetBuilder<ContractedDetailController>(
        builder: (controller) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Division",
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Container(
                      color: Colors.white,
                      height: 38,
                      width: Get.width,
                      child: Center(
                        child: DropDownButtonComponent(
                          itemsList: controller.saleStatusData.division,
                          onChangedData: (Sale value) {
                            controller.updateDivision(value.value.toString());
                            debugPrint(
                                'divisionDropDownDropdownValue${value.value}');
                          },
                          hintText:
                              controller.contractedDetail.value.division ??
                                  'Select Division',
                          hintColor: Colors.grey,
                          color: Colors.white,
                          selectedItemColor: Colors.grey,
                          iconColor: Color(int.parse(AppColors.bgColor)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ));
  }

  void onPressBack() {
    controller.onPressBack();
  }

  void onPressSave() {
    controller.onPressSave();
  }
}
