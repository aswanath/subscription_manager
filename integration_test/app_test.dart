import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:integration_test/integration_test.dart';
import 'package:subsciption_manager/app.dart';
import 'package:subsciption_manager/core/dependency_injection/injection_container.dart';
import 'package:subsciption_manager/core/hive_adaptors/register_hive_adaptors.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  registerAdaptors();
  await configureDependencies();

  group('end-to-end test', () {
    testWidgets('open app and add a category, verify lists', (
      tester,
    ) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));

      //verifying get started screen
      expect(find.byKey(const Key("getStartedButtonKey")), findsOneWidget);

      //navigating to home screen
      await tester.tap(find.byKey(const Key("getStartedButtonKey")));
      await tester.pumpAndSettle(const Duration(seconds: 4));
      await Future.delayed(const Duration(seconds: 2));

      //verifying home screen
      expect(find.byKey(const Key("homeScreenKey")), findsOneWidget);

      //changing tab to general screen
      expect(find.byKey(const Key("subscriptionScreenKey")), findsOneWidget);
      expect(find.byKey(const Key("generalScreenKey")), findsNothing);

      await tester.tap(find.byKey(const Key("dashboardIconKey")));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));

      expect(find.byKey(const Key("subscriptionScreenKey")), findsNothing);
      expect(find.byKey(const Key("generalScreenKey")), findsOneWidget);

      //changing back to subscription screen and verifying all elements
      await tester.tap(find.byKey(const Key("subscriptionsIconKey")));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));

      expect(find.byKey(const Key("subscriptionScreenKey")), findsOneWidget);
      expect(find.byKey(const Key("generalScreenKey")), findsNothing);

      expect(
          find.byKey(const Key("animatedTabBarTabChipKey")), findsNWidgets(2));
      expect(find.byKey(const Key("animatedStackedListItemTitleKey")),
          findsAtLeast(4));

      //tapping on + button to add new category
      await tester.tap(find.byKey(const Key("animatedTabBarTabChipKey")).last);
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));

      //verify and enter category name and select items
      expect(
          find.byKey(const Key("addCategoryBottomSheetKey")), findsOneWidget);
      const testName = 'Entertainment';
      await tester.enterText(
          find.byKey(const Key('categoryNameFieldKey')), testName);
      await tester.pump();
      await Future.delayed(const Duration(seconds: 2));

      //save button should not be enabled at this point
      await tester.tap(find.byKey(const Key('saveButtonKey')));
      await tester.pumpAndSettle();
      expect(
          find.byKey(const Key("addCategoryBottomSheetKey")), findsOneWidget);
      await Future.delayed(const Duration(seconds: 2));

      //tap checkbox to add one item
      await tester.tap(find.byKey(const Key('subscriptionCheckBoxKey0')));
      await tester.pump();
      await Future.delayed(const Duration(seconds: 2));

      final String sub0 = (tester.widget(
                  find.byKey(const Key("addCategorySubscriptionListTileKey0")))
              as Text)
          .data!;

      //tap on save and it should navigate back
      await tester.tap(find.byKey(const Key('saveButtonKey')));
      await tester.pumpAndSettle();
      expect(find.byKey(const Key("addCategoryBottomSheetKey")), findsNothing);
      await Future.delayed(const Duration(seconds: 2));

      //verifying new added data
      expect(
          find.byKey(const Key("animatedTabBarTabChipKey")), findsNWidgets(3));
      final animatedStackedListItemTitleFinder =
          find.byKey(const Key("animatedStackedListItemTitleKey"));
      expect(animatedStackedListItemTitleFinder, findsNWidgets(2));
      expect(
          (tester.widget(animatedStackedListItemTitleFinder.at(0)) as Text)
              .data,
          "Add a subscription");
      expect(
          (tester.widget(animatedStackedListItemTitleFinder.at(1)) as Text)
              .data,
          sub0);

      //changing to all subs tab
      await tester.tap(find.byKey(const Key("animatedTabBarTabChipKey")).first);
      await tester.pumpAndSettle(const Duration(seconds: 2));
      await Future.delayed(const Duration(seconds: 1));
    });
  });
}
