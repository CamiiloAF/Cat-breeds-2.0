import 'package:flutter/material.dart';

import '../../models/breed_model.dart';
import 'breed_item.dart';
import 'breed_search_input.dart';

class BreedsList extends StatelessWidget {
  const BreedsList({Key? key, required this.breeds}) : super(key: key);

  final List<Breed> breeds;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          child: const BreedSearchInput(),
        ),
        breeds.isEmpty
            ? Center(
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
            : Expanded(
                child: ListView.separated(
                  itemCount: breeds.length,
                  separatorBuilder: (_, __) =>
                      const Divider(color: Colors.transparent),
                  itemBuilder: (context, index) {
                    final breed = breeds[index];

                    return BreedItem(breed: breed);
                  },
                ),
              ),
      ],
    );
  }
}
