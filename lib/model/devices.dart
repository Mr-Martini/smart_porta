import 'package:meta/meta.dart';

class Device {
  final String name;
  final String type;
  final String id;
  final String hwVersion;
  final String manufacturer;
  final String model;
  final String swVersion;
  final List<String> traits;
  final bool isLocked;

  Device({
    required this.name,
    required this.type,
    required this.id,
    required this.hwVersion,
    required this.manufacturer,
    required this.model,
    required this.swVersion,
    required this.traits,
    required this.isLocked
  });

  factory Device.fromSnapshot(Map<String, dynamic> snapshot) {
    return Device(
      name: snapshot['name']['name'] ?? "unknown",
      type: snapshot['type'] ?? "unknown",
      id: snapshot['id'] ?? "unknown",
      hwVersion: snapshot['deviceInfo']['hwVersion'] ?? "unknown",
      manufacturer: snapshot['deviceInfo']['manufacturer'] ?? "unknown",
      model: snapshot['deviceInfo']['model'] ?? "unknown",
      swVersion: snapshot['deviceInfo']['swVersion'] ?? "unknown",
      traits: List<String>.from(snapshot['traits'] ?? <String>[]),
      isLocked: snapshot["isLocked"] ?? false
    );
  }
}
