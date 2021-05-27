import 'package:equatable/equatable.dart';
import 'package:smart_porta/features/user_photo/domain/entities/user_photo.dart';

class UserPhotoModel extends Equatable implements UserPhoto {
  final String url;

  UserPhotoModel({required this.url});

  @override
  List<Object?> get props => [url];

  factory UserPhotoModel.fromUrl(String url) {
    return UserPhotoModel(url: url);
  }
}