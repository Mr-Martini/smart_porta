part of 'sign_in_with_google_bloc.dart';

abstract class SignInWithGoogleState extends Equatable {
  const SignInWithGoogleState();
}

class SignInWithGoogleInitial extends SignInWithGoogleState {
  @override
  List<Object> get props => [];
}

class SignInWithGoogleLoading extends SignInWithGoogleState {
  @override
  List<Object?> get props => [];
}

class SignInWithGoogleLoaded extends SignInWithGoogleState {
  @override
  List<Object?> get props => [];
}

class SignInWithGoogleError extends SignInWithGoogleState {

  final Failure failure;

  SignInWithGoogleError({required this.failure});

  @override
  List<Object?> get props => [failure];
}
