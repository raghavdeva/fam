import 'entity.dart';
import 'package:flutter/material.dart';

class FormattedText {
  final String text;
  final String? align;
  final List<Entity> entities;

  FormattedText({
    required this.text,
    this.align,
    required this.entities,
  });

  factory FormattedText.fromJson(Map<String, dynamic> json) {
    return FormattedText(
      text: json['text'] ?? '',
      align: json['align'],
      entities: json['entities'] != null
          ? (json['entities'] as List)
          .map((entity) => Entity.fromJson(entity))
          .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'align': align,
      'entities': entities.map((entity) => entity.toJson()).toList(),
    }..removeWhere(
            (key, value) => value == null || value is List && value.isEmpty);
  }
}


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