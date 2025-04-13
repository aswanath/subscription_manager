import 'package:flutter/material.dart';
import 'package:subsciption_manager/config/constants/colors.dart';

Widget materialApp(Widget child) {
  return MaterialApp(
    theme: ThemeData(
      scaffoldBackgroundColor: AppColors.black,
    ),
    builder: (context, child) {
      if (child != null) {
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.noScaling),
          child: child,
        );
      }
      return const SizedBox.shrink();
    },
    home: child,
  );
}
