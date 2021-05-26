import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smart_porta/dependency_injector.dart' as dp;
import 'package:smart_porta/screens/device_screen.dart';
import 'package:smart_porta/screens/home.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  dp.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart porta',
      themeMode: ThemeMode.dark,
      initialRoute: MyHomePage.id,
      routes: {
        MyHomePage.id: (context) => MyHomePage(),
        DeviceScreen.id: (context) => DeviceScreen(),
      },
    );
  }
}
