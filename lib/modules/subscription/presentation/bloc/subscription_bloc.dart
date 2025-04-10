import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:subsciption_manager/modules/subscription/data/models/subscription_group_model.dart';
import 'package:subsciption_manager/modules/subscription/data/repository/isubscription_repository.dart';

part 'subscription_event.dart';
part 'subscription_state.dart';

@injectable
class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final ISubscriptionRepository _subscriptionRepository;

  SubscriptionBloc(this._subscriptionRepository)
      : super(SubscriptionInitial()) {
    on<FetchSubscriptionGroups>(_onFetchSubscriptionGroups);
    on<AddSubscriptionGroup>(_onAddSubscriptionGroup);
  }

  static List<SubscriptionGroupModel> _subscriptions = [];

  static List<SubscriptionGroupModel> get subscriptions => _subscriptions;

  FutureOr<void> _onFetchSubscriptionGroups(
      FetchSubscriptionGroups event, emit) async {
    final subscriptions = await _subscriptionRepository.getSubscriptionGroups();
    _subscriptions = subscriptions;
    emit(
      FetchedSubscriptionGroups(
        subscriptions: _subscriptions,
        groupName: event.groupName,
      ),
    );
  }

  FutureOr<void> _onAddSubscriptionGroup(
      AddSubscriptionGroup event, emit) async {
    final result =
        await _subscriptionRepository.addSubGroup(event.subscriptionGroupModel);
    if (result) {
      add(
        FetchSubscriptionGroups(
          groupName: event.subscriptionGroupModel.name,
        ),
      );
    } else {
      emit(
        SubscriptionError(),
      );
    }
  }
}
