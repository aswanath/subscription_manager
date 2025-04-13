import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:subsciption_manager/modules/subscription/presentation/widgets/custom_check_box.dart';

import '../../../../material_app_widget.dart';

void main() {
  group('custom check box tests', () {
    testWidgets('initial state is unchecked', (WidgetTester tester) async {
      await tester.pumpWidget(
        materialApp(
          Scaffold(
            body: CustomCheckbox(
              onChanged: (value) {},
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container).first);
      final decoration = container.decoration as BoxDecoration;

      // Expect it to be black (unchecked)
      expect(decoration.color, Colors.black);
      expect(find.byIcon(Icons.check), findsNothing);
    });

    testWidgets('tapping toggles checkbox and calls onChanged',
        (WidgetTester tester) async {
      bool? isChecked;

      await tester.pumpWidget(
        materialApp(
          Scaffold(
            body: CustomCheckbox(
              onChanged: (value) => isChecked = value,
            ),
          ),
        ),
      );

      expect(isChecked, isNull);
      expect(find.byIcon(Icons.check), findsNothing);

      await tester.tap(find.byType(CustomCheckbox));
      await tester.pump();

      // Should now be checked
      expect(isChecked, isTrue);
      expect(find.byIcon(Icons.check), findsOneWidget);

      await tester.tap(find.byType(CustomCheckbox));
      await tester.pump();

      // Should now be unchecked
      expect(isChecked, isFalse);
      expect(find.byIcon(Icons.check), findsNothing);
    });

    testWidgets('changes visual state after each tap',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        materialApp(
          Scaffold(
            body: CustomCheckbox(
              onChanged: (_) {},
            ),
          ),
        ),
      );

      // Initially unchecked
      expect(find.byIcon(Icons.check), findsNothing);

      await tester.tap(find.byType(CustomCheckbox));
      await tester.pump();

      expect(find.byIcon(Icons.check), findsOneWidget);

      await tester.tap(find.byType(CustomCheckbox));
      await tester.pump();

      expect(find.byIcon(Icons.check), findsNothing);
    });
  });
}
