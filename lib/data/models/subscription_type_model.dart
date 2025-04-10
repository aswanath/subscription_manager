import 'dart:ui';

import 'package:equatable/equatable.dart';

class SubscriptionTypeModel extends Equatable {
  final String name;
  final String imagePath;
  final Color glowColor;
  final double amount;
  final bool isMonthly;

  const SubscriptionTypeModel({
    required this.name,
    required this.imagePath,
    required this.glowColor,
    required this.amount,
    required this.isMonthly,
  });

  @override
  List<Object?> get props => [
        name,
        imagePath,
        glowColor,
        amount,
        isMonthly,
      ];
}
