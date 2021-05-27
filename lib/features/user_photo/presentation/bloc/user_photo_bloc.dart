import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:smart_porta/features/core/failures/failure.dart';
import 'package:smart_porta/features/core/params/no_params.dart';
import 'package:smart_porta/features/user_photo/domain/entities/user_photo.dart';
import 'package:smart_porta/features/user_photo/domain/use_cases/user_photo_usecase.dart';

part 'user_photo_event.dart';
part 'user_photo_state.dart';

class UserPhotoBloc extends Bloc<UserPhotoEvent, UserPhotoState> {
  final UserPhotoUseCase getPhoto;

  UserPhotoBloc({
    required this.getPhoto,
  }) : super(UserPhotoInitial());

  @override
  Stream<UserPhotoState> mapEventToState(
    UserPhotoEvent event,
  ) async* {
    if (event is UserPhotoGetPhoto) {
      final result = getPhoto(NoParams());
      yield* _eitherLoadedOrError(result);
    }
  }

  Stream<UserPhotoState> _eitherLoadedOrError(
      Result<Failure, UserPhoto> result) async* {
    yield result.when(
      (Failure failure) => UserPhotoError(failure: failure),
      (UserPhoto user) => UserPhotoLoaded(url: user.url),
    );
  }
}
