import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:subsciption_manager/data/models/subscription_type_model.dart';

void main() {
  group(
    "subscription type model tests",
    () {
      const modelA = SubscriptionTypeModel(
        name: "Figma",
        imagePath: "assets/figma.png",
        glowColor: Color(0XFFFF4D12),
        amount: 12.00,
        isMonthly: true,
      );

      const modelB = SubscriptionTypeModel(
        name: "Figma",
        imagePath: "assets/figma.png",
        glowColor: Color(0XFFFF4D12),
        amount: 12.00,
        isMonthly: true,
      );

      const modelDifferent = SubscriptionTypeModel(
        name: "Spotify",
        imagePath: "assets/spotify.png",
        glowColor: Color(0XFF10C64B),
        amount: 8.00,
        isMonthly: true,
      );

      test(
        'should support value equality',
        () {
          expect(modelA, equals(modelB));
        },
      );

      test(
        'should not be equal to a different model',
        () {
          expect(modelA == modelDifferent, false);
        },
      );

      test(
        'props list should contain all fields',
        () {
          expect(
            modelA.props,
            [
              'Figma',
              'assets/figma.png',
              const Color(0XFFFF4D12),
              12.0,
              true,
            ],
          );
        },
      );
    },
  );
}
