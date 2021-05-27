part of 'device_state_bloc.dart';

abstract class DeviceStateState extends Equatable {
  const DeviceStateState();
}

class DeviceStateInitial extends DeviceStateState {
  @override
  List<Object> get props => [];
}

class DeviceStateLoading extends DeviceStateState {
  @override
  List<Object> get props => [];
}

class DeviceStateLoaded extends DeviceStateState {

  final String id;
  final bool isLocked;

  DeviceStateLoaded({required this.id, required this.isLocked});

  @override
  List<Object?> get props => [id, isLocked];
}


class DeviceStateError extends DeviceStateState {

  final Failure failure;

  DeviceStateError({required this.failure});

  @override
  List<Object?> get props => [failure];
}
