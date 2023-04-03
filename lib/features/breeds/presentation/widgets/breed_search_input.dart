import 'package:flutter/material.dart';

import '../../../../app_config.dart';
import '../blocs/breeds_bloc.dart';

class BreedSearchInput extends StatelessWidget {
  const BreedSearchInput({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    final breedsBloc = blocCore.getBlocModule<BreedsBloc>(
      BreedsBloc.name,
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: TextField(
        textInputAction: TextInputAction.search,
        decoration: const InputDecoration(
          suffixIcon: Icon(Icons.search),
          contentPadding: EdgeInsets.symmetric(horizontal: 8),
        ),
        onChanged: breedsBloc.filterBreeds,
        onSubmitted: breedsBloc.filterBreeds,
      ),
    );
  }
}
