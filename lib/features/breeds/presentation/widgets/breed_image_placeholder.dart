import 'package:flutter/material.dart';

class BreedImagePlaceholder extends StatelessWidget {
  const BreedImagePlaceholder({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return Image.asset(
      'assets/images/cat_placeholder.png',
      fit: BoxFit.fitHeight,
    );
  }
}
