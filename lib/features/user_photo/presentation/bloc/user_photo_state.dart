part of 'user_photo_bloc.dart';

abstract class UserPhotoState extends Equatable {
  const UserPhotoState();
}

class UserPhotoInitial extends UserPhotoState {
  @override
  List<Object> get props => [];
}

class UserPhotoLoaded extends UserPhotoState {

  final String url;

  UserPhotoLoaded({required this.url});

  @override
  List<Object?> get props => [url];

}

class UserPhotoError extends UserPhotoState {

  final Failure failure;

  UserPhotoError({required this.failure});

  @override
  List<Object?> get props => [failure];

}
