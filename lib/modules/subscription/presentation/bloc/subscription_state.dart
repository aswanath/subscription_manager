part of 'subscription_bloc.dart';

@immutable
abstract class SubscriptionState {}

class SubscriptionInitial extends SubscriptionState {}

class SubscriptionError extends SubscriptionState {}

class FetchedSubscriptionGroups extends SubscriptionState {
  final List<SubscriptionGroupModel> subscriptions;
  final String groupName;

  FetchedSubscriptionGroups({
    required this.subscriptions,
    required this.groupName,
  });
}
