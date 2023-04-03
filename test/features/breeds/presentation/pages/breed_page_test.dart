import 'package:aleteo_triqui/app_config.dart';
import 'package:aleteo_triqui/core/blocs/bloc_user_notifications.dart';
import 'package:aleteo_triqui/core/exceptions/failure.dart';
import 'package:aleteo_triqui/features/breeds/presentation/blocs/breeds_bloc.dart';
import 'package:aleteo_triqui/features/breeds/presentation/pages/breeds_page.dart';
import 'package:aleteo_triqui/features/breeds/presentation/widgets/breeds_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../blocs/breeds_bloc_test.dart';

void main() {
  late MockGetBreedsUseCase getBreedsUseCase;
  late MockGetBreedImageUseCase getBreedImageUseCase;

  setUp(() {
    getBreedsUseCase = MockGetBreedsUseCase();
    getBreedImageUseCase = MockGetBreedImageUseCase();

    blocCore.addBlocModule(
      BreedsBloc.name,
      BreedsBloc(
        getBreedsUseCase: getBreedsUseCase,
        getBreedImageUseCase: getBreedImageUseCase,
      ),
    );
  });

  group('StreamBuilder states', () {
    testWidgets(
        'BreedsPage has a CircularProgressIndicator when data is loading',
        (tester) async {
          when(() => getBreedsUseCase(null)).thenAnswer((_) async => []);

      await tester.pumpWidget(
        const MaterialApp(
          home: BreedsPage(),
        ),
      );

      final circularProgressIndicatorFinder = find.byType(
        CircularProgressIndicator,
      );

      expect(circularProgressIndicatorFinder, findsOneWidget);
    });

    testWidgets('BreedsPage has a BreedsList when data is loaded',
        (tester) async {
          when(() => getBreedsUseCase(null)).thenAnswer((_) async => []);

      await tester.pumpWidget(
        const MaterialApp(
          home: BreedsPage(),
        ),
      );

      await tester.pump();

      final breedListFinder = find.byType(BreedsList);

      expect(breedListFinder, findsOneWidget);
    });

    testWidgets('BreedsPage has a SnackBar when data could not be loaded',
        (tester) async {
          const errorMessage = 'Could not load data';
      when(() => getBreedsUseCase(null)).thenThrow(Failure(errorMessage));

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(builder: (context) {
            blocCore.addBlocModule(
              UserNotificationsBloc.name,
              UserNotificationsBloc(context),
            );

            return const BreedsPage();
          }),
        ),
      );

      await tester.pump();

      final snackBarFinder = find.byType(SnackBar);
      final snackBarTextFinder = find.text(errorMessage);
      final breedsListFinder = find.byType(BreedsList);

      expect(snackBarFinder, findsOneWidget);
      expect(snackBarTextFinder, findsOneWidget);
      expect(breedsListFinder, findsNothing);
    });
  });
}
