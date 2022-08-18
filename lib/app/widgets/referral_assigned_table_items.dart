import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_pipeline/app/models/ActivityOverviewVO.dart';
import 'package:sales_pipeline/app/models/leadVO.dart';
import 'package:sales_pipeline/app/modules/LeadListing/controllers/lead_listing_controller.dart';

import '../routes/app_pages.dart';

class ReferralAssignedTableItems extends StatelessWidget {
  final List<LeadAssignedVO>? referral_assigned_data;
  const ReferralAssignedTableItems(this.referral_assigned_data, {Key? key})
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
          _createTableTitleCell(label: 'Contact Info'),
          _createTableTitleCell(label: 'Action'),
        ]),

        if(referral_assigned_data!=null)
        for (var i = 0; i < referral_assigned_data!.length; i++)
          TableRow(children: [
            _createTableCell(label: i+1),
            _createTableCell(label: referral_assigned_data![i].businessName),
            _crateContactInfo(label1: referral_assigned_data![i].contactNo,label2: referral_assigned_data![i].address),
            _createEditTableCell(label: 'Edit',leadID: referral_assigned_data![i].lid),
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
                style: const TextStyle(color: Colors.white,fontSize: 12,decoration: TextDecoration.underline),
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

  Widget _crateContactInfo({label1, label2,}) {
    return TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label1.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
               const Text(",",style: TextStyle(color: Colors.white),),
                Text(
                  label2.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void navigateToBusinessDetailView(leadID) {
    Get.toNamed(Routes.BUSINESS_DETAIL,arguments: leadID)!.then((value) => LeadListingController.to.fetchLeadList()
    );
  }
}
