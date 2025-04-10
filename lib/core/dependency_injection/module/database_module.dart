import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:subsciption_manager/config/constants/app_constants.dart';
import 'package:subsciption_manager/config/constants/hive_box_names.dart';
import 'package:subsciption_manager/modules/subscription/data/models/subscription_group_model.dart';

@module
abstract class DatabaseModule {
  @preResolve
  @Named(HiveBoxNames.subsGroup)
  Future<Box<SubscriptionGroupModel>> get subsGroupBox async {
    final box =
        await Hive.openBox<SubscriptionGroupModel>(HiveBoxNames.subsGroup);
    if (box.isEmpty) {
      box.add(
        SubscriptionGroupModel(
          AppConstants.kAllSubs,
          AppConstants.subscriptions.keys.toList(),
        ),
      );
    }
    return box;
  }
}
