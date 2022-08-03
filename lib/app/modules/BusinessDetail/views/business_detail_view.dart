import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sales_pipeline/app/models/dropDownVO.dart';
import 'package:sales_pipeline/app/models/lead_status.dart';
import 'package:sales_pipeline/app/modules/BusinessDetail/controllers/business_detail_controller.dart';
import 'package:sales_pipeline/app/modules/Dashboard/controllers/dashboard_controller.dart';
import 'package:sales_pipeline/components/drop_down_button_component.dart';
import 'package:sales_pipeline/components/lead_status_drop_down_button_component.dart';
import 'package:sales_pipeline/components/text_field_component.dart';
import 'package:sales_pipeline/res/colors.dart';

import '../../../routes/app_pages.dart';

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
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
            label == 'Estimate Flight Date'
                ? const Icon(
                    Icons.calendar_month,
                    color: Colors.white,
                  )
                : const SizedBox()
          ],
        ),
        InkWell(
          child: Container(
            color: Colors.white,
            height: 35,
            width: Get.width,
            child: Center(
              child: TextFieldComponent(
                hintText: hintText,
                enable: label == 'Current ISP' ? true : false,
                errorText: '',
                controller: textEditingController,
                onTextDataChange: (String value){
                },
              ),
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
                makeTextFormField(
                    controller.sourceTextController,
                    'Source',
                    controller.activityDetailData.value.leadSource ??
                        'xxxxxxxxxx'),
                makeTextFormField(
                    controller.businessTypeTextController,
                    'Business Type',
                    controller.activityDetailData.value.businessType ??
                        'xxxxxxxxxx'),
                makeTextFormField(
                    controller.locationAndDivisionTextController,
                    'Location/Division',
                    controller.activityDetailData.value.division ??
                        'xxxxxxxxxx'),
                makeTextFormField(
                    controller.businessNameTextController,
                    'Business Name',
                    controller.activityDetailData.value.businessName ??
                        'xxxxxxxxxx'),
                makeTextFormField(
                    controller.contactPersonTextController,
                    'Contact Person Name',
                    controller.activityDetailData.value.firstname ??
                        'xxxxxxxxxx'),
                makeTextFormField(
                    controller.designationTextController,
                    'Designation',
                    controller.activityDetailData.value.designation ??
                        'xxxxxxxxxx'),
                makeTextFormField(
                    controller.contactNoAndEmailTextController,
                    'Contact Number/Email Address',
                    '${controller.activityDetailData.value.contactno} / ${controller.activityDetailData.value.email} '),
                makeTextFormField(
                    controller.currentISPTextController,
                    'Current ISP',
                    controller.activityDetailData.value.currentIsp ?? 'xxxxxxxxxx'),
                makeTextFormField(
                    controller.planTextController,
                    'Plan',
                    controller.activityDetailData.value.plan ?? 'xxxxxxxxxx'),
                makeTextFormField(
                    controller.packageTextController,
                    'Package',
                    controller.activityDetailData.value.package ?? 'xxxxxxxxxx'),
                makeTextFormField(
                    controller.amountTextController,
                    'Amount',
                    controller.activityDetailData.value.packageTotal ?? 'xxxxxxxxxx'),
                makeTextFormField(
                    controller.discountTextController,
                    'Discount',
                    controller.activityDetailData.value.discount ?? 'xxxxxxxxxx'),
                makeLeadStatusDropDown(
                    'Lead Status',
                    controller.saleStatusData.saleStatus,
                    controller.leadStatusName),
                controller.leadStatusName != ''
                    ? InkWell(
                        onTap: () {
                          controller.selectDateTime(context);
                        },
                        child: makeTextFormField(
                            controller.dateTimeTextController,
                            'Remind Me on Date/Time',
                             controller.activityDetailData.value.followupDate ?? 'xxxxxxxxxx'),
                      )
                    : const SizedBox(),
                makeTextFormField(
                    controller.weightTextController, 'Weighted%', 'xxxxxxxxxx'),
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
                      hintText:controller.followUpViaStatusName=='null' ? 'Select here' : controller.followUpViaStatusName,
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
                      controller.activityDetailData.value.estimateFlightdate ?? 'xxxxxxxxxx'
                  ),
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
