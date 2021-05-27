import 'package:flutter/material.dart';
import 'package:smart_porta/features/google_sign_in/presentation/widgets/sign_in_with_google_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  static const String id = "/welcome";

  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;

    double width;

    if (screenWidth < 600) {
      width = 0.8 * screenWidth;
    } else if (screenWidth > 1200) {
      width = 0.3 * screenWidth;
    } else {
      width = (-(0.5 / 600) * screenWidth + 1.3) * screenWidth;
    }

    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Projeto Integrador",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SignInWithGoogleButton(),
            ],
          ),
        ),
      ),
    );
  }
}
