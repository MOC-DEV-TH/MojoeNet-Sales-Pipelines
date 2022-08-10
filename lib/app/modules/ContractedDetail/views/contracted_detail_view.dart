import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_pipeline/app/modules/ContractedDetail/controllers/contracted_detail_controller.dart';
import 'package:sales_pipeline/app/utils/app_constants.dart';
import 'package:sales_pipeline/components/contracted_detail_package_drop_down_button_component.dart';
import 'package:sales_pipeline/components/text_field_component.dart';
import 'package:sales_pipeline/main.dart';
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
                                const Text(
                                  'Business Name',
                                  style: TextStyle(
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
                                    isAlwaysShown: false,
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
                hintText: hintText,
                enable:(label=='Current Plan' || label=='Current Package') ? false : true,
                errorText: '',
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
                    controller.contractedDetail.value.firstname ??
                        'xxxxxxxxxx'),
                makeTextFormField(controller.addressTextController, 'Address',
                    controller.contractedDetail.value.address ?? 'xxxxxxxxxx'),
                makeTextFormField(
                    controller.contactNoTextController,
                    'Contact No',
                    controller.contractedDetail.value.phone1 ?? 'xxxxxxxxxx'),
                makeTextFormField(controller.emailTextController, 'Email',
                    controller.contractedDetail.value.email ?? 'xxxxxxxxxx'),
                makeTextFormField(controller.divisionTextController, 'Division',
                    controller.contractedDetail.value.division ?? 'xxxxxxxxxx'),
                makeTextFormField(controller.currentPlanTextController, 'Current Plan',
                    controller.contractedDetail.value.plan ?? 'xxxxxxxxxx'),
                makeTextFormField(controller.currentPackageTextController, 'Current Package',
                    controller.contractedDetail.value.package ?? 'xxxxxxxxxx'),
                makeDropDownContainer(),
                makePackageDropDownContainer()
              ],
            ));
  }

  Widget makeDropDownContainer() {
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
                            controller.updateTownshipStatus(value.value.toString());
                            debugPrint(
                                'TownshipDropDownDropdownValue${value.value}');
                          },
                          hintText:
                              controller.contractedDetail.value.township ??
                                  'Select Township',
                          hintColor: Colors.grey,
                          color: Colors.white,
                          selectedItemColor: Colors.grey,
                          iconColor: Color(int.parse(AppColors.bgColor)),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                const SizedBox(
                  height: 15,
                ),
              ],
            ));
  }

  Widget makePackageDropDownContainer() {
    return GetBuilder<ContractedDetailController>(
        builder: (controller) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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

  void onPressBack() {
    controller.onPressBack();
  }

  void onPressSave() {
    controller.onPressSave();
  }
}
