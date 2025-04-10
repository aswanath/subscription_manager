import 'package:flutter/material.dart';
import 'package:subsciption_manager/config/constants/colors.dart';
import 'package:subsciption_manager/modules/get_started/presentation/screens/get_started_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
      home: const GetStartedScreen(),
    );
  }
}
