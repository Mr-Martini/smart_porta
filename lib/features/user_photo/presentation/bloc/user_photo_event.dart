part of 'user_photo_bloc.dart';

abstract class UserPhotoEvent extends Equatable {
  const UserPhotoEvent();
}

class UserPhotoGetPhoto extends UserPhotoEvent {
  @override
  List<Object?> get props => [];
}
