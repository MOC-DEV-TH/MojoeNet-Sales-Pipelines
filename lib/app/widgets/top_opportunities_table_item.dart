import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopOppotunitiesTableItems extends StatelessWidget {
  final List<Map> _books = [
    {'id': 1, 'title': 'Flutter Basics', 'author': '34','revenue':'10000','business':'Business'},
    {'id': 2, 'title': 'Flutter Basics', 'author': '45','revenue':'55550000','business':'SME'},
    {'id': 3, 'title': 'Git and GitHub', 'author': '67','revenue':'66660000','business':'Corporate'},
  ];

  Widget build(BuildContext context) {
    return FittedBox(
      child: Table(
        defaultColumnWidth: FixedColumnWidth(120.0),
        border: TableBorder.all(
            color: Colors.white, style: BorderStyle.solid, width: 1),
        children: [
          TableRow(children: [
            _createTableTitleCell(label: 'Period'),
            _createTableTitleCell(label: 'No.of Lead'),
            _createTableTitleCell(label: 'Business'),
            _createTableTitleCell(label: 'Revenue'),
            _createTableTitleCell(label: 'Total Revenue Amount\n(of each week)'),
          ]),
          TableRow(children: [
            _createTableCell(label: 'June'),
            _createNestTableCell(list: _books,status: 'id'),
            _createNestTableCell(list: _books,status: 'business'),
            _createNestTableCell(list: _books,status: 'revenue'),
            _createTableCell(label: '97765446(Sum of all revenue of the week)')
          ]),
        ],
      ),
    );
  }

  Widget _createNestTableCell({required List list,required String status}) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Column(
          children: list
              .map((item) => Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 0.5),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(item[status].toString(),
                    style: const TextStyle(color: Colors.white)),
              ),
            ),
          ))
              .toList()),
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