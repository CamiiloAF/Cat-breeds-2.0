import 'dart:async';

import '../../../../core/entities/entity_bloc.dart';
import '../../../../core/exceptions/failure.dart';
import '../../domain/entities/breed_image_model.dart';
import '../../domain/entities/breeds_state_model.dart';
import '../../domain/use_cases/get_breed_image_use_case.dart';
import '../../domain/use_cases/get_breeds_use_case.dart';

class BreedsBloc extends BlocModule {
  BreedsBloc({
    required final GetBreedsUseCase getBreedsUseCase,
    required final GetBreedImageUseCase getBreedImageUseCase,
  })  : _getBreedsUseCase = getBreedsUseCase,
        _getBreedImageUseCase = getBreedImageUseCase;
  static const name = 'breedsBloc';

  final GetBreedsUseCase _getBreedsUseCase;
  final GetBreedImageUseCase _getBreedImageUseCase;

  final BlocGeneral<BreedsStateModel> _breedsBloc =
      BlocGeneral<BreedsStateModel>(
    const BreedsStateModel.empty(),
  );

  BreedsStateModel get breeds => _breedsBloc.value;

  Stream<BreedsStateModel> get stateStream => _breedsBloc.stream;

  Future<void> getBreeds() async {
    _changeLoadingState(isLoading: true);

    try {
      final breeds = await _getBreedsUseCase(null);
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

  Future<BreedImage> getBreedImage(final String referencedImageId) async {
    try {
      return _getBreedImageUseCase(referencedImageId);
    } on Failure {
      rethrow;
    } on Exception catch (_) {
      throw Failure();
    }
  }

  void _changeLoadingState({required final bool isLoading}) {
    _breedsBloc.value = _breedsBloc.value.copyWith(isLoading: isLoading);
  }

  @override
  FutureOr<void> dispose() {
    _breedsBloc.dispose();
  }

  void filterBreeds(final String value) {
    final filteredBreeds = _breedsBloc.value.allBreads
        .where((final bred) =>
            bred.name.toLowerCase().contains(value.toLowerCase()))
        .toList();

    _breedsBloc.value = _breedsBloc.value.copyWith(
      breeds: filteredBreeds,
    );
  }
}
