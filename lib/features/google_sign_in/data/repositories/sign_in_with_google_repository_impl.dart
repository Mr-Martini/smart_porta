import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:smart_porta/features/core/exceptions/exceptions.dart';
import 'package:smart_porta/features/core/failures/failure.dart';
import 'package:smart_porta/features/google_sign_in/data/data_sources/sign_in_with_google_remote_datasource.dart';
import 'package:smart_porta/features/google_sign_in/domain/entities/google_sign_in.dart';
import 'package:smart_porta/features/google_sign_in/domain/repositories/sign_in_with_google_repository.dart';

class SignInWithGoogleRepositoryImpl implements SignInWithGoogleRepository {
  final SignInWithGoogleRemoteDataSource dataSource;

  SignInWithGoogleRepositoryImpl({required this.dataSource});

  @override
  Future<Result<Failure, SignInWithGoogle>> signIn() async {
    try {
      final result = await dataSource.signIn();
      return Success(result);
    } on PlatformException catch (err) {
      final String code = err.code;

      switch (code) {
        case GoogleSignIn.kNetworkError:
          return Error(NetworkFailure());
        case GoogleSignIn.kSignInCanceledError:
          return Error(GoogleSignInCanceledFailure());
        case GoogleSignIn.kSignInFailedError:
        default:
          print(err);
          return Error(UnknownFailure());
      }
    } on SignInCanceledException {
      return Error(GoogleSignInCanceledFailure());
    } catch (err) {
      print(err);
      return Error(UnknownFailure());
    }
  }
}
