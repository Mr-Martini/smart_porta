import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:smart_porta/dependency_injector.dart';
import 'package:smart_porta/features/core/failures/failure.dart';
import 'package:smart_porta/features/device_state/domain/entities/device_state.dart';
import 'package:smart_porta/features/device_state/domain/use_cases/device_state_get_state.dart';

part 'device_state_event.dart';
part 'device_state_state.dart';

class DeviceStateBloc extends Bloc<DeviceStateEvent, DeviceStateState> {
  final DeviceStateGetStateUseCase getState;
  final firestore = sl.get<FirebaseFirestore>();
  late StreamSubscription _subscription;

  DeviceStateBloc({
    required this.getState,
  }) : super(DeviceStateInitial());

  @override
  Stream<DeviceStateState> mapEventToState(
    DeviceStateEvent event,
  ) async* {
    if (event is DeviceStateInitialEvent) {
      yield DeviceStateLoading();
      _subscription = firestore
          .collection("devices")
          .doc(event.id)
          .snapshots()
          .listen((event) {
            print("called");
        add(DeviceStateGetState(id: event.id));
      });
    } else if (event is DeviceStateGetState) {
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

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
