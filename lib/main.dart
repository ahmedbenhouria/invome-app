import 'package:Invome/presentation/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl_standalone.dart'
    if (dart.library.html) 'package:intl/intl_browser.dart';

import 'core/configs/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await findSystemLocale();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Invome',
      theme: AppTheme.lightTheme,
      home: AppScaffold(),
    );
  }
}
