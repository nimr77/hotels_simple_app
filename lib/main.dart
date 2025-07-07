import 'package:flutter/material.dart';

import 'app.dart';
import 'models/env.dart';
import 'setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.load();
  await Setup.init();
  runApp(const MyApp());
}
