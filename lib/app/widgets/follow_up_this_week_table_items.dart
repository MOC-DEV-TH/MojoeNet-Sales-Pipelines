import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FollowUpThisWeekTableItems extends StatelessWidget {
  final List<Map> _books = [
    {
      'date': 1,
      'business': 'ABC',
      'status': 'Meeting follow up',
      'followUpVia': 'phone'
    },
    {
      'date': 2,
      'business': 'ABC',
      'status': 'Meeting follow up',
      'followUpVia': 'phone'
    },
  ];

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
        for (var item in _books)
          TableRow(children: [
            _createTableCell(label: item['date'].toString()),
            _createBusinessTableCell(label: item['business']),
            _createTableCell(label: item['status']),
            _createTableCell(label: item['followUpVia']),
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
              style: const TextStyle(color: Colors.white, fontSize: 12),
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

  Widget _createBusinessTableCell({label}) {
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
}
