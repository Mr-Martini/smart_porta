import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_porta/dependency_injector.dart' show sl;
import 'package:smart_porta/screens/dashboard.dart';
import 'package:smart_porta/screens/home.dart';

class Guard extends StatelessWidget {
  const Guard({Key? key}) : super(key: key);

  Future<User?> get getUser async {
    final auth = sl.get<FirebaseAuth>();

    final User? user = auth.currentUser;

    return user;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUser,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final User? user = snapshot.data;

          if (user == null) {
            return WelcomeScreen();
          }
          return DashboardScreen();
        }

        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
