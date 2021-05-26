part of 'scan_device_bloc.dart';

abstract class ScanDeviceEvent extends Equatable {
  const ScanDeviceEvent();
}

class ScanDeviceAction extends ScanDeviceEvent {
  @override
  List<Object?> get props => [];
}
