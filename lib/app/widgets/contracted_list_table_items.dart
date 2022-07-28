import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/contracted_lead_vo.dart';

class ContractedListTableItems extends StatelessWidget {
  final List<Detail>? contractedLead;
  const ContractedListTableItems(this.contractedLead, {Key? key})
      : super(key: key);
  Widget build(BuildContext context) {
    return Table(
      columnWidths:  const {
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
          _createTableTitleCell(label: 'Contact Information'),
        ]),
        for (var i = 0; i < contractedLead!.length; i++)
          TableRow(children: [
            _createTableCell(label: i.toString()),
            _createTableCell(label: contractedLead![i].firstName.toString()),
            _createTableCell(label: contractedLead![i].status.toString()),
            _createTableCell(label: contractedLead![i].contactInformation.toString()),
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
}
