import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'presentation/components/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(App(prefs: prefs));
}
