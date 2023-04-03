import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'breed_image_placeholder.dart';

class BreedCacheImage extends StatelessWidget {
  const BreedCacheImage({
    required this.imageUrl,
    required this.cacheKey,
    final Key? key,
  }) : super(key: key);

  final String imageUrl;
  final String cacheKey;

  @override
  Widget build(final BuildContext context) {
    return Hero(
      tag: cacheKey,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        cacheKey: cacheKey,
        fit: BoxFit.cover,
        errorWidget: (final context, final url, final error) =>
            const BreedImagePlaceholder(),
      ),
    );
  }
}
