part of 'subscription_bloc.dart';

@immutable
abstract class SubscriptionState {}

class SubscriptionInitial extends SubscriptionState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class SubscriptionError extends SubscriptionState {}

class FetchedSubscriptionGroups extends SubscriptionState with EquatableMixin {
  final List<SubscriptionGroupModel> subscriptions;
  final String groupName;

  FetchedSubscriptionGroups({
    required this.subscriptions,
    required this.groupName,
  });

  @override
  List<Object?> get props => [
        subscriptions,
        groupName,
      ];
}
