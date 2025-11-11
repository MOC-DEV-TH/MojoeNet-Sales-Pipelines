import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_pipeline/app/models/leadVO.dart';
import 'package:sales_pipeline/app/modules/LeadListing/controllers/lead_listing_controller.dart';

import '../routes/app_pages.dart';

class LeadListTableItems extends StatelessWidget {
  final List<Detail>? lead;
  const LeadListTableItems(this.lead, {Key? key})
      : super(key: key);

  Widget build(BuildContext context) {
    return Table(
      columnWidths:  const {
        0: FlexColumnWidth(1.5),
        1: FlexColumnWidth(4),
        2: FlexColumnWidth(5),
        3: FlexColumnWidth(2.4),
      },
      border: TableBorder.all(
          color: Colors.white, style: BorderStyle.solid, width: 1),
      children: [
        TableRow(children: [
          _createTableTitleCell(label: 'SN'),
          _createTableTitleCell(label: 'Business Name'),
          _createTableTitleCell(label: 'Status'),
          _createTableTitleCell(label: 'Action'),
        ]),

        for (var i = 0; i < lead!.length; i++)
          TableRow(children: [
            _createTableCell(label: i+1),
            _createTableCell(label: lead![i].businessName ?? '-----'),
            _createTableCell(label: lead![i].status),
            _createEditTableCell(label: 'Edit',leadID: lead![i].lid),
          ])
      ],
    );
  }

  Widget _createTableCell({label,leadID}) {
    return TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              label.toString(),
              style: const TextStyle(color: Colors.white,fontSize: 12),
            ),
          ),
        ));
  }

  Widget _createEditTableCell({label,leadID}) {
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
                style: const TextStyle(color: Colors.white,fontSize: 12),
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
                  color: Colors.white, fontWeight: FontWeight.bold,fontSize: 12),
            ),
          ),
        ));
  }

  void navigateToBusinessDetailView(leadID) {
    Get.toNamed(Routes.BUSINESS_DETAIL,arguments: leadID)!.then((value) => LeadListingController.to.fetchLeadList()
    );
  }
}
