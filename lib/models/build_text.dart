import 'package:flutter/material.dart';

import 'entity.dart';

class BuildFormattedText extends StatelessWidget {
  Entity entity;
  double? fontSize;
  FontWeight? fontWeight;
  String? fontFamily;
  BuildFormattedText(
      {super.key,
        required this.entity,
        this.fontFamily,
        this.fontSize,
        this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      entity.text,
      style: TextStyle(
        color: entity.color != null
            ? Color(int.parse(entity.color!.replaceFirst('#', '0xFF')))
            : null,
        fontStyle:
        entity.fontStyle == 'italic' ? FontStyle.italic : FontStyle.normal,
        fontWeight: fontWeight ?? FontWeight.normal,
        fontSize: fontSize ?? entity.fontSize,
        fontFamily: fontFamily ?? entity.fontFamily,
      ),
    );
  }
}
