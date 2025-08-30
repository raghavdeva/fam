import 'call_to_action.dart';
import 'formatted_text.dart';
import 'gradient.dart';
import 'image_property.dart';

class CardData {
  final String id;
  final String name;
  final String slug;
  final String type;

  final FormattedText? formattedTitle;
  final String? title;

  final FormattedText? formattedDescription;
  final String? description;

  final ImageProperty? bgImage;
  final Gradient? bgGradient;
  final String? bgColor;
  final List<CardData>? cards;

  final ImageProperty? icon;

  final String? url;
  final List<CallToAction>? cta;
  final bool isDisabled;
  final bool isShareable;
  final bool isInternal;

  final int? iconSize;
  final List<dynamic>? positionalImages;
  final List<dynamic>? components;

  final bool? isScrollable;
  final double? height;

  CardData({
    required this.id,
    required this.name,
    required this.slug,
    required this.type,
    this.formattedTitle,
    this.title,
    this.formattedDescription,
    this.description,
    this.bgImage,
    this.bgGradient,
    this.bgColor,
    this.icon,
    this.url,
    this.cta,
    required this.isDisabled,
    this.isShareable = false,
    this.isInternal = false,
    this.iconSize,
    this.positionalImages,
    this.components,
    this.isScrollable, this.height, this.cards
  });

  factory CardData.fromJson(Map<String, dynamic> json) {
    return CardData(
        id: json['id'].toString(),
        name: json['name'] ?? '',
        slug: json['slug'] ?? '',
        type: json['design_type'] ?? json['type'] ?? 'Unknown',

        formattedTitle: json['formatted_title'] is Map
            ? FormattedText.fromJson(json['formatted_title'])
            : null,
        title: json['title'],

        formattedDescription: json['formatted_description'] is Map
            ? FormattedText.fromJson(json['formatted_description'])
            : null,
        description: json['description'],

        bgImage: json['bg_image'] is Map
            ? ImageProperty.fromJson(json['bg_image'])
            : null,
        bgGradient: json['bg_gradient'] is Map
            ? Gradient.fromJson(json['bg_gradient'])
            : null,
        bgColor: json['bg_color'],

        icon: json['icon'] is Map
            ? ImageProperty.fromJson(json['icon'])
            : null,

        url: json['url'],
        cta: json['cta'] is List
            ? (json['cta'] as List).map((ctaJson) => CallToAction.fromJson(ctaJson)).toList()
            : null,
        isDisabled: json['is_disabled'] ?? false,
        isShareable: json['is_shareable'] ?? false,
        isInternal: json['is_internal'] ?? false,

        iconSize: json['icon_size'],
        positionalImages: json['positional_images'],
        components: json['components'],
        height: json['height'] ?? 100,
        isScrollable: json['is_scrollable']
    );
  }
}


