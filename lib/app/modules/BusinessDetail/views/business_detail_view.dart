import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_pipeline/app/models/lead_status.dart';
import 'package:sales_pipeline/app/modules/BusinessDetail/controllers/business_detail_controller.dart';
import 'package:sales_pipeline/components/drop_down_button_component.dart';
import 'package:sales_pipeline/components/lead_status_drop_down_button_component.dart';
import 'package:sales_pipeline/components/text_field_component.dart';
import 'package:sales_pipeline/res/colors.dart';

class BusinessDetailView extends GetView<BusinessDetailController> {
  final List<String> data = <String>[
    'Company',
    'SME',
    'Condo',
    'Hotel',
    'Bar/Restaurant/KTV',
    'Home'
  ];
  final List<String> follow_up_via_data = <String>['In-person', 'Phone'];
  final List<String> send_proposal_via_data = <String>[
    'Email',
    'Viber',
    'Messenger'
  ];

  List<LeadStatusVO> leadStatusList = [
    LeadStatusVO(name: 'Contracted', weight: '100%'),
    LeadStatusVO(name: 'New Lead', weight: '10%'),
    LeadStatusVO(name: 'Keep Follow Up', weight: '25%'),
    LeadStatusVO(name: 'Appointment', weight: '50%'),
    LeadStatusVO(name: 'Proposal Follow Up', weight: '75%'),
    LeadStatusVO(name: 'Contract Follow Up', weight: '90%'),
    LeadStatusVO(name: 'Dead Lead', weight: '0%'),
    LeadStatusVO(name: 'Send Proposal', weight: '0%'),
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
          padding: const EdgeInsets.only(
            top: 20,
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Center(
                    child: Image(
                        height: 70,
                        fit: BoxFit.contain,
                        image: AssetImage('assets/images/header_logo.png'))),
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
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        InkWell(
                          onTap: () {
                            onPressBack();
                          },
                          child: const Text(
                            '<< Back',
                            style: TextStyle(color: Colors.white, fontSize: 16),
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
                  height: 55,
                ),
                SizedBox(
                    child: Container(
                        alignment: Alignment.centerRight, child: makeButton())),
              ],
            ),
          ),
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

  Widget makeTextFormField(controller, label, hintText) {
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
        Container(
          color: Colors.white,
          height: 35,
          width: Get.width,
          child: Center(
            child: TextFieldComponent(
              hintText: hintText,
              errorText: '',
              controller: controller,
              enable: (label == 'Weighted%' ||
                      label == 'Remind Me on Date/Time' ||
                      label == 'Estimate Flight Date')
                  ? false
                  : true,
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
                    controller.sourceTextController, 'Source', 'xxxxxxxxxx'),
                makeTextFormField(controller.sourceTextController,
                    'Business Type', 'xxxxxxxxxx'),
                makeTextFormField(controller.sourceTextController,
                    'Location/Division', 'xxxxxxxxxx'),
                makeTextFormField(controller.sourceTextController,
                    'Business Name', 'xxxxxxxxxx'),
                makeTextFormField(controller.sourceTextController,
                    'Contact Person Name', 'xxxxxxxxxx'),
                makeTextFormField(controller.sourceTextController,
                    'Designation', 'xxxxxxxxxx'),
                makeTextFormField(controller.sourceTextController,
                    'Contact Number/Email Address', 'xxxxxxxxxx'),
                makeTextFormField(controller.sourceTextController,
                    'Current ISP', 'xxxxxxxxxx'),
                makeLeadStatusDropDown(
                    'Lead Status', leadStatusList, 'Select Lead Status'),
                controller.leadStatusName != ''
                    ? InkWell(
                        onTap: () {
                          controller.selectDateTime(context);
                        },
                        child: makeTextFormField(
                            controller.dateTimeTextController,
                            'Remind Me on Date/Time',
                            'Choose Time....'),
                      )
                    : const SizedBox(),
                makeTextFormField(
                    controller.weightTextController, 'Weighted%', 'xxxxxxxxxx'),
                (controller.leadStatusName == 'Keep Follow Up' ||
                        controller.leadStatusName == 'Proposal Follow Up' ||
                        controller.leadStatusName == 'Send Proposal')
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
              onChangedData: (LeadStatusVO value) {
                debugPrint('DropdownValue$value');
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
    return Column(
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
              itemsList: controller.leadStatusName == 'Send Proposal'
                  ? send_proposal_via_data
                  : follow_up_via_data,
              onChangedData: (String value) {
                debugPrint('DropdownValue$value');
              },
              hintText: 'Select here',
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
          child: makeTextFormField(controller.estimateFlightDateTextController,
              'Estimate Flight Date', 'xxxxxxxxxx'),
        ),
      ],
    );
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
