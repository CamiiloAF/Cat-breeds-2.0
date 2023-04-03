import 'package:flutter/material.dart';

import '../../../../app_config.dart';
import '../../../../core/blocs/navigator_bloc.dart';
import '../../domain/entities/breed_image_model.dart';
import '../../domain/entities/breed_model.dart';
import '../blocs/breeds_bloc.dart';
import '../pages/breed_detail_page.dart';
import 'breed_cache_image.dart';
import 'breed_image_placeholder.dart';

class BreedItem extends StatelessWidget {
  const BreedItem({
    required this.breed,
    final Key? key,
  }) : super(key: key);

  final Breed breed;

  @override
  Widget build(final BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return InkWell(
      onTap: _navigateToDetail,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: const BorderSide(color: Colors.black38),
        ),
        child: Column(
          children: [
            _buildHeader(textTheme, theme),
            _buildBreedImage(screenSize),
            _buildFooter(textTheme)
          ],
        ),
      ),
    );
  }

  Container _buildFooter(final TextTheme textTheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            breed.origin,
            style: textTheme.bodySmall,
          ),
          Text(
            'Inteligencia: ${breed.intelligence}',
            style: textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  SizedBox _buildBreedImage(final Size screenSize) {
    final breedsBloc = blocCore.getBlocModule<BreedsBloc>(
      BreedsBloc.name,
    );

    return SizedBox(
      height: screenSize.height * .3,
      width: double.infinity,
      child: breed.imageUrl != null
          ? BreedCacheImage(
              imageUrl: breed.imageUrl!,
              cacheKey: breed.id + breed.name,
            )
          : Builder(
        builder: (final context) {
                if (breed.referenceImageId == null) {
                  return const BreedImagePlaceholder();
                }

                return FutureBuilder<BreedImage>(
                  future: breedsBloc.getBreedImage(
                    breed.referenceImageId!,
                  ),
                  builder: (final context, final snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshot.hasError) {
                      return const BreedImagePlaceholder();
                    }

                    breed.imageUrl = snapshot.data?.url;

                    return snapshot.hasData
                        ? BreedCacheImage(
                            imageUrl: breed.imageUrl!,
                            cacheKey: breed.id + breed.name,
                          )
                        : const BreedImagePlaceholder();
                  },
                );
              },
            ),
    );
  }

  Widget _buildHeader(final TextTheme textTheme, final ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            breed.name,
            style: textTheme.titleLarge,
          ),
          TextButton(
            onPressed: _navigateToDetail,
            child: Text(
              'Más...',
              style: textTheme.titleLarge!.copyWith(
                color: theme.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToDetail() {
    blocCore
        .getBlocModule<NavigatorBloc>(NavigatorBloc.name)
        .pushPage('breedDetail', BreedDetailPage(breed: breed));
  }
}
