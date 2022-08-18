import 'package:flutter/material.dart';
class TextFieldComponent extends StatelessWidget {
  TextFieldComponent({
    Key? key,
    required this.hintText,
    this.maxLines = 1,
    required this.errorText,
    this.textInputType = TextInputType.text,
    this.icon,
    this.isVisible = false,
    this.suffixText,
    this.enable,
    this.initialValue,
    this.label,
    this.onTextDataChange,
   required this.controller,
    this.onPress,
  }) : super(key: key);
  final String hintText;
  final int maxLines;
  final String errorText;
  final IconData? icon;
  final bool isVisible;
  final bool? enable;
  String? label;
  String? initialValue;
  final Function()? onPress;
  final String? suffixText;
  final  Function(String)? onTextDataChange;
  final TextInputType textInputType;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType:(label=="Primary Contact Number" || label=="Secondary Contact Number") ? TextInputType.number : TextInputType.multiline,
      maxLines: null,
      enabled: enable,
      initialValue: initialValue,
      textInputAction: TextInputAction.next,
      controller: controller,
      textAlign: TextAlign.center,
      style:const TextStyle(fontSize:12),
      onChanged: (String value){
        onTextDataChange!(value);
      },
      decoration: InputDecoration(
        hintText:  hintText,
        hintStyle:const TextStyle(fontSize: 12),
        border: InputBorder.none,
        labelStyle:const TextStyle(
          fontSize: 12,
          color: Colors.black,
        ),
        contentPadding: EdgeInsets.only(bottom: 12),
      ),
    );
  }
}