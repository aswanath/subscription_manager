import 'package:hive_flutter/hive_flutter.dart';
import 'package:subsciption_manager/config/constants/app_constants.dart';
import 'package:subsciption_manager/data/models/subscription_type_model.dart';

part 'subscription_group_model.g.dart';

@HiveType(typeId: 0)
class SubscriptionGroupModel extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final List<String> subscriptions;

  SubscriptionGroupModel(
    this.name,
    this.subscriptions,
  );

  List<SubscriptionTypeModel> get subscriptionModels =>
      subscriptions.map((e) => AppConstants.subscriptions[e]!).toList();
}
