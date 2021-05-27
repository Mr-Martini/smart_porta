import 'package:equatable/equatable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:smart_porta/features/core/failures/failure.dart';
import 'package:smart_porta/features/core/usecases/async_usecase.dart';
import 'package:smart_porta/features/device_state/domain/entities/device_state.dart';
import 'package:smart_porta/features/device_state/domain/repositories/device_state_repository.dart';

class DeviceStateGetStateUseCase
    extends AsyncUseCase<DeviceState, DeviceStateParams> {
  final DeviceStateRepository repository;

  DeviceStateGetStateUseCase({required this.repository});

  @override
  Future<Result<Failure, DeviceState>> call(DeviceStateParams params) {
    return repository.getState(params.id);
  }
}

class DeviceStateParams extends Equatable {
  final String id;

  DeviceStateParams({required this.id});

  @override
  List<Object?> get props => [id];
}
