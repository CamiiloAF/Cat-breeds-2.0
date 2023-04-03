import 'package:aleteo_triqui/features/breeds/presentation/pages/breed_detail_page.dart';
import 'package:aleteo_triqui/features/breeds/presentation/widgets/breed_item.dart';
import 'package:aleteo_triqui/features/breeds/presentation/widgets/breed_search_input.dart';
import 'package:aleteo_triqui/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('tap on breed item, verify navigate to detail page',
        (final tester) async {
      app.main();
      await tester.pumpAndSettle();

      final breedItem = find.byType(BreedItem).first;
      await tester.tap(breedItem);

      await tester.pumpAndSettle();

      expect(find.byType(BreedDetailPage), findsOneWidget);

      final detailPageBackButtonItem =
          find.widgetWithIcon(GestureDetector, Icons.arrow_back);
      await tester.tap(detailPageBackButtonItem);

      await tester.pumpAndSettle();

          expect(find.byType(BreedDetailPage), findsNothing);
        });

    testWidgets('tap on "Más..." button, verify navigate to detail page',
            (final tester) async {
          app.main();
          await tester.pumpAndSettle();

          final breedItemTextButton =
              find
                  .widgetWithText(TextButton, 'Más...')
                  .first;
          await tester.tap(breedItemTextButton);

          await tester.pumpAndSettle();

          expect(find.byType(BreedDetailPage), findsOneWidget);

          final detailPageBackButtonItem =
          find.widgetWithIcon(GestureDetector, Icons.arrow_back);
          await tester.tap(detailPageBackButtonItem);

          await tester.pumpAndSettle();

          expect(find.byType(BreedDetailPage), findsNothing);
        });

    testWidgets('search breeds, verify found nothing', (final tester) async {
      app.main();
      await tester.pumpAndSettle();

      final breedItemTextButton = find.byType(BreedSearchInput);
      await tester.enterText(breedItemTextButton, 'Nothing to found');

      await tester.pumpAndSettle();

      expect(find.text('No hemos encontrado resultados'), findsOneWidget);
    });

    testWidgets('search breeds, verify filter breeds', (final tester) async {
      app.main();
      await tester.pumpAndSettle();

      final allBreedItems = find.byType(BreedItem);
      final allBreedItemsCount = allBreedItems
          .evaluate()
          .length;

      final breedItemTextButton = find.byType(BreedSearchInput);
      await tester.enterText(breedItemTextButton, 'Abys');

      await tester.pumpAndSettle();

      final filteredBreedItems = find.byType(BreedItem);

      expect(
        allBreedItemsCount,
        greaterThan(filteredBreedItems
            .evaluate()
            .length),
      );
    });
  });
}
