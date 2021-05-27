part of 'device_state_bloc.dart';

abstract class DeviceStateEvent extends Equatable {
  const DeviceStateEvent();
}

class DeviceStateGetState extends DeviceStateEvent {
  final String id;

  DeviceStateGetState({required this.id});

  @override
  List<Object?> get props => [id];
}
