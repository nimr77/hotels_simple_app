import 'package:flutter/material.dart';

import 'app.dart';
import 'models/env.dart';
import 'setup.dart';

void main() async {
  // Splash screen
  WidgetsFlutterBinding.ensureInitialized();
  await Env.load();
  await Setup.init();

  // end of the splash screen
  runApp(const AppMainWidget());
}
