import 'package:multiple_result/multiple_result.dart';
import 'package:smart_porta/features/core/failures/failure.dart';
import 'package:smart_porta/features/google_sign_in/domain/entities/google_sign_in.dart';

abstract class SignInWithGoogleRepository {
  Future<Result<Failure, SignInWithGoogle>> signIn();
}