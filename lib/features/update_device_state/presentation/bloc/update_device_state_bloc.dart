import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:smart_porta/features/core/failures/failure.dart';
import 'package:smart_porta/features/update_device_state/domain/entities/device_state.dart';
import 'package:smart_porta/features/update_device_state/domain/use_cases/update_device_state_usecase.dart';

part 'update_device_state_event.dart';
part 'update_device_state_state.dart';

class UpdateDeviceStateBloc
    extends Bloc<UpdateDeviceStateEvent, UpdateDeviceStateState> {
  final UpdateDeviceStateUseCase updateDevice;

  UpdateDeviceStateBloc({
    required this.updateDevice,
  }) : super(UpdateDeviceStateInitial());

  @override
  Stream<UpdateDeviceStateState> mapEventToState(
    UpdateDeviceStateEvent event,
  ) async* {
    if (event is UpdateDeviceStateAction) {
      yield UpdateDeviceLoading();
      final result = await updateDevice(
        UpdateDeviceParams(
          id: event.id,
          state: event.state,
        ),
      );
      yield* _eitherLoadOrError(result);
    }
  }

  Stream<UpdateDeviceStateState> _eitherLoadOrError(
      Result<Failure, UpdateDeviceState> result) async* {
    yield result.when(
      (Failure failure) => UpdateDeviceError(failure: failure),
      (success) => UpdateDeviceLoaded(),
    );
  }
}
