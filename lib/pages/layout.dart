import 'package:flutter/material.dart';

class LayoutPage extends StatelessWidget {
  final Widget child;
  const LayoutPage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: child);
  }
}
