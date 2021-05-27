import 'package:multiple_result/multiple_result.dart';
import 'package:smart_porta/features/core/failures/failure.dart';
import 'package:smart_porta/features/device_state/domain/entities/device_state.dart';

abstract class DeviceStateRepository {
  Future<Result<Failure, DeviceState>> getState(String id);
}
