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
    @required this.name,
    @required this.type,
    @required this.id,
    @required this.hwVersion,
    @required this.manufacturer,
    @required this.model,
    @required this.swVersion,
    @required this.traits,
    this.isLocked
  });

  factory Device.fromSnapshot(Map<String, dynamic> snapshot) {
    return Device(
      name: snapshot['name']['name'],
      type: snapshot['type'],
      id: snapshot['id'],
      hwVersion: snapshot['deviceInfo']['hwVersion'],
      manufacturer: snapshot['deviceInfo']['manufacturer'],
      model: snapshot['deviceInfo']['model'],
      swVersion: snapshot['deviceInfo']['swVersion'],
      traits: List<String>.from(snapshot['traits']),
      isLocked: snapshot["isLocked"]
    );
  }
}
