import 'dart:convert';

import '../../../../core/entities/entity_model.dart';

BreedImage breedImageFromJson(final Map<String, dynamic> json) =>
    BreedImage.fromJson(json);

String breedImageToJson(final BreedImage data) => json.encode(data.toJson());

class BreedImage extends ModelEntity {
  BreedImage({
    required this.id,
    required this.url,
    required this.width,
    required this.height,
  });

  factory BreedImage.fromJson(final Map<String, dynamic> source) => BreedImage(
        id: source['id'],
        url: source['url'],
        width: source['width'],
        height: source['height'],
      );

  final String id;
  final String url;
  final int width;
  final int height;

  @override
  BreedImage fromJson(final Map<String, dynamic> source) => BreedImage(
        id: source['id'],
        url: source['url'],
        width: source['width'],
        height: source['height'],
      );

  @override
  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'url': url,
        'width': width,
        'height': height,
      };
}
