import 'package:flutter/material.dart';

import '../../../../app_config.dart';
import '../../../../core/blocs/navigator_bloc.dart';
import '../../domain/entities/breed_model.dart';
import '../widgets/breed_cache_image.dart';
import '../widgets/breed_image_placeholder.dart';

class BreedDetailPage extends StatelessWidget {
  const BreedDetailPage({
    required this.breed,
    final Key? key,
  }) : super(key: key);

  final Breed breed;

  @override
  Widget build(final BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          onTap: () =>
              blocCore.getBlocModule<NavigatorBloc>(NavigatorBloc.name).back(),
          child: const Icon(Icons.arrow_back),
        ),
        title: Text(breed.name),
      ),
      body: Column(
        children: [
          SizedBox(
            height: screenSize.height * .5,
            child: breed.imageUrl != null
                ? BreedCacheImage(
                    imageUrl: breed.imageUrl!,
                    cacheKey: breed.id + breed.name,
                  )
                : const BreedImagePlaceholder(),
          ),
          Expanded(
            child: Scrollbar(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Text(breed.description, style: textTheme.titleMedium),
                    _buildSeparator(),
                    _buildTextSpan('Country', breed.origin),
                    _buildTextSpan('Intelligence', '${breed.intelligence}'),
                    _buildTextSpan('Adaptability', '${breed.adaptability}'),
                    _buildTextSpan('Vitality', breed.lifeSpan),
                    _buildSeparator(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox _buildSeparator() => const SizedBox(height: 16);

  Widget _buildTextSpan(final String title, final String text) {
    return Builder(
      builder: (final context) {
        final textTheme = Theme.of(context).textTheme;

        return RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '$title: ',
                style: textTheme.titleMedium!.copyWith(color: Colors.black),
              ),
              TextSpan(text: text, style: textTheme.titleMedium)
            ],
          ),
        );
      },
    );
  }
}
