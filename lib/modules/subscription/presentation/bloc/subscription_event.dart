part of 'subscription_bloc.dart';

@immutable
abstract class SubscriptionEvent {}

class FetchSubscriptionGroups extends SubscriptionEvent {
  final String groupName;

  FetchSubscriptionGroups({required this.groupName});
}

class AddSubscriptionGroup extends SubscriptionEvent {
  final SubscriptionGroupModel subscriptionGroupModel;

  AddSubscriptionGroup({
    required this.subscriptionGroupModel,
  });
}
