import 'package:flutter/material.dart';

import '../../domain/entities/breed_model.dart';
import 'breed_item.dart';
import 'breed_search_input.dart';

class BreedsList extends StatelessWidget {
  const BreedsList({
    required this.breeds,
    final Key? key,
  }) : super(key: key);

  final List<Breed> breeds;

  @override
  Widget build(final BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          child: const BreedSearchInput(),
        ),
        if (breeds.isEmpty)
          Center(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                child: Center(
                  child: Text(
                    'No hemos encontrado resultados',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
            ),
          )
        else
          Expanded(
            child: ListView.separated(
              itemCount: breeds.length,
              separatorBuilder: (final _, final __) =>
                  const Divider(color: Colors.transparent),
              itemBuilder: (final context, final index) {
                final breed = breeds[index];

                return BreedItem(breed: breed);
              },
            ),
          ),
      ],
    );
  }
}
