import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test/hive_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:subsciption_manager/config/constants/app_constants.dart';
import 'package:subsciption_manager/config/constants/hive_box_names.dart';
import 'package:subsciption_manager/core/dependency_injection/injection_container.dart';
import 'package:subsciption_manager/core/hive_adaptors/register_hive_adaptors.dart';
import 'package:subsciption_manager/modules/home/presentation/screens/home_screen.dart';
import 'package:subsciption_manager/modules/subscription/data/models/subscription_group_model.dart';

import '../../../../material_app_widget.dart';
import 'home_screen_test.mocks.dart';

@GenerateMocks([Box<SubscriptionGroupModel>])
void main() async {
  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await setUpTestHive();
    registerAdaptors();
    await configureDependencies();

    await getIt.unregister<Box<SubscriptionGroupModel>>(
        instanceName: HiveBoxNames.subsGroup);
    final Box<SubscriptionGroupModel> subsGroupModel =
        MockBox<SubscriptionGroupModel>();
    getIt.registerSingleton(subsGroupModel,
        instanceName: HiveBoxNames.subsGroup);

    when(subsGroupModel.values).thenReturn(
      [
        SubscriptionGroupModel(
          AppConstants.kAllSubs,
          AppConstants.subscriptions.keys.toList(),
        ),
      ],
    );
  });

  tearDown(() async {
    await tearDownTestHive();
  });

  group(
    "Get started screen tests",
    () {
      testWidgets(
        "all the widgets should present and should navigate to home screen",
        (tester) async {
          await tester.pumpWidget(
            materialApp(
              const HomeScreen(
                key: Key("homeScreenKey"),
              ),
            ),
          );

          //initial values
          final menuAnimatedScaleFinder =
              find.byKey(const Key("menuAnimatedScaleKey"));
          expect(menuAnimatedScaleFinder, findsOneWidget);
          expect(
              (tester.widget(menuAnimatedScaleFinder) as AnimatedScale).scale,
              0.0);

          final customTabBarAnimatedScaleFinder =
              find.byKey(const Key("customTabBarAnimatedScaleKey"));
          expect(customTabBarAnimatedScaleFinder, findsOneWidget);
          expect(
              (tester.widget(customTabBarAnimatedScaleFinder) as AnimatedScale)
                  .scale,
              0.0);

          final notificationAnimatedScaleFinder =
              find.byKey(const Key("notificationAnimatedScaleKey"));
          expect(notificationAnimatedScaleFinder, findsOneWidget);
          expect(
              (tester.widget(notificationAnimatedScaleFinder) as AnimatedScale)
                  .scale,
              0.0);

          await tester.pumpAndSettle();
          expect(find.byKey(const Key("homeScreenKey")), findsOneWidget);

          final menuAnimatedScaleFinder1 =
              find.byKey(const Key("menuAnimatedScaleKey"));
          expect(menuAnimatedScaleFinder1, findsOneWidget);
          expect(
              (tester.widget(menuAnimatedScaleFinder1) as AnimatedScale).scale,
              1.0);

          final customTabBarAnimatedScaleFinder1 =
              find.byKey(const Key("customTabBarAnimatedScaleKey"));
          expect(customTabBarAnimatedScaleFinder1, findsOneWidget);
          expect(
              (tester.widget(customTabBarAnimatedScaleFinder1) as AnimatedScale)
                  .scale,
              1.0);

          final notificationAnimatedScaleFinder1 =
              find.byKey(const Key("notificationAnimatedScaleKey"));
          expect(notificationAnimatedScaleFinder1, findsOneWidget);
          expect(
              (tester.widget(notificationAnimatedScaleFinder1) as AnimatedScale)
                  .scale,
              1.0);

          //initial page is 1
          final pageViewFinder =
              find.byKey(const Key("homeScreenPageViewBuilderKey"));
          expect(pageViewFinder, findsOneWidget);
          expect((tester.widget(pageViewFinder) as PageView).controller?.page,
              1.0);

          //changing tab bar to general and back.
        },
      );
    },
  );
}
