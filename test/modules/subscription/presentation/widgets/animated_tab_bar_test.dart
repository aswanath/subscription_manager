import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:subsciption_manager/modules/subscription/data/models/subscription_group_model.dart';
import 'package:subsciption_manager/modules/subscription/presentation/widgets/animated_tab_bar.dart';

import '../../../../material_app_widget.dart';

void main() {
  group('animated tab bar tests', () {
    late List<SubscriptionGroupModel> testTabs;

    setUp(() {
      testTabs = [
        SubscriptionGroupModel('Spotify', []),
        SubscriptionGroupModel('Dribble', []),
      ];
    });

    testWidgets('renders all tabs with + button', (tester) async {
      await tester.pumpWidget(
        materialApp(
          AnimatedTabList(
            tabs: testTabs,
            initialIndex: 0,
            onAddCategoryTapped: () {},
            onChanged: (_) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Spotify'), findsOneWidget);
      expect(find.text('Dribble'), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('initial index highlights selected tab', (tester) async {
      await tester.pumpWidget(
        materialApp(
          AnimatedTabList(
            tabs: testTabs,
            initialIndex: 1,
            onAddCategoryTapped: () {},
            onChanged: (_) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      final selected = tester
          .widgetList<AnimatedContainer>(find.byType(AnimatedContainer))
          .toList();
      expect(
        (selected[1].decoration as BoxDecoration).color,
        isNot(equals((selected[0].decoration as BoxDecoration).color)),
      );
    });

    testWidgets('taps on + icon triggers onAddCategoryTapped', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        materialApp(
          AnimatedTabList(
            tabs: testTabs,
            initialIndex: 0,
            onAddCategoryTapped: () => tapped = true,
            onChanged: (_) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.add));
      expect(tapped, true);
    });

    testWidgets('tapping tab updates selection and triggers onChanged',
        (tester) async {
      int? selectedIndex;

      await tester.pumpWidget(
        materialApp(
          AnimatedTabList(
            tabs: testTabs,
            initialIndex: 0,
            onAddCategoryTapped: () {},
            onChanged: (index) => selectedIndex = index,
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Dribble'));
      await tester.pump();

      expect(selectedIndex, 1);
    });

    testWidgets('animation offsets are initialized correctly', (tester) async {
      await tester.pumpWidget(
        materialApp(
          AnimatedTabList(
            tabs: testTabs,
            initialIndex: 0,
            onAddCategoryTapped: () {},
            onChanged: (_) {},
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(AnimatedSlide), findsNWidgets(3));
    });
  });

  group('TabChip tests', () {
    testWidgets('displays label text when not "+"', (tester) async {
      await tester.pumpWidget(
        materialApp(
          TabChip(
            label: 'TestTab',
            isSelected: false,
            onTap: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('TestTab'), findsOneWidget);
      expect(find.byIcon(Icons.add), findsNothing);
    });

    testWidgets('displays "+" icon when label is "+"', (tester) async {
      await tester.pumpWidget(
        materialApp(
          TabChip(
            label: '+',
            isSelected: false,
            onTap: () {},
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.text('+'), findsNothing);
    });

    testWidgets('tap triggers onTap', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        materialApp(
          TabChip(
            label: 'ClickMe',
            isSelected: false,
            onTap: () => tapped = true,
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('ClickMe'));
      expect(tapped, true);
    });
  });
}
