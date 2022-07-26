import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_pipeline/app/models/ActivityOverviewVO.dart';
import 'package:sales_pipeline/app/modules/Dashboard/controllers/dashboard_controller.dart';

import '../routes/app_pages.dart';

class FollowUpTodayTableItems extends StatelessWidget {
  final List<ActivityVO>? dailyFollowUpData;

  const FollowUpTodayTableItems(this.dailyFollowUpData, {Key? key})
      : super(key: key);

  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(
          color: Colors.white, style: BorderStyle.solid, width: 1),
      children: [
        TableRow(children: [
          _createTableTitleCell(label: 'Date'),
          _createTableTitleCell(label: 'Business'),
          _createTableTitleCell(label: 'Status'),
          _createTableTitleCell(label: 'Follow Up Via'),
        ]),
        if(dailyFollowUpData!=null)
        for (var item in dailyFollowUpData!)
          TableRow(children: [
            _createTableCell(label: item.followupDate.toString()),
            _createBusinessTableCell(label: item.businessName.toString(),leadID: item.lid.toString()),
            _createTableCell(label: item.status.toString()),
            _createTableCell(label: item.followupVia.toString()),
          ])
      ],
    );
  }

  Widget _createTableCell({label}) {
    return TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
        ));
  }

  Widget _createBusinessTableCell({label,leadID}) {
    return TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Center(
          child: TableRowInkWell(
            onTap: () {
              navigateToBusinessDetailView(leadID);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ));
  }

  Widget _createTableTitleCell({label}) {
    return TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              label,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
          ),
        ));
  }

  void navigateToBusinessDetailView(leadID) {
    Get.toNamed(Routes.BUSINESS_DETAIL,arguments: leadID);
  }
}
