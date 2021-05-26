import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:smart_porta/features/core/failures/failure.dart';
import 'package:smart_porta/features/core/params/no_params.dart';
import 'package:smart_porta/features/google_sign_in/domain/entities/google_sign_in.dart';
import 'package:smart_porta/features/google_sign_in/domain/use_cases/sign_in_with_google_usecase.dart';

part 'sign_in_with_google_event.dart';
part 'sign_in_with_google_state.dart';

class SignInWithGoogleBloc
    extends Bloc<SignInWithGoogleEvent, SignInWithGoogleState> {
  final SignInWithGoogleUseCase signIn;

  SignInWithGoogleBloc({
    required this.signIn,
  }) : super(SignInWithGoogleInitial());

  @override
  Stream<SignInWithGoogleState> mapEventToState(
    SignInWithGoogleEvent event,
  ) async* {
    if (event is SignIn) {
      yield SignInWithGoogleLoading();
      final result = await signIn(NoParams());
      yield* _eitherLoadedOrError(result);
    }
  }

  Stream<SignInWithGoogleState> _eitherLoadedOrError(
      Result<Failure, SignInWithGoogle> result) async* {
    yield result.when(
      (Failure failure) => SignInWithGoogleError(failure: failure),
      (success) => SignInWithGoogleLoaded(),
    );
  }
}
