import '../../../../core/use_case/use_case.dart';
import '../entities/breed_model.dart';
import '../repositories/breeds_repository_contract.dart';

class GetBreedsUseCase implements UseCase<Future<List<Breed>>, void> {
  GetBreedsUseCase(this._repository);

  final BreedsRepositoryContract _repository;

  @override
  Future<List<Breed>> call(_) async {
    return _repository.getBreeds();
  }
}
