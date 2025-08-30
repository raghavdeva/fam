class Gradient {
  final List<String> colors;
  final int? angle;

  Gradient({
    required this.colors,
    this.angle,
  });

  factory Gradient.fromJson(Map<String, dynamic> json) {
    return Gradient(
      colors: (json['colors'] as List?)?.map((color) => color.toString()).toList() ?? [],
      angle: json['angle'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'colors': colors,
      'angle': angle,
    }..removeWhere((key, value) => value == null || value is List && value.isEmpty);
  }
}