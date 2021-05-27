import 'package:flutter/material.dart';
import 'package:smart_porta/features/device_state/presentation/pages/device_screen.dart';
import 'package:smart_porta/model/devices.dart';
import 'package:vrouter/vrouter.dart';

class DeviceListTile extends StatelessWidget {
  final Device device;
  const DeviceListTile({
    required Key key,
    required this.device,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.vRouter.push(DeviceScreen.id, queryParameters: device.toJson);
      },
      child: ListTile(
        leading: Icon(Icons.lock),
        title: Text(
          device.name,
        ),
      ),
    );
  }
}
