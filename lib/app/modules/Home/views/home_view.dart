import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_pipeline/app/widgets/appointment_this_week_table_items.dart';
import 'package:sales_pipeline/app/widgets/appointment_today_table_items.dart';
import 'package:sales_pipeline/app/widgets/follow_up_this_week_table_items.dart';
import 'package:sales_pipeline/app/widgets/follow_up_today_table_items.dart';
import 'package:sales_pipeline/res/colors.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    controller.fetchActivityOverview(context);

    return Scaffold(
        backgroundColor: Color(int.parse(AppColors.bgColor)),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else {
            return Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                const Center(
                  child: Text(
                    'Your Activity This Week',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                        margin: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            /**
                             * follow up today table items
                             */
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Follow Up Today',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            FollowUpTodayTableItems(controller
                                .activityOverviewDetailData
                                .value
                                .dailyFollowUpData),
                            /**
                             * follow up this week table items
                             */
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              'Follow Up This Week',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            FollowUpThisWeekTableItems(controller
                                .activityOverviewDetailData
                                .value
                                .weeklyFollowUpData),

                            /**
                             * Appointment today table items
                             */

                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              'Appointment Today',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            AppointmentTodayTableItems(controller
                                .activityOverviewDetailData
                                .value
                                .dailyAppointmentData),

                            /**
                             * Appointment this week table items
                             */

                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              'Appointment This Week',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            AppointmentThisWeekTableItems(controller
                                .activityOverviewDetailData
                                .value
                                .weeklyAppointmentData),
                          ],
                        )),
                  ),
                )
              ],
            );
          }
        }));
  }
}
