import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'styles/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hotel App',
      theme: AppTheme.lightTheme,
      home: const HomePage(),
    );
  }
}
