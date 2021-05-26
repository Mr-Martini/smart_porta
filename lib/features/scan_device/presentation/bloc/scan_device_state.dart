part of 'scan_device_bloc.dart';

abstract class ScanDeviceState extends Equatable {
  const ScanDeviceState();
}

class ScanDeviceInitial extends ScanDeviceState {
  @override
  List<Object> get props => [];
}

class ScanDeviceLoading extends ScanDeviceState {
  @override
  List<Object?> get props => [];
}

class ScanDeviceLoaded extends ScanDeviceState {
  @override
  List<Object?> get props => [];
}

class ScanDeviceError extends ScanDeviceState {
  final Failure failure;

  ScanDeviceError({required this.failure});

  @override
  List<Object?> get props => [failure];
}
