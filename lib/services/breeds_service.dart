import 'package:network_bound_resource/network_bound_resource.dart';

import '../exceptions/failure.dart';

class BreedsService {
  final NetworkBoundResource _httpClient;
  final String _breedsPath;
  final String _breedImagesPath;

  BreedsService({
    required NetworkBoundResource httpClient,
    required String breedsPath,
    required String breedImagesPath,
  })  : _httpClient = httpClient,
        _breedsPath = breedsPath,
        _breedImagesPath = breedImagesPath;

  Future<List<dynamic>> getBreeds() async {
    try {
      final response = await _httpClient.executeGet(
        path: _breedsPath,
        tableName: 'breeds',
      );

      return response.data;
    } on Exception catch (_) {
      throw Failure(
        'Tuvimos un error al intentar cargar los datos, intente nuevamente',
      );
    }
  }

  Future<Map<String, dynamic>> getBreedImage(String referencedImageId) async {
    try {
      final response = await _httpClient.executeGet(
        path: '$_breedImagesPath/$referencedImageId',
        tableName: 'breedsImages',
      );

      return response.data;
    } on Exception catch (_) {
      throw Failure(
        'Tuvimos un error al intentar cargar los datos, intente nuevamente',
      );
    }
  }
}
