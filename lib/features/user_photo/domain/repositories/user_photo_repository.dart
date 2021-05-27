import 'package:multiple_result/multiple_result.dart';
import 'package:smart_porta/features/core/failures/failure.dart';
import 'package:smart_porta/features/user_photo/domain/entities/user_photo.dart';

abstract class UserPhotoRepository {
  Result<Failure, UserPhoto> getPhoto();
}