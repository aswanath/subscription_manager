import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:subsciption_manager/config/constants/hive_box_names.dart';
import 'package:subsciption_manager/modules/subscription/data/models/subscription_group_model.dart';
import 'package:subsciption_manager/modules/subscription/data/repository/isubscription_repository.dart';

@Injectable(as: ISubscriptionRepository)
class SubscriptionRepository implements ISubscriptionRepository {
  final Box<SubscriptionGroupModel> _subsBox;

  SubscriptionRepository(
    @Named(HiveBoxNames.subsGroup) this._subsBox,
  );

  @override
  Future<List<SubscriptionGroupModel>> getSubscriptionGroups() async {
    try {
      return _subsBox.values.toList();
    } catch (e) {
      debugPrint(e.toString());
      return const [];
    }
  }

  @override
  Future<bool> addSubGroup(SubscriptionGroupModel model) async {
    try {
      await _subsBox.add(model);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
