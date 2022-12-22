import 'package:alexandr_test_app/app/app.dart';
import 'package:alexandr_test_app/app/app_injector.dart' as di;
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.initialAppDependencyInjector();
  runApp(const App());
}
