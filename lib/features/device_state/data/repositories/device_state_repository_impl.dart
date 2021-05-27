import 'package:multiple_result/multiple_result.dart';
import 'package:smart_porta/features/core/exceptions/exceptions.dart';
import 'package:smart_porta/features/core/failures/failure.dart';
import 'package:smart_porta/features/device_state/data/data_sources/device_state_remote_datasource.dart';
import 'package:smart_porta/features/device_state/domain/entities/device_state.dart';
import 'package:smart_porta/features/device_state/domain/repositories/device_state_repository.dart';

class DeviceStateRepositoryImpl implements DeviceStateRepository {
  final DeviceStateRemoteDataSource dataSource;

  DeviceStateRepositoryImpl({required this.dataSource});

  @override
  Future<Result<Failure, DeviceState>> getState(String id) async {
    try {
      final result = await dataSource.getState(id);
      return Success(result);
    } on NoUserException {
      return Error(NoUserFailure());
    } on NoDeviceException {
      return Error(NoDeviceFailure());
    } catch (err) {
      return Error(UnknownFailure());
    }
  }
}
