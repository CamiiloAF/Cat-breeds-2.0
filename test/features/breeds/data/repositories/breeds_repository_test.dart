import 'package:aleteo_triqui/core/exceptions/failure.dart';
import 'package:aleteo_triqui/features/breeds/data/repositories/breeds_repository.dart';
import 'package:aleteo_triqui/features/breeds/domain/repositories/breeds_repository_contract.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_bound_resource/network_bound_resource.dart';

class MockHttpClient extends Mock implements NetworkBoundResource {}

void main() {
  late BreedsRepositoryContract breedsService;
  late NetworkBoundResource httpClient;

  setUp(() {
    httpClient = MockHttpClient();

    breedsService = BreedsRepository(
      httpClient: httpClient,
      breedsPath: '',
      breedImagesPath: '',
    );
  });

  group('getBreeds', () {
    test('Should return a list of breeds when http client response ok',
        () async {
      final breedJsonResponse = [
        {
          'weight': {'imperial': '7  -  10', 'metric': '3 - 5'},
          'id': 'abys',
          'name': 'Abyssinian',
          'cfa_url': 'http://cfa.org/Breeds/BreedsAB/Abyssinian.aspx',
          'vetstreet_url': 'http://www.vetstreet.com/cats/abyssinian',
          'vcahospitals_url':
              'https://vcahospitals.com/know-your-pet/cat-breeds/abyssinian',
          'temperament': 'Active, Energetic, Independent, Intelligent, Gentle',
          'origin': 'Egypt',
          'country_codes': 'EG',
          'country_code': 'EG',
          'description':
              'The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals.',
          'life_span': '14 - 15',
          'indoor': 0,
          'lap': 1,
          'alt_names': '',
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
          'wikipedia_url': 'https://en.wikipedia.org/wiki/Abyssinian_(cat)',
          'hypoallergenic': 0,
          'reference_image_id': '0XYvRd7oD'
        }
      ];

      when(
        () => httpClient.executeGet(
          path: any(named: 'path'),
          tableName: any(named: 'tableName'),
        ),
      ).thenAnswer(
            (final _) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: breedJsonResponse,
          statusCode: 200,
        ),
      );

      final response = await breedsService.getBreeds();

      expect(response.length, 1);
    });

    test('Should throw a Failure when http client throws a DioError', () async {
      when(
        () => httpClient.executeGet(
          path: any(named: 'path'),
          tableName: any(named: 'tableName'),
        ),
      ).thenThrow(
        DioError(requestOptions: RequestOptions(path: ''), error: 'Error'),
      );

      await expectLater(breedsService.getBreeds(), throwsA(isA<Failure>()));
    });
  });

  group('getBreedImage', () {
    test('Should return a BreedImage when http client response ok', () async {
      final breedImageJsonResponse = {
        'id': '0XYvRd7oD',
        'url': 'https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg',
        'breeds': [
          {
            'weight': {'imperial': '7  -  10', 'metric': '3 - 5'},
            'id': 'abys',
            'name': 'Abyssinian',
            'cfa_url': 'http://cfa.org/Breeds/BreedsAB/Abyssinian.aspx',
            'vetstreet_url': 'http://www.vetstreet.com/cats/abyssinian',
            'vcahospitals_url':
                'https://vcahospitals.com/know-your-pet/cat-breeds/abyssinian',
            'temperament':
                'Active, Energetic, Independent, Intelligent, Gentle',
            'origin': 'Egypt',
            'country_codes': 'EG',
            'country_code': 'EG',
            'description':
                'The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals.',
            'life_span': '14 - 15',
            'indoor': 0,
            'lap': 1,
            'alt_names': '',
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
            'wikipedia_url': 'https://en.wikipedia.org/wiki/Abyssinian_(cat)',
            'hypoallergenic': 0,
            'reference_image_id': '0XYvRd7oD'
          }
        ],
        'width': 1204,
        'height': 1445
      };

      when(
        () => httpClient.executeGet(
          path: any(named: 'path'),
          tableName: any(named: 'tableName'),
        ),
      ).thenAnswer(
            (final _) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: breedImageJsonResponse,
          statusCode: 200,
        ),
      );

      final response = await breedsService.getBreedImage('referencedImageId');

      expect(response.height, 1445);
    });

    test('Should throw a Failure when http client throws a DioError', () async {
      when(
        () => httpClient.executeGet(
          path: any(named: 'path'),
          tableName: any(named: 'tableName'),
        ),
      ).thenThrow(
        DioError(requestOptions: RequestOptions(path: ''), error: 'Error'),
      );

      await expectLater(
        breedsService.getBreedImage('referencedImageId'),
        throwsA(isA<Failure>()),
      );
    });
  });
}
