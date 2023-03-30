import 'breed_model.dart';

class BreedsStateModel {
  final List<Breed> allBreads;
  final List<Breed> breeds;
  final bool isLoading;
  final bool hasError;

  const BreedsStateModel({
    required this.allBreads,
    required this.breeds,
    required this.isLoading,
    required this.hasError,
  });

  const BreedsStateModel.empty({
     this.allBreads = const [],
     this.breeds = const [],
     this.isLoading = false,
     this.hasError = false,
  });

  BreedsStateModel copyWith({
    List<Breed>? allBreads,
    List<Breed>? breeds,
    bool? isLoading,
    bool? hasError,
  }) {
    return BreedsStateModel(
      allBreads: allBreads ?? this.allBreads,
      breeds: breeds ?? this.breeds,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
    );
  }
}
