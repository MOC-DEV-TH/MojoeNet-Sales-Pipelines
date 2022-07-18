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
   required this.controller,
    this.onPress,
  }) : super(key: key);
  final String hintText;
  final int maxLines;
  final String errorText;
  final IconData? icon;
  final bool isVisible;
  final bool? enable;
  final Function()? onPress;
  final String? suffixText;
  final TextInputType textInputType;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enable,
      keyboardType: TextInputType.multiline,
      maxLength: null,
      maxLines: null,
      textInputAction: TextInputAction.next,
      controller: controller,
      textAlign: TextAlign.center,
      style:const TextStyle(fontSize:12),
      decoration: InputDecoration(
        hintText:  hintText,
        hintStyle:const TextStyle(fontSize: 12),
        border: InputBorder.none,
        labelStyle:const TextStyle(
          fontSize: 12,
          color: Colors.black,
        ),
        contentPadding: EdgeInsets.only(bottom: 16),
      ),
    );
  }
}