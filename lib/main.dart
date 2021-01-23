import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smart_porta/screens/device_screen.dart';
import 'package:smart_porta/screens/home.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart porta',
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.red,
        buttonColor: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: Typography.blackRedmond,
      ),
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.red,
        buttonColor: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: Typography.blackRedmond,
      ),
      initialRoute: MyHomePage.id,
      routes: {
        MyHomePage.id: (context) => MyHomePage(),
        DeviceScreen.id: (context) => DeviceScreen(),
      },
    );
  }
}
