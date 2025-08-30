// Represents an image asset
class ImageProperty {
  final String imageType;
  final String? assetType;
  final String? imageUrl;
  final String? webpImageUrl;
  final double? aspectRatio;

  ImageProperty({
    required this.imageType,
    this.assetType,
    this.imageUrl,
    this.webpImageUrl,
    this.aspectRatio,
  });

  factory ImageProperty.fromJson(Map<String, dynamic> json) {
    return ImageProperty(
      imageType: json['image_type'] ?? 'ext',
      assetType: json['asset_type'],
      imageUrl: json['image_url'],
      webpImageUrl: json['webp_image_url'],
      aspectRatio: json['aspect_ratio'] is num
          ? (json['aspect_ratio'] as num).toDouble()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image_type': imageType,
      'asset_type': assetType,
      'image_url': imageUrl,
      'webp_image_url': webpImageUrl,
      'aspect_ratio': aspectRatio,
    }..removeWhere((key, value) => value == null);
  }
}