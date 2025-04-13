import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_test/hive_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:subsciption_manager/config/constants/app_constants.dart';
import 'package:subsciption_manager/core/dependency_injection/injection_container.dart';
import 'package:subsciption_manager/core/hive_adaptors/register_hive_adaptors.dart';
import 'package:subsciption_manager/modules/subscription/data/models/subscription_group_model.dart';
import 'package:subsciption_manager/modules/subscription/data/repository/isubscription_repository.dart';
import 'package:subsciption_manager/modules/subscription/presentation/screens/subscription_screen.dart';
import 'package:subsciption_manager/modules/subscription/presentation/widgets/animated_tab_bar.dart'
    show TabChip;

import '../../../../material_app_widget.dart';
import 'subscription_screen_test.mocks.dart';

@GenerateMocks([ISubscriptionRepository])
void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await setUpTestHive();
  registerAdaptors();
  await configureDependencies();
  final ISubscriptionRepository subscriptionRepository =
      MockISubscriptionRepository();
  await getIt.unregister<ISubscriptionRepository>();
  getIt.registerSingleton<ISubscriptionRepository>(subscriptionRepository);
  final List<SubscriptionGroupModel> subs = [
    SubscriptionGroupModel(
      AppConstants.kAllSubs,
      AppConstants.subscriptions.keys.toList(),
    ),
  ];

  group(
    "subscription screen test",
    () {
      testWidgets('AddCategory flow works', (WidgetTester tester) async {
        when(subscriptionRepository.getSubscriptionGroups()).thenAnswer(
          (_) async => subs,
        );

        await tester.pumpWidget(
          materialApp(
            const SubscriptionScreen(
              key: Key("subscriptionScreenKey"),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.byKey(const Key("subscriptionScreenKey")), findsOneWidget);
        expect(find.byKey(const Key("animatedTabListKey")), findsOneWidget);
        expect(find.byKey(const Key("animatedStackedListKey")), findsOneWidget);

        final animatedStackedListItemTitleFinder =
            find.byKey(const Key("animatedStackedListItemTitleKey"));

        expect(animatedStackedListItemTitleFinder, findsAtLeast(4));
        final animatedTabBarTabChipFinder =
            find.byKey(const Key("animatedTabBarTabChipKey"));
        expect(animatedTabBarTabChipFinder, findsNWidgets(2));

        expect(
            (tester.widget(animatedTabBarTabChipFinder.at(0)) as TabChip)
                .isSelected,
            true);

        //Tap the + (Add Category) button
        await tester.tap(animatedTabBarTabChipFinder.last);
        await tester.pumpAndSettle();

        // Type category name
        final nameField = find.byKey(const Key('categoryNameFieldKey'));
        await tester.enterText(nameField, 'Entertainment');

        // Tap some checkboxes
        final checkBox1 = find.byKey(const Key('subscriptionCheckBoxKey0'));
        final checkBox2 = find.byKey(const Key('subscriptionCheckBoxKey1'));
        await tester.tap(checkBox1);
        await tester.tap(checkBox2);

        final String sub0 = (tester.widget(find.byKey(
                const Key("addCategorySubscriptionListTileKey0"))) as Text)
            .data!;
        final String sub1 = (tester.widget(find.byKey(
                const Key("addCategorySubscriptionListTileKey1"))) as Text)
            .data!;

        await tester.pumpAndSettle();
        final newSubModel = SubscriptionGroupModel(
          "Entertainment",
          [
            sub0,
            sub1,
          ],
        );
        subs.add(newSubModel);

        when(
          subscriptionRepository.addSubGroup(
            newSubModel,
          ),
        ).thenAnswer((_) => Future.value(true));

        when(subscriptionRepository.getSubscriptionGroups()).thenAnswer(
          (_) async => subs,
        );

        // Tap Save button
        final saveBtn = find.byKey(const Key('saveButtonKey'));
        expect(saveBtn, findsOneWidget);
        await tester.tap(saveBtn);
        await tester.pumpAndSettle();

        //ensure that the tab and list changed.
        final animatedStackedListItemTitleFinder1 =
            find.byKey(const Key("animatedStackedListItemTitleKey"));

        expect(animatedStackedListItemTitleFinder1, findsNWidgets(3));

        final animatedTabBarTabChipFinder1 =
            find.byKey(const Key("animatedTabBarTabChipKey"));

        expect(animatedTabBarTabChipFinder1, findsNWidgets(3));

        expect(
            (tester.widget(animatedTabBarTabChipFinder1.at(1)) as TabChip)
                .isSelected,
            true);
      });
    },
  );
}
