import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/firebase_options.dart';

import 'app.dart';
import 'models/env.dart';
import 'setup.dart';

void main() async {
  // Splash screen
  WidgetsFlutterBinding.ensureInitialized();
  await Env.load();
  await Setup.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // end of the splash screen
  runApp(const AppMainWidget());
}
