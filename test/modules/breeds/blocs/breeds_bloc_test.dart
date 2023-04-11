import 'package:aleteo_triqui/exceptions/failure.dart';
import 'package:aleteo_triqui/modules/breeds/blocs/breeds_bloc.dart';
import 'package:aleteo_triqui/services/breeds_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBreedsService extends Mock implements BreedsService {}

void main() {
  late BreedsBloc breedsBloc;
  late MockBreedsService breedsService;

  setUp(() {
    breedsService = MockBreedsService();
    breedsBloc = BreedsBloc(breedsService: breedsService);
  });

  group('getBreeds', () {
    test('Should return a list of breeds', () async {
      final breed = {
        'weight': {
          'imperial': "7  -  10",
          'metric': "3 - 5",
        },
        'id': "abys",
        'name': "Abyssinian",
        'cfa_url': "http://cfa.org/Breeds/BreedsAB/Abyssinian.aspx",
        'vetstreet_url': "http://www.vetstreet.com/cats/abyssinian",
        'vcahospitals_url':
            "https//vcahospitals.com/know-your-pet/cat-breeds/abyssinian",
        'temperament': "Active, Energetic, Independent, Intelligent, Gentle",
        'origin': "Egypt",
        'country_codes': "EG",
        'country_code': "EG",
        'description':
            "TheAbyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals.",
        'life_span': "14 - 15",
        'indoor': 0,
        'lap': 1,
        'alt_names': "",
        'adaptability': 5,
        'affection_level': 5,
        'child_friendly': 3,
        'dog_friendly': 4,
        'energy_level': 5,
        'grooming': 1,
        'health_issues': 2,
        'intelligence': 5,
        'shedding_level': 2,
        'social_needs': 5,
        'stranger_friendly': 5,
        'vocalisation': 1,
        'experimental': 0,
        'hairless': 0,
        'natural': 1,
        'rare': 0,
        'rex': 0,
        'suppressed_tail': 0,
        'short_legs': 0,
        'wikipedia_url': "https://en.wikipedia.org/wiki/Abyssinian_(cat)",
        'hypoallergenic': 0,
        'reference_image_id': "0XYvRd7oD",
        'cat_friendly': null,
        'bidability': null,
      };

      when(
        () => breedsService.getBreeds(),
      ).thenAnswer(
        (_) async => [breed],
      );

      await breedsBloc.getBreeds();

      expect(breedsBloc.breeds.isLoading, false);
      expect(breedsBloc.breeds.breeds.length, 1);
      expect(breedsBloc.breeds.allBreads.length, 1);
    });

    test('Should throw a Failure when service fail', () async {
      when(
        () => breedsService.getBreeds(),
      ).thenThrow(Failure());

      await expectLater(breedsBloc.getBreeds(), throwsA(isA<Failure>()));
    });

    test('Should throw a Failure when service throws an Exception', () async {
      when(
        () => breedsService.getBreeds(),
      ).thenThrow(const FormatException());

      await expectLater(breedsBloc.getBreeds(), throwsA(isA<Failure>()));
    });
  });

  group('getBreedImage', () {
    test('Should return a BreedImage', () async {
      final breedImage = {
        'id': '0XYvRd7oD',
        'url': 'https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg',
        'width': 1204,
        'height': 1445
      };

      when(
        () => breedsService.getBreedImage(any()),
      ).thenAnswer(
        (_) async => breedImage,
      );

      final response = await breedsBloc.getBreedImage('referencedImageId');

      expect(response.id, breedImage['id']);
    });

    test('Should throw a Failure when service fail', () async {
      when(
        () => breedsService.getBreedImage(any()),
      ).thenThrow(Failure());

      await expectLater(
        breedsBloc.getBreedImage('referencedImageId'),
        throwsA(
          isA<Failure>(),
        ),
      );
    });

    test('Should throw a Failure when service throws an Exception', () async {
      when(
        () => breedsService.getBreedImage(any()),
      ).thenThrow(const FormatException());

      await expectLater(
        breedsBloc.getBreedImage('referencedImageId'),
        throwsA(isA<Failure>()),
      );
    });
  });
}
