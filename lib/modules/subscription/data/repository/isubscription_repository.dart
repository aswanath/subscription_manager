import 'package:subsciption_manager/modules/subscription/data/models/subscription_group_model.dart';

abstract class ISubscriptionRepository {
  Future<List<SubscriptionGroupModel>> getSubscriptionGroups();

  Future<bool> addSubGroup(SubscriptionGroupModel model);
}
