import 'package:equatable/equatable.dart';

class DeviceState extends Equatable {
  final String id;
  final bool isLocked;

  DeviceState({
    required this.id,
    required this.isLocked,
  });

  @override
  List<Object?> get props => [id, isLocked];
}
