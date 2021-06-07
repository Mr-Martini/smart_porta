part of 'update_device_state_bloc.dart';

abstract class UpdateDeviceStateEvent extends Equatable {
  const UpdateDeviceStateEvent();
}

class UpdateDeviceStateAction extends UpdateDeviceStateEvent {
  final bool state;
  final String id;

  UpdateDeviceStateAction({required this.id, required this.state});

  @override
  List<Object?> get props => [state, id];
}