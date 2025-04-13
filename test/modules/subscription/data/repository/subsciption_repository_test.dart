import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test/hive_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:subsciption_manager/config/constants/app_constants.dart';
import 'package:subsciption_manager/config/constants/hive_box_names.dart';
import 'package:subsciption_manager/core/dependency_injection/injection_container.dart';
import 'package:subsciption_manager/core/hive_adaptors/register_hive_adaptors.dart';
import 'package:subsciption_manager/modules/subscription/data/models/subscription_group_model.dart';
import 'package:subsciption_manager/modules/subscription/data/repository/isubscription_repository.dart';

import 'subsciption_repository_test.mocks.dart';

@GenerateMocks([Box<SubscriptionGroupModel>])
void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await setUpTestHive();
  registerAdaptors();
  await configureDependencies();

  final List<SubscriptionGroupModel> subscriptionList = [
    SubscriptionGroupModel(
      AppConstants.kAllSubs,
      AppConstants.subscriptions.keys.toList(),
    ),
  ];

  await getIt.unregister<Box<SubscriptionGroupModel>>(
      instanceName: HiveBoxNames.subsGroup);
  final Box<SubscriptionGroupModel> subsGroupModel =
      MockBox<SubscriptionGroupModel>();
  getIt.registerSingleton(subsGroupModel, instanceName: HiveBoxNames.subsGroup);

  when(subsGroupModel.values).thenReturn(
    subscriptionList,
  );
  final ISubscriptionRepository subsRepo = getIt<ISubscriptionRepository>();

  tearDown(() async {
    await tearDownTestHive();
  });

  group(
    "subscription repository - getSubscriptionGroups",
    () {
      test(
        "getSubscriptionGroups - should return value list",
        () async {
          final List<SubscriptionGroupModel> result =
              await subsRepo.getSubscriptionGroups();
          expect(result.isNotEmpty, true);
        },
      );

      test(
        "getSubscriptionGroups - should return empty list",
        () async {
          when(subsGroupModel.values).thenThrow(Exception());
          final List<SubscriptionGroupModel> result =
              await subsRepo.getSubscriptionGroups();
          expect(result.isEmpty, true);
        },
      );
    },
  );

  group(
    "subscription repository - addSubGroup",
    () {
      test(
        "addSubGroup - should return true",
        () async {
          when(subsGroupModel.add(subscriptionList.first))
              .thenAnswer((_) async => 1);
          final bool result =
              await subsRepo.addSubGroup(subscriptionList.first);
          expect(result, true);
        },
      );

      test(
        "addSubGroup - should return false",
        () async {
          when(subsGroupModel.add(subscriptionList.first))
              .thenThrow(Exception());
          final bool result =
              await subsRepo.addSubGroup(subscriptionList.first);
          expect(result, false);
        },
      );
    },
  );
}
