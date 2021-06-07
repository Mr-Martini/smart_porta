import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
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
    if (kIsWeb) {
      const String url =
          "https://firebasestorage.googleapis.com/v0/b/projeto-integrador-93d50.appspot.com/o/56713.jpg?alt=media&token=e9cad1c9-083c-4ad4-a3df-94d1c49b6bf0";
      return UserPhotoModel.fromUrl(url);
    }

    final User? user = auth.currentUser;

    if (user == null) throw NoUserException();

    final String? url = user.photoURL;

    if (url == null) throw NoPhotoUrlException();

    return UserPhotoModel.fromUrl(url);
  }
}
