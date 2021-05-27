import 'package:multiple_result/multiple_result.dart';
import 'package:smart_porta/features/core/exceptions/exceptions.dart';
import 'package:smart_porta/features/core/failures/failure.dart';
import 'package:smart_porta/features/user_photo/data/data_sources/user_photo_remote_datasource.dart';
import 'package:smart_porta/features/user_photo/domain/entities/user_photo.dart';
import 'package:smart_porta/features/user_photo/domain/repositories/user_photo_repository.dart';

class UserPhotoRepositoryImpl implements UserPhotoRepository {
  final UserPhotoRemoteDataSource dataSource;

  UserPhotoRepositoryImpl({required this.dataSource});

  @override
  Result<Failure, UserPhoto> getPhoto() {
    try {
      final result = dataSource.getPhoto();
      return Success(result);
    } on NoUserException {
      return Error(NoUserFailure());
    } on NoPhotoUrlException {
      return Error(NoPhotoUrlFailure());
    } catch (err) {
      return Error(UnknownFailure());
    }
  }
}
