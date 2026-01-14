import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_pipeline/app/modules/Contracted/controllers/contracted_controller.dart';
import 'package:sales_pipeline/app/utils/app_constants.dart';

import '../models/contracted_lead_vo.dart';
import '../routes/app_pages.dart';

class ContractedListTableItems extends StatelessWidget {
  final List<Detail>? contractedLead;

  const ContractedListTableItems(this.contractedLead, {Key? key})
      : super(key: key);

  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1.5),
        1: FlexColumnWidth(4),
        2: FlexColumnWidth(4),
        3: FlexColumnWidth(4),
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
        for (var i = 0; i < contractedLead!.length; i++)
          TableRow(children: [
            _createTableCell(label: (i+1).toString()),
            _createTableCell(label: contractedLead![i].businessName),
            _createTableCell(label: contractedLead![i].status),
            _createActionTableCell(
                label1: 'Edit',
                label2: 'Signed',
                leadID: contractedLead![i].profileID.toString(),
                signUrl: BASE_URL + contractedLead![i].sign!)
          ])
      ],
    );
  }

  Widget _createTableCell({label}) {
    return TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Center(
          child: TableRowInkWell(
            onTap: () {
              debugPrint(label);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                label ?? '-----',
                style: const TextStyle(color: Colors.white, fontSize: 12),
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

  Widget _createActionTableCell({label1, label2, leadID, signUrl}) {
    return TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    navigateToContractedDetail(leadID);
                  },
                  child: Text(
                    label1,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const Text(
                  '||',
                  style: TextStyle(color: Colors.white),
                ),
                InkWell(
                  onTap: () async {
                    navigateToWebView(signUrl);
                    // launchUrl(Uri.parse(signUrl)).then((value) =>
                    //     ContractedController.to.fetchContractedLead());
                  },
                  child: Text(
                    label2,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void navigateToContractedDetail(leadID) {
    Get.toNamed(Routes.CONTRACTED_DETAIL, arguments: leadID)!
        .then((value) => ContractedController.to.fetchContractedLead());
  }

  void navigateToWebView(leadID) {
    Get.toNamed(Routes.WEB_VIEW, arguments: leadID)!
        .then((value) => ContractedController.to.fetchContractedLead());
  }
}
