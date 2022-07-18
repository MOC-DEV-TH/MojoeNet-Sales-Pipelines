import 'package:flutter/material.dart';

class SourceTableItems extends StatelessWidget {
  final List<Map> _books = [
    {'id': 1, 'title': 'Flutter Basics', 'author': '34'},
    {'id': 2, 'title': 'Flutter Basics', 'author': '45'},
    {'id': 3, 'title': 'Git and GitHub', 'author': '67'}
  ];

  Widget build(BuildContext context) {
    return Table(
      columnWidths:  const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(4),
        2: FlexColumnWidth(4),
      },
      border: TableBorder.all(
          color: Colors.white, style: BorderStyle.solid, width: 1),
      children: [
        TableRow(children: [
          _createTableTitleCell(label: 'SN'),
          _createTableTitleCell(label: 'Lead Status'),
          _createTableTitleCell(label: 'No. of Lead'),
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