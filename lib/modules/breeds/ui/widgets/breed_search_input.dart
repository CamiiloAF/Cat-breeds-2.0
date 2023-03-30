import 'package:flutter/material.dart';

import '../../../../app_config.dart';
import '../../blocs/breeds_bloc.dart';

class BreedSearchInput extends StatelessWidget {
  const BreedSearchInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final breedsBloc = blocCore.getBlocModule<BreedsBloc>(
      BreedsBloc.name,
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: TextField(
        textInputAction: TextInputAction.search,
        decoration: const InputDecoration(
          suffixIcon: Icon(Icons.search),
          contentPadding: EdgeInsets.symmetric(horizontal: 8),
        ),
        onChanged: (value) {
          breedsBloc.filterBreeds(value);
        },
        onSubmitted: (value) {
          breedsBloc.filterBreeds(value);
        },
      ),
    );
  }
}
