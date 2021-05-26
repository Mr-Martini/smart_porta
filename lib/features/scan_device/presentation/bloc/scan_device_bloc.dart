import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:smart_porta/features/core/failures/failure.dart';
import 'package:smart_porta/features/core/params/no_params.dart';
import 'package:smart_porta/features/scan_device/domain/entities/scan_device.dart';
import 'package:smart_porta/features/scan_device/domain/use_cases/scan_device_usecase.dart';

part 'scan_device_event.dart';
part 'scan_device_state.dart';

class ScanDeviceBloc extends Bloc<ScanDeviceEvent, ScanDeviceState> {
  final ScanDeviceUseCase scanDevice;

  ScanDeviceBloc({
    required this.scanDevice,
  }) : super(ScanDeviceInitial());

  @override
  Stream<ScanDeviceState> mapEventToState(
    ScanDeviceEvent event,
  ) async* {
    if (event is ScanDeviceAction) {
      yield ScanDeviceLoading();
      final result = await scanDevice(NoParams());
      yield* _eitherLoadedOrError(result);
    }
  }

  Stream<ScanDeviceState> _eitherLoadedOrError(
      Result<Failure, ScanDevice> result) async* {
    yield result.when(
      (Failure failure) => ScanDeviceError(failure: failure),
      (success) => ScanDeviceLoaded(),
    );
  }
}
