import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContractedListTableItems extends StatelessWidget {
  final List<Map> _books = [
    {'id': 1, 'title': 'Basics', 'author': 'contracted',},
    {'id': 2, 'title': 'Basics', 'author': 'contracted',},
    {'id': 3, 'title': 'GitHub', 'author': 'contracted',},
    {'id': 4, 'title': 'GitHub', 'author': 'contracted',}
  ];

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
        ]),
        for (var item in _books)
          TableRow(children: [
            _createTableCell(label: item['id'].toString()),
            _createTableCell(label: item['title']),
            _createTableCell(label: item['author']),
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
