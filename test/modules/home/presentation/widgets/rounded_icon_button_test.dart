import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:subsciption_manager/modules/home/presentation/widgets/rounded_icon_button.dart';

import '../../../../material_app_widget.dart';

void main() {
  group(
    "rounded icon button test",
    () {
      testWidgets('RoundedIconButton renders icon and triggers onTap',
          (WidgetTester tester) async {
        bool tapped = false;

        await tester.pumpWidget(
          materialApp(
            Scaffold(
              body: RoundedIconButton(
                icon: Icons.notifications_none_outlined,
                onTap: () {
                  tapped = true;
                },
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.notifications_none_outlined), findsOneWidget);

        await tester.tap(find.byType(RoundedIconButton));
        await tester.pumpAndSettle();

        // Check if onTap callback is triggered
        expect(tapped, isTrue);
      });
    },
  );
}
