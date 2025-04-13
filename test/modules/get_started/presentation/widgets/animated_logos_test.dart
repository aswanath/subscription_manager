import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:subsciption_manager/config/constants/app_constants.dart';
import 'package:subsciption_manager/modules/get_started/presentation/widgets/animated_logos.dart';

import '../../../../material_app_widget.dart';

void main() {
  group(
    "Animated logos test",
    () {
      testWidgets(
        "logos should present and change it's positions after 2 seconds",
        (tester) async {
          await tester.pumpWidget(
            materialApp(
              const AnimatedLogos(
                key: Key("animatedLogosKey"),
              ),
            ),
          );

          await tester.pump(const Duration(seconds: 1));
          expect(find.byKey(const Key("animatedLogosKey")), findsOneWidget);

          //checking initial bg glow color
          final logoBackgroundDecoratedBoxFinder =
              find.byKey(const Key("logoBackgroundDecoratedBoxKey"));
          expect(logoBackgroundDecoratedBoxFinder, findsOneWidget);
          final decoratedBox =
              tester.widget(logoBackgroundDecoratedBoxFinder) as DecoratedBox;
          expect(
            (decoratedBox.decoration as BoxDecoration).boxShadow,
            [
              BoxShadow(
                color: AppConstants.subscriptions.values.elementAt(4).glowColor,
                blurRadius: 100,
                spreadRadius: 50,
              ),
            ],
          );

          //checking initial logos
          final circleContainerFinder =
              find.byKey(const Key("circleContainerKey"));
          expect(circleContainerFinder, findsNWidgets(5));
          final logoImageKeyFinder = find.byKey(const Key("logoImageKey"));
          expect(logoImageKeyFinder, findsNWidgets(5));
          for (int i = 0; i < 5; i++) {
            expect(
                ((tester.widget(logoImageKeyFinder.at(i)) as Image).image
                        as AssetImage)
                    .assetName,
                AppConstants.subscriptions.values.elementAt(i).imagePath);
            expect(
              (tester.widget(circleContainerFinder.at(i)) as Container)
                  .constraints,
              BoxConstraints.expand(
                height: i == 4
                    ? 76.0
                    : i == 2 || i == 3
                        ? 68.0
                        : 60.0,
                width: i == 4
                    ? 76.0
                    : i == 2 || i == 3
                        ? 68.0
                        : 60.0,
              ),
            );
          }

          final BuildContext context =
              tester.element(find.byType(AnimatedLogos));
          final double width = MediaQuery.sizeOf(context).width;
          for (int i = 0; i < 5; i++) {
            final logoAnimatedPositionedFinder =
                find.byKey(Key("logoAnimatedPositionedKey$i"));
            expect(logoAnimatedPositionedFinder, findsOneWidget);
            expect(
                (tester.widget(logoAnimatedPositionedFinder)
                        as AnimatedPositioned)
                    .left,
                (width * 0.5) + xInitialPositions[i]);
          }

          //after one iteration
          await tester.pump(const Duration(seconds: 3));
          await tester.pumpAndSettle();

          final logoBackgroundDecoratedBoxFinder1 =
              find.byKey(const Key("logoBackgroundDecoratedBoxKey"));
          expect(logoBackgroundDecoratedBoxFinder1, findsOneWidget);
          final decoratedBox1 =
              tester.widget(logoBackgroundDecoratedBoxFinder1) as DecoratedBox;
          expect(
            (decoratedBox1.decoration as BoxDecoration).boxShadow,
            [
              BoxShadow(
                color: AppConstants.subscriptions.values.elementAt(3).glowColor,
                blurRadius: 100,
                spreadRadius: 50,
              ),
            ],
          );

          final circleContainerFinder1 =
              find.byKey(const Key("circleContainerKey"));
          expect(circleContainerFinder1, findsNWidgets(5));
          final logoImageKeyFinder1 = find.byKey(const Key("logoImageKey"));
          expect(logoImageKeyFinder1, findsNWidgets(5));
          for (int i = 0; i < 5; i++) {
            expect(
                ((tester.widget(logoImageKeyFinder1.at(i)) as Image).image
                        as AssetImage)
                    .assetName,
                AppConstants.subscriptions.values
                    .elementAt(logoSwapPositions[i])
                    .imagePath);
            expect(
              (tester.widget(circleContainerFinder1.at(i)) as Container)
                  .constraints,
              BoxConstraints.expand(
                height: i == 4
                    ? 76.0
                    : i == 2 || i == 3
                        ? 68.0
                        : 60.0,
                width: i == 4
                    ? 76.0
                    : i == 2 || i == 3
                        ? 68.0
                        : 60.0,
              ),
            );
          }

          for (int i = 0; i < 5; i++) {
            final logoAnimatedPositionedFinder =
                find.byKey(Key("logoAnimatedPositionedKey$i"));
            expect(logoAnimatedPositionedFinder, findsOneWidget);
            expect(
                (tester.widget(logoAnimatedPositionedFinder)
                        as AnimatedPositioned)
                    .left,
                (width * 0.5) + xInitialPositions[i]);
          }
        },
      );
    },
  );
}
