import 'package:network_bound_resource/network_bound_resource.dart';

import '../../../../core/exceptions/failure.dart';
import '../../domain/entities/breed_image_model.dart';
import '../../domain/entities/breed_model.dart';
import '../../domain/repositories/breeds_repository_contract.dart';

class BreedsRepository implements BreedsRepositoryContract {

  BreedsRepository({
    required final NetworkBoundResource httpClient,
    required final String breedsPath,
    required final String breedImagesPath,
  })  : _httpClient = httpClient,
        _breedsPath = breedsPath,
        _breedImagesPath = breedImagesPath;
  final NetworkBoundResource _httpClient;
  final String _breedsPath;
  final String _breedImagesPath;

  @override
  Future<List<Breed>> getBreeds() async {
    try {
      final response = await _httpClient.executeGet(
        path: _breedsPath,
        tableName: 'breeds',
      );

      return breedsFromJson(response.data);
    } on Exception catch (_) {
      throw Failure(
        'Tuvimos un error al intentar cargar los datos, intente nuevamente',
      );
    }
  }

  @override
  Future<BreedImage> getBreedImage(final String referencedImageId) async {
    try {
      final response = await _httpClient.executeGet(
        path: '$_breedImagesPath/$referencedImageId',
        tableName: 'breedsImages',
      );

      return breedImageFromJson(response.data);
    } on Exception catch (_) {
      throw Failure(
        'Tuvimos un error al intentar cargar los datos, intente nuevamente',
      );
    }
  }

}
