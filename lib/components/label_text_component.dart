import 'package:flutter/material.dart';
class LabelTextComponent extends StatelessWidget {
  LabelTextComponent({
    Key? key,
    required this.text,
    required this.color,
    required this.padding,
    this.containerWidth,
    this.textAlign,
  }) : super(key: key);

  final String text;
  final Color color;
  final double padding;
  TextAlign? textAlign;
  double? containerWidth;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(padding),
      child: SizedBox(
        width: containerWidth,
        child: Text(
          text,
          textAlign: TextAlign.start,
          style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 14,
              color:color,
              decoration: TextDecoration.none),
          overflow: TextOverflow.fade,
          softWrap: true,
        ),
      ),
    );
  }
}
