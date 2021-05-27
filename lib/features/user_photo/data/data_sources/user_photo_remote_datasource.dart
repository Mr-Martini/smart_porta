import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_porta/features/core/exceptions/exceptions.dart';
import 'package:smart_porta/features/user_photo/data/models/user_photo_model.dart';

abstract class UserPhotoRemoteDataSource {
  UserPhotoModel getPhoto();
}

class UserPhotoRemoteDataSourceImpl implements UserPhotoRemoteDataSource {

  final FirebaseAuth auth;

  UserPhotoRemoteDataSourceImpl({required this.auth});

  @override
  UserPhotoModel getPhoto() {

    final User? user = auth.currentUser;

    if (user == null) throw NoUserException();

    final String? url = user.photoURL;

    if (url == null) throw NoPhotoUrlException();

    return UserPhotoModel.fromUrl(url);
  }
}