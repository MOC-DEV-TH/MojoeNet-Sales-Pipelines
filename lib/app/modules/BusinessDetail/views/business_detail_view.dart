import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_pipeline/app/models/dropDownVO.dart';
import 'package:sales_pipeline/app/modules/BusinessDetail/controllers/business_detail_controller.dart';
import 'package:sales_pipeline/components/drop_down_button_component.dart';
import 'package:sales_pipeline/components/lead_status_drop_down_button_component.dart';
import 'package:sales_pipeline/components/text_field_component.dart';
import 'package:sales_pipeline/res/colors.dart';

import '../../../../components/contracted_detail_package_drop_down_button_component.dart';

class BusinessDetailView extends GetView<BusinessDetailController> {
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
                                  controller.activityDetailData.value
                                              .businessName
                                              .toString() ==
                                          "null"
                                      ? ""
                                      : controller
                                          .activityDetailData.value.businessName
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
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
            (label == 'Estimate Flight Date')
                ? const Icon(
                    Icons.calendar_month,
                    color: Colors.white,
                  )
                : label == 'Lat'
                    ? const Text(
                        '*',
                        style: TextStyle(color: Colors.red),
                      )
                    : label == 'Long'
                        ? const Text(
                            '*',
                            style: TextStyle(color: Colors.red),
                          )
                        : label == 'Installation Appointment Date'
                            ? const Text(
                                '*',
                                style: TextStyle(color: Colors.red),
                              )
                            : label == 'Contracted Date'
                                ? const Text(
                                    '*',
                                    style: TextStyle(color: Colors.red),
                                  )
                                : label == 'Note'
                                    ? const Text(
                                        '*',
                                        style: TextStyle(color: Colors.red),
                                      )
                                    :
                label == 'Est.Contract Date' ? const Text(
                  '*',
                  style: TextStyle(color: Colors.red),
                ) :  label == 'Est.Start Date' ? const Text(
                  '*',
                  style: TextStyle(color: Colors.red),
                ) : label == 'Est.Follow Up Date' ? const Text(
                  '*',
                  style: TextStyle(color: Colors.red),
                ) :
                const SizedBox()
          ],
        ),
        InkWell(
          child: Container(
            color: Colors.white,
            height:label == "Meeting Notes" || label == "Next Step" ? null : 35,
            width: Get.width,
            child: TextFieldComponent(
              hintText: hintText,
              enable: (label == "Estimate Flight Date" ||
                      label == "Remind Me on Date/Time" ||
                      label == 'Amount' ||
                      label == 'Current Package' ||
                      label == 'Installation Appointment Date' ||
                      label == 'Contracted Date' ||
                      label == "Current Plan" ||
                      label == "Est.Contract Date" ||
                      label == "Est.Start Date" ||
                      label == "Est.Follow Up Date" ||
                      label == 'Weighted%')
                  ? false
                  : true,
              errorText: '',
              label: label,
              controller: textEditingController,
              onTextDataChange: (String value) {},
            ),
          ),
        )
      ],
    );
  }

  Widget buildBusinessInfo(BuildContext context) {
    return GetBuilder<BusinessDetailController>(
        builder: (controller) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                makeLeadSourceDropDownContainer(),
                makeBusinessTypeDropDownContainer(),
                controller.businessTypeStatus == 'Other'
                    ? makeTextFormField(
                        controller.businessTypeOtherTextController,
                        'Business Type Other',
                        controller.activityDetailData.value.businessTypeOther ??
                            'xxxxxxxxxx')
                    : const SizedBox(),
                makeDivisionDropDownContainer(),
                makeTownshipDropDownContainer(),
                makeTextFormField(
                    controller.businessNameTextController,
                    'Business Name',
                    controller.activityDetailData.value.businessName ??
                        'xxxxxxxxxx'),
                makeTextFormField(
                    controller.addressTextController,
                    'Address',
                    (controller.activityDetailData.value.address.toString() ==
                                "null" ||
                            controller.activityDetailData.value.address
                                    .toString() ==
                                "")
                        ? 'xxxxxxxxxx'
                        : controller.activityDetailData.value.address
                            .toString()),
                makeTextFormField(
                    controller.contactPersonTextController,
                    'Contact Person Name',
                    controller.activityDetailData.value.firstname ??
                        'xxxxxxxxxx'),
                makeDesignationDropDownContainer(),
                controller.designationStatus == 'Other'
                    ? makeTextFormField(
                        controller.designationTypeOtherTextController,
                        'Designation Type Other',
                        controller.activityDetailData.value
                                .designationTypeOther ??
                            'xxxxxxxxxx')
                    : const SizedBox(),
                makeTextFormField(
                    controller.primaryContactNoTextController,
                    'Primary Contact Number',
                    controller.activityDetailData.value.contactno ??
                        'xxxxxxxxxx'),
                makeTextFormField(
                    controller.secondaryContactNoTextController,
                    'Secondary Contact Number',
                    controller
                            .activityDetailData.value.secondaryContactNumber ??
                        'xxxxxxxxxx'),
                makeTextFormField(controller.emailTextController, 'Email',
                    controller.activityDetailData.value.email ?? 'xxxxxxxxxx'),
                makeTextFormField(
                    controller.currentISPTextController,
                    'Current ISP',
                    controller.activityDetailData.value.currentIsp ??
                        'xxxxxxxxxx'),
                makeTextFormField(
                    controller.currentPlanTextController,
                    'Current Plan',
                    controller.activityDetailData.value.plan ?? 'xxxxxxxxxx'),
                makeNewPlanDropDownContainer(),
                makeTextFormField(
                    controller.currentPackageTextController,
                    'Current Package',
                    controller.activityDetailData.value.package ??
                        'xxxxxxxxxx'),
                makePackageDropDownContainer(),
                makeTextFormField(
                    controller.amountTextController,
                    'Amount',
                    controller.activityDetailData.value.packageTotal ??
                        'xxxxxxxxxx'),
                makeDiscountDropDownContainer(),
                makeLeadStatusDropDown(
                    'Lead Status',
                    controller.saleStatusData.saleStatus,
                    controller.leadStatusName),
                controller.leadStatusName == "Contracted"
                    ? makeContractedContainer()
                    : const SizedBox(),
                controller.leadStatusName != ''
                    ? InkWell(
                        onTap: () {
                          controller.selectDateTime(context);
                        },
                        child: makeTextFormField(
                            controller.dateTimeTextController,
                            'Remind Me on Date/Time',
                            controller.activityDetailData.value.followupDate ??
                                'xxxxxxxxxx'),
                      )
                    : const SizedBox(),
                makeTextFormField(
                    controller.weightTextController, 'Weighted%', 'xxxxxxxxxx'),
                makeTextFormField(
                    controller.meetingNoteTextController,
                    'Meeting Notes',
                    controller.activityDetailData.value.meetingNotes ??
                        'xxxxxxxxxx'),
                makeTextFormField(
                    controller.nextStepTextController,
                    'Next Step',
                    controller.activityDetailData.value.nextStep ??
                        'xxxxxxxxxx'),
                InkWell(
                  onTap: () {
                    controller
                        .selectDate(controller.estContractDateTextController);
                  },
                  child: makeTextFormField(
                      controller.estContractDateTextController,
                      'Est.Contract Date',
                      controller.activityDetailData.value.estContractDate ??
                          'xxxxxxxxxx'),
                ),
                InkWell(
                  onTap: () {
                    controller
                        .selectDate(controller.estStartDateTextController);
                  },
                  child: makeTextFormField(
                      controller.estStartDateTextController,
                      'Est.Start Date',
                      controller.activityDetailData.value.estStartDate ??
                          'xxxxxxxxxx'),
                ),
                InkWell(
                  onTap: () {
                    controller
                        .selectDate(controller.estFollowUpDateTextController);
                  },
                  child: makeTextFormField(
                      controller.estFollowUpDateTextController,
                      'Est.Follow Up Date',
                      controller.activityDetailData.value.estFollowUpDate ??
                          'xxxxxxxxxx'),
                ),
                (controller.leadStatusName == 'Keep Follow Up' ||
                        controller.leadStatusName == 'Proposal Follow Up' ||
                        controller.leadStatusName == 'Appointment' ||
                        controller.leadStatusName == 'Contract Follow Up' ||
                        controller.leadStatusName == 'Contracted')
                    ? makeFooterContainer(context)
                    : const SizedBox()
              ],
            ));
  }

  Widget makeLeadStatusDropDown(String label, itemList, hint) {
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
        Container(
          color: Colors.white,
          height: 38,
          width: Get.width,
          child: Center(
            child: LeadStatusDropDownButtonComponent(
              itemsList: itemList,
              onChangedData: (SaleStatus value) {
                debugPrint('DropdownValue${value.value}');
                controller.updateLeadStatus(value);
              },
              hintText: hint,
              hintColor: Colors.grey,
              color: Colors.white,
              selectedItemColor: Colors.grey,
              iconColor: Color(int.parse(AppColors.bgColor)),
            ),
          ),
        )
      ],
    );
  }

  Widget makeFooterContainer(BuildContext context) {
    return GetBuilder<BusinessDetailController>(
        builder: (controller) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Follow Up Via',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                Container(
                  color: Colors.white,
                  height: 38,
                  width: Get.width,
                  child: Center(
                    child: DropDownButtonComponent(
                      itemsList: controller.saleStatusData.followUpVia,
                      onChangedData: (FollowUpVia value) {
                        debugPrint('DropdownValue${value.value}');
                        controller.updateFollowUpViaStatus(value);
                      },
                      hintText: controller.followUpViaStatusName == 'null'
                          ? 'Select here'
                          : controller.followUpViaStatusName,
                      hintColor: Colors.grey,
                      color: Colors.white,
                      selectedItemColor: Colors.grey,
                      iconColor: Color(int.parse(AppColors.bgColor)),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    controller.selectEstimateFlightDate(context);
                  },
                  child: makeTextFormField(
                      controller.estimateFlightDateTextController,
                      'Estimate Flight Date',
                      controller.activityDetailData.value.estimateFlightdate ??
                          'xxxxxxxxxx'),
                ),
              ],
            ));
  }

  Widget makeNewPlanDropDownContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
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
                debugPrint('PlanDropDownDropdownValue${value.value}');
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
    );
  }

  Widget makePackageDropDownContainer() {
    return GetBuilder<BusinessDetailController>(
        builder: (controller) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
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

  Widget makeDiscountDropDownContainer() {
    return GetBuilder<BusinessDetailController>(
        builder: (controller) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Discount",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                Container(
                  color: Colors.white,
                  height: 38,
                  width: Get.width,
                  child: Center(
                    child: DropDownButtonComponent(
                      itemsList: controller.saleStatusData.discount,
                      onChangedData: (Discount value) {
                        controller.selectDiscount(value);
                        debugPrint(
                            'DiscountDropDownDropdownValue${value.value}');
                      },
                      hintText:
                          controller.activityDetailData.value.discount ?? '0%',
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

  Widget makeTownshipDropDownContainer() {
    return GetBuilder<BusinessDetailController>(
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
                              controller.activityDetailData.value.township ??
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
              ],
            ));
  }

  Widget makeContractedContainer() {
    return Column(
      children: [
        makeTextFormField(controller.latTextController, 'Lat',
            controller.activityDetailData.value.latitude ?? 'xx.xxxxxx'),
        makeTextFormField(controller.longTextController, 'Long',
            controller.activityDetailData.value.longitude ?? 'xx.xxxxxx'),
        InkWell(
          onTap: () {
            controller.selectAppointmentDateTime();
          },
          child: makeTextFormField(
              controller.appointmentDateTextController,
              'Installation Appointment Date',
              controller.activityDetailData.value.installationAppointmentDate ??
                  'xxxxxxxxxx'),
        ),
        InkWell(
          onTap: () {
            controller.selectContractDateTime();
          },
          child: makeTextFormField(
              controller.contractDateTextController,
              'Contracted Date',
              controller.activityDetailData.value.contractDate ?? 'xxxxxxxxxx'),
        ),
        makeTextFormField(controller.customerNoteTextController, 'Note',
            controller.activityDetailData.value.customerNote ?? 'xxxxxxxxxx'),
      ],
    );
  }

  Widget makeLeadSourceDropDownContainer() {
    return GetBuilder<BusinessDetailController>(
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
                      "Source",
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Container(
                      color: Colors.white,
                      height: 38,
                      width: Get.width,
                      child: Center(
                        child: DropDownButtonComponent(
                          itemsList: controller.saleStatusData.saleSource,
                          onChangedData: (Sale value) {
                            controller.updateLeadSource(value.value.toString());
                            debugPrint(
                                'LeadSourceDropDownDropdownValue${value.value}');
                          },
                          hintText:
                              controller.activityDetailData.value.leadSource ??
                                  'Select Lead Source',
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

  Widget makeBusinessTypeDropDownContainer() {
    return GetBuilder<BusinessDetailController>(
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
                      "Business Type",
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Container(
                      color: Colors.white,
                      height: 38,
                      width: Get.width,
                      child: Center(
                        child: DropDownButtonComponent(
                          itemsList: controller.saleStatusData.saleBusinessType,
                          onChangedData: (Sale value) {
                            controller
                                .updateBusinessType(value.value.toString());
                            debugPrint(
                                'BusinessTypeDropDownDropdownValue${value.value}');
                          },
                          hintText: controller
                                  .activityDetailData.value.businessType ??
                              'Select Business Type',
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

  Widget makeDivisionDropDownContainer() {
    return GetBuilder<BusinessDetailController>(
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
                              controller.activityDetailData.value.division ??
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

  Widget makeDesignationDropDownContainer() {
    return GetBuilder<BusinessDetailController>(
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
                      "Designation",
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Container(
                      color: Colors.white,
                      height: 38,
                      width: Get.width,
                      child: Center(
                        child: DropDownButtonComponent(
                          itemsList: controller.saleStatusData.saleDesignation,
                          onChangedData: (SaleDesignation value) {
                            controller
                                .updateDesignation(value.value.toString());
                            debugPrint(
                                'designationDropDownDropdownValue${value.value}');
                          },
                          hintText:
                              controller.activityDetailData.value.designation ??
                                  'Select Designation',
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

  void onPressEdit() {
    controller.onPressEdit();
  }

  void onPressSave() {
    controller.onPressSave();
  }
}
