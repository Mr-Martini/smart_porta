part of 'sign_in_with_google_bloc.dart';

abstract class SignInWithGoogleEvent extends Equatable {
  const SignInWithGoogleEvent();
}

class SignIn extends SignInWithGoogleEvent {
  @override
  List<Object?> get props => [];
}
