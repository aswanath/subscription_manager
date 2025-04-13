import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_test/hive_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:subsciption_manager/config/constants/app_constants.dart';
import 'package:subsciption_manager/core/dependency_injection/injection_container.dart';
import 'package:subsciption_manager/core/hive_adaptors/register_hive_adaptors.dart';
import 'package:subsciption_manager/modules/subscription/data/models/subscription_group_model.dart';
import 'package:subsciption_manager/modules/subscription/data/repository/isubscription_repository.dart';
import 'package:subsciption_manager/modules/subscription/presentation/bloc/subscription_bloc.dart';

import 'subscription_bloc_test.mocks.dart';

@GenerateMocks([ISubscriptionRepository])
void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await setUpTestHive();
  registerAdaptors();
  await configureDependencies();
  final ISubscriptionRepository subscriptionRepository =
      MockISubscriptionRepository();
  await getIt.unregister<ISubscriptionRepository>();
  getIt.registerSingleton<ISubscriptionRepository>(subscriptionRepository);
  final List<SubscriptionGroupModel> subs = [
    SubscriptionGroupModel(
      AppConstants.kAllSubs,
      AppConstants.subscriptions.keys.toList(),
    ),
  ];

  group(
    "FetchSubscriptionGroups tests",
    () {
      blocTest(
        "FetchSubscriptionGroups  - success",
        build: () => getIt<SubscriptionBloc>(),
        act: (bloc) {
          when(subscriptionRepository.getSubscriptionGroups()).thenAnswer(
            (_) async => subs,
          );
          bloc.add(
            FetchSubscriptionGroups(
              groupName: AppConstants.kAllSubs,
            ),
          );
        },
        expect: () => [
          FetchedSubscriptionGroups(
            subscriptions: subs,
            groupName: AppConstants.kAllSubs,
          ),
        ],
      );
    },
  );

  group(
    "AddSubscriptionGroup tests",
    () {
      blocTest(
        "AddSubscriptionGroup  - success",
        build: () => getIt<SubscriptionBloc>(),
        act: (bloc) {
          final newSubModel = SubscriptionGroupModel(
            "Entertainment",
            [
              "Figma",
              "Dribble",
            ],
          );
          when(
            subscriptionRepository.addSubGroup(
              newSubModel,
            ),
          ).thenAnswer((_) => Future.value(true));
          subs.add(newSubModel);
          when(subscriptionRepository.getSubscriptionGroups()).thenAnswer(
            (_) async => subs,
          );
          bloc.add(
            AddSubscriptionGroup(
              subscriptionGroupModel: newSubModel,
            ),
          );
        },
        expect: () => [
          FetchedSubscriptionGroups(
            subscriptions: subs,
            groupName: "Entertainment",
          ),
        ],
      );

      blocTest(
        "AddSubscriptionGroup  - failure",
        build: () => getIt<SubscriptionBloc>(),
        act: (bloc) {
          final newSubModel = SubscriptionGroupModel(
            "Entertainment",
            [
              "Figma",
              "Dribble",
            ],
          );
          when(
            subscriptionRepository.addSubGroup(
              newSubModel,
            ),
          ).thenAnswer((_) => Future.value(false));
          bloc.add(
            AddSubscriptionGroup(
              subscriptionGroupModel: newSubModel,
            ),
          );
        },
        expect: () => [
          isA<SubscriptionError>(),
        ],
      );
    },
  );
}
