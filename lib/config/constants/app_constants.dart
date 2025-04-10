import 'dart:ui';

import 'package:subsciption_manager/config/constants/assets.dart';
import 'package:subsciption_manager/data/models/subscription_type_model.dart';

class AppConstants {
  static const Map<String, SubscriptionTypeModel> subscriptions = {
    "Figma": SubscriptionTypeModel(
      name: "Figma",
      imagePath: ImageAssets.figma,
      glowColor: Color(0XFFFF4D12),
      amount: 12.00,
      isMonthly: true,
    ),
    "Amazon": SubscriptionTypeModel(
      name: "Amazon",
      imagePath: ImageAssets.amazon,
      glowColor: Color(0XFFEA7B0B),
      amount: 10.00,
      isMonthly: true,
    ),
    "Spotify": SubscriptionTypeModel(
      name: "Spotify",
      imagePath: ImageAssets.spotify,
      glowColor: Color(0XFF10C64B),
      amount: 8.00,
      isMonthly: true,
    ),
    "Youtube": SubscriptionTypeModel(
      name: "Youtube",
      imagePath: ImageAssets.youtube,
      glowColor: Color(0XFFFF0001),
      amount: 8.97,
      isMonthly: true,
    ),
    "Dribble": SubscriptionTypeModel(
      name: "Dribble",
      imagePath: ImageAssets.dribble,
      glowColor: Color(0XFFFA4695),
      amount: 9.00,
      isMonthly: true,
    ),
    "Apple": SubscriptionTypeModel(
      name: "Apple",
      imagePath: ImageAssets.apple,
      glowColor: Color(0XFF000000),
      amount: 199.00,
      isMonthly: false,
    ),
    "Playstation Plus": SubscriptionTypeModel(
      name: "Playstation Plus",
      imagePath: ImageAssets.playstation,
      glowColor: Color(0XFFFDD100),
      amount: 67.57,
      isMonthly: false,
    ),
    "HBO Max": SubscriptionTypeModel(
      name: "HBO Max",
      imagePath: ImageAssets.hbo,
      glowColor: Color(0XFF454647),
      amount: 9.99,
      isMonthly: true,
    ),
  };

  static const String kAllSubs = "All Subs";
}
