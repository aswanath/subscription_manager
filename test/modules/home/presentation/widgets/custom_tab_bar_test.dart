import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:subsciption_manager/modules/home/presentation/widgets/custom_tab_bar.dart';

import '../../../../material_app_widget.dart';

void main() {
  group(
    "custom tab bar test",
    () {
      testWidgets(
        "make sure all items are showing properly and callback is working",
        (tester) async {
          int index = 0;
          await tester.pumpWidget(
            materialApp(
              Scaffold(
                body: Center(
                  child: CustomTabBar(
                    key: const Key("customTabBarKey"),
                    initialIndex: 0,
                    onChanged: (i) {
                      index = i;
                    },
                  ),
                ),
              ),
            ),
          );

          await tester.pump();
          expect(index, 0);
          expect(find.byKey(const Key("customTabBarKey")), findsOneWidget);

          final animatedAlignFinder =
              find.byKey(const Key("customTabBarAnimatedAlignKey"));
          expect(animatedAlignFinder, findsOneWidget);
          expect(
              (tester.widget(animatedAlignFinder) as AnimatedAlign).alignment,
              Alignment.centerLeft);

          final dashboardIconFinder = find.byKey(const Key("dashboardIconKey"));
          expect(dashboardIconFinder, findsOneWidget);
          expect((tester.widget(dashboardIconFinder) as Icon).icon,
              Icons.dashboard_customize);

          final subscriptionsIconFinder =
              find.byKey(const Key("subscriptionsIconKey"));
          expect(subscriptionsIconFinder, findsOneWidget);
          expect((tester.widget(subscriptionsIconFinder) as Icon).icon,
              Icons.subscriptions_outlined);

          expect(find.byKey(const Key("generalTextKey")), findsOneWidget);
          expect(find.byKey(const Key("mySubsTextKey")), findsNothing);

          //tapping on same icon to ensure it is not navigating.
          await tester.tap(dashboardIconFinder);
          await tester.pumpAndSettle();
          expect(find.byKey(const Key("generalTextKey")), findsOneWidget);
          expect(find.byKey(const Key("mySubsTextKey")), findsNothing);
          expect(index, 0);

          //changing tab to index 1.
          await tester.tap(subscriptionsIconFinder);
          await tester.pumpAndSettle();
          expect(find.byKey(const Key("generalTextKey")), findsNothing);
          expect(find.byKey(const Key("mySubsTextKey")), findsOneWidget);

          expect(index, 1);

          final animatedAlignFinder1 =
              find.byKey(const Key("customTabBarAnimatedAlignKey"));
          expect(animatedAlignFinder1, findsOneWidget);
          expect(
              (tester.widget(animatedAlignFinder1) as AnimatedAlign).alignment,
              Alignment.centerRight);

          final dashboardIconFinder1 =
              find.byKey(const Key("dashboardIconKey"));
          expect(dashboardIconFinder1, findsOneWidget);
          expect((tester.widget(dashboardIconFinder1) as Icon).icon,
              Icons.dashboard_customize_outlined);

          final subscriptionsIconFinder1 =
              find.byKey(const Key("subscriptionsIconKey"));
          expect(subscriptionsIconFinder1, findsOneWidget);
          expect((tester.widget(subscriptionsIconFinder1) as Icon).icon,
              Icons.subscriptions);
        },
      );

      testWidgets(
        "make initial index working properly",
        (tester) async {
          await tester.pumpWidget(
            materialApp(
              Scaffold(
                body: Center(
                  child: CustomTabBar(
                    key: const Key("customTabBarKey"),
                    initialIndex: 1,
                    onChanged: (i) {},
                  ),
                ),
              ),
            ),
          );

          await tester.pump();
          expect(find.byKey(const Key("customTabBarKey")), findsOneWidget);

          final animatedAlignFinder =
              find.byKey(const Key("customTabBarAnimatedAlignKey"));
          expect(animatedAlignFinder, findsOneWidget);
          expect(
              (tester.widget(animatedAlignFinder) as AnimatedAlign).alignment,
              Alignment.centerRight);

          final dashboardIconFinder = find.byKey(const Key("dashboardIconKey"));
          expect(dashboardIconFinder, findsOneWidget);
          expect((tester.widget(dashboardIconFinder) as Icon).icon,
              Icons.dashboard_customize_outlined);

          final subscriptionsIconFinder =
              find.byKey(const Key("subscriptionsIconKey"));
          expect(subscriptionsIconFinder, findsOneWidget);
          expect((tester.widget(subscriptionsIconFinder) as Icon).icon,
              Icons.subscriptions);

          expect(find.byKey(const Key("generalTextKey")), findsNothing);
          expect(find.byKey(const Key("mySubsTextKey")), findsOneWidget);
        },
      );
    },
  );
}
