import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smart_porta/features/google_sign_in/data/data_sources/sign_in_with_google_remote_datasource.dart';
import 'package:smart_porta/features/google_sign_in/data/repositories/sign_in_with_google_repository_impl.dart';
import 'package:smart_porta/features/google_sign_in/domain/repositories/sign_in_with_google_repository.dart';
import 'package:smart_porta/features/google_sign_in/domain/use_cases/sign_in_with_google_usecase.dart';
import 'package:smart_porta/features/google_sign_in/presentation/bloc/sign_in_with_google_bloc.dart';

final sl = GetIt.instance;

void init() {
  registerFirebaseAuth();
  registerCloudFirestore();
  registerGoogleSignInClient();
  registerGoogleSignIn();
}

void registerFirebaseAuth() {
  sl.registerSingleton(FirebaseAuth.instance);
}

void registerCloudFirestore() {
  sl.registerSingleton(FirebaseFirestore.instance);
}

void registerGoogleSignInClient() {
  sl.registerSingleton(GoogleSignIn());
}

void registerGoogleSignIn() {
  sl.registerFactory(
    () => SignInWithGoogleBloc(
      signIn: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => SignInWithGoogleUseCase(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton<SignInWithGoogleRepository>(
    () => SignInWithGoogleRepositoryImpl(
      dataSource: sl(),
    ),
  );

  sl.registerLazySingleton<SignInWithGoogleRemoteDataSource>(
    () => SignInWithGoogleRemoteDataSourceImpl(
      googleSignIn: sl.get<GoogleSignIn>(),
      auth: sl.get<FirebaseAuth>(),
    ),
  );
}
