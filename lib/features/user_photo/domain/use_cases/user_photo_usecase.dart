import 'package:multiple_result/multiple_result.dart';
import 'package:smart_porta/features/core/failures/failure.dart';
import 'package:smart_porta/features/core/params/no_params.dart';
import 'package:smart_porta/features/core/usecases/usecase.dart';
import 'package:smart_porta/features/user_photo/domain/entities/user_photo.dart';
import 'package:smart_porta/features/user_photo/domain/repositories/user_photo_repository.dart';

class UserPhotoUseCase extends UseCase<UserPhoto, NoParams> {

  final UserPhotoRepository repository;

  UserPhotoUseCase({required this.repository});

  @override
  Result<Failure, UserPhoto> call(NoParams params) {
    return repository.getPhoto();
  }

}