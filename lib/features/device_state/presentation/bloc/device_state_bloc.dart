import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:smart_porta/features/core/failures/failure.dart';
import 'package:smart_porta/features/device_state/domain/entities/device_state.dart';
import 'package:smart_porta/features/device_state/domain/use_cases/device_state_get_state.dart';

part 'device_state_event.dart';
part 'device_state_state.dart';

class DeviceStateBloc extends Bloc<DeviceStateEvent, DeviceStateState> {
  final DeviceStateGetStateUseCase getState;

  DeviceStateBloc({
    required this.getState,
  }) : super(DeviceStateInitial());

  @override
  Stream<DeviceStateState> mapEventToState(
    DeviceStateEvent event,
  ) async* {
    if (event is DeviceStateGetState) {
      yield DeviceStateLoading();
      final result = await getState(
        DeviceStateParams(id: event.id),
      );
      yield* _eitherLoadOrError(result);
    }
  }

  Stream<DeviceStateState> _eitherLoadOrError(
      Result<Failure, DeviceState> result) async* {
    yield result.when(
      (Failure failure) => DeviceStateError(failure: failure),
      (DeviceState state) =>
          DeviceStateLoaded(id: state.id, isLocked: state.isLocked),
    );
  }
}
