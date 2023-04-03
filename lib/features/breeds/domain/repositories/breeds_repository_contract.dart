import '../entities/breed_image_model.dart';
import '../entities/breed_model.dart';

abstract class BreedsRepositoryContract {
  Future<List<Breed>> getBreeds();

  Future<BreedImage> getBreedImage(String referencedImageId);
}
