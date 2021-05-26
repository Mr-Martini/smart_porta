import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_porta/dependency_injector.dart';
import 'package:smart_porta/features/core/failures/failure.dart';
import 'package:smart_porta/features/google_sign_in/presentation/bloc/sign_in_with_google_bloc.dart';
import 'package:smart_porta/screens/dashboard.dart';

class SignInWithGoogleButton extends StatelessWidget {
  const SignInWithGoogleButton({Key? key}) : super(key: key);

  void generateSnackBar(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(title),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
          label: 'Ok',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInWithGoogleBloc>(
      create: (context) => sl.get<SignInWithGoogleBloc>(),
      child: Builder(
        builder: (context) =>
            BlocListener<SignInWithGoogleBloc, SignInWithGoogleState>(
          listener: (context, state) {
            if (state is SignInWithGoogleLoaded) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                DashboardScreen.id,
                (route) => false,
              );
            }

            if (state is SignInWithGoogleError) {
              final Failure failure = state.failure;

              if (failure is NetworkFailure) {
                generateSnackBar(context, "network failure");
              } else if (failure is UnknownFailure) {
                generateSnackBar(context, "unknown failure");
              }
            }
          },
          child: BlocBuilder<SignInWithGoogleBloc, SignInWithGoogleState>(
            builder: (context, state) {
              if (state is SignInWithGoogleLoading) {
                return ElevatedButton(
                  onPressed: null,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircularProgressIndicator(),
                      ],
                    ),
                  ),
                );
              }

              return ElevatedButton(
                onPressed: () => BlocProvider.of<SignInWithGoogleBloc>(context)
                    .add(SignIn()),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FaIcon(FontAwesomeIcons.google),
                      Text("SIGN IN WITH GOOGLE"),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
