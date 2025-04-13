import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subsciption_manager/config/constants/app_constants.dart';
import 'package:subsciption_manager/core/dependency_injection/injection_container.dart';
import 'package:subsciption_manager/modules/subscription/presentation/bloc/subscription_bloc.dart';
import 'package:subsciption_manager/modules/subscription/presentation/widgets/add_category_bottom_sheet.dart';
import 'package:subsciption_manager/modules/subscription/presentation/widgets/animated_stacked_list.dart';
import 'package:subsciption_manager/modules/subscription/presentation/widgets/animated_tab_bar.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  late final SubscriptionBloc _subscriptionBloc;

  @override
  void initState() {
    super.initState();
    _subscriptionBloc = getIt<SubscriptionBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SubscriptionBloc>(
      create: (context) => _subscriptionBloc
        ..add(
          FetchSubscriptionGroups(
            groupName: AppConstants.kAllSubs,
          ),
        ),
      child: BlocBuilder<SubscriptionBloc, SubscriptionState>(
        buildWhen: (prev, curr) => curr is FetchedSubscriptionGroups,
        builder: (context, state) {
          if (state is! FetchedSubscriptionGroups) return const SizedBox();
          return Column(
            children: [
              const SizedBox(
                height: 32.0,
              ),
              AnimatedTabList(
                key: const Key("animatedTabListKey"),
                initialIndex: state.subscriptions
                    .indexWhere((e) => e.name == state.groupName),
                onChanged: (int index) {
                  _subscriptionBloc.add(
                    FetchSubscriptionGroups(
                      groupName: state.subscriptions[index].name,
                    ),
                  );
                },
                onAddCategoryTapped: () async {
                  await showCupertinoModalPopup(
                    context: context,
                    builder: (context) => AddCategoryBottomSheet(
                      onSaved: (val) {
                        _subscriptionBloc.add(
                          AddSubscriptionGroup(
                            subscriptionGroupModel: val,
                          ),
                        );
                      },
                    ),
                  );
                },
                tabs: state.subscriptions,
              ),
              const SizedBox(
                height: 25.0,
              ),
              Expanded(
                child: AnimatedStackedList(
                  key: const Key("animatedStackedListKey"),
                  subscriptions: state.subscriptions
                      .firstWhere((e) => e.name == state.groupName)
                      .subscriptionModels,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
