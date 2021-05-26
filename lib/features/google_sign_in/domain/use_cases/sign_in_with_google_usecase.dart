import 'package:multiple_result/multiple_result.dart';
import 'package:smart_porta/features/core/failures/failure.dart';
import 'package:smart_porta/features/core/params/no_params.dart';
import 'package:smart_porta/features/core/usecases/async_usecase.dart';
import 'package:smart_porta/features/google_sign_in/domain/entities/google_sign_in.dart';
import 'package:smart_porta/features/google_sign_in/domain/repositories/sign_in_with_google_repository.dart';

class SignInWithGoogleUseCase extends AsyncUseCase<SignInWithGoogle, NoParams> {

  final SignInWithGoogleRepository repository;

  SignInWithGoogleUseCase({required this.repository});

  @override
  Future<Result<Failure, SignInWithGoogle>> call(NoParams params) {
    return repository.signIn();
  }

}