import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sales_pipeline/app/utils/app_constants.dart';

import '../app/models/dropDownVO.dart';

class ContractedDetailPackageDropDownButtonComponent<T> extends StatelessWidget {
  final List<dynamic>? itemsList;
  final List<dynamic>? installItemsList;
  final IconData? icon;
  final dynamic value;
  final String? hintText;
  final void Function(T) onChangedData;
  final String? status;
  final dynamic firstElement;
  final Color? color;
  final Color? hintColor;
  final Color? selectedItemColor;
  final Color? iconColor;

   ContractedDetailPackageDropDownButtonComponent(
      {Key? key,
      this.itemsList = const [],
      this.installItemsList = const [],
      this.icon,
      this.value,
      this.status,
      this.color,
      this.hintColor,
      this.selectedItemColor,
      this.iconColor,
        this.firstElement,
      required this.hintText,
      required this.onChangedData})
      : super(key: key);

  final dataStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButtonFormField2<dynamic>(
        isExpanded: true,
        isDense: false,
        itemHeight: 30,
        value: value,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        icon: const Padding(
          padding: EdgeInsets.only(right: 5),
          child: Icon(Icons.keyboard_arrow_down_outlined),
        ),
        iconEnabledColor: iconColor,
        iconSize: 30,
        buttonHeight: 40,
        dropdownMaxHeight: 190,
        scrollbarAlwaysShow: true,
        selectedItemBuilder: (BuildContext context) {
          return itemsList!
              .map((items) => Center(
                    child: Text(
                      items.key.toString(),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: selectedItemColor, fontSize: 10),
                    ),
                  ))
              .toList();
        },
        items: itemsList!
            .map((items) => DropdownMenuItem(
                  child: Center(
                    child: Text(
                      items.key.toString(),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                  ),
                  value: items,
                ))
            .toList(),
        onChanged: (value) {
          onChangedData(value);
          debugPrint("PackageIndex${itemsList?.indexOf(value)}");
        },
        hint: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Center(
            child: Text(
              hintText.toString(),
              style: TextStyle(fontSize: 10, color: hintColor),
            ),
          ),
        ),
      ),
    );
  }
}
