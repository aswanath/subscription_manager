import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:subsciption_manager/data/models/subscription_type_model.dart';
import 'package:subsciption_manager/modules/subscription/presentation/widgets/animated_stacked_list.dart';

import '../../../../material_app_widget.dart';

void main() {
  const mockSubscription = SubscriptionTypeModel(
    name: 'Netflix',
    amount: 199,
    isMonthly: true,
    imagePath: 'assets/netflix.png',
    glowColor: Colors.red,
  );

  const mockSubscription2 = SubscriptionTypeModel(
    name: 'Spotify',
    amount: 129,
    isMonthly: true,
    imagePath: 'assets/spotify.png',
    glowColor: Colors.green,
  );

  group(
    "animated stacked list test",
    () {
      testWidgets('renders one subscription and add button', (tester) async {
        await tester.pumpWidget(
          materialApp(
            const Scaffold(
              body: AnimatedStackedList(
                key: Key("animatedStackedListKey"),
                subscriptions: [
                  mockSubscription,
                ],
              ),
            ),
          ),
        );

        expect(find.byKey(const Key("animatedStackedListKey")), findsOneWidget);
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
            mockSubscription.name);
      });

      testWidgets('renders only add button when subscription list is empty',
          (tester) async {
        await tester.pumpWidget(
          materialApp(
            const Scaffold(
              body: AnimatedStackedList(
                subscriptions: [],
              ),
            ),
          ),
        );

        final animatedStackedListItemTitleFinder =
            find.byKey(const Key("animatedStackedListItemTitleKey"));

        expect(animatedStackedListItemTitleFinder, findsOneWidget);

        expect(
            (tester.widget(animatedStackedListItemTitleFinder.at(0)) as Text)
                .data,
            "Add a subscription");
      });

      testWidgets('adds a new subscription dynamically', (tester) async {
        late StateSetter setStateCallback;
        List<SubscriptionTypeModel> subscriptions = [mockSubscription];

        await tester.pumpWidget(
          materialApp(
            Scaffold(
              body: StatefulBuilder(
                builder: (context, setState) {
                  setStateCallback = setState;
                  return AnimatedStackedList(
                    subscriptions: subscriptions,
                  );
                },
              ),
            ),
          ),
        );

        final animatedStackedListItemTitleFinder =
            find.byKey(const Key("animatedStackedListItemTitleKey"));

        expect(animatedStackedListItemTitleFinder, findsNWidgets(2));

        expect(
            (tester.widget(animatedStackedListItemTitleFinder.at(1)) as Text)
                .data,
            mockSubscription.name);

        setStateCallback(() {
          subscriptions = [mockSubscription, mockSubscription2];
        });

        await tester.pumpAndSettle();

        final animatedStackedListItemTitleFinder1 =
            find.byKey(const Key("animatedStackedListItemTitleKey"));

        expect(animatedStackedListItemTitleFinder1, findsNWidgets(3));

        expect(
            (tester.widget(animatedStackedListItemTitleFinder1.at(2)) as Text)
                .data,
            mockSubscription2.name);
      });

      testWidgets('removes a new subscription dynamically', (tester) async {
        late StateSetter setStateCallback;
        List<SubscriptionTypeModel> subscriptions = [
          mockSubscription,
          mockSubscription2
        ];

        await tester.pumpWidget(
          materialApp(
            Scaffold(
              body: StatefulBuilder(
                builder: (context, setState) {
                  setStateCallback = setState;
                  return AnimatedStackedList(
                    subscriptions: subscriptions,
                  );
                },
              ),
            ),
          ),
        );

        final animatedStackedListItemTitleFinder =
            find.byKey(const Key("animatedStackedListItemTitleKey"));

        expect(animatedStackedListItemTitleFinder, findsNWidgets(3));

        expect(
            (tester.widget(animatedStackedListItemTitleFinder.at(2)) as Text)
                .data,
            mockSubscription2.name);

        setStateCallback(() {
          subscriptions = [mockSubscription];
        });

        await tester.pumpAndSettle();

        final animatedStackedListItemTitleFinder1 =
            find.byKey(const Key("animatedStackedListItemTitleKey"));

        expect(animatedStackedListItemTitleFinder1, findsNWidgets(2));

        expect(
            (tester.widget(animatedStackedListItemTitleFinder1.at(1)) as Text)
                .data,
            mockSubscription.name);
      });
    },
  );
}
