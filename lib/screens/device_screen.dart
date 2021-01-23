import 'package:flutter/material.dart';
import 'package:smart_porta/arguments.dart';
import 'package:smart_porta/model/devices.dart';
import '../widgets//device_state.dart';

class DeviceScreen extends StatefulWidget {
  DeviceScreen({Key key});

  static const String id = "device_screen";

  @override
  _DeviceScreenState createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  @override
  Widget build(BuildContext context) {
    final Arguments args = ModalRoute.of(context).settings.arguments;
    final Device device = args.device;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text(device.name),
      ),
      body: DeviceState(device: device,),
    );
  }
}
