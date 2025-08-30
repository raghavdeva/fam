// Represents a Call to Action (CTA) button
class CallToAction {
  final String text;
  final String? bgColor;
  final String? textColor;
  final String? url;
  final String type;
  final bool isCircular;
  final bool isSecondary;
  final int strokeWidth;

  CallToAction({
    required this.text,
    this.bgColor,
    this.textColor,
    this.url,
    this.type = 'normal',
    this.isCircular = false,
    this.isSecondary = false,
    this.strokeWidth = 0,
  });

  factory CallToAction.fromJson(Map<String, dynamic> json) {
    return CallToAction(
      text: json['text'] ?? '',
      bgColor: json['bg_color'],
      textColor: json['text_color'],
      url: json['url'],
      type: json['type'] ?? 'normal',
      isCircular: json['is_circular'] ?? false,
      isSecondary: json['is_secondary'] ?? false,
      strokeWidth: json['stroke_width'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'bg_color': bgColor,
      'text_color': textColor,
      'url': url,
      'type': type,
      'is_circular': isCircular,
      'is_secondary': isSecondary,
      'stroke_width': strokeWidth,
    }..removeWhere((key, value) => value == null);
  }
}
