import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'breed_image_placeholder.dart';

class BreedCacheImage extends StatelessWidget {
  const BreedCacheImage({
    Key? key,
    required this.imageUrl,
    required this.cacheKey,
  }) : super(key: key);

  final String imageUrl;
  final String cacheKey;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: cacheKey,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        cacheKey: cacheKey,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => const BreedImagePlaceholder(),
      ),
    );
  }
}
