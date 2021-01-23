import 'package:flutter/material.dart';
import 'package:smart_porta/arguments.dart';
import 'package:smart_porta/model/devices.dart';
import 'package:smart_porta/screens/device_screen.dart';

class DeviceListTile extends StatelessWidget {
  final Device device;
  const DeviceListTile({Key key, @required this.device}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          DeviceScreen.id,
          arguments: Arguments(device: device),
        );
      },
      child: ListTile(
        leading: Icon(Icons.lock),
        title: Text(
          device.name,
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black54,
          ),
        ),
      ),
    );
  }
}
