import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales_pipeline/components/text_field_box_decoration_component.dart';
import 'package:sales_pipeline/res/colors.dart';

import '../controllers/new_lead_controller.dart';

class NewLeadView extends GetView<NewLeadController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(int.parse(AppColors.bgColor)),
        body: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            const Center(
              child: Image(
                  height: 70,
                  fit: BoxFit.contain,
                  image: AssetImage('assets/images/header_logo.png')),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                    margin: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Leads Form',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.white),
                        ),

                        /**
                         * Lead List table items
                         */
                        const SizedBox(
                          height: 10,
                        ),
                        _createMultipleTextForm()
                      ],
                    )),
              ),
            )
          ],
        ));
  }

  Widget _createMultipleTextForm() {
    return Column(
      children: [
        TextFieldBoxDecorationComponent(
            hintText: '',
            errorText: '',
            label: 'Business Name',
            controller: controller.businessNameController),
        TextFieldBoxDecorationComponent(
            hintText: '',
            errorText: '',
            label: 'Business Type',
            controller: controller.businessNameController),
        TextFieldBoxDecorationComponent(
            hintText: '',
            errorText: '',
            label: 'Business Potential',
            controller: controller.businessNameController),
        TextFieldBoxDecorationComponent(
            hintText: '',
            errorText: '',
            label: 'Source',
            controller: controller.businessNameController),
        TextFieldBoxDecorationComponent(
            hintText: '',
            errorText: '',
            label: 'Status',
            controller: controller.businessNameController),
        TextFieldBoxDecorationComponent(
            hintText: '',
            errorText: '',
            label: 'Weighted %',
            controller: controller.businessNameController),
        TextFieldBoxDecorationComponent(
            hintText: '',
            errorText: '',
            label: 'Contract Date',
            controller: controller.businessNameController),
        TextFieldBoxDecorationComponent(
            hintText: '',
            errorText: '',
            label: 'Plan',
            controller: controller.businessNameController),
        TextFieldBoxDecorationComponent(
            hintText: '',
            errorText: '',
            label: 'Package',
            controller: controller.businessNameController),
        TextFieldBoxDecorationComponent(
            hintText: '',
            errorText: '',
            label: 'Amount',
            controller: controller.businessNameController),
        TextFieldBoxDecorationComponent(
            hintText: '',
            errorText: '',
            label: 'Installation Appointment',
            controller: controller.businessNameController),
        TextFieldBoxDecorationComponent(
            hintText: '',
            errorText: '',
            label: 'Contract Term',
            controller: controller.businessNameController),
        TextFieldBoxDecorationComponent(
            hintText: '',
            errorText: '',
            label: 'Contract Name',
            controller: controller.businessNameController),
        TextFieldBoxDecorationComponent(
            hintText: '',
            errorText: '',
            label: 'Email',
            controller: controller.businessNameController),
        TextFieldBoxDecorationComponent(
            hintText: '',
            errorText: '',
            label: 'Division',
            controller: controller.businessNameController),
        TextFieldBoxDecorationComponent(
            hintText: '',
            errorText: '',
            label: 'Location',
            controller: controller.businessNameController),
        TextFieldBoxDecorationComponent(
            hintText: '',
            errorText: '',
            label: 'Address',
            controller: controller.businessNameController),
        TextFieldBoxDecorationComponent(
            hintText: '',
            errorText: '',
            label: 'Latitude',
            controller: controller.businessNameController),
        TextFieldBoxDecorationComponent(
            hintText: '',
            errorText: '',
            label: 'Longitude',
            controller: controller.businessNameController),


      ],
    );
  }
}
