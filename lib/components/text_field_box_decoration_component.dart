import 'package:flutter/material.dart';

class TextFieldBoxDecorationComponent extends StatelessWidget {
  TextFieldBoxDecorationComponent({
    Key? key,
    required this.hintText,
    this.maxLines = 1,
    required this.errorText,
    this.textInputType = TextInputType.text,
    this.icon,
    this.isVisible = false,
    required this.label,
    required this.controller,
    this.initialValue,
    this.onTextDataChange,
    this.onPress,
  }) : super(key: key);
  final String hintText;
  final int maxLines;
  final String label;
  final String errorText;
  final IconData? icon;
  final bool isVisible;
  final  Function(String)? onTextDataChange;
  String? initialValue;
  final Function()? onPress;
  final TextInputType textInputType;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 47,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: TextFormField(
          maxLines: null,
          initialValue: initialValue,
          textInputAction: TextInputAction.next,
          keyboardType: textInputType,
          controller: controller,
          obscureText: isVisible,
          textAlign: TextAlign.start,
          onChanged: (String value){
            onTextDataChange!(value);
          },
          style: TextStyle(fontSize: 12,color: Colors.grey),
          decoration: InputDecoration(
              hintText: hintText,
            border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.grey),
             ),
          validator: (value) => value!.trim().isEmpty ? errorText : null,
        ),
      ),
    );
  }
}
