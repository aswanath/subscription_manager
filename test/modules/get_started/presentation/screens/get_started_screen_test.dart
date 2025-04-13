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
import 'package:subsciption_manager/modules/get_started/presentation/screens/get_started_screen.dart';
import 'package:subsciption_manager/modules/subscription/data/models/subscription_group_model.dart';

import '../../../../material_app_widget.dart';
import 'get_started_screen_test.mocks.dart';

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
              const GetStartedScreen(
                key: Key("getStartedScreenKey"),
              ),
            ),
          );

          //initial values
          final elevatedButtonAnimatedOpacityFinder =
              find.byKey(const Key("getStartedAnimatedOpacityKey"));
          expect(elevatedButtonAnimatedOpacityFinder, findsOneWidget);
          expect(
              (tester.widget(elevatedButtonAnimatedOpacityFinder)
                      as AnimatedOpacity)
                  .opacity,
              0.0);

          final descriptionAnimatedOpacityFinder =
              find.byKey(const Key("descriptionAnimatedOpacityKey"));
          expect(descriptionAnimatedOpacityFinder, findsOneWidget);
          expect(
              (tester.widget(descriptionAnimatedOpacityFinder)
                      as AnimatedOpacity)
                  .opacity,
              0.0);
          final titleAnimatedOpacityFinder =
              find.byKey(const Key("titleAnimatedOpacityKey"));
          expect(titleAnimatedOpacityFinder, findsOneWidget);
          expect(
              (tester.widget(titleAnimatedOpacityFinder) as AnimatedOpacity)
                  .opacity,
              0.0);

          await tester.pumpAndSettle();
          //after pumping final values
          expect(find.byKey(const Key("getStartedScreenKey")), findsOneWidget);

          final elevatedButtonAnimatedOpacityFinder1 =
              find.byKey(const Key("getStartedAnimatedOpacityKey"));
          expect(elevatedButtonAnimatedOpacityFinder1, findsOneWidget);
          expect(
              (tester.widget(elevatedButtonAnimatedOpacityFinder1)
                      as AnimatedOpacity)
                  .opacity,
              1.0);

          final descriptionAnimatedOpacityFinder1 =
              find.byKey(const Key("descriptionAnimatedOpacityKey"));
          expect(descriptionAnimatedOpacityFinder1, findsOneWidget);
          expect(
              (tester.widget(descriptionAnimatedOpacityFinder1)
                      as AnimatedOpacity)
                  .opacity,
              1.0);

          final titleAnimatedOpacityFinder1 =
              find.byKey(const Key("titleAnimatedOpacityKey"));
          expect(titleAnimatedOpacityFinder1, findsOneWidget);
          expect(
              (tester.widget(titleAnimatedOpacityFinder1) as AnimatedOpacity)
                  .opacity,
              1.0);

          await tester.pumpAndSettle();

          await tester.tap(find.byKey(const Key("getStartedButtonKey")));
          await tester.pumpAndSettle();
          expect(find.byKey(const Key("homeScreenKey")), findsOneWidget);
        },
      );
    },
  );
}
