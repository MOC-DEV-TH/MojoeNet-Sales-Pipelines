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
  final Function(String)? onTextDataChange;
  final TextInputType textInputType;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    // ✅ Set initial text ONCE if needed
    if (initialValue != null && controller.text.isEmpty) {
      controller.text = initialValue!;
    }

    final isPhoneField =
        label == "Primary Contact Number" || label == "Secondary Contact Number";

    final isMultiLineNote =
        label == "Meeting Notes" || label == "Next Step";

    return TextFormField(
      keyboardType: isPhoneField ? TextInputType.number : TextInputType.text,
      maxLines: isMultiLineNote ? null : 1,
      enabled: enable ?? true,
      autofocus: false,
      // ❌ DO NOT use initialValue here
      controller: controller,
      textInputAction: TextInputAction.next,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 12),
      onChanged: (String value) {
        if (onTextDataChange != null) {
          onTextDataChange!(value);
        }
      },
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 12),
        border: InputBorder.none,
        labelStyle: const TextStyle(
          fontSize: 12,
          color: Colors.black,
        ),
        contentPadding: EdgeInsets.only(
          bottom: isMultiLineNote ? 0 : 12,
        ),
      ),
    );
  }
}
