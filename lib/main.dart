import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:subsciption_manager/app.dart';
import 'package:subsciption_manager/core/dependency_injection/injection_container.dart';
import 'package:subsciption_manager/core/hive_adaptors/register_hive_adaptors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  registerAdaptors();
  await configureDependencies();

  runApp(
    const MyApp(),
  );
}
