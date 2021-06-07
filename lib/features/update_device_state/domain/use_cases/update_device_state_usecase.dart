import 'package:equatable/equatable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:smart_porta/features/core/failures/failure.dart';
import 'package:smart_porta/features/core/usecases/async_usecase.dart';
import 'package:smart_porta/features/update_device_state/domain/entities/device_state.dart';
import 'package:smart_porta/features/update_device_state/domain/repositories/update_device_state_repository.dart';

class UpdateDeviceStateUseCase
    extends AsyncUseCase<UpdateDeviceState, UpdateDeviceParams> {
  final UpdateDeviceStateRepository repository;

  UpdateDeviceStateUseCase({required this.repository});

  @override
  Future<Result<Failure, UpdateDeviceState>> call(UpdateDeviceParams params) {
    return repository.updateState(params.state, params.id);
  }
}

class UpdateDeviceParams extends Equatable {
  final bool state;
  final String id;

  UpdateDeviceParams({required this.state, required this.id});

  @override
  List<Object?> get props => [state, id];
}
