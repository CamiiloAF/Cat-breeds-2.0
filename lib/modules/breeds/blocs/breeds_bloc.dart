import 'dart:async';

import 'package:aleteo_triqui/services/breeds_service.dart';

import '../../../entities/entity_bloc.dart';
import '../../../exceptions/failure.dart';
import '../models/breed_image_model.dart';
import '../models/breeds_state_model.dart';

class BreedsBloc extends BlocModule {
  static const name = 'breedsBloc';

  BreedsBloc({
    required BreedsService breedsService,
  }) : _breedsService = breedsService;

  final BreedsService _breedsService;

  final BlocGeneral<BreedsStateModel> _breedsBloc =
      BlocGeneral<BreedsStateModel>(
    const BreedsStateModel.empty(),
  );

  BreedsStateModel get breeds => _breedsBloc.value;

  Stream<BreedsStateModel> get stateStream => _breedsBloc.stream;

  Future<void> getBreeds() async {
    _changeLoadingState(isLoading: true);

    try {
      final breeds = await _breedsService.getBreeds();
      _breedsBloc.value = _breedsBloc.value.copyWith(
        breeds: breeds,
        allBreads: [...breeds],
        hasError: false,
      );
    } on Failure {
      _breedsBloc.value = _breedsBloc.value.copyWith(
        hasError: true,
      );
      rethrow;
    } on Exception catch (_) {
      _breedsBloc.value = _breedsBloc.value.copyWith(
        hasError: true,
      );
      throw Failure();
    } finally {
      _changeLoadingState(isLoading: false);
    }
  }

  Future<BreedImage> getBreedImage(String referencedImageId) async {
    try {
      return _breedsService.getBreedImage(referencedImageId);
    } on Failure {
      rethrow;
    } on Exception catch (_) {
      throw Failure();
    }
  }

  void _changeLoadingState({required bool isLoading}) {
    _breedsBloc.value = _breedsBloc.value.copyWith(isLoading: isLoading);
  }

  @override
  FutureOr<void> dispose() {
    _breedsBloc.dispose();
  }

  void filterBreeds(String value) {
    final filteredBreeds = _breedsBloc.value.allBreads
        .where((bred) => bred.name.toLowerCase().contains(value.toLowerCase()))
        .toList();

    _breedsBloc.value = _breedsBloc.value.copyWith(
      breeds: filteredBreeds,
    );
  }
}
