import 'package:equatable/equatable.dart';
import 'package:smart_porta/features/device_state/domain/entities/device_state.dart';

class DeviceStateModel extends Equatable implements DeviceState {
  final String id;
  final bool isLocked;

  DeviceStateModel({
    required this.id,
    required this.isLocked,
  });

  factory DeviceStateModel.fromMap(Map<String, dynamic> json) {
    return DeviceStateModel(
      id: json["id"],
      isLocked: json["isLocked"],
    );
  }

  @override
  List<Object?> get props => [id, isLocked];
}
