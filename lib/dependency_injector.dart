import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smart_porta/features/device_state/data/data_sources/device_state_remote_datasource.dart';
import 'package:smart_porta/features/device_state/data/repositories/device_state_repository_impl.dart';
import 'package:smart_porta/features/device_state/domain/repositories/device_state_repository.dart';
import 'package:smart_porta/features/device_state/domain/use_cases/device_state_get_state.dart';
import 'package:smart_porta/features/device_state/presentation/bloc/device_state_bloc.dart';
import 'package:smart_porta/features/google_sign_in/data/data_sources/sign_in_with_google_remote_datasource.dart';
import 'package:smart_porta/features/google_sign_in/data/repositories/sign_in_with_google_repository_impl.dart';
import 'package:smart_porta/features/google_sign_in/domain/repositories/sign_in_with_google_repository.dart';
import 'package:smart_porta/features/google_sign_in/domain/use_cases/sign_in_with_google_usecase.dart';
import 'package:smart_porta/features/google_sign_in/presentation/bloc/sign_in_with_google_bloc.dart';
import 'package:smart_porta/features/scan_device/data/data_sources/scan_device_local_datasource.dart';
import 'package:smart_porta/features/scan_device/data/repositories/scan_device_repository_impl.dart';
import 'package:smart_porta/features/scan_device/domain/repositories/scan_device_repository.dart';
import 'package:smart_porta/features/scan_device/domain/use_cases/scan_device_usecase.dart';
import 'package:smart_porta/features/scan_device/presentation/bloc/scan_device_bloc.dart';
import 'package:smart_porta/features/user_photo/data/data_sources/user_photo_remote_datasource.dart';
import 'package:smart_porta/features/user_photo/data/repositories/user_photo_repository_impl.dart';
import 'package:smart_porta/features/user_photo/domain/repositories/user_photo_repository.dart';
import 'package:smart_porta/features/user_photo/domain/use_cases/user_photo_usecase.dart';
import 'package:smart_porta/features/user_photo/presentation/bloc/user_photo_bloc.dart';

final sl = GetIt.instance;

void init() {
  registerFirebaseAuth();
  registerCloudFirestore();
  registerGoogleSignInClient();
  registerGoogleSignIn();
  registerScanDevice();
  registerUserPhoto();
  registerDeviceState();
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

void registerScanDevice() {
  sl.registerFactory(
    () => ScanDeviceBloc(
      scanDevice: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => ScanDeviceUseCase(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton<ScanDeviceRepository>(
    () => ScanDeviceRepositoryImpl(
      dataSource: sl(),
    ),
  );

  sl.registerLazySingleton<ScanDeviceLocalDataSource>(
    () => ScanDeviceLocalDataSourceImpl(
      firestore: sl.get<FirebaseFirestore>(),
      auth: sl.get<FirebaseAuth>(),
    ),
  );
}

void registerUserPhoto() {
  sl.registerFactory(
    () => UserPhotoBloc(
      getPhoto: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => UserPhotoUseCase(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton<UserPhotoRepository>(
    () => UserPhotoRepositoryImpl(
      dataSource: sl(),
    ),
  );

  sl.registerLazySingleton<UserPhotoRemoteDataSource>(
    () => UserPhotoRemoteDataSourceImpl(
      auth: sl.get<FirebaseAuth>(),
    ),
  );
}

void registerDeviceState() {
  sl.registerFactory(
    () => DeviceStateBloc(
      getState: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => DeviceStateGetStateUseCase(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton<DeviceStateRepository>(
    () => DeviceStateRepositoryImpl(
      dataSource: sl(),
    ),
  );

  sl.registerLazySingleton<DeviceStateRemoteDataSource>(
    () => DeviceStateRemoteDataSourceImpl(
      auth: sl.get<FirebaseAuth>(),
      firestore: sl.get<FirebaseFirestore>(),
    ),
  );
}
