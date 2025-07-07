import 'package:flutter/material.dart';

import 'app.dart';
import 'models/env.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.load();
  runApp(const MyApp());
}
