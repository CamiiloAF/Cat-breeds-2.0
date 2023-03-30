import 'package:flutter/material.dart';

class BreedImagePlaceholder extends StatelessWidget {
  const BreedImagePlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/cat_placeholder.png',
      fit: BoxFit.fitHeight,
    );
  }
}
