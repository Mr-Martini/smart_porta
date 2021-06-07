import 'package:multiple_result/multiple_result.dart';
import 'package:smart_porta/features/core/failures/failure.dart';
import 'package:smart_porta/features/update_device_state/domain/entities/device_state.dart';

abstract class UpdateDeviceStateRepository {
  Future<Result<Failure, UpdateDeviceState>> updateState(bool state, String id);
}