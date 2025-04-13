import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:subsciption_manager/modules/subscription/data/models/subscription_group_model.dart';
import 'package:subsciption_manager/modules/subscription/presentation/widgets/add_category_bottom_sheet.dart';

import '../../../../material_app_widget.dart';

void main() {
  group(
    "add category bottom sheet tests",
    () {
      testWidgets(
        'AddCategoryBottomSheet - form input and save',
        (WidgetTester tester) async {
          SubscriptionGroupModel? savedModel;

          await tester.pumpWidget(
            materialApp(
              Scaffold(
                body: Builder(
                  builder: (context) {
                    return Center(
                      child: ElevatedButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (_) => AddCategoryBottomSheet(
                              onSaved: (model) => savedModel = model,
                            ),
                          );
                        },
                        child: const Text('Open BottomSheet'),
                      ),
                    );
                  },
                ),
              ),
            ),
          );

          await tester.tap(find.text('Open BottomSheet'));
          await tester.pumpAndSettle();

          const testName = 'Entertainment';
          final nameField = find.byKey(const Key('categoryNameFieldKey'));
          await tester.enterText(nameField, testName);
          await tester.pump();

          // Tap the first checkbox
          final checkboxFinder =
              find.byKey(const Key('subscriptionCheckBoxKey0'));
          await tester.tap(checkboxFinder);
          await tester.pump();

          // Tap the save button
          final saveButton = find.byKey(const Key('saveButtonKey'));
          await tester.tap(saveButton);
          await tester.pumpAndSettle();

          expect(savedModel, isNotNull);
          expect(savedModel!.name, testName);
          expect(savedModel!.subscriptions.isNotEmpty, true);
        },
      );
    },
  );
}
