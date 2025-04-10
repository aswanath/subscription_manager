import 'package:hive/hive.dart';
import 'package:subsciption_manager/modules/subscription/data/models/subscription_group_model.dart';

void registerAdaptors() {
  Hive.registerAdapter(SubscriptionGroupModelAdapter());
}
