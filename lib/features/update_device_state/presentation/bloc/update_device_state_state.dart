part of 'update_device_state_bloc.dart';

abstract class UpdateDeviceStateState extends Equatable {
  const UpdateDeviceStateState();
}

class UpdateDeviceStateInitial extends UpdateDeviceStateState {
  @override
  List<Object> get props => [];
}

class UpdateDeviceLoaded extends UpdateDeviceStateState {
  @override
  List<Object?> get props => [];
}

class UpdateDeviceLoading extends UpdateDeviceStateState {
  @override
  List<Object?> get props => [];
}

class UpdateDeviceError extends UpdateDeviceStateState {
  final Failure failure;

  UpdateDeviceError({required this.failure});

  @override
  List<Object?> get props => [];
}
