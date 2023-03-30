import 'package:aleteo_triqui/exceptions/failure.dart';
import 'package:aleteo_triqui/modules/breeds/blocs/breeds_bloc.dart';
import 'package:aleteo_triqui/modules/breeds/models/breed_image_model.dart';
import 'package:aleteo_triqui/modules/breeds/models/breed_model.dart';
import 'package:aleteo_triqui/modules/breeds/models/weight_model.dart';
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
      final breed = Breed(
        weight: Weight(
          imperial: "7  -  10",
          metric: "3 - 5",
        ),
        id: "abys",
        name: "Abyssinian",
        cfaUrl: "http://cfa.org/Breeds/BreedsAB/Abyssinian.aspx",
        vetstreetUrl: "http://www.vetstreet.com/cats/abyssinian",
        vcahospitalsUrl:
            "https//vcahospitals.com/know-your-pet/cat-breeds/abyssinian",
        temperament: "Active, Energetic, Independent, Intelligent, Gentle",
        origin: "Egypt",
        countryCodes: "EG",
        countryCode: "EG",
        description:
            "TheAbyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals.",
        lifeSpan: "14 - 15",
        indoor: 0,
        lap: 1,
        altNames: "",
        adaptability: 5,
        affectionLevel: 5,
        childFriendly: 3,
        dogFriendly: 4,
        energyLevel: 5,
        grooming: 1,
        healthIssues: 2,
        intelligence: 5,
        sheddingLevel: 2,
        socialNeeds: 5,
        strangerFriendly: 5,
        vocalisation: 1,
        experimental: 0,
        hairless: 0,
        natural: 1,
        rare: 0,
        rex: 0,
        suppressedTail: 0,
        shortLegs: 0,
        wikipediaUrl: "https://en.wikipedia.org/wiki/Abyssinian_(cat)",
        hypoallergenic: 0,
        referenceImageId: "0XYvRd7oD",
        catFriendly: null,
        bidability: null,
      );

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
      final breedImage = BreedImage(
          id: "0XYvRd7oD",
          url: "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg",
          width: 1204,
          height: 1445);

      when(
        () => breedsService.getBreedImage(any()),
      ).thenAnswer(
        (_) async => breedImage,
      );

      final response = await breedsBloc.getBreedImage('referencedImageId');

      expect(response, breedImage);
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
