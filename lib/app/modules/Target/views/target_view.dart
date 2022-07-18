import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales_pipeline/app/modules/Contracted/controllers/contracted_controller.dart';
import 'package:sales_pipeline/app/modules/Target/controllers/target_controller.dart';
import 'package:sales_pipeline/components/text_field_component.dart';

import 'package:sales_pipeline/res/colors.dart';

import '../../../../components/drop_down_button_component.dart';
import '../../../widgets/lead_list_table_items.dart';

class TargetView extends GetView<TargetController> {
  @override
  Widget build(BuildContext context) {
    controller.contactNoTextController.text = '';
    controller.businessNameTextController.text = '';
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
                          'Leads',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Search',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        /**
                         * Search with business name
                         */
                        Container(
                          width: 160,
                          height: 30,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextFieldComponent(
                                    hintText: 'BusinessName',
                                    errorText: '',
                                    controller: controller.businessNameTextController,
                                   ),
                              ),
                              Container(
                                  width: 35,
                                  height: Get.height,
                                  decoration: BoxDecoration(
                                      color: Color(
                                          int.parse(AppColors.buttonColor)),
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(6),
                                          bottomRight: Radius.circular(6))),
                                  child: const Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ))
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        /**
                         * Search with contact no
                         */
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 160,
                              height: 30,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: TextFieldComponent(
                                        hintText: 'Contact No.',
                                        errorText: '',
                                        controller: controller.contactNoTextController,
                                      ),
                                  ),
                                  Container(
                                      width: 35,
                                      height: Get.height,
                                      decoration: BoxDecoration(
                                          color: Color(
                                              int.parse(AppColors.buttonColor)),
                                          borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(6),
                                              bottomRight: Radius.circular(6))),
                                      child: const Icon(
                                        Icons.search,
                                        color: Colors.white,
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                        /**
                         * Lead List table items
                         */
                        const SizedBox(
                          height: 20,
                        ),
                        LeadListTableItems(),
                      ],
                    )),
              ),
            )
          ],
        ));
  }
}
